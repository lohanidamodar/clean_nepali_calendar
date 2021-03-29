//  Copyright (c) 2019 Aleksander Woźniak
//  Licensed under Apache License v2.0

part of clean_nepali_calendar;

/// Class containing styling and configuration of `CleanNepaliCalendar`'s header.
class HeaderStyle {
  /// Responsible for making title Text centered.
  final bool centerHeaderTitle;

  /// Use to customize header's title text (eg. with different `DateFormat`).
  /// You can use `String` transformations to further customize the text.
  /// Defaults to simple `'yMMMM'` format (eg. January 2019, February 2019, March 2019, etc.).
  ///
  /// Example usage:
  /// ```dart
  /// titleTextBuilder: (date, locale) => DateFormat.yM(locale).format(date),
  /// ```
  final TextBuilder? titleTextBuilder;

  /// Style for title Text (month-year) displayed in header.
  final TextStyle titleTextStyle;

  /// Inside padding for left chevron.
  final EdgeInsets leftChevronPadding;

  /// Inside padding for right chevron.
  final EdgeInsets rightChevronPadding;

  /// Icon used for left chevron.
  /// Defaults to black `Icons.chevron_left`.
  final Icon leftChevronIcon;

  /// Icon used for right chevron.
  /// Defaults to black `Icons.chevron_right`.
  final Icon rightChevronIcon;

  /// Header decoration, used to draw border or shadow or change color of the header
  /// Defaults to empty BoxDecoration.
  final BoxDecoration decoration;
  /// enable or disable fadeTransition animation on header when changing the month
  final bool enableFadeTransition;

  const HeaderStyle({
    this.centerHeaderTitle = true,
    this.titleTextBuilder,
    this.titleTextStyle = const TextStyle(fontSize: 17.0),
    this.leftChevronPadding = const EdgeInsets.all(8.0),
    this.rightChevronPadding = const EdgeInsets.all(8.0),
    this.leftChevronIcon = const Icon(Icons.chevron_left, color: Colors.black),
    this.rightChevronIcon =
        const Icon(Icons.chevron_right, color: Colors.black),
    this.decoration = const BoxDecoration(),
    this.enableFadeTransition = true,
  });
}
