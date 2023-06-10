import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HTMaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const HTMaterialLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return locale == const Locale('ht');
  }
  @override
  Future<MaterialLocalizations> load(Locale locale) {
    assert(locale == const Locale('ht'));
    return SynchronousFuture<MaterialLocalizations>(HTLocalizations());
  }
  @override
  bool shouldReload(HTMaterialLocalizationsDelegate old) => false;
}

class HTLocalizations extends MaterialLocalizations {
  HTLocalizations();

  @override
  String get okButtonLabel => 'ht';

  @override
  String formatYear(DateTime date) {
    return date.year.toString();
  }

  @override
  String get keyboardKeyCapsLock => 'Caps Lock';

  @override
  String get keyboardKeyChannelDown => 'Channel Down';

  @override
  String get keyboardKeyChannelUp => 'Channel Up';

  @override
  String get keyboardKeyControl => 'Control';

  @override
  String get keyboardKeyDelete => 'Delete';

  @override
  String get keyboardKeyEject => 'Eject';

  @override
  String get keyboardKeyEnd => 'End';

  @override
  String get keyboardKeyEscape => 'Escape';

  @override
  String get keyboardKeyFn => 'Fn';

  @override
  String get keyboardKeyHome => 'Home';

  @override
  String get keyboardKeyInsert => 'Insert';

  @override
  String get keyboardKeyMeta => 'Meta';

  @override
  String get keyboardKeyMetaMacOs => 'Meta (MacOS)';

  @override
  String get keyboardKeyMetaWindows => 'Meta (Windows)';

  @override
  String get keyboardKeyNumLock => 'Num Lock';

  @override
  String get keyboardKeyNumpad0 => 'Numpad 0';

  @override
  String get keyboardKeyNumpad1 => 'Numpad 1';

  @override
  String get keyboardKeyNumpad2 => 'Numpad 2';

  @override
  String get keyboardKeyNumpad3 => 'Numpad 3';

  @override
  String get keyboardKeyNumpad4 => 'Numpad 4';

  @override
  String get keyboardKeyNumpad5 => 'Numpad 5';

  @override
  String get keyboardKeyNumpad6 => 'Numpad 6';

  @override
  String get keyboardKeyNumpad7 => 'Numpad 7';

  @override
  String get keyboardKeyNumpad8 => 'Numpad 8';

  @override
  String get keyboardKeyNumpad9 => 'Numpad 9';

  @override
  String get keyboardKeyNumpadAdd => 'Numpad Add';

  @override
  String get keyboardKeyNumpadComma => 'Numpad Comma';

  @override
  String get keyboardKeyNumpadDecimal => 'Numpad Decimal';

  @override
  String get keyboardKeyNumpadDivide => 'Numpad Divide';

  @override
  String get keyboardKeyNumpadEnter => 'Numpad Enter';

  @override
  String get keyboardKeyNumpadEqual => 'Numpad Equal';

  @override
  String get keyboardKeyNumpadMultiply => 'Numpad Multiply';

  @override
  String get keyboardKeyNumpadParenLeft => 'Numpad Paren Left';

  @override
  String get keyboardKeyNumpadParenRight => 'Numpad Paren Right';

  @override
  String get keyboardKeyNumpadSubtract => 'Numpad Subtract';

  @override
  String get keyboardKeyPageDown => 'Page Down';

  @override
  String get keyboardKeyPageUp => 'Page Up';

  @override
  String get keyboardKeyPower => 'Power';

  @override
  String get keyboardKeyPowerOff => 'Power Off';

  @override
  String get keyboardKeyPrintScreen => 'Print Screen';

  @override
  String get keyboardKeyScrollLock => 'Scroll Lock';

  @override
  String get keyboardKeySelect => 'Select';

  @override
  String get keyboardKeyShift => 'Shift';

  @override
  String get keyboardKeySpace => 'Space';

  @override
  String get licensesPageTitle => 'Licenses';

