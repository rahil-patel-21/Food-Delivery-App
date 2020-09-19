import 'dart:async';
import 'package:flutter/material.dart';

import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notifier/main_notifier.dart';
import 'package:notifier/notifier_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'Helper/Constant.dart';
import 'Helper/SharedManaged.dart';
import 'Screens/OnBoardingScreen/Onboarding.dart';
import 'Screens/OrderStatusPage/OrderStatusPage.dart';
import 'Screens/TabBarScreens/Orders/OrderScreen.dart';
import 'Screens/TabBarScreens/TabScreen/TabBar.dart';
import 'generated/i18n.dart';

void main() => runApp(
      NotifierProvider(
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: SharedManager.shared.locale,
        builder: (context, Locale value, _) {
          print(value);
          return MaterialApp(
            // initialRoute:'/LoginPage',
            // onGenerateRoute: RouteGenerator.generateRoute,
            debugShowCheckedModeBanner: false,
            locale: value,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            localeListResolutionCallback:
                S.delegate.listResolution(fallback: const Locale('en', '')),
            color: Colors.blue,
            home: new Splash(),
          );
        });
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new TabBarScreen()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Onboarding()));
    }
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    // FirebaseApp.initializeApp(this);

    new Timer(new Duration(milliseconds: (Platform.isAndroid ? 2000 : 100)),
        () {
      checkFirstSeen();
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
        // _notifier.notify('message', 'true');
        final message1 = message['notification']['body'];
        print("Notification Message:$message1");
        OrderScreen().updateOrder();
        OrderStatusPage().getOrderStatus();
        // if (Platform.isAndroid) {
        displayTostForNotification(message1);
        // }
        return;
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) async {
      assert(token != null);
      print(token);
      SharedManager.shared.token = token;
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.setString(token,DefaultKeys.pushToken);
    });
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    /*Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new SecondScreen(payload)),
    );*/
  }

  displayTostForNotification(String message) async {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future onDidRecieveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
  }
  Notifier notifier;

  @override
  Widget build(BuildContext context) {
    notifier = NotifierProvider.of(context);
    return new Scaffold(
      body: new Center(
          child: Platform.isAndroid
              ? new Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: new BorderRadius.circular(75),
                      image: DecorationImage(
                          image: AssetImage(AppImages.appLogo))),
                )
              : new Text('')),
    );
  }
}
