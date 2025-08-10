**Batch File Calendar**
=======================

***Objective***: This script aims to calculate the number of days in a specific month of a given year, taking into account whether the year is a leap year. After calculating the number of days, the script creates a folder for each day of the month within a directory structure provided as input. The script solves the problem of determining the number of days in each month and generates a folder organization representing each day.

***What it does***:

1.  **Calculates the number of days in the month**: The script checks if the year is a leap year and, based on that, correctly sets the number of days for each month, considering that February has 29 days in leap years and 28 in other years.

2.  **Creates directories**: For each day of the month, the script creates a folder within the specified directory structure.

3.  **Checks if the year is a leap year**: The script calculates if the year is a leap year (a year divisible by 4, but not by 100, unless it is also divisible by 400) to adjust the number of days in February.

Detailed Code Explanation
-------------------------

### 1\. Directory Verification and Creation

```
if not exist "%1" (
    mkdir "%1"
)
cd "%1"

if not exist "%2" (
    mkdir "%2"
)
cd "%2"

```

This block checks if the folders specified by the parameters `%1` (first directory) and `%2` (second directory) exist. If they do not, they are created. The `cd` (change directory) command moves the script's execution into these folders. These folders will be used to store the directories for the days of the month.

### 2\. Variable Definition

Here, the script assigns the values of the parameters provided to the script to the variables `mes` (month) and `ano` (year).

```
set mes=%3
set ano=%4

```

### 3\. Leap Year Calculation

```
set /a resto1=%ano% %% 4
set /a resto2=%ano% %% 100
set /a resto3=%ano% %% 400
set /a bissexto=0

if %resto1%==0 (
    if %resto2%==0 (
        if %resto3%==0 (
            set bissexto=1
        ) else (
            set bissexto=0
        )
    ) else (
        set bissexto=1
    )
)

```

-   This block calculates whether the provided year is a leap year.

-   A year is a leap year if it is divisible by 4, but not by 100, unless it is also divisible by 400.

-   The variables `resto1`, `resto2`, and `resto3` store the remainders of the year's division by 4, 100, and 400, respectively.

-   The `bissexto` variable is set to `1` (true) if the year is a leap year and `0` (false) otherwise.

### 4\. Creating Directories for the Days of the Month

-   This uses a `for /L` loop to create numbered folders from 1 up to the number of days in the month.

```
echo The number of days in month %mes% of year %ano% is %dias%.

for /L %%i in (1,1,%dias%) do (
    mkdir %%i
)

cd ..

```

Challenges and Solutions
------------------------

-   **Handling leap years**: It was necessary to use three conditions to correctly verify if the year is a leap year.

-   **Creating directories automatically**: Using `mkdir` within a `for /L` loop allowed for the creation of numbered folders without manual intervention.

-   **Passing arguments**: The script relies on arguments (`%1`, `%2`, etc.), so if they are not provided correctly, it may fail.

Lessons Learned
---------------

With the construction of this code, it was possible to better understand conditional chains which, in turn, presented a simple visual logic but were difficult to apply and manage. It was also possible to learn important programming concepts such as variables, `if` and `else`, parameters, and loops.

Improvements
------------

### Argument Validation

Currently, the script assumes that the provided arguments (`%3` for the month and `%4` for the year) are always valid numeric values. However, if the user enters something invalid (like letters or a number outside the expected range), the script might fail or produce unexpected results.

-   **Solution:** Implement checks to ensure the year is a four-digit number (e.g., 2025) and that the month is between 1 and 12. Otherwise, display an error message and terminate execution.

### Using `setlocal enabledelayedexpansion`

Inside `for` loops, standard Batch variables are not updated dynamically. This can cause unexpected behavior, especially when working with numbers or strings inside the loop.

-   **Solution:** Add `setlocal enabledelayedexpansion` at the beginning of the script and use `!variable!` instead of `%variable%` inside loops to ensure the correct updating of values.

### More User-Friendly Error Messages

The script currently does not provide clear feedback when the user enters invalid values. A simple mistake, like typing "13" for the month, could cause the script to create unexpected directories.

-   **Solution:** Add checks with explanatory messages, such as:

    -   "Error: The month must be between 1 and 12."

    -   "Error: The year must be a valid four-digit number."

    -   "Correct usage: script.bat [directory1] [directory2] [month] [year]"

### Log Creation

To monitor execution and later verify which folders were created, a logging system can be useful.

-   **Solution:** Record all script actions in a `.log` file, including the date, created directories, and any potential errors. This helps maintain an execution history and facilitates debugging if something doesn't work as expected.
