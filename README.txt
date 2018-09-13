DIGITAL CLOCK Y3604419
----------------------

To run a function, toggle the DIP switch UP and then DOWN

DIP 0: Set Time
DIP 1: 12H/24H
DIP 2: Activate Alarm
DIP 3: Set Alarm
DIP 4: Stopwatch

Set Time/ Alarm Instructions
N Button: Increment Time
S Button: Decrement Time
E Button: Move Unit >>
W Button: Move Unit <<
C Button: Set Time

Stopwatch Instructions
N Button: Record Lap
C Button: Clear Stopwatch
S Button: Exit Stopwatch

-------------------------------------------------
If workspace is not already setup
-------------------------------------------------
1. Setup BSP
-------------------------------------------------
File-> New -> Board Support Package
Select XilKernal
Click Finish

Set config_time, config_sema to TRUE
Unfold config_sched
	Set SCHED_RR to SCHED_PRIO
Unfold config_pthread_support
	Set config_pthread_mutex to TRUE
Click OK
---------------------------------------------------
2. Setup Application Project
---------------------------------------------------
File-> New-> Application Project
Give project a Name
On OS Platform select xilkernal
On board support package select "use existing"
Click Next
Select Empty Application
Click Finish
---------------------------------------------------
3. Importing Files
---------------------------------------------------
Unfold your project file and right click on "src"
Click "Import"
Select "File System"
Click Next
Click Browse
Navigate to %PATH TO UNZIPPED FOLDER%\Y3604419\workspace5\project\src
Select HW_LCD.c, LCD.c, LCD.h
Click Finish
----------------------------------------------------
4. Create Linker Script
----------------------------------------------------
Right Click your project file
Set Place Code Sections in: to mcb_ddr2_S0_AXI_BASEADDR
Set Place Data Sections in: to mcb_ddr2_S0_AXI_BASEADDR
Set Place Heap and Stack in: to mcb_ddr2_S0_AXI_BASEADDR
Click Generate
-----------------------------------------------------
5. Generate Run Config
-----------------------------------------------------
Click Arrow next to green play button
Click Run Configurations
Double Click Xilinx C/C++ Application
Click STDIO Connection
Set Port to appropriate value
Click Apply
Click Run
------------------------------------------------------
END
------------------------------------------------------