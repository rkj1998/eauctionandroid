// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

const primaryColor = Colors.deepPurple;
const secondaryColor = Colors.purple;

class ProfileData{
  static var userData;
  static assignData(data){
    userData=data;
  }
}