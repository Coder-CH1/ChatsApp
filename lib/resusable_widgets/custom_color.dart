

import 'package:flutter/cupertino.dart';

class CustomColor {
  static LinearGradient get multiColors => LinearGradient(colors: [
    Color(0xFFFFE81D),
    Color(0xFF00F0FF),
  ],
  begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static LinearGradient get multiColors2 => LinearGradient(colors: [
    Color(0xFF00F0FF),
    Color(0xFFFFE81D),
  ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}