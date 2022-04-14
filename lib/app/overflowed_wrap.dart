import 'dart:math' as math;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class OverflowedWrap extends MultiChildRenderObjectWidget {
  final int maxLines;
  final double spacing;
  final double runSpacing;

  OverflowedWrap({
    Key? key,
    List<Widget> children = const [],
    required Widget overflowWidget,
    required this.maxLines,
    this.spacing = 0,
    this.runSpacing = 0,
  }) : super(key: key, children: [...children, overflowWidget]);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderOverflowedWrap(
      maxLines: maxLines,
      runSpacing: runSpacing,
      spacing: spacing,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderOverflowedWrap renderObject,
  ) {
    renderObject
      ..maxLines = maxLines
      ..spacing = spacing
      ..lineSpacing = runSpacing;
  }
}

class _RenderOverflowedWrap extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _CustomWrapParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _CustomWrapParentData> {
  _RenderOverflowedWrap({
    required int maxLines,
    double spacing = 0,
    double runSpacing = 0,
  })  : _maxLines = maxLines,
        _spacing = spacing,
        _runSpacing = runSpacing;

  int get maxLines => _maxLines;
  int _maxLines;
  set maxLines(int value) {
    if (value == _maxLines) {
      return;
    }
    _maxLines = value;
    markNeedsLayout();
  }

  double get spacing => _spacing;
  double _spacing;
  set spacing(double value) {
    if (value == _spacing) {
      return;
    }
    _spacing = value;
    markNeedsLayout();
  }

  double get lineSpacing => _runSpacing;
  double _runSpacing;
  set lineSpacing(double value) {
    if (value == _runSpacing) {
      return;
    }
    _runSpacing = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    RenderBox? child = firstChild;
    if (child == null) {
      size = constraints.smallest;
      return;
    }
    final widthLimit = constraints.maxWidth;
    final childConstraints = BoxConstraints(maxWidth: widthLimit);
    final overflowChild = lastChild!;
    double verticalOffset = 0;
    bool hasOverflow = false;
    double containerHeight = 0;

    overflowChild.layout(childConstraints, parentUsesSize: true);

    for (var i = 0; i < maxLines; i++) {
      double lineWidth = 0;
      while (child != null) {
        child.layout(childConstraints, parentUsesSize: true);
        final childWidth = child.size.width;
        final childHeight = child.size.height;
        final childParentData = child.parentData! as _CustomWrapParentData;

        bool hasWidthOverflow() {
          return lineWidth + childWidth + spacing > widthLimit;
        }

        if (i == maxLines - 1) {
          if (hasWidthOverflow() && child != overflowChild) {
            hasOverflow = true;
            childParentData._shouldBePainted = false;
          }
        } else {
          if (hasWidthOverflow()) {
            verticalOffset += childHeight + lineSpacing;
            break;
          }
        }

        if (!hasOverflow && child == overflowChild) {
          childParentData._shouldBePainted = false;
        }

        containerHeight = math.max(
          containerHeight,
          childHeight + verticalOffset,
        );

        childParentData.offset = Offset(lineWidth, verticalOffset);
        if (!hasOverflow) {
          lineWidth += childWidth + spacing;
        }

        child = childParentData.nextSibling;
      }
    }
    size = constraints.constrain(Size(widthLimit, containerHeight));
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _CustomWrapParentData) {
      child.parentData = _CustomWrapParentData();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as _CustomWrapParentData;
      if (childParentData._shouldBePainted) {
        context.paintChild(child, childParentData.offset + offset);
      }
      child = childParentData.nextSibling;
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}

class _CustomWrapParentData extends ContainerBoxParentData<RenderBox> {
  bool _shouldBePainted = true;
}
