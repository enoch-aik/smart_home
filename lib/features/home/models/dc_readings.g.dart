// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dc_readings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DCReadings _$DCReadingsFromJson(Map<String, dynamic> json) => DCReadings(
      current: (json['Current'] as num?)?.toDouble(),
      voltage: (json['Voltage'] as num?)?.toDouble(),
      ledState: json['ledstate'] as int?,
      status: (json['status'] as num?)?.toDouble(),
      temperature: (json['temperature'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DCReadingsToJson(DCReadings instance) =>
    <String, dynamic>{
      'Current': instance.current,
      'Voltage': instance.voltage,
      'ledstate': instance.ledState,
      'status': instance.status,
      'temperature': instance.temperature,
    };
