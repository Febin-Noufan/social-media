import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color myColor = Color.fromARGB(255, 126, 10, 86);
const Color blackColor= Colors.black;
const Color whiteColor= Colors.black;


Future<void> setLoginStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', status);
  }