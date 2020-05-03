![bot controller logo](https://firebasestorage.googleapis.com/v0/b/telegrambot-42384.appspot.com/o/Github%20Images%2Fbot%20logo.png?alt=media&token=4ce92d51-7192-41b6-add4-3bc1b25c742d)

# botcontroller
This is telegram bot controlling app build with flutter. 
This bot is build to help us manage our community with telegram bot.
Their is node APi that connect app with telegram bot.
App and node API is underdevelopment!

## Features
* Send Messages : This app will let admins to send message to different group telegram group that are manage by our community
* Kickout Memebers : It will let us to kickout a memeber from group
* Add new Memebers : When new members are added to the group when the bot will add to the  so we can get all memebers list
* Removed Memebers : When a member left or kickout from the group then it will remove from the DB.
* Reports : This will let us to see all the report that are given by members from the group.
* Start new Event : This will us to start new events which can be online or offline.
* Attendance : This will help to see the attendance of the members in the Event.

## Design

All the designs are done by Harish in figma


![bot controller logo](https://firebasestorage.googleapis.com/v0/b/telegrambot-42384.appspot.com/o/Github%20Images%2Fotp.png?alt=media&token=d26c28ff-0a12-4c48-a8ae-cfbc2f3baff9)

![bot controller logo](https://firebasestorage.googleapis.com/v0/b/telegrambot-42384.appspot.com/o/Github%20Images%2Fsign%20up.png?alt=media&token=623466b8-2eb3-4635-b7e4-bccead15b110)

## Intro
We use Firebase Firestore as the database. 
App id as set to com.evolvingkid.botcontroller (change if you need)

## Directory
In lib folder :
* helper container page route fade animation.
* core contain firebase auth
* models contain data models
### Features Represntation
All the feature listed in the app are store in a list which take Options.
```dart 
 List<Options> options = [];
```
This is saved in the provider/optionsData.dart file.
Options takes data as
```dart
 Options({String name, IconData icon, String catergory, String pageRouteName})

```

#### Options catergory
It takes string as data
* mainPage: means category that shows on main page grid
