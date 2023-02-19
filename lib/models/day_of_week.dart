enum DayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  bool get isMonday => monday == this;
  bool get isTuesday => tuesday == this;
  bool get isWednesday => wednesday == this;
  bool get isThursday => thursday == this;
  bool get isFriday => friday == this;
  bool get isSaturday => saturday == this;
  bool get isSunday => sunday == this;
}
