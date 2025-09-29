import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for Event'**
  String get searchHint;

  /// No description provided for @birthdayText.
  ///
  /// In en, this message translates to:
  /// **'This is Birthday Party'**
  String get birthdayText;

  /// No description provided for @meetingText.
  ///
  /// In en, this message translates to:
  /// **'Meeting for Updating The Development Method'**
  String get meetingText;

  /// No description provided for @nowLabel.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get nowLabel;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back ✨'**
  String get welcome_back;

  /// No description provided for @user_name.
  ///
  /// In en, this message translates to:
  /// **'John Safwat'**
  String get user_name;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @sport.
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get sport;

  /// No description provided for @birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get birthday;

  /// No description provided for @all_events.
  ///
  /// In en, this message translates to:
  /// **'All Events'**
  String get all_events;

  /// No description provided for @sports_events.
  ///
  /// In en, this message translates to:
  /// **'Sports Events'**
  String get sports_events;

  /// No description provided for @birthday_events.
  ///
  /// In en, this message translates to:
  /// **'Birthday Events'**
  String get birthday_events;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @evently.
  ///
  /// In en, this message translates to:
  /// **'Evently'**
  String get evently;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @fill_all_fields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields'**
  String get fill_all_fields;

  /// No description provided for @invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalid_email;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forget Password?'**
  String get forget_password;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t Have Account?'**
  String get dont_have_account;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get create_account;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @login_with_google.
  ///
  /// In en, this message translates to:
  /// **'Login With Google'**
  String get login_with_google;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @password_not_match.
  ///
  /// In en, this message translates to:
  /// **'Password Not Match'**
  String get password_not_match;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @re_password.
  ///
  /// In en, this message translates to:
  /// **'Re password'**
  String get re_password;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already Have Account?'**
  String get already_have_account;

  /// No description provided for @forgetpassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetpassword;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @personalize_experience.
  ///
  /// In en, this message translates to:
  /// **'Personalize Your Experience'**
  String get personalize_experience;

  /// No description provided for @choose_preferred_theme.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred theme and language to start a comfortable, personalized experience.'**
  String get choose_preferred_theme;

  /// No description provided for @lets_start.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Start'**
  String get lets_start;

  /// No description provided for @find_events_that_inspire.
  ///
  /// In en, this message translates to:
  /// **'Find Events That Inspire You'**
  String get find_events_that_inspire;

  /// No description provided for @dive_into_world_of_events.
  ///
  /// In en, this message translates to:
  /// **'Dive into a world of events crafted to fit your unique interests. Whether you\'re into live music, art workshops, professional networking, or discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.'**
  String get dive_into_world_of_events;

  /// No description provided for @effortless_event_planning.
  ///
  /// In en, this message translates to:
  /// **'Effortless Event Planning'**
  String get effortless_event_planning;

  /// No description provided for @take_the_hassle_out_of_organizing.
  ///
  /// In en, this message translates to:
  /// **'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.'**
  String get take_the_hassle_out_of_organizing;

  /// No description provided for @connect_with_friends.
  ///
  /// In en, this message translates to:
  /// **'Connect with Friends & Share Moments'**
  String get connect_with_friends;

  /// No description provided for @share_moments_with_friends.
  ///
  /// In en, this message translates to:
  /// **'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.'**
  String get share_moments_with_friends;

  /// No description provided for @supervised_by.
  ///
  /// In en, this message translates to:
  /// **'Supervised by Mohamed Nabil'**
  String get supervised_by;

  /// No description provided for @create_event.
  ///
  /// In en, this message translates to:
  /// **'Create Event'**
  String get create_event;

  /// No description provided for @category_bookClub.
  ///
  /// In en, this message translates to:
  /// **'Book Club'**
  String get category_bookClub;

  /// No description provided for @category_sport.
  ///
  /// In en, this message translates to:
  /// **'Sport'**
  String get category_sport;

  /// No description provided for @category_birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get category_birthday;

  /// No description provided for @category_meeting.
  ///
  /// In en, this message translates to:
  /// **'Meeting'**
  String get category_meeting;

  /// No description provided for @category_gaming.
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get category_gaming;

  /// No description provided for @category_workshop.
  ///
  /// In en, this message translates to:
  /// **'Workshop'**
  String get category_workshop;

  /// No description provided for @category_exhibition.
  ///
  /// In en, this message translates to:
  /// **'Exhibition'**
  String get category_exhibition;

  /// No description provided for @category_holiday.
  ///
  /// In en, this message translates to:
  /// **'Holiday'**
  String get category_holiday;

  /// No description provided for @category_eating.
  ///
  /// In en, this message translates to:
  /// **'Eating'**
  String get category_eating;

  /// No description provided for @event_date.
  ///
  /// In en, this message translates to:
  /// **'Event Date'**
  String get event_date;

  /// No description provided for @choose_date.
  ///
  /// In en, this message translates to:
  /// **'Choose Date'**
  String get choose_date;

  /// No description provided for @event_time.
  ///
  /// In en, this message translates to:
  /// **'Event Time'**
  String get event_time;

  /// No description provided for @choose_time.
  ///
  /// In en, this message translates to:
  /// **'Choose Time'**
  String get choose_time;

  /// No description provided for @event_title.
  ///
  /// In en, this message translates to:
  /// **'Event Title'**
  String get event_title;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @event_description.
  ///
  /// In en, this message translates to:
  /// **'Event Description'**
  String get event_description;

  /// No description provided for @choose_event_location.
  ///
  /// In en, this message translates to:
  /// **'Choose Event Location'**
  String get choose_event_location;

  /// No description provided for @please_enter_title.
  ///
  /// In en, this message translates to:
  /// **'Please enter title'**
  String get please_enter_title;

  /// No description provided for @please_enter_description.
  ///
  /// In en, this message translates to:
  /// **'Please enter description'**
  String get please_enter_description;

  /// No description provided for @please_select_date.
  ///
  /// In en, this message translates to:
  /// **'Please select date'**
  String get please_select_date;

  /// No description provided for @please_select_time.
  ///
  /// In en, this message translates to:
  /// **'Please select time'**
  String get please_select_time;

  /// No description provided for @please_select_location.
  ///
  /// In en, this message translates to:
  /// **'Please select location'**
  String get please_select_location;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
