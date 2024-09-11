
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
              log('Visible Screen RouteName = ${ModalRoute.of(context)?.settings.name}');
              log('currentTabIndex RouteName = $currentTabIndex');
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
