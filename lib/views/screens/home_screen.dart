import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtihon3_clon/controllers/hotel_controller.dart';
import 'package:imtihon3_clon/controllers/user_controller.dart';
import 'package:imtihon3_clon/functions/review_calculator.dart';
import 'package:imtihon3_clon/models/hotel.dart';
import 'package:imtihon3_clon/views/screens/hotel_info_screen.dart';
import 'package:imtihon3_clon/views/screens/profile_screen.dart';
import 'package:imtihon3_clon/views/widgets/search_view_delegate.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';


class HomeScreen extends StatefulWidget {
  final ValueChanged<void> themChanged;

  const HomeScreen({super.key, required this.themChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HotelController hotelController = HotelController();
  UserController userController = UserController();
  List<Hotel> hotelList = [];
  List<Hotel> filteredHotelList = [];
  bool isDataCame = false;
  bool flag = true;
  String selectedFilter = 'Rating';

  double averageRating(List<int> ratings){
    var sum = 0;
    for(var rating in ratings){
      sum += rating;
    }
    return sum/ratings.length;
  }
  
  @override
  void initState() {
    super.initState();
    getHotels();
  }

  void isScroll() {
    setState(() {
      flag = !flag;
    });
  }

  Future<void> getHotels() async {
    hotelList = await hotelController.getHotels();
    filteredHotelList = List.from(hotelList);
    isDataCame = true;
    setState(() {});
  }

  Future<void> getUser() async {
    await userController.getUser();
  }

  void showAllHotels() async {
    filteredHotelList = await hotelController.getHotels();
    setState(() {});
  }

  void filterHotels(String filter) {
    setState(() {
      if (filter == 'Rating') {
        filteredHotelList.sort((a, b) => averageRating(b.rating).compareTo(averageRating(a.rating)));
      } else if (filter == 'Price') {
        filteredHotelList.sort((a, b) => b.price.compareTo(a.price));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Hotels",
          style: TextStyle(fontSize: 20.h, fontWeight: FontWeight.bold),
        ),
        leadingWidth: 120.w,
        leading: Row(
          children: [
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                Future.delayed(const Duration(milliseconds: 400), () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          themChanged: widget.themChanged,
                        ),
                      ));
                });
              },
              icon: Icon(
                CupertinoIcons.person_crop_circle,
                size: 30.sp,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await showSearch(
                    context: context, delegate: SearchViewDelegate(hotelList));
              },
              icon: Icon(
                Icons.search,
                size: 30.sp,
              )),
          SizedBox(
            width: 6.w,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: selectedFilter,
                  items: <String>['Rating', 'Price']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(fontSize: 14),),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedFilter = newValue!;
                      filterHotels(selectedFilter);
                    });
                  },
                ),
                ZoomTapAnimation(
                  onTap: () => isScroll(),
                  child: flag ? const Text("Show All") : const Icon(Icons.exit_to_app_sharp),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Hotel>>(
              future: hotelController.getHotels(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("No Data"),
                  );
                }
                final List<Hotel> data = filteredHotelList;
                return flag == true
                    ? GridView.builder(
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.55,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return HotelInfoScreen(hotel: data[index]);
                          })),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 200.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        data[index].imageUrl[0]),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  )),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data[index].hotelName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                  Text(
                                    data[index].location,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star_half,
                                        color: Colors.amber,
                                        size: 15.h,
                                      ),
                                      Text(
                                        "${(ReviewCalculator(hotel: data[index]).reviewCalculate).toStringAsFixed(2)} (${data[index].rating.length} Reviews)",
                                        style: TextStyle(fontSize: 12.sp),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.money_dollar,
                                        size: 14,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        "${data[index].price}",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                        "/night ",
                                        style: TextStyle(fontSize: 14),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
                    : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return HotelInfoScreen(hotel: data[index]);
                          })),
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 170.h,
                              width: 110.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        data[index].imageUrl[0]),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  )),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[index].hotelName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(
                                      data[index].location,
                                      style:
                                      const TextStyle(color: Colors.grey),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star_half,
                                          size: 17,
                                          color: Colors.amber,
                                        ),
                                        Text(
                                          "${(ReviewCalculator(hotel: data[index]).reviewCalculate).toStringAsFixed(2)} (${data[index].rating.length} Reviews)",
                                          style:
                                          TextStyle(fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          CupertinoIcons.money_dollar,
                                          color: Colors.green,
                                          size: 14,
                                        ),
                                        Text(
                                          "${data[index].price}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        const Text(
                                          "/night",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}