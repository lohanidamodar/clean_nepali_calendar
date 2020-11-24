part of clean_nepali_calendar;

typedef Widget DateCellBuilder(
  bool isToday,
  bool isSelected,
  bool isDisabled,
  NepaliDateTime nepaliDate,
  String label,
  String text,
  CalendarStyle calendarStyle,
  bool isWeekend,
);

class _DayWidget extends StatelessWidget {
  const _DayWidget({
    Key key,
    @required this.isSelected,
    @required this.isDisabled,
    @required this.isToday,
    @required this.label,
    @required this.text,
    @required this.onTap,
    @required this.calendarStyle,
    @required this.day,
    this.builder,
    this.isWeekend,
  }) : super(key: key);

  final bool isSelected;
  final bool isDisabled;
  final bool isToday;
  final String label;
  final String text;
  final Function() onTap;
  final CalendarStyle calendarStyle;
  final NepaliDateTime day;
  final DateCellBuilder builder;
  final bool isWeekend;

  @override
  Widget build(BuildContext context) {
    Decoration _buildCellDecoration() {
      if (isSelected && calendarStyle.highlightSelected) {
        return BoxDecoration(
          color: calendarStyle.selectedColor,
          shape: BoxShape.circle,
        );
      } else if (isToday && calendarStyle.highlightToday) {
        return BoxDecoration(
          shape: BoxShape.circle,
          color: calendarStyle.todayColor,
        );
      } else {
        return BoxDecoration(
          shape: BoxShape.circle,
        );
      }
    }

    TextStyle _buildCellTextStyle() {
      if (isDisabled) {
        return calendarStyle.unavailableStyle;
      } else if (isSelected && calendarStyle.highlightSelected) {
        return calendarStyle.selectedStyle;
      } else if (isToday && calendarStyle.highlightToday) {
        return calendarStyle.todayStyle;
      } else {
        return calendarStyle.dayStyle;
      }
    }

    return (builder != null)
        ? builder(isToday, isSelected, isDisabled, day, label, text,
            calendarStyle, isWeekend)
        : AnimatedContainer(
            duration: Duration(milliseconds: 2000),
            decoration: _buildCellDecoration(),
            child: Center(
              child: Semantics(
                label: label,
                selected: isSelected,
                child: ExcludeSemantics(
                  child: Text(text, style: _buildCellTextStyle()),
                ),
              ),
            ),
          );
  }
}
