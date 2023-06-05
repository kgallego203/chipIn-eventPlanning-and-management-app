import 'package:chip_in/features/auth/services/user_service.dart';
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
  late final String _id = '';
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
      // Check if the form is valid
      _formKey.currentState!.save(); // Save the form data

      DateTime dateTime = DateTime(
          _date.year,
          _date.month,
          _date.day,
          _time.hour,
          _time
              .minute); // Create a DateTime object from the selected date and time

      Event newEvent = Event(
        id: _id, // Set the id of the new event
        title: _title, // Set the title of the new event
        dateTime: dateTime, // Set the date and time of the new event
        location: _location, // Set the location of the new event
        description: _description, // Set the description of the new event
        creatorId: await AppwriteAuth
            .getCreatorId(), // Set the creatorId of the new event
      );

      bool success = await widget.eventService.createEvent(
          newEvent); // Call the createEvent method of the eventService and pass in the newEvent object
      if (success) {
        // If the event was created successfully
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Event created successfully!')), // Show a snackbar with a success message
        );

        setState(() {
          // Reset the form fields
          _title = '';
          _date = DateTime.now();
          _time = TimeOfDay.now();
          _location = '';
          _description = '';
        });
        Navigator.pop(
            context); // Pop the current screen off the navigation stack
      } else {
        // If the event creation failed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Failed to create event.')), // Show a snackbar with an error message
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
        title: const Text('Create Event'), // Set the title of the app bar
      ),
      body: Form(
        key: _formKey, // Set the key for the form
        child: ListView(
          padding: const EdgeInsets.all(16.0), // Set padding for the list view
          children: [
            customFormField(
              labelText: 'Title', // Set the label text for the form field
              validator: (value) => value!.isEmpty
                  ? 'Please enter a title'
                  : null, // Set the validator for the form field
              onSaved: (value) => _title =
                  value!, // Set the onSaved callback for the form field
            ),
            customFormField(
              labelText: 'Location', // Set the label text for the form field
              validator: (value) => value!.isEmpty
                  ? 'Please enter a location'
                  : null, // Set the validator for the form field
              onSaved: (value) => _location =
                  value!, // Set the onSaved callback for the form field
            ),
            customFormField(
              labelText: 'Description', // Set the label text for the form field
              validator: (value) => value!.isEmpty
                  ? 'Please enter a description'
                  : null, // Set the validator for the form field
              onSaved: (value) => _description =
                  value!, // Set the onSaved callback for the form field
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today,
                  color: Pallete
                      .neutral70), // Set the leading icon for the list tile
              title: const Text('Date',
                  style: TextStyle(
                      color: Pallete
                          .neutral70)), // Set the title text for the list tile
              subtitle: Text(
                '${_date.year}-${_date.month}-${_date.day}', // Set the subtitle text for the list tile
                style: const TextStyle(
                    color: Pallete
                        .neutral100), // Set the style for the subtitle text
              ),
              onTap: _selectDate, // Set the onTap callback for the list tile
            ),
            ListTile(
              leading: const Icon(Icons.access_time,
                  color: Pallete
                      .neutral70), // Set the leading icon for the list tile
              title: const Text('Time',
                  style: TextStyle(
                      color: Pallete
                          .neutral70)), // Set the title text for the list tile
              subtitle: Text(
                _time
                    .format(context), // Set the subtitle text for the list tile
                style: const TextStyle(
                    color: Pallete
                        .neutral100), // Set the style for the subtitle text
              ),
              onTap: _selectTime, // Set the onTap callback for the list tile
            ),
            const SizedBox(height: 16.0), // Add a sized box with a fixed height
            ElevatedButton(
              onPressed:
                  _submit, // Set the onPressed callback for the elevated button
              style: ElevatedButton.styleFrom(
                backgroundColor: Pallete
                    .primary200, // Set the background color for the elevated button
                foregroundColor: Pallete
                    .neutral0, // Set the foreground color for the elevated button
              ),
              child: const Text(
                  'Create Event'), // Set the text for the elevated button
            ),
          ],
        ),
      ),
    );
  }
}
