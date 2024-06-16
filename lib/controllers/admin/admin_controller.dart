import 'package:imtihon3_clon/services/admin_panel_http_service.dart';

import '../../models/hotel.dart';

class AdminController {
  final AdminHttpService _adminRepository = AdminHttpService();

  Future<List<Hotel>> get hotelsList async {
    return await _adminRepository.getHotels();
  }

  Future<void> addHotel({
    required List<String> amenities,
    required String hotelName,
    required String description,
    required List<String> imageUrl,
    required double price,
    required List<int> rating,
    required List<int> rooms,
    required String location,
  }) async {
    await _adminRepository.addHotel(
        amenities: amenities,
        hotelName: hotelName,
        description: description,
        imageUrl: imageUrl,
        price: price,
        rating: rating,
        rooms: rooms,
        location: location);
  }

  Future<void> deleteHotel({required String hotelId}) async {
    await _adminRepository.deleteHotel(hotelId: hotelId);
  }

  Future<void> editHotels({
    required hotelId,
    required List<String> newAmenities,
    required String newHotelName,
    required String newDescription,
    required List<String> newImageUrl,
    required double newPrice,
    required List<int> newRating,
    required List<int> newSpaceRooms,
    required String newLocation,
  }) async {
    await _adminRepository.editHotels(
      hotelId: hotelId,
      newAmenities: newAmenities,
      newHotelName: newHotelName,
      newDescription: newDescription,
      newImageUrl: newImageUrl,
      newPrice: newPrice,
      newRating: newRating,
      newSpaceRooms: newSpaceRooms,
      newLocation: newLocation,
    );
  }
}
