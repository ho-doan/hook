import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entry.g.dart';

@JsonSerializable()
class EntryModel extends Equatable {
  @JsonKey(name: 'API')
  final String? aPI;
  @JsonKey(name: 'Description')
  final String? description;
  @JsonKey(name: 'Auth')
  final String? auth;
  @JsonKey(name: 'HTTPS')
  final bool? hTTPS;
  @JsonKey(name: 'Cors')
  final String? cors;
  @JsonKey(name: 'Link')
  final String? link;
  @JsonKey(name: 'Category')
  final String? category;

  const EntryModel({
    this.aPI,
    this.description,
    this.auth,
    this.hTTPS,
    this.cors,
    this.link,
    this.category,
  });

  factory EntryModel.fromJson(Map<String, dynamic> json) =>
      _$EntryModelFromJson(json);

  Map<String, dynamic> toJson() => _$EntryModelToJson(this);

  @override
  List<Object?> get props =>
      [aPI, description, auth, hTTPS, cors, link, category];
}
