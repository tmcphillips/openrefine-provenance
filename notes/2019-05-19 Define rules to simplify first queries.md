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

