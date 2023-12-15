import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../../core/theme_utils/colors_are_close.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('DrawerScreen build');
    return ResponsiveScaffold(
      menuItems: const [
        MenuItemData(label: 'weather', icon: Icons.sunny),
        MenuItemData(label: 'product', icon: Icons.phone),
        MenuItemData(label: 'shopping', icon: Icons.shop),
      ],
      onSelect: (int index) {},
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.arrow_back_ios),
      ),
    );
  }
}

class MenuItemData {
  const MenuItemData({
    required this.label,
    required this.icon,
  });
  final String label;
  final IconData icon;
}

const double _kMenuWidth = 280;
const double _kRailWidth = 52;
const double _kBreakpointShowFullMenu = 900;
const Duration _kMenuAnimationDuration = Duration(milliseconds: 246);

class ResponsiveScaffold extends StatefulWidget {
  final double menuWidth;
  final List<MenuItemData> menuItems;
  final double railWidth;
  final ValueChanged<int>? onSelect;

  final Widget? body;
  final Widget? floatingActionButton;

  const ResponsiveScaffold({
    super.key,
    this.menuWidth = _kMenuWidth,
    required this.menuItems,
    this.railWidth = _kRailWidth,
    this.onSelect,
    this.body,
    this.floatingActionButton,
  });

  @override
  State<ResponsiveScaffold> createState() => _ResponsiveScaffoldState();
}

class _ResponsiveScaffoldState extends State<ResponsiveScaffold> {
  late double activeMenuWidth;
  late double previousMenuWidth;
  late Size previousMediaSize;

  bool isMenuExpanded = true;
  bool isMenuClosed = false;
  bool menuDoneClosing = false;

  @override
  void initState() {
    previousMediaSize = Size.zero;
    activeMenuWidth = widget.menuWidth;
    previousMenuWidth = activeMenuWidth;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant ResponsiveScaffold oldWidget) {
    final Size mediaSize = MediaQuery.sizeOf(context);
    if (mediaSize != previousMediaSize) {
      previousMediaSize = mediaSize;

      final bool isPhone = mediaSize.width < 600;

      if (isPhone) {
        isMenuClosed = true;
      } else {
        isMenuClosed = false;
      }
    }
    print('_ResponsiveScaffoldState didUpdateWidget ');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print('_ResponsiveScaffoldState build');

    final bool isDesktop = MediaQuery.sizeOf(context).width >=
        _kBreakpointShowFullMenu; //MediaQuery.sizeOf 쿼리 하는 속성이 변하면 re build
    print('isDesktop:$isDesktop');
    if (!isDesktop) activeMenuWidth = widget.railWidth;
    if (!isDesktop && isMenuClosed) activeMenuWidth = 0;
    if (!isDesktop && !isMenuClosed) activeMenuWidth = widget.railWidth;

    if (isDesktop && !isMenuExpanded) activeMenuWidth = widget.railWidth;
    if (isDesktop && isMenuExpanded) activeMenuWidth = widget.menuWidth;

    return Row(
      children: [
        FocusTraversalGroup(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: widget.menuWidth,
            ),
            child: Material(
              child: AnimatedContainer(
                duration: _kMenuAnimationDuration,
                onEnd: () {
                  setState(() {
                    if (isMenuClosed) {
                      menuDoneClosing = true;
                    } else {
                      menuDoneClosing = false;
                    }
                    print(
                        'AnimatedContainer onEnd menuDoneClosing:$menuDoneClosing');
                  });
                },
                width: activeMenuWidth,
                child: AppMenu(
                  maxWidth: widget.menuWidth,
                  menuItems: widget.menuItems,
                  railWidth: widget.railWidth,
                  onSelect: widget.onSelect,
                  onOperate: () {
                    setState(() {
                      if (isDesktop) {
                        isMenuExpanded = !isMenuExpanded;
                      } else {
                        isMenuClosed = true;
                      }
                    });
                    print(
                        'onOperate isMenuExpanded:$isMenuExpanded isMenuClosed:$isMenuClosed');
                  },
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: FocusTraversalGroup(
            child: Scaffold(
              appBar: AppBar(
                title: Row(children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.backspace_rounded)),
                  const Text('Scaffold Title')
                ]),
                centerTitle: false,
                actions: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.info))
                ],
                //automaticallyImplyLeading == false 이면 뒤로가기 없어진다.
                automaticallyImplyLeading:
                    !isDesktop && isMenuClosed && menuDoneClosing,
              ),
              drawer: ConstrainedBox(
                constraints: BoxConstraints.expand(width: widget.menuWidth),
                child: Drawer(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(0),
                        bottomRight: Radius.circular(0)),
                  ),
                  child: AppMenu(
                    maxWidth: widget.menuWidth,
                    menuItems: widget.menuItems,
                    railWidth: widget.railWidth,
                    onSelect: (int index) {
                      Navigator.of(context).pop();
                      widget.onSelect?.call(index);
                    },
                    onOperate: () {
                      Navigator.of(context).pop();
                      Future<void>.delayed(_kMenuAnimationDuration, () {
                        setState(() {
                          isMenuClosed = false;
                        });
                      });
                    },
                  ),
                ),
              ),
              body: widget.body,
              floatingActionButton: widget.floatingActionButton,
              //backgroundColor: Colors.grey.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}

class AppMenu extends StatefulWidget {
  final double maxWidth;
  final double railWidth;
  final List<MenuItemData> menuItems;
  final VoidCallback? onOperate;
  final ValueChanged<int>? onSelect;
  const AppMenu({
    super.key,
    required this.maxWidth,
    required this.menuItems,
    required this.railWidth,
    this.onOperate,
    this.onSelect,
  });

