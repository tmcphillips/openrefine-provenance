
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% facts

% array(ArrayId, DatasetId).
array(array_1, nil).

% column(ColId, ArrayId).
column(col_1, array_1).
column(col_2, array_1).
column(col_3, array_1).

% column_schema(ColSchemaId, ColId, StateId, ColType, ColName, PrevColId, PrevColSchemaId).
column_schema(col_schema_1, col_1, 1, 'string', 'Book Title', nil, nil).
column_schema(col_schema_2, col_2, 1, 'string', 'Author',   col_1, nil).
column_schema(col_schema_3, col_3, 1, 'string', 'Date',     col_2, nil).

% row(RowId, ArrayId).
row(row_1, array_1).

% cell(CellId, ColId, RowId).
cell(cell_1, col_1, row_1). cell(cell_2, col_2, row_1). cell(cell_3, col_3, row_1).

% state(StateId, ArrayId, PrevStateId).
state(1, array_1, nil).

% content(ContentId, CellId, StateId, ValId, PrevContentId).
content(content_1, cell_1, 1, val_1, nil).
content(content_2, cell_2, 1, val_2, nil).
content(content_3, cell_3, 1, val_3, nil).

% value(ValId, ValText).
value(val_1, 'Against Method').  value(val_2, 'Paul Feyerabend').  value(val_3, '1975').

% row_position(RowPosId, RowId, StateId, PrevRowId, PrevRowPosId).
row_position(row_pos_1, row_1, 1, nil,   nil).

%%%% Change the author name %%%%%
state(3, array_1, 2).
value(val_10, 'Feyerabend, P.').
content(content_10, cell_4, 3, val_10, content_4).

%%%% Swap order of second and third columns %%%%%
state(4, array_1, 3).
column_schema(col_schema_4, col_3, 5, 'string', 'Date',   col_1, col_schema_3).
column_schema(col_schema_5, col_2, 5, 'string', 'Author', col_3, col_schema_2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% test array_row/2

test__array_row__before_first_state() :-
    not array_row(row_1, 0, _).

test__array_row__first_state() :-
    array_row(row_1, 1, Row),
    Row == '| Against Method | Paul Feyerabend | 1975 |'.

test__array_row__between_first_and_second_state() :-
    array_row(row_1, 2, Row),
    Row == '| Against Method | Paul Feyerabend | 1975 |'.

test__array_row__second_state() :-
    array_row(row_1, 3, Row),
    Row == '| Against Method | Feyerabend, P. | 1975 |'.

test__array_row__third_state() :-
    array_row(row_1, 4, Row),
    Row == '| Against Method | 1975| Feyerabend, P. |'.
