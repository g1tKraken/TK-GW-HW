import os
import csv


raw_file_path = os.path.join("..","Resources","cereal.csv")
#raw_file_path = os.path.join('..',"C:\\Users\\SeaLord\\class\\TK-GW-HW\\week_3_Python\\Part-1-Mini-Assignment\\02-HW_CerealCleaner\\Unsolved\\cereal.csv")

with open(raw_file_path, 'r') as openfile:
        filereader = csv.reader(openfile, delimiter=",")
        hdr = next(filereader, None)
        for row in filereader:
            fbr = float(row[7])
            if fbr > 5:
                nameOnBox = row[0]
                
                print(f"Whats in a box of {nameOnBox}? It contains {row[3]} {hdr[3]}, {row[4]} {hdr[4]}, {row[5]} {hdr[5]}, {row[6]} {hdr[6]}, {row[7]} {hdr[7]}, {row[8]} {hdr[8]}, {row[9]} {hdr[9]}, {row[10]} {hdr[10]}, {row[11]} {hdr[11]}, {row[12]} {hdr[12]}, {row[13]} {hdr[13]}, {row[14]} {hdr[14]}, {row[15]} {hdr[15]} ")
                