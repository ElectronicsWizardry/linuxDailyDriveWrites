# linuxDailyDriveWrites
This little python script will make a table showing the daily average writes and reads on all disks in the system.

I made this script to testing the amount of endurance that is done on SSDs by averagering the total writes reported by the kernel by the uptime. I also take into account the sector size of the size of the drive. 

Uses Python 3, I've only tested it on Debian and Fedora Linux, but it likely works on other distros.

Screenshot of example output:

![image](https://user-images.githubusercontent.com/26336785/170580872-05f51ee3-ae1a-4977-b2f9-6e7b8802ff92.png)
