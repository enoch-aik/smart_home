import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_home/features/home/home.dart';
import 'package:smart_home/features/home/screens/dc_details_screen.dart';
import 'package:smart_home/lib.dart';

class DCReadingsInfoCard extends ConsumerWidget {
  final DCReadings? dcReadings;
  final ValueNotifier<bool> dcOn;

  const DCReadingsInfoCard({Key? key, this.dcReadings, required this.dcOn})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData currentTheme = dcOn.value ? AppTheme.dark : AppTheme.light;

    final dbProvider = ref.watch(realtimeDatabaseProvider);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => DCDetailsScreen(readings: dcReadings!)));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        height: 215.h,
        width: 165.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: currentTheme.colorScheme.primaryContainer),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                    height: 40.h,
                    width: 40.h,
                    duration: const Duration(milliseconds: 1000),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentTheme.colorScheme.onPrimaryContainer),
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: SvgPicture.asset(
                        AppAssets.dcIcon,
                        color: currentTheme.colorScheme.primaryContainer,
                      ),
                    )),
              ),
              KText('Direct Current',
                  fontWeight: FontWeight.w500,
                  fontSize: 19.sp,
                  textAlign: TextAlign.left,
                  color: currentTheme.colorScheme.onPrimaryContainer),
              if (dcReadings?.temperature != null)
                KText('Temp: ${dcReadings?.temperature}°C',
                    fontWeight: FontWeight.w400,
                    color: currentTheme.colorScheme.onPrimaryContainer
                    // textAlign: TextAlign.left,
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  KText(dcOn.value ? 'On' : 'Off',
                      fontWeight: FontWeight.w500,
                      fontSize: 24.sp,
                      color: currentTheme.colorScheme.onPrimaryContainer),
                  Switch.adaptive(
                      value: dcOn.value,
                      onChanged: (bool value) {
                        dcOn.value = value;
                        dbProvider.setLedState(value: value ? 1 : 0);
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
