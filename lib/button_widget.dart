import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef Widget Parent(Widget par);

class ButtomAnimationTupCustom extends StatefulWidget {
  Widget child;
  Parent parent;
  VoidCallback tap;
  BorderRadiusGeometry? borderRadius;
  BorderSide? borderSideColor;
  ButtomAnimationTupCustom({ 
    Key? key,
    required this.child,
    required this.parent,
    required this.tap,
    this.borderRadius,
    this.borderSideColor
    }) : super(key: key);

  @override
  State<ButtomAnimationTupCustom> createState() => _ButtomAnimationTupCustomState();
}

class _ButtomAnimationTupCustomState extends State<ButtomAnimationTupCustom> 
 with MaterialStateMixin
{


    bool myEnable = false;

    double elevation = 2.0;
    double focusElevation = 4.0;
    double hoverElevation = 4.0;
    double highlightElevation = 8.0;
    double disabledElevation = 0.0;

    Size minSize = Size(2, 2);

    Duration animationDuration = kThemeChangeDuration;
    Clip clipBehavior = Clip.none;

    static double minHigth = 15.0;
    static double minWigth = 15.0;

    final BoxConstraints effectiveConstraints = 
          VisualDensity.standard.effectiveConstraints(
             BoxConstraints(minWidth: minWigth, minHeight: minHigth)); // BoxConstraints(minWidth: minWigth, minHeight: minHigth));


    double get _effectiveElevation {
      // These conditionals are in order of precedence, so be careful about
      // reorganizing them.
      if (isDisabled) {// MaterialStateMixin
        return this.disabledElevation; 
      }
      if (isPressed) {// MaterialStateMixin
        return this.highlightElevation;
      }
      if (isHovered) {// MaterialStateMixin
        return this.hoverElevation;
      }
      if (isFocused) {// MaterialStateMixin
        return this.focusElevation;
      }
      return this.elevation;
    }



  @override
  Widget build(BuildContext context) {

    final Widget result = ConstrainedBox(
      constraints: effectiveConstraints,
      child: Material(
        elevation: _effectiveElevation,
        // textStyle: widget.textStyle?.copyWith(color: effectiveTextColor),
        // shape: effectiveShape,
        color: Colors.green,
        type: Colors.red != null ? MaterialType.transparency : MaterialType.button,
        animationDuration: this.animationDuration,
        clipBehavior: this.clipBehavior,
        child: InkWell( 
          onTap:(){
            // setState(() {
              myEnable = !myEnable;
            // });
            widget.tap();
          },
          customBorder: widget.borderSideColor !=null ? RoundedRectangleBorder(
            side:widget.borderSideColor ??    BorderSide(color: Colors.transparent), 
            borderRadius: widget.borderRadius ??  BorderRadius.all( Radius.circular(0))
          ):  RoundedRectangleBorder(
            borderRadius: widget.borderRadius ??  BorderRadius.all( Radius.circular(12))
          ),
          // onLongPress: (){},
          child: IconTheme.merge(
            data: IconThemeData(color: Colors.amber),
            child: Container(
              // color: Colors.green,
              // padding: EdgeInsets.all(10),
              child: Center(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );

    // if(!custom){
    //   return Container(
    //     width: 200,
    //     height: 300,
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.all(Radius.circular(25)),
    //         color: Colors.green,
    //     ),
    //     child: Semantics(
    //       container: true,
    //       button: true,
    //       enabled: myEnable,
    //       child: InputPadding(
    //         minSize: Size(2, 2),
    //         child: result,
    //       ),
    //     ),
    //   );
    // }else{
      return widget.parent(
       Semantics(
          container: true,
          button: true,
          enabled: myEnable,
          child: InputPadding(
            minSize: minSize,
            child: result,
          ),
        ),
      );
    // }

  }
}







/// A widget to pad the area around a [MaterialButton]'s inner [Material].
///
/// Redirect taps that occur in the padded area around the child to the center
/// of the child. This increases the size of the button and the button's
/// "tap target", but not its material or its ink splashes.
class InputPadding extends SingleChildRenderObjectWidget {
  const InputPadding({
    Key? key,
    Widget? child,
    required this.minSize,
  }) : super(key: key, child: child);

  final Size minSize;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderInputPadding(minSize);
  }

  @override
  void updateRenderObject(BuildContext context, covariant _RenderInputPadding renderObject) {
    renderObject.minSize = minSize;
  }
}

class _RenderInputPadding extends RenderShiftedBox {
  _RenderInputPadding(this._minSize, [RenderBox? child]) : super(child);

  Size get minSize => _minSize;
  Size _minSize;
  set minSize(Size value) {
    if (_minSize == value)
      return;
    _minSize = value;
    markNeedsLayout();
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    if (child != null)
      return math.max(child!.getMinIntrinsicWidth(height), minSize.width);
    return 0.0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (child != null)
      return math.max(child!.getMinIntrinsicHeight(width), minSize.height);
    return 0.0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    if (child != null)
      return math.max(child!.getMaxIntrinsicWidth(height), minSize.width);
    return 0.0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (child != null)
      return math.max(child!.getMaxIntrinsicHeight(width), minSize.height);
    return 0.0;
  }

  Size _computeSize({required BoxConstraints constraints, required ChildLayouter layoutChild}) {
    if (child != null) {
      final Size childSize = layoutChild(child!, constraints);
      final double height = math.max(childSize.width, minSize.width);
      final double width = math.max(childSize.height, minSize.height);
      return constraints.constrain(Size(height, width));
    }
    return Size.zero;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _computeSize(
      constraints: constraints,
      layoutChild: ChildLayoutHelper.dryLayoutChild,
    );
  }

  @override
  void performLayout() {
    size = _computeSize(
      constraints: constraints,
      layoutChild: ChildLayoutHelper.layoutChild,
    );
    if (child != null) {
      final BoxParentData childParentData = child!.parentData! as BoxParentData;
      childParentData.offset = Alignment.center.alongOffset(size - child!.size as Offset);
    }
  }

  @override
  bool hitTest(BoxHitTestResult result, { required Offset position }) {
    if (super.hitTest(result, position: position)) {
      return true;
    }
    final Offset center = child!.size.center(Offset.zero);
    return result.addWithRawTransform(
      transform: MatrixUtils.forceToPoint(center),
      position: center,
      hitTest: (BoxHitTestResult result, Offset position) {
        assert(position == center);
        return child!.hitTest(result, position: center);
      },
    );
  }
}
