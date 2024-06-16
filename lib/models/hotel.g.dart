// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hotel _$HotelFromJson(Map<String, dynamic> json) => Hotel(
      hotelId: json['hotelId'] as String,
      location: json['location'] as String,
      amenities:
          (json['amenities'] as List<dynamic>).map((e) => e as String).toList(),
      comment:
          (json['comment'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String,
      hotelName: json['hotelName'] as String,
      imageUrl:
          (json['imageUrl'] as List<dynamic>).map((e) => e as String).toList(),
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      spaceRooms: (json['spaceRooms'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$HotelToJson(Hotel instance) => <String, dynamic>{
      'hotelId': instance.hotelId,
      'amenities': instance.amenities,
      'comment': instance.comment,
      'description': instance.description,
      'hotelName': instance.hotelName,
      'imageUrl': instance.imageUrl,
      'price': instance.price,
      'rating': instance.rating,
      'spaceRooms': instance.spaceRooms,
      'location': instance.location,
    };
