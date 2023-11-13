import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart' as physics;

import 'package:lottie/lottie.dart';

class CustomHeader extends Header {
  final Key? key;

  /// The location of the widget.
  /// Only supports [MainAxisAlignment.center],
  /// [MainAxisAlignment.start] and [MainAxisAlignment.end].
  final MainAxisAlignment mainAxisAlignment;

  /// Background color.
  final Color? backgroundColor;

  /// Text on [IndicatorMode.drag].
  final String? dragText;

  /// Text on [IndicatorMode.armed].
  final String? armedText;

  /// Text on [IndicatorMode.ready].
  final String? readyText;

  /// Text on [IndicatorMode.processing].
  final String? processingText;

  /// Text on [IndicatorMode.processed].
  final String? processedText;

  /// Text on [IndicatorResult.noMore].
  final String? noMoreText;

  /// Text on [IndicatorResult.fail].
  final String? failedText;

  /// Whether to display text.
  final bool showText;

  /// Message text.
  /// %T will be replaced with the last time.
  final String? messageText;

  /// Whether to display message.
  final bool showMessage;

  /// The dimension of the text area.
  /// When less than 0, calculate the length of the text widget.
  final double? textDimension;

  /// The dimension of the icon area.
  final double iconDimension;

  /// Spacing between text and icon.
  final double spacing;

  /// Icon when [IndicatorResult.success].
  final Widget? succeededIcon;

  /// Icon when [IndicatorResult.fail].
  final Widget? failedIcon;

  /// Icon when [IndicatorResult.noMore].
  final Widget? noMoreIcon;

  /// Icon on pull.
  final CIPullIconBuilder? pullIconBuilder;

  /// Text style.
  final TextStyle? textStyle;

  /// Build text.
  final CITextBuilder? textBuilder;

  /// Text style.
  final TextStyle? messageStyle;

  /// Build message.
  final CIMessageBuilder? messageBuilder;

  /// Link [Stack.clipBehavior].
  final Clip clipBehavior;

  /// Icon style.
  final IconThemeData? iconTheme;

  /// Progress indicator size.
  final double? progressIndicatorSize;

  /// Progress indicator stroke width.
  /// See [CircularProgressIndicator.strokeWidth].
  final double? progressIndicatorStrokeWidth;

  const CustomHeader({
    this.key,
    double triggerOffset = 70,
    bool clamping = false,
    IndicatorPosition position = IndicatorPosition.above,
    Duration processedDuration = const Duration(seconds: 1),
    physics.SpringDescription? spring,
    SpringBuilder? readySpringBuilder,
    bool springRebound = true,
    FrictionFactor? frictionFactor,
    bool safeArea = true,
    double? infiniteOffset,
    bool? hitOver,
    bool? infiniteHitOver,
    bool hapticFeedback = false,
    bool triggerWhenReach = false,
    bool triggerWhenRelease = false,
    double maxOverOffset = double.infinity,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.backgroundColor,
    this.dragText,
    this.armedText,
    this.readyText,
    this.processingText,
    this.processedText,
    this.noMoreText,
    this.failedText,
    this.showText = true,
    this.messageText,
    this.showMessage = true,
    this.textDimension,
    this.iconDimension = 24,
    this.spacing = 16,
    this.succeededIcon,
    this.failedIcon,
    this.noMoreIcon,
    this.pullIconBuilder,
    this.textStyle ,
    this.textBuilder,
    this.messageStyle,
    this.messageBuilder,
    this.clipBehavior = Clip.hardEdge,
    this.iconTheme,
    this.progressIndicatorSize = 50,
    this.progressIndicatorStrokeWidth,
  }) : super(
    triggerOffset: triggerOffset,
    clamping: clamping,
    processedDuration: processedDuration,
    spring: spring,
    readySpringBuilder: readySpringBuilder,
    springRebound: springRebound,
    frictionFactor: frictionFactor,
    safeArea: safeArea,
    infiniteOffset: infiniteOffset,
    hitOver: hitOver,
    infiniteHitOver: infiniteHitOver,
    position: position,
    hapticFeedback: hapticFeedback,
    triggerWhenReach: triggerWhenReach,
    triggerWhenRelease: triggerWhenRelease,
    maxOverOffset: maxOverOffset,
  );

