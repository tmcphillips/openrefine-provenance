%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% facts

% array(array_id, dataset_id).
array(array_2, nil).

% column(column_id, array_id).
column(col_1, array_2).
column(col_2, array_2).
column(col_3, array_2).

% state(state_id, array_id, previous_state_id).
state(4, array_2, nil).
state(5, array_2,   4).
state(6, array_2,   6).

% column_schema(ColumnSchemaId, ColumnId, StateId, ColumnType, ColumnName, PreviousColumnId, PreviousColumnSchemaId).
column_schema(col_schema_7, col_1, 4, 'string', 'initial column 1 title',   nil, nil).
column_schema(col_schema_8, col_2, 4, 'string', 'initial column 2 title', col_1, nil).
column_schema(col_schema_9, col_3, 4, 'string', 'initial column 3 title', col_2, nil).

test_first_column() :-
    first_column(4, col_1, col_schema_7).

test_atom_concat() :-
    S1 = s1,
    S2 = s2,
    atom_concat(S1, S2, S3),
    S3 == 's1s2'.

%test_last_column() :-

