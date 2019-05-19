#!/usr/bin/env bash
#
# ./run_queries.sh &> run_queries.txt

source ../settings.sh

xsb --quietload --noprompt --nofeedback --nobanner << END_XSB_STDIN

['$RULES_DIR/general_rules'].
['$RULES_DIR/prov_rules'].
['cleaning_history'].

%set_prolog_flag(unknown, fail).

%-------------------------------------------------------------------------------
banner( 'Q1',
        'What are the names of file from which data was imported?',
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
    column_schema(_, _, ImportStateId, _, ColumnName, _).
end_of_file.
printall(q2(_)).
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
banner( 'Q3',
        'What new names are assigned to these columns?',
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
