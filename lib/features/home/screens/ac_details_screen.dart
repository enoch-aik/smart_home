import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_home/features/home/models/ac_readings.dart';
import 'package:smart_home/features/home/providers/database.dart';
import 'package:smart_home/features/home/screens/components/expansion_tile.dart';
import 'package:smart_home/lib.dart';

class ACDetailsScreen extends HookConsumerWidget {
  final ACReadings readings;

  const ACDetailsScreen({Key? key, required this.readings}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dbProvider = ref.watch(realtimeDatabaseProvider);
    final acOn = useState<bool>(readings.ledState == 1?true:false);
    return Scaffold(
      appBar: AppBar(
        title: KText(
          'AC Details',
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
                      color: readings.status! < 1 ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: KText(
                    readings.status! < 1 ? 'Faulty' : 'Healthy',
                    color: Colors.white, fontSize: 16.sp,
                    // color: readings.status! > 0 ? Colors.red : Colors.green,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const KText(
                  'Current Status:',
                  fontWeight: FontWeight.w500,
                ),
                Switch.adaptive(
                    value: acOn.value,
                    onChanged: (bool value) {
                      acOn.value = value;
                      dbProvider.setLedState(value: value ? 1 : 0, path: 'AC');
                    })
                /* KText(
                  readings.ledState ==1 ? 'ON' : 'OFF',
                  fontWeight: FontWeight.w600,
                ),*/
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const KText(
                  'Temperature:',
                  fontWeight: FontWeight.w500,
                ),

                 KText(
                  '${readings.temperature}°C',
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          KExpansionTile(title: 'Surge Protector 1', phase: readings.phase1!),
          KExpansionTile(title: 'Surge Protector 2', phase: readings.phase2!),
          KExpansionTile(title: 'Surge Protector 3', phase: readings.phase3!),
        ],
      ),
    );
  }
}
