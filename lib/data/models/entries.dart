import 'package:hook_ffff/data/models/entry.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entries.g.dart';

@JsonSerializable()
class EntriesModel {
  final int count;
  final List<EntryModel> entries;

  EntriesModel({
    this.count = 0,
    this.entries = const [],
  });

  factory EntriesModel.fromJson(Map<String, dynamic> json) =>
      _$EntriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$EntriesModelToJson(this);
}
