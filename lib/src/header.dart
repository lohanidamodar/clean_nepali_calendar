part of clean_nepali_calendar;

typedef HeaderBuilder = Widget Function(
  BoxDecoration decoration,
  double height,
  Function nextMonthHandler,
  Function prevMonthHandler,
  NepaliDateTime nepaliDateTime,
);

class _CalendarHeader extends StatelessWidget {
  const _CalendarHeader({
    Key? key,
    required Language language,
    required Animation<double> chevronOpacityAnimation,
    required bool isDisplayingFirstMonth,
    required NepaliDateTime previousMonthDate,
    required this.date,
    required bool isDisplayingLastMonth,
    required NepaliDateTime nextMonthDate,
    required HeaderStyle headerStyle,
    required Function() handleNextMonth,
    required Function() handlePreviousMonth,
    this.onHeaderTapped,
    this.onHeaderLongPressed,
    required changeToToday,
    HeaderBuilder? headerBuilder,
  })  : _chevronOpacityAnimation = chevronOpacityAnimation,
        _isDisplayingFirstMonth = isDisplayingFirstMonth,
        _previousMonthDate = previousMonthDate,
        _isDisplayingLastMonth = isDisplayingLastMonth,
        _nextMonthDate = nextMonthDate,
        _headerStyle = headerStyle,
        _handleNextMonth = handleNextMonth,
        _handlePreviousMonth = handlePreviousMonth,
        _language = language,
        _changeToToday = changeToToday,
        _headerBuilder = headerBuilder,
        super(key: key);

  final Animation<double> _chevronOpacityAnimation;
  final bool _isDisplayingFirstMonth;
  final NepaliDateTime _previousMonthDate;
  final NepaliDateTime date;
  final bool _isDisplayingLastMonth;
  final NepaliDateTime _nextMonthDate;
  final HeaderStyle _headerStyle;
  final Function() _handleNextMonth;
  final Function() _handlePreviousMonth;
  final Function() _changeToToday;
  final Language _language;
  final HeaderGestureCallback? onHeaderTapped;
  final HeaderGestureCallback? onHeaderLongPressed;
  final HeaderBuilder? _headerBuilder;

  _onHeaderTapped() {
    if (onHeaderTapped != null) {
      onHeaderTapped!(date);
    }
  }

  _onHeaderLongPressed() {
    if (onHeaderLongPressed != null) {
      onHeaderLongPressed!(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onHeaderTapped,
      onLongPress: _onHeaderLongPressed,
      child: (_headerBuilder != null)
          ? _headerBuilder!(_headerStyle.decoration, _kDayPickerRowHeight,
              _handleNextMonth, _handlePreviousMonth, date)
          : Container(
              decoration: _headerStyle.decoration,
              height: _kDayPickerRowHeight,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _headerStyle.centerHeaderTitle
                        ? Center(
                            child: _buildTitle(),
                          )
                        : _buildTitle(),
                  ),
                  InkWell(
                    onTap: _changeToToday,
                    child: Text(
                      _language == Language.nepali ? "आज" : 'Today',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Semantics(
                    sortKey: _MonthPickerSortKey.previousMonth,
                    child: FadeTransition(
                      opacity: _chevronOpacityAnimation,
                      child: IconButton(
                        padding: _headerStyle.leftChevronPadding,
                        icon: _headerStyle.leftChevronIcon,
                        tooltip: _isDisplayingFirstMonth
                            ? null
                            : 'Previous month ${formattedMonth(_previousMonthDate.month, Language.english)} ${_previousMonthDate.year}',
                        onPressed: _isDisplayingFirstMonth
                            ? null
                            : _handlePreviousMonth,
                      ),
                    ),
                  ),
                  Semantics(
                    sortKey: _MonthPickerSortKey.nextMonth,
                    child: FadeTransition(
                      opacity: _chevronOpacityAnimation,
                      child: IconButton(
                        padding: _headerStyle.rightChevronPadding,
                        icon: _headerStyle.rightChevronIcon,
                        tooltip: _isDisplayingLastMonth
                            ? null
                            : 'Next month ${formattedMonth(_nextMonthDate.month, Language.english)} ${_nextMonthDate.year}',
                        onPressed:
                            _isDisplayingLastMonth ? null : _handleNextMonth,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildTitle() {
    return FadeTransition(
      opacity: _chevronOpacityAnimation,
      child: ExcludeSemantics(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    _headerStyle.titleTextBuilder != null
                        ? _headerStyle.titleTextBuilder!(
                            date,
                            _language,
                          )
                        : '${formattedMonth(date.month, _language)} - ${_language == Language.english ? date.year : NepaliUnicode.convert('${date.year}')}',
                    style: _headerStyle.titleTextStyle,
                    textAlign: _headerStyle.centerHeaderTitle
                        ? TextAlign.center
                        : TextAlign.start,
                  ),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
              Text(
                _headerStyle.titleTextBuilder != null
                    ? _headerStyle.titleTextBuilder!(
                        date,
                        _language,
                      )
                    : "${getFormattedEnglishMonth(date.toDateTime().month)}/${getFormattedEnglishMonth(date.toDateTime().month + 1)} - ${date.toDateTime().year}",
                style: _headerStyle.titleTextStyle
                    .copyWith(fontWeight: FontWeight.normal, fontSize: 14),
                textAlign: _headerStyle.centerHeaderTitle
                    ? TextAlign.center
                    : TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getFormattedEnglishMonth(int mnth) {
  switch (mnth) {
    case DateTime.january:
      return "Jan";
    case DateTime.february:
      return "Feb";
    case DateTime.march:
      return "Mar";
    case DateTime.april:
      return "April";
    case DateTime.june:
      return "Jun";
    case DateTime.july:
      return "Jul";
    case DateTime.august:
      return "Aug";
    case DateTime.september:
      return "Sep";
    case DateTime.october:
      return "Oct";
    case DateTime.november:
      return "Nov";
    case DateTime.december:
      return "Dec";
    default:
      return "Jan";
  }
}
