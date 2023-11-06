import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart' show DateFormat, NumberFormat;
import 'package:syncfusion_flutter_core/core.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'common.dart';
import 'constants.dart';
import 'range_slider_base.dart';
import 'slider_shapes.dart';

class SfRangeSelector extends StatefulWidget {
  /// Creates a [SfRangeSelector].
  const SfRangeSelector(
      {Key? key,
      this.min = 0.0,
      this.max = 1.0,
      this.initialValues,
      this.onChanged,
      this.onChangeStart,
      this.onChangeEnd,
      this.controller,
      this.enabled = true,
      this.interval,
      this.stepSize,
      this.stepDuration,
      this.deferredUpdateDelay = 500,
      this.minorTicksPerInterval = 0,
      this.showTicks = false,
      this.showLabels = false,
      this.showDividers = false,
      this.enableTooltip = false,
      this.shouldAlwaysShowTooltip = false,
      this.enableIntervalSelection = false,
      this.enableDeferredUpdate = false,
      this.dragMode = SliderDragMode.onThumb,
      this.inactiveColor,
      this.activeColor,
      this.labelPlacement = LabelPlacement.onTicks,
      this.edgeLabelPlacement = EdgeLabelPlacement.auto,
      this.numberFormat,
      this.dateFormat,
      this.dateIntervalType,
      this.labelFormatterCallback,
      this.tooltipTextFormatterCallback,
      this.semanticFormatterCallback,
      this.trackShape = const SfTrackShape(),
      this.dividerShape = const SfDividerShape(),
      this.overlayShape = const SfOverlayShape(),
      this.thumbShape = const SfThumbShape(),
      this.tickShape = const SfTickShape(),
      this.minorTickShape = const SfMinorTickShape(),
      this.tooltipShape = const SfRectangularTooltipShape(),
      this.startThumbIcon,
      this.endThumbIcon,
      required this.child})
      : assert(min != max),
        assert(interval == null || interval > 0),
        assert(stepSize == null || stepSize > 0),
        assert(!enableIntervalSelection ||
            (enableIntervalSelection && (interval != null && interval > 0))),
        assert(controller != null || initialValues != null),
        super(key: key);

  final dynamic min;

  final dynamic max;

  final SfRangeValues? initialValues;

  final ValueChanged<SfRangeValues>? onChanged;

  final ValueChanged<SfRangeValues>? onChangeStart;

  final ValueChanged<SfRangeValues>? onChangeEnd;

  final RangeController? controller;

  final bool enabled;

  final double? interval;

  final double? stepSize;
  final SliderStepDuration? stepDuration;

  final int deferredUpdateDelay;

  final int minorTicksPerInterval;

  final bool showTicks;

  final bool showLabels;

  final bool showDividers;

  final bool enableTooltip;

  final bool shouldAlwaysShowTooltip;

  final bool enableIntervalSelection;

  final bool enableDeferredUpdate;

  final SliderDragMode dragMode;

  final Color? inactiveColor;

  final Color? activeColor;

  final LabelPlacement labelPlacement;

  final EdgeLabelPlacement edgeLabelPlacement;

  final NumberFormat? numberFormat;

  final DateFormat? dateFormat;

  final DateIntervalType? dateIntervalType;

  final LabelFormatterCallback? labelFormatterCallback;

  final TooltipTextFormatterCallback? tooltipTextFormatterCallback;

  final RangeSelectorSemanticFormatterCallback? semanticFormatterCallback;

  /// Base class for [SfRangeSelector] track shapes.
  final SfTrackShape trackShape;

  /// Base class for [SfRangeSelector] dividers shapes.
  final SfDividerShape dividerShape;

  /// Base class for [SfRangeSelector] overlay shapes.
  final SfOverlayShape overlayShape;

  ///  Base class for [SfRangeSelector] thumb shapes.
  final SfThumbShape thumbShape;

  /// Base class for [SfRangeSelector] major tick shapes.
  final SfTickShape tickShape;

  /// Base class for [SfRangeSelector] minor tick shapes.
  final SfTickShape minorTickShape;
  final SfTooltipShape tooltipShape;

  final Widget child;

  final Widget? startThumbIcon;

  final Widget? endThumbIcon;

  @override
  State<SfRangeSelector> createState() => _SfRangeSelectorState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    if (initialValues != null) {
      properties.add(
        initialValues!.toDiagnosticsNode(name: 'initialValues'),
      );
    }
    properties.add(DiagnosticsProperty<dynamic>('min', min));
    properties.add(DiagnosticsProperty<dynamic>('max', max));
    if (controller != null) {
      properties.add(
        controller!.toDiagnosticsNode(name: 'controller'),
      );
    }
    properties.add(FlagProperty('enabled',
        value: enabled,
        ifTrue: 'Range selector is enabled',
        ifFalse: 'Range selector is disabled'));
    properties.add(DoubleProperty('interval', interval));
    properties.add(DoubleProperty('stepSize', stepSize));
    if (stepDuration != null) {
      properties.add(stepDuration!.toDiagnosticsNode(name: 'stepDuration'));
    }

    properties.add(IntProperty('minorTicksPerInterval', minorTicksPerInterval));
    properties.add(FlagProperty('showTicks',
        value: showTicks,
        ifTrue: 'Ticks are showing',
        ifFalse: 'Ticks are not showing'));
    properties.add(FlagProperty('showLabels',
        value: showLabels,
        ifTrue: 'Labels are showing',
        ifFalse: 'Labels are not showing'));
    properties.add(FlagProperty('showDividers',
        value: showDividers,
        ifTrue: 'Dividers are  showing',
        ifFalse: 'Dividers are not showing'));
    if (shouldAlwaysShowTooltip) {
      properties.add(FlagProperty('shouldAlwaysShowTooltip',
          value: shouldAlwaysShowTooltip, ifTrue: 'Tooltip is always visible'));
    } else {
      properties.add(FlagProperty('enableTooltip',
          value: enableTooltip,
          ifTrue: 'Tooltip is enabled',
          ifFalse: 'Tooltip is disabled'));
    }
    properties.add(FlagProperty('enableIntervalSelection',
        value: enableIntervalSelection,
        ifTrue: 'Interval selection is enabled',
        ifFalse: 'Interval selection is disabled'));
    properties.add(FlagProperty('enableDeferredUpdate',
        value: enableDeferredUpdate,
        ifTrue: 'Deferred update is enabled',
        ifFalse: 'Deferred update is disabled'));
    properties.add(EnumProperty<SliderDragMode>('dragMode', dragMode));
    properties.add(ColorProperty('activeColor', activeColor));
    properties.add(ColorProperty('inactiveColor', inactiveColor));
    properties
        .add(EnumProperty<LabelPlacement>('labelPlacement', labelPlacement));
    properties.add(EnumProperty<EdgeLabelPlacement>(
        'edgeLabelPlacement', edgeLabelPlacement));
    properties
        .add(DiagnosticsProperty<NumberFormat>('numberFormat', numberFormat));
    if (initialValues != null &&
        initialValues!.start.runtimeType == DateTime &&
        dateFormat != null) {
      properties.add(StringProperty('dateFormat',
          'Formatted value is ${dateFormat!.format(initialValues!.start)}'));
    }

