import 'package:flutter/material.dart';
import 'package:imtihon3_clon/controllers/admin/admin_controller.dart';
import 'package:imtihon3_clon/views/screens/admin_panel/admin_panel.dart';

import '../../models/hotel.dart';

class AddHotelDialog extends StatefulWidget {
  final Hotel? hotel;
  final bool isEdit;
  final Function refresh;

  const AddHotelDialog({
    super.key,
    this.hotel,
    required this.isEdit,
    required this.refresh

  });

  @override
  State<AddHotelDialog> createState() => _AddHotelDialogState();
}

class _AddHotelDialogState extends State<AddHotelDialog> {
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

  // @override
  // void initState() {
  //   super.initState();
  //
  //   amenities = widget.hotel!.amenities;
  //   comment = widget.hotel!.comment;
  //   description = widget.hotel!.description;
  //   hotelName = widget.hotel!.hotelName;
  //   imageUrl = widget.hotel!.imageUrl;
  //   price = widget.hotel!.price;
  //   rating = widget.hotel!.rating;
  //   spaceRooms = widget.hotel!.spaceRooms;
  //   location = widget.hotel!.location;
  // }

  Future<void> addHotel() async{
   await AdminController().addHotel(
      amenities: amenities,
      hotelName: hotelName,
      description: description,
      imageUrl: imageUrl,
      price: price,
      rating: rating,
      rooms: spaceRooms,
      location: location,
    );
  }

  @override
  void initState() {
    super.initState();

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
                keyboardType: TextInputType.number,
                initialValue: rating.join(','),
                decoration: const InputDecoration(labelText: 'Rating'),
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
                decoration: const InputDecoration(labelText: 'Space rooms'),
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
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (_formkey.currentState!.validate()) {
                _formkey.currentState!.save();
                addHotel();
                widget.refresh();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const AdminPanel(),));
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
