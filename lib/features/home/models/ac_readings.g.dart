// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ac_readings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ACReadings _$ACReadingsFromJson(Map<String, dynamic> json) => ACReadings(
      phase1: json['phase1'] == null
          ? null
          : ACPhase.fromJson((json['phase1'] as Map<String, dynamic>).map(
              (k, e) => MapEntry(k, e as Object),
            )),
      phase2: json['phase2'] == null
          ? null
          : ACPhase.fromJson((json['phase2'] as Map<String, dynamic>).map(
              (k, e) => MapEntry(k, e as Object),
            )),
      phase3: json['phase3'] == null
          ? null
          : ACPhase.fromJson((json['phase3'] as Map<String, dynamic>).map(
              (k, e) => MapEntry(k, e as Object),
            )),
      status: (json['status'] as num?)?.toDouble(),
      ledState: json['ledstate'] as int?,
      temperature: (json['temperature'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ACReadingsToJson(ACReadings instance) =>
    <String, dynamic>{
      'phase1': instance.phase1?.toJson(),
      'phase2': instance.phase2?.toJson(),
      'phase3': instance.phase3?.toJson(),
      'status': instance.status,
      'temperature': instance.temperature,
      'ledstate': instance.ledState,
    };

ACPhase _$ACPhaseFromJson(Map<String, dynamic> json) => ACPhase(
      current: (json['current'] as num?)?.toDouble(),
      frequency: (json['frequency'] as num?)?.toDouble(),
      power: (json['power'] as num?)?.toDouble(),
      powerFactor: (json['powerfactor'] as num?)?.toDouble(),
      voltage: (json['voltage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ACPhaseToJson(ACPhase instance) => <String, dynamic>{
      'current': instance.current,
      'frequency': instance.frequency,
      'power': instance.power,
      'powerfactor': instance.powerFactor,
      'voltage': instance.voltage,
    };
