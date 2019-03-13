
## 2019-03-06  Observe changes in OpenRefine workspace after changes to schema

### Viewed metadata for data set
- Restarted OpenRefine and viewed project listing in Open Project dialog:

	![](https://lh3.googleusercontent.com/X19xzIS_k1ay1dm74wDv0uZWVJGqn_8IQv1fgx4u9xozj3ToABTwInzlcsdx_Ip0Pm--6RtNtjd-vxgKyZNj0_I1qsodtNH3XKA966tD-tHNAoa_63PMuS57XbNmQ-x6MJsy-Y7j)

- Clicked *About* link to display project metadata for project created 2019-03-05.  Except for *Project ID* (which is stored in the project directory name:  2548854995375.project) this metadata corresponds to the contents of the *metadata.json* file.

	![](https://lh4.googleusercontent.com/8alFCGCglrxk-SnnyOLLmmjMdzjagVmhsE5krD4l_IjkgSK0EK7JK4Az6x3KiLV3AASPBSofG4FNbu9wXi8JKVrYR_HDVwin8bkrWGz2-P1r2V1HRAri4_SUzG8NFK4IVR3n6u2p)

### Made one change to test data set schema and observed changes in workspace
- Opened the project above.
- Noted that the files in the project directory are still unchanged after reopening the project:

    ```console
    tmcphill@circe-win10:~$ ls -al .local/share/openrefine/2548854995375.project/
    total 9860
    drwxrwxrwx 1 tmcphill tmcphill     4096 Mar  5 18:01 .
    drwxrwxrwx 1 tmcphill tmcphill     4096 Mar  5 19:21 ..
    -rw-rw-rw- 1 tmcphill tmcphill 10018592 Mar  5 18:01 data.zip
    -rw-rw-rw- 1 tmcphill tmcphill      888 Mar  5 17:56 metadata.json
    ```
- Renamed title of third column from *Object Title* to *Title.*
- The *Undo/Redo* tab now shows 1 step titled "Rename column Object title to Title".

- The project directory immediately shows changes to the size and timestamp of *data.zip*, the timestamp of *metadata.json*, a new *metadata.old.json* file, and and a new *history* subdirectory:

    ```console
    tmcphill@circe-win10:~$ ls -al .local/share/openrefine/2548854995375.project/
    total 9864
    drwxrwxrwx 1 tmcphill tmcphill     4096 Mar  6 10:33 .
    drwxrwxrwx 1 tmcphill tmcphill     4096 Mar  6 10:33 ..
    -rw-rw-rw- 1 tmcphill tmcphill 10018666 Mar  6 10:33 data.zip
    drwxrwxrwx 1 tmcphill tmcphill     4096 Mar  6 10:32 history
    -rw-rw-rw- 1 tmcphill tmcphill      888 Mar  6 10:33 metadata.json
    -rw-rw-rw- 1 tmcphill tmcphill      888 Mar  5 19:26 metadata.old.json
    ```

- The new *history* directory contains one zip file:

    ```console
    tmcphill@circe-win10:~$ ls -al .local/share/openrefine/2548854995375.project/history/
    total 0
    drwxrwxrwx 1 tmcphill tmcphill 4096 Mar  6 10:32 .
    drwxrwxrwx 1 tmcphill tmcphill 4096 Mar  6 10:38 ..
    -rw-rw-rw- 1 tmcphill tmcphill  347 Mar  6 10:32 1551898148430.change.zip
    ```

- The zip file in the *history* directory contains two files, *change.txt* and *pool.txt*:

    ```console
    tmcphill@circe-win10:~$ unzip .local/share/openrefine/2548854995375.project/history/155189814
    8430.change.zip
    Archive:  .local/share/openrefine/2548854995375.project/history/1551898148430.change.zip
      inflating: change.txt
      inflating: pool.txt
    
    tmcphill@circe-win10:~$ cat change.txt
    3.1
    com.google.refine.model.changes.ColumnRenameChange
    oldColumnName=Object Title
    newColumnName=Title
    /ec/
    
    tmcphill@circe-win10:~$ cat pool.txt
    3.1
    reconCount=0
    ```
- Stored new *data.zip*, *metadata.json*, and *metadata.old.json* in a new *or2* directory, and expanded *data.zip* there:

    ```console
    tmcphill@circe-win10:or2$ cp ../.local/share/openrefine/2548854995375.project/data.zip .
    tmcphill@circe-win10:or2$ cp ../.local/share/openrefine/2548854995375.project/metadata.json .
    tmcphill@circe-win10:or2$ cp ../.local/share/openrefine/2548854995375.project/metadata.old.json .
    
    tmcphill@circe-win10:or2$ unzip data.zip
    Archive:  data.zip
      inflating: data.txt
      inflating: pool.txt
    
    tmcphill@circe-win10:or2$ ls -al
    total 80072
    drwxrwxrwx 1 tmcphill tmcphill     4096 Mar  6 11:10 .
    drwxr-xr-x 1 tmcphill tmcphill     4096 Mar  6 11:09 ..
    -rw-rw-rw- 1 tmcphill tmcphill 70264416 Mar  6  2019 data.txt
    -rw-rw-rw- 1 tmcphill tmcphill 10018666 Mar  6 11:10 data.zip
    -rw-rw-rw- 1 tmcphill tmcphill      888 Mar  6 11:10 metadata.json
    -rw-rw-rw- 1 tmcphill tmcphill      888 Mar  6 11:10 metadata.old.json
    -rw-rw-rw- 1 tmcphill tmcphill       17 Mar  6  2019 pool.txt
    ```
- Comparing against the workspace state prior to change, it appears that the size of *data.txt* has changed (and thus *data.zip* as well), whereas *metadata.json* and *pool.txt* have not changed in size:
    
    ```console
    tmcphill@circe-win10:or2$ ls -al ../or1
    total 79888
    drwxrwxrwx 1 tmcphill tmcphill     4096 Mar  5 18:42 .
    drwxr-xr-x 1 tmcphill tmcphill     4096 Mar  6 11:09 ..
    -rw-rw-rw- 1 tmcphill tmcphill 70264173 Mar  6 02:01 data.txt
    -rw-rw-rw- 1 tmcphill tmcphill 10018592 Mar  5 18:42 data.zip
    -rw-rw-rw- 1 tmcphill tmcphill      888 Mar  5 18:42 metadata.json
    -rw-rw-rw- 1 tmcphill tmcphill       17 Mar  6 02:01 pool.txt
    ```

### Analyzed changes to workspace files resulting from the column rename operation

- Difference from *or1/metadata.json* to *or2/metadata.json*:
    ```diff
    tmcphill@circe-win10:or2$ jd ../or1/metadata.json  metadata.json
    @ ["created"]
    - "2019-03-06T01:55:32Z"
    + "2019-03-06T02:31:44Z"
    @ ["modified"]
    - "2019-03-06T01:56:51Z"
    + "2019-03-06T18:33:47Z"
    ```
- Difference from *metadata.old.json* to *metadata.json* in *or2*:

    ```diff
    tmcphill@circe-win10:or2$ jd metadata.old.json metadata.json
    @ ["modified"]
   	- "2019-03-06T03:26:47Z"
   	+ "2019-03-06T18:33:47Z"
    ```

- Observations: 
	1. Only the timestamp properties change in metadata.json when doing a column rename.
    2. The meaning of metadata.old.json is not clear, given that it differs from both the old and the new version of metadata.json.

- The contents of *pool.txt* (stored in *data.zip*) does not change:

    ```console
    tmcphill@circe-win10:or2$ diff ../or1/pool.txt pool.txt
    tmcphill@circe-win10:or2
    ```

- Three changes occur in *data.txt* (stored in *data.zip*): 
		1. The JSON object representing the column description for column 1 changes to reflect the new title.
		2. The *pastEntryCount* property in the history section increments. 
		3. A new JSON object representing the column rename operation is inserted into the history section of the file:

    ```diff
    tmcphill@circe-win10:or2$ diff ../or1/data.txt data.txt
    7c7
    < {"cellIndex":1,"originalName":"Object Title","name":"Object Title","type":"string","format":"","title":"","description":"","constraints":"{}"}
    ---
    > {"cellIndex":1,"originalName":"Object Title","name":"Title","type":"string","format":"","title":"","description":"","constraints":"{}"}
    25c25,26
    < pastEntryCount=0
    ---
    > pastEntryCount=1
    > {"id":1551898148430,"description":"Rename column Object Title to Title","time":"2019-03-06T18:32:40Z","operation":{"op":"core/column-rename","description":"Rename column Object Title to Title","oldColumnName":"Object Title","newColumnName":"Title"}}
    ```
    
### Compared operation information in change.txt vs in data.txt

- The *change.txt* file resulting from the column rename operation contains:

    ```console
    tmcphill@circe-win10:~$ unzip -p .local/share/openrefine/2548854995375.project/history/1551898148430.change.zip change.txt
    3.1
    com.google.refine.model.changes.ColumnRenameChange
    oldColumnName=Object Title
    newColumnName=Title
    /ec/
    ```
- The JSON object representing the operation in *data.txt* is:
    ```console
    tmcphill@circe-win10:or2$ echo '{"id":1551898148430,"description":"Rename column Object Title to Title","time":"2019-03-06T18:32:40Z","operation":{"op":"core/column-rename","description":"Rename column Object Title to Title","oldColumnName":"Object Title","newColumnName":"Title"}}' | jq .
    {
      "id": 1551898148430,
      "description": "Rename column Object Title to Title",
      "time": "2019-03-06T18:32:40Z",
      "operation": {
        "op": "core/column-rename",
        "description": "Rename column Object Title to Title",
        "oldColumnName": "Object Title",
        "newColumnName": "Title"
      }
    }
    ```
- For this operation only the *change.txt* file includes what appears to be the Java class name corresponding to the operation:

    ```console
    com.google.refine.model.changes.ColumnRenameChange
    ```

- Only the new JSON object in *data.txt* includes the *description*, *time*, and *op* properties.

- Noted that the *change.txt* file and operation JSON object are related to each other via a unique operation ID. The operation ID is part of the history file name:  

    ```console
    history/1551898148430.change.zip
    ```
- The same operation ID is stored in the *id* property of the operation JSON object:  

    ```
    "id": 1551898148430
    ```

- Further noted that the ID of a change is the time of the change in units of milliseconds since the Unix Epoch.  
Using the date command to convert all but the last 3 digits of the ID yields a valid-looking date-time close to the time the change was made:

    ```console
    tmcphill@circe-win10:~$ date --date='@1551898148'
    Wed Mar  6 10:49:08 STD 2019
    ```


