    properties.add(ObjectFlagProperty<ValueChanged<SfRangeValues>>.has(
        'onChanged', onChanged));
    properties.add(ObjectFlagProperty<ValueChanged<SfRangeValues>>.has(
        'onChangeStart', onChangeStart));
    properties.add(ObjectFlagProperty<ValueChanged<SfRangeValues>>.has(
        'onChangeEnd', onChangeEnd));
    properties.add(
        EnumProperty<DateIntervalType>('dateIntervalType', dateIntervalType));
    properties.add(ObjectFlagProperty<TooltipTextFormatterCallback>.has(
        'tooltipTextFormatterCallback', tooltipTextFormatterCallback));
    properties.add(ObjectFlagProperty<LabelFormatterCallback>.has(
        'labelFormatterCallback', labelFormatterCallback));
    properties.add(
        ObjectFlagProperty<RangeSelectorSemanticFormatterCallback>.has(
            'semanticFormatterCallback', semanticFormatterCallback));
  }
}

class _SfRangeSelectorState extends State<SfRangeSelector>
    with TickerProviderStateMixin {
  late AnimationController overlayStartController;
  late AnimationController overlayEndController;
  late AnimationController startPositionController;
  late AnimationController endPositionController;
  late AnimationController stateController;
  late AnimationController tooltipAnimationStartController;
  late AnimationController tooltipAnimationEndController;
  final Duration duration = const Duration(milliseconds: 100);
  SfRangeValues? _values;

  String _getFormattedLabelText(dynamic actualText, String formattedText) {
    return formattedText;
  }

  String _getFormattedTooltipText(dynamic actualText, String formattedText) {
    return formattedText;
  }

  SfRangeSelectorThemeData _getRangeSelectorThemeData(ThemeData themeData) {
    SfRangeSelectorThemeData rangeSelectorThemeData =
        SfRangeSelectorTheme.of(context)!;
    final double minTrackHeight = math.min(
        rangeSelectorThemeData.activeTrackHeight,
        rangeSelectorThemeData.inactiveTrackHeight);
    final double maxTrackHeight = math.max(
        rangeSelectorThemeData.activeTrackHeight,
        rangeSelectorThemeData.inactiveTrackHeight);
    rangeSelectorThemeData = rangeSelectorThemeData.copyWith(
      activeTrackHeight: rangeSelectorThemeData.activeTrackHeight,
      inactiveTrackHeight: rangeSelectorThemeData.inactiveTrackHeight,
      tickSize: rangeSelectorThemeData.tickSize,
      minorTickSize: rangeSelectorThemeData.minorTickSize,
      tickOffset: rangeSelectorThemeData.tickOffset,
      labelOffset: rangeSelectorThemeData.labelOffset ??
          (widget.showTicks ? const Offset(0.0, 5.0) : const Offset(0.0, 13.0)),
      inactiveLabelStyle: rangeSelectorThemeData.inactiveLabelStyle ??
          themeData.textTheme.bodyText1!.copyWith(
              color: widget.enabled
                  ? themeData.textTheme.bodyText1!.color!.withOpacity(0.87)
                  : themeData.colorScheme.onSurface.withOpacity(0.32)),
      activeLabelStyle: rangeSelectorThemeData.activeLabelStyle ??
          themeData.textTheme.bodyText1!.copyWith(
              color: widget.enabled
                  ? themeData.textTheme.bodyText1!.color!.withOpacity(0.87)
                  : themeData.colorScheme.onSurface.withOpacity(0.32)),
      tooltipTextStyle: rangeSelectorThemeData.tooltipTextStyle ??
          themeData.textTheme.bodyText1!
              .copyWith(color: themeData.colorScheme.surface),
      inactiveTrackColor: widget.inactiveColor ??
          rangeSelectorThemeData.inactiveTrackColor ??
          themeData.colorScheme.primary.withOpacity(0.24),
      activeTrackColor: widget.activeColor ??
          rangeSelectorThemeData.activeTrackColor ??
          themeData.colorScheme.primary,
      thumbColor: widget.activeColor ??
          rangeSelectorThemeData.thumbColor ??
          themeData.colorScheme.primary,
      activeTickColor: rangeSelectorThemeData.activeTickColor ??
          themeData.colorScheme.onSurface.withOpacity(0.37),
      inactiveTickColor: rangeSelectorThemeData.inactiveTickColor ??
          themeData.colorScheme.onSurface.withOpacity(0.37),
      disabledActiveTickColor: rangeSelectorThemeData.disabledActiveTickColor ??
          themeData.colorScheme.onSurface.withOpacity(0.24),
      disabledInactiveTickColor:
          rangeSelectorThemeData.disabledInactiveTickColor ??
              themeData.colorScheme.onSurface.withOpacity(0.24),
      activeMinorTickColor: rangeSelectorThemeData.activeMinorTickColor ??
          themeData.colorScheme.onSurface.withOpacity(0.37),
      inactiveMinorTickColor: rangeSelectorThemeData.inactiveMinorTickColor ??
          themeData.colorScheme.onSurface.withOpacity(0.37),
      disabledActiveMinorTickColor:
          rangeSelectorThemeData.disabledActiveMinorTickColor ??
              themeData.colorScheme.onSurface.withOpacity(0.24),
      // ignore: lines_longer_than_80_chars
      disabledInactiveMinorTickColor:
          rangeSelectorThemeData.disabledInactiveMinorTickColor ??
              themeData.colorScheme.onSurface.withOpacity(0.24),
      overlayColor: widget.activeColor?.withOpacity(0.12) ??
          rangeSelectorThemeData.overlayColor ??
          themeData.colorScheme.primary.withOpacity(0.12),
      inactiveDividerColor: widget.activeColor ??
          rangeSelectorThemeData.inactiveDividerColor ??
          themeData.colorScheme.primary.withOpacity(0.54),
      activeDividerColor: widget.inactiveColor ??
          rangeSelectorThemeData.activeDividerColor ??
          themeData.colorScheme.onPrimary.withOpacity(0.54),
      disabledInactiveDividerColor:
          rangeSelectorThemeData.disabledInactiveDividerColor ??
              themeData.colorScheme.onSurface.withOpacity(0.12),
      disabledActiveDividerColor:
          rangeSelectorThemeData.disabledActiveDividerColor ??
              themeData.colorScheme.onPrimary.withOpacity(0.12),
      disabledActiveTrackColor:
          rangeSelectorThemeData.disabledActiveTrackColor ??
              themeData.colorScheme.onSurface.withOpacity(0.32),
      disabledInactiveTrackColor:
          rangeSelectorThemeData.disabledInactiveTrackColor ??
              themeData.colorScheme.onSurface.withOpacity(0.12),
      disabledThumbColor: rangeSelectorThemeData.disabledThumbColor ??
          Color.alphaBlend(themeData.colorScheme.onSurface.withOpacity(0.38),
              themeData.colorScheme.surface),
      thumbStrokeColor: rangeSelectorThemeData.thumbStrokeColor,
      overlappingThumbStrokeColor:
          rangeSelectorThemeData.overlappingThumbStrokeColor ??
              themeData.colorScheme.surface,
      activeDividerStrokeColor: rangeSelectorThemeData.activeDividerStrokeColor,
      inactiveDividerStrokeColor:
          rangeSelectorThemeData.inactiveDividerStrokeColor,
      overlappingTooltipStrokeColor:
          rangeSelectorThemeData.overlappingTooltipStrokeColor ??
              themeData.colorScheme.surface,
      activeRegionColor:
          rangeSelectorThemeData.activeRegionColor ?? Colors.transparent,
      inactiveRegionColor: widget.inactiveColor ??
          rangeSelectorThemeData.inactiveRegionColor ??
          (themeData.brightness == Brightness.light
              ? const Color.fromRGBO(255, 255, 255, 1).withOpacity(0.75)
              : const Color.fromRGBO(48, 48, 48, 1).withOpacity(0.75)),
      tooltipBackgroundColor: rangeSelectorThemeData.tooltipBackgroundColor ??
          (themeData.brightness == Brightness.light
              ? const Color.fromRGBO(97, 97, 97, 1)
              : const Color.fromRGBO(224, 224, 224, 1)),
      trackCornerRadius:
          rangeSelectorThemeData.trackCornerRadius ?? maxTrackHeight / 2,
      thumbRadius: rangeSelectorThemeData.thumbRadius,
      overlayRadius: rangeSelectorThemeData.overlayRadius,
      activeDividerRadius:
          rangeSelectorThemeData.activeDividerRadius ?? minTrackHeight / 4,
      inactiveDividerRadius:
          rangeSelectorThemeData.inactiveDividerRadius ?? minTrackHeight / 4,
      thumbStrokeWidth: rangeSelectorThemeData.thumbStrokeWidth,
      activeDividerStrokeWidth: rangeSelectorThemeData.activeDividerStrokeWidth,
      inactiveDividerStrokeWidth:
          rangeSelectorThemeData.inactiveDividerStrokeWidth,
    );

    return rangeSelectorThemeData;
  }

  void _onChangeStart(SfRangeValues values) {
    if (widget.onChangeStart != null && widget.enabled) {
      widget.onChangeStart!(values);
    }
  }

  void _onChangeEnd(SfRangeValues values) {
    if (widget.onChangeEnd != null && widget.enabled) {
      widget.onChangeEnd!(values);
    }
  }

  @override
  void initState() {
    if (widget.controller != null) {
      assert(widget.controller!.start != null);
      assert(widget.controller!.end != null);
      _values = SfRangeValues(widget.controller!.start, widget.controller!.end);
    }

    overlayStartController =
        AnimationController(vsync: this, duration: duration);
    overlayEndController = AnimationController(vsync: this, duration: duration);
    stateController = AnimationController(vsync: this, duration: duration);
    startPositionController =
        AnimationController(duration: Duration.zero, vsync: this);
    endPositionController =
        AnimationController(duration: Duration.zero, vsync: this);
    tooltipAnimationStartController =
        AnimationController(vsync: this, duration: duration);
    tooltipAnimationEndController =
        AnimationController(vsync: this, duration: duration);
    stateController.value =
        widget.enabled && (widget.min != widget.max) ? 1.0 : 0.0;
    super.initState();
  }

  @override
  void didUpdateWidget(SfRangeSelector oldWidget) {
    if (oldWidget.shouldAlwaysShowTooltip != widget.shouldAlwaysShowTooltip) {
      if (widget.shouldAlwaysShowTooltip) {
        tooltipAnimationStartController.value = 1;
        tooltipAnimationEndController.value = 1;
      } else {
        tooltipAnimationStartController.value = 0;
        tooltipAnimationEndController.value = 0;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    overlayStartController.dispose();
    overlayEndController.dispose();
    startPositionController.dispose();
    endPositionController.dispose();
    tooltipAnimationStartController.dispose();
    tooltipAnimationEndController.dispose();
    stateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return _RangeSelectorRenderObjectWidget(
      key: widget.key,
      min: widget.min,
      max: widget.max,
      values: _values ?? widget.initialValues,
      onChangeStart: widget.onChangeStart != null ? _onChangeStart : null,
      onChangeEnd: widget.onChangeEnd != null ? _onChangeEnd : null,
      enabled: widget.enabled && widget.min != widget.max,
      interval: widget.interval,
      stepSize: widget.stepSize,
      stepDuration: widget.stepDuration,
      deferUpdateDelay: widget.deferredUpdateDelay,
      minorTicksPerInterval: widget.minorTicksPerInterval,
      showTicks: widget.showTicks,
      showLabels: widget.showLabels,
      showDividers: widget.showDividers,
      enableTooltip: widget.enableTooltip,
      shouldAlwaysShowTooltip: widget.shouldAlwaysShowTooltip,
      enableIntervalSelection: widget.enableIntervalSelection,
      deferUpdate: widget.enableDeferredUpdate,
      dragMode: widget.dragMode,
      inactiveColor:
          widget.inactiveColor ?? themeData.primaryColor.withOpacity(0.24),
      activeColor: widget.activeColor ?? themeData.primaryColor,
      labelPlacement: widget.labelPlacement,
      edgeLabelPlacement: widget.edgeLabelPlacement,
      numberFormat: widget.numberFormat ?? NumberFormat('#.##'),
      dateFormat: widget.dateFormat,
      dateIntervalType: widget.dateIntervalType,
      labelFormatterCallback:
          widget.labelFormatterCallback ?? _getFormattedLabelText,
      tooltipTextFormatterCallback:
          widget.tooltipTextFormatterCallback ?? _getFormattedTooltipText,
      semanticFormatterCallback: widget.semanticFormatterCallback,
      trackShape: widget.trackShape,
      dividerShape: widget.dividerShape,
      overlayShape: widget.overlayShape,
      thumbShape: widget.thumbShape,
      tickShape: widget.tickShape,
      minorTickShape: widget.minorTickShape,
      tooltipShape: widget.tooltipShape,
      rangeSelectorThemeData: _getRangeSelectorThemeData(themeData),
      startThumbIcon: widget.startThumbIcon,
      endThumbIcon: widget.endThumbIcon,
      state: this,
      child: widget.child,
    );
  }
}

class _RangeSelectorRenderObjectWidget extends RenderObjectWidget {
  const _RangeSelectorRenderObjectWidget({
    Key? key,
    required this.min,
    required this.max,
    required this.values,
    required this.onChangeStart,
    required this.onChangeEnd,
    required this.enabled,
    required this.interval,
    required this.stepSize,
    required this.stepDuration,
    required this.deferUpdateDelay,
    required this.minorTicksPerInterval,
    required this.showTicks,
    required this.showLabels,
    required this.showDividers,
    required this.enableTooltip,
    required this.shouldAlwaysShowTooltip,
    required this.enableIntervalSelection,
    required this.deferUpdate,
    required this.dragMode,
    required this.inactiveColor,
    required this.activeColor,
    required this.labelPlacement,
    required this.edgeLabelPlacement,
    required this.numberFormat,
    required this.dateFormat,
    required this.dateIntervalType,
    required this.labelFormatterCallback,
    required this.tooltipTextFormatterCallback,
    required this.semanticFormatterCallback,
    required this.trackShape,
    required this.dividerShape,
    required this.overlayShape,
    required this.thumbShape,
    required this.tickShape,
    required this.minorTickShape,
    required this.tooltipShape,
    required this.child,
    required this.rangeSelectorThemeData,
    required this.startThumbIcon,
    required this.endThumbIcon,
    required this.state,
  }) : super(key: key);

  final dynamic min;
  final dynamic max;
  final SfRangeValues? values;
  final ValueChanged<SfRangeValues>? onChangeStart;
  final ValueChanged<SfRangeValues>? onChangeEnd;
  final bool enabled;
  final double? interval;
  final double? stepSize;
  final SliderStepDuration? stepDuration;
  final int deferUpdateDelay;
  final int minorTicksPerInterval;

  final bool showTicks;
  final bool showLabels;
  final bool showDividers;
  final bool enableTooltip;
  final bool enableIntervalSelection;
  final bool deferUpdate;
  final bool shouldAlwaysShowTooltip;
  final SliderDragMode dragMode;

  final Color inactiveColor;
  final Color activeColor;

  final LabelPlacement labelPlacement;
  final EdgeLabelPlacement edgeLabelPlacement;
  final NumberFormat numberFormat;
  final DateFormat? dateFormat;
  final DateIntervalType? dateIntervalType;
  final SfRangeSelectorThemeData rangeSelectorThemeData;
  final LabelFormatterCallback labelFormatterCallback;
  final TooltipTextFormatterCallback tooltipTextFormatterCallback;
  final RangeSelectorSemanticFormatterCallback? semanticFormatterCallback;
  final SfTrackShape trackShape;
  final SfDividerShape dividerShape;
  final SfOverlayShape overlayShape;
  final SfThumbShape thumbShape;
  final SfTickShape tickShape;
  final SfTickShape minorTickShape;
  final SfTooltipShape tooltipShape;
  final Widget child;
  final Widget? startThumbIcon;
  final Widget? endThumbIcon;
  final _SfRangeSelectorState state;

  @override
  _RenderRangeSelectorElement createElement() =>
      _RenderRangeSelectorElement(this);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderRangeSelector(
      min: min,
      max: max,
      values: values,
      onChangeStart: onChangeStart,
      onChangeEnd: onChangeEnd,
      enabled: enabled,
      interval: interval,
      stepSize: stepSize,
      stepDuration: stepDuration,
      deferUpdateDelay: deferUpdateDelay,
      minorTicksPerInterval: minorTicksPerInterval,
      showTicks: showTicks,
      showLabels: showLabels,
      showDividers: showDividers,
      enableTooltip: enableTooltip,
      shouldAlwaysShowTooltip: shouldAlwaysShowTooltip,
      isInversed: Directionality.of(context) == TextDirection.rtl,
      enableIntervalSelection: enableIntervalSelection,
      deferUpdate: deferUpdate,
      dragMode: dragMode,
      labelPlacement: labelPlacement,
      edgeLabelPlacement: edgeLabelPlacement,
      numberFormat: numberFormat,
      dateFormat: dateFormat,
      dateIntervalType: dateIntervalType,
      labelFormatterCallback: labelFormatterCallback,
      tooltipTextFormatterCallback: tooltipTextFormatterCallback,
      semanticFormatterCallback: semanticFormatterCallback,
      trackShape: trackShape,
      dividerShape: dividerShape,
      overlayShape: overlayShape,
      thumbShape: thumbShape,
      tickShape: tickShape,
      minorTickShape: minorTickShape,
      tooltipShape: tooltipShape,
      rangeSelectorThemeData: rangeSelectorThemeData,
      textDirection: Directionality.of(context),
      mediaQueryData: MediaQuery.of(context),
      state: state,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderRangeSelector renderObject) {
    renderObject
      ..min = min
      ..max = max
      ..onChangeStart = onChangeStart
      ..onChangeEnd = onChangeEnd
      ..isInteractive = enabled
      ..interval = interval
      ..stepSize = stepSize
      ..stepDuration = stepDuration
      ..deferUpdateDelay = deferUpdateDelay
      ..minorTicksPerInterval = minorTicksPerInterval
      ..showTicks = showTicks
      ..showLabels = showLabels
      ..showDividers = showDividers
      ..enableTooltip = enableTooltip
      ..shouldAlwaysShowTooltip = shouldAlwaysShowTooltip
      ..isInversed = Directionality.of(context) == TextDirection.rtl
      ..enableIntervalSelection = enableIntervalSelection
      ..deferUpdate = deferUpdate
      ..dragMode = dragMode
      ..labelPlacement = labelPlacement
      ..edgeLabelPlacement = edgeLabelPlacement
      ..numberFormat = numberFormat
      ..dateFormat = dateFormat
      ..dateIntervalType = dateIntervalType
      ..labelFormatterCallback = labelFormatterCallback
      ..tooltipTextFormatterCallback = tooltipTextFormatterCallback
      ..semanticFormatterCallback = semanticFormatterCallback
      ..trackShape = trackShape
      ..dividerShape = dividerShape
      ..overlayShape = overlayShape
      ..thumbShape = thumbShape
      ..tickShape = tickShape
      ..minorTickShape = minorTickShape
      ..tooltipShape = tooltipShape
      ..sliderThemeData = rangeSelectorThemeData
      ..textDirection = Directionality.of(context)
      ..mediaQueryData = MediaQuery.of(context);
  }
}

class _RenderRangeSelectorElement extends RenderObjectElement {
  _RenderRangeSelectorElement(_RangeSelectorRenderObjectWidget rangeSelector)
      : super(rangeSelector);

  final Map<ChildElements, Element> _slotToChild = <ChildElements, Element>{};
  final Map<Element, ChildElements> _childToSlot = <Element, ChildElements>{};

  @override
  _RangeSelectorRenderObjectWidget get widget =>
      // ignore: avoid_as
      super.widget as _RangeSelectorRenderObjectWidget;

  @override
  _RenderRangeSelector get renderObject =>
      // ignore: avoid_as
      super.renderObject as _RenderRangeSelector;

  void _updateChild(Widget? widget, ChildElements slot) {
    final Element? oldChild = _slotToChild[slot];
    final Element? newChild = updateChild(oldChild, widget, slot);
    if (oldChild != null) {
      _childToSlot.remove(oldChild);
      _slotToChild.remove(slot);
    }
    if (newChild != null) {
      _slotToChild[slot] = newChild;
      _childToSlot[newChild] = slot;
    }
  }

  void _updateRenderObject(RenderObject? child, ChildElements slot) {
    switch (slot) {
      case ChildElements.startThumbIcon:
        // ignore: avoid_as
        renderObject.startThumbIcon = child as RenderBox?;
        break;
      case ChildElements.endThumbIcon:
        // ignore: avoid_as
        renderObject.endThumbIcon = child as RenderBox?;
        break;
      case ChildElements.child:
        // ignore: avoid_as
        renderObject.child = child as RenderBox?;
        break;
    }
  }

  @override
  void visitChildren(ElementVisitor visitor) {
    _slotToChild.values.forEach(visitor);
  }

  @override
  void mount(Element? parent, dynamic newSlot) {
    super.mount(parent, newSlot);
    _updateChild(widget.startThumbIcon, ChildElements.startThumbIcon);
    _updateChild(widget.endThumbIcon, ChildElements.endThumbIcon);
    _updateChild(widget.child, ChildElements.child);
  }

  @override
  void update(_RangeSelectorRenderObjectWidget newWidget) {
    super.update(newWidget);
    assert(widget == newWidget);
    _updateChild(widget.startThumbIcon, ChildElements.startThumbIcon);
    _updateChild(widget.endThumbIcon, ChildElements.endThumbIcon);
    _updateChild(widget.child, ChildElements.child);
  }

  @override
  void insertRenderObjectChild(RenderObject child, dynamic slotValue) {
    assert(child is RenderBox);
    assert(slotValue is ChildElements);
    // ignore: avoid_as
    final ChildElements slot = slotValue as ChildElements;
    _updateRenderObject(child, slot);
    assert(renderObject.childToSlot.keys.contains(child));
    assert(renderObject.slotToChild.keys.contains(slot));
  }

  @override
  void removeRenderObjectChild(RenderObject child, ChildElements slot) {
    assert(child is RenderBox);
    assert(renderObject.childToSlot.keys.contains(child));
    _updateRenderObject(null, renderObject.childToSlot[child]!);
    assert(!renderObject.childToSlot.keys.contains(child));
    assert(!renderObject.slotToChild.keys.contains(slot));
  }

  @override
  void moveRenderObjectChild(
      RenderObject child, dynamic oldSlot, dynamic newSlot) {
    assert(false, 'not reachable');
  }
}

class _RenderRangeSelector extends RenderBaseRangeSlider {
  _RenderRangeSelector({
    required dynamic min,
    required dynamic max,
    required SfRangeValues? values,
    required ValueChanged<SfRangeValues>? onChangeStart,
    required ValueChanged<SfRangeValues>? onChangeEnd,
    required bool enabled,
    required double? interval,
    required double? stepSize,
    required SliderStepDuration? stepDuration,
    required int deferUpdateDelay,
    required int minorTicksPerInterval,
    required bool showTicks,
    required bool showLabels,
    required bool showDividers,
    required bool enableTooltip,
    required bool shouldAlwaysShowTooltip,
    required bool isInversed,
    required bool enableIntervalSelection,
    required bool deferUpdate,
    required SliderDragMode dragMode,
    required LabelPlacement labelPlacement,
    required EdgeLabelPlacement edgeLabelPlacement,
    required NumberFormat numberFormat,
    required DateFormat? dateFormat,
    required DateIntervalType? dateIntervalType,
    required LabelFormatterCallback labelFormatterCallback,
    required TooltipTextFormatterCallback tooltipTextFormatterCallback,
    required RangeSelectorSemanticFormatterCallback? semanticFormatterCallback,
    required SfTrackShape trackShape,
    required SfDividerShape dividerShape,
    required SfOverlayShape overlayShape,
    required SfThumbShape thumbShape,
    required SfTickShape tickShape,
    required SfTickShape minorTickShape,
    required SfTooltipShape tooltipShape,
    required SfRangeSelectorThemeData rangeSelectorThemeData,
    required TextDirection textDirection,
    required MediaQueryData mediaQueryData,
    required _SfRangeSelectorState state,
  })  : _state = state,
        _isEnabled = enabled,
        _deferUpdateDelay = deferUpdateDelay,
        _deferUpdate = deferUpdate,
        _semanticFormatterCallback = semanticFormatterCallback,
        super(
            min: min,
            max: max,
            values: values,
            onChangeStart: onChangeStart,
            onChangeEnd: onChangeEnd,
            interval: interval,
            stepSize: stepSize,
            stepDuration: stepDuration,
            minorTicksPerInterval: minorTicksPerInterval,
            showTicks: showTicks,
            showLabels: showLabels,
            showDividers: showDividers,
            enableTooltip: enableTooltip,
            shouldAlwaysShowTooltip: shouldAlwaysShowTooltip,
            isInversed: isInversed,
            enableIntervalSelection: enableIntervalSelection,
            dragMode: dragMode,
            labelPlacement: labelPlacement,
            edgeLabelPlacement: edgeLabelPlacement,
            numberFormat: numberFormat,
            dateFormat: dateFormat,
            dateIntervalType: dateIntervalType,
            labelFormatterCallback: labelFormatterCallback,
            tooltipTextFormatterCallback: tooltipTextFormatterCallback,
            trackShape: trackShape,
            dividerShape: dividerShape,
            overlayShape: overlayShape,
            thumbShape: thumbShape,
            tickShape: tickShape,
            minorTickShape: minorTickShape,
            tooltipShape: tooltipShape,
            sliderThemeData: rangeSelectorThemeData,
            sliderType: SliderType.horizontal,
            tooltipPosition: null,
            textDirection: textDirection,
            mediaQueryData: mediaQueryData) {
    _inactiveRegionColor = rangeSelectorThemeData.inactiveRegionColor!;
    _activeRegionColor = rangeSelectorThemeData.activeRegionColor!;
  }

  final _SfRangeSelectorState _state;
  late Color _inactiveRegionColor;
  late Color _activeRegionColor;
  Timer? _deferUpdateTimer;

  @override
  bool get isInteractive => _isEnabled;
  bool _isEnabled;
  set isInteractive(bool value) {
    if (_isEnabled == value) {
      return;
    }
    final bool wasEnabled = isInteractive;
    _isEnabled = value;
    if (wasEnabled != isInteractive) {
      if (isInteractive) {
        _state.stateController.forward();
      } else {
        _state.stateController.reverse();
      }
    }
    markNeedsLayout();
  }

  int get deferUpdateDelay => _deferUpdateDelay;
  int _deferUpdateDelay;
  set deferUpdateDelay(int value) {
    if (_deferUpdateDelay == value) {
      return;
    }
    _deferUpdateDelay = value;
  }

  bool get deferUpdate => _deferUpdate;
  late bool _deferUpdate;
  set deferUpdate(bool value) {
    if (_deferUpdate == value) {
      return;
    }
    _deferUpdate = value;
  }

  RangeSelectorSemanticFormatterCallback? get semanticFormatterCallback =>
      _semanticFormatterCallback;
  RangeSelectorSemanticFormatterCallback? _semanticFormatterCallback;
  set semanticFormatterCallback(RangeSelectorSemanticFormatterCallback? value) {
    if (_semanticFormatterCallback == value) {
      return;
    }
    _semanticFormatterCallback = value;
    markNeedsSemanticsUpdate();
  }

  @override
  set sliderThemeData(SfSliderThemeData value) {
    if (super.sliderThemeData == value) {
      return;
    }
    super.sliderThemeData = value;
    maxTrackHeight = getMaxTrackHeight();

    if (value is SfRangeSelectorThemeData) {
      _inactiveRegionColor = value.inactiveRegionColor!;
      _activeRegionColor = value.activeRegionColor!;
    }
    markNeedsPaint();
  }

  @override
  bool get mounted => _state.mounted;

  @override
  AnimationController get overlayStartController =>
      _state.overlayStartController;

  @override
  AnimationController get overlayEndController => _state.overlayEndController;

  @override
  AnimationController get stateController => _state.stateController;

  @override
  AnimationController get startPositionController =>
      _state.startPositionController;

  @override
  AnimationController get endPositionController => _state.endPositionController;

  @override
  AnimationController get tooltipAnimationStartController =>
      _state.tooltipAnimationStartController;

  @override
  AnimationController get tooltipAnimationEndController =>
      _state.tooltipAnimationEndController;

  @override
  RenderBox? get child => _child;
  RenderBox? _child;

  @override
  set child(RenderBox? value) {
    _child = updateChild(_child, value, ChildElements.child);
  }

  Iterable<RenderBox> get children sync* {
    if (startThumbIcon != null) {
      yield startThumbIcon!;
    }
    if (endThumbIcon != null) {
      yield endThumbIcon!;
    }
    if (child != null) {
      yield child!;
    }
  }

  double get elementsActualHeight => math.max(
      2 * trackOffset.dy,
      trackOffset.dy +
          maxTrackHeight / 2 +
          math.max(actualTickHeight, actualMinorTickHeight) +
          actualLabelHeight);

  // When the active track height and inactive track height are different,
  // a small gap is happens between min track height and child
  // So we adjust track offset to ignore that gap.
  double get adjustTrackY => sliderThemeData.activeTrackHeight >
          sliderThemeData.inactiveTrackHeight
      ? sliderThemeData.activeTrackHeight - sliderThemeData.inactiveTrackHeight
      : sliderThemeData.inactiveTrackHeight - sliderThemeData.activeTrackHeight;

  void _updateNewValues(SfRangeValues newValues) {
    if (_state.widget.onChanged != null) {
      _state.widget.onChanged!(newValues);
    }
    if (_state.widget.controller != null) {
      _state.widget.controller!.start = newValues.start;
      _state.widget.controller!.end = newValues.end;
    } else if (!_deferUpdate) {
      values = newValues;
      markNeedsPaint();
    }
  }

  void _handleRangeControllerChange() {
    if (_state.mounted &&
        _state.widget.controller != null &&
        (values.start != _state.widget.controller!.start ||
            values.end != _state.widget.controller!.end)) {
      values = SfRangeValues(
          getActualValue(value: _state.widget.controller!.start),
          getActualValue(value: _state.widget.controller!.end));

      markNeedsPaint();
    }
  }

  @override
  void updateValues(SfRangeValues newValues) {
    if (_isEnabled && !isIntervalTapped) {
      if (newValues.start != values.start || newValues.end != values.end) {
        if (_deferUpdate) {
          _deferUpdateTimer?.cancel();
          _deferUpdateTimer =
              Timer(Duration(milliseconds: _deferUpdateDelay), () {
            _updateNewValues(newValues);
          });
          values = newValues;
          markNeedsPaint();
        } else {
          _updateNewValues(newValues);
        }
      }
    }
    super.updateValues(newValues);
  }

  @override
  void updateIntervalTappedAndDeferredUpdateValues(SfRangeValues newValues) {
    if (isIntervalTapped) {
      _updateNewValues(newValues);
    }
    // Default, we only update new values when dragging.
    // If [deferUpdate] is enabled, new values are updated with
    // [deferUpdateDelay].
    // But touch up is handled before the [deferUpdateDelay] timer,
    // we have to invoke [onChanged] call back with new values and
    // update the new values to the [controller] immediately.
    if (_deferUpdate) {
      _deferUpdateTimer?.cancel();
      _updateNewValues(newValues);
    }
  }

  void _drawRegions(PaintingContext context, Rect trackRect, Offset offset,
      Offset startThumbCenter, Offset endThumbCenter) {
    final Paint inactivePaint = Paint()
      ..isAntiAlias = true
      ..color = _inactiveRegionColor;
    if (child != null && child!.size.height > 1 && child!.size.width > 1) {
      final double halfActiveTrackHeight =
          sliderThemeData.activeTrackHeight / 2;
      final double halfInactiveTrackHeight =
          sliderThemeData.inactiveTrackHeight / 2;
      final bool isMaxActive = sliderThemeData.activeTrackHeight >
          sliderThemeData.inactiveTrackHeight;
      Offset leftThumbCenter;
      Offset rightThumbCenter;
      if (textDirection == TextDirection.rtl) {
        leftThumbCenter = endThumbCenter;
        rightThumbCenter = startThumbCenter;
      } else {
        leftThumbCenter = startThumbCenter;
        rightThumbCenter = endThumbCenter;
      }

      //Below values are used to fit active and inactive region into the track.
      final double inactiveRegionAdj =
          isMaxActive ? halfActiveTrackHeight - halfInactiveTrackHeight : 0;
      final double activeRegionAdj =
          !isMaxActive ? halfInactiveTrackHeight - halfActiveTrackHeight : 0;
      context.canvas.drawRect(
          Rect.fromLTRB(trackRect.left, offset.dy, leftThumbCenter.dx,
              trackRect.top + inactiveRegionAdj),
          inactivePaint);
      final Paint activePaint = Paint()
        ..isAntiAlias = true
        ..color = _activeRegionColor;
      context.canvas.drawRect(
          Rect.fromLTRB(leftThumbCenter.dx, offset.dy, rightThumbCenter.dx,
              trackRect.top + activeRegionAdj),
          activePaint);
      context.canvas.drawRect(
          Rect.fromLTRB(rightThumbCenter.dx, offset.dy, trackRect.right,
              trackRect.top + inactiveRegionAdj),
          inactivePaint);
    }
  }

  void _increaseStartAction() {
    if (isInteractive) {
      final SfRangeValues newValues =
          SfRangeValues(increasedStartValue, values.end);
      if (getNumerizedValue(newValues.start) <=
          getNumerizedValue(newValues.end)) {
        _updateNewValues(newValues);
      }
    }
  }

  void _decreaseStartAction() {
    if (isInteractive) {
      _updateNewValues(SfRangeValues(decreasedStartValue, values.end));
    }
  }

  void _increaseEndAction() {
    if (isInteractive) {
      _updateNewValues(SfRangeValues(values.start, increasedEndValue));
    }
  }

  void _decreaseEndAction() {
    if (isInteractive) {
      final SfRangeValues newValues =
          SfRangeValues(values.start, decreasedEndValue);
      if (getNumerizedValue(newValues.start) <=
          (getNumerizedValue(newValues.end))) {
        _updateNewValues(newValues);
      }
    }
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    children.forEach(visitor);
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    if (_state.widget.controller != null) {
      _state.widget.controller!.addListener(_handleRangeControllerChange);
    }
    for (final RenderBox child in children) {
      child.attach(owner);
    }
  }

  @override
  void detach() {
    super.detach();
    _deferUpdateTimer?.cancel();
    if (_state.widget.controller != null) {
      _state.widget.controller!.removeListener(_handleRangeControllerChange);
    }
    for (final RenderBox child in children) {
      child.detach();
    }
  }

  @override
  void performLayout() {
    double childHeight = 0.0;
    double childWidth = 0.0;
    final double minTrackHeight = math.min(
        sliderThemeData.activeTrackHeight, sliderThemeData.inactiveTrackHeight);
    final Offset trackCenterLeft = trackOffset;
    final double elementsHeightWithoutChild = elementsActualHeight;

    double elementsHeightAfterRenderedChild = math.max(
        trackCenterLeft.dy + minTrackHeight / 2,
        maxTrackHeight / 2 +
            minTrackHeight / 2 +
            math.max(actualTickHeight, actualMinorTickHeight) +
            actualLabelHeight);

    if (constraints.maxHeight < elementsHeightWithoutChild) {
      final double actualChildHeight =
          elementsHeightWithoutChild - elementsHeightAfterRenderedChild;
      final double spaceLeftInActualLayoutHeight =
          elementsHeightAfterRenderedChild - constraints.maxHeight;
      // Reduce the [elementsHeightAfterRenderedChild] from the
      // actual child height and remaining space in actual layout height to
      // match the given constraints height.
      elementsHeightAfterRenderedChild = elementsHeightAfterRenderedChild -
          spaceLeftInActualLayoutHeight -
          actualChildHeight;
    }

    if (child != null) {
      final double maxRadius = trackOffset.dx;
      final BoxConstraints childConstraints = constraints.deflate(
          EdgeInsets.only(
              left: maxRadius,
              right: maxRadius,
              bottom: elementsHeightAfterRenderedChild));
      child!.layout(childConstraints, parentUsesSize: true);
      // ignore: avoid_as
      final BoxParentData childParentData = child!.parentData! as BoxParentData;
      childParentData.offset = Offset(maxRadius, 0);
      childHeight = child!.size.height;
      childWidth = child!.size.width;
    }

    final BoxConstraints contentConstraints = BoxConstraints.tightFor(
        width: actualThumbSize.width, height: actualThumbSize.height);
    startThumbIcon?.layout(contentConstraints, parentUsesSize: true);
    endThumbIcon?.layout(contentConstraints, parentUsesSize: true);

    final double actualWidth = childWidth > 0.0
        ? (childWidth + 2 * trackOffset.dx)
        : minTrackWidth + 2 * trackOffset.dx;

    final double actualHeight = childHeight + elementsHeightAfterRenderedChild;
    size = Size(
        constraints.hasBoundedWidth && (constraints.maxWidth < actualWidth)
            ? constraints.maxWidth
            : actualWidth,
        constraints.hasBoundedHeight && (constraints.maxHeight < actualHeight)
            ? constraints.maxHeight
            : actualHeight);

    generateLabelsAndMajorTicks();
    generateMinorTicks();
  }

  @override
  void drawRegions(PaintingContext context, Rect trackRect, Offset offset,
      Offset startThumbCenter, Offset endThumbCenter) {
    _drawRegions(context, trackRect, offset, startThumbCenter, endThumbCenter);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    double childHeight = 0.0;
    if (child != null) {
      // ignore: avoid_as
      final BoxParentData childParentData = child!.parentData! as BoxParentData;
      context.paintChild(child!, childParentData.offset + offset);
      childHeight = child!.size.height;
      if (childHeight >= constraints.maxHeight) {
        childHeight -= elementsActualHeight -
            math.max(actualOverlaySize.height, actualThumbSize.height) / 2;
      }
    }

    final Offset actualTrackOffset = Offset(
        offset.dx,
        offset.dy +
            math.max(childHeight - adjustTrackY / 2,
                trackOffset.dy - maxTrackHeight / 2));

    drawRangeSliderElements(context, offset, actualTrackOffset);
  }

  // Create the semantics configuration for a single value.
  SemanticsConfiguration _createSemanticsConfiguration(
    dynamic value,
    dynamic increasedValue,
    dynamic decreasedValue,
    SfThumb thumb,
    VoidCallback increaseAction,
    VoidCallback decreaseAction,
  ) {
    final SemanticsConfiguration config = SemanticsConfiguration();
    config.isEnabled = isInteractive;
    config.textDirection = textDirection;
    if (isInteractive) {
      config.onIncrease = increaseAction;
      config.onDecrease = decreaseAction;
    }

    if (semanticFormatterCallback != null) {
      config.value = semanticFormatterCallback!(value, thumb);
      config.increasedValue = semanticFormatterCallback!(increasedValue, thumb);
      config.decreasedValue = semanticFormatterCallback!(decreasedValue, thumb);
    } else {
      final String thumbValue = thumb.toString().split('.').last;
      config.value = 'the $thumbValue value is $value';
      config.increasedValue = 'the $thumbValue  value is $increasedValue';
      config.decreasedValue = 'the $thumbValue  value is $decreasedValue';
    }
    return config;
  }

  @override
  void assembleSemanticsNode(
    SemanticsNode node,
    SemanticsConfiguration config,
    Iterable<SemanticsNode> children,
  ) {
    assert(children.isEmpty);
    final SemanticsConfiguration startSemanticsConfiguration =
        _createSemanticsConfiguration(
      values.start,
      increasedStartValue,
      decreasedStartValue,
      SfThumb.start,
      _increaseStartAction,
      _decreaseStartAction,
    );
    final SemanticsConfiguration endSemanticsConfiguration =
        _createSemanticsConfiguration(
      values.end,
      increasedEndValue,
      decreasedEndValue,
      SfThumb.end,
      _increaseEndAction,
      _decreaseEndAction,
    );
    // Split the semantics node area between the start and end nodes.
    final Rect leftRect =
        Rect.fromPoints(node.rect.topLeft, node.rect.bottomCenter);
    final Rect rightRect =
        Rect.fromPoints(node.rect.topCenter, node.rect.bottomRight);
    switch (textDirection) {
      case TextDirection.ltr:
        startSemanticsNode!.rect = leftRect;
        endSemanticsNode!.rect = rightRect;
        break;
      case TextDirection.rtl:
        startSemanticsNode!.rect = rightRect;
        endSemanticsNode!.rect = leftRect;
        break;
    }

    startSemanticsNode!.updateWith(config: startSemanticsConfiguration);
    endSemanticsNode!.updateWith(config: endSemanticsConfiguration);

    final List<SemanticsNode> finalChildren = <SemanticsNode>[
      startSemanticsNode!,
      endSemanticsNode!,
    ];

    node.updateWith(config: config, childrenInInversePaintOrder: finalChildren);
  }

  @override
  void clearSemantics() {
    super.clearSemantics();
    startSemanticsNode = null;
    endSemanticsNode = null;
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config.isSemanticBoundary = isInteractive;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(StringProperty('deferredUpdateDelay', '$_deferUpdateDelay ms'));
    debugRangeSliderFillProperties(properties);
  }
}
