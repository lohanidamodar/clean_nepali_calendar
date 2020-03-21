part of clean_nepali_calendar;

String formattedMonth(
  int month, [
  Language language,
]) =>
    NepaliDateFormat.MMMM(language).format(
      NepaliDateTime(0, month),
    );

const int _kMaxDayPickerRowCount = 6; // A 31 day month that starts on Saturday.
// Two extra rows: one for the day-of-week header and one for the month header.
const double _kMaxDayPickerHeight =
    _kDayPickerRowHeight * (_kMaxDayPickerRowCount + 2);

class CleanNepaliCalendar extends StatefulWidget {
  const CleanNepaliCalendar({
    Key key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.selectableDayPredicate,
    this.language,
    this.onDaySelected,
  }) : super(key: key);

  final NepaliDateTime initialDate;
  final NepaliDateTime firstDate;
  final NepaliDateTime lastDate;
  final Function(NepaliDateTime) onDaySelected;
  final SelectableDayPredicate selectableDayPredicate;
  final Language language;

  @override
  _CleanNepaliCalendarState createState() => _CleanNepaliCalendarState();
}

class _CleanNepaliCalendarState extends State<CleanNepaliCalendar> {
  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  bool _announcedInitialDate = false;

  MaterialLocalizations localizations;
  TextDirection textDirection;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localizations = MaterialLocalizations.of(context);
    textDirection = Directionality.of(context);
    if (!_announcedInitialDate) {
      _announcedInitialDate = true;
      SemanticsService.announce(
        NepaliDateFormat.yMMMMd().format(_selectedDate),
        textDirection,
      );
    }
  }

  @override
  void didUpdateWidget(CleanNepaliCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectedDate = widget.initialDate;
  }

  NepaliDateTime _selectedDate;
  final GlobalKey _pickerKey = GlobalKey();

  void _vibrate() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        HapticFeedback.vibrate();
        break;
      case TargetPlatform.iOS:
        break;
    }
  }

  void _handleDayChanged(NepaliDateTime value) {
    _vibrate();
    setState(() {
      _selectedDate = value;
    });
    if (widget.onDaySelected != null) widget.onDaySelected(value);
  }

  Widget _buildPicker() {
    return _MonthView(
      key: _pickerKey,
      language: widget.language,
      selectedDate: _selectedDate,
      onChanged: _handleDayChanged,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      selectableDayPredicate: widget.selectableDayPredicate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildPicker();
  }
}

typedef SelectableDayPredicate = bool Function(NepaliDateTime day);
