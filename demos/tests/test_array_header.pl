
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% facts

% array(ArrayId, DatasetId).
array(array_2, nil).

% column(ColId, ArrayId).
column(column_3, array_2).
column(column_4, array_2).
column(column_5, array_2).

% state(StateId, ArrayId, PrevStateId).
state(6, array_2, nil).

% column_schema(ColSchemaId, ColId, StateId, ColType, ColName, PrevColId, PrevColSchemaId).
column_schema(col_schema_9,  column_3, 6, 'string', 'left column at state 6',   nil,      nil).
column_schema(col_schema_10, column_4, 6, 'string', 'middle column at state 6', column_3, nil).
column_schema(col_schema_11, column_5, 6, 'string', 'right column at state 6',  column_4, nil).

state(7, array_2, 6).
column_schema(col_schema_12, column_5, 7, 'string', 'middle column at state 7', column_3, col_schema_11).
column_schema(col_schema_13, column_4, 7, 'string', 'right column at state 7',  column_5, col_schema_10).

state(8, array_2, 7).

state(9, array_2, 8).
column_schema(col_schema_14, column_5, 9, 'string', 'left column at state 9',   nil,      col_schema_12).
column_schema(col_schema_15, column_3, 9, 'string', 'middle column at state 9', column_5, col_schema_9).
column_schema(col_schema_16, column_4, 9, 'string', 'right column at state 9',  column_3, col_schema_13).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% test array_header/2

test__array_header__before_first_state() :-
    not array_header(5, _).

test__array_header__first_state() :-
    array_header(6, Header),
    Header == '| left column at state 6 | middle column at state 6 | right column at state 6 |'.

test__array_header__second_state() :-
    array_header(7, Header),
    Header == '| left column at state 6 | middle column at state 7 | right column at state 7 |'.

test__array_header__between_second_and_third_state() :-
    array_header(8, Header),
    Header == '| left column at state 6 | middle column at state 7 | right column at state 7 |'.

test__array_header__at_third_state() :-
    array_header(9, Header),
    Header == '| left column at state 9 | middle column at state 9 | right column at state 9 |'.

test__array_header__after_third_state() :-
    array_header(10, Header),
    Header == '| left column at state 9 | middle column at state 9 | right column at state 9 |'.
