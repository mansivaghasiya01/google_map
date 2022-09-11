import 'package:flutter/material.dart';
import 'package:google_map_demo/views/multiple_marker_onTap.dart';
import 'package:google_map_demo/views/user_current_location.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MultipleMarkerOnTap(),
    );
  }
}
