import 'package:expenses_tracking/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'list_item.dart';

class DropDownList<T> extends StatefulWidget {
  final List<ListItem<T>> listItems;
  final T? value;
  final ValueChanged<T?>? onChange;
  final TextStyle? textStyle;

  const DropDownList({
    Key? key,
    required this.listItems,
    this.value,
    this.onChange,
    this.textStyle=MyTextStyles.textStyleMedium17,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DropDownListState<T>();

}

class _DropDownListState<T> extends State<DropDownList<T>> {
  final GlobalKey _key = GlobalKey();
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  ListItem? _selected;
  bool _isOverlayShown = false;
  OverlayEntry? _overlay;
  FocusScopeNode? _focusScopeNode;

  @override
  void initState() {
    super.initState();
    if (widget.listItems.isNotEmpty) {
      _selected = widget.value == null ? widget.listItems.first : widget.listItems.firstWhere((listItem) => listItem.value == widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: _onTap,
        child: FocusableActionDetector(
          focusNode: _focusNode,
          mouseCursor: SystemMouseCursors.click,
          actions: {
            ActivateIntent: CallbackAction<Intent>(onInvoke: (_) => _onTap()),
          },
          child: Container(
            key: _key,
            padding: const EdgeInsets.only(left: 10, right: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_selected == null ? '' : _selected!.title, style: widget.textStyle),
                SvgPicture.asset("assets/images/ic_arrow_drop_down.svg")
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _focusScopeNode?.dispose();
  }

  OverlayEntry _createOverlay() {
    _focusScopeNode = FocusScopeNode();
    return OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _removeOverlay,
        child: Stack(
          children: [
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: Alignment.bottomRight,
              followerAnchor: Alignment.topRight,
              child: Material(
                color: Colors.transparent,
                child: FocusScope(
                  node: _focusScopeNode,
                  child: _createListItems(),
                  onKey: (node, event) {
                    if (event.logicalKey == LogicalKeyboardKey.escape) {
                      _removeOverlay();
                    }

                    return KeyEventResult.ignored;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeOverlay() {
    _overlay!.remove();
    _isOverlayShown = false;
    _focusScopeNode!.dispose();
    FocusScope.of(context).nextFocus();
  }

  Widget _createListItems() {
    RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;

    return Container(
      decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
                color: MyColors.black.withOpacity(.07),
                offset: const Offset(0, 2),
                blurRadius: 2,
                spreadRadius: 1
            )
          ]
      ),
      padding: const EdgeInsets.symmetric(vertical: 10 / 2.0),
      width: renderBox.size.width - 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.listItems
            .map((listItem) => ListItem(
          listItem.title,
          onTap: () => _onListItemTap(listItem),
        ))
            .toList(),
      ),
    );
  }

  void _onTap() {
    if (_isOverlayShown) {
      _removeOverlay();
    } else {
      _overlay = _createOverlay();
      Overlay.of(context).insert(_overlay!);
      _isOverlayShown = true;
      FocusScope.of(context).setFirstFocus(_focusScopeNode!);
    }
  }

  void _onListItemTap(ListItem listItem) {
    _removeOverlay();
    setState(() {
      _selected = listItem;
    });

    widget.onChange?.call(listItem.value);
  }
}