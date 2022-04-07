import 'package:flutter/material.dart';
import 'package:fapp1/pages/covid_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Covid List",
      debugShowCheckedModeBanner: false,
      home: CovidPage(),
    );
  }
}
