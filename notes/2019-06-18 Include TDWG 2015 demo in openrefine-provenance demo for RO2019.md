## 2019-06-18 Include TDWG 2015 demo in openrefine-provenance demo for RO2019

### Copied example scripts and data files from kurator-validation repo

- Created new directory in openrefine-provenance repo:  `demos/04_paper_demo/python`

- Copied  `clean_data_using_worms.py` (the data cleaning script) from `kurator-validation/packages/kurator_worms/scripts/` to the new directory.

- Copied `services.py` (the WoRMS service module) from `kurator-validation/packages/kurator_worms` to `worms_service.py` in the new directory.

- Updated the first line of  `clean_data_using_worms.py` to import the `WoRMService` class from the `worms_service` module in the same directory:

    ```python
    from worms_service import WoRMSService
    ```
- Copied the demo_input.csv file from `kurator-validation/packages/kurator_worms/scripts/` to the new directory.

- Ran the script in the new location using Python 2 (and using the currently installed `suds-jurko` package), confirming that the two output files are identical the outputs files in  `kurator-validation/packages/kurator_worms/scripts/`.

- The example script and data files are now self-contained in the new `demos/04_paper_demo/python` directory.

### Updated local copy of script and WoRMS service to work with Python 3

- Updated print statements in `clean_data_using_worms.py`  and `worms_service.py`  to conform to Python 3 syntax.

- Added a requirements.txt file specifying the single dependency:

    ```console
    $ cat requirements.txt
    suds-jurko==0.6
    ```
- Created a virtual environment for running the data cleaning script with Python 3:

    ```console
    $ python3 -m venv .venv_04_paper_demo
    
    $ . .venv_04_paper_demo/bin/activate
    
    (.venv_04_paper_demo) $ pip list
    pip (9.0.1)
    pkg-resources (0.0.0)
    setuptools (33.1.1)
    ```
- Installed the dependency in the new virtual environment:

    ```console
    (.venv_04_paper_demo) $ pip install -r requirements.txt
    Collecting suds-jurko==0.6 (from -r requirements.txt (line 1))
    Installing collected packages: suds-jurko
    Successfully installed suds-jurko-0.6
    
    (.venv_04_paper_demo) $ pip list
    DEPRECATION: The default format will switch to columns in the future. You can use --format=(legacy|columns) (or define a format=(legacy|columns) in your pip.conf under the [list] section) to disable this warning.
    pip (9.0.1)
    pkg-resources (0.0.0)
    setuptools (33.1.1)
    suds-jurko (0.6)
    ```

