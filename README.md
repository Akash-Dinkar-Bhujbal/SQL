# SQL
Microsoft SQL Server Management Studio (Almost same as MySQL)

## Some Basic Definitions :
- RDBMS -relational database management system
- DATABASE -COLLECTION OF MANY TABLES
- TABLE -WHERE INFORMATION IS ALWAYS STORES IN THE FORM OF ROWS AND COLUMNS
- SQL -STRUCTURED QUERY LANGUAGE-A LANGUAGE WHICH WE USE TO INTERACT WITH DATABASE 

### WILD CARD CHARACTERS 
- %	Represents zero or more characters
```sql
%a : end with 'a'
a% : start with 'a'
%a% : anywhere 'a'
```
- _	Represents a single character
```sql
_at : eg. 'bat', 'rat'
```
- []	Represents any single character within the brackets
```sql
h[o,a]t : eg. 'hot', 'hat'
```
- ^	Represents any character not in the brackets
```sql
h[^o,a]t : eg. Except 'hot', 'hat' Anything like 'hit'
```
- -	Represents any single character within the specified range
```sql
c[a-b]t : eg. 'cat', 'cbt'
```