  @override
  String get modalBarrierDismissLabel => 'Dismiss';

  @override
  String get moreButtonTooltip => 'More';

  @override
  String get nextMonthTooltip => 'Next month';

  @override
  String get nextPageTooltip => 'Next page';

  @override
  String get openAppDrawerTooltip => 'Open navigation menu';

  @override
  String get pasteButtonLabel => 'Paste';

  @override
  String get popupMenuLabel => 'Popup menu';

  @override
  String get postMeridiemAbbreviation => 'PM';

  @override
  String get previousMonthTooltip => 'Previous month';

  @override
  String get previousPageTooltip => 'Previous page';

  @override
  String get refreshIndicatorSemanticLabel => 'Refresh';

  @override
  String remainingTextFieldCharacterCount(int remaining) {
    return '$remaining remaining';
  }

  @override
  String get reorderItemDown => 'Move down';

  @override
  String get reorderItemLeft => 'Move left';

  @override
  String get reorderItemRight => 'Move right';

  @override
  String get reorderItemToEnd => 'Move to the end';

  @override
  String get reorderItemToStart => 'Move to the start';

  @override
  String get reorderItemUp => 'Move up';

  @override
  String get rowsPerPageTitle => 'Rows per page:';

  @override
  String get saveButtonLabel => 'Save';

  @override
  String get searchFieldLabel => 'Search';

  @override
  String get selectAllButtonLabel => 'Select All';

  @override
  String selectedRowCountTitle(int selectedRowCount) {
    if (selectedRowCount == 0) {
      return 'No items selected';
    } else if (selectedRowCount == 1) {
      return '1 item selected';
    } else {
      return '$selectedRowCount items selected';
    }
  }

  @override
  String get showAccountsLabel => 'Show accounts';

  @override
  String get signedInLabel => 'Signed in';



  @override
  String tabLabel({required int tabIndex, required int tabCount}) {
    return 'Tab $tabIndex of $tabCount';
  }

  @override
  TimeOfDayFormat timeOfDayFormat({bool alwaysUse24HourFormat = false}) {
    return alwaysUse24HourFormat ? TimeOfDayFormat.HH_colon_mm : TimeOfDayFormat.h_colon_mm_space_a;
  }

  @override
  String get timePickerHourModeAnnouncement => 'Select hours';

  @override
  String get timePickerMinuteModeAnnouncement => 'Select minutes';





  @override
  String get viewLicensesButtonLabel => 'VIEW LICENSES';
  @override
  String aboutListTileTitle(String applicationName) {
    return 'About $applicationName';
  }

  @override
  String get alertDialogLabel => 'Alert';

  @override
  String get anteMeridiemAbbreviation => 'AM';

  @override
  String get backButtonTooltip => 'Back';

  @override
  String get bottomSheetLabel => 'Bottom Sheet';

  @override
  String get calendarModeButtonLabel => 'Calendar Mode';

  @override
  String get cancelButtonLabel => 'Cancel';

  @override
  String get closeButtonLabel => 'Close';

  @override
  String get closeButtonTooltip => 'Close';

  @override
  String get continueButtonLabel => 'Continue';

  @override
  String get copyButtonLabel => 'Copy';

  @override
  String get currentDateLabel => 'Current Date';

  @override
  String get cutButtonLabel => 'Cut';

  @override
  String get dateHelpText => 'Select a date';

  @override
  String get dateInputLabel => 'Date';

  @override
  String get dateOutOfRangeLabel => 'Date out of range';

  @override
  String get datePickerHelpText => 'Select a date';

  @override
  String dateRangeEndDateSemanticLabel(String formattedDate) {
    return 'End date: $formattedDate';
  }

  @override
  String get dateRangeEndLabel => 'End Date';

  @override
  String get dateRangePickerHelpText => 'Select a date range';

