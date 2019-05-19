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
- The above query is confusing mostly because the inference of state transition is implicit.  The new rule `state_transition` makes the sequence of states explicit, and provides a more intuitive, forward-looking view of the state relationships (`stateId` and `nextStateId` replace the `PreviousStateId` in the underlying `state/3` fact):
-
    ```prolog
    state_transition(DatasetId, ArrayId, StateId, NextStateId) :-
        array(ArrayId, DatasetId),
        state(NextStateId, ArrayId, StateId).
    ```
- A new `column_name` view of the `column_schema` fact further clarifies the intent of queries using it:

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



