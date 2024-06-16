import 'package:json_annotation/json_annotation.dart';
part 'hotel.g.dart';

@JsonSerializable()
class Hotel {
  String hotelId;
  List<String> amenities;
  List<String> comment;
  String description;
  String hotelName;
  List<String> imageUrl;
  double price;
  List<int> rating;
  List<int> spaceRooms;
  String location;

  Hotel({
    required this.hotelId,
    required this.location,
    required this.amenities,
    required this.comment,
    required this.description,
    required this.hotelName,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.spaceRooms,
  });

  static Hotel fromJson(Map<String, dynamic> json) {
    return _$HotelFromJson(json);
  }

  toJson() {
    return _$HotelToJson(this);
  }
}