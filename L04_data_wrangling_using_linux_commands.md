# Unit 01 - The Linux Command Line
## Lecture 04 - Data Wrangling
Date: 23/01/2026
Notes taken on: 20/02/2026

---


## Data Wrangling Commands
#### In this lecture we will discuss some of the most useful data wrangling commands in Linux
- The commands we will go through today are useful for working with large datasets and they simplify the process
- Below are some of the powerful tools for processing data, which will be explored in details:
    *In particular, the following three are the most useful/important:* `grep` `sed` and `awk`

### **<ins>sort</ins>**

**Purpose:** Sorts *argument* and prints sorted output

**Use case:** *Alphabetise data*

**Syntax:** ``sort`` *argument*


### **<ins>join</ins>**

**Purpose:** Joins lines of files on a common field

**Use case:** *Merge datasets*

**Syntax:** ``join`` *file1 file2*


### **<ins>uniq</ins>**

**Purpose:** Removes duplicate lubes of sorted *argument*

**Use case:** *Find unique values*

**Syntax:** ``uniq`` *argument*


### **<ins>grep</ins>**

**Purpose:** "Global Regular Expression Print"

**Use case:** *Search for patterns*

**Syntax:** ``grep``


### **<ins>sed</ins>**

**Purpose:** Stream editor

**Use case:** *Find and replace*

**Syntax:** ``sed``


### **<ins>awk</ins>**

**Purpose:** Pattern scanning and text processing language

**Use case:** *Complex data manipulation*

**Syntax:** ``awk``

---


## Regex
#### Regex is a pattern matching language and it can get me out of binds really often. 
- **For example, if I have millions of streams of texts it can help me find the desired text**
![Regex in real life](regexcomic.jpg)
#### So... the ultimate goal of this lecture is to have a good understanding of the commands mentioned above

## Input/Output Redirection

***Key concept:*** *BASH commands can ***<ins>take input</ins>*** and ***<ins>produce output</ins>*** in flexible ways*

**Explanation:**
- ***<ins>Inputs</ins>*** can have different origins:
    - Files
    - Other commands
    - *They can also act directly as an argument to commands*
- ***<ins>Outputs</ins>*** can be:
    - Directly printed on screen
    - Saved in a file
    - Appended to a file
    - Passed to other commands

**Putting into practice:**
##### *To get a better understanding of how the input/output redirection works, we can use the contents of `.zip` file used on the previous lecture*

- Case 1 (changing working directory to `DATE_FILES` and running `ls` command)

```bash
MacBook-Air-441:~ datipapinashvili$ cd DATE_FILES/
MacBook-Air-441:DATE_FILES datipapinashvili$ ls
2017_01_01.txt	2017_10_27.txt	2018_08_22.txt	2019_06_17.txt	2020_04_11.txt	2021_02_04.txt	2021_11_30.txt	2022_09_25.txt	2023_07_21.txt	2024_05_15.txt	2025_03_10.txt 2017_01_02.txt	2017_10_28.txt	2018_08_23.txt
...
```
We have already discussed the `ls` command and why/how we use it.

Now, using 2 of the commands (`ls`, and `wc`) from previous lecture instead of separately running them separately, we can get the desired output in <ins>one</ins> line of code

- Case 2 (exploring the file contents and printing their word count on screen)

```bash
MacBook-Air-441:DATE_FILES datipapinashvili$ ls | wc 
    3288    3288   49321
```

As we can see, running the input (`ls | wc`) gives us an output with a following format - `lines    words   bytes`


## Redirection Operators
#### We already used the `|` operator. However, there are ***4 key elements*** used as operators of input/output redirection:

| **Operator** | **Function**                          | **Example**                  | 
|:------------:|:-------------------------------------:|:----------------------------:|
| `<`          | Take input from file                  | `sort < unsorted.txt`        | 
| `>`          | Send output to file (overwrite)       | `ls -l > filelist.txt`       |
| `>>`         | Append output to file                 | `echo "new line" >> log.txt` |     
| `\|`         | "Pipeline" for concatenating commands | `ls -l \| grep "txt"`        |

Consider:

- `>` overwrites the file entirely
- `>>` adds to the end of the file
- `|` is one of the most powerful features of the command line!

Examples:

**1. Overwriting a file by sending output from `file1` to `file2`**

```bash
MacBook-Air-441:DATE_FILES datipapinashvili$ ls | grep "2025" > rediropera
MacBook-Air-441:DATE_FILES datipapinashvili$ cat rediropera
2025_01_01.txt
2025_01_02.txt
...
2025_12_30.txt
2025_12_31.txt
MacBook-Air-441:DATE_FILES datipapinashvili$
```
- *In this example, we can see that after running `ls | grep "2025" > rediropera` followed by `cat rediropera` output on the screen showed every single file that exists in the file (i.e. `radiropera`)*

**2. Printing word count of a new (overwritten) file**

```bash
MacBook-Air-441:DATE_FILES datipapinashvili$ wc rediropera
     365     365    5475 rediropera
```
- *Moreover, since our file contains a `.txt` file for every single day of the year 2025, running `wc` showed that the file contains 365 lines... or 365 `.txt` files*

**3. Appending specific output from `file1` to `file2`**

```bash
MacBook-Air-441:DATE_FILES datipapinashvili$ ls | grep "2025" >> rediropera
MacBook-Air-441:DATE_FILES datipapinashvili$ wc rediropera
     730     730   10950 rediropera
```
- *By using the `>>` operator, we were able to append every single file (with "2025" in their name) to our file and ultimately get the `wc`. As an output we got `730 730 10950`, proving the fact that `>>` operator adds to the end of the line*

**4. Reverting to the origin**

```bash
MacBook-Air-441:DATE_FILES datipapinashvili$ ls | grep "2025" > rediropera
MacBook-Air-441:DATE_FILES datipapinashvili$ wc rediropera
     365     365    5475 rediropera
```

- *Finally we went back to the original line of code*


## Comparing Files with `diff`

| **Purpose:**                   | **Code:**                  |
|:------------------------------:|:--------------------------:|
| ***To count different lines*** | `diff file1.txt file2.txt` |

- No output = files are identical
- Output shows differences between files
- Example:
```bash
MacBook-Air-441:DATE_FILES datipapinashvili$ diff 2017_01_01.txt 2017_01_02.txt
1,10c1,10
< 7OzAbpvAIb
< yBo5g2QNZx
< HAeRF4eyEW
< lOxg5lD2gH
< vE3UpKC4Ig
< YGnOd9fExI
< mdVd3hzxCo
< tm2vXg5Ygf
< YWNZoa2q97
< D7YlZrdeRE
---
> gJAJFx4cR4
> NrqjuImCpG
> uqJN52wmqA
> dbkOdYH5Sp
> 5AVIVVAn9D
> eCiypa7sd4
> 1sTYKtx3DK
> cs1KIUBRq4
> jAX7Iffd5M
> P6Ph4CqGCz
```


| **Purpose:**                              | **Code:**                                        |
|:-----------------------------------------:|:------------------------------------------------:|
| ***To check if two files are identical*** | `diff file1.txt file2.txt \| grep "^<" \| wc -l` |

- `<` indicates lines only in first file
- `>` indicates lines only in second file