//
// Generated file. Do not edit.
// This file is generated from template in file `flutter_tools/lib/src/flutter_plugins.dart`.
//

// @dart = 3.10

import 'dart:io'; // flutter_ignore: dart_io_import.
import 'package:open_file_android/open_file_android.dart' as open_file_android;
import 'package:path_provider_android/path_provider_android.dart' as path_provider_android;
import 'package:open_file_ios/open_file_ios.dart' as open_file_ios;
import 'package:path_provider_foundation/path_provider_foundation.dart' as path_provider_foundation;
import 'package:open_file_linux/open_file_linux.dart' as open_file_linux;
import 'package:path_provider_linux/path_provider_linux.dart' as path_provider_linux;
import 'package:open_file_mac/open_file_mac.dart' as open_file_mac;
import 'package:path_provider_foundation/path_provider_foundation.dart' as path_provider_foundation;
import 'package:open_file_windows/open_file_windows.dart' as open_file_windows;
import 'package:path_provider_windows/path_provider_windows.dart' as path_provider_windows;

@pragma('vm:entry-point')
class _PluginRegistrant {

  @pragma('vm:entry-point')
  static void register() {
    if (Platform.isAndroid) {
      try {
        open_file_android.OpenFileAndroid.registerWith();
      } catch (err) {
        print(
          '`open_file_android` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        path_provider_android.PathProviderAndroid.registerWith();
      } catch (err) {
        print(
          '`path_provider_android` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

    } else if (Platform.isIOS) {
      try {
        open_file_ios.OpenFileIOS.registerWith();
      } catch (err) {
        print(
          '`open_file_ios` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        path_provider_foundation.PathProviderFoundation.registerWith();
      } catch (err) {
        print(
          '`path_provider_foundation` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

    } else if (Platform.isLinux) {
      try {
        open_file_linux.OpenFileLinux.registerWith();
      } catch (err) {
        print(
          '`open_file_linux` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        path_provider_linux.PathProviderLinux.registerWith();
      } catch (err) {
        print(
          '`path_provider_linux` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

    } else if (Platform.isMacOS) {
      try {
        open_file_mac.OpenFileMac.registerWith();
      } catch (err) {
        print(
          '`open_file_mac` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        path_provider_foundation.PathProviderFoundation.registerWith();
      } catch (err) {
        print(
          '`path_provider_foundation` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

    } else if (Platform.isWindows) {
      try {
        open_file_windows.OpenFileWindows.registerWith();
      } catch (err) {
        print(
          '`open_file_windows` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

      try {
        path_provider_windows.PathProviderWindows.registerWith();
      } catch (err) {
        print(
          '`path_provider_windows` threw an error: $err. '
          'The app may not function as expected until you remove this plugin from pubspec.yaml'
        );
      }

    }
  }
}
