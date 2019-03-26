## 2019-03-20  List interesting data cleaning provenance queries

 
### Data-set level dependencies
- What information other than the original data set does the final (or intermediate) data set depend on?
- What reconciliation services does the final (or intermediate) data set depend on?
- What transformations does the final (or intermediate) data set depend on?

### Column-level dependencies
- What operations during data cleaning affected the final (or intermediate) state of this column?
-  What columns in the original data set does this column of the final (or intermediate) data set depend on?
- What reconciliation services does this column in the final (or intermediate) data set depend on?
- What transformations does this column in the final (or intermediate) data set depend on?

### Row-level dependencies
- What operations during data cleaning affected the final (or intermediate) state of this row?
- What row in the original data set does this row of the final (or intermediate) data set depend on?
- What reconciliation services does this row in the final (or intermediate) data set depend on?
- What transformations does this row in the final (or intermediate) data set depend on?

### Cell-level dependencies
- What operations during data cleaning affected the final (or intermediate) value in this cell?
- What cells in the imported data had values that affected the final value in this cell?
- What cells in the final data set were affected by the value in this cell in the imported data set?
- What is the type of dependency does this cell have on cells in the imported data set?
	- Identity-Of? Value-Of? Derived-from?  Or just Depends-On?  Other?
- What reconciliation services does the final (or intermediate) cell value depend on?
- What transformations does the final (or intermediate) value of this cell depend on?
