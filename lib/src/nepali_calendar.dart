part of clean_nepali_calendar;

typedef TextBuilder = String Function(NepaliDateTime date, Language language);
typedef HeaderGestureCallback = void Function(NepaliDateTime focusedDay);

String formattedMonth(
  int month, [
  Language? language,
]) =>
    NepaliDateFormat.MMMM(language).format(
      NepaliDateTime(1970, month),
    );

const int _kMaxDayPickerRowCount = 6; // A 31 day month that starts on Saturday.
// Two extra rows: one for the day-of-week header and one for the month header.
const double _kMaxDayPickerHeight =
    _kDayPickerRowHeight * (_kMaxDayPickerRowCount + 2);

class CleanNepaliCalendar extends StatefulWidget {
  const CleanNepaliCalendar({
    Key? key,
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
    required this.controller,
    this.headerDayType = HeaderDayType.initial,
    this.headerDayBuilder,
    this.dateCellBuilder,
    this.enableVibration = true,
    this.headerBuilder,
  }) : super(key: key);

  final NepaliDateTime? initialDate;
  final NepaliDateTime? firstDate;
  final NepaliDateTime? lastDate;
  final Function(NepaliDateTime)? onDaySelected;
  final SelectableDayPredicate? selectableDayPredicate;
  final Language language;
  final CalendarStyle calendarStyle;
  final HeaderStyle headerStyle;
  final HeaderGestureCallback? onHeaderTapped;
  final HeaderGestureCallback? onHeaderLongPressed;
  final NepaliCalendarController controller;
  final HeaderDayType headerDayType;
  final HeaderDayBuilder? headerDayBuilder;
  final DateCellBuilder? dateCellBuilder;
  final HeaderBuilder? headerBuilder;
  final bool enableVibration;

  @override
  CleanNepaliCalendarState createState() => CleanNepaliCalendarState();
}

class CleanNepaliCalendarState extends State<CleanNepaliCalendar> {
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

  late MaterialLocalizations localizations;
  late TextDirection textDirection;

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

  late NepaliDateTime _selectedDate;
  final GlobalKey _pickerKey = GlobalKey();

  void _vibrate() {
    HapticFeedback.vibrate();
  }

  void _handleDayChanged(NepaliDateTime value, {bool runCallback = true}) {
    if (widget.enableVibration) _vibrate();
    setState(() {
      widget.controller.setSelectedDay(value, isProgrammatic: false);
      _selectedDate = value;
    });
    if (runCallback && widget.onDaySelected != null) {
      widget.onDaySelected!(value);
    }
  }

  Widget _buildPicker() {
    return _MonthView(
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
      headerDayType: widget.headerDayType,
      headerDayBuilder: widget.headerDayBuilder,
      dateCellBuilder: widget.dateCellBuilder,
      headerBuilder: widget.headerBuilder,
      dragStartBehavior: DragStartBehavior.start,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildPicker();
  }
}

typedef SelectableDayPredicate = bool Function(NepaliDateTime day);
