import os
from os.path import join

path = os.getcwd() + "/parsed"
if not os.path.exists(path):
    os.makedirs(path)

# Search will be passed as ex: search("Susan", "F")
def search(name, gender):
    # Loop through all files in directory to dynamically gather data
    for filename in os.listdir(os.getcwd() + "/Names"):
        file = open(os.getcwd() +"/Names/" + filename,'r')
        year = filename[3:7]
        lines = file.readlines()
        file.close()
        # Allocate memory for variables
        total = 0
        found = False
        to_write = ""
        for line in lines:
            line_split = line.split(',')
            # Add before sanity check to get every line's occurrences
            total = total + int(line_split[2])
            # Sanity check
            if line_split[0].lower() != name.lower() or line_split[1].lower() != gender.lower():
                continue
            # Begin building your string to write, so it parses the new data file
            to_write = year + "," + line_split[2].strip()
            found = True
            line = [i.strip() for i in line]
            # "Found" was only set if the sanity check was passed. This would indicate the search was valid
        if found:
            # Finishes building string and writes it to a new data file called name_gender.txt
            to_write = to_write + "," + str(total) + "\n"
            # If the file doesnt exist create it and open a file handle
            file = open(join(path, name + "_" + gender + ".txt"), "a")
            file.write(to_write)
            file.close()
    print("Parsing Complete")

name = input("Please enter a name: ")
gender = input("Please enter a gender (M/F): ")

search(str(name), str(gender))
