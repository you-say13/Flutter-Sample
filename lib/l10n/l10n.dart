import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
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
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n? of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

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
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  String get appKey;

  /// No description provided for @nameError.
  ///
  /// In en, this message translates to:
  /// **'有効な氏名を入力してください。'**
  String get nameError;

  /// No description provided for @userNameError.
  ///
  /// In en, this message translates to:
  /// **'有効なニックネームを入力してください。'**
  String get userNameError;

  /// No description provided for @emailError.
  ///
  /// In en, this message translates to:
  /// **'有効なEメールを入力してください。'**
  String get emailError;

  /// No description provided for @phoneError.
  ///
  /// In en, this message translates to:
  /// **'有効な電話番号を入力してください。'**
  String get phoneError;

  /// No description provided for @zipCodeError.
  ///
  /// In en, this message translates to:
  /// **'有効な住所を入力してください。'**
  String get zipCodeError;

  /// No description provided for @cityError.
  ///
  /// In en, this message translates to:
  /// **'有効な町名を入力してください。'**
  String get cityError;

  /// No description provided for @suiteError.
  ///
  /// In en, this message translates to:
  /// **'有効な街区符号を入力してください。'**
  String get suiteError;

  /// No description provided for @streetError.
  ///
  /// In en, this message translates to:
  /// **'有効な住居番号を入力してください。'**
  String get streetError;

  /// No description provided for @companyNameError.
  ///
  /// In en, this message translates to:
  /// **'有効な会社名を入力してください。'**
  String get companyNameError;

  /// No description provided for @defaultRequiredError.
  ///
  /// In en, this message translates to:
  /// **'必須項目です。'**
  String get defaultRequiredError;

  /// No description provided for @defaultLengthError.
  ///
  /// In en, this message translates to:
  /// **'1文字以上、16文字以下で入力してください。'**
  String get defaultLengthError;

  /// No description provided for @emailLengthError.
  ///
  /// In en, this message translates to:
  /// **'32文字以下で入力してください。'**
  String get emailLengthError;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return L10nEn();
  }

  throw FlutterError('L10n.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
