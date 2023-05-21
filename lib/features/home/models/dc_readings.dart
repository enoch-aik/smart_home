import 'package:json_annotation/json_annotation.dart';

part 'dc_readings.g.dart';

@JsonSerializable()
class DCReadings {
  @JsonKey(name: 'Current')
  final double? current;
  @JsonKey(name: 'Voltage')
  final double? voltage;
  @JsonKey(name: 'ledstate')
  final int? ledState;
  final int? status;
  final double? temperature;

  const DCReadings(
      {this.current,
      this.voltage,
      this.ledState,
      this.status,
      this.temperature});
factory DCReadings.fromJson(Map<String,Object?> json) => _$DCReadingsFromJson(json);

Map<String,dynamic> toJson ()=> _$DCReadingsToJson(this);
}
