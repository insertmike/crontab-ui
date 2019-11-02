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

![image](https://user-images.githubusercontent.com/45242072/68074393-63078300-fd92-11e9-8607-07ddcc2f4715.png)

### Inserting a job [2]:
If you have typed ```2``` then you will be presented with a series of questions to configure your to-be scheduled task, such as the time of day that you wish for your task to run & what is that you wish for your task to do.

![image](https://user-images.githubusercontent.com/45242072/68074404-8e8a6d80-fd92-11e9-9666-bde1dae10d66.png)

### Editing a job [3]:
If you have typed ```3```, you will be presented with a prompt input to search by task commands. If the searched task command exists, then you will be asked to change the scheduled task to whatever you want through a similar set of 'config' questions like in _commands 2_.

![image](https://user-images.githubusercontent.com/45242072/68074423-bd084880-fd92-11e9-9a4d-9ea368aa182b.png)

### Remove a job [4]:
If you have typed ```4```, you will be presented with a prompt input to search by task commands. If the searched task command exists, that task will be removed from the your scheduled tasks.

![image](https://user-images.githubusercontent.com/45242072/68074434-dd380780-fd92-11e9-8d35-dd872c0aa9b3.png)

### Remove all job [5]:
If you have typed ```5```, all of the scheduled tasks will be removed.

![image](https://user-images.githubusercontent.com/45242072/68074441-f2ad3180-fd92-11e9-8048-7ae817328d98.png)

### Exit task scheduler [9]:
If you have typed ```9```, you will exit the task scheduler user interface.

![image](https://user-images.githubusercontent.com/45242072/68074449-05276b00-fd93-11e9-981a-de7138c74cb5.png)

Further technical code doc.
--

For this project we have used a variety of different commands to fulfill our task scheduler. We listed & explained in detail the commands below, with examples of how we used them from our project code.

- ```grep```

- ```sed```

- ```crontab```


Requirements:
--

No requirements...lol...jk. Only works in Linux/Ubuntu/Unix OS ;)
Have fun scheduling!
