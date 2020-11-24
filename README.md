# Clean Nepali Calendar

Flutter package to display Nepali Calendar. Inspired greatly from [nepali_date_picker](https://pub.dev/packages/nepali_date_picker) and [table_calendar](https://pub.dev/packages/table_calendar).

[![Pub Package](https://img.shields.io/pub/v/clean_nepali_calendar.svg?style=flat-square)](https://pub.dev/packages/clean_nepali_calendar) ![Publish](https://github.com/lohanidamodar/clean_nepali_calendar/workflows/Publish/badge.svg)


Highly customizable, feature-packed Flutter Nepali Calendar package.

| ![Image](https://raw.githubusercontent.com/lohanidamodar/clean_nepali_calendar/master/demo/demo1.gif) | ![Image](https://raw.githubusercontent.com/lohanidamodar/clean_nepali_calendar/master/demo/demo2.png) | ![Image](https://raw.githubusercontent.com/lohanidamodar/clean_nepali_calendar/master/demo/demo3.png) |
| ------------- |:-------------:| -----:|


## Features

* Extensive, yet easy to use API
* View in Unicode Nepali or Roman literals
* Gesture handling
* Specifying available date range
* Highly customizable

## Usage

Make sure to check out [example project](https://github.com/lohanidamodar/clean_nepali_calendar/tree/master/example). 
For additional info please refer to [API docs](https://pub.dartlang.org/documentation/clean_nepali_calendar/latest/clean_nepali_calendar/clean_nepali_calendar-library.html).

### Installation

Add to pubspec.yaml:

```yaml
dependencies:
  clean_nepali_calendar: latest
```

Then import it to your project:

```dart
import 'package:clean_nepali_calendar/clean_nepali_calendar.dart';
```

Then create and use the `NepaliCalendarController` and instantiate the `CleanNepaliCalendar` widget. works out of box;

```dart
@override
void initState() {
  super.initState();
  _calendarController = NepaliCalendarController();
}

@override
Widget build(BuildContext context) {
  return CleanNepaliCalendar(
    controller: _calendarController,
    onDaySelected: (day){
        print(day.toString());
    },
  );
}
```

Check out [example project](https://github.com/lohanidamodar/clean_nepali_calendar/tree/master/example) more detailed information.
