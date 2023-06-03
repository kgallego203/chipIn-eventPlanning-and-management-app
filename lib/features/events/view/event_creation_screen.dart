import 'package:chip_in/features/auth/services/auth_service.dart';
import 'package:chip_in/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:chip_in/features/events/services/event_service.dart';
import 'package:chip_in/features/events/models/event_model.dart';

class EventCreationScreen extends StatefulWidget {
  final EventService eventService;

  EventCreationScreen({required this.eventService});

  @override
  _EventCreationScreenState createState() => _EventCreationScreenState();
}

class _EventCreationScreenState extends State<EventCreationScreen> {
  // Key for accessing the form state
  final _formKey = GlobalKey<FormState>();

  // Form fields
  late String _id;
  late String _title;
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  late String _location;
  late String _description;

  // Function to show a date picker and update the selected date
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

  // Function to show a time picker and update the selected time
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

  // Function called when the form is submitted
  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Combine date and time into a single DateTime object
      DateTime dateTime = DateTime(
          _date.year, _date.month, _date.day, _time.hour, _time.minute);

      // Create a new Event object with the entered data
      Event newEvent = Event(
        id: _id, // provide a value for the id parameter
        title: _title,
        dateTime: dateTime,
        location: _location,
        description: _description,
        creatorId: await AppwriteAuth.getCreatorId(),
      );

      // Call the event service to create the event
      bool success = await widget.eventService.createEvent(newEvent);
      if (success) {
        // Show a success message if the event creation was successful
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event created successfully!')),
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
        // Show an error message if the event creation failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create event.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Event')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Text input field for the event title
            TextFormField(
              decoration: const InputDecoration(
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
            // Text input field for the event location
            TextFormField(
              decoration: const InputDecoration(
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
            // Text input field for the event description
            TextFormField(
              decoration: const InputDecoration(
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
            // Date selection tile
            ListTile(
              leading:
                  const Icon(Icons.calendar_today, color: Pallete.neutral70),
              title: const Text('Date',
                  style: TextStyle(color: Pallete.neutral70)),
              subtitle: Text(
                '${_date.year}-${_date.month}-${_date.day}',
                style: const TextStyle(color: Pallete.neutral100),
              ),
              onTap: _selectDate,
            ),
            // Time selection tile
            ListTile(
              leading: const Icon(Icons.access_time, color: Pallete.neutral70),
              title: const Text('Time',
                  style: TextStyle(color: Pallete.neutral70)),
              subtitle: Text(
                '${_time.format(context)}',
                style: const TextStyle(color: Pallete.neutral100),
              ),
              onTap: _selectTime,
            ),
            const SizedBox(height: 16.0),
            // Button to submit the form and create the event
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
