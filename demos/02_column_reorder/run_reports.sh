#!/usr/bin/env bash
#
# ./run_reports.sh &> run_reports.txt

source ../settings.sh

xsb --quietload --noprompt --nofeedback --nobanner << END_XSB_STDIN

['$RULES_DIR/general_rules'].
['$RULES_DIR/query_rules'].
['$RULES_DIR/report_rules'].
['cleaning_history'].

%set_prolog_flag(unknown, fail).

%-------------------------------------------------------------------------------
banner( 'Report 1',
        'Print the names of the columns in order at the initially imported state',
        'r1()').
[user].
r1() :-

    import_state('biblio.csv', _, _, ImportStateId),
    array_header(ImportStateId, Header),
    writeln(Header).

end_of_file.
r1().
%-------------------------------------------------------------------------------

%-------------------------------------------------------------------------------
banner( 'Report 2',
        'Print the names of the columns in order at the final state',
        'r2()').
[user].
r2() :-

    import_state('biblio.csv', _, ArrayId, _),
    final_array_state(ArrayId, FinalStateId),
    array_header(FinalStateId, Header),
    writeln(Header).

end_of_file.
r2().
%-------------------------------------------------------------------------------


%-------------------------------------------------------------------------------

banner( 'Report 3',
        'Print the names of the columns in order at any intermediate states',
        'r3()').
[user].

r3() :-

    import_state('biblio.csv', _, ArrayId, ImportStateId),
    final_array_state(ArrayId, FinalStateId),
    state(StateId, ArrayId, _),
    StateId \== ImportStateId,
    StateId \== FinalStateId,
    array_header(StateId, Header),
    fmt_write("At state %S: %S \n", arg(StateId, Header)),
    fail
    ;
    true.

end_of_file.
r3().
%-------------------------------------------------------------------------------


END_XSB_STDIN

