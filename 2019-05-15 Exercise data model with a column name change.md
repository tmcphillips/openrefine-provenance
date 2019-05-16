## 2019-05-15 Exercise data model with a column name change

### Background
- Over the weekend developed a data model for representing data cleaning workflows (retrospectively).
- Need to exercise the model with simple data cleaning workflows. Can they be represented?
- For these simple workflows need to check if the most obvious provenance queries are supported by the model.
- A data cleaning workflow that consists of just a data import followed by a single column rename is about as simple as it gets.

### Strategies for data model
As the data model was developed a number of problems and strategies to address them emerged:

- **Problem:** Provenance queries need access to previous values of cells buy is too space-expensive to store each state of a data set in its entirety.  
**Strategy:** Store only new values when they are assigned to cells, and provide views of the full data set at each point in its history.


-   **Problem:**  Provenance queries must be able to access past states of the data set.
**Solution:** Design a model that is add-only.  If all information added to the database is immutable, and never deleted then in principle it may be possible to access previous states of the data set.

- **Problem:**  A data cleaning workflow may work on different parts of a data set concurrently for both conceptual and performance reasons.  The history of operations should be independent for each part worked on separately.
**Solution:**  Associate the cells, columns, and rows of a single data set with one or array; have data cleaning operations work on these arrays; and separately model and record the slicing and fusion of arrays during the workflow.

### Datalog model - Version 1
```prolog
% a source refers to the data file from which a dataset is imported
source(source_id, source_uri, source_format).

% a dataset is associated with a data source, import details,
% and a data array containing the imported data values
dataset(dataset_id, source_id, import_id, array_id).

% the import includes all data parsing choices made when the dataset was created
import(import_id, ...).

% an array is a set of columns, rows, and the values in each cell
array(array_id, dataset_id).

% a column is associated with an array but its schema and position is elsewhere
column(column_id, array_id).

% a row is associated with an array but iss schema and position is elsewhere
row(row_id, array_id).

% a cell is a pairing of a column and row of an array
cell(cell_id, column_id, row_id).

% an array goes through a sequence of states represented as a singly-linked list
state(state_id, array_id, previous_state_id).

% content gives the value of a cell at a specific state
content(content_id, cell_id, state_id, value_id).

% a value is stored as text so that the type of columns can change
% without updating all of the values of its cells
value(value_id, value_text).

% the type, name, and relative position of a column can vary from state to state
column_schema(column_schema_id, column_id, state_id, column_type,
              column_name, previous_column_id).

% the relative position of a row can vary from state to state
row_position(row_positition_id, row_id, state_id, previous_row_id).
```

### Example 1 - Column rename on a small data set

- Data source is a a CSV file named 'biblio.csv' with these contents:

    ```csv
    Book Title,Author,Date
    Against Method,Paul Feyerabend,1975
    Changing Order,H.M. Collins,1985
    Exceeding Our Grasp,P. Kyle Stanford,2006
    ```

- After importing this data the dataset should look like this is OpenRefine:

|Book Title|Author|Date|
|--|--|--|
|Against Method|Paul Feyerabend|1975|
|Changing Order|H.M. Collins|1985|
|Exceeding Our Grasp|P. Kyle Stanford|2006|

- And the Datalog representation of the dataset should start as:

    ```prolog
    % source(source_id, source_uri, source_format).
    source(7, 'biblio.csv', 'text/csv').
    
    % dataset(dataset_id, source_id, import_id, array_id).
    dataset(3, 7, 5, 9).
    
    % import(import_id, ...).
    import(5).
    
    % array(array_id, dataset_id).
    array(9, 3).
    
    % column(column_id, array_id).
    column(1, 9).
    column(2, 9).
    column(3, 9).
    
    % row(row_id, array_id).
    row(6, 9).
    row(7, 9).
    row(8, 9).
    
    % cell(cell_id, column_id, row_id).
    cell(1, 1, 6).
    cell(2, 1, 7).
    cell(3, 1, 8).
    cell(4, 2, 6).
    cell(5, 2, 7).
    cell(6, 2, 8).
    cell(7, 3, 6).
    cell(8, 3, 7).
    cell(9, 3, 8).
    
    % state(state_id, array_id, previous_state_id).
    state(17, 9, nil).
    
    % content(content_id, cell_id, state_id, value_id).
    content(11, 1, 17, 21).
    content(12, 2, 17, 22).
    content(13, 3, 17, 23).
    content(14, 4, 17, 24).
    content(15, 5, 17, 25).
    content(16, 6, 17, 26).
    content(17, 7, 17, 27).
    content(18, 8, 17, 28).
    content(19, 9, 17, 29).
    
    % value(value_id, value_text).
    value(21, 'Against Method').
    value(22, 'Changing Order').
    value(23, 'Exceeding our Grasp').
    value(24, 'Paul Feyerabend').
    value(25, 'H.M. Collins').
    value(26, 'P. Kyle Stanford').
    value(27, '1975').
    value(28, '1985').
    value(29, '2006').
    
    % column_schema(column_schema_id, column_id, state_id, column_type, column_name, previous_column_id).
    column_schema(4, 1, 17, 'string', 'Book Title', nil).
    column_schema(5, 2, 17, 'string', 'Author', 1).
    column_schema(6, 3, 17, 'string', 'Data', 2).
    
    % row_position(row_positition_id, row_id, state_id, previous_row_id).
    row_position(31, 6, 17, nil).
    row_position(32, 7, 17, 6).
    row_position(33, 8, 17, 7).
    ```


