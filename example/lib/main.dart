import 'package:clean_nepali_calendar/clean_nepali_calendar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Nepali Calendar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final NepaliCalendarController _nepaliCalendarController = NepaliCalendarController();
  @override
  Widget build(BuildContext context){
    final NepaliDateTime first =NepaliDateTime(2075,5);
    final NepaliDateTime last = NepaliDateTime(2077,3);
    return Scaffold(
      appBar: AppBar(
        title: Text('Clean Nepali Calendar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RaisedButton(
              onPressed: (){
                print(_nepaliCalendarController.selectedDay);
                _nepaliCalendarController.setSelectedDay(NepaliDateTime(2077,1,1));
              },
            ),
            CleanNepaliCalendar(
              controller: _nepaliCalendarController,
              onHeaderLongPressed: (date) {
                print("header long pressed $date");
              },
              onHeaderTapped: (date) {
                print("header tapped $date");
              },
              calendarStyle: CalendarStyle(
                selectedColor: Colors.deepOrange,
                dayStyle: TextStyle(fontWeight: FontWeight.bold),
                todayStyle: TextStyle(
                  fontSize: 20.0,
                ),
                todayColor: Colors.orange.shade400,
                highlightSelected: true,
                renderDaysOfWeek: true,
                highlightToday: true,
              ),
              headerStyle: HeaderStyle(
                centerHeaderTitle: false,
                titleTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange,fontSize: 20.0),
              ),
              initialDate: NepaliDateTime.now(),
              firstDate: first,
              lastDate: last,
              language: Language.nepali,
              onDaySelected: (day){
                print(day.toString());
              },
              
            ),
          ],
        ),
      ),
    );
  }
}