abstract class Days {
  static const int monday = 1; // 2^0
  static const int tuesday = 2; // 2^1
  static const int wednesday = 4; // 2^2
  static const int thursday = 8; // 2^3
  static const int friday = 16; // 2^4
  static const int saturday = 32; // 2^5
  static const int sunday = 64; // 2^6
  static const int allDays =
      monday | tuesday | wednesday | thursday | friday | saturday | sunday;

  static bool isMonday(int value) {
    return (value & monday) == monday;
    // 0001011
    // &
    // 0000001
    // = 0000001
  }

  static bool isTuesday(int value) {
    return (value & tuesday) == tuesday;
  }

  static bool isWednesday(int value) {
    return (value & wednesday) == wednesday;
  }

  static bool isThursday(int value) {
    return (value & thursday) == thursday;
  }

  static bool isFriday(int value) {
    return (value & friday) == friday;
  }

  static bool isSaturday(int value) {
    return (value & saturday) == saturday;
  }

  static bool isSunday(int value) {
    return (value & sunday) == sunday;
  }

  static int toggle(int value, int day) {
    return value ^ day;
    // XOR
    // 0001011
    // &
    // 0000001
    // = 0000001

    // false true = true
    // true false = true
    // true true = false
    // false false false
  }

  static bool isSelected(int value, int day) {
    return (value & day) == day;
  }

  static bool isSelectedEveryDay(int value) {
    return value ==
        (monday | tuesday | wednesday | thursday | friday | saturday | sunday);
  }

  static const List<int> daysOfTheWeek = [
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday,
    sunday
  ];

  static const Map<int, String> weekDayNames = {
    monday: 'Monday',
    tuesday: 'Tuesday',
    wednesday: 'Wednesday',
    thursday: 'Thursday',
    friday: 'Friday',
    saturday: 'Saturday',
    sunday: 'Sunday'
  };
}
