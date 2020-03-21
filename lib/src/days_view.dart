part of clean_nepali_calendar;

const double _kDayPickerRowHeight = 42.0;

class _DayPickerGridDelegate extends SliverGridDelegate {
  const _DayPickerGridDelegate();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    const columnCount = 7;
    final tileWidth = constraints.crossAxisExtent / columnCount;
    final tileHeight = math.min(_kDayPickerRowHeight,
        constraints.viewportMainAxisExtent / (_kMaxDayPickerRowCount + 1));
    return SliverGridRegularTileLayout(
      crossAxisCount: columnCount,
      mainAxisStride: tileHeight,
      crossAxisStride: tileWidth,
      childMainAxisExtent: tileHeight,
      childCrossAxisExtent: tileWidth,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(_DayPickerGridDelegate oldDelegate) => false;
}

const _DayPickerGridDelegate _kDayPickerGridDelegate = _DayPickerGridDelegate();

class _DaysView extends StatelessWidget {
  _DaysView({
    Key key,
    @required this.selectedDate,
    @required this.currentDate,
    @required this.onChanged,
    @required this.firstDate,
    @required this.lastDate,
    @required this.displayedMonth,
    @required this.language,
    this.selectableDayPredicate,
    this.dragStartBehavior = DragStartBehavior.start,
  })  : assert(selectedDate != null),
        assert(currentDate != null),
        assert(onChanged != null),
        assert(displayedMonth != null),
        assert(dragStartBehavior != null),
        assert(!firstDate.isAfter(lastDate)),
        assert(selectedDate.isAfter(firstDate)),
        super(key: key);

  final NepaliDateTime selectedDate;

  final NepaliDateTime currentDate;

  final ValueChanged<NepaliDateTime> onChanged;

  final NepaliDateTime firstDate;

  final NepaliDateTime lastDate;

  final NepaliDateTime displayedMonth;

  final SelectableDayPredicate selectableDayPredicate;

  final DragStartBehavior dragStartBehavior;

  final Language language;

  List<Widget> _getDayHeaders(Language language, TextStyle headerStyle) {
    return (language == Language.english
            ? ['S', 'M', 'T', 'W', 'T', 'F', 'S']
            : ['आ', 'सो', 'मं', 'बु', 'वि', 'शु', 'श'])
        .map(
          (label) => ExcludeSemantics(
            child: Center(
              child: Text(label, style: headerStyle),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final year = displayedMonth.year;
    final month = displayedMonth.month;
    final daysInMonth = displayedMonth.totalDays;
    final firstDayOffset = displayedMonth.weekDay - 1;
    final labels = <Widget>[];
    labels.addAll(
      _getDayHeaders(language, themeData.textTheme.caption),
    );
    for (var i = 0; true; i += 1) {
      // 1-based day of month, e.g. 1-31 for January, and 1-29 for February on
      // a leap year.
      final day = i - firstDayOffset + 1;
      if (day > daysInMonth) break;
      if (day < 1) {
        labels.add(Container());
      } else {
        final dayToBuild = NepaliDateTime(year, month, day);
        final disabled = dayToBuild.isAfter(lastDate) ||
            dayToBuild.isBefore(firstDate) ||
            (selectableDayPredicate != null &&
                !selectableDayPredicate(dayToBuild));

        final isSelectedDay = selectedDate.year == year &&
            selectedDate.month == month &&
            selectedDate.day == day;
        final bool isCurrentDay = currentDate.year == year &&
            currentDate.month == month &&
            currentDate.day == day;
        final semanticLabel =
            '${formattedMonth(month, Language.english)} $day, $year';
        final text =
            '${language == Language.english ? day : NepaliUnicode.convert('$day')}';

        Widget dayWidget = _DayWidget(
          disabled: disabled,
          text: text,
          label: semanticLabel,
          isCurrentDay: isCurrentDay,
          isSelectedDay: isSelectedDay,
          onTap: () {
            onChanged(dayToBuild);
          },
        );

        if (!disabled) {
          dayWidget = GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              onChanged(dayToBuild);
            },
            child: dayWidget,
            dragStartBehavior: dragStartBehavior,
          );
        }
        labels.add(dayWidget);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          Container(
            height: _kDayPickerRowHeight,
            child: Center(
              child: ExcludeSemantics(
                child: Text(
                  '${formattedMonth(month, language)} ${language == Language.english ? year : NepaliUnicode.convert('$year')}',
                  style: themeData.textTheme.subhead,
                ),
              ),
            ),
          ),
          Flexible(
            child: GridView.custom(
              gridDelegate: _kDayPickerGridDelegate,
              childrenDelegate:
                  SliverChildListDelegate(labels, addRepaintBoundaries: false),
            ),
          ),
        ],
      ),
    );
  }
}
