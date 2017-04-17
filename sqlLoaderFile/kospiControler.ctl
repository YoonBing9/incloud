load data
infile 'C:\file\kospi.csv'
append
into table KOSPI
fields terminated by ","
(thetime DATE "yyyy/mm", kospi)