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
    column_name_at_state(Column, State1, Name1),
    column_name_at_state(Column, State2, Name2),
    State2 > State1,
    Name2 \== Name1.

d1() :-
    import_state(_, _, Array, ImportState),
    final_array_state(Array, FinalState),
    column_rename(ImportState, OriginalName, FinalState, FinalName),
    fmt_write('The column originally named "%S\" was ultimately named "%S".\n', fmt(OriginalName, FinalName)),
    fail
    ;
    true.

end_of_file.
d1().
%-------------------------------------------------------------------------------


%-------------------------------------------------------------------------------
demo_banner( 'Demo 2', 'What columns in the final dataset contain cells with updated values?').
[user].

:- table column_with_updated_cell_value/1.
column_with_updated_cell_value(Column) :-
    content(_, Cell, _, _, PrevContentId),
    PrevContentId \== nil,
    cell(Cell, Column, _).

d2() :-
    column_with_updated_cell_value(Column),
    final_array_state(_, FinalState),
    column_name(Column, FinalState, ColumnName),
    fmt_write('The column named "%S\" in the final data set contains cells with updated values.\n', fmt(ColumnName)),
    fail
    ;
    true.

end_of_file.
d2().
%-------------------------------------------------------------------------------



END_XSB_STDIN

