import 'package:flutter/material.dart';
import 'package:flutter_template/app/app_exports.dart'
    show Config, GlobalErrorLogger, MainApp, secureStorageProvider;
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the configuration
  await Config().init();

  runApp(
    ProviderScope(
      overrides: [
        secureStorageProvider.overrideWithValue(Config().secureStorage),
      ],
      observers: [GlobalErrorLogger()],
      child: const MainApp(),
    ),
  );
}
