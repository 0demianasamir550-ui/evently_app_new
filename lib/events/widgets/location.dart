import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently_app_new/providers/app_theme.dart';

// ---------------- MAIN ----------------
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.isDarkMode() ? ThemeMode.dark : ThemeMode.light,
      home: const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: LocationWidget(),
          ),
        ),
      ),
    );
  }
}

// ---------------- WIDGET ----------------
class LocationWidget extends StatefulWidget {
  final String? selectedLocation;
  final ValueChanged<String>? onLocationChanged;

  const LocationWidget({
    super.key,
    this.selectedLocation,
    this.onLocationChanged,
  });

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    locationController = TextEditingController(text: widget.selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final borderColor = Color(0xFF5669FF);
    final textColor = Color(0xFF5669FF);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -------- Label --------
        Text(
          "Location",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.0,
            letterSpacing: 0,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 8),

        // -------- Rectangle --------
        Container(
          width: double.infinity,
          height: 62,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: borderColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      'assets/images/icon_location.png',
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: locationController,
                      style: TextStyle(color: textColor, fontSize: 16),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Choose Event Location",
                        hintStyle: TextStyle(color: textColor.withOpacity(0.7)),
                      ),
                      onChanged: (value) {
                        if (widget.onLocationChanged != null) {
                          widget.onLocationChanged!(value);
                        }
                      },
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: borderColor,
                size: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}