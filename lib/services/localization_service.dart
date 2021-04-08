import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {

  AppLocalizations(this.appLocale);

  Map<String, String> _localizedStrings;
  final Locale appLocale;

  Future<bool> load() async
  {
    String jsonString = await rootBundle.loadString('assets/languages/${appLocale.languageCode}.json');

    Map<String, dynamic> jsonLanguageMap = json.decode(jsonString);
    _localizedStrings = jsonLanguageMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  String translate(String jsonkey) {
    return _localizedStrings[jsonkey];
  }
}