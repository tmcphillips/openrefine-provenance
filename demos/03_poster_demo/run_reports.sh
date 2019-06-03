#!/usr/bin/env bash
#
# ./run_reports.sh &> reports.txt

source ../settings.sh

xsb --quietload --noprompt --nofeedback --nobanner << END_XSB_STDIN

['$RULES_DIR/general_rules'].
['$RULES_DIR/query_rules'].
['$RULES_DIR/report_rules'].
['dataset_1'].

%set_prolog_flag(unknown, fail).

%-------------------------------------------------------------------------------
banner( 'Report 1',
        'Print the names of the columns in order at the initially imported state',
        'r1()').
[user].
r1() :-

    import_state(_, dataset_1, _, ImportStateId),
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

    import_state(_, dataset_1, ArrayId, _),
    final_array_state(ArrayId, FinalStateId),
    array_header(FinalStateId, Header),
    writeln(Header).

end_of_file.
r2().
%-------------------------------------------------------------------------------


END_XSB_STDIN

