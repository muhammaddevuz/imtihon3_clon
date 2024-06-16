import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imtihon3_clon/controllers/admin/admin_controller.dart';
import 'package:imtihon3_clon/views/screens/admin_panel/user_info_screen.dart';
import 'package:imtihon3_clon/views/widgets/admin_hotels_widget.dart';
import 'package:imtihon3_clon/views/widgets/edit_hotel_dialog.dart';

import '../../widgets/add_hotel_dialog.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final AdminController _adminController = AdminController();
  @override
  void initState() {
    super.initState();
    _loadHotels();
  }

  Future<void> _loadHotels() async {}

  void refresh() {
    setState(() {});
  }

  void onAddPressed() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => AddHotelDialog(
        isEdit: false,
        refresh: refresh,
      ),
    );
    setState(() {});
  }

  void editFunc(Map<String, dynamic> response, hotelId) async {
    _adminController.editHotels(
        hotelId: hotelId,
        newAmenities: response['newAmenities'],
        newHotelName: response['newHotelName'],
        newDescription: response['newDescription'],
        newImageUrl: response['newImageUrl'],
        newPrice: response['newPrice'],
        newRating: response['newRating'],
        newSpaceRooms: response['newSpaceRooms'],
        newLocation: response['newLocation']);
    setState(() {});
  }

  void onDeletePressed({required String hotelId}) async {
    await _adminController.deleteHotel(hotelId: hotelId);
    refresh();
    _loadHotels();
  }

  @override
  Widget build(BuildContext context) {
    //test();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Admin",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: onAddPressed,
            icon: const Icon(
              CupertinoIcons.add,
              size: 30,
            ),
          ),
          const SizedBox(width: 10)
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [Text("Menu")],
            )),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminPanel(),
                  ),
                );
              },
              title: const Text("Admin Panel"),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfoScreen(),
                  ),
                );
              },
              title: const Text("User Info"),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
          ],
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: FutureBuilder(
              future: _adminController.hotelsList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text('Add hotels'),
                  );
                }

                final data = snapshot.data!;
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return HotelsWidget(
                            onDeletePressed: () {
                              onDeletePressed(hotelId: data[index].hotelId);
                            },
                            onEditPressed: () async {
                              final Map<String, dynamic> response =
                                  await showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    EditHotelDialog(
                                  hotel: data[index],
                                  refresh: refresh,
                                ),
                              );
                              editFunc(response, data[index].hotelId);
                            },
                            hotels: data,
                            index: index,
                          );
                        },
                      ),
                    ),
                  ],
                );
              })),
    );
  }
}
