import 'package:flutter/material.dart';

class HomeModel {
  final String title;
  final String content;
  final Widget icon;
  final Color color;
  HomeModel({
    required this.content,
    required this.title,
    required this.icon,
    required this.color
  });
}
