import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_home/features/home/models/dc_readings.dart';
import 'package:smart_home/features/home/providers/database.dart';
import 'package:smart_home/lib.dart';

class DCDetailsScreen extends HookConsumerWidget {
  final DCReadings readings;

  const DCDetailsScreen({Key? key, required this.readings}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dbProvider = ref.watch(realtimeDatabaseProvider);
    final dcOn = useState<bool>(false);
    return Scaffold(
      appBar: AppBar(
        title: KText(
          'DC Details',
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const KText(
                  'Current Condition:',
                  fontWeight: FontWeight.w500,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                  decoration: BoxDecoration(
                      color: readings.status! > 0 ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: KText(
                    readings.status! > 0 ? 'Faulty' : 'Healthy',
                    color: Colors.white, fontSize: 16.sp,
                    // color: readings.status! > 0 ? Colors.red : Colors.green,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const KText(
                'Current Status:',
                fontWeight: FontWeight.w500,
              ),
              Switch.adaptive(
                  value: dcOn.value,
                  onChanged: (bool value) {
                    dcOn.value = value;
                    dbProvider.setStatus(
                      value: value ? 1 : 0,
                    );
                  })
              /* KText(
                readings.ledState ==1 ? 'ON' : 'OFF',
                fontWeight: FontWeight.w600,
              ),*/
            ],
          ),
          detailTile(title: 'Current', details: '${readings.current}'),
          detailTile(title: 'Voltage', details: '${readings.voltage}v'),
          detailTile(
              title: 'Temperature', details: '${readings.temperature}°C'),
        ],
      ),
    );
  }
}

Widget detailTile({required String title, required String details}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 12.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        KText(
          '$title:',
          fontWeight: FontWeight.w500,
        ),
        KText(
          details,
          fontWeight: FontWeight.w600,
        ),
      ],
    ),
  );
}
