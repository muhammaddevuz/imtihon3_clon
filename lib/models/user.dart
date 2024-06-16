import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  String id;
  String userId;
  String name;
  String email;
  DateTime birthday;
  @JsonKey(defaultValue: [])
  List orderedHotels;

  User({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.birthday,
    required this.orderedHotels,
  });

  static User fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  toJson() {
    return _$UserToJson(this);
  }
}
