import 'package:field_scheduling/data/database/booking_db.dart';
import 'package:field_scheduling/data/database/booking_model.dart';
import 'package:field_scheduling/ui/pages/booking_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Booking>>? getAll;
  final bookingDB = BookingDB();

  @override
  void initState() {
    super.initState();
    bookingDB.fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reservas",
          style: TextStyle(
            letterSpacing: 10,
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: BookingList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'new_booking');
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
