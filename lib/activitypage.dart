import 'dart:async'; // Tambahkan ini untuk Timer
import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  final Map<String, dynamic>? newBooking; // Data booking dari BookingPage
  const ActivityPage({super.key, this.newBooking});

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Timer? _timer; // Tambahkan Timer

  // List untuk menyimpan aktivitas
  List<Map<String, dynamic>> inProgressList = [];
  List<Map<String, dynamic>> historyList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Tambahkan booking baru ke In Progress jika ada
    if (widget.newBooking != null) {
      setState(() {
        inProgressList.add(widget.newBooking!);
      });
    }

    // Jadwalkan pengecekan booking setiap detik
    _startCheckCompletedBookings();
  }

  void _startCheckCompletedBookings() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return; // Pastikan widget masih aktif
      setState(() {
        // Pindahkan booking yang sudah selesai ke History
        inProgressList.removeWhere((booking) {
          DateTime endDate = booking['endDate'];
          if (DateTime.now().isAfter(endDate)) {
            historyList.add(booking);
            return true; // Hapus dari In Progress
          }
          return false;
        });
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Batalkan Timer
    _tabController.dispose(); // Hapus controller
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
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final booking = list[index];
        return Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            title: Text("${booking['petName']} - ${booking['cageType']} Cage"),
            subtitle: Text(
              "Duration: ${booking['duration']} days\n"
              "Total Price: Rp ${booking['totalPrice']}",
            ),
            trailing: Text(
              booking['status'],
              style: TextStyle(
                color: booking['status'] == 'Dalam pengantaran'
                    ? Colors.orange
                    : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}