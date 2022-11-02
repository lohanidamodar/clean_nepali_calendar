part of clean_nepali_calendar;

typedef _SelectedDayCallback = void Function(NepaliDateTime day, {bool runCallback});

class NepaliCalendarController {
  NepaliDateTime? get selectedDay => _selectedDay;
  NepaliDateTime? _selectedDay;
  _SelectedDayCallback? _selectedDayCallback;

  void _init({
    required _SelectedDayCallback selectedDayCallback,
    required NepaliDateTime initialDay,
  }) {
    _selectedDayCallback = selectedDayCallback;
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
      _selectedDayCallback?.call(value, runCallback: runCallback);
    }
  }
}
