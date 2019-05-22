## 2019-05-20 Define rules to reconstruct column names at any state

### Background
- A key objective is to be able to reconstruct the state of a data set at any past state during cleaning without storing full snapshots of the data set at each state.
- A place to start is to support queries of the names of particular columns at any point in the cleaning workflow.

### Rules for recovering column name as of a particular state
- The names of columns are stored in `column_schema/7` structures.
- Each `column_schema` identifies the `state` at which it was assigned. A `column_schema` instance only is defined at states where the schema of that particular column was changed.
- Changes of column names are only one kind of column schema changes.
-  We need a rule that can take a column ID and state ID, and return the column name given by the latest column_schema as of the provided state.
- The following two rules accomplish this goal, with `column_name_state/3` providing access to a column's name as of the given state:

	```prolog
    % RULE : next_column_schema_at_or_before_state/2
    %
    % Succeeds if a column schema follows the one identified by ColumnSchemaId,
    % and the later column schema was created at StateId or earlier.
    %
    next_column_schema_at_or_before_state(ColumnSchemaId, StateId) :-
        column_schema(_, _, NextColumnSchemaStateId, _, _, _, ColumnSchemaId),
        NextColumnSchemaStateId =< StateId.
    
   
    % RULE : column_name_at_state/3
    %
    % Returns ColumnName for ColumnId at the latest state at or before StateId.
    %
    column_name_at_state(ColumnId, StateId, ColumnName) :-
        column_schema(ColumnSchemaId, ColumnId, CoumnSchemaStateId, _, ColumnName, _, _),
        StateId >= CoumnSchemaStateId,
        not next_column_schema_at_or_before_state(ColumnSchemaId, StateId).
	```
- Note that no traversal of the column schema linked list is necessary in the above rules.

### New query `q5` uses the above rules to list the final names of the columns

- The new rule `final_array_state/2` provides the ID of the final state for a dataset array:

    ```prolog
    final_array_state(ArrayId, FinalStateId) :-
        state(FinalStateId, ArrayId, _),
        not state(_, ArrayId, FinalStateId).
    ```
- Query `q5` can now be added to `run_queries.sh`:

    ```prolog
    banner( 'Q5',
            'What are the final names of each column in this data set?',
            'q5(ColumnName)').
    [user].
    
    :- table q5/1.
    q5(ColumnName) :-
    
        import_state('biblio.csv', _, ImportArrayId, _),
        final_array_state(ImportArrayId, FinalArrayStateId),
        column_name_at_state(_, FinalArrayStateId, ColumnName).
    
    end_of_file.
    
    printall(q5(_)).
    ```
- Running `q5` gives correct results:

    ```prolog
    q5('Main Title').
    q5('Publication').
    q5('Author').
    ```

