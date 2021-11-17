import 'package:dalotee/presentation/bottom_navigation/bottom_navigation.dart';
import 'package:dalotee/presentation/pages/daily/daily_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dalotee/bloc/locale/locale_state.dart';
import 'package:dalotee/configs/routes.dart';
import 'package:dalotee/configs/service_locator.dart';
import 'package:dalotee/generated/assets/fonts.gen.dart';
import 'package:dalotee/presentation/widgets/base/app_configs_widgets.dart';
import 'package:dalotee/values/colors.dart';

import 'bloc/app/app_bloc.dart';
import 'bloc/locale/locale_bloc.dart';
import 'configs/flavor.dart';
import 'generated/localization/l10n.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppBloc()),
        BlocProvider(create: (context) => LocaleBloc(locator.get())),
      ],
      child: BlocBuilder<LocaleBloc, LocaleState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            return MaterialApp(
              title: 'dalotee',
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              theme: _buildThemeData(context),
              builder: EasyLoading.init(),
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale?.languageCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: state.locale,
              onGenerateRoute: Routes.generateRoute,
              home: BottomNavigation(),
            );
          }),
    );
  }

  ThemeData _buildThemeData(BuildContext context) {
    return ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: FontFamily.poppins,
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: AppColor.colorTextNormal,
            fontFamily: FontFamily.poppins),
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ));
  }

  // static void initSystemTheme() {
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
  //       .copyWith(statusBarColor: Colors.transparent));
  // }

  static Future<void> appRunner(FlavorConfig flavorConfig) async {
    // Ready to call native code
    WidgetsFlutterBinding.ensureInitialized();

    // System overlay
    // MyApp.initSystemTheme();

    // IoC
    await setupServiceLocator();

    return runApp(AppConfigWidget(
      flavorConfig: flavorConfig,
      child: MyApp(),
    ));
  }
}
