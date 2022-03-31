import 'package:flutter/material.dart';

import 'color_helper.dart';

class IconHelper {
  //Home Page
  static const Icon appBarReplay = Icon(Icons.replay);
  static const Icon taskDocIcon = Icon(
    Icons.note,
    color: ColorHelper.colorWhite,
    size: 28.0,
  );
  static const Icon taskFalse = Icon(
    Icons.history_toggle_off,
    color: ColorHelper.colorWhite,
    size: 30.0,
  );
  static const Icon taskEnabled = Icon(
    Icons.check,
    color: ColorHelper.colorWhite,
    size: 30.0,
  );
  static const Icon newTaskBtn = Icon(Icons.add);
  static const Icon taskDelete = Icon(Icons.add);
  static const Icon taskUpdate = Icon(Icons.add);
  //Detail Page
  static const Icon taskDocIcon2 = Icon(
    Icons.note,
    color: ColorHelper.colorWhite,
    size: 30.0,
  );
  static const Icon taskDateIcon = Icon(
    Icons.date_range,
    color: ColorHelper.colorWhite,
    size: 30.0,
  );
  //Create Page
  static const Icon taskDateIcon2 = Icon(Icons.date_range);
}
