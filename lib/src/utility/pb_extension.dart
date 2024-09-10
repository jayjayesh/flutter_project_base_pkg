part of flutter_project_base;

// ------- UI -------

extension OnColumn on Column {
  Widget padding(EdgeInsets edgeInsets) {
    return Padding(padding: edgeInsets, child: this);
  }
}

extension OnRow on Row {
  Widget padding(EdgeInsets edgeInsets) {
    return Padding(padding: edgeInsets, child: this);
  }
}

extension OnElevetedButton on ElevatedButton{
  Widget withLoading(bool isLoading){
    if(isLoading == false){
      return this;
    }

    return ElevatedButton(
      onPressed: null,
      child : SizedBox.square(
        dimension: 24,
        child: CircularProgressIndicator.adaptive(), 
      ),
    );
  }
}

extension OnTextButton on TextButton{
  Widget withLoading(bool isLoading){
    if(isLoading == false){
      return this;
    }

    return TextButton(
      onPressed: null,
      child : SizedBox.square(
        dimension: 24,
        child: CircularProgressIndicator.adaptive(), 
      ),
    );
  }
}

// ------- Logic -------

extension OnBuildContext on BuildContext {
/// common
ThemeData get theme => Theme.of(this);
MediaQueryData get mediaQuery => MediaQuery.of(this);
NavigatorState get navigator => Navigator.of(this);

/// Screen Size
  bool get isMobile => MediaQuery.of(this).size.width <= 500.0;

  bool get isTablet => MediaQuery.of(this).size.width < 1024.0 && MediaQuery.of(this).size.width >= 650.0;

  bool get isSmallTablet => MediaQuery.of(this).size.width < 650.0 && MediaQuery.of(this).size.width > 500.0;

  bool get isDesktop => MediaQuery.of(this).size.width >= 1024.0;

  bool get isSmall => MediaQuery.of(this).size.width < 850.0 && MediaQuery.of(this).size.width >= 560.0;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  Size get size => MediaQuery.of(this).size;
  

/// Navigation
  void pop<T extends Object?>([T? result]){
    return Navigator.of(this).pop();
  }

  Future<T?> pushNamed<T extends Object?>(
    String routeName,{
    Object? arguments,
  }){
    return Navigator.of(this).pushNamed(routeName, arguments:arguments);
  }

}

extension OrDefault<T> on T? {
  T get orDefault {
    final value = this;
    if (value == null) {
      return {
        int: 0,
        double: 0.0,
        num: 0.0,
        String: '',
        Map: {},
      }[T] as T;
    } else {
      return value;
    }
  }
}

/// Define an extension:
extension DoubleExtention on double {
  // how much digit you want after decimal point
  double toPrecisionExtensionMethod(int n) => double.parse(toStringAsFixed(n));
}

/// Define an extension:
extension StringExtention on String {
  ///
  String firstChars(int n) {
    return substring(0, length < n ? length : n);
  }

  String lastChars(int n) => substring(length - n);

  ///
  int toInt() {
    return int.tryParse(this) ?? 0;
  }

  ///
  double toDouble() {
    return double.tryParse(this) ?? 0.0;
  }

  ///
  num toNumber() {
    return num.tryParse(this) ?? 0.0;
  }
}
