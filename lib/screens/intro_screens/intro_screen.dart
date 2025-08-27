import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:respeto/helpers/consts.dart';
import 'package:respeto/helpers/functions_helper.dart';
import 'package:respeto/providers/dark_theme_provider.dart';
import 'package:respeto/screens/main_screens/home_screen.dart';
import 'package:respeto/widgets/clickables/clickacble_text_widget.dart';
import 'package:respeto/widgets/static/single_intro_screen.dart';
import 'package:respeto/l10n/generated/app_localizations.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int currentIndex = 1;

  @override
  void initState() {
    getLocationPermession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(
        builder: (context, darkThemeConsumer, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text("$currentIndex/3"),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ClickableText(
                    text: AppLocalizations.of(context)!.skip,
                    color: withOpacity(blackTextColor, 0.5),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const HomeScreen()),
                          (route) => false);
                    }),
              ),
            )
          ],
        ),
        body: Center(
          child: IntroductionScreen(
            showSkipButton: false,
            showBackButton: false,
            showDoneButton: true,
            showNextButton: true,
            next: Text(AppLocalizations.of(context)!.next),
            done: Text(AppLocalizations.of(context)!.intro3title),
            doneStyle: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(primaryColor),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              foregroundColor: WidgetStateProperty.all<Color>(lightWihteColor),
            ),
            nextStyle: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(primaryColor),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              foregroundColor: WidgetStateProperty.all<Color>(lightWihteColor),
            ),
            onDone: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false);
            },
            dotsDecorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              activeColor:
                  darkThemeConsumer.isDark ? lightWihteColor : primaryColor,
              color: darkThemeConsumer.isDark
                  ? withOpacity(lightWihteColor, 0.5)
                  : withOpacity(primaryColor, 0.5),
            ),
            globalBackgroundColor: darkThemeConsumer.isDark
                ? withOpacity(blackTextColor, 0.5)
                : lightWihteColor,
            rawPages: [
              SingleIntroScreen(
                icon: FontAwesomeIcons.language,
                title: AppLocalizations.of(context)!.intro1title,
                description: AppLocalizations.of(context)!.intro1,
              ),
              SingleIntroScreen(
                icon: FontAwesomeIcons.moon,
                title: AppLocalizations.of(context)!.intro2title,
                description: AppLocalizations.of(context)!.intro2,
              ),
              SingleIntroScreen(
                icon: FontAwesomeIcons.bowlFood,
                title: AppLocalizations.of(context)!.intro3title,
                description: AppLocalizations.of(context)!.intro3,
              ),
            ],
            onChange: (index) {
              setState(() {
                currentIndex = index + 1;
              });
            },
            curve: Curves.easeInBack,
          ),
        ),
      );
    });
  }
}
