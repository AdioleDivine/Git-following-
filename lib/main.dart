import 'package:flutter/material.dart';
import 'package:git/home.dart';
import 'package:provider/provider.dart';

import 'Providers/UserProvider.dart';

void main() {
  runApp(ChangeNotifierProvider<UserProvider>(
    create: (context) => UserProvider(),
    child: MaterialApp(home: Home(), debugShowCheckedModeBanner: false),
  ));
}
