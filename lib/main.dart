import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:respeto/firebase_options.dart';
import 'package:respeto/providers/dark_theme_provider.dart';
import 'package:respeto/providers/places_provider.dart';
import 'package:respeto/screens/intro_screens/splash_screen.dart';
import './screens/intro_screens/intro_screen.dart';
import './screens/main_screens/home_screen.dart';
import './screens/sub_screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:respeto/helpers/consts.dart';
import 'package:respeto/helpers/functions_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:respeto/l10n/generated/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('ar');

  Future<void> setLocale(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _locale = locale;
    });
    prefs.setString("langCode", locale.languageCode.toString());
  }

  getLocalLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? localCode = prefs.getString('langCode');
    if (localCode == 'en') {
      setState(() {
        _locale = const Locale('en');
        setLocale(const Locale('en'));
      });
    } else {
      setState(() {
        _locale = const Locale('ar');
        setLocale(const Locale('ar'));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DarkThemeProvider()),
        ChangeNotifierProvider(create: (context) => PlacesProvider()),
      ],
      child: Consumer<DarkThemeProvider>(
          builder: (context, darkThemeConsumer, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale(
              'en',
            ),
            Locale(
              'ar',
            ),
          ],
          locale: _locale,
          title: 'Carrot',
          theme: ThemeData(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            useMaterial3: false,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: darkThemeConsumer.isDark
                  ? withOpacity(blackTextColor, 0.5)
                  : lightWihteColor,
            ),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: darkThemeConsumer.isDark
                    ? withOpacity(blackTextColor, 0.5)
                    : lightWihteColor,
                statusBarBrightness: darkThemeConsumer.isDark
                    ? Brightness.dark
                    : Brightness.light,
              ),
              titleTextStyle: GoogleFonts.tajawal(
                  color: darkThemeConsumer.isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              backgroundColor: darkThemeConsumer.isDark
                  ? withOpacity(blackTextColor, 0.5)
                  : lightWihteColor,
              centerTitle: true,
              elevation: 0,
              iconTheme: IconThemeData(
                  color:
                      darkThemeConsumer.isDark ? Colors.white : Colors.black),
            ),
            primaryColor: primaryColor,
            scaffoldBackgroundColor: darkThemeConsumer.isDark
                ? withOpacity(secondaryColor, 0.1)
                : lightWihteColor,
            textTheme: GoogleFonts.tajawalTextTheme(
              Theme.of(context).textTheme.apply(
                    bodyColor: darkThemeConsumer.isDark
                        ? lightWihteColor
                        : blackTextColor,
                    displayColor: darkThemeConsumer.isDark
                        ? lightWihteColor
                        : blackTextColor,
                  ),
            ),
            drawerTheme: DrawerThemeData(
              elevation: 0,
              backgroundColor:
                  darkThemeConsumer.isDark ? blackTextColor : lightWihteColor,
            ),
            listTileTheme: ListTileThemeData(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            dividerTheme: DividerThemeData(
              thickness: 0.5,
              color: darkThemeConsumer.isDark
                  ? withOpacity(lightWihteColor, 0.5)
                  : withOpacity(blackTextColor, 0.5),
            ),
            scrollbarTheme: ScrollbarThemeData(
              thickness: WidgetStateProperty.all<double>(10),
              trackVisibility: WidgetStateProperty.all<bool>(true),
            ).copyWith(
              thumbColor: WidgetStateProperty.all(lightWihteColor),
              trackColor:
                  WidgetStateProperty.all(withOpacity(blackTextColor, 0.2)),
            ),
            tabBarTheme: TabBarThemeData(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                labelStyle: GoogleFonts.almarai(),
                unselectedLabelStyle: GoogleFonts.almarai(),
                indicator: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                indicatorSize: TabBarIndicatorSize.tab),
            progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: primaryColor,
            ),
            inputDecorationTheme: InputDecorationTheme(
              fillColor: darkThemeConsumer.isDark
                  ? withOpacity(blackTextColor, 0.5)
                  : withOpacity(lightWihteColor, 0.1),
              filled: true,
              isDense: false,
              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: withOpacity(primaryColor, 0.2),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: withOpacity(primaryColor, 0.5),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: withOpacity(primaryColor, 0.2),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: withOpacity(blackTextColor, 0.5),
              ),
              errorStyle: const TextStyle(
                fontSize: 9,
                color: Colors.red,
              ),
            ),
            checkboxTheme: CheckboxThemeData(
              fillColor: WidgetStateProperty.all(primaryColor),
              checkColor: WidgetStateProperty.all(darkThemeConsumer.isDark
                  ? withOpacity(blackTextColor, 0.5)
                  : lightWihteColor),
              overlayColor: WidgetStateProperty.all(primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  color: darkThemeConsumer.isDark
                      ? withOpacity(blackTextColor, 0.5)
                      : lightWihteColor,
                  width: 1,
                ),
              ),
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: primaryColor,
              unselectedItemColor: darkThemeConsumer.isDark
                  ? lightWihteColor
                  : withOpacity(blackTextColor, 0.5),
              backgroundColor: darkThemeConsumer.isDark
                  ? withOpacity(blackTextColor, 0.5)
                  : withOpacity(blackTextColor, 0.1),
              selectedLabelStyle: const TextStyle(
                  color: primaryColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
              unselectedLabelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
              showUnselectedLabels: true,
              elevation: 0,
            ),
          ),
          home: SplashScreen(),
        );
      }),
    );
  }
}

class ScreenRouter extends StatefulWidget {
  const ScreenRouter({super.key});

  @override
  State<ScreenRouter> createState() => _ScreenRouterState();
}

class _ScreenRouterState extends State<ScreenRouter> {
  bool? firstLaunch;
  bool checking = true;
  @override
  initState() {
    getFirst();

    super.initState();
    getFirst();
  }

  getFirst() async {
    firstLaunch = await getBoolFromPrefs('firstLaunch').then((value) {
      setState(() {
        checking = false;
      });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: animationDuration,
      child: checking == true
          ? const LoadingScreen()
          : firstLaunch == true || firstLaunch == null
              ? const IntroScreen()
              : const HomeScreen(),
    );
  }
}
