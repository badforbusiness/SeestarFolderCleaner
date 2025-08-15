

# **PowerShell Astrophotography File Cleaner**

This script is designed to automate the process of cleaning up raw astrophotography data folders. It performs two main actions:

1. It deletes all files that do not have the .fit extension.  
2. It moves all remaining .fit files (typically light frames) into a dedicated lights subfolder.

## **⚠️ WARNING**

**This script will permanently delete files.** Please ensure you have backed up any important data and have correctly set the $targetFolder variable before running. Use at your own risk.

## **How to Use**

1. **Set the Target Folder**: Open the script in a text editor (like Notepad, VS Code, or PowerShell ISE). Find the following line:  
   $targetFolder \= "C:\\Astro\\seestar\\Experiment\\allm31\\M 31\_mosaic\_sub"

   Change the path in the quotes to the **full path** of the folder you want to clean.  
2. **Run the Script**:  
   * Right-click the script file (.ps1) and select "Run with PowerShell".  
   * Alternatively, open a PowerShell terminal, navigate to the directory where you saved the script, and run it by typing .\\your-script-name.ps1.

The script will print its progress to the console, showing you which files are being deleted and moved.

## **What the Script Does**

The script operates in three sequential steps:

1. **Delete Non-.fit Files**: It scans the $targetFolder and removes any file that does not end with the .fit extension. This is useful for clearing out log files, preview images (.jpg, .png), or other miscellaneous files generated during an imaging session.  
2. **Create "lights" Subfolder**: It checks if a subfolder named lights already exists within your target folder. If it doesn't, the script creates it.  
3. **Move .fit Files**: It finds all remaining .fit files in the $targetFolder, copies them to the lights subfolder, and then deletes the originals from the parent directory. It also verifies that the copy was successful before deleting the original file.