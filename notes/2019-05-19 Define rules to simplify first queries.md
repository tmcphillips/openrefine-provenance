## 2019-05-19 Define rules to simplify first queries

### Background
- The four queries of the two-step data cleaning workflow (import followed by a single column rename) from last week are defined entirely inline.
- These can be simplified, made clearer, and the logic shared with future queries by factoring out rules.

### Added import_state rule to simplify q2
- The query `q2` displays the names of the columns in the data set at the time of data import:

    ```prolog
    q2(ColumnName) :-
        dataset(DatasetId, _, ArrayId),
        array(ArrayId, DatasetId),
        state(FirstStateId, ArrayId, nil),
        column_schema(_, _, FirstStateId, _, ColumnName, _).
    ```
- Defined a rule `import_state/3` in a new file `demos/rules/prov_rules.P`:
    ```prolog
    import_state(SourceUri, DatasetId, ImportArrayId, ImportStateId) :-
        source(SourceId, SourceUri, _),
        dataset(DatasetId, SourceId, ImportArrayId),
        state(ImportStateId, ImportArrayId, nil).
    ```
- This rule provides easy access to the array into which data was originally represented following data import, and the first state of this array.
- It also allows a data set to be accessed by original filename, or dataset ID.
- The file import lines in `run_queries.sh` now includes `prov_rules.P` to make the new rule available:
	```prolog
	. . .
	['$RULES_DIR/general_rules'].
	['$RULES_DIR/prov_rules'].
	['cleaning_history'].
	. . .
	```
- And now `q2` can be rewritten simply as the following, with the additional feature that the query specifies the name of the imported data file:

    ```prolog
    q2(ColumnName) :-
        import_state('biblio.csv', _, _, ImportStateId),
        column_schema(_, _, ImportStateId, _, ColumnName, _).
    ```

### Added column_name and state_transition rules to clarify q3
- The query `q3` displays changes in column names during data cleaning:

    ```prolog
    q3(OldColumnName, NewColumnName) :-
        dataset(DatasetId, _, ArrayId),
        array(ArrayId, DatasetId),
        state(StateId, ArrayId, PreviousStateId),
        column_schema(_, ColumnId, StateId, _, NewColumnName, _),
        column_schema(_, ColumnId, PreviousStateId, _, OldColumnName, _),
        OldColumnName \== NewColumnName.
    ```
- The above query is confusing mostly because the inference of state transition is implicit.  The new rule `state_transition/4` makes the sequence of states explicit, and provides a more intuitive, forward-looking view of the state relationships (`NextStateId` in `state_transition/4` replaces the `PreviousStateId` in the underlying `state/3` fact):
-
    ```prolog
    state_transition(DatasetId, ArrayId, StateId, NextStateId) :-
        array(ArrayId, DatasetId),
        state(NextStateId, ArrayId, StateId).
    ```
- A new `column_name` view of the `column_schema` fact further clarifies the intent of queries that use it:

    ```prolog
    column_name(ColumnId, StateId, ColumnName) :-
        column_schema(_, ColumnId, StateId, _, ColumnName, _).
    ```

- Using the new rules the updated `q3` is now:
 
    ```prolog
    q3(ColumnName, NewColumnName) :-
        import_state('biblio.csv', DatasetId, _, _),
        state_transition(DatasetId, _, StateId, NextStateId),
        column_name(ColumnId, StateId, ColumnName),
        column_name(ColumnId, NextStateId, NewColumnName),
        NewColumnName \== ColumnName.
    ```
### Generalized `q4` to handle multiple arrays per workflow
- The main limitation of the original implementation of q4 is its assumption that the workflow is represented only by the single array into which data is originally imported:

    ```prolog
    q4(StateCount) :-
        dataset(DatasetId, _, ArrayId),
        array(ArrayId, DatasetId),
        count(state(_, ArrayId, _), StateCount).
    ```

- Using the new `import_state/4` rule the updated `q4` counts states for all arrays associated with the workflow:

    ```prolog
    q4(StateCount) :-
        import_state('biblio.csv', DatasetId, _, _),
        array(ArrayId, DatasetId),
        count(state(_, ArrayId, _), StateCount).
    ```

 ### Confirmed that the updated queries give the same results as the original ones:
