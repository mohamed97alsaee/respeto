import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:respeto/helpers/consts.dart';
import 'package:respeto/main.dart';
import 'package:respeto/providers/dark_theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
        builder: (context, darkThemeConsumer, child) {
      return Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        darkThemeConsumer.switchMode();
                      },
                      title: Text(darkThemeConsumer.isDark
                          ? AppLocalizations.of(context)!.lightMode
                          : AppLocalizations.of(context)!.darkMode),
                      trailing: Icon(
                        darkThemeConsumer.isDark
                            ? FontAwesomeIcons.sun
                            : FontAwesomeIcons.moon,
                        color: darkThemeConsumer.isDark
                            ? lightWihteColor
                            : blackTextColor,
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        MyApp.setLocale(
                            context,
                            AppLocalizations.of(context)!.localeName == 'en'
                                ? Locale('ar')
                                : Locale('en'));
                      },
                      title: Text(AppLocalizations.of(context)!.language),
                      trailing: Icon(
                        FontAwesomeIcons.language,
                        color: darkThemeConsumer.isDark
                            ? lightWihteColor
                            : blackTextColor,
                      ),
                    ),
                    Divider(),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
