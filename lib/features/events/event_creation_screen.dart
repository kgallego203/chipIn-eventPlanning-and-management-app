import 'package:chip_in/services/auth_service.dart';
import 'package:chip_in/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:chip_in/services/event_service.dart';
import 'package:chip_in/models/event.dart';

class EventCreationScreen extends StatefulWidget {
  final EventService eventService;

  EventCreationScreen({required this.eventService});

  @override
  _EventCreationScreenState createState() => _EventCreationScreenState();
}

class _EventCreationScreenState extends State<EventCreationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  String _location = '';
  String _description = '';

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Combine date and time into a single DateTime object
      DateTime dateTime = DateTime(
          _date.year, _date.month, _date.day, _time.hour, _time.minute);

      Event newEvent = Event(
        title: _title,
        dateTime: dateTime,
        location: _location,
        description: _description,
        creatorId: await AppwriteAuth.getCreatorId(),
      );

      bool success = await widget.eventService.createEvent(newEvent);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Event created successfully!')),
        );

        // Clear form fields and navigate back to home screen
        setState(() {
          _title = '';
          _date = DateTime.now();
          _time = TimeOfDay.now();
          _location = '';
          _description = '';
        });
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create event.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Event')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Pallete.neutral70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Pallete.neutral70),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Pallete.primary200),
                ),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a title' : null,
              onSaved: (value) => _title = value!,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Location',
                labelStyle: TextStyle(color: Pallete.neutral70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Pallete.neutral70),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Pallete.primary200),
                ),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a location' : null,
              onSaved: (value) => _location = value!,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Pallete.neutral70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Pallete.neutral70),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Pallete.primary200),
                ),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a description' : null,
              onSaved: (value) => _description = value!,
            ),
            ListTile(
              leading: Icon(Icons.calendar_today, color: Pallete.neutral70),
              title: Text('Date', style: TextStyle(color: Pallete.neutral70)),
              subtitle: Text(
                '${_date.year}-${_date.month}-${_date.day}',
                style: TextStyle(color: Pallete.neutral100),
              ),
              onTap: _selectDate,
            ),
            ListTile(
              leading: Icon(Icons.access_time, color: Pallete.neutral70),
              title: Text('Time', style: TextStyle(color: Pallete.neutral70)),
              subtitle: Text(
                '${_time.format(context)}',
                style: TextStyle(color: Pallete.neutral100),
              ),
              onTap: _selectTime,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Create Event'),
              style: ElevatedButton.styleFrom(
                primary: Pallete.primary200,
                onPrimary: Pallete.neutral0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
