import 'package:flutter/material.dart';
import 'dart:async';
import './router/application.dart';

class LoadingPage extends StatefulWidget {
  @override
  LoadingState createState() => LoadingState();
}

class LoadingState extends State<LoadingPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Application.router.navigateTo(context, '/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: Stack(
          children: <Widget>[
            Image.asset('assets/images/loading.jpeg'),
            Positioned(
              top: 100,
              child: Container(
                width: 400,
                child: Center(
                  child: Text(
                    'Flutter企业站',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      decoration: TextDecoration.none
                    ),
                  )
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}