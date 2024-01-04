import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hook_ffff/home/home_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'data/remote_data_source/api_client.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cookieStoredDirectory = await getApplicationSupportDirectory();
    runApp(
      ProviderScope(
        overrides: [
          cookieStoredDirectoryProvider
              .overrideWithValue(cookieStoredDirectory.path),
        ],
        child: const MyApp(),
      ),
    );
  }, (error, stack) {
    log(error.toString());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
