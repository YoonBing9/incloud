load data
infile 'C:\file\assc4.csv'
append
into table ASSC
fields terminated by ","
(id, word, assc)