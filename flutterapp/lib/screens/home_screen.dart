// Dart imports:
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:medico/providers/prescription_provider.dart';
import 'package:medico/widgets/doctor.dart';
import 'package:medico/widgets/profile.dart';
import '../common/common_vals.dart';
import '../utils/colors.dart';
import '../utils/medical_icons_icons.dart';
import '../widgets/medicine.dart';
import '../widgets/prescription.dart';
import 'crop_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(
    initialPage: 1,
  );
  final ValueNotifier<int> _selectedIndex = ValueNotifier<int>(1);
  final picker = ImagePicker();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // Provider.of<MedicineProvider>(context).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: hasPris,
      builder: (context, value, child) {
        return value
            ? Scaffold(
                body: ValueListenableBuilder(
                  valueListenable: _selectedIndex,
                  builder: (context, value, child) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOutCirc,
                      decoration: BoxDecoration(
                        color: pastelColors[value],
                      ),
                      child: SafeArea(
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (value) =>
                              _selectedIndex.value = value,
                          children: [
                            Center(child: Medicine()),
                            Center(
                              child: Prescription(),
                            ),
                            Center(child: Doctor()),
                            Profile(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                bottomNavigationBar: ValueListenableBuilder(
                  valueListenable: _selectedIndex,
                  builder: (context, value, child) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOutCirc,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            offset: const Offset(0, -5),
                            blurRadius: 30,
                          ),
                        ],
                      ),
                      child: GNav(
                        gap: 10,
                        haptic: true,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        curve: Curves.easeInOutCirc,
                        color: Colors.grey[600],
                        activeColor: Colors.black,
                        backgroundColor: Colors.white,
                        rippleColor: Colors.grey[300],
                        hoverColor: Colors.grey[700],
                        iconSize: 25,
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.25,
                        ),
                        tabBackgroundColor: pastelColors[value],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 15),
                        duration: const Duration(milliseconds: 200),
                        // ignore: prefer_const_literals_to_create_immutables
                        tabs: [
                          const GButton(
                            icon: MedicalIcons.drugs,
                            text: 'Current',
                          ),
                          const GButton(
                            icon: MedicalIcons.prescription,
                            text: 'Schedule',
                          ),
                          const GButton(
                            icon: MedicalIcons.doctor,
                            text: 'Doctor',
                          ),
                          const GButton(
                            icon: Icons.data_usage_rounded,
                            text: 'You',
                          )
                        ],
                        selectedIndex: value,
                        onTabChange: (index) {
                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOutCirc,
                          );
                          _selectedIndex.value = index;
                        },
                      ),
                    );
                  },
                ),
              )
            : Scaffold(
                body: SafeArea(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            final pickedFile = await picker.getImage(
                                source: ImageSource.camera);
                            final Uint8List bytes =
                                await pickedFile.readAsBytes();

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CropScreen(bytes),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 30,
                            ),
                            decoration: BoxDecoration(
                              color: pastelColors[0],
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Text(
                              'Capture photo',
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        InkWell(
                          onTap: () async {
                            final pickedFile = await picker.getImage(
                                source: ImageSource.gallery);
                            final Uint8List bytes =
                                await pickedFile.readAsBytes();

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CropScreen(bytes),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 30,
                            ),
                            decoration: BoxDecoration(
                              color: pastelColors[1],
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Text(
                              'Upload photo',
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
