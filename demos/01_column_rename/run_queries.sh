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
        'What is the name of the file from data was imported?',
        'q1(SourceUri)').
[user].
:- table q1/1.
q1(SourceUri) :-
    source(_, SourceUri, _).
end_of_file.
printall(q1(_)).
%-------------------------------------------------------------------------------

END_XSB_STDIN
