import 'dart:async';
import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  final Map<String, dynamic>? newBooking;
  const ActivityPage({super.key, this.newBooking});

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Timer? _timer;

  List<Map<String, dynamic>> inProgressList = [
    {
      'petName': 'Bobby',
      'cageType': 'Single',
      'duration': 10,
      'totalPrice': 1000000,
      'status': 'In Progress',
    },
  ];

  List<Map<String, dynamic>> historyList = [
    {
      'petName': 'Kedy',
      'cageType': 'Single',
      'duration': 5,
      'totalPrice': 500000,
      'status': 'Done',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    if (widget.newBooking != null) {
      inProgressList.add(widget.newBooking!);
    }

    _startCheckCompletedBookings();
  }

  void _startCheckCompletedBookings() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      setState(() {
        inProgressList.removeWhere((booking) {
          DateTime endDate = booking['endDate'];
          if (DateTime.now().isAfter(endDate)) {
            booking['status'] = 'Selesai';
            historyList.add(booking);
            return true;
          }
          return false;
        });
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'In Progress'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildListView(inProgressList),
          _buildListView(historyList),
        ],
      ),
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> list) {
    if (list.isEmpty) {
      return const Center(
        child: Text(
          'No data available.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final booking = list[index];
        return Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            title: Text(
              "${booking['petName']} - ${booking['cageType']} Cage",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Duration: ${booking['duration']} days\n"
              "Total Price: Rp ${booking['totalPrice']}",
            ),
            trailing: Text(
              booking['status'],
              style: TextStyle(
                color: _getStatusColor(booking['status']),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'In Progress':
        return Colors.orange;
      case 'Done':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}