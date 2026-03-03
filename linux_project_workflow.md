# Data Science in Economics (BEE2041)
## Project 1: Has UK Housing Become Less Affordable After Brexit?
### ***A Linux Command Line Analysis (2003-2023)***

**Date:** February 2026
***Consideration:*** Majority of the commands used for this project are located in file (called - L04_data_wrangling_using_linux_commands.md) with lecture notes inside of it. Additionally, .csv and .txt files I have worked on are also uploaded in this repository.

---

#### Script for the project

1. Navigating

- To start working on the project it was first necessary to change my working directory into the module related one
```bash
cd ~/Desktop/Data_Science_in_Economics_BEE2041/
cd assignment1/
```

2. Retrieving data

- Instead of manually downloading the datasets, I used `wget` command to retrieve data from "landregistry.gov.uk", ultimately making the process more time efficient and keeping data consistent
- Since, MacOS does not have built-in `wget` function, I used `brew install wget` command to install it

```bash
# Instead of manually downloading the datasets, I used `wget` command to retrieve data from landregistry.gov.uk, ultimately making the process more time efficient and keeping data consistent
wget -O uk_hpi.csv "https://publicdata.landregistry.gov.uk/market-trend-data/house-price-index-data/UK-HPI-full-file-2025-12.csv?utm_medium=GOV.UK&utm_source=datadownload&utm_campaign=full_fil&utm_term=9.30_18_02_26"
```

3. Formatting the data

- I used `sed` command in order to change the date format from `dd/mm/yyyy` to `yyyy-mm-dd` and later saved the output to a new file
- The main reason behind this is to avoid inaccurate outputs

```bash
sed -E 's|([0-9]{2})/([0-9]{2})/([0-9]{4})|\3-\2-\1|' uk_hpi.csv > uk_hpi_fixed_delimiter.csv
```

4. Exploring the files

- Using `head` and `tail` commands, I was able to check whether I had the right data by checking first and last few lines of the .csv file
head uk_hpi_fixed_delimiter.csv 
- Additionally I used `|` to run multiple commands after one another
- By utilising `grep`, `awk` and `sort` I was able to: 
       - convert the dataset downloaded from the web, from monthly to average annual house price index
       - `sort` and the symbol `>` sorted data in current file and then appended it to a new file called "uk_hpi_annual_average.csv"

```bash
tail -n +2 uk_hpi_fixed_delimiter.csv | grep "United Kingdom" | awk -F ',' '{ year=substr($1, 1, 4); sum[year]+=$4; count[year]++} END {for (year in sum) print year, sum[year]/count[year] }' | sort > uk_hpi_annual_average.csv
```

`cat` command was used to print the file contents

```bash
cat uk_hpi_annual_average.csv
```

Dataset for average household income did not require converting into annual
```bash
mv gross-disposable-household-income-per-head-line-chart-data.csv uk_gdhi.csv
```

```bash
# Counted the number of lines in the first two lines of the data file to confirm that it contains the expected number of lines (2)
head -n 2 uk_hpi.csv | wc -l
tail -n 2 uk_hpi.csv
```

This is the pattern of how data was sorted in the original .csv file:
```bash
head -n 10 uk_hpi.csv
  453  Date,RegionName,AreaCode,AveragePrice,Index,IndexSA,1m%Change,12m%Change,AveragePriceSA,SalesVolume,DetachedPrice,DetachedIndex,Detached1m%Change,Detached12m%Change,SemiDetachedPrice,SemiDetachedIndex,SemiDetached1m%Change,SemiDetached12m%C
```

```bash
tail -n +1 uk_hpi_fixed_delimiter.csv
head -n 4 uk_hpi_fixed_delimiter.csv
```

- First, I removed head section of my document to avoid unnecessary data processing
- Using `grep`, I was able to filter for "United Kingdom" data only
- I calculated annual average house prices, using monthly data and transferred it into a new file

```bash
tail -n +2 uk_hpi_fixed_delimiter.csv | \ # 
grep "United Kingdom" | \ 
awk -F ',' '{year=substr($1, 1, 4); sum[year]+=$4; count[year]++} END {for (year in sum) print year, sum[year]/count[year]}' | \ 
sort > uk_hpi_annual_average.csv

head -n 10 uk_gdhi.csv
tail -n +7 uk_gdhi.csv | \
grep "United Kingdom" | \
awk -F ',' '{ year=substr($3, 1, 4); sum[year]+=$4; count[year]++} END {for (year in sum) print year, sum[year]/count[year] }' | \
sort > uk_gdhi_annual_average.csv
cat uk_gdhi_annual_average.csv
```

- Appending data from years 2003 to 2024 to a new .csv file
```bash
awk -F ',' '$1 >= 2003 && $1 < 2024' uk_hpi_annual_average.csv > houseprice.csv
cp uk_gdhi_annual_average.csv income.csv
```

5. Starting to use more data wrangling commands
```bash
MacBook-Air-546:assignment1 datipapinashvili$ awk -F ',' '$1 >= 2003 && $1 < 2024' uk_hpi_annual_average.csv > houseprice.csv
MacBook-Air-546:assignment1 datipapinashvili$ cp uk_gdhi_annual_average.csv income.csv
MacBook-Air-546:assignment1 datipapinashvili$ cp uk_gdhi_annual_average.csv income.txt
MacBook-Air-546:assignment1 datipapinashvili$ cp uk_hpi_annual_average.csv houseprice.txt
MacBook-Air-546:assignment1 datipapinashvili$ sort income.txt > sortedincome.txt
MacBook-Air-546:assignment1 datipapinashvili$ sort houseprice.txt > sortedhpi.txt
MacBook-Air-546:assignment1 datipapinashvili$  
MacBook-Air-546:assignment1 datipapinashvili$ echo 'Year AvgHPI GDHI Ratio' > affordability.txt
MacBook-Air-546:assignment1 datipapinashvili$ join sortedhpi.txt sortedincome.txt | awk '{print $1, $2, $3, $2/$3}' | sort -n >> affordability.txt
MacBook-Air-546:assignment1 datipapinashvili$ echo 'Year  Ratio' > prebrexit.txt
MacBook-Air-546:assignment1 datipapinashvili$ echo 'Year  Ratio' > postbrexit.txt
```



