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

      Event newEvent = Event(
        title: _title,
        date: _date,
        time: _time,
        location: _location,
        description: _description,
      );

      bool success = await widget.eventService.createEvent(newEvent);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Event created successfully!')),
        );
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
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a title' : null,
              onSaved: (value) => _title = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Location'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a location' : null,
              onSaved: (value) => _location = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a description' : null,
              onSaved: (value) => _description = value!,
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text('Time'),
              subtitle: Text('${_time.format(context)}'),
              onTap: _selectTime,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Create Event'),
            ),
          ],
        ),
      ),
    );
  }
}
