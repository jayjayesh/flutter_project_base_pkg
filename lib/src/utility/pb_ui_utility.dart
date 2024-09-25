part of flutter_project_base;

class PBUIUtility {
  /// ------- SnackBar -------
  void showSnackBar(BuildContext context, String message,
      {Duration duration = const Duration(seconds: 1)}) {
    ///
    if (message.isEmpty) {
      return;
    }

    ///
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: duration,
        ),
      );
  }

  /// ------- SVG -------
  ///
  /// ------- How to use it? ---------- 
  /// use this preloadSVGFiles method in main.dart before run app
  ///
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await preloadSVGFiles([
  ///     'assets/my_icon1.svg',
  ///     'assets/my_icon2.svg',
  ///     'assets/my_icon3.svg',
  ///   ]);
  ///   runApp(MyApp());  
  /// }
  /// 
  /// ----------------------------------
  /// 
  /// Use these tips:
  /// 
  /// If you have 100s of SVG for project it will significantly increase your app start time
  /// 
  /// Lazy Loading:
  /// Instead of preloading all 200+ SVGs at startup, consider lazy loading only the assets that are required initially (e.g., for the first screen).
  /// Preload other assets asynchronously in the background as needed, without blocking the app’s startup.
  /// 
  /// Prioritized Preloading:
  /// You can prioritize preloading only the most critical assets (like those needed for the initial view) and delay the rest until after the app has started.
  /// 
  /// Preload in Background:
  /// Preload assets during idle moments or after the app has started to ensure it doesn’t block the UI during startup.
  ///
  /// 
  Future<void> preloadSVGFiles(List<String> svgPaths) async{
    for(final svgFilePath in svgPaths){
      final svgLoader = SvgAssetLoader(svgFilePath);
      await svg.cache.putIfAbsent(
        svgLoader.cacheKey(null),
        () => svgLoader.loadBytes(null),
      );
    }
  }

}
