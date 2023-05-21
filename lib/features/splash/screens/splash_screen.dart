import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_home/features/auth/auth.dart';
import 'package:smart_home/features/auth/providers/auth_providers.dart';
import 'package:smart_home/features/home/providers/location.dart';
import 'package:smart_home/features/home/screens/home_screen.dart';
import 'package:smart_home/src/src.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(locationProvider).requestLocationPermission();

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Image.asset(
              AppAssets.onboarding,
              filterQuality: FilterQuality.high,
            ),
          ),
          KText(
            'Smart Surge Protector',
            fontWeight: FontWeight.w700,
            fontSize: 40.sp,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.h, bottom: 32.h),
            child: KText(
              'Manage your home connection from anywhere, anytime.',
              textAlign: TextAlign.center,
              fontSize: 18.sp,
            ),
          ),
          IconButton(
              onPressed: () {
                bool hasCurrentUser = ref.read(isLoggedIn.notifier).state;
                if (hasCurrentUser) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()));
                } else {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                }
              },
              icon: Icon(Icons.arrow_circle_right_rounded, size: 85.sp)
              /* .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .fade(duration: 500.ms, begin: 0.7, end: 1)
                .scale(delay: 500.ms),*/
              )
        ],
      ),
    );
  }
}
