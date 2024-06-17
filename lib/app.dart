import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_home/features/features.dart';
import 'package:smart_home/features/splash/screens/splash_screen.dart';
import 'package:smart_home/src/res/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: false,
          useInheritedMediaQuery: true,
          builder: (context, child) {
            return MaterialApp(
              title: 'Smart Surge Protector',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              home: const SplashScreen(),
              //home: const OnboardingScreen(),
            );
          }),
    );
  }
}
