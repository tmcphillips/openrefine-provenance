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

column_name_at_state(Column, State, Name) :-
    column_schema_at_state(Schema, Column, State),
    column_schema(Schema, _, _, _, Name, _, _).

column_rename(State1, Name1, State2, Name2) :-
    column_name_at_state(ColumnId, State1, Name1),
    column_name_at_state(ColumnId, State2, Name2),
    State2 > State1,
    Name2 \== Name1.

d1() :-
    import_state(_, _, Array, ImportState),
    final_array_state(Array, FinalState),
    column_rename(ImportState, OriginalName, FinalState, FinalName),
    fmt_write('Column originally named "%S\" was ultimately named "%S".\n', fmt(OriginalName, FinalName)),
    fail
    ;
    true.

end_of_file.
d1().
%-------------------------------------------------------------------------------


END_XSB_STDIN

