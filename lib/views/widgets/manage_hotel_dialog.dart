import 'package:flutter/material.dart';
import 'package:imtihon3_clon/controllers/admin/admin_controller.dart';

import '../../models/hotel.dart';

class ManageHotelDialog extends StatefulWidget {
  final Hotel? hotel;
  final bool isEdit;
  final Function() edited;

  const ManageHotelDialog({super.key, this.hotel, required this.isEdit, required this.edited});

  @override
  State<ManageHotelDialog> createState() => _ManageHotelDialogState();
}

class _ManageHotelDialogState extends State<ManageHotelDialog> {
  List<String> amenities = [];
  List<String> comment = [];
  String description = '';
  String hotelName = '';
  List<String> imageUrl = [];
  double price = 0.0;
  List<int> rating = [];
  List<int> spaceRooms = [];
  String location = '';

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  AdminController adminController = AdminController();

  // void addHotel(amenities,  comment,  hotelName,  description,  imageUrl, price, rating, spaceRooms) async{
  //   await adminController.addHotel(amenities: amenities, comment: comment, hotelName: hotelName, description: description, imageUrl: imageUrl, price: price, rating: rating, rooms: spaceRooms);
  // }

  @override
  void initState() {
    super.initState();

    if (widget.isEdit) {
      amenities = widget.hotel!.amenities;
      comment = widget.hotel!.comment;
      description = widget.hotel!.description;
      hotelName = widget.hotel!.hotelName;
      imageUrl = widget.hotel!.imageUrl;
      price = widget.hotel!.price;
      rating = widget.hotel!.rating;
      spaceRooms = widget.hotel!.spaceRooms;
      location = widget.hotel!.location;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text(widget.isEdit ? 'Edit hotel' : 'Add hotel'),
        content: Form(
          key: _formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: hotelName,
                decoration: const InputDecoration(labelText: 'Hotel name'),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter something!';
                  }
                  return null;
                },
                onSaved: (String? newValue) {
                  if (newValue != null) {
                    hotelName = newValue;
                  }
                },
              ),
              TextFormField(
                initialValue: description,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter something!';
                  }
                  return null;
                },
                onSaved: (String? newValue) {
                  if (newValue != null) {
                    description = newValue;
                  }
                },
              ),
              TextFormField(
                initialValue: imageUrl.join(','),
                decoration: const InputDecoration(labelText: 'image url'),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter something!';
                  }
                  return null;
                },
                onSaved: (String? newValue) {
                  if (newValue != null) {
                    imageUrl = newValue.split(',');
                  }
                },
              ),
              TextFormField(
                initialValue: amenities.join(','),
                decoration: const InputDecoration(labelText: 'Amenities'),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter something!';
                  }
                  return null;
                },
                onSaved: (String? newValue) {
                  if (newValue != null) {
                    amenities = newValue.split(',');
                  }
                },
              ),
              TextFormField(
                //initialValue: widget.hotel.description,
                initialValue: comment.join(','),
                decoration: const InputDecoration(labelText: 'Comment'),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter something!';
                  }
                  return null;
                },
                onSaved: (String? newValue) {
                  if (newValue != null) {
                    comment = newValue.split(',');
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                //initialValue: widget.hotel.description,
                initialValue: price.toString(),
                decoration: const InputDecoration(labelText: 'Price'),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter something!';
                  }
                  return null;
                },
                onSaved: (String? newValue) {
                  if (newValue != null) {
                    price = double.parse(newValue);
                  }
                },
              ),
              TextFormField(
                initialValue: rating.join(','),
                decoration: const InputDecoration(labelText: 'Comment'),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter something!';
                  }
                  return null;
                },
                onSaved: (String? newValue) {
                  if (newValue != null) {
                    rating = newValue
                        .split(',')
                        .map((e) => int.tryParse(e.trim()) ?? 0)
                        .toList();
                  }
                },
              ),
              TextFormField(
                initialValue: spaceRooms.join(','),
                decoration: const InputDecoration(labelText: 'SpaceRooms'),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter something!';
                  }
                  return null;
                },
                onSaved: (String? newValue) {
                  if (newValue != null) {
                    spaceRooms = newValue
                        .split(',')
                        .map((e) => int.tryParse(e.trim()) ?? 0)
                        .toList();
                  }
                },
              ),
              TextFormField(
                initialValue: location,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter something!';
                  }
                  return null;
                },
                onSaved: (String? newValue) {
                  if (newValue != null) {
                    location = newValue;
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child:const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (_formkey.currentState!.validate()) {
                _formkey.currentState!.save();
                AdminController().addHotel(
                  amenities: amenities,
                  hotelName: hotelName,
                  description: description,
                  imageUrl: imageUrl,
                  price: price,
                  rating: rating,
                  rooms: spaceRooms,
                  location: location,

                );
                Navigator.pop(context);
                widget.edited();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
