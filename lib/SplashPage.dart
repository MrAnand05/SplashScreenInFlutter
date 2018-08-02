import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 2100),
      vsync: this,
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final logo = ScaleTransition(
      scale: animation,
      child: Icon(
        Icons.shopping_cart,
        size: 200.0,
        color: Colors.green,
      ),
    );

    final descriptionText = FadeTransition(
      child: SlideTransition(
          position: Tween<Offset>(begin: Offset(0.0, -0.8), end: Offset.zero)
              .animate(controller),
          child: Text(
            'Check In to Explore',
            style: textStyle.copyWith(fontSize: 30.0),
          )),
      opacity: animation,
    );

    Widget button(String label, Function onTap) {
      return FadeTransition(
        opacity: animation,
      child:SlideTransition(
        position: Tween<Offset>(begin: Offset(0.0, -0.8), end: Offset.zero)
            .animate(controller),
        child: Material(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.circular(30.0),
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.blue,
            highlightColor: Colors.red,
            //borderRadius: BorderRadius.circular(100.0),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 13.0),
                child: Center(
                  child: Text(
                    label,
                    style: textStyle.copyWith(
                      fontSize: 24.0,
                    ),
                  ),
                )),
          ),
        ),
      ));
    }

    return new Scaffold(
      body: new Center(
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              'assets/StorePic.png',
              fit: BoxFit.cover,
            ),
            Opacity(
              opacity: 0.6,
              child: Container(
                color: Colors.black,
              ),
            ),
            SafeArea(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: logo,
                        ),
                        descriptionText,
                        SizedBox(
                          height: 35.0,
                        ),
                        button('Customer', () {
                          print('Customer LogIn');
                        }),
                        SizedBox(
                          height: 8.0,
                        ),
                        button('Seller', () {
                          print('Seller LogIn');
                        }),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}

const TextStyle textStyle = TextStyle(
  fontFamily: 'ModernAntiqua',
  color: Colors.white,
);
