import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:respeto/helpers/consts.dart';
import 'package:respeto/main.dart';
import 'package:respeto/widgets/clickables/main_button.dart';
import '../../providers/dark_theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SingleIntroScreen extends StatelessWidget {
  const SingleIntroScreen({
    Key? key,
    required this.title,
    required this.icon,
    required this.description,
  }) : super(key: key);
  final String title;
  final String description;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);

    return Center(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: themeListener.isDark
                        ? lightWihteColor
                        : Colors.black87),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: themeListener.isDark
                        ? lightWihteColor
                        : Colors.black87),
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Icon(
              icon,
              color: themeListener.isDark
                  ? lightWihteColor.withOpacity(0.7)
                  : blackTextColor.withOpacity(0.7),
              size: size.width * 0.2,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            icon == FontAwesomeIcons.language
                ? MainButton(
                    text: AppLocalizations.of(context)!.language,
                    onPressed: () {
                      MyApp.setLocale(
                          context,
                          Locale(
                              AppLocalizations.of(context)!.localeName == 'en'
                                  ? 'ar'
                                  : 'en'));
                    })
                : icon == FontAwesomeIcons.moon
                    ? MainButton(
                        text: themeListener.isDark
                            ? AppLocalizations.of(context)!.lightMode
                            : AppLocalizations.of(context)!.darkMode,
                        onPressed: () {
                          Provider.of<DarkThemeProvider>(context, listen: false)
                              .switchMode();
                        })
                    : SizedBox(),
            SizedBox(
              height: size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
