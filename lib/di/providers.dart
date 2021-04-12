import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mcnd_mobile/di/injector.dart';
import 'package:mcnd_mobile/ui/prayer_times/prayer_times_viewmodel.dart';
import 'package:mcnd_mobile/ui/settings/settings_viewmodel.dart';

final prayerTimesViewModelProvider = StateNotifierProvider.autoDispose<PrayerTimesViewModel>((ref) {
  return injector.get();
});

final settingsViewModelProvider = StateNotifierProvider.autoDispose<SettingsViewModel>((ref) {
  return injector.get();
});
