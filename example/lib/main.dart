import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multiple_localization/multiple_localization.dart';
import './app/l10n/messages_all.dart';
import './package/l10n/messages_all.dart' as package;

void main() {
  runApp(
    const MaterialApp(
      supportedLocales: [Locale('en')],
      localizationsDelegates: [
        AppLocalizations.delegate,
        PackageLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      home: HomeScreen(),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context);
    final packageLocalization = PackageLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalization.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            children: [
              Text(appLocalization.messageFromApp),
              Text(packageLocalization.messageFromPackage),
              Text(packageLocalization.messageFromPackageForOverride),
            ],
          ),
        ),
      ),
    );
  }
}

// Application localization

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return MultipleLocalizations.load(
      initializeMessages,
      locale,
      AppLocalizations.new,
      setDefaultLocale: true,
    );
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}

/// App localization.
class AppLocalizations {
  /// Delegate.
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  final String locale;

  AppLocalizations(this.locale);

  String get title => Intl.message('Multiple localization', name: 'title');

  String get messageFromApp =>
      Intl.message('Default Message from App', name: 'messageFromApp');

  String get messageFromPackageForOverride => Intl.message(
        'This translation override package translation',
        name: 'messageFromPackageForOverride',
      );
}

// Other localization, for example from package

class _PackageLocalizationsDelegate
    extends LocalizationsDelegate<PackageLocalizations> {
  const _PackageLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en'].contains(locale.languageCode);

  @override
  Future<PackageLocalizations> load(Locale locale) {
    return MultipleLocalizations.load(
      package.initializeMessages,
      locale,
      PackageLocalizations.new,
    );
  }

  @override
  bool shouldReload(LocalizationsDelegate<PackageLocalizations> old) => false;
}

/// Package localization.
class PackageLocalizations {
  /// Delegate.
  static const LocalizationsDelegate<PackageLocalizations> delegate =
      _PackageLocalizationsDelegate();

  static PackageLocalizations of(BuildContext context) =>
      Localizations.of<PackageLocalizations>(context, PackageLocalizations)!;

  final String locale;

  PackageLocalizations(this.locale);

  String get messageFromPackage =>
      Intl.message('Default Message from Package', name: 'messageFromPackage');

  String get messageFromPackageForOverride => Intl.message(
        'Default Message from Package for override',
        name: 'messageFromPackageForOverride',
      );
}
