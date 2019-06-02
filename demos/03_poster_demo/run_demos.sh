#!/usr/bin/env bash
#
# ./run_demos.sh &> demos.txt

source ../settings.sh

xsb --quietload --noprompt --nofeedback --nobanner << END_XSB_STDIN

['$RULES_DIR/general_rules'].
['$RULES_DIR/query_rules'].
['$RULES_DIR/report_rules'].
['cleaning_history'].

%set_prolog_flag(unknown, fail).

%-------------------------------------------------------------------------------
demo_banner( 'Demo 1', 'What columns in the original dataset were renamed?').
[user].
d1() :-

    column_rename(_, _, StateId, ColumnName, NewColumnName),
    fmt_write('In step %S column "%S\" was renamed to "%S".\n', fmt(StateId, ColumnName, NewColumnName)).

end_of_file.
d1().
%-------------------------------------------------------------------------------


END_XSB_STDIN

