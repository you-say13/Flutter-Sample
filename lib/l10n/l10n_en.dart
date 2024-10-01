import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get appKey => '8842c2517a2e5981494057fc25a3d08d8d6def54';

  @override
  String get nameError => '有効な氏名を入力してください。';

  @override
  String get userNameError => '有効なニックネームを入力してください。';

  @override
  String get emailError => '有効なEメールを入力してください。';

  @override
  String get phoneError => '有効な電話番号を入力してください。';

  @override
  String get zipCodeError => '有効な住所を入力してください。';

  @override
  String get cityError => '有効な町名を入力してください。';

  @override
  String get suiteError => '有効な街区符号を入力してください。';

  @override
  String get streetError => '有効な住居番号を入力してください。';

  @override
  String get defaultLengthError => '1文字以上、16文字以下で入力してください。';

  @override
  String get emailLengthError => '32文字以下で入力してください。';
}
