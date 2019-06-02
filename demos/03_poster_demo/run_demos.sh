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

column_rename(FirstStateId, FirstColumnName, SecondStateId, SecondColumnName) :-
    state(FirstStateId, ArrayId, _),
    state(SecondStateId, ArrayId, _),
    column_schema_at_state(FirstColumnSchemaId, ColumnId, FirstStateId),
    column_schema(FirstColumnSchemaId, _, _, _, FirstColumnName, _, _),
    column_schema_at_state(SecondColumnSchemaId, ColumnId, SecondStateId),
    column_schema(SecondColumnSchemaId, _, _, _, SecondColumnName, _, _),
    SecondStateId > FirstStateId,
    SecondColumnName \== FirstColumnName.

d1() :-
    import_state(_, _, ArrayId, ImportStateId),
    final_array_state(ArrayId, FinalStateId),
    column_rename(ImportStateId, ColumnName, FinalStateId, NewColumnName),
    fmt_write('Column originally named "%S\" was ultimately named "%S".\n', fmt(ColumnName, NewColumnName)),
    fail
    ;
    true.

end_of_file.
d1().
%-------------------------------------------------------------------------------


END_XSB_STDIN

