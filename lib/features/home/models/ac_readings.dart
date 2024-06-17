import 'package:json_annotation/json_annotation.dart';

part 'ac_readings.g.dart';

@JsonSerializable(explicitToJson: true)
class ACReadings {
  final ACPhase? phase1;
  final ACPhase? phase2;
  final ACPhase? phase3;
  final double? status;
  final double? temperature;
  @JsonKey(name: 'ledstate')
  final int? ledState;

  const ACReadings(
      {required this.phase1,
      required this.phase2,
      required this.phase3,
      required this.status,required this.ledState,
      required this.temperature});

  factory ACReadings.fromJson(Map<String, dynamic> json) =>
      _$ACReadingsFromJson(json);

  Map<String, dynamic> toJson() => _$ACReadingsToJson(this);
}

@JsonSerializable()
class ACPhase {
  final double? current;
  final double? frequency;
  final double? power;
  @JsonKey(name: 'powerfactor')
  final double? powerFactor;
  final double? voltage;

  const ACPhase(
      {required this.current,
      required this.frequency,
      required this.power,
      required this.powerFactor,
      required this.voltage});

  factory ACPhase.fromJson(Map<String, Object> json) => _$ACPhaseFromJson(json);

  Map<String, dynamic> toJson() => _$ACPhaseToJson(this);
}
