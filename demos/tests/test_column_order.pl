
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
% test first_column/2

test__first_column__before_first_state() :-
    not first_column(0, _, _).

test__first_column__at_first_state() :-
    first_column(6, ColumnId, ColumnSchemaId),
    ColumnId == column_3,
    ColumnSchemaId == col_schema_9.

test__first_column__at_second_state() :-
    first_column(7, ColumnId, ColumnSchemaId),
    ColumnId == column_3,
    ColumnSchemaId == col_schema_9.

test__first_column__between_second_and_third_state() :-
    first_column(8, ColumnId, ColumnSchemaId),
    ColumnId == column_3,
    ColumnSchemaId == col_schema_9.

test__first_column__at_third_state() :-
    first_column(9, ColumnId, ColumnSchemaId),
    ColumnId == column_5,
    ColumnSchemaId == col_schema_14.

test__first_column__after_final_state() :-
    first_column(10, ColumnId, ColumnSchemaId),
    ColumnId == column_5,
    ColumnSchemaId == col_schema_14.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% test last_column/3

test__last_column__before_first_state() :-
    not last_column(1, _, _).

test__last_column__at_first_state() :-
    last_column(6, ColumnId, ColumnSchemaId),
    ColumnId == column_5,
    ColumnSchemaId == col_schema_11.

test__last_column__at_second_state() :-
    last_column(7, ColumnId, ColumnSchemaId),
    ColumnId == column_4,
    ColumnSchemaId == col_schema_13.

test__last_column__between_second_and_third_state() :-
    last_column(8, ColumnId, ColumnSchemaId),
    ColumnId == column_4,
    ColumnSchemaId == col_schema_13.

test__last_column__at_third_state() :-
    last_column(9, ColumnId, ColumnSchemaId),
    ColumnId == column_4,
    ColumnSchemaId == col_schema_16.

test__last_column__after_final_state() :-
    last_column(10, ColumnId, ColumnSchemaId),
    ColumnId == column_4,
    ColumnSchemaId == col_schema_16.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% test schema_of_previous_column/3

test__schema_of_previous_column__first_state_left_column() :-
    not schema_of_previous_column(col_schema_9, _, 6).

test__schema_of_previous_column__first_state_middle_column() :-
    schema_of_previous_column(col_schema_10, SchemaIdForPreviousColumn, 6),
    SchemaIdForPreviousColumn == col_schema_9.

test__schema_of_previous_column__first_state_right_column() :-
    schema_of_previous_column(col_schema_11, SchemaIdForPreviousColumn, 6),
    SchemaIdForPreviousColumn == col_schema_10.

test__schema_of_previous_column__second_state_left_column() :-
    not schema_of_previous_column(col_schema_9, _, 7).

test__schema_of_previous_column__second_state_middle_column() :-
    schema_of_previous_column(col_schema_12, SchemaIdForPreviousColumn, 7),
    SchemaIdForPreviousColumn == col_schema_9.

test__schema_of_previous_column__second_state_right_column() :-
    schema_of_previous_column(col_schema_13, SchemaIdForPreviousColumn, 7),
    SchemaIdForPreviousColumn == col_schema_12.

test__schema_of_previous_column__second_state_left_column() :-
    not schema_of_previous_column(col_schema_13, _, 9).

test__schema_of_previous_column__second_state_middle_column() :-
    schema_of_previous_column(col_schema_14, SchemaIdForPreviousColumn, 9),
    SchemaIdForPreviousColumn == col_schema_13.

test__schema_of_previous_column__second_state_right_column() :-
    schema_of_previous_column(col_schema_15, SchemaIdForPreviousColumn, 0),
    SchemaIdForPreviousColumn == col_schema_14.
