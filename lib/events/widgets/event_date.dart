import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently_app_new/providers/app_theme.dart';
import 'package:evently_app_new/providers/app_language_provider.dart';
import 'package:evently_app_new/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


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
            child: EventDateWidget(),
          ),
        ),
      ),
    );
  }
}


class EventDateWidget extends StatefulWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime>? onDateChanged;

  const EventDateWidget({
    super.key,
    this.selectedDate,
    this.onDateChanged,
  });

  @override
  State<EventDateWidget> createState() => _EventDateWidgetState();
}

class _EventDateWidgetState extends State<EventDateWidget> {
  late DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate;
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
          Row(
            children: [
              Icon(Icons.calendar_today,
                  color: isDark ? Colors.white : Colors.black),
              const SizedBox(width: 8),
              Text(
                localizations.event_date,
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () async {
              DateTime now = DateTime.now();
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? now,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
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
                  selectedDate = picked;
                });
                if (widget.onDateChanged != null) {
                  widget.onDateChanged!(picked);
                }
              }
            },
            child: Text(
              selectedDate == null
                  ? localizations.choose_date
                  : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
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