- Successfully ran data cleaning script using Python3:

    ```console
    (.venv_04_paper_demo) $ which python3
    /mnt/c/Users/tmcphill/GitRepos/openrefine-provenance/demos/04_paper_demo/python/.venv_04_paper_demo/bin/python3

    (.venv_04_paper_demo) $ python3 clean_data_using_worms.py
    2019-06-18 18:39:05  Reading input records from 'demo_input.csv'.
    
    2019-06-18 18:39:05  Reading input record 001.
    2019-06-18 18:39:05  Trying WoRMs EXACT match for scientific name: 'Placopecten magellanicus'.
    2019-06-18 18:39:06  WoRMs EXACT match was SUCCESSFUL.
    2019-06-18 18:39:06  UPDATING scientific name authorship from 'Gmelin, 1791' to '(Gmelin, 1791)'.
    2019-06-18 18:39:06  ACCEPTED record 001.
    
    2019-06-18 18:39:06  Reading input record 002.
    2019-06-18 18:39:06  Trying WoRMs EXACT match for scientific name: 'Placopecten magellanicus'.
    2019-06-18 18:39:07  WoRMs EXACT match was SUCCESSFUL.
    2019-06-18 18:39:07  ACCEPTED record 002.
    
    2019-06-18 18:39:07  Reading input record 003.
    2019-06-18 18:39:07  Trying WoRMs EXACT match for scientific name: 'magellanicus placopecten'.
    2019-06-18 18:39:07  EXACT match FAILED.
    2019-06-18 18:39:07  Trying WoRMs FUZZY match for scientific name: 'magellanicus placopecten'.
    2019-06-18 18:39:14  WoRMs FUZZY match FAILED.
    2019-06-18 18:39:14  REJECTED record 003.
    
    2019-06-18 18:39:14  Reading input record 004.
    2019-06-18 18:39:14  Trying WoRMs EXACT match for scientific name: 'Placopecten magellanicus'.
    2019-06-18 18:39:15  WoRMs EXACT match was SUCCESSFUL.
    2019-06-18 18:39:15  UPDATING scientific name authorship from '' to '(Gmelin, 1791)'.
    2019-06-18 18:39:15  ACCEPTED record 004.
    
    2019-06-18 18:39:15  Reading input record 005.
    2019-06-18 18:39:15  Trying WoRMs EXACT match for scientific name: 'Placopecten magellanicus'.
    2019-06-18 18:39:16  WoRMs EXACT match was SUCCESSFUL.
    2019-06-18 18:39:16  ACCEPTED record 005.
    
    2019-06-18 18:39:16  Reading input record 006.
    2019-06-18 18:39:16  Trying WoRMs EXACT match for scientific name: ''.
    2019-06-18 18:39:16  EXACT match FAILED.
    2019-06-18 18:39:16  Trying WoRMs FUZZY match for scientific name: ''.
    2019-06-18 18:39:23  WoRMs FUZZY match FAILED.
    2019-06-18 18:39:23  REJECTED record 006.
    
    2019-06-18 18:39:23  Reading input record 007.
    2019-06-18 18:39:23  Trying WoRMs EXACT match for scientific name: 'Placopcten magellanicus'.
    2019-06-18 18:39:24  EXACT match FAILED.
    2019-06-18 18:39:24  Trying WoRMs FUZZY match for scientific name: 'Placopcten magellanicus'.
    2019-06-18 18:39:30  WoRMs FUZZY match was SUCCESSFUL.
    2019-06-18 18:39:30  UPDATING scientific name from 'Placopcten magellanicus' to 'Placopecten magellanicus'.
    2019-06-18 18:39:30  UPDATING scientific name authorship from 'Gmellin' to '(Gmelin, 1791)'.
    2019-06-18 18:39:30  ACCEPTED record 007.
    
    2019-06-18 18:39:30  Reading input record 008.
    2019-06-18 18:39:30  Trying WoRMs EXACT match for scientific name: 'Placopecten magellanicus'.
    2019-06-18 18:39:31  WoRMs EXACT match was SUCCESSFUL.
    2019-06-18 18:39:31  ACCEPTED record 008.
    
    2019-06-18 18:39:31  Reading input record 009.
    2019-06-18 18:39:31  Trying WoRMs EXACT match for scientific name: 'Nodipecten nodsus'.
    2019-06-18 18:39:32  EXACT match FAILED.
    2019-06-18 18:39:32  Trying WoRMs FUZZY match for scientific name: 'Nodipecten nodsus'.
    2019-06-18 18:39:41  WoRMs FUZZY match was SUCCESSFUL.
    2019-06-18 18:39:41  UPDATING scientific name from 'Nodipecten nodsus' to 'Nodipecten nodosus'.
    2019-06-18 18:39:41  ACCEPTED record 009.
    
    2019-06-18 18:39:41  Reading input record 010.
    2019-06-18 18:39:41  Trying WoRMs EXACT match for scientific name: 'Pecten nodosus'.
    2019-06-18 18:39:41  EXACT match FAILED.
    2019-06-18 18:39:41  Trying WoRMs FUZZY match for scientific name: 'Pecten nodosus'.
    2019-06-18 18:39:47  WoRMs FUZZY match FAILED.
    2019-06-18 18:39:47  REJECTED record 010.
    
    2019-06-18 18:39:47  Wrote 7 accepted records to 'demo_cleaned.csv'.
    2019-06-18 18:39:47  Wrote 3 rejected records to 'demo_rejected.csv'.
    ```

- Confirmed that output data files are correct.


