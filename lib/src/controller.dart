part of clean_nepali_calendar;

typedef void _SelectedDayCallback(NepaliDateTime day, {bool runCallback});

class NepaliCalendarController {
  NepaliDateTime get selectedDay => _selectedDay;
  NepaliDateTime get currentMonth => _currentMonth;
  NepaliDateTime _selectedDay;
  NepaliDateTime _currentMonth;
  _SelectedDayCallback _selectedDayCallback;
  _SelectedDayCallback _currentMonthCallback;

  void _init({
    @required _SelectedDayCallback selectedDayCallback,
    @required _SelectedDayCallback currentMonthCallback,
    @required NepaliDateTime initialDay,
  }) {
    _selectedDayCallback = selectedDayCallback;
    _currentMonthCallback = currentMonthCallback;
    _selectedDay = initialDay;
  }

  void setSelectedDay(
    NepaliDateTime value, {
    bool isProgrammatic = true,
    bool animate = true,
    bool runCallback = false,
  }) {
    _selectedDay = value;

    if (isProgrammatic && _selectedDayCallback != null) {
      _selectedDayCallback(value, runCallback: runCallback);
    }
  }

  // void setCurrentMonth(
  //   NepaliDateTime value, {
  //   bool isProgrammatic = true,
  //   bool animate = true,
  //   bool runCallback = false,
  // }) {
  //   _currentMonth = value;

  //   if (isProgrammatic && _currentMonthCallback != null) {
  //     _currentMonthCallback(value, runCallback: runCallback);
  //   }
  // }
}
