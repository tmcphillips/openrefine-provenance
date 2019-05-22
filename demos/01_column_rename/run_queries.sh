#!/usr/bin/env bash
#
# ./run_queries.sh &> run_queries.txt

source ../settings.sh

xsb --quietload --noprompt --nofeedback --nobanner << END_XSB_STDIN

['$RULES_DIR/general_rules'].
['$RULES_DIR/prov_rules'].
['$RULES_DIR/array_views'].
['cleaning_history'].

%set_prolog_flag(unknown, fail).

%-------------------------------------------------------------------------------
banner( 'Q1',
        'What are the names of files from which data was imported?',
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
        'What are the original names of each column in this data set?',
        'q2(ColumnName)').
[user].

:- table q2/1.
q2(ColumnName) :-

    import_state('biblio.csv', _, _, ImportStateId),
    column_name(_, ImportStateId, ColumnName).

end_of_file.

printall(q2(_)).
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
banner( 'Q3',
        'What new names are assigned to these columns?',
        'q3(ColumnName, NewColumnName)').
[user].

:- table q3/2.
q3(ColumnName, NewColumnName) :-

    import_state('biblio.csv', DatasetId, _, _),
    column_rename(DatasetId, _, _, ColumnName, NewColumnName).

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

    import_state('biblio.csv', DatasetId, _, _),
    array(ArrayId, DatasetId),
    count(state(_, ArrayId, _), StateCount).

end_of_file.

printall(q4(_)).
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
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
%-------------------------------------------------------------------------------

END_XSB_STDIN

