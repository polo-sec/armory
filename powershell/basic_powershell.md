# Powershell 

## Listing Directory Contents
To list the contents of the current directory we are in, we can use the Get-ChildItem cmdlet. 

There are various other options we can use with this cmdlet to enhance its capabilities further.

* -Path : Specifies a path to one or more locations. Wildcards are accepted.
* -File / -Directory : To get a list of files, use the File parameter. To get a list of directories, use the Directory parameter. You can use the Recurse parameter with File and/or Directory parameters.
* -Filter : Specifies a filter to qualify the Path parameter.
* -Recurse : Gets the items in the specified locations and in all child items of the locations.
* -Hidden : To get only hidden items, use the Hidden parameter.
* -ErrorAction SilentlyContinue : Specifies what action to take if the command encounters an error.

For example, if you want to view all of the hidden files in the current directory you are in, you can issue the following command: 
	Get-ChildItem -File -Hidden -ErrorAction SilentlyContinue

## Reading Text Files 
Another useful cmdlet is Get-Content. This will allow you to read the contents of a file.

You can run this command as follows: 

	Get-Content -Path file.txt

You can run numerous operations with the Get-Content cmdlet to give you more information about the particular file you are inspecting. Such as how many words are in the file and the exact positions for a particular string within a file.

### Get Number of Words in File
To get the number of words contained within a file, you can use the Get-Content cmdlet and pipe the results to the Measure-Object cmdlet.

You run this command as follows: 

	Get-Content -Path file.txt | Measure-Object -Word

### Get Position of String in File
To get the exact position of a string within the file, you can use the following command:  

	(Get-Content -Path file.txt)[index]


The index is the numerical value that is the location of the string within the file. Since indexes start at zero, you typically need to subtract one from the original value to extract the string at the correct position. This is not necessary for this exercise.

### Pattern Matching
The last cmdlet that is needed to solve this room is Select-String. This cmdlet will search a particular file for a pattern you define within the command to run.

An example execution of this command is: Select-String -Path 'c:\users\administrator\desktop' -Pattern '*.pdf' 

## Changing Directories
*To change directories, you can use the Set-Location cmdlet.For example:

	Set-Location -Path c:\users\administrator\desktop 

Will change your location to the Administrator's desktop.

## Getting Help
Note: You can always use the Get-Help cmdlet to obtain more information about a specific cmdlet. For example, 

	Get-Help Select-String

## Getting File Hashes
With PowerShell, we can obtain the hash of a file by running the following command: 

	Get-FileHash -Algorithm MD5 file.txt

By comparing the verified file hash to the above cmdlet's output, you will know whether the file is authentic.

## Using Strings in Powershell
Strings scans the file you pass it for strings of a default length of 3 or more characters. You can use the Strings tool to peek inside this mysterious executable file. The tool is located within C:\Tools.

	c:\Tools\strings64.exe -accepteula file.exe

## Alternate Data Streams in PowerShell
The command to view ADS using Powershell: 

	Get-Item -Path file.exe -Stream *

There are a few lines of output when you run this command. Pay particularly close attention to Stream and Length.

We can use a built-in Windows tool, Windows Management Instrumentation, to launch the hidden file. The command to run to launch the hidden executable hiding within ADS: 

	wmic process call create $(Resolve-Path file.exe:streamname)
