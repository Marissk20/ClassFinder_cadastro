class ClassroomModel {
  String classroom;
  int capacity;
  int computersCount;
  bool hasProjector;
  bool hasTelevision;
  bool hasAirConditioning;
  bool hasLeftHandedDesk;
  bool hasHandicapDesk;

  ClassroomModel({
    required this.classroom,
    required this.capacity,
    required this.computersCount,
    required this.hasProjector,
    required this.hasTelevision,
    required this.hasAirConditioning,
    required this.hasLeftHandedDesk,
    required this.hasHandicapDesk,
  });
}
