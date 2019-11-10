# User friendly task scheduler with __crontab__

Project motivation
--

As a team we aim to simplify the use of command-line commands that aim to schedule tasks for the user, by building a more user friendly interface for a UNIX 'task scheduler'.

Description:
--

This project aims to make task-scheduling in Unix OS systems much simpler and user friendly. For this project
we are using __'cron'__ _"a Unix, solaris, Linux utility that allows tasks to be automatically run in the background at regular intervals by the cron daemon."_

For the management of the task & their respective scheduling, we are using __'crontab'__ (in short for: _"CRON TABle"_), which is a file that contains the schedule of cron entries to be run and at specified times by the user.

Cron job (or cron schedule) is a specific set of execution instructions specifying day, time and command to execute. crontab can have multiple execution statements within itself.

How it works?
--

1. Run the script by typing the following in to the console/terminal: ```./crontab-ui.sh```
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

Usage Examples (In-depth):
--

Here we will show you how to use or script.

First and foremost, you must run the script by typing the following in to the console/terminal: ```./<filename.sh>```

You are presented with a menu with numbered options to manage your tasks.

Select an option by typing in the console the corresponding number to that command, ie: ```1. Display all jobs``` will display all current active scheduled jobs once you press ```1```

### Display crontab jobs [1]:
If you have typed ```1``` then you will obtain an output (list-like) of all of the current active crontab jobs.

![image](https://user-images.githubusercontent.com/20924663/68547427-7db4aa00-03d9-11ea-98b5-b5205c46a43d.png)

### Inserting a job [2]:
If you have typed ```2``` then you will be presented with a series of questions to configure your to-be scheduled task: whether you want a custom schedule or use a preset schedule command, when you want your task to run & what will the task do.

Using Custom Schedule Commands

![image](https://user-images.githubusercontent.com/20924663/68547491-0a5f6800-03da-11ea-809f-6748fbc57d7c.png)

Using Pre-set schedule commands

![image](https://user-images.githubusercontent.com/20924663/68547512-3e3a8d80-03da-11ea-856e-d2a13b4a080b.png)

### Editing a job [3]:
If you have typed ```3```, you will be presented with a prompt input to search by task commands. If the searched task command exists, then you will be asked to change the scheduled task to whatever you want through a similar set of 'config' questions like in _command 2_ **Inserting a job**.

![image](https://user-images.githubusercontent.com/20924663/68547544-a7ba9c00-03da-11ea-95ce-89144f7758c2.png)

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

- ```grep```- stands for: _g/re/p (globally search a regular expression and print)_. This commands has the same effect: doing a global search with the regular expression and printing all matching lines.

- ```sed``` - stands for _**s**tream **ed**itorsed_. As a command it receives input text as a _“stream”_ and edits the stream according to your instructions (filter). By and large, **people use _sed_ as a command line version of find and replace.**

- ```cat``` -

- ```IFS``` -

- ```read``` -

- ```tail``` -



Requirements:
--

No requirements...lol...jk. Only works in Linux/Ubuntu/Unix OS ;)
Have fun scheduling!
