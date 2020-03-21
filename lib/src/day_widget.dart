part of clean_nepali_calendar;

class DayWidget extends StatelessWidget {
  const DayWidget({
    Key key,
    this.isSelectedDay,
    this.disabled,
    this.isCurrentDay,
    this.label,
    this.text,
    this.onTap,
    this.dragStartBehavior,
  }) : super(key: key);

  final bool isSelectedDay;
  final bool disabled;
  final bool isCurrentDay;
  final String label;
  final String text;
  final Function() onTap;
  final DragStartBehavior dragStartBehavior;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    BoxDecoration decoration;
    var itemStyle = themeData.textTheme.body1;

    if (isSelectedDay) {
      // The selected day gets a circle background highlight, and a contrasting text color.
      itemStyle = themeData.accentTextTheme.body2;
      decoration = BoxDecoration(
        color: themeData.accentColor,
        shape: BoxShape.circle,
      );
    } else if (disabled) {
      itemStyle =
          themeData.textTheme.body1.copyWith(color: themeData.disabledColor);
    } else if (isCurrentDay) {
      // The current day gets a different text color.
      itemStyle =
          themeData.textTheme.body2.copyWith(color: themeData.accentColor);
    }

    Widget dayWidget = Container(
      decoration: decoration,
      child: Center(
        child: Semantics(
          label: label,
          selected: isSelectedDay,
          child: ExcludeSemantics(
            child: Text(text, style: itemStyle),
          ),
        ),
      ),
    );

    if (!disabled) {
      dayWidget = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: dayWidget,
        dragStartBehavior: dragStartBehavior,
      );
    }
    return dayWidget;
  }
}
