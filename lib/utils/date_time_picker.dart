import 'package:flutter/material.dart';

class DateTimePickerScreen extends StatefulWidget {
  @override
  _DateTimePickerScreenState createState() => _DateTimePickerScreenState();
}

class _DateTimePickerScreenState extends State<DateTimePickerScreen> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Date Time Picker')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Date: ${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select Date'),
            ),
            SizedBox(height: 32),
            Text(
              'Selected Time: ${_selectedTime.format(context)}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text('Select Time'),
            ),
          ],
        ),
      ),
    );
  }
}