  @override
  Widget build(BuildContext context, IndicatorState state) {
    return _CustomIndicator(
      key: key,
      state: state,
      backgroundColor: backgroundColor,
      mainAxisAlignment: mainAxisAlignment,
      dragText: dragText ?? 'Pull to refresh',
      armedText: armedText ?? 'Release ready',
      readyText: readyText ?? 'Refreshing...',
      processingText: processingText ?? 'Refreshing...',
      processedText: processedText ?? 'Succeeded',
      noMoreText: noMoreText ?? 'No more',
      failedText: failedText ?? 'Failed',
      showText: showText,
      messageText: messageText ?? 'Last updated at %T',
      showMessage: showMessage,
      textDimension: textDimension,
      iconDimension: iconDimension,
      spacing: spacing,
      reverse: state.reverse,
      succeededIcon: succeededIcon,
      failedIcon: failedIcon,
      noMoreIcon: noMoreIcon,
      pullIconBuilder: pullIconBuilder,
      textStyle: textStyle,
      textBuilder: textBuilder,
      messageStyle: messageStyle,
      messageBuilder: messageBuilder,
      clipBehavior: clipBehavior,
      iconTheme: iconTheme,
      progressIndicatorSize: progressIndicatorSize,
      progressIndicatorStrokeWidth: progressIndicatorStrokeWidth,
    );
  }
}



///-------------------------------


/// Pull icon widget builder.
typedef CIPullIconBuilder = Widget Function(
    BuildContext context, IndicatorState state, double animation);

/// Text widget builder.
typedef CITextBuilder = Widget Function(
    BuildContext context, IndicatorState state, String text);

/// Message widget builder.
typedef CIMessageBuilder = Widget Function(
    BuildContext context, IndicatorState state, String text, DateTime dateTime);

/// Default progress indicator size.
const _kDefaultProgressIndicatorSize = 20.0;

/// Default progress indicator stroke width.
// const _kDefaultProgressIndicatorStrokeWidth = 2.0;

/// Classic indicator.
/// Base widget for [ClassicHeader] and [ClassicFooter].
class _CustomIndicator extends StatefulWidget {
  /// Indicator properties and state.
  final IndicatorState state;

  /// The location of the widget.
  /// Only supports [MainAxisAlignment.center],
  /// [MainAxisAlignment.start] and [MainAxisAlignment.end].
  final MainAxisAlignment mainAxisAlignment;

  /// Background color.
  final Color? backgroundColor;

  /// Text on [IndicatorMode.drag].
  final String dragText;

  /// Text on [IndicatorMode.armed].
  final String armedText;

  /// Text on [IndicatorMode.ready].
  final String readyText;

  /// Text on [IndicatorMode.processing].
  final String processingText;

  /// Text on [IndicatorMode.processed].
  final String processedText;

  /// Text on [IndicatorResult.noMore].
  final String noMoreText;

  /// Text on [IndicatorResult.fail].
  final String failedText;

  /// Whether to display text.
  final bool showText;

  /// Message text.
  /// %T will be replaced with the last time.
  final String messageText;

  /// Whether to display message.
  final bool showMessage;

  /// The dimension of the text area.
  /// When less than 0, calculate the length of the text widget.
  final double? textDimension;

  /// The dimension of the icon area.
  final double iconDimension;

  /// Spacing between text and icon.
  final double spacing;

  /// True for up and left.
  /// False for down and right.
  final bool reverse;

  /// Icon when [IndicatorResult.success].
  final Widget? succeededIcon;

  /// Icon when [IndicatorResult.fail].
  final Widget? failedIcon;

  /// Icon when [IndicatorResult.noMore].
  final Widget? noMoreIcon;

  /// Icon on pull builder.
  final CIPullIconBuilder? pullIconBuilder;

  /// Text style.
  final TextStyle? textStyle;

  /// Build text.
  final CITextBuilder? textBuilder;

  /// Text style.
  final TextStyle? messageStyle;

  /// Build message.
  final CIMessageBuilder? messageBuilder;

  /// Link [Stack.clipBehavior].
  final Clip clipBehavior;

  /// Icon style.
  final IconThemeData? iconTheme;

  /// Progress indicator size.
  final double? progressIndicatorSize;

  /// Progress indicator stroke width.
  /// See [CircularProgressIndicator.strokeWidth].
  final double? progressIndicatorStrokeWidth;

  const _CustomIndicator({
    Key? key,
    required this.state,
    required this.mainAxisAlignment,
    this.backgroundColor,
    required this.dragText,
    required this.armedText,
    required this.readyText,
    required this.processingText,
    required this.processedText,
    required this.noMoreText,
    required this.failedText,
    this.showText = true,
    required this.messageText,
    required this.reverse,
    this.showMessage = true,
    this.textDimension,
    this.iconDimension = 24,
    this.spacing = 16,
    this.succeededIcon,
    this.failedIcon,
    this.noMoreIcon,
    this.pullIconBuilder,
    this.textStyle,
    this.textBuilder,
    this.messageStyle,
    this.messageBuilder,
    this.clipBehavior = Clip.hardEdge,
    this.iconTheme,
    this.progressIndicatorSize,
    this.progressIndicatorStrokeWidth,
  })  : assert(
  mainAxisAlignment == MainAxisAlignment.start ||
      mainAxisAlignment == MainAxisAlignment.center ||
      mainAxisAlignment == MainAxisAlignment.end,
  'Only supports [MainAxisAlignment.center], [MainAxisAlignment.start] and [MainAxisAlignment.end].'),
        super(key: key);

