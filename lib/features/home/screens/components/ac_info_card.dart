import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_home/features/home/models/ac_readings.dart';
import 'package:smart_home/features/home/providers/database.dart';
import 'package:smart_home/features/home/screens/ac_details_screen.dart';
import 'package:smart_home/lib.dart';

class ACReadingsInfoCard extends HookConsumerWidget {
  final ACReadings? acReadings;
  final ValueNotifier<bool> acOn;

  const ACReadingsInfoCard({Key? key, this.acReadings, required this.acOn})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData currentTheme = acOn.value ? AppTheme.dark : AppTheme.light;
    final dbProvider = ref.watch(realtimeDatabaseProvider);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => ACDetailsScreen(readings: acReadings!)));
      },
      child: Theme(
        data: acOn.value ? AppTheme.dark : AppTheme.light,
        child: AnimatedContainer(
          height: 215.h,
          width: 165.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: currentTheme.colorScheme.primaryContainer),
          duration: const Duration(milliseconds: 1000),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        height: 40.h,
                        width: 40.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentTheme.colorScheme.onPrimaryContainer),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: SvgPicture.asset(
                            AppAssets.acIcon,
                            color: currentTheme.colorScheme.primaryContainer,
                          ),
                        )),
                  ),
                ),
                KText('Alternating Current',
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                    textAlign: TextAlign.left,
                    color: currentTheme.colorScheme.onPrimaryContainer),
                if (acReadings?.temperature != null)
                  KText('Temp: ${acReadings?.temperature}°C',
                      fontWeight: FontWeight.w400,
                      color: currentTheme.colorScheme.onPrimaryContainer
                      // textAlign: TextAlign.left,
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    KText(acOn.value ? 'On' : 'Off',
                        fontWeight: FontWeight.w500,
                        fontSize: 24.sp,
                        color: currentTheme.colorScheme.onPrimaryContainer),
                    Switch.adaptive(
                        value: acOn.value,
                        onChanged: (bool value) {
                          acOn.value = value;
                          dbProvider.setLedState(
                              value: value ? 1 : 0, path: 'AC');
                        })
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
