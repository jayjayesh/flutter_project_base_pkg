import "package:flutter_svg/flutter_svg.dart";  
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
  /// ----------------------------------
  ///
  Future<void> preloadSVGFiles(List<String> svgPaths) async{
    for(final svg in svgPaths){
      final svgLoader = SvgAssetsLoader(svg);
      await svg.catch.putIfAbsent(
        svgLoader.cacheKey(null),
        () => svgLoader.loadBytes(null),
      );
    }
    return Future.wait(svgPaths.map((path) async {
      await precachePicture(ExactAssetPicture(AssetName(path)), null);
    }));
  }

}
