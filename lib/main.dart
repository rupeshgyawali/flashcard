import 'package:flash_card/ui/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(FlashCardApp());

class FlashCardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue.shade700,
      ),
      routes: <String, WidgetBuilder>{
        '/': (context) => HomeScreen(),
      },
    );
  }
}
