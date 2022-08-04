# What is this? 
You work with the data files provided in the "Names" folder in the files section. These files contain national data on the relative frequency of given names in the population of U.S. births where the individual has a Social Security Number. For each year of birth YYYY after 1879, there is a comma-delimited file called yobYYYY.txt. Each record in the individual annual files has the format "name,sex,number," where "name" is 2 to 15 characters, "sex" is M (male) or F (female) and "number" is the number of occurrences of the name. Each file is sorted first on sex and then on number of occurrences in descending order. The following creates an application that will show how often a certain name has been used throughout history in the United States.

# Python
It will analyze the given data to feed a graphical user interface created in MATLAB. The program does the following:
  1. Ask the user for a desired name and a sex.
  2. Go through all the data files and find how many times the user-given name has been used for the user-given sex each year.
  3. Calculate the popularity of the user-given name per year as a percentage of the total number of name occurrences used per year.
  4. Find the best linear fit to the name occurrence data using the least squares method. This should be done for both the absolute number of occurrences and the popularity percentages.

The results should be saved in txt format and will be used for part 2.
  
The least squares linear fit approximates a set of (x,y) data as a straight line. This method is based on minimizing the error between the actual data points and the line one gets using the calculated values of m and b. To use the least squares method assume that each of your x values is called xi and each of your y values is called yi, so that a single data point is (xi, yi). The counter i goes from 1 to n, which is the number of data points you have. 
  
You can define average x and y values:

![db1203685d7f2d35ae04ce53f23ab633](https://user-images.githubusercontent.com/93693073/163869898-a174e80d-d3ee-47ce-95c8-36d4b609f8c0.png)

These values to determine m and b:

![b41ab1c8745b966cf9bb7ee5250bf683](https://user-images.githubusercontent.com/93693073/163872561-687caf28-fe43-4178-a09e-644383130b12.png)

In our case, the values xi represent years, while the values yi represent either name occurrences or name popularity for each year.

# MATLAB
The program does the following:
  1. Import the text data into MATLAB.
  2. Create a GUI that will show the historic occurrences of the user-given name over time. Your GUI should include a plot of name occurrences (y-axis) vs year (x-axis) as well as buttons (or drop-down menus, or checkboxes, or any other control structure you prefer) to choose whether to plot the absolute number of occurrences or the popularity percentages.
  3. Plot the appropriate least squares fit line on top of the historic data.

# Screenshots/Example of what is made:
After running the code, a program where you type in the name and select their gender will appear. You click "Plot now!" to plot the popularity of your name. Have fun :)!
In MATLAB, the GUI should be able to refresh whenever the user selects to plot absolute number of occurrences or the popularity percentage.

![d786a99e8bf75fdbc3dbbdaf374954c5](https://user-images.githubusercontent.com/93693073/164383631-2152de09-6fe9-4d65-9835-15901323fb10.png)
 
![fjkhsakjfhangela1](https://user-images.githubusercontent.com/93693073/164383646-349b6b10-38e3-413a-ad61-74e99689576d.png)

![michael](https://user-images.githubusercontent.com/93693073/164383772-897aec4b-cb70-442d-9bfc-fe975fc3eb23.png)

![bob](https://user-images.githubusercontent.com/93693073/164383781-b2aedb8f-b5d5-4e12-be1d-562b59414641.png)

# Extras
Use Python first, then MATLAB.
Made with names folder relative to this:

  os.getcwd() + "/Names/" + filename
