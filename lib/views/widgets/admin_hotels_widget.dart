import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imtihon3_clon/models/hotel.dart';

class HotelsWidget extends StatefulWidget {
  final Function() onDeletePressed;
  final Function() onEditPressed;
  final List<Hotel> hotels;
  final int index;

  const HotelsWidget({
    super.key,
    required this.onDeletePressed,
    required this.onEditPressed,
    required this.hotels,
    required this.index,
  });

  @override
  State<HotelsWidget> createState() => _HotelsWidgetState();
}

class _HotelsWidgetState extends State<HotelsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: widget.index == 0 ? 15 : 0),
      padding: EdgeInsets.only(top: 5.h,bottom: 5.h),
      width: 343.w,
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            width: 114.w,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                bottomLeft: Radius.circular(10.r),
              ),
              image: DecorationImage(
                image: NetworkImage(widget.hotels[widget.index].imageUrl[0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.hotels[widget.index].hotelName,
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 5.h),
                Text(
                  widget.hotels[widget.index].location,
                  style: TextStyle(fontSize: 16.sp,),
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Text(
                      widget.hotels[widget.index].rating[0].toString(),
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        '(${widget.hotels[widget.index].description})',
                        style: TextStyle(fontSize: 14.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                      List.generate(
                        widget.hotels[widget.index].amenities.length,
                            (int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              widget.hotels[widget.index].amenities[index],
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                Text("Space rooms: ${widget.hotels[widget.index].spaceRooms[0].toString()}"),
                SizedBox(height: 5.h),
                Text(
                  '\$${widget.hotels[widget.index].price}/night',
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: widget.onEditPressed,
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: widget.onDeletePressed,
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
