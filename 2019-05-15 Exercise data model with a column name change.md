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

