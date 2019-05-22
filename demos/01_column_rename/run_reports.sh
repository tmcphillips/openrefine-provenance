#!/usr/bin/env bash
#
# ./run_reports.sh &> run_reports.txt

source ../settings.sh

xsb --quietload --noprompt --nofeedback --nobanner << END_XSB_STDIN

['$RULES_DIR/general_rules'].
['$RULES_DIR/prov_rules'].
['$RULES_DIR/array_views'].
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
    print_array_header(ImportStateId).

end_of_file.
r1().
%-------------------------------------------------------------------------------

END_XSB_STDIN