  @override
  String dateRangeStartDateSemanticLabel(String formattedDate) {
    return 'Start date: $formattedDate';
  }

  @override
  String get dateRangeStartLabel => 'Start Date';

  @override
  String get dateSeparator => ' - ';

  @override
  String get deleteButtonTooltip => 'Delete';

  @override
  String get dialModeButtonLabel => 'Dial Mode';

  @override
  String get dialogLabel => 'Dialog';

  @override
  String get drawerLabel => 'Drawer';

  @override
  int get firstDayOfWeekIndex => 0;

  @override
  String get firstPageTooltip => 'First Page';

  @override
  String formatCompactDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  @override
  String formatDecimal(int number) {
    return number.toString();
  }

  @override
  String formatFullDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  @override
  String formatHour(TimeOfDay timeOfDay, {bool alwaysUse24HourFormat = false}) {
    if (alwaysUse24HourFormat) {
      return timeOfDay.hour.toString().padLeft(2, '0');
    } else {
      int hour = timeOfDay.hourOfPeriod;
      if (hour == 0) hour = 12;
      return hour.toString().padLeft(2, '0');
    }
  }

  @override
  String formatMediumDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  @override
  String formatMinute(TimeOfDay timeOfDay) {
    return timeOfDay.minute.toString().padLeft(2, '0');
  }

  @override
  String formatMonthYear(DateTime date) {
    return '${date.month}/${date.year}';
  }

  @override
  String formatShortDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  @override
  String formatShortMonthDay(DateTime date) {
    return '${date.month}/${date.day}';
  }

  @override
  String formatTimeOfDay(TimeOfDay timeOfDay, {bool alwaysUse24HourFormat = false}) {
    String hourFormat = formatHour(timeOfDay, alwaysUse24HourFormat: alwaysUse24HourFormat);
    String minuteFormat = formatMinute(timeOfDay);
    if (alwaysUse24HourFormat) {
      return '$hourFormat:$minuteFormat';
    } else {
      String period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
      return '$hourFormat:$minuteFormat $period';
    }
  }

  @override
  String get hideAccountsLabel => 'Hide Accounts';

  @override
  String get inputDateModeButtonLabel => 'Date Input Mode';

  @override
  String get inputTimeModeButtonLabel => 'Time Input Mode';

  @override
  String get invalidDateFormatLabel => 'Invalid date format';

  @override
  String get invalidDateRangeLabel => 'Invalid date range';

  @override
  String get invalidTimeLabel => 'Invalid time';

  @override
  String get keyboardKeyAlt => 'Alt';

  @override
  String get keyboardKeyAltGraph => 'Alt Graph';

  @override
  String get keyboardKeyBackspace => 'Backspace';

  @override
  String get lastPageTooltip => 'Last Page';

  @override
  String licensesPackageDetailText(int licenseCount) {
    return 'View $licenseCount Licenses';
  }

  @override
  String get menuBarMenuLabel => 'Menu';

  @override
  List<String> get narrowWeekdays => ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  @override
  DateTime? parseCompactDate(String? inputString) {
    if (inputString == null || inputString.isEmpty) return null;
    List<String> parts = inputString.split('/');
    if (parts.length != 3) return null;
    int? month = int.tryParse(parts[0]);
    int? day = int.tryParse(parts[1]);
    int? year = int.tryParse(parts[2]);
    if (month == null || day == null || year == null) return null;
    return DateTime(year, month, day);
  }

  @override
  String get scrimLabel => 'Scrim';

  @override
  String scrimOnTapHint(String modalRouteContentName) {
    return 'Double tap to dismiss $modalRouteContentName';
  }

  @override
  ScriptCategory get scriptCategory => ScriptCategory.englishLike;

  @override
  String get selectYearSemanticsLabel => 'Select Year';

  @override
  String get showMenuTooltip => 'Show Menu';

  @override
  String get timePickerDialHelpText => 'Select a time';

  @override
  String get timePickerHourLabel => 'Hour';

