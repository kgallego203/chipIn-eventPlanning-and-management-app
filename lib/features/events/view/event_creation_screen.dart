import 'package:chip_in/features/auth/services/auth_service.dart';
import 'package:chip_in/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:chip_in/features/events/services/event_service.dart';
import 'package:chip_in/features/events/models/event_model.dart';
import '/utils/form_utilities.dart'; // import form_utilities.dart

class EventCreationScreen extends StatefulWidget {
  final EventService eventService;
  const EventCreationScreen({required this.eventService});

  @override
  _EventCreationScreenState createState() => _EventCreationScreenState();
}

class _EventCreationScreenState extends State<EventCreationScreen> {
  final _formKey = GlobalKey<FormState>(); // Instantiating a GlobalKey
  // Instance Variables
  late String _id;
  late String _title;
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  late String _location;
  late String _description;

/* ------------------------------------------------------------------------------------------------------------------------------ */
  /// * This function is named _selectDate() and it is a Future that shows a date picker dialog to the user and updates the _date
  /// * instance variable with the selected date. It is called when the user taps on the "Select Date" button in the EventCreationScreen widget.
  Future<void> _selectDate() async {
    final DateTime? picked =
        await selectDate(context, _date); // use selectDate from utilities
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

/* ------------------------------------------------------------------------------------------------------------------------------ */
  /// * This code defines a function named _selectTime() that shows a time picker dialog to the user and updates the _time instance
  /// * variable with the selected time. It is called when the user taps on the "Select Time" button in the EventCreationScreen widget.
  Future<void> _selectTime() async {
    final TimeOfDay? newTime =
        await selectTime(context, _time); // use selectTime from utilities
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

/* ------------------------------------------------------------------------------------------------------------------------------ */
  /// * This function called _submit() is responsible for validating the form and creating a new event based on the user's input.
  /// * It also saves the new event to the database using the eventService instance passed to the EventCreationScreen widget.
  /// * If the event is successfully created, it shows a success message and resets the form. If it fails, it shows an error message.
  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      DateTime dateTime = DateTime(
          _date.year, _date.month, _date.day, _time.hour, _time.minute);

      Event newEvent = Event(
        id: _id,
        title: _title,
        dateTime: dateTime,
        location: _location,
        description: _description,
        creatorId: await AppwriteAuth.getCreatorId(),
      );

      bool success = await widget.eventService.createEvent(newEvent);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event created successfully!')),
        );

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

/* ------------------------------------------------------------------------------------------------------------------------------ */
  /// * UI SECTION
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
        leading: Container(), // Remove the back button from the app bar
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            customFormField(
              labelText: 'Title',
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a title' : null,
              onSaved: (value) => _title = value!,
            ),
            customFormField(
              labelText: 'Location',
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a location' : null,
              onSaved: (value) => _location = value!,
            ),
            customFormField(
              labelText: 'Description',
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a description' : null,
              onSaved: (value) => _description = value!,
            ),
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
            ListTile(
              leading: const Icon(Icons.access_time, color: Pallete.neutral70),
              title: const Text('Time',
                  style: TextStyle(color: Pallete.neutral70)),
              subtitle: Text(
                _time.format(context),
                style: const TextStyle(color: Pallete.neutral100),
              ),
              onTap: _selectTime,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Pallete.primary200,
                foregroundColor: Pallete.neutral0,
              ),
              child: const Text('Create Event'),
            ),
          ],
        ),
      ),
    );
  }
}
