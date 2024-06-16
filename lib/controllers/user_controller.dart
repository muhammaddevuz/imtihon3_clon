import 'package:imtihon3_clon/models/hotel.dart';
import 'package:imtihon3_clon/models/user.dart';
import 'package:imtihon3_clon/services/user_http_services.dart';

class UserController {
  UserHttpServices userHttpServices = UserHttpServices();
  Future<void> addUser(String email, String userId) async {
    await userHttpServices.addUser(email, userId);
  }

  Future<User> getUser() async {
    User box = await userHttpServices.getUser();
    return box;
  }

  Future<List<User>> getUsers() async {
    List<User> box = await userHttpServices.getUsers();
    return box;
  }

  Future<List<Hotel>> getOrderedHotels(List orderedHoteld) async {
    List<Hotel> box = await userHttpServices.getOrderedHotels(orderedHoteld);
    return box;
  }

  Future<void> deleteOrderedHotel(
      String userId, List orderedHoteld, String hotelId) async {
    await userHttpServices.deleteOrderedHotel(userId, orderedHoteld, hotelId);
  }

  Future<void> editUser(String id, String name, String birthday) async {
    await userHttpServices.editUser(id, name, birthday);
  }

  Future<void> addComment(String comment, String hotelId) async {
    await userHttpServices.addComment(comment, hotelId);
  }

  Future<void> addOrderedHotel(String userId, List orderedHotels) async {
    await userHttpServices.addOrderedHotel(userId, orderedHotels);
  }
}
