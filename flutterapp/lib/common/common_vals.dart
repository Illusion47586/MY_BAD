// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences pref;

ValueNotifier<bool> hasPris = ValueNotifier<bool>(false);
ValueNotifier<bool> hasDoctorDetails = ValueNotifier<bool>(false);
Barcode docres;

const fetchLink = 'https://stormy-garden-92515.herokuapp.com/api';
