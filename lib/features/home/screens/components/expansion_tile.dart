import 'package:smart_home/features/home/models/ac_readings.dart';
import 'package:smart_home/lib.dart';

class KExpansionTile extends StatelessWidget {
  final String title;
  final ACPhase phase;

  const KExpansionTile({Key? key, required this.title, required this.phase})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: KText(title),
        children: [
          expansionTileBody(title: 'Current', detail: '${phase.current}'),
          expansionTileBody(title: 'Voltage', detail: '${phase.voltage}v'),
          expansionTileBody(title: 'Power', detail: '${phase.power}'),
          expansionTileBody(title: 'Frequency', detail: '${phase.frequency}'),
          expansionTileBody(
              title: 'Power factor', detail: '${phase.powerFactor}'),
        ],
      ),
    );
  }
}

Widget expansionTileBody({required String title, required String detail}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        KText(
          '• $title:',
          fontSize: 18.sp,
        ),
        Flexible(
          child: KText(
            detail,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    ),
  );
}
