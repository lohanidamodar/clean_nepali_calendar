part of clean_nepali_calendar;

class _DayWidget extends StatelessWidget {
  const _DayWidget({
    Key key,
    this.isSelectedDay,
    this.disabled,
    this.isCurrentDay,
    this.label,
    this.text,
    this.onTap,
  }) : super(key: key);

  final bool isSelectedDay;
  final bool disabled;
  final bool isCurrentDay;
  final String label;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    var itemStyle = themeData.textTheme.body1;

    if (isSelectedDay) {
      // The selected day gets a circle background highlight, and a contrasting text color.
      itemStyle = themeData.accentTextTheme.body2;
    } else if (disabled) {
      itemStyle =
          themeData.textTheme.body1.copyWith(color: themeData.disabledColor);
    } else if (isCurrentDay) {
      // The current day gets a different text color.
      itemStyle =
          themeData.textTheme.body2.copyWith(color: themeData.accentColor);
    }
    Decoration _buildCellDecoration() {
      if (isSelectedDay) {
        return BoxDecoration(
          color: themeData.accentColor,
          shape: BoxShape.circle,
        );
      } else if (disabled) {
        return BoxDecoration(
          shape: BoxShape.circle,
        );
      } else if (isCurrentDay) {
        return BoxDecoration(
          shape: BoxShape.circle,
        );
      }else{
        return BoxDecoration(
          shape: BoxShape.circle,
        );
      }
    }

   return AnimatedContainer(
      duration: Duration(milliseconds: 2000),
      decoration: _buildCellDecoration(),
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
  }
}
