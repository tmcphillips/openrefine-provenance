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

END_XSB_STDIN
