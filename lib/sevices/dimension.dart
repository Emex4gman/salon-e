class DimensionService {
  factory DimensionService() => _dimentionService;
  static final DimensionService _dimentionService = DimensionService._intance();
  DimensionService._intance();

  late double _height;
  double get deviceHeight => _height;

  set height(double height) {
    _height = height;
  }

  late double _width;
  double get deviceWidth => _width;

  set width(double width) {
    _width = width;
  }
}
