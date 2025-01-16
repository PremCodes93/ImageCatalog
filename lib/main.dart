import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_listing_app/presentation/app.dart';

import 'core/injection/environment_config.dart';
import 'core/injection/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final GetIt locator = GetIt.instance;
  await configureInjection(locator);
  await ConfigureEnvironment.configureEndpoints();
  runApp(const MyApp());
}
