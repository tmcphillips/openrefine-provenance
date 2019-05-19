## 2019-05-18 Explore simple queries of trivial data cleaning workflow

### Background
- Last week composed first Datalog-style queries of the data cleaning workflow developed earlier in the week.
- Automated these queries using combination of Bash scripting and XSB Prolog programming.
- Would like to simplify these queries by defining reusable rules.

### Structure of Bash script that invokes XSB to perform inlined queries
- I found previously that it is convenient to embed queries in a here-document in a Bash script that runs XSB prolog on those queries.
- The first of the trivial data-cleaning provenance queries in [demos/01_column_rename/run_queries.sh](https://github.com/tmcphillips/openrefine-provenance/blob/8d877ed7341a270285fec0faa995bd97fa10bbd5/demos/01_column_rename/run_queries.sh) is shown here embedded within the bash script that invokes it:

    ```prolog
    #!/usr/bin/env bash
    #
    # ./run_queries.sh &> run_queries.txt
    
    source ../settings.sh
    
    xsb --quietload --noprompt --nofeedback --nobanner << END_XSB_STDIN
    
    ['$RULES_DIR/general_rules'].
    ['cleaning_history'].
    
    %set_prolog_flag(unknown, fail).
    
    %-------------------------------------------------------------------------------
    banner( 'Q1',
            'What is the name of the file from which data was imported?',
            'q1(SourceUri)').
    [user].
    :- table q1/1.
    q1(SourceUri) :-
        source(_, SourceUri, _).
    end_of_file.
    printall(q1(_)).
    %-------------------------------------------------------------------------------
   
    END_XSB_STDIN
    ```
- The text between the pair of ```END_XSB_STDIN``` delimiters is passed as (standard) input to XSB.
- Within the text sent to XSB, the portion bracketed by ```[user].``` and ```end_of_file.``` is interpreted by XSB as Prolog facts and rules, and is equivalent to such information loaded from an external file.
- The remaining text sent to XSB is equivalent to interactive input given by a user to XSB.
- Thus the script combines interactive and non-interactive input to XSB in a single script.
- The facts describing the data cleaning run is read from `cleaning_history.P` (see next section).
- Running the above script from the command line with `xsb` in the PATH:

    ```console
    $ ./run_queries.sh
    ---------------------------------------------------------------------------------------------------
    Q1 : What is the name of the file from which data was imported?
    
    q1(SourceUri)
    ...................................................................................................
    q1('biblio.csv').
    ```

### Facts describing the data cleaning workflow
- The facts manually composed and listed in the notes for 2019-05-15 were saved in the cleaning_history.P file, with the exception of the ```import``` fact due a conflict with a reserved XSB keyword:

    ```prolog
    %%%% STATE AFTER INITIAL IMPORT STEP %%%%%
    
    % source(source_id, source_uri, source_format).
    source(7, 'biblio.csv', 'text/csv').
    
    % dataset(dataset_id, source_id, import_id, array_id).
    dataset(3, 7, 9).
    
    % array(array_id, dataset_id).
    array(9, 3).
    
    % column(column_id, array_id).
    column(1, 9).
    column(2, 9).
    column(3, 9).
    
    % row(row_id, array_id).
    row(6, 9).
    row(7, 9).
    row(8, 9).
    
    % cell(cell_id, column_id, row_id).
    cell(1, 1, 6).
    cell(2, 1, 7).
    cell(3, 1, 8).
    cell(4, 2, 6).
    cell(5, 2, 7).
    cell(6, 2, 8).
    cell(7, 3, 6).
    cell(8, 3, 7).
    cell(9, 3, 8).
    
    % state(state_id, array_id, previous_state_id).
    state(17, 9, nil).
    
    % content(content_id, cell_id, state_id, value_id).
    content(11, 1, 17, 21).
    content(12, 2, 17, 22).
    content(13, 3, 17, 23).
    content(14, 4, 17, 24).
    content(15, 5, 17, 25).
    content(16, 6, 17, 26).
    content(17, 7, 17, 27).
    content(18, 8, 17, 28).
    content(19, 9, 17, 29).
    
    % value(value_id, value_text).
    value(21, 'Against Method').
    value(22, 'Changing Order').
    value(23, 'Exceeding our Grasp').
    value(24, 'Paul Feyerabend').
    value(25, 'H.M. Collins').
    value(26, 'P. Kyle Stanford').
    value(27, '1975').
    value(28, '1985').
    value(29, '2006').
    
    % column_schema(column_schema_id, column_id, state_id, column_type, column_name, previous_column_id).
    column_schema(4, 1, 17, 'string', 'Book Title', nil).
    column_schema(5, 2, 17, 'string', 'Author', 1).
    column_schema(6, 3, 17, 'string', 'Date', 2).
    
    % row_position(row_positition_id, row_id, state_id, previous_row_id).
    row_position(31, 6, 17, nil).
    row_position(32, 7, 17, 6).
    row_position(33, 8, 17, 7).
    
    % state(state_id, array_id, previous_state_id).
    state(18, 9, 17).
     
    %%%% STATE AFTER COLUMN RENAME STEP %%%%%
    
    % column_schema(column_schema_id, column_id, state_id, column_type, column_name, previous_column_id).
    column_schema(4, 1, 18, 'string', 'Title', nil).
    ```


### Four basic queries defined inline
- To examine whether the column rename even can be detected at all in these facts, queries were written to answer the following questions:
	1. What is the name of the file from which data was imported?
	2. What are the original names of each column?
	3. What new names are assigned to columns?
	4. How many steps are there in the data cleaning workflow including data import?
- Saved in run_queries.sh, the script with queries is as follows:

    ```prolog
    #!/usr/bin/env bash
    #
    # ./run_queries.sh &> run_queries.txt
    
    source ../settings.sh
    
    xsb --quietload --noprompt --nofeedback --nobanner << END_XSB_STDIN
    
    ['$RULES_DIR/general_rules'].
    ['cleaning_history'].
    
    %set_prolog_flag(unknown, fail).
    
    %-------------------------------------------------------------------------------
    banner( 'Q1',
            'What is the name of the file from which data was imported?',
            'q1(SourceUri)').
    [user].
    :- table q1/1.
    q1(SourceUri) :-
        source(_, SourceUri, _).
    end_of_file.
    printall(q1(_)).
    %-------------------------------------------------------------------------------
    
    %-------------------------------------------------------------------------------
    banner( 'Q2',
            'What are the original names of each column?',
            'q2(ColumnName)').
    [user].
    :- table q2/1.
    q2(ColumnName) :-
        dataset(DatasetId, _, ArrayId),
        array(ArrayId, DatasetId),
        state(FirstStateId, ArrayId, nil),
        column_schema(_, _, FirstStateId, _, ColumnName, _).
    end_of_file.
    printall(q2(_)).
    %-------------------------------------------------------------------------------
    
    %-------------------------------------------------------------------------------
    banner( 'Q3',
            'What new names are assigned to columns?',
            'q3(OldColumnName, NewColumnName)').
    [user].
    :- table q3/2.
    q3(OldColumnName, NewColumnName) :-
        dataset(DatasetId, _, ArrayId),
        array(ArrayId, DatasetId),
        state(StateId, ArrayId, PreviousStateId),
        column_schema(_, ColumnId, StateId, _, NewColumnName, _),
        column_schema(_, ColumnId, PreviousStateId, _, OldColumnName, _),
        OldColumnName \== NewColumnName.
    end_of_file.
    printall(q3(_,_)).
    %-------------------------------------------------------------------------------
    
    %-------------------------------------------------------------------------------
    banner( 'Q4',
            'How many steps are there in the data cleaning workflow including data import?',
            'q4(StateCount)').
    [user].
    :- table q4/1.
    q4(StateCount) :-
        dataset(DatasetId, _, ArrayId),
        array(ArrayId, DatasetId),
        count(state(_, ArrayId, _), StateCount).
    end_of_file.
    printall(q4(_)).
    %-------------------------------------------------------------------------------
    
    END_XSB_STDIN
    ```
- And running the script gives correct output:

    ```
    ---------------------------------------------------------------------------------------------------
    Q1 : What is the name of the file from which data was imported?
    
    q1(SourceUri)
    ...................................................................................................
    q1('biblio.csv').
    
    
    ---------------------------------------------------------------------------------------------------
    Q2 : What are the original names of each column?
    
    q2(ColumnName)
    ...................................................................................................
    q2('Date').
    q2('Author').
    q2('Book Title').
    
    
    ---------------------------------------------------------------------------------------------------
    Q3 : What new names are assigned to columns?
    
    q3(OldColumnName, NewColumnName)
    ...................................................................................................
    q3('Book Title','Title').
    
    
    ---------------------------------------------------------------------------------------------------
    Q4 : How many steps are there in the data cleaning workflow including data import?
    
    q4(StateCount)
    ...................................................................................................
    q4(2).
    ```

