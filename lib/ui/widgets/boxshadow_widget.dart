import 'package:flutter/material.dart';

class BoxShadowWidget {
  static const BoxShadow light = BoxShadow(
    color: Colors.black12,
    blurRadius: 4.0,
    offset: Offset(2, 2),
  );

  static const BoxShadow medium = BoxShadow(
    color: Colors.black26,
    blurRadius: 8.0,
    offset: Offset(4, 4),
  );

  static const BoxShadow heavy = BoxShadow(
    color: Colors.black45,
    blurRadius: 12.0,
    offset: Offset(6, 6),
  );

  static const BoxShadow inset = BoxShadow(
    color: Colors.black38,
    blurRadius: 8.0,
    spreadRadius: 1.0,
    offset: Offset(-4, -4), // Makes it look like it's inset
  );

// Add more shadow variations as needed
}
