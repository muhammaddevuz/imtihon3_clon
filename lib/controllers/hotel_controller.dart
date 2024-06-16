import 'package:imtihon3_clon/models/hotel.dart';
import 'package:imtihon3_clon/services/hotel_http_services.dart';

class HotelController {
  HotelHttpServices authHttpServices = HotelHttpServices();
  Future<List<Hotel>> getHotels() async {
    return authHttpServices.getHotels();
  }
}
