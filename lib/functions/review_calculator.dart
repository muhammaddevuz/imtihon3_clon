import 'package:imtihon3_clon/models/hotel.dart';

class ReviewCalculator {
  Hotel hotel;

  ReviewCalculator({required this.hotel});

  get reviewCalculate {
    int sum = 0;
    for (var i in hotel.rating) {
      sum += i;
    }
    return sum / hotel.rating.length - 1;
  }
}
