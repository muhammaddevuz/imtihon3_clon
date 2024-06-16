import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtihon3_clon/controllers/user_controller.dart';
import 'package:imtihon3_clon/functions/review_calculator.dart';
import 'package:imtihon3_clon/models/hotel.dart';
import 'package:imtihon3_clon/models/user.dart';

class HotelInfoScreen extends StatefulWidget {
  final Hotel hotel;
  HotelInfoScreen({super.key, required this.hotel});

  @override
  State<HotelInfoScreen> createState() => _HotelInfoScreenState();
}

class _HotelInfoScreenState extends State<HotelInfoScreen> {
  UserController userController = UserController();
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  int i = 0;
  bool isLoading = true;

  void toggleImage() {
    if (i + 1 < widget.hotel.imageUrl.length - 1) {
      i++;
    } else {
      i = 0;
    }
    setState(() {});
  }

  void refresh() {
    setState(() {});
  }

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await userController.addComment(
          _commentController.text, widget.hotel.hotelId);
      _formKey.currentState!.dispose();
      _commentController.clear();
      Navigator.of(context).pop();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel detail'),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  toggleImage();
                },
                child: Container(
                  height: 200.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.sp),
                    image: DecorationImage(
                      image: NetworkImage(widget.hotel.imageUrl[i]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 40.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFC3C7CA),
                            borderRadius: BorderRadius.circular(13.sp),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5.sp),
                            child: Text(
                                "${i + 1}/${widget.hotel.imageUrl.length - 1}"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.hotel.hotelName,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20.sp),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.hotel.location,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14.sp),
                        ),
                        Row(
                          children: [
                            Text(
                              "${(ReviewCalculator(hotel: widget.hotel).reviewCalculate).toStringAsFixed(2)} / (${widget.hotel.rating.length} Reviews)",
                              style: TextStyle(fontSize: 12.sp),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 5.h),
                    SizedBox(
                      width: 200.w,
                      child: Row(
                        children: [
                          Text(
                              "${widget.hotel.spaceRooms.length} Rooms are available")
                        ],
                      ),
                    ),
                    const Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18.sp),
                        ),
                        Text(
                          widget.hotel.description,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14.sp),
                        ),
                      ],
                    ),
                    Text(
                      "What this place offers",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: 200.h,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.hotel.amenities.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 10.sp,
                          crossAxisSpacing: 10.sp,
                          crossAxisCount: 3,
                        ),
                        itemBuilder: (_, index) {
                          return Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(12.sp),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Text(
                              widget.hotel.amenities[index],
                              style: TextStyle(fontSize: 15.sp),
                            ),
                          );
                        },
                      ),
                    ),
                    Text(
                      "Comments",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w700),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10.h),
                      height: 150.h,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 20.w),
                            width: 140.w,
                            padding: EdgeInsets.all(20.sp),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  child: IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(17.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Form(
                                                      key: _formKey,
                                                      child: TextFormField(
                                                        controller:
                                                            _commentController,
                                                        decoration:
                                                            const InputDecoration(
                                                                border:
                                                                    OutlineInputBorder()),
                                                        validator: (value) {
                                                          if (value == null) {
                                                            return 'Please enter comment';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.h),
                                                    InkWell(
                                                      onTap: () async {
                                                        onSubmit();
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7.sp),
                                                            color:
                                                                Colors.amber),
                                                        width: double.infinity,
                                                        padding: EdgeInsets.all(
                                                            10.sp),
                                                        child: Text(
                                                          "Add comment",
                                                          style: TextStyle(
                                                              fontSize: 15.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.add)),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                    widget.hotel.comment.length, (int index) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 20.w),
                                    width: 140.w,
                                    padding: EdgeInsets.all(20.sp),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const CircleAvatar(
                                          child: Icon(Icons.person),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(widget.hotel.comment[index]),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Location',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp)),
                      child: Image.asset(
                        'assets/map.png',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 20.w),
                      child: const Text(
                        textAlign: TextAlign.left,
                        'Dago Pakar Villa P4-16, Jl. Dago Pakar Permai IV No.16, Mekarsaluyu, Cimenyan, Bandung Regency, West Java 40198',
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Start From',
                              style: TextStyle(
                                  color: const Color(0xFF858789),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "\$${widget.hotel.price} / night",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        FilledButton(
                            onPressed: () async {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                            "Hotel nomi: ${widget.hotel.hotelName}"),
                                        SizedBox(height: 10.h),
                                        Text(
                                            "Hotel qulayliklari: ${widget.hotel.amenities.join(", ")}"),
                                        SizedBox(height: 10.h),
                                        Text(
                                            "Hotel narxi: ${widget.hotel.price}\$"),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            User user =
                                                await userController.getUser();
                                            List box = user.orderedHotels;
                                            box.add(widget.hotel.hotelId);
                                            await userController
                                                .addOrderedHotel(user.id, box);
                                            // ignore: use_build_context_synchronously
                                            Navigator.pop(context);
                                            await showDialog(
                                              // ignore: use_build_context_synchronously
                                              context: context,
                                              builder: (context) {
                                                return const AlertDialog(
                                                  content: Text(
                                                      "Mehmonhona muvafaqiyatli bron qilindi"),
                                                );
                                              },
                                            );
                                          },
                                          child: const Text("Buyurtma qilish"))
                                    ],
                                  );
                                },
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(5.sp),
                              child: const Text('Reserve'),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
