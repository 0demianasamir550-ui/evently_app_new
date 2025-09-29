import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently_app_new/providers/app_theme.dart';
import 'package:evently_app_new/providers/app_language_provider.dart';
import 'package:evently_app_new/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// ---------------- MAIN ----------------
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ChangeNotifierProvider(create: (_) => AppLanguageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final languageProvider = Provider.of<AppLanguageProvider>(context);

    final isDark = themeProvider.isDarkMode();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale(languageProvider.appLanguage),
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: isDark ? const Color(0xFF101127) : Colors.white,
        body: const SafeArea(
          child: Center(
            child: EventTimeWidget(),
          ),
        ),
      ),
    );
  }
}

// ---------------- WIDGET ----------------
class EventTimeWidget extends StatefulWidget {
  final TimeOfDay? selectedTime;
  final ValueChanged<TimeOfDay>? onTimeChanged;

  const EventTimeWidget({super.key, this.selectedTime, this.onTimeChanged});

  @override
  State<EventTimeWidget> createState() => _EventTimeWidgetState();
}

class _EventTimeWidgetState extends State<EventTimeWidget> {
  late TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.selectedTime;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final isDark = themeProvider.isDarkMode();
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // أيقونة وتقريب النص على اليسار
          Row(
            children: [
              Icon(Icons.access_time,
                  color: isDark ? Colors.white : Colors.black),
              const SizedBox(width: 8),
              Text(
                localizations.event_time,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          // Choose Time أو الوقت المختار على اليمين
          GestureDetector(
            onTap: () async {
              final TimeOfDay now = TimeOfDay.now();
              final TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: selectedTime ?? now,
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: isDark
                          ? const ColorScheme.dark(
                        primary: Color(0xFF5669FF),
                        onPrimary: Colors.white,
                        surface: Color(0xFF101127),
                        onSurface: Colors.white,
                      )
                          : const ColorScheme.light(
                        primary: Color(0xFF5669FF),
                        onPrimary: Colors.white,
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF5669FF),
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
              );

              if (picked != null) {
                setState(() {
                  selectedTime = picked;
                });
                if (widget.onTimeChanged != null) {
                  widget.onTimeChanged!(picked);
                }
              }
            },
            child: Text(
              selectedTime == null
                  ? localizations.choose_time
                  : selectedTime!.format(context),
              style: const TextStyle(
                  color: Color(0xFF5669FF),
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}