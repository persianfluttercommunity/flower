import 'dart:ui';

import 'package:flower/flower.dart';
import 'package:flower/flower_interface.dart';

// import '../../../get_core/get_core.dart';

class _IntlHost {
  Locale? locale;

  Locale? fallbackLocale;

  Map<String, Map<String, String>> translations = {};
}

extension FirstWhereExt<T> on List<T> {
  /// The first element satisfying [test], or `null` if there are none.
  T? firstWhereOrNull(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

extension LocalesIntl on FlowerInterface {
  static final _intlHost = _IntlHost();

  Locale? get locale => _intlHost.locale;

  Locale? get fallbackLocale => _intlHost.fallbackLocale;

  set locale(Locale? newLocale) => _intlHost.locale = newLocale;

  set fallbackLocale(Locale? newLocale) => _intlHost.fallbackLocale = newLocale;

  Map<String, Map<String, String>> get translations => _intlHost.translations;

  void addTranslations(Map<String, Map<String, String>> tr) {
    translations.addAll(tr);
  }

  void clearTranslations() {
    translations.clear();
  }

  void appendTranslations(Map<String, Map<String, String>> tr) {
    tr.forEach((key, map) {
      if (translations.containsKey(key)) {
        translations[key]!.addAll(map);
      } else {
        translations[key] = map;
      }
    });
  }
}

extension Trans on String {
  // Checks whether the language code and country code are present, and
  // whether the key is also present.
  bool get _fullLocaleAndKey {
    return Flower.translations.containsKey(
            "${Flower.locale!.languageCode}_${Flower.locale!.countryCode}") &&
        Flower.translations[
                "${Flower.locale!.languageCode}_${Flower.locale!.countryCode}"]!
            .containsKey(this);
  }

  // Checks if there is a callback language in the absence of the specific
  // country, and if it contains that key.
  Map<String, String>? get _getSimilarLanguageTranslation {
    final translationsWithNoCountry = Flower.translations
        .map((key, value) => MapEntry(key.split("_").first, value));
    final containsKey = translationsWithNoCountry
        .containsKey(Flower.locale!.languageCode.split("_").first);

    if (!containsKey) {
      return null;
    }

    return translationsWithNoCountry[
        Flower.locale!.languageCode.split("_").first];
  }

  String get tr {
    // print('language');
    // print(Flower.locale!.languageCode);
    // print('contains');
    // print(Flower.translations.containsKey(Flower.locale!.languageCode));
    // print(Flower.translations.keys);
    // Returns the key if locale is null.
    if (Flower.locale?.languageCode == null) return this;

    if (_fullLocaleAndKey) {
      return Flower.translations[
              "${Flower.locale!.languageCode}_${Flower.locale!.countryCode}"]![
          this]!;
    }
    final similarTranslation = _getSimilarLanguageTranslation;
    if (similarTranslation != null && similarTranslation.containsKey(this)) {
      return similarTranslation[this]!;
      // If there is no corresponding language or corresponding key, return
      // the key.
    } else if (Flower.fallbackLocale != null) {
      final fallback = Flower.fallbackLocale!;
      final key = "${fallback.languageCode}_${fallback.countryCode}";

      if (Flower.translations.containsKey(key) &&
          Flower.translations[key]!.containsKey(this)) {
        return Flower.translations[key]![this]!;
      }
      if (Flower.translations.containsKey(fallback.languageCode) &&
          Flower.translations[fallback.languageCode]!.containsKey(this)) {
        return Flower.translations[fallback.languageCode]![this]!;
      }
      return this;
    } else {
      return this;
    }
  }

  String trArgs([List<String> args = const []]) {
    var key = tr;
    if (args.isNotEmpty) {
      for (final arg in args) {
        key = key.replaceFirst(RegExp(r'%s'), arg.toString());
      }
    }
    return key;
  }

  String trPlural([String? pluralKey, int? i, List<String> args = const []]) {
    return i == 1 ? trArgs(args) : pluralKey!.trArgs(args);
  }

  String trParams([Map<String, String> params = const {}]) {
    var trans = tr;
    if (params.isNotEmpty) {
      params.forEach((key, value) {
        trans = trans.replaceAll('@$key', value);
      });
    }
    return trans;
  }

  String trPluralParams(
      [String? pluralKey, int? i, Map<String, String> params = const {}]) {
    return i == 1 ? trParams(params) : pluralKey!.trParams(params);
  }
}
