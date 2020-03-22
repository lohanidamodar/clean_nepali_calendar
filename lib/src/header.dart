part of clean_nepali_calendar;

class _CalendarHeader extends StatelessWidget {
  const _CalendarHeader({
    Key key,
    @required Language language,
    @required Animation<double> chevronOpacityAnimation,
    @required bool isDisplayingFirstMonth,
    @required NepaliDateTime previousMonthDate,
    @required NepaliDateTime date,
    @required bool isDisplayingLastMonth,
    @required NepaliDateTime nextMonthDate,
    @required HeaderStyle headerStyle,
    @required Function() handleNextMonth,
    @required Function() handlePreviousMonth,
    @required this.onHeaderTapped,
    @required this.onHeaderLongPressed,
  })  : _chevronOpacityAnimation = chevronOpacityAnimation,
        _isDisplayingFirstMonth = isDisplayingFirstMonth,
        _previousMonthDate = previousMonthDate,
        date = date,
        _isDisplayingLastMonth = isDisplayingLastMonth,
        _nextMonthDate = nextMonthDate,
        _headerStyle = headerStyle,
        _handleNextMonth = handleNextMonth,
        _handlePreviousMonth = handlePreviousMonth,
        _language = language,
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
  final Language _language;
  final HeaderGestureCallback onHeaderTapped;
  final HeaderGestureCallback onHeaderLongPressed;

  _onHeaderTapped() {
    if (onHeaderTapped != null) {
      onHeaderTapped(date);
    }
  }

  _onHeaderLongPressed() {
    if (onHeaderLongPressed != null) {
      onHeaderLongPressed(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _headerStyle.decoration,
      height: _kDayPickerRowHeight,
      child: Row(
        children: <Widget>[
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
                onPressed:
                    _isDisplayingFirstMonth ? null : _handlePreviousMonth,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: _onHeaderTapped,
              onLongPress: _onHeaderLongPressed,
              child: _headerStyle.centerHeaderTitle
                  ? Center(
                      child: _buildTitle(),
                    )
                  : _buildTitle(),
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
                onPressed: _isDisplayingLastMonth ? null : _handleNextMonth,
              ),
            ),
          ),
        ],
      ),
    );
  }

  FadeTransition _buildTitle() {
    return FadeTransition(
      opacity: _chevronOpacityAnimation,
      child: ExcludeSemantics(
        child: Text(
          _headerStyle.titleTextBuilder != null
              ? _headerStyle.titleTextBuilder(
                  date,
                  _language,
                )
              : '${formattedMonth(date.month, _language)} ${_language == Language.english ? date.year : NepaliUnicode.convert('${date.year}')}',
          style: _headerStyle.titleTextStyle,
          textAlign: _headerStyle.centerHeaderTitle
              ? TextAlign.center
              : TextAlign.start,
        ),
      ),
    );
  }
}