  @override
  State<_CustomIndicator> createState() => _ClassicIndicatorState();
}

class _ClassicIndicatorState extends State<_CustomIndicator>
    with TickerProviderStateMixin<_CustomIndicator> {
  /// Icon [AnimatedSwitcher] switch key.
  late GlobalKey _iconAnimatedSwitcherKey;

  /// Update time.
  late DateTime _updateTime;

  /// Icon animation controller.
  late AnimationController _iconAnimationController;

  MainAxisAlignment get _mainAxisAlignment => widget.mainAxisAlignment;

  double get _offset => widget.state.offset;

  double get _actualTriggerOffset => widget.state.actualTriggerOffset;

  double get _triggerOffset => widget.state.triggerOffset;

  double get _safeOffset => widget.state.safeOffset;

  IndicatorMode get _mode => widget.state.mode;

  IndicatorResult get _result => widget.state.result;

  @override
  void initState() {
    super.initState();
    _iconAnimatedSwitcherKey = GlobalKey();
    _updateTime = DateTime.now();
    _iconAnimationController = AnimationController(
      value: 0,
      vsync: this,
      duration: const Duration(microseconds: 200),
    );
    _iconAnimationController.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(_CustomIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update time.
    if (widget.state.mode == IndicatorMode.processed &&
        oldWidget.state.mode != IndicatorMode.processed) {
      _updateTime = DateTime.now();
    }
    if (widget.state.mode == IndicatorMode.armed &&
        oldWidget.state.mode == IndicatorMode.drag) {
      // Armed animation.
      _iconAnimationController.animateTo(1,
          duration: const Duration(milliseconds: 200));
    } else if (widget.state.mode == IndicatorMode.drag &&
        oldWidget.state.mode == IndicatorMode.armed) {
      // Recovery animation.
      _iconAnimationController.animateBack(0,
          duration: const Duration(milliseconds: 200));
    } else if (widget.state.mode == IndicatorMode.processing &&
        oldWidget.state.mode != IndicatorMode.processing) {
      // Reset animation.
      _iconAnimationController.reset();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _iconAnimationController.dispose();
  }

  /// The text of the current state.
  String get _currentText {
    if (_result == IndicatorResult.noMore) {
      return widget.noMoreText;
    }
    switch (_mode) {
      case IndicatorMode.drag:
        return widget.dragText;
      case IndicatorMode.armed:
        return widget.armedText;
      case IndicatorMode.ready:
        return widget.readyText;
      case IndicatorMode.processing:
        return widget.processingText;
      case IndicatorMode.processed:
      case IndicatorMode.done:
        if (_result == IndicatorResult.fail) {
          return widget.failedText;
        } else {
          // return widget.processedText;
          if(widget.showMessage) {
            return _messageText;
          } else {
            return widget.processedText;
          }
        }
      default:
        return widget.dragText;
    }
  }

  /// Message text.
  String get _messageText {
    if (widget.messageText.contains('%T')) {
      String fillChar = _updateTime.minute < 10 ? "0" : "";
      return widget.messageText.replaceAll(
          "%T", "${_updateTime.hour}:$fillChar${_updateTime.minute}");
    }
    return widget.messageText;
  }

  /// Build icon.
  Widget _buildIcon() {
    if (widget.pullIconBuilder != null) {
      return widget.pullIconBuilder!
          .call(context, widget.state, _iconAnimationController.value);
    }
    Widget icon;
    final iconTheme = widget.iconTheme ?? Theme.of(context).iconTheme;
    ValueKey iconKey;
    final progressIndicatorSize =
        widget.progressIndicatorSize ?? _kDefaultProgressIndicatorSize;
    if (_result == IndicatorResult.noMore) {
      iconKey = const ValueKey(IndicatorResult.noMore);
      icon = SizedBox(
        width: progressIndicatorSize,
        height: progressIndicatorSize,
        child: widget.noMoreIcon ??
            // const Icon(
            //   Icons.inbox_outlined,
            // ),
            Lottie.asset('assets/refresh_progress.json',
              animate: true,
            ),
      );
    } else if (_mode == IndicatorMode.processing ||
        _mode == IndicatorMode.ready) {
      iconKey = const ValueKey(IndicatorMode.processing);
      icon = SizedBox(
        width: progressIndicatorSize,
        height: progressIndicatorSize,
        child: Lottie.asset('assets/refresh_progress.json',
          animate: true,
        ),
        // child: CircularProgressIndicator(
        //   strokeWidth: widget.progressIndicatorStrokeWidth ??
        //       _kDefaultProgressIndicatorStrokeWidth,
        //   color: iconTheme.color,
        // ),
      );
    } else if (_mode == IndicatorMode.processed ||
        _mode == IndicatorMode.done) {
      if (_result == IndicatorResult.fail) {
        iconKey = const ValueKey(IndicatorResult.fail);
        icon = SizedBox(
            width: progressIndicatorSize,
            height: progressIndicatorSize,
          child: widget.failedIcon ??
              Lottie.asset('assets/refresh_failed.json',
                animate: true,
              )
              // const Icon(
              //   Icons.error_outline,
              // ),
        );
      } else {
        iconKey = const ValueKey(IndicatorResult.success);
        icon = SizedBox(
            width: progressIndicatorSize,
            height: progressIndicatorSize,
          child: widget.succeededIcon ??
              Lottie.asset('assets/refresh_success.json',
                animate: true,
              )
              // Transform.rotate(
              //   angle: 0,
              //   child: const Icon(
              //     Icons.done,
              //   ),
              // ),
        );
      }
    } else {
      iconKey = const ValueKey(IndicatorMode.drag);
      icon = SizedBox(
        width: progressIndicatorSize,
        height: progressIndicatorSize,
        child: Lottie.asset('assets/refresh_pull_down.json',
          animate: true,
          width: 30,
          height: 30,
        ),
        // child: Transform.rotate(
        //   angle: -math.pi * _iconAnimationController.value,
        //   child: Icon(widget.reverse
        //       ? (_axis == Axis.vertical ? Icons.arrow_upward : Icons.arrow_back)
        //       : (_axis == Axis.vertical
        //       ? Icons.arrow_downward
        //       : Icons.arrow_forward)),
        // ),
      );
    }
    return AnimatedSwitcher(
      key: _iconAnimatedSwitcherKey,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      child: IconTheme(
        key: iconKey,
        data: iconTheme,
        child: icon,
      ),
    );
  }

  /// Build text.
  Widget _buildText() {
    return widget.textBuilder?.call(context, widget.state, _currentText) ??
        Text(
          _currentText,
          // ignore: deprecated_member_use
          style: widget.textStyle ?? Theme.of(context).textTheme.subtitle1,
        );
  }

  /// When the list direction is vertically.
  Widget _buildVerticalWidget() {
    return Stack(
      clipBehavior: widget.clipBehavior,
      children: [
        if (_mainAxisAlignment == MainAxisAlignment.center)
          Positioned(
            left: 0,
            right: 0,
            top: _offset < _actualTriggerOffset
                ? -(_actualTriggerOffset -
                _offset +
                (widget.reverse ? _safeOffset : -_safeOffset)) /
                2
                : (!widget.reverse ? _safeOffset : 0),
            bottom: _offset < _actualTriggerOffset
                ? null
                : (widget.reverse ? _safeOffset : 0),
            height:
            _offset < _actualTriggerOffset ? _actualTriggerOffset : null,
            child: Center(
              child: _buildVerticalBody(),
            ),
          ),
        if (_mainAxisAlignment != MainAxisAlignment.center)
          Positioned(
            left: 0,
            right: 0,
            top: _mainAxisAlignment == MainAxisAlignment.start
                ? (!widget.reverse ? _safeOffset : 0)
                : null,
            bottom: _mainAxisAlignment == MainAxisAlignment.end
                ? (widget.reverse ? _safeOffset : 0)
                : null,
            child: _buildVerticalBody(),
          ),
      ],
    );
  }

  /// The body when the list is vertically direction.
  Widget _buildVerticalBody() {
    return Container(
      alignment: Alignment.center,
      height: _triggerOffset,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: widget.iconDimension,
            child: _buildIcon(),
          ),
          if (widget.showText)
            Container(
              margin: EdgeInsets.symmetric(horizontal: widget.spacing),
              width: widget.textDimension,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildText(),
                  // if (widget.showMessage) _buildMessage(),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double offset = _offset;
    if (widget.state.indicator.infiniteOffset != null &&
        widget.state.indicator.position == IndicatorPosition.locator &&
        (_mode != IndicatorMode.inactive ||
            _result == IndicatorResult.noMore)) {
      offset = _actualTriggerOffset;
    }
    return Container(
      color: widget.backgroundColor,
      width: double.infinity,
      height: offset,
      child: _buildVerticalWidget(),
    );
  }
}