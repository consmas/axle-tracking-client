// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlarmImpl _$$AlarmImplFromJson(Map<String, dynamic> json) => _$AlarmImpl(
      id: json['id'] as String,
      vehicleId: json['vehicle_id'] as String,
      type: json['type'] as String,
      message: json['message'] as String,
      occurredAt: DateTime.parse(json['occurred_at'] as String),
      latitude: _numToDouble(json['latitude']),
      longitude: _numToDouble(json['longitude']),
      severity: _severityToString(json['severity']),
    );

Map<String, dynamic> _$$AlarmImplToJson(_$AlarmImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vehicle_id': instance.vehicleId,
      'type': instance.type,
      'message': instance.message,
      'occurred_at': instance.occurredAt.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'severity': instance.severity,
    };
