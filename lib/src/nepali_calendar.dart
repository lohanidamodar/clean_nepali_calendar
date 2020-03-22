part of clean_nepali_calendar;

typedef String TextBuilder(NepaliDateTime date, Language language);
typedef void HeaderGestureCallback(NepaliDateTime focusedDay);

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
    this.language = Language.nepali,
    this.onDaySelected,
    this.headerStyle = const HeaderStyle(),
    this.calendarStyle = const CalendarStyle(),
    this.onHeaderTapped,
    this.onHeaderLongPressed,
    @required this.controller,
  }) : super(key: key);

  final NepaliDateTime initialDate;
  final NepaliDateTime firstDate;
  final NepaliDateTime lastDate;
  final Function(NepaliDateTime) onDaySelected;
  final SelectableDayPredicate selectableDayPredicate;
  final Language language;
  final CalendarStyle calendarStyle;
  final HeaderStyle headerStyle;
  final HeaderGestureCallback onHeaderTapped;
  final HeaderGestureCallback onHeaderLongPressed;
  final NepaliCalendarController controller;

  @override
  _CleanNepaliCalendarState createState() => _CleanNepaliCalendarState();
}

class _CleanNepaliCalendarState extends State<CleanNepaliCalendar> {
  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? NepaliDateTime.now();
    widget.controller._init(
      selectedDayCallback: _handleDayChanged,
      initialDay: widget.initialDate ?? NepaliDateTime.now(),
    );
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
    _selectedDate = widget.initialDate ?? NepaliDateTime.now();
    widget.controller
        .setSelectedDay(widget.initialDate ?? NepaliDateTime.now());
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

  void _handleDayChanged(NepaliDateTime value, {bool runCallback = true}) {
    _vibrate();
    setState(() {
      widget.controller.setSelectedDay(value, isProgrammatic: false);
      _selectedDate = value;
    });
    if (runCallback && widget.onDaySelected != null)
      widget.onDaySelected(value);
  }

  Widget _buildPicker() {
    return Padding(
      padding: widget.calendarStyle.contentPadding,
      child: _MonthView(
        key: _pickerKey,
        headerStyle: widget.headerStyle,
        calendarStyle: widget.calendarStyle,
        language: widget.language,
        selectedDate: _selectedDate,
        onChanged: _handleDayChanged,
        firstDate: widget.firstDate ?? NepaliDateTime(2000, 1),
        lastDate: widget.lastDate ?? NepaliDateTime(2095, 12),
        selectableDayPredicate: widget.selectableDayPredicate,
        onHeaderTapped: widget.onHeaderTapped,
        onHeaderLongPressed: widget.onHeaderLongPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildPicker();
  }
}

typedef SelectableDayPredicate = bool Function(NepaliDateTime day);
