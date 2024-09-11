import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kamai/app_imports.dart';
import 'package:kamai/common/utils/app_manager.dart';
import 'package:kamai/common/widgets/app_exit_popup_widget.dart';
import 'package:kamai/feature/bottom_navigation/current_tab_view.dart';
import 'package:kamai/feature/home/influencer_profile_page/influencer_profile_page.dart';
import 'package:kamai/feature/side_menu/side_menu.dart';
import 'package:kamai/riverpod/state_notifiers/current_tab_view/current_tab_view_state_notifier.dart';

DateTime lastTimeBackButtonWasClicked = DateTime.now();

class AppExitWillPopScopeWidget extends ConsumerStatefulWidget {
  const AppExitWillPopScopeWidget({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<AppExitWillPopScopeWidget> createState() => _AppExitWillPopScopeWidgetState();
}

class _AppExitWillPopScopeWidgetState extends ConsumerState<AppExitWillPopScopeWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ModalRoute.of(context)?.settings.name == InfluencerProfilePage.routeName
          ? null
          : () async {
              final currentTabIndex = ref.read(CurrentTabViewStateNotifier.provider).tabIndex;
              'Visible Screen RouteName = ${ModalRoute.of(context)?.settings.name}'.logThis();
              'currentTabIndex RouteName = $currentTabIndex'.logThis();
              if (SideMenu.isDrawerOpen(serviceLocator<AppManager>().currentTabViewScaffoldKey)) {
                SideMenu.closeSideMenu(serviceLocator<AppManager>().currentTabViewScaffoldKey);
                return false;
              } else if (ModalRoute.of(context)?.settings.name == CurrentTabView.routeName && currentTabIndex != 3) {
                ref.read(CurrentTabViewStateNotifier.provider.notifier).onTapChangeTab(3);

                return false;
              } else if (ModalRoute.of(context)?.settings.name == CurrentTabView.routeName && currentTabIndex == 3) {
                'DateTime.now().difference(lastTimeBackButtonWasClicked) = ${DateTime.now().difference(lastTimeBackButtonWasClicked)}'
                    .logThis();
                if (DateTime.now().difference(lastTimeBackButtonWasClicked) >= const Duration(microseconds: 1)) {
                  /* AppToast.show(
                    message: 'Press again to exit app',
                    type: SnackbarType.error,
                  ); */
                  await showExitPopup(context);
                  lastTimeBackButtonWasClicked = DateTime.now();
                  return false;
                } else {
                  return true;
                }
              } else {
                return true;
              }
            },
      child: widget.child,
    );
  }
}
