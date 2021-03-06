import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


void main() {
  runApp(NotifCustIcon());
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class NotifCustIcon extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

Future _showNotification() async {

  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'EDApps',
      'FlutterTutorials',
      'Learn And Run Quizzes',
      sound:'tone',
      importance: Importance.Max,
      priority: Priority.High
  );

  var iOSPlatformChannelSpecifics = new IOSNotificationDetails(
      sound: "tone.aiff",
  );

  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics,
      iOSPlatformChannelSpecifics
  );

  await flutterLocalNotificationsPlugin.show(
    0,
    'New Notification!',
    'Recieved From Notification Tutorials',
    platformChannelSpecifics,
    payload: 'Custom_Sound',
  );
}



class _MyAppState extends State<NotifCustIcon> {

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("Notification Clicked"),
          content: Text("Opened From Notification!"),
        );
      },
    );
  }

  @override
  initState() {
    super.initState();

    var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = new IOSInitializationSettings();

    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid,
        initializationSettingsIOS
    );

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onSelectNotification:onSelectNotification
    );

  }



  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner:false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Notification With Custom Icon'),
        ),
        body:
         Center(
           child:RaisedButton(
             onPressed: _showNotification,
             child: new Text('Show Notification With Custom Icon'),
           ),
         )
      ),
    );

  }


}

