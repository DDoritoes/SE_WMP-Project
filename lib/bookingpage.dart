import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_care/activitypage.dart';
// Import the ActivityPage

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  // Controllers
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _petAgeController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _complaintController = TextEditingController(); // Complaint text field

  // Variables
  DateTime? selectedDate;
  String? selectedPetType;
  String? selectedCageType;
  bool hasComplaint = false;
  String? bookingOption;
  int remainingSingleCages = 50;
  int remainingSharedCages = 10;
  int maxSharedPerCage = 15;

  // Dropdown options
  final List<String> petTypes = [
    'Dog',
    'Cat',
    'Bird',
    'Fish',
    'Rabbit',
    'Hamster',
    'Turtle',
    'Iguana'
  ];
  final List<String> cageTypes = ['Single', 'Sharing'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Pet Type'),
            DropdownButtonFormField<String>(
              value: selectedPetType,
              items: petTypes
                  .map((type) =>
                      DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedPetType = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select pet type',
              ),
            ),
            const SizedBox(height: 10),

            _buildSectionTitle('Pet Name'),
            TextField(
              controller: _petNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter pet name',
              ),
            ),
            const SizedBox(height: 10),

            _buildSectionTitle('Pet Age (months)'),
            TextField(
              controller: _petAgeController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Only digits
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter age in months',
              ),
            ),
            const SizedBox(height: 10),

            _buildSectionTitle('Is There Any Health Complaint?'),
            SwitchListTile(
              title: const Text('Is there any health complaint?'),
              value: hasComplaint,
              onChanged: (value) {
                setState(() {
                  hasComplaint = value;
                });
              },
            ),
            if (hasComplaint) ...[
              _buildSectionTitle('Complaint Description'),
              TextField(
                controller: _complaintController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter complaint details',
                ),
                maxLines: 3,
              ),
            ],
            const SizedBox(height: 10),

            _buildSectionTitle('Cage Type'),
            DropdownButtonFormField<String>(
              value: selectedCageType,
              items: cageTypes
                  .map((type) =>
                      DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCageType = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select cage type',
              ),
            ),
            const SizedBox(height: 10),

            _buildSectionTitle('Booking Duration (days)'),
            TextField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Only digits
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter booking duration',
              ),
            ),
            const SizedBox(height: 10),

            _buildSectionTitle('Select Date'),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(
                selectedDate == null
                    ? 'No date selected'
                    : '${selectedDate!.toLocal()}'.split(' ')[0],
              ),
              trailing: const Icon(Icons.edit),
              onTap: _selectDate,
            ),
            const SizedBox(height: 10),

            Text(
              'Remaining Single Cages: $remainingSingleCages',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              'Remaining Shared Cages: $remainingSharedCages, Max $maxSharedPerCage Pets Per Cage',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),

            _buildSectionTitle('Booking Options'),
            RadioListTile<String>(
              title: const Text('Regular Booking (Food)'),
              value: 'regular',
              groupValue: bookingOption,
              onChanged: (value) {
                setState(() {
                  bookingOption = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Premium Booking (Food & Health Check)'),
              value: 'premium',
              groupValue: bookingOption,
              onChanged: (value) {
                setState(() {
                  bookingOption = value;
                });
              },
            ),
            const SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: _submitBooking,
                child: const Text('Booking'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _submitBooking() {
  if (selectedPetType == null ||
      _petNameController.text.isEmpty ||
      _petAgeController.text.isEmpty ||
      selectedCageType == null ||
      _durationController.text.isEmpty ||
      bookingOption == null ||
      selectedDate == null) {
    _showAlert('Booking Failed', 'Please fill in all the details first!');
    return;
  }

  // Hitung harga
  int duration = int.tryParse(_durationController.text) ?? 0;
  int pricePerDay = (selectedCageType == 'Single')
      ? (bookingOption == 'regular' ? 80000 : 100000)
      : (bookingOption == 'regular' ? 65000 : 85000);
  int totalPrice = pricePerDay * duration;

  // Buat data booking
  Map<String, dynamic> newBooking = {
    'petName': _petNameController.text,
    'petType': selectedPetType,
    'cageType': selectedCageType,
    'duration': duration,
    'totalPrice': totalPrice,
    'status': 'Dalam pengantaran',
    'endDate': selectedDate!.add(Duration(days: duration)), // Tanggal selesai
  };

  // Tampilkan invoice sebelum pindah ke halaman berikutnya
  _showInvoice(newBooking, pricePerDay, totalPrice);
}

void _showInvoice(Map<String, dynamic> bookingData, int pricePerDay, int totalPrice) {
  showDialog(
    context: context,
    barrierDismissible: false, // Tidak bisa ditutup dengan tap di luar
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Invoice for Pet Boarding'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text('Pet Type: ${bookingData['petType']}'),
              Text('Pet Name: ${bookingData['petName']}'),
              Text('Pet Age: ${_petAgeController.text} months'),
              Text('Cage Type: ${bookingData['cageType']}'),
              Text('Booking Option: $bookingOption'),
              Text('Booking Duration: ${bookingData['duration']} days'),
              Text('Booking Date: ${selectedDate!.toLocal()}'.split(' ')[0]),
              if (hasComplaint)
                Text('Complaint: ${_complaintController.text}'),
              const Divider(),
              Text('Price Per Day: Rp $pricePerDay'),
              Text(
                'Total Price: Rp $totalPrice',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Back to Home Page
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text('Back to Home Page'),
          ),
          TextButton(
            onPressed: () {
              // Pindah ke ActivityPage
              Navigator.of(context).pop(); // Tutup dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ActivityPage(newBooking: bookingData),
                ),
              );
            },
            child: const Text('Check Activity Page'),
          ),
        ],
      );
    },
  );
}

  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
