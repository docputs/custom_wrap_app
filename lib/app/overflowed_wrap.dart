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
    return RenderOverflowedWrap(
      maxLines: maxLines,
      runSpacing: runSpacing,
      spacing: spacing,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderOverflowedWrap renderObject) {
    renderObject
      ..maxLines = maxLines
      ..spacing = spacing
      ..lineSpacing = runSpacing;
  }
}

class RenderOverflowedWrap extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, CustomWrapParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, CustomWrapParentData> {
  RenderOverflowedWrap({
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
        final childParentData = child.parentData! as CustomWrapParentData;

        if (i == maxLines - 1) {
          if (lineWidth + childWidth + overflowChild.size.width + spacing >
                  widthLimit &&
              child != overflowChild) {
            hasOverflow = true;
            childParentData._shouldBePainted = false;
          }
        } else {
          if (lineWidth + childWidth + spacing > widthLimit) {
            verticalOffset += childHeight + lineSpacing;
            break;
          }
        }

        containerHeight = math.max(containerHeight, childHeight);

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
    if (child.parentData is! CustomWrapParentData) {
      child.parentData = CustomWrapParentData();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;
    while (child != null) {
      final childParentData = child.parentData! as CustomWrapParentData;
      if (childParentData._shouldBePainted) {
        context.paintChild(child, childParentData.offset + offset);
      }
      child = childParentData.nextSibling;
    }
  }
}

class CustomWrapParentData extends ContainerBoxParentData<RenderBox> {
  bool _shouldBePainted = true;
}
