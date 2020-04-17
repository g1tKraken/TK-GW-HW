import os
import csv

def cash(d):
    return ' $  {:,.2f}'.format(d)

#print(f"Working dir[{os.getcwd()}]")
raw_file_in_path = os.path.join('.','Resources','budget_data.csv')
txt_file_out_path = os.path.join('.','analysis','budget_analysis.txt')

months_lst = []
profs_lst = []

with open(raw_file_in_path, 'r') as openfile:
    filereader = csv.reader(openfile, delimiter=",")
    hdr = next(filereader, None)
    
    for row in filereader:
        months_lst.append(row[0])
        profs_lst.append(float(row[1]))

    count_months = len(months_lst)
    profit_sum = sum(profs_lst)

    maxProf = max(profs_lst)
    maxProfIx = profs_lst.index(maxProf)
    minProf = min(profs_lst)
    minProfIx = profs_lst.index(minProf)
    outputtext = "\nFinancial Analysis\n" + "--" * 45
    outputtext += f"\nBank profits across {count_months} months :"
    outputtext += f"\n\tNet profit [{cash(profit_sum)}]"
    outputtext += f"\n\tAverage profit [{cash(sum(profs_lst)/count_months)}] ({cash(profit_sum)} / {count_months})"
    outputtext += f"\n\tThe highest profit increase month was {months_lst[maxProfIx]}, posting [{cash(maxProf)}] gain.)"
    outputtext += f"\n\tThe highest profit loss month was {months_lst[minProfIx]}, posting [{cash(minProf)}] lost.)"
    outputtext += f"\n" + "--" * 45 + "\n"
    print(outputtext)
        
with open(txt_file_out_path, 'w') as outfile:
    outfile.write(outputtext)
    outfile.close()