  @override
  State<AppMenu> createState() => _AppMenuState();
}

class _AppMenuState extends State<AppMenu> {
  int selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    final Color menuBackground = theme.canvasColor;
    final Color scaffoldBackground = theme.scaffoldBackgroundColor;
    final bool closeColors =
        colorsAreClose(menuBackground, scaffoldBackground, isLight);

    return LayoutBuilder(
      builder: (context, constraints) {
        print('_AppMenuState LayoutBuilder builder');
        return OverflowBox(
          alignment: AlignmentDirectional.topStart,
          minWidth: 0,
          maxWidth: widget.maxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                title: const Text('AppMenu Title'),
                titleSpacing: 0,
                leadingWidth: widget.railWidth,
                leading: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.menu),
                  onPressed: widget.onOperate,
                ),
              ),
              Expanded(
                child: Container(
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    border: BorderDirectional(
                      end: BorderSide(
                        width: 0,
                        color: closeColors
                            ? theme.dividerColor
                            : Colors.transparent,
                      ),
                    ),
                  ),
                  child: ClipRect(
                      child: OverflowBox(
                    alignment: AlignmentDirectional.topStart,
                    minWidth: 0,
                    maxWidth: widget.maxWidth,
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        const MenuLeadingItem(),
                        for (int i = 0; i < widget.menuItems.length; i++)
                          MenuItem(
                            dividerAbove: true,
                            dividerBelow:
                                i == widget.menuItems.length - 1 ? true : false,
                            label: widget.menuItems[i].label,
                            icon: widget.menuItems[i].icon,
                            onTap: () {
                              setState(() {
                                selectedItemIndex = i;
                              });
                              widget.onSelect?.call(i);
                            },
                            selected: selectedItemIndex == i,
                            width: constraints.maxWidth,
                            menuWidth: widget.maxWidth,
                            railWidth: widget.railWidth,
                          ),
                        const Divider(thickness: 1, height: 1),
                      ],
                    ),
                  )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MenuLeadingItem extends StatefulWidget {
  const MenuLeadingItem({super.key});

  @override
  State<MenuLeadingItem> createState() => _MenuLeadingItemState();
}

class _MenuLeadingItemState extends State<MenuLeadingItem> {
  bool _collapsed = true;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: Column(
        children: [
          ListTile(
            visualDensity: VisualDensity.comfortable,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 5,
            ),
            leading: const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text('CT'),
            ),
            title: const Text('Title'),
            subtitle: const Text('SubTitle'),
            trailing: ExpandIcon(
              isExpanded: !_collapsed,
              padding: EdgeInsets.zero,
              onPressed: (_) {
                _focusNode.requestFocus();
                setState(() {
                  _collapsed = !_collapsed;
                });
              },
            ),
            onTap: () {
              _focusNode.requestFocus();
              setState(() {
                _collapsed = !_collapsed;
              });
            },
          ),
          AnimatedSwitcher(
            duration: const Duration(
              milliseconds: 200,
            ),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SizeTransition(
                sizeFactor: animation,
                child: child,
              );
            },
            child: _collapsed
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: const Column(
                            children: [Icon(Icons.info, size: 30)],
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

class MenuItem extends StatefulWidget {
  const MenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.selected = false,
    required this.onTap,
    required this.width,
    required this.menuWidth,
    required this.dividerAbove,
    required this.dividerBelow,
    required this.railWidth,
  });
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final double width;
  final double menuWidth;
  final bool dividerAbove;
  final bool dividerBelow;
  final double railWidth;

  static const double _itemHeight = 50;

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    final double endPadding = (widget.width > widget.railWidth + 10)
        ? 12
        // If we use a really narrow rail rail, make padding even smaller-
        : widget.railWidth < 60
            ? 5
            : 8;

    if (widget.width < 4) {
      return const SizedBox.shrink();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.dividerAbove)
            const Divider(
              thickness: 1,
              height: 1,
            ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 2, endPadding, 2),
            child: Material(
              clipBehavior: Clip.antiAlias,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(MenuItem._itemHeight / 2),
                bottomRight: Radius.circular(MenuItem._itemHeight / 2),
              ),
              child: SizedBox(
                height: MenuItem._itemHeight,
                width: math.max(widget.width - 5, 0),
                child: OverflowBox(
                  alignment: AlignmentDirectional.topStart,
                  minWidth: 0,
                  maxWidth: math.max(widget.menuWidth, 0),
                  child: InkWell(
                    onTap: () {
                      widget.onTap();
                    },
                    child: Row(
                      children: [
                        Tooltip(
                          message: widget.label,
                          child: ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                              width: widget.railWidth,
                              height: widget.railWidth,
                            ),
                            child: Icon(widget.icon),
                          ),
                        ),
                        if (widget.width < widget.railWidth + 10)
                          const SizedBox.shrink()
                        else
                          Text(widget.label)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (widget.dividerBelow) const Divider(thickness: 1, height: 1)
        ],
      );
    }
  }
}
