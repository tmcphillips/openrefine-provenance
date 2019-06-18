## 2019-06-17 Consider adapting TDWG 2015 demo for RO2019 paper

### Background
- The demonstration of Kurator concepts, YesWorkflow, and Kurator-Akka presented at TDWG 2015 included a small biodiversity dataset and data cleaning workflow.

- TDWG 2015 presentation: [Data cleaning with the Kurator toolkit](http://www.slideshare.net/TimothyMcPhillips/data-cleaning-with-the-kurator-toolkit-bridging-the-gap-between-conventional-scripting-and-highperformance-workflow-automation)

- The demo scripts and test data sets are stored in the `kurator-worms` Python package in the [kurator-validation](https://github.com/kurator-org/kurator-validation) repo:  [packages/kurator_worms](https://github.com/kurator-org/kurator-validation/tree/master/packages/kurator_worms)

- The demo includes a number of data cleaning operations that suggest interesting, science-oriented provenance questions.

### Prepared to run the Python script portion of the kurator-validation data cleaning demo

- Cloned the kurator-validation Git repo:
    ```bash
    tmcphill@circe-win10:~/GitRepos$ git clone git@github.com:kurator-org/kurator-validation.git
    Cloning into 'kurator-validation'...
    remote: Enumerating objects: 4990, done.
    remote: Total 4990 (delta 0), reused 0 (delta 0), pack-reused 4990
    Receiving objects: 100% (4990/4990), 26.57 MiB | 8.42 MiB/s, done.
    Resolving deltas: 100% (2783/2783), done.
    
    tmcphill@circe-win10:~/GitRepos/kurator-validation$ ls -al
    total 48
    drwxrwxrwx 1 tmcphill tmcphill  4096 Jun 17 18:48 .
    drwxr-xr-x 1 tmcphill tmcphill  4096 Jun 17 18:48 ..
    drwxrwxrwx 1 tmcphill tmcphill  4096 Jun 17 19:02 .git
    -rw-rw-rw- 1 tmcphill tmcphill   270 Jun 17 18:48 .gitignore
    drwxrwxrwx 1 tmcphill tmcphill  4096 Jun 17 18:48 packages
    -rw-rw-rw- 1 tmcphill tmcphill 17470 Jun 17 18:48 pom.xml
    -rw-rw-rw- 1 tmcphill tmcphill 26898 Jun 17 18:48 README.md
    drwxrwxrwx 1 tmcphill tmcphill  4096 Jun 17 18:48 src
    ```

- Navigated to the the packages/kurator_worms/scripts directory containing the `clean_data_using_worms.py script`, input file `demo_input.csv`, and expected output files `demo_cleaned.csv` and `demo_rejected.csv` :
    ```bash
    tmcphill@circe-win10:~/GitRepos/kurator-validation$ cd packages/kurator_worms/scripts/
    
    tmcphill@circe-win10:~/GitRepos/kurator-validation/packages/kurator_worms/scripts$ ls -al
    total 384
    drwxrwxrwx 1 tmcphill tmcphill   4096 Jun 17 18:48 .
    drwxrwxrwx 1 tmcphill tmcphill   4096 Jun 17 18:56 ..
    -rw-rw-rw- 1 tmcphill tmcphill   8959 Jun 17 19:01 clean_data_using_worms.py
    -rw-rw-rw- 1 tmcphill tmcphill   3967 Jun 17 18:48 combined.gv
    -rw-rw-rw- 1 tmcphill tmcphill 255267 Jun 17 18:48 combined.png
    -rw-rw-rw- 1 tmcphill tmcphill   2378 Jun 17 19:03 demo_cleaned.csv
    -rw-rw-rw- 1 tmcphill tmcphill   2532 Jun 17 18:48 demo_input.csv
    -rw-rw-rw- 1 tmcphill tmcphill    852 Jun 17 19:03 demo_rejected.csv
    -rw-rw-rw- 1 tmcphill tmcphill   2180 Jun 17 18:48 process.gv
    -rw-rw-rw- 1 tmcphill tmcphill  98338 Jun 17 18:48 process.png
    -rw-rw-rw- 1 tmcphill tmcphill    191 Jun 17 18:48 README.md
    -rw-rw-rw- 1 tmcphill tmcphill    331 Jun 17 18:48 yw.properties
    ```
    
- The first line of the script declares a dependency on the `kurator_worms.service` package:
    ```bash
    $ head -5 clean_data_using_worms.py
    from kurator_worms.service import WoRMSService
    import sys
    import csv
    import time
    from datetime import datetime    
    ```
- Added the kurator-validation modules to the PYTHONPATH so that Python can find the `kurator_worms` package:
    ```bash
    $ export PYTHONPATH="/home/tmcphill/GitRepos/kurator-validation/packages"
    ```
- Inspected the first few lines of the `kurator_worms.service` module to check for further dependencies: 
    ```bash
    $ head ../service.py
    from suds.client import Client
    
    class WoRMSService(object):
        """
        Class for accessing the WoRMS taxonomic name database via the AphiaNameService.
    
        The Aphia names services are described at http://marinespecies.org/aphia.php?p=soap.
        """
    ```

- Installed the `suds-jurko` package that the `kurator_worms` package depends on:
    ```bash
    $ pip2 install suds-jurko
    Collecting suds-jurko
      Downloading https://files.pythonhosted.org/packages/bd/6f/54fbf0999a606680d27c69b1ad12dfff62768ecb9fe48524cebda6eb4423/suds-jurko-0.6.tar.bz2 (143kB)
        100% |████████████████████████████████| 153kB 2.6MB/s
    Building wheels for collected packages: suds-jurko
      Running setup.py bdist_wheel for suds-jurko ... done
      Stored in directory: /home/tmcphill/.cache/pip/wheels/12/68/53/d3902c054e32115da1d45bac442a547a071a86a65db4d77027
    Successfully built suds-jurko
    Installing collected packages: suds-jurko
    Successfully installed suds-jurko-0.6
    ```
### Successfully ran the data cleaning demo script

- Examined the data file used as input by the demo script, noting that it contains 10 records:
    ```bash
    $ cat demo_input.csv
    id,scientificName,scientificNameAuthorship,specificEpithet,genus,family,order,class,phylum,kingdom,recordedBy,eventDate,verbatimEventDate,locality,stateProvince,country,higherGeography
    MCZ:Mala:184232,Placopecten magellanicus,"Gmelin, 1791",magellanicus,Placopecten,Pectinidae,Pectinoida,Bivalvia,Mollusca,Animalia,[no agent data],5/27/50,27-May-50,"Chebeaque Island, west side, Eastern Point",Maine,United States,"North America, United States, Maine"
    MCZ:Mala:223575,Placopecten magellanicus,"(Gmelin, 1791)",magellanicus,Placopecten,Pectinidae,Pectinoida,Bivalvia,Mollusca,Animalia,Arethussa,1880-01-01/1880-12-31,1880,W. Penobscot Bay,Maine,United States,"North America, United States, Maine"
    MCZ:Mala:247327,magellanicus placopecten,"(Gmelin, 1791)",magellanicus,Placopecten,Pectinidae,Pectinoida,Bivalvia,Mollusca,Animalia,K. Read,1963-09-01/1963-09-30,Sep-63,"Salt Pond, Bluehill",Maine,United States,"North America, United States, Maine"
    MCZ:Mala:98960,Placopecten magellanicus,,magellanicus,Placopecten,Pectinidae,Pectinoida,Bivalvia,Mollusca,Animalia,E. Sidney Marks,1931-09-01/1931-09-30,Sep-31,Sandy Hook,New Jersey,United States,"North America, United States, New Jersey"
    MCZ:Mala:139031,Placopecten magellanicus,"(Gmelin, 1791)",magellanicus,Placopecten,Pectinidae,Pectinoida,Bivalvia,Mollusca,Animalia,USCSS Blake Expeditions,1880-01-01/1880-12-31,1880,off Long Island,New York,United States,"North America, United States, New York"
    MCZ:Mala:249963,,"(Gmelin, 1791)",magellanicus,Placopecten,Pectinidae,Pectinoida,Bivalvia,Mollusca,Animalia,Mr. Francis N. Balch,1904-06-01/1904-06-30,4-Jun,"Prince Edward Islands, Pleasant River",,Canada,"North America, Canada"
    MCZ:Mala:223592,Placopcten magellanicus,Gmellin,magellanicus,Placopecten,Pectinidae,Pectinoida,Bivalvia,Mollusca,Animalia,J. A. Cushman,,[date unknown],Vineyard Sound,Massachusetts,United States,"North America, United States, Massachusetts"
    MCZ:Mala:87168,Placopecten magellanicus,"(Gmelin, 1791)",magellanicus,Placopecten,Pectinidae,Pectinoida,Bivalvia,Mollusca,Animalia,[no agent data],,[date unknown],Fisher's Island,New York,United States,"North America, United States, New York"
    MCZ:Mala:74068,Nodipecten nodsus,"(Linnaeus, 1758)",nodosus,Nodipecten,Pectinidae,Pectinoida,Bivalvia,Mollusca,Animalia,[no agent data],,[date unknown],St. Thomas,,West Indies,West Indies
    MCZ:Mala:74068,Pecten nodosus,"(Linnaeus, 1758)",nodosus,Nodipecten,Pectinidae,Pectinoida,Bivalvia,Mollusca,Animalia,[no agent data],,[date unknown],St. Thomas,,West Indies,West Indies
    ```

- Deleted the two expected output files in the `packages/kurator_worms/scripts` directory:
    ```bash
    $ rm demo_rejected.csv demo_cleaned.csv
    ```

- Ran the `clean_data_using_worms.py` script:

    ```bash
    $ python2 clean_data_using_worms.py
    2019-06-17 19:43:37  Reading input records from 'demo_input.csv'.
    
    2019-06-17 19:43:37  Reading input record 001.
    2019-06-17 19:43:37  Trying WoRMs EXACT match for scientific name: 'Placopecten magellanicus'.
    2019-06-17 19:43:38  WoRMs EXACT match was SUCCESSFUL.
    2019-06-17 19:43:38  UPDATING scientific name authorship from 'Gmelin, 1791' to '(Gmelin, 1791)'.
    2019-06-17 19:43:38  ACCEPTED record 001.
    
    2019-06-17 19:43:38  Reading input record 002.
    2019-06-17 19:43:38  Trying WoRMs EXACT match for scientific name: 'Placopecten magellanicus'.
    2019-06-17 19:43:39  WoRMs EXACT match was SUCCESSFUL.
    2019-06-17 19:43:39  ACCEPTED record 002.
    
    2019-06-17 19:43:39  Reading input record 003.
    2019-06-17 19:43:39  Trying WoRMs EXACT match for scientific name: 'magellanicus placopecten'.
    2019-06-17 19:43:39  EXACT match FAILED.
    2019-06-17 19:43:39  Trying WoRMs FUZZY match for scientific name: 'magellanicus placopecten'.
    2019-06-17 19:43:47  WoRMs FUZZY match FAILED.
    2019-06-17 19:43:48  REJECTED record 003.
    
    2019-06-17 19:43:48  Reading input record 004.
    2019-06-17 19:43:48  Trying WoRMs EXACT match for scientific name: 'Placopecten magellanicus'.
    2019-06-17 19:43:49  WoRMs EXACT match was SUCCESSFUL.
    2019-06-17 19:43:49  UPDATING scientific name authorship from '' to '(Gmelin, 1791)'.
    2019-06-17 19:43:49  ACCEPTED record 004.
    
    2019-06-17 19:43:49  Reading input record 005.
    2019-06-17 19:43:49  Trying WoRMs EXACT match for scientific name: 'Placopecten magellanicus'.
    2019-06-17 19:43:50  WoRMs EXACT match was SUCCESSFUL.
    2019-06-17 19:43:50  ACCEPTED record 005.
    
    2019-06-17 19:43:50  Reading input record 006.
    2019-06-17 19:43:50  Trying WoRMs EXACT match for scientific name: ''.
    2019-06-17 19:43:51  EXACT match FAILED.
    2019-06-17 19:43:51  Trying WoRMs FUZZY match for scientific name: ''.
    2019-06-17 19:43:57  WoRMs FUZZY match FAILED.
    2019-06-17 19:43:57  REJECTED record 006.
    
    2019-06-17 19:43:57  Reading input record 007.
    2019-06-17 19:43:57  Trying WoRMs EXACT match for scientific name: 'Placopcten magellanicus'.
    2019-06-17 19:43:57  EXACT match FAILED.
    2019-06-17 19:43:57  Trying WoRMs FUZZY match for scientific name: 'Placopcten magellanicus'.
    2019-06-17 19:44:04  WoRMs FUZZY match was SUCCESSFUL.
    2019-06-17 19:44:04  UPDATING scientific name from 'Placopcten magellanicus' to 'Placopecten magellanicus'.
    2019-06-17 19:44:04  UPDATING scientific name authorship from 'Gmellin' to '(Gmelin, 1791)'.
    2019-06-17 19:44:04  ACCEPTED record 007.
    
    2019-06-17 19:44:04  Reading input record 008.
    2019-06-17 19:44:04  Trying WoRMs EXACT match for scientific name: 'Placopecten magellanicus'.
    2019-06-17 19:44:06  WoRMs EXACT match was SUCCESSFUL.
    2019-06-17 19:44:06  ACCEPTED record 008.
    
    2019-06-17 19:44:06  Reading input record 009.
    2019-06-17 19:44:06  Trying WoRMs EXACT match for scientific name: 'Nodipecten nodsus'.
    2019-06-17 19:44:06  EXACT match FAILED.
    2019-06-17 19:44:06  Trying WoRMs FUZZY match for scientific name: 'Nodipecten nodsus'.
    2019-06-17 19:44:13  WoRMs FUZZY match was SUCCESSFUL.
    2019-06-17 19:44:13  UPDATING scientific name from 'Nodipecten nodsus' to 'Nodipecten nodosus'.
    2019-06-17 19:44:13  ACCEPTED record 009.
    
    2019-06-17 19:44:13  Reading input record 010.
    2019-06-17 19:44:13  Trying WoRMs EXACT match for scientific name: 'Pecten nodosus'.
    2019-06-17 19:44:14  EXACT match FAILED.
    2019-06-17 19:44:14  Trying WoRMs FUZZY match for scientific name: 'Pecten nodosus'.
    2019-06-17 19:44:22  WoRMs FUZZY match FAILED.
    2019-06-17 19:44:22  REJECTED record 010.
    
    2019-06-17 19:44:22  Wrote 7 accepted records to 'demo_cleaned.csv'.
    2019-06-17 19:44:22  Wrote 3 rejected records to 'demo_rejected.csv'.
    ```
- Confirmed that the two expected output files were regenerated and do not differ from the files that had been deleted:

    ```bash
    tmcphill@circe-win10:~/GitRepos/kurator-validation/packages/kurator_worms/scripts$ ls -alrt *.csv
    -rw-rw-rw- 1 tmcphill tmcphill 2532 Jun 17 18:48 demo_input.csv
    -rw-rw-rw- 1 tmcphill tmcphill  852 Jun 17 19:44 demo_rejected.csv
    -rw-rw-rw- 1 tmcphill tmcphill 2378 Jun 17 19:44 demo_cleaned.csv

    tmcphill@circe-win10:~/GitRepos/kurator-validation/packages/kurator_worms/scripts$ git status
    On branch master
    Your branch is up-to-date with 'origin/master'.
    nothing to commit, working tree clean
    ```

- Examined the cleaned data file `demo_cleaned.csv`, noting that it contains seven records:

    ```bash
    $ cat demo_cleaned.csv
    id,scientificName,scientificNameAuthorship,specificEpithet,genus,family,order,class,phylum,kingdom,recordedBy,eventDate,verbatimEventDate,locality,stateProvince,country,higherGeography,LSID,WoRMsMatchResult,originalScientificName,originalAuthor
    MCZ:Mala:184232,Placopecten magellanicus,"(Gmelin, 1791)",magellanicus,Placopecten,Pectinidae,Pectinoida,Bivalvia,Mollusca,Animalia,[no agent data],5/27/50,27-May-50,"Chebeaque Island, west side, Eastern Point",Maine,United States,"North America, United States, Maine",urn:lsid:marinespecies.org:taxname:156972,exact,,"Gmelin, 1791"
    MCZ:Mala:223575,Placopecten magellanicus,"(Gmelin, 1791)",magellanicus,Placopecten,Pectinidae,Pectinoida,Bivalvia,Mollusca,Animalia,Arethussa,1880-01-01/1880-12-31,1880,W. Penobscot Bay,Maine,United States,"North America, United States, Maine",urn:lsid:marinespecies.org:taxname:156972,exact,,
    MCZ:Mala:98960,Placopecten magellanicus,"(Gmelin, 1791)",magellanicus,Placopecten,Pectinidae,Pectinoida,Bivalvia,Mollusca,Animalia,E. Sidney Marks,1931-09-01/1931-09-30,Sep-31,Sandy Hook,New Jersey,United States,"North America, United States, New Jersey",urn:lsid:marinespecies.org:taxname:156972,exact,,
    MCZ:Mala:139031,Placopecten magellanicus,"(Gmelin, 1791)",magellanicus,Placopecten,Pectinidae,Pectinoida,Bivalvia,Mollusca,Animalia,USCSS Blake Expeditions,1880-01-01/1880-12-31,1880,off Long Island,New York,United States,"North America, United States, New York",urn:lsid:marinespecies.org:taxname:156972,exact,,
    MCZ:Mala:223592,Placopecten magellanicus,"(Gmelin, 1791)",magellanicus,Placopecten,Pectinidae,Pectinoida,Bivalvia,Mollusca,Animalia,J. A. Cushman,,[date unknown],Vineyard Sound,Massachusetts,United States,"North America, United States, Massachusetts",urn:lsid:marinespecies.org:taxname:156972,fuzzy,Placopcten magellanicus,Gmellin
    MCZ:Mala:87168,Placopecten magellanicus,"(Gmelin, 1791)",magellanicus,Placopecten,Pectinidae,Pectinoida,Bivalvia,Mollusca,Animalia,[no agent data],,[date unknown],Fisher's Island,New York,United States,"North America, United States, New York",urn:lsid:marinespecies.org:taxname:156972,exact,,
    MCZ:Mala:74068,Nodipecten nodosus,"(Linnaeus, 1758)",nodosus,Nodipecten,Pectinidae,Pectinoida,Bivalvia,Mollusca,Animalia,[no agent data],,[date unknown],St. Thomas,,West Indies,West Indies,urn:lsid:marinespecies.org:taxname:225252,fuzzy,Nodipecten nodsus,
    ```

- And noted that `demo_rejected.csv` contains three records, presumably the three in the original data file not represented in the cleaned data file:

    ```bash
    $ cat demo_rejected.csv
    id,scientificName,scientificNameAuthorship,specificEpithet,genus,family,order,class,phylum,kingdom,recordedBy,eventDate,verbatimEventDate,locality,stateProvince,country,higherGeography
    MCZ:Mala:247327,magellanicus placopecten,"(Gmelin, 1791)",magellanicus,Placopecten,Pectinidae,Pectinoida,Bivalvia,Mollusca,Animalia,K. Read,1963-09-01/1963-09-30,Sep-63,"Salt Pond, Bluehill",Maine,United States,"North America, United States, Maine"
    MCZ:Mala:249963,,"(Gmelin, 1791)",magellanicus,Placopecten,Pectinidae,Pectinoida,Bivalvia,Mollusca,Animalia,Mr. Francis N. Balch,1904-06-01/1904-06-30,4-Jun,"Prince Edward Islands, Pleasant River",,Canada,"North America, Canada"
    MCZ:Mala:74068,Pecten nodosus,"(Linnaeus, 1758)",nodosus,Nodipecten,Pectinidae,Pectinoida,Bivalvia,Mollusca,Animalia,[no agent data],,[date unknown],St. Thomas,,West Indies,West Indies
    ```

