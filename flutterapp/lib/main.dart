// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:medico/providers/prescription_provider.dart';
import 'common/common_vals.dart';
import 'models/doctor_model.dart';
import 'models/medicine_model.dart';
import 'models/patient_model.dart';
import 'models/prescription_model.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();
  hasPris.value = false;
  // hasPris.value = pref.getBool('hasPris') ?? false;

  // final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDir.path);
  // Hive.registerAdapter(PatientAdapter());
  // Hive.registerAdapter(MedicineAdapter());
  // Hive.registerAdapter(PrescriptionAdapter());
  // Hive.registerAdapter(DoctorAdapter());

  // MedicineProvider().fetchData();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => MedicineProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Medico',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.black,
          primaryColor: Colors.black,
          fontFamily: 'manrope',
          brightness: Brightness.light,
          iconTheme: const IconThemeData(
            color: Colors.black,
            size: 25,
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
