## OpenRefine Data and Project Model

### Basic facts 
The following are to be considered falsifiable statements about OpenRefine. Each statement aims to be correct (corresponding to reality, and neither a matter of opinion nor a modeling choice of my own), and each potentially can be falsified by examining the documentation for OpenRefine or observing its actual behavior.

-   An OpenRefine *server* is uniquely associated with one *workspace*, a directory tree on a storage volume accessible to the server.
    
-   Configuration information associated with the OpenRefine server as a whole is stored in the *workspace.json* file at the top level of the *workspace.*
    
-   An OpenRefine server can manage multiple *projects.*
    
-   Each project is associated with a  *project ID* unique within a workspace.
    
-   The state of a project  is persisted in a unique *project directory* tree rooted in the workspace.
    
-   The name of a project directory is of the form: *{project ID}.project*
    
-   A project  directory contains at minimum two files, *metadata.json* and *data.zip.*
    
-   The file *metadata.json* contains metadata about the project as a whole.
    
-   The following top-level properties in the *metadata.json* file are given values at the time of  data import: *name* (a text string), *created* (a date-time string), *modified* (a date-time string), *importOptionMetadata* (a JSON structure), *encoding* (a text string indicating the text encoding), and *rowCount* (a positive integer).
    
-   The *importOptionMetadata* structure in *metadata.json* stores all of the options applied during data import.
    
-   The file *data.zip* is a zip archive containing two files named *data.txt* and *pool.txt*.
    
-   The file *data.txt* represents the current state of the project.
    
-   The file *data.txt* comprises three sections. Lines with just the text **/e/** serve as separators between the sections.
    
-   The first section of *data.txt* is the *column model* and includes a sequence of JSON objects, each on its own line, that each represent the metadata for one *column* of the *data*, including the relative position (*cellIndex)* of the column, the name of the column, and the type of the column.
    
-   The second section of *data.txt* represents the history of operations carried out on the project *data*, and comprises two sequences of *history entries*, the first representing the operations that have been applied and can be reverted (undone), the second the operations that have been reverted and can be applied again in the future (redone).
    
-   Each history entry in section 2 of *data.txt* is represented as a JSON object that stores metadata for the operation, including a unique *change ID* (*id*), a human-readable *description* of the operation, a timestamp (*time*), and an *operation* property that stores (as a JSON dictionary) the information that would be needed to apply the operation to a different project.
    
-   The third section of *data.txt* stores the current state of the project data. Each *row* of the project data is represented as a single JSON object, and occupies is own line. Each JSON object has three top-level properties: the *flagged* boolean property, the *starred* boolean property, and the *cells* array. The *cells* array has as many elements as there are columns in the project data, and the values of these elements represent the current values of the corresponding cells in the row if defined, and *null* otherwise.
    
-   Each operation also is associated with a *change object* representing the detailed changes to the project data as a result of the operation.
    
-   Each change object is stored in its own zip archive in the *history* subdirectory of the project directory.
    
-   The name of the zip archive containing a change object is of the form *{change ID}.change.zip* where the *change ID* matches that the value of the *id* property of the corresponding history entry in *data.txt*.
    
-   The *change ID* is an integer and appears to be equivalent to date-time of the change event in units of milliseconds since the Unix epoch (00:00:00 1970-Jan-01 UTC).
    
-   Each *change object* zip archive contains two files:  *change.txt* and *pool.txt*.
    
-   The *change.txt* file contains the two-way diff associated with the change, i.e. the information required either to revert this change to the project, or to apply the change again if it has been reverted.
    
-   The diff stored in a change object is computed by a corresponding *process object* which creates the change object along with the corresponding history entry.
    
-   A process that potentially can affect more than one column, more than one row, or more than one cell of the project data is considered a *generalizable process*.
    
-   A generalizable process is associated with an *abstract operation* that encodes the information required to create another instance of the process, potentially for a different project.
    
-   The **History Panel** (on the **Undo / Redo** tab) in the UI displays a list of all of the history entries, with those corresponding to reverted changes grayed out.
    
-   Clicking the **Extract** button at the top of **History Panel** opens the **Extract Operation History** modal dialog.
    
-   The **Extract Operation History** dialog displays a list of all history entries along with a checkbox for each history entry that was created by a generalizable process. History entries not created by generalizable processes are grayed out and do not have a checkbox associated with them, and thus cannot be extracted through this dialog.

- Checking the box next to a history entry causes the value of the operation property of the history entry to be included in a list of JSON objects in the right panel of the dialog that can be copied by the user and applied as a *recipe* in another project.
