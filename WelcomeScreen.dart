import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin { //mixins provide timing control for animations.
  AnimationController controller;     //controller needed to make animations happen
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)     //code responsible for grey to white transition on app startup
        .animate(controller);
    controller.forward();     //animation controller only goes forwards
    controller.addListener(() { //Always listneing for changes and updates app state once it does. Thats how the light changes from grey to white smoothly for the app
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();     //you need to dispose animation controller once ur done with it or it will keep running in the background
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(         //Hero widgets wrap images to transition between one app page and another. Its a built in animation class basically.
                  tag: 'logo',      //logo transitions from this page to login or register screen
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(    //This is imported class from that package. Its not written by me but basically shows type writer animation of text
                  text: ['KU Collaboration'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              title: 'Register',
              colour: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);      //Two rounded buttons to click and route to different page by
              },
            ),
          ],
        ),
      ),
    );
  }
}
