%%%% STATE AFTER INITIAL IMPORT STEP %%%%%

% source(SourceId, SourceUri, SourceFormat).
source(source_1, 'biblio.csv', 'text/csv').

% dataset(DatasetId, SourceId).
dataset(dataset_2, source_1, array_1).

% array(ArrayId, DatasetId).
array(array_1, dataset_1).

% column(ColId, ArrayId).
column(col_1, array_1).
column(col_2, array_1).
column(col_3, array_1).

% row(RowId, ArrayId).
row(row_1, array_1).
row(row_2, array_1).
row(row_3, array_1).

% cell(CellId, ColId, RowId).
cell(cell_1, col_1, row_1). cell(cell_4, col_2, row_1). cell(cell_7, col_3, row_1).
cell(cell_2, col_1, row_2). cell(cell_5, col_2, row_2). cell(cell_8, col_3, row_2).
cell(cell_3, col_1, row_3). cell(cell_6, col_2, row_3). cell(cell_9, col_3, row_3).

% state(StateId, ArrayId, PrevStateId).
state(1, array_1, nil).

% content(ContentId, CellId, StateId, ValId, PrevContentId).
content(content_1, cell_1, 1, val_1, nil).
content(content_2, cell_2, 1, val_2, nil).
content(content_3, cell_3, 1, val_3, nil).
content(content_4, cell_4, 1, val_4, nil).
content(content_5, cell_5, 1, val_5, nil).
content(content_6, cell_6, 1, val_6, nil).
content(content_7, cell_7, 1, val_7, nil).
content(content_8, cell_8, 1, val_8, nil).
content(content_9, cell_9, 1, val_9, nil).

% value(ValId, ValText).
value(val_1, 'Against Method').      value(val_4, 'Paul Feyerabend').  value(val_7, '1975').
value(val_2, 'Changing Order').      value(val_5, 'H.M. Collins').     value(val_8, '1985').
value(val_3, 'Exceeding our Grasp'). value(val_6, 'P. Kyle Stanford'). value(val_9, '2006').

% column_schema(ColSchemaId, ColId, StateId, ColType, ColName, PrevColId, PrevColSchemaId).
column_schema(col_schema_1, col_1, 1, 'string', 'Book Title', nil, nil).
column_schema(col_schema_2, col_2, 1, 'string', 'Author',   col_1, nil).
column_schema(col_schema_3, col_3, 1, 'string', 'Date',     col_2, nil).

% row_position(RowPosId, RowId, StateId, PrevRowId, PrevRowPosId).
row_position(row_pos_1, row_1, 1, nil,   nil).
row_position(row_pos_2, row_2, 1, row_1, nil).
row_position(row_pos_3, row_3, 1, row_2, nil).

%%%% Rename column 1 from Book Title to Title %%%%%
state(2, array_1, 1).
column_schema(col_schema_4, col_1, 2, 'string', 'Title', nil, col_schema_1).

%%%% Place surname first and abbreviate given names to initials in Author column %%%%%
state(3, array_1, 2).
value(val_10, 'Feyerabend, P.').
value(val_11, 'Collins, H.M.').
value(val_12, 'Stanford, P.K.').
content(content_10, cell_4, 3, val_10, content_4).
content(content_11, cell_5, 3, val_11, content_5).
content(content_12, cell_6, 3, val_12, content_6).

%%%% Sort rows by Author %%%%%
state(4, array_1, 3).
row_position(row_pos_4, row_2, 4, nil,   row_pos_2).
row_position(row_pos_5, row_1, 4, row_2, row_pos_1).
row_position(row_pos_6, row_3, 4, row_1, row_pos_3).

%%%% Swap order of second and third columns %%%%%
state(5, array_1, 4).
column_schema(col_schema_5, col_3, 5, 'string', 'Date',   col_1, col_schema_3).
column_schema(col_schema_6, col_2, 5, 'string', 'Author', col_3, col_schema_2).

%%%% Rename column 1 from Title to Main Title %%%%%
state(6, array_1, 5).
column_schema(col_schema_7, col_1, 6, 'string', 'Main Title', nil, col_schema_4).

%%%% Rename column 3 from Date to Published %%%%%
state(7, array_1, 6).
column_schema(col_schema_8, col_3, 7, 'string', 'Published', nil, col_schema_5).
