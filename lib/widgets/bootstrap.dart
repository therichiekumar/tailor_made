import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:injector/injector.dart';
import 'package:tailor_made/environments/environment.dart';
import 'package:tailor_made/services/_api/stats.dart';
import 'package:tailor_made/services/_mocks/stats.dart';
import 'package:tailor_made/services/stats.dart';
import 'package:tailor_made/utils/mk_settings.dart';

Future<BootstrapModel> bootstrap(Environment env) async {
  MkSettings.environment = env;

  Injector.appInstance
    ..registerSingleton<Stats>(
      (_) => MkSettings.isMock ? StatsMockImpl() : StatsImpl(),
    );

  final isFirstTime = await MkSettings.checkIsFirstTimeLogin();

  try {
    await MkSettings.initVersion();
  } catch (e) {
    //
  }

  return BootstrapModel(
    isFirstTime: isFirstTime,
  );
}

class BootstrapModel {
  const BootstrapModel({
    @required this.isFirstTime,
  });

  final bool isFirstTime;
}