# User friendly task scheduler with __crontab__

Project motivation
--

As a team we aim to simplify the use of command-line commands that aim to schedule tasks for the user, by building a user friendly interface for a 'task scheduler', which otherwise is not very user friendly.

Description:
--

This project aims to make task-scheduling in Unix OS systems much simpler and user friendly. For this project
we are using __'cron'__ _"a Unix, solaris, Linux utility that allows tasks to be automatically run in the background at regular intervals by the cron daemon."_

For the management of the task & their respective scheduling, we are using __'crontab'__ (in short for: _"CRON TABle"_), which is a file that contains the schedule of cron entries to be run and at specified times by the user.

Cron job (or cron schedule) is a specific set of execution instructions specifying day, time and command to execute. crontab can have multiple execution statements within itself.

How it works?
--

1. Run the script by typing the following in to the console/terminal: ```./<filename.sh>```
2. You are presented with a menu with numbered options to manage your tasks.
3. Select an option by typing in the console the corresponding number to that command, ie: ```1. Display all jobs``` will display all current active scheduled jobs once you press ```1```

Available commands:
--

command | description
------- | -----------
1 | Display crontab jobs
2 | Insert a job
3 | Edit a job
4 | Remove a job
5 | Remove all jobs
9 | Exit

Usage Examples:
--

Here we will show you how to use or script.

First and foremost, you must run the script by typing the following in to the console/terminal: ```./<filename.sh>```

You are presented with a menu with numbered options to manage your tasks.

Select an option by typing in the console the corresponding number to that command, ie: ```1. Display all jobs``` will display all current active scheduled jobs once you press ```1```

### Display crontab jobs [1]:
If you have typed ```1``` then you will obtain an output (list-like) of all of the current active crontab jobs.

[image-example]

### Inserting a job [2]:
If you have typed ```2``` then you will be presented with a series of questions to configure your to-be scheduled task, such as the time of day that you wish for your task to run & what is that you wish for your task to do.

[image(s)-example]


Requirements:
--

No requirements...lol...jk. Only works in Linux/Ubuntu/Unix OS ;)
