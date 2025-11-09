// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) =>
    Task(
        json['title'] as String,
        json['details'] as String,
        (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      )
      ..id = json['id'] as String
      ..createDate = DateTime.parse(json['createDate'] as String)
      ..status = $enumDecode(_$TaskStatusEnumMap, json['status'])
      ..lastStatusDate = DateTime.parse(json['lastStatusDate'] as String);

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'tags': instance.tags,
  'createDate': instance.createDate.toIso8601String(),
  'status': _$TaskStatusEnumMap[instance.status]!,
  'lastStatusDate': instance.lastStatusDate.toIso8601String(),
  'details': instance.details,
};

const _$TaskStatusEnumMap = {
  TaskStatus.InProgress: 'InProgress',
  TaskStatus.Completed: 'Completed',
};
