// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entries.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntriesModel _$EntriesModelFromJson(Map<String, dynamic> json) => EntriesModel(
      count: json['count'] as int? ?? 0,
      entries: (json['entries'] as List<dynamic>?)
              ?.map((e) => EntryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$EntriesModelToJson(EntriesModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'entries': instance.entries,
    };
