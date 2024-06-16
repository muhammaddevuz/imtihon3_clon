import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtihon3_clon/controllers/user_controller.dart';
import 'package:imtihon3_clon/models/hotel.dart';
import 'package:imtihon3_clon/models/user.dart';
import 'package:imtihon3_clon/utils/app_constans.dart';
import 'package:imtihon3_clon/views/screens/hotel_info_screen.dart';

class ProfileScreen extends StatefulWidget {
  final ValueChanged<void> themChanged;
  const ProfileScreen({super.key, required this.themChanged});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserController userController = UserController();
  TextEditingController nameEditingController = TextEditingController();
  User? user;
  DateTime? birthday;
  String? userEmail;

  late Future<List<Hotel>> orderedHotelsFuture;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    user = await userController.getUser();
    if (user != null) {
      orderedHotelsFuture =
          userController.getOrderedHotels(user!.orderedHotels);
      setState(() {
        birthday = user!.birthday;
        userEmail = user!.email;
        nameEditingController.text = user!.name;
      });
    }
  }

  Future<void> _refreshOrderedHotels() async {
    if (user != null) {
      orderedHotelsFuture =
          userController.getOrderedHotels(user!.orderedHotels);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 22.h, fontWeight: FontWeight.w500),
        ),
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SwitchListTile(
                    value: AppConstans.themeCheck,
                    onChanged: widget.themChanged,
                    title: Text(
                      "Tungi holat",
                      style: TextStyle(
                        fontSize: 15.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  TextFormField(
                    controller: nameEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      labelText: "Name",
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Birthday:",
                        style: TextStyle(
                          fontSize: 15.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      date()
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Email:",
                        style: TextStyle(
                          fontSize: 15.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userEmail!,
                        style: TextStyle(
                          fontSize: 11.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Ordered hotels",
                        style: TextStyle(
                          fontSize: 15.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: orederdHotelsWidget())
                ],
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () async {
            if (user != null) {
              userController.editUser(
                  user!.id, nameEditingController.text, birthday.toString());
              await showDialog(
                context: context,
                builder: (context) => const AlertDialog(
                  content: Text("O'zgarishlar muvaffaqiyatli saqlandi"),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "O'zgartirishlarni saqlash",
              style: TextStyle(color: Colors.white, fontSize: 13.h),
            ),
          ),
        ),
      ),
    );
  }

  Widget date() {
    return InkWell(
      onTap: () async {
        DateTime? newDate = await showDatePicker(
          context: context,
          initialDate: birthday ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (newDate != null) {
          setState(() {
            birthday = newDate;
          });
        }
      },
      child: Text(
        birthday == null
            ? "Sanani tanlang"
            : birthday.toString().split(" ")[0],
        style: TextStyle(fontSize: 15.h, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget orederdHotelsWidget() {
    return FutureBuilder<List<Hotel>>(
      future: orderedHotelsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Xatolik yuz berdi: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Buyurtma qilingan mehmonxonalar yo'q"));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final hotel = snapshot.data![index];
              return Column(
                children: [
                  ListTile(
                    title: Text(hotel.hotelName),
                    leading: Container(
                      height: 100.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.sp)),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        hotel.imageUrl[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            await userController.deleteOrderedHotel(
                                user!.id, user!.orderedHotels, hotel.hotelId);
                            await _refreshOrderedHotels();
                            Navigator.pushReplacement(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen(
                                      themChanged: widget.themChanged),
                                ));
                          },
                          icon: const Icon(
                            Icons.delete,
                            size: 30,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(hotel.description),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HotelInfoScreen(hotel: hotel),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10.h),
                ],
              );
            },
          );
        }
      },
    );
  }
}
