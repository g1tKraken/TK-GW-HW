
import os
import csv

#set up function to format the percent strings as dd.ddd%
def formP(d):
    return '{:,.3f}%'.format(d)
    
raw_file_in_path = os.path.join('.','Resources','election_data.csv')
txt_file_out_path = os.path.join('.','Analysis','election_results.txt')

vt_id_lst = []
cnty_lst = []
can_vot_dct = {}
unique_can_lst = []

with open(raw_file_in_path, 'r') as openfile:
    filereader = csv.reader(openfile, delimiter=",")
    #skip the header row with next()
    hdr = next(filereader, None)
    
    #read the input loop
    for row in filereader:
        vt_id_lst.append(row[0])
        cnty_lst.append(row[1])

        #add candidate rows to a dictionary and increment the vote for each pass
        if row[2] in can_vot_dct.keys():
            can_vot_dct.update({row[2]:can_vot_dct[row[2]] + 1})
        else:
            can_vot_dct.update({row[2]:1})

    vote_count = len(vt_id_lst)

    outputtext = "\nElection Results\n" + "--" * 15
    outputtext += f"\nTotal Votes:  {vote_count}"
    outputtext += "\n" + "--" * 15
    for key, val in can_vot_dct.items():
        outputtext += f"\n{key} : {formP(int(val)/int(vote_count) * 100)} ({val})"
    outputtext += "\n" + "--" * 15
    outputtext += f"\nWinner is: {max(can_vot_dct, key=can_vot_dct.get)}"
    outputtext += "\n" + "--" * 15
    print(outputtext)

#write the output to a file and close the file
with open(txt_file_out_path, 'w') as outfile:
    outfile.write(outputtext)
    outfile.close()

'''
from my prompt output:

Election Results
------------------------------
Total Votes:  3521001
------------------------------
Khan : 63.000% (2218231)
Correy : 20.000% (704200)
Li : 14.000% (492940)
O'Tooley : 3.000% (105630)
------------------------------
Winner is: Khan
------------------------------

'''