  @override
  String get timePickerInputHelpText => 'Enter a time';

  @override
  String get timePickerMinuteLabel => 'Minute';

  @override
  String get unspecifiedDate => 'Unspecified Date';

  @override
  String get unspecifiedDateRange => 'Unspecified Date Range';

  @override
  String pageRowsInfoTitle(int firstRow, int lastRow, int rowCount, bool rowCountIsApproximate) {
    if (rowCountIsApproximate) {
      return 'Rows $firstRow-$lastRow (Approximate total $rowCount)';
    } else {
      return 'Rows $firstRow-$lastRow of $rowCount';
    }
  }
}

class HTCupertinoLocalizationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const HTCupertinoLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return locale == const Locale('ht');
  }
  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    assert(locale == const Locale('ht'));
    return SynchronousFuture<CupertinoLocalizations>(HTCupertinoLocalizations());
  }
  @override
  bool shouldReload(HTCupertinoLocalizationsDelegate old) => false;
}

class HTCupertinoLocalizations extends CupertinoLocalizations {
  HTCupertinoLocalizations();



  @override
  DatePickerDateOrder get datePickerDateOrder => DatePickerDateOrder.dmy;

  @override
  DatePickerDateTimeOrder get datePickerDateTimeOrder => DatePickerDateTimeOrder.date_time_dayPeriod;

  @override
  String datePickerDayOfMonth(int dayIndex, [int? weekDay]) {
    if (weekDay != null) {
      return '${weekDay.toString()} $dayIndex';
    }
    return dayIndex.toString();
  }

  @override
  String datePickerHour(int hour) {
    return hour.toString();
  }

  @override
  String? datePickerHourSemanticsLabel(int hour) {
    return hour.toString();
  }

  @override
  String datePickerMediumDate(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }

  @override
  String datePickerMinute(int minute) {
    return minute.toString();
  }

  @override
  String? datePickerMinuteSemanticsLabel(int minute) {
    return minute.toString();
  }

  @override
  String datePickerMonth(int monthIndex) {
    return monthIndex.toString();
  }

  @override
  String datePickerYear(int yearIndex) {
    return yearIndex.toString();
  }

  @override
  String get modalBarrierDismissLabel => 'Dismiss';

  @override
  String get noSpellCheckReplacementsLabel => 'No replacements';

  @override
  String get pasteButtonLabel => 'Paste';

  @override
  String get postMeridiemAbbreviation => 'PM';

  @override
  String get searchTextFieldPlaceholderLabel => 'Search';

  @override
  String get selectAllButtonLabel => 'Select All';

  @override
  String tabSemanticsLabel({required int tabIndex, required int tabCount}) {
    return 'Tab $tabIndex of $tabCount';
  }

  @override
  String timerPickerHour(int hour) {
    return hour.toString();
  }

  @override
  String? timerPickerHourLabel(int hour) {
    return hour.toString();
  }

  @override
  List<String> get timerPickerHourLabels {
    return List.generate(24, (index) => index.toString());
  }

  @override
  String timerPickerMinute(int minute) {
    return minute.toString();
  }

  @override
  String? timerPickerMinuteLabel(int minute) {
    return minute.toString();
  }

  @override
  List<String> get timerPickerMinuteLabels {
    return List.generate(60, (index) => index.toString());
  }

  @override
  String timerPickerSecond(int second) {
    return second.toString();
  }

  @override
  String? timerPickerSecondLabel(int second) {
    return second.toString();
  }

  @override
  List<String> get timerPickerSecondLabels {
    return List.generate(60, (index) => index.toString());
  }

  @override
  String get todayLabel => 'Today';

  @override
  String get alertDialogLabel => 'Alert';

  @override
  String get anteMeridiemAbbreviation => 'AM';

  @override
  String get copyButtonLabel => 'Copy';

  @override
  String get cutButtonLabel => 'Cut';


}