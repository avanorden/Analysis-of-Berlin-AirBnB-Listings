#converts csv data to markdown table format
import csv
import os


#output csv or tsv file into a new txt file in the markdown table format

#| header1 | header2 |
#| --- | --- |
#| data1 | data2 |
#| data1 | data2 |

def markdown_table_format(filepath, csv_file, encoding_type):
    delimiter_type = ""
    if csv_file.endswith(".csv"):
        delimiter_type = ","
    elif csv_file.endswith(".tsv"):
        delimiter_type = "\t"
    else:
        print(csv_file + "was not a csv file")
        return
    
    
    try:
        
        results = []
        
        with open(filepath + "\\" + csv_file, "r", encoding=encoding_type) as csvfile: #open [filename].csv
            reader = csv.reader(csvfile, delimiter=delimiter_type)
            
            
            filetext = ""
            for row in reader:
                line = "|"
                for data in row:
                    data = data.replace("|", "\|") #the | character causes formating issues if not escaped
                    
                    line += " " + data + " |"
                
                filetext += line + "\n"
                
                if reader.line_num == 1: #special line below headers
                    pad = "|"
                    for data in row:
                        pad += "---|"
                    
                    filetext += pad + "\n"
            
            
            newFileName = csv_file[:-4] + ".txt"
            
            try:
                with open(filepath + "\\" + newFileName, "x", encoding=encoding_type)as newfile: #write to [filename].txt
                    newfile.write(filetext)
            except OSError as OSE:
                print("markdown_table_format() Error: " + newFileName + " could not be created")
                print(OSE)
                print("") 
            else:
                print(newFileName + " was created successfully")
                print("") 
                
    except FileNotFoundError:
        print("markdown_table_format() Error: Invalid file path")
    except UnicodeDecodeError as UDE:
        print("markdown_table_format() Error: " + csv_file + " was not encoded in "+ encoding_type)
        print(UDE)
        print("")
    except OSError as OSE:
        print("markdown_table_format() Error: " + csv_file + " could not be opened")
        print(OSE)
        print("")
        
        
#Main
encoding = "utf-8"


#Prompt user for path to csv files
print("All .csv files in the chosen directory will be converted using " + encoding + ",")
print("Output stored in 'converted_[filename].txt',")
print("Enter the filepath for the directory:")
filepath:str = input()

try:
    #Run converson for each file
    dirlist:list = os.listdir(filepath)

    for f in dirlist:
        if f.endswith(".csv") or f.endswith(".tsv"):
            markdown_table_format(filepath, f, encoding);
except FileNotFoundError:
    print("Invalid file path")