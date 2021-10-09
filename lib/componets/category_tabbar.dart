import 'package:flutter/material.dart';

class CategoryTabBar extends StatefulWidget {
  const CategoryTabBar({Key? key}) : super(key: key);

  @override
  _CategoryTabBarState createState() => _CategoryTabBarState();
}

class _CategoryTabBarState extends State<CategoryTabBar>
    with SingleTickerProviderStateMixin, RestorationMixin {

  final RestorableInt tabIndex = RestorableInt(0);
  TabController? _tabController;

  @override
  String get restorationId => 'tab_scrollable';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController!.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this, initialIndex: 0);

    _tabController!.addListener(() {
      setState(() {
        tabIndex.value = _tabController!.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['1', '2', '3', '4', '5'];
    return TabBar(
        controller: _tabController,
        isScrollable: true,
        tabs: [for (var tab in tabs) Tab(text: tab)]);
  }
}