- By using "awk" command with multiple conditions, I was able to split data in the "affordability.txt" file into pre and post brexit affordability ratios and ultimately create two separate files with affordability ratios over years
```bash
MacBook-Air-546:assignment1 datipapinashvili$ awk 'NR>1 && $1>2007 && $1<2016 {print $1, $4}' affordability.txt >> prebrexit.txt
MacBook-Air-546:assignment1 datipapinashvili$ awk 'NR>1 && $1>2015 {print $1, $4}' affordability.txt >> postbrexit.txt
```



- Concatenating the file to display output and check how previous commands worked
```bash
MacBook-Air-546:assignment1 datipapinashvili$ cat prebrexit.txt
Year  Ratio
2008 10.3799
2009 9.29932
2010 9.74092
2011 9.50547
2012 9.20385
2013 9.09757
2014 9.52594
2015 9.59224
MacBook-Air-546:assignment1 datipapinashvili$ cat postbrexit.txt
Year  Ratio
2016 10.1433
2017 10.3649
2018 10.3079
2019 10.1082
2020 10.4167
2021 10.8754
2022 11.2732
2023 10.4266
```



- Counting lines of two files
```bash
MacBook-Air-546:assignment1 datipapinashvili$ wc -l prebrexit.txt
       9 prebrexit.txt
MacBook-Air-546:assignment1 datipapinashvili$ wc -l postbrexit.txt
       9 postbrexit.txt
```



- I "overwrote" a file with prebrexit dataset and appended postbrexit data to it
- This way I was able to have a separate file with merged dataset and used it to calculate % growth in affordability ratio between the years 2015 and 2023
```bash
MacBook-Air-546:assignment1 datipapinashvili$ tail -n +2 prebrexit.txt > full.txt
MacBook-Air-546:assignment1 datipapinashvili$ tail -n +2 postbrexit.txt >> full.txt
MacBook-Air-546:assignment1 datipapinashvili$ cat full.txt
2008 10.3799
2009 9.29932
2010 9.74092
2011 9.50547
2012 9.20385
2013 9.09757
2014 9.52594
2015 9.59224
2016 10.1433
2017 10.3649
2018 10.3079
2019 10.1082
2020 10.4167
2021 10.8754
2022 11.2732
2023 10.4266
MacBook-Air-546:assignment1 datipapinashvili$ sort full.txt 
2008 10.3799
2009 9.29932
2010 9.74092
2011 9.50547
2012 9.20385
2013 9.09757
2014 9.52594
2015 9.59224
2016 10.1433
2017 10.3649
2018 10.3079
2019 10.1082
2020 10.4167
2021 10.8754
2022 11.2732
2023 10.4266
MacBook-Air-546:assignment1 datipapinashvili$ sort full.txt > fullsorted.txt # Sorting the dataset and appending it to a new file
```

- Using "awk" command to compute percentage growth in affordability ratio between 2015 & 2023.
```bash
MacBook-Air-546:assignment1 datipapinashvili$ awk '$1==2015 {old=$2} $1==2023 {new=$2} END {printf "%.2f%%\n", ((new-old)/old)*100}' fullsorted.txt
8.70% 
```



- Utilising the same command but appending (`,`) output to another "temporary" file
```bash
MacBook-Air-546:assignment1 datipapinashvili$ awk '$1==2015 {old=$2} $1==2023 {new=$2} {print} END {printf "Percentage_Change %.2f%%\n", ((new-old)/old)*100}' fullsorted.txt > temp.txt
```

Explaining the command in details:
- `awk` processes the file line by line
- `$` represents different columns, based on the value (e.g. `$1`, `$2`, `$3` etc.)
- `$1==2015 {old=$2}` means that when the first column equals to 2015, it takes the value from `$2` and stores it in a variable called `old`
- Since `awk` finished reading the file and assigned required values to variables `new` and `old`, I ran `END {...}`:
  - `printf "Percentage_Change %.2f%%\n"` was used to give a relevant name to my desired output
  - In `%.2f` starting with `%` was a necessary formatting instruction, while `.2f` was used to print the result rounded up to 2 decimal places
  - Lastly, since I wanted to print the result with a percentage sign next to it, I used 2 `%%` signs to start a formatting instruction (escape it) and then write a literal `%` symbol
  - This part ends with running the final calculation - `((new-old)/old)*100` and "overwriting" temp.txt with my output (`> temp.txt`)



- Since the % change was printed at the end of my dataset, I ran this command to display the last line of it and show me the actual change
```bash
MacBook-Air-546:assignment1 datipapinashvili$ tail -n 1 temp.txt
Percentage_Change 8.70%
```



- I moved the temporary file to a new "fullsorted.txt" file
```bash
MacBook-Air-546:assignment1 datipapinashvili$ mv temp.txt fullsorted.txt
MacBook-Air-546:assignment1 datipapinashvili$ cat fullsorted.txt
2008 10.3799
2009 9.29932
2010 9.74092
2011 9.50547
2012 9.20385
2013 9.09757
2014 9.52594
2015 9.59224
2016 10.1433
2017 10.3649
2018 10.3079
2019 10.1082
2020 10.4167
2021 10.8754
2022 11.2732
2023 10.4266
Percentage_Change 8.70%
```