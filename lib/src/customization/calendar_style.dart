//  Copyright (c) 2019 Aleksander Woźniak
//  Licensed under Apache License v2.0

part of clean_nepali_calendar;

/// Class containing styling for `TableCalendar`'s content.
class CalendarStyle {
  /// Style of foreground Text for regular weekdays.
  final TextStyle dayStyle;

  /// Style of foreground Text for selected day.
  final TextStyle selectedStyle;

  /// Style of foreground Text for today.
  final TextStyle todayStyle;

  /// Style of foreground Text for days outside of `startDay` - `endDay` Date range.
  final TextStyle unavailableStyle;

  /// Background Color of selected day.
  final Color selectedColor;

  /// Background Color of today.
  final Color todayColor;

  /// Determines whether the row of days of the week should be rendered or not.
  final bool renderDaysOfWeek;

  /// Padding of `CleanNepaliCalendar`'s content.
  final EdgeInsets contentPadding;

  /// Specifies whether or not SelectedDay should be highlighted.
  final bool highlightSelected;

  /// Specifies whether or not Today should be highlighted.
  final bool highlightToday;

  /// show different colors for weekend, currently only saturday
  final Color weekEndTextColor;

  const CalendarStyle({
    this.dayStyle = const TextStyle(),
    this.selectedStyle = const TextStyle(
        color: Color(0xFFFAFAFA), fontSize: 16.0), // Material grey[50]
    this.todayStyle = const TextStyle(
        color: Color(0xFFFAFAFA), fontSize: 16.0), // Material grey[50]
    this.unavailableStyle = const TextStyle(color: Color(0xFFBFBFBF)),
    this.selectedColor = const Color(0xFF5C6BC0), // Material indigo[400]
    this.todayColor = const Color(0xFF9FA8DA), // Material indigo[200]
    this.renderDaysOfWeek = true,
    this.contentPadding =
        const EdgeInsets.only(bottom: 4.0, left: 8.0, right: 8.0),
    this.highlightSelected = true,
    this.highlightToday = true,
    this.weekEndTextColor = Colors.red,
  });
}
