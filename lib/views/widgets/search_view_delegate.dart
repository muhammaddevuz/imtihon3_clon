import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtihon3_clon/models/hotel.dart';
import 'package:imtihon3_clon/views/screens/hotel_info_screen.dart';

class SearchViewDelegate extends SearchDelegate<String> {
  final List<Hotel> data;

  SearchViewDelegate(this.data);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? data
        : data.where((element) => element.hotelName.contains(query)).toList();
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestionList[index].hotelName),
            leading: Container(
              height: 100.h,
              width: 50.w,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50.sp)),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                suggestionList[index].imageUrl[0],
                fit: BoxFit.cover,
              ),
            ),
            subtitle: Text(suggestionList[index].description),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HotelInfoScreen(hotel: suggestionList[index])));
            },
          );
        });
  }
}
