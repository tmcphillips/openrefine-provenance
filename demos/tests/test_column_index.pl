
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
% test column_index/3

test__column_index__first_column_at_first_state() :-
    column_index(column_3, 6, 1).

test__column_index__second_column_at_first_state() :-
    column_index(column_4, 6, 2).

test__column_index__third_column_at_first_state() :-
    column_index(column_5, 6, 3).


test__column_index__first_column_at_second_state() :-
    column_index(column_3, 7, 1).

test__column_index__second_column_at_second_state() :-
    column_index(column_5, 7, 2).

test__column_index__third_column_at_second_state() :-
    column_index(column_4, 7, 3).


test__column_index__first_column_between_second_and_third_state() :-
    column_index(column_3, 8, 1).

test__column_index__second_column_beteween_second_and_third_state() :-
    column_index(column_5, 7, 2).

test__column_index__third_column_beteween_second_and_third_state() :-
    column_index(column_4, 7, 3).


test__column_index__first_column_at_third_state() :-
    column_index(column_5, 9, 1).

test__column_index__second_column_at_third_state() :-
    column_index(column_3, 9, 2).

test__column_index__third_column_at_third_state() :-
    column_index(column_4, 9, 3).

