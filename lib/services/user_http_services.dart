import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imtihon3_clon/models/hotel.dart';
import 'package:imtihon3_clon/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHttpServices {
  Future<User> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Uri url =
        Uri.parse("https://imtihon3-default-rtdb.firebaseio.com/users.json");
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<User> loadedTodos = [];
    if (data != null) {
      data.forEach((key, value) {
        if (value["userId"] == sharedPreferences.getString("userId")) {
          value['id'] = key;
          loadedTodos.add(User.fromJson(value));
        }
      });
    }
    return loadedTodos[0];
  }

  Future<List<User>> getUsers() async {
    Uri url =
        Uri.parse("https://imtihon3-default-rtdb.firebaseio.com/users.json");
    final response = await http.get(url);
    final Map<String, dynamic> data = jsonDecode(response.body);
    List<User> loadedUsers = [];
    data.forEach((key, value) {
      value['id'] = key;
      loadedUsers.add(User.fromJson(value));
    });
    return loadedUsers;
  }

  Future<List<Hotel>> getOrderedHotels(List orderedHotel) async {
    Uri urlHotels =
        Uri.parse("https://imtihon3-default-rtdb.firebaseio.com/hotels.json");
    List<Hotel> orderedHotels = [];
    final responseHotels = await http.get(urlHotels);

    final Map<String, dynamic> dataHotels = json.decode(responseHotels.body);

    for (var element in orderedHotel) {
      dataHotels.forEach((key, value) {
        if (element == key) {
          value['hotelId'] = key;
          orderedHotels.add(Hotel.fromJson(value));
        }
      });
    }
    return orderedHotels;
  }

  Future<void> addUser(String email, String userId) async {
    Uri url =
        Uri.parse("https://imtihon3-default-rtdb.firebaseio.com/users.json");

    Map<String, dynamic> user = {
      "userId": userId,
      "name": "",
      "email": email,
      "birthday": DateTime.now().toString(),
      "orderedHotels": [
        "aa",
      ],
    };
    await http.post(
      url,
      body: jsonEncode(user),
    );
  }

  Future<void> editUser(String id, String newnNme, String newBirthday) async {
    Uri url = Uri.parse(
        "https://imtihon3-default-rtdb.firebaseio.com/users/$id.json");

    Map<String, dynamic> todoData = {
      "name": newnNme,
      "birthday": newBirthday,
    };
    await http.patch(
      url,
      body: jsonEncode(todoData),
    );
  }

  Future<void> deleteOrderedHotel(
      String userId, List orderedHotel, String hotelId) async {
    Uri editUrl = Uri.parse(
        "https://imtihon3-default-rtdb.firebaseio.com/users/$userId.json");
    Uri urlHotels =
        Uri.parse("https://imtihon3-default-rtdb.firebaseio.com/hotels.json");
    List<Hotel> orderedHotels = [];
    final responseHotels = await http.get(urlHotels);

    final Map<String, dynamic> dataHotels = json.decode(responseHotels.body);

    for (var element in orderedHotel) {
      dataHotels.forEach((key, value) {
        if (element == key) {
          value['hotelId'] = key;
          orderedHotels.add(Hotel.fromJson(value));
        }
      });
    }
    for (var i = 0; i < orderedHotels.length; i++) {
      if (orderedHotels[i].hotelId == hotelId) {
        orderedHotels.removeAt(i);
        break;
      }
    }
    List<String> hotelIdBox = [];
    for (var i = 0; i < orderedHotels.length; i++) {
      hotelIdBox.add(orderedHotels[i].hotelId);
    }
    await http.patch(
      editUrl,
      body: jsonEncode({"orderedHotels": hotelIdBox}),
    );
  }

  Future<void> addComment(String comment, String hotelId) async {
    Uri url = Uri.parse(
        "https://imtihon3-default-rtdb.firebaseio.com/hotels/-O-QX_D36lkvOM08Szui/comment.json");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> comments = jsonDecode(response.body) ?? [];
      comments.add(comment);
      await http.put(url, body: jsonEncode(comments));
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<void> addOrderedHotel(String userId, List orderedHotels) async {
    Uri url = Uri.parse(
        "https://imtihon3-default-rtdb.firebaseio.com/users/$userId.json");

    http.patch(url, body: jsonEncode({"orderedHotels": orderedHotels}));
  }
}
