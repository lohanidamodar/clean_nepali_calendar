part of clean_nepali_calendar;

typedef DateCellBuilder = Widget Function(
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
    Key? key,
    required this.isSelected,
    required this.isDisabled,
    required this.isToday,
    required this.label,
    required this.text,
    required this.onTap,
    required this.calendarStyle,
    required this.day,
    this.builder,
    this.isWeekend = false,
  }) : super(key: key);

  final bool isSelected;
  final bool isDisabled;
  final bool isToday;
  final String label;
  final String text;
  final Function() onTap;
  final CalendarStyle calendarStyle;
  final NepaliDateTime day;
  final DateCellBuilder? builder;
  final bool isWeekend;

  @override
  Widget build(BuildContext context) {
    Decoration buildCellDecoration() {
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
        return const BoxDecoration(
          shape: BoxShape.circle,
        );
      }
    }

    TextStyle buildCellTextStyle() {
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
        ? builder!(isToday, isSelected, isDisabled, day, label, text,
            calendarStyle, isWeekend)
        : AnimatedContainer(
            duration: const Duration(milliseconds: 2000),
            decoration: buildCellDecoration(),
            child: Center(
              child: Semantics(
                label: label,
                selected: isSelected,
                child: ExcludeSemantics(
                  child: Text(text,
                      style: buildCellTextStyle().copyWith(
                          color: isWeekend
                              ? calendarStyle.weekEndTextColor
                              : null)),
                ),
              ),
            ),
          );
  }
}