- Updated the run_queries.txt file with the new query results:

    ```console
        $ ./run_queries.sh > run_queries.txt
    ```
- Confirmed that all differences in this file observed by git are in the descriptions of the queries:

    ```diff
    $ git diff run_queries.txt
    diff --git a/demos/01_column_rename/run_queries.txt b/demos/01_column_rename/run_queries.txt
    index 441542d..480d8bc 100644
    --- a/demos/01_column_rename/run_queries.txt
    +++ b/demos/01_column_rename/run_queries.txt
    @@ -1,7 +1,7 @@
    
    
     ---------------------------------------------------------------------------------------------------
    -Q1 : What is the name of the file from which data was imported?
    +Q1 : What are the names of file from which data was imported?
    
     q1(SourceUri)
     ...................................................................................................
    @@ -9,7 +9,7 @@ q1('biblio.csv').
    
    
     ---------------------------------------------------------------------------------------------------
    -Q2 : What are the original names of each column?
    +Q2 : What are the original names of each column in this data set?
    
     q2(ColumnName)
     ...................................................................................................
    @@ -19,9 +19,9 @@ q2('Book Title').
    
    
     ---------------------------------------------------------------------------------------------------
    -Q3 : What new names are assigned to columns?
    +Q3 : What new names are assigned to these columns?
    
    -q3(OldColumnName, NewColumnName)
    +q3(ColumnName, NewColumnName)
     ...................................................................................................
     q3('Book Title','Title').
     ```

### Found that `q3` can give incorrect results for multiple column renames
- The query `q3` as written now gives correct results if column 1 is renamed twice in a row, and these are the only data cleaning steps:

    ```prolog
    % cleaning_history.P
    ...
    %%%% STATE AFTER FIRST RENAME OF FIRST COLUMN %%%%%
    
    % state(state_id, array_id, previous_state_id).
    state(18, 9, 17).
    
    % column_schema(column_schema_id, column_id, state_id, column_type, column_name, previous_column_id).
    column_schema(4, 1, 18, 'string', 'Title', nil).
    
    %%%% STATE AFTER SECOND RENAME STEP OF FIRST COLUMN %%%%%
    
    % state(state_id, array_id, previous_state_id).
    state(19, 9, 18).
    
    % column_schema(column_schema_id, column_id, state_id, column_type, column_name, previous_column_id).
    column_schema(5, 1, 19, 'string', 'Main Title', nil).
    ```

    ```console
    $ ./run_queries.sh
    . . .
    ---------------------------------------------------------------------------------------------------
    Q3 : What new names are assigned to these columns?
    
    q3(ColumnName, NewColumnName)
    ...................................................................................................
    q3('Book Title','Title').
    q3('Title','Main Title').
    . . .
    ```
- However, if a rename of column 3 is interleaved between the two renames of column 1, only the first rename is reported:

    ```prolog
    % cleaning_history.P
    ...
    %%%% STATE AFTER FIRST RENAME OF FIRST COLUMN %%%%%
    
    % state(state_id, array_id, previous_state_id).
    state(18, 9, 17).
    
    % column_schema(column_schema_id, column_id, state_id, column_type, column_name, previous_column_id).
    column_schema(4, 1, 18, 'string', 'Title', nil).
    
    %%%% STATE AFTER FIRST RENAME OF THIRD COLUMN %%%%%
    
    % state(state_id, array_id, previous_state_id).
    state(19, 9, 18).
    
    % column_schema(column_schema_id, column_id, state_id, column_type, column_name, previous_column_id).
    column_schema(5, 3, 19, 'string', 'Publication', nil).
    
    %%%% STATE AFTER SECOND RENAME STEP OF FIRST COLUMN %%%%%
    
    % state(state_id, array_id, previous_state_id).
    state(20, 9, 19).
    
    % column_schema(column_schema_id, column_id, state_id, column_type, column_name, previous_column_id).
    column_schema(6, 1, 20, 'string', 'Main Title', nil).
    ```
    ```console
    Q3 : What new names are assigned to these columns?
    
    q3(ColumnName, NewColumnName)
    ...................................................................................................
    q3('Book Title','Title').
    ```
