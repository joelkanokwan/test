import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';

class CustomerOrderHistory extends StatefulWidget {
  @override
  _CustomerOrderHistoryState createState() => _CustomerOrderHistoryState();
}

class _CustomerOrderHistoryState extends State<CustomerOrderHistory> {
  DateTime? selectedDay;
  late List<CleanCalendarEvent> selectedEvent;

  final Map<DateTime, List<CleanCalendarEvent>> events = {
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
      CleanCalendarEvent(
        'Event A',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 10, 0),
        endTime: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          12,
          0,
        ),
        description: 'A special event',
        color: Colors.blue,
      ),
    ],
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2):
        [
      CleanCalendarEvent('Event B',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 12, 0),
          color: Colors.orange),
      CleanCalendarEvent('Event C',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 14, 30),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 17, 0),
          color: Colors.pink),
    ],
  };

  static var endTime;

  void _handleData(date) {
    setState(() {
      selectedDay = date;
      selectedEvent = events[selectedDay] ?? [];
    });
    print(selectedDay);
  }

  @override
  void initState() {
    selectedEvent = events[selectedDay] ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Partner OrderHistory'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: Calendar(
            startOnMonday: true,
            selectedColor: Colors.blue,
            todayColor: Colors.red,
            eventColor: Colors.green,
            eventDoneColor: Colors.amber,
            bottomBarColor: Colors.deepOrange,
            onRangeSelected: (range) {
              print('selected Day ${range.from},${range.to}');
            },
            onDateSelected: (date) {
              return _handleData(date);
            },
            events: events,
            isExpanded: true,
            dayOfWeekStyle: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
            bottomBarTextStyle: TextStyle(
              color: Colors.white,
            ),
            hideBottomBar: false,
            hideArrows: false,
            weekDays: [
              'Mon',
              'Tue',
              'Wed',
              'Thu',
              'Fri',
              'Sat',
              'Sun',
            ],
          ),
        ),
      ),
    );
  }
}
