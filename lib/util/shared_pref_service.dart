import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKeys {
  SharedPrefKeys._();

  //User Prefs
  static const String themeDarkMode = 'themeDarkMode';

  //User Info Keys
  static const userName = 'userName';
  static const userGender = 'gender';
  static const userAge = 'age';
  static const userHeight = 'height';
  static const userStartWeight = 'startWeight';
  static const userStartWeightDate = 'startWeightDate';
  static const userTargetWeight = 'targetWeight';
  static const userTargetWeightDate = 'targetWeightDate';
  static const weightUnitType = 'weightUnitType';
  static const reminderStatus = 'reminderStatus';
  static const onBoardingSeenBefore = 'onboardingscreen';
}

class SharedPreferencesService {
  static SharedPreferencesService _instance;
  static SharedPreferences _preferences;

  SharedPreferencesService._internal();

  static Future<SharedPreferencesService> get instance async {
    if (_instance == null) {
      _instance = SharedPreferencesService._internal();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  Future<void> setOnBoardingSeenBefore(bool onBoardingSeenBefore) async =>
      await _preferences.setBool(
          SharedPrefKeys.onBoardingSeenBefore, onBoardingSeenBefore);

  Future<void> setUsername(String userName) async =>
      await _preferences.setString(SharedPrefKeys.userName, userName);

  Future<void> setStartWeight(double userStartWeight) async =>
      await _preferences.setDouble(
          SharedPrefKeys.userStartWeight, userStartWeight);

  Future<void> setStartWeightDate(String userStartWeightDate) async =>
      await _preferences.setString(
          SharedPrefKeys.userStartWeightDate, userStartWeightDate);

  Future<void> setTargetWeight(double userTargetWeight) async =>
      await _preferences.setDouble(
          SharedPrefKeys.userTargetWeight, userTargetWeight);

  Future<void> setTargetWeightDate(String userTargetWeightDate) async =>
      await _preferences.setString(
          SharedPrefKeys.userTargetWeightDate, userTargetWeightDate);

  Future<void> setThemeDarkMode(bool themeMode) async =>
      await _preferences.setBool(SharedPrefKeys.themeDarkMode, themeMode);

  Future<void> setWeightUnitType(String weightUnitType) async =>
      await _preferences.setString(
          SharedPrefKeys.weightUnitType, weightUnitType);

  Future<void> setReminderStatus(bool reminderStatus) async =>
      await _preferences.setBool(SharedPrefKeys.reminderStatus, reminderStatus);

  bool get getOnBoardingSeenBefore =>
      _preferences.getBool(SharedPrefKeys.onBoardingSeenBefore);

  String get getUsername => _preferences.getString(SharedPrefKeys.userName);

  double get getStartWeight =>
      _preferences.getDouble(SharedPrefKeys.userStartWeight);

  String get getStartWeightDate =>
      _preferences.getString(SharedPrefKeys.userStartWeightDate);

  double get getTargetWeight =>
      _preferences.getDouble(SharedPrefKeys.userTargetWeight);

  String get getTargetWeightDate =>
      _preferences.getString(SharedPrefKeys.userTargetWeightDate);

  bool get getThemeDarkMode =>
      _preferences.getBool(SharedPrefKeys.themeDarkMode);

  String get getWeightUnitType =>
      _preferences.getString(SharedPrefKeys.weightUnitType);

  bool get getReminderStatus =>
      _preferences.getBool(SharedPrefKeys.reminderStatus);
}
