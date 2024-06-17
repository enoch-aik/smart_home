import 'dart:convert';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smart_home/features/auth/providers/providers.dart';
import 'package:smart_home/features/home/models/ac_readings.dart';
import 'package:smart_home/features/home/models/dc_readings.dart';
import 'package:smart_home/features/home/providers/database.dart';
import 'package:smart_home/features/home/providers/location.dart';
import 'package:smart_home/features/home/providers/weather.dart';
import 'package:smart_home/features/home/screens/components/ac_info_card.dart';
import 'package:smart_home/features/home/screens/components/dc_info_card.dart';
import 'package:smart_home/features/home/screens/components/weather_details.dart';
import 'package:smart_home/features/home/screens/components/weather_icon.dart';
import 'package:smart_home/lib.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //app theme
    final theme = Theme.of(context);

    //data streams for AC and DC
    final dcStream = ref.watch(dcStreamProvider('dc'));
    final acStream = ref.watch(acStreamProvider('AC'));

    //current user
    final currentUser = ref.watch(currentUserProvider);
    //final Map<String, dynamic>? currentUserDetails = ref.watch(userDetailsProvider);

    ValueNotifier<bool> dcOn = useState(false);
    ValueNotifier<bool> acOn = useState(false);
    //current location
    final location = ref.watch(locationFProvider);
    if (ref.read(allowedLocationProvider.notifier).state == true) {
      location.when(
          data: (data) => null, error: (e, _) => null, loading: () => null);
    }

    //current weather
    final weather = ref.watch(weatherFProvider);
    return Scaffold(
      appBar: (currentUser?.displayName != null &&
              currentUser!.displayName!.isNotEmpty)
          ? AppBar(
              centerTitle: false,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KText(
                    'Hello!',
                    fontWeight: FontWeight.w500,
                    fontSize: 22.sp,
                  ),
                  KText(currentUser.displayName ?? ''),
                ],
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Initicon(
                    text: currentUser.displayName!,
                    backgroundColor: theme.colorScheme.primary,
                  ),
                )
              ],
            )
          : AppBar(),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          children: [
            SizedBox(
              height: 16.h,
            ),
            weather.when(
              data: (data) {
                return SizedBox(
                  // height: 160.h,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                          color: theme.colorScheme.primary, width: 0.1),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              KText(
                                'Today:  ',
                                fontWeight: FontWeight.w400,
                                fontSize: 19.sp,
                                color: Colors.white,
                              ),
                              KText(
                                DateFormat()
                                    .add_yMMMMEEEEd()
                                    .format(DateTime.now()),
                                fontSize: 19.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              )
                            ],
                          ),
                          Row(
                            children: [
                              WeatherIconImage(
                                iconPath: data.details.first.icon,
                                x2Size: true,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Column(
                                children: [
                                  Text(
                                    data.details.first.weatherShortDescription,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                  KText(
                                    data.name ?? '',
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              KText(
                                '${data.temperature.currentTemperature}°C',
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              WeatherDetails(
                                  title: 'Humidity',
                                  body: '${data.temperature.humidity}%'),
                              WeatherDetails(
                                  title: 'Wind',
                                  body: data.wind.speed.toString()),
                              WeatherDetails(
                                  title: 'Feels like',
                                  body: '${data.temperature.feelsLike}°C'),
                              WeatherDetails(
                                  title: 'Pressure',
                                  body: '${data.temperature.pressure} hpa'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              error: (e, _) {
                return const SizedBox();
              },
              loading: () => const SizedBox(),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dcStream.when(
                  data: (data) {
                    Object? values = data.snapshot.value;
                    Map<String, dynamic> decodedValue =
                        jsonDecode(jsonEncode(values));
                    DCReadings readings = DCReadings.fromJson(decodedValue);
                    dcOn.value = readings.ledState == 1 ? true : false;
                    return DCReadingsInfoCard(
                      dcOn: dcOn,
                      dcReadings: readings,
                    );
                  },
                  error: (e, _) => SizedBox(
                    height: 215.h,
                    width: 165.w,
                  ),
                  loading: () => SizedBox(
                    height: 215.h,
                    width: 165.w,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                acStream.when(
                  data: (data) {
                    Object? values = data.snapshot.value;
                    Map<String, dynamic> decodedValue =
                        jsonDecode(jsonEncode(values));
                    ACReadings readings = ACReadings.fromJson(decodedValue);
                    acOn.value = readings.ledState == 1 ? true : false;

                    return ACReadingsInfoCard(
                      acOn: acOn,
                      acReadings: readings,
                    );
                  },
                  error: (e, _) => SizedBox(
                    height: 215.h,
                    width: 165.w,
                  ),
                  loading: () => SizedBox(
                    height: 215.h,
                    width: 165.w,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