- The problem is that `q3` assumes that the name of every column is provided at each state, whereas the actual history--for space efficiency reasons--only includes a column schema at a particular state if it has changed.
-  The query needs to compare the name of columns given at each state with the last name provided to that column, possibly many states earlier in the history.

### Added  to `column_schema` field referencing previous schema for the column
- The problem with `column_schema` can be easily fixed by adding a reference to the previous column schema.
- The updated column_schema facts for the workflow with three column rename operations becomes:
    ```prolog
    %%%% STATE AFTER INITIAL IMPORT STEP %%%%%
    
    % column_schema(ColumnSchemaId, ColumnId, StateId, ColumnType, 
    %               ColumnName, PreviousColumnId, PreviousColumnSchemaId).
    column_schema(4, 1, 17, 'string', 'Book Title', nil, nil).
    column_schema(5, 2, 17, 'string', 'Author', 1, nil).
    column_schema(6, 3, 17, 'string', 'Date', 2, nil).
    
    %%%% STATE AFTER THREE COLUMN RENAME OPERATIONS %%%%%
    
    column_schema(7, 1, 18, 'string', 'Title', nil, 4).
    column_schema(8, 3, 19, 'string', 'Publication', 2, 6).
    column_schema(9, 1, 20, 'string', 'Main Title', nil, 7).
    ```
- And `q3` becomes:
    ```prolog
    q3(ColumnName, NewColumnName) :-
        import_state('biblio.csv', DatasetId, _, _),
        column_schema(_, _, _, _, NewColumnName, _, PreviousColumnSchemaId),
        column_schema(PreviousColumnSchemaId, _, _, _, ColumnName, _, _),
        NewColumnName \== ColumnName.
    end_of_file.
    ```
- Running the query now gives the correct output:

    ```
    Q3 : What new names are assigned to these columns?
    
    q3(ColumnName, NewColumnName)
    ...................................................................................................
    q3('Title','Main Title').
    q3('Date','Publication').
    q3('Book Title','Title').
    ```
### Simplified `q3` with new `column_rename` rule
- Moved logic of `q3` to a new rule `column_rename/5`, adding the option to filter by dataset or array in a dataset:
    ```prolog
    :- table column_rename/5.
    column_rename(DatasetId, ArrayId, StateId, ColumnName, NewColumnName) :-
        array(ArrayId, DatasetId),
        state(StateId, ArrayId, _),
        column_schema(_, _, _, _, NewColumnName, _, PreviousColumnSchemaId),
        column_schema(PreviousColumnSchemaId, _, StateId, _, ColumnName, _, _),
        NewColumnName \== ColumnName.
    ```
- The updated `q3` is now:

    ```prolog
    q3(ColumnName, NewColumnName) :-
        import_state('biblio.csv', DatasetId, _, _),
        column_rename(DatasetId, _, _, ColumnName, NewColumnName).
    ```
- And all of the queries give correct results:

    ```console
    $ ./run_queries.sh
    
    ---------------------------------------------------------------------------------------------------
    Q1 : What are the names of files from which data was imported?
    
    q1(SourceUri)
    ...................................................................................................
    q1('biblio.csv').
    
    
    ---------------------------------------------------------------------------------------------------
    Q2 : What are the original names of each column in this data set?
    
    q2(ColumnName)
    ...................................................................................................
    q2('Book Title').
    q2('Author').
    q2('Date').
    
    
    ---------------------------------------------------------------------------------------------------
    Q3 : What new names are assigned to these columns?
    
    q3(ColumnName, NewColumnName)
    ...................................................................................................
    q3('Book Title','Title').
    q3('Date','Publication').
    q3('Title','Main Title').
    
    
    ---------------------------------------------------------------------------------------------------
    Q4 : How many steps are there in the data cleaning workflow including data import?
    
    q4(StateCount)
    ...................................................................................................
    q4(4).
    ```

