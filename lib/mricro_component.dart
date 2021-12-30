import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import 'dart:math' as math show sin, pi, sqrt;
import 'package:flutter/animation.dart';



class CurveWave extends Curve {
  const CurveWave();
  @override
  double transform(double t) {
    if (t == 0 || t == 1) {
      return 0.01;
    }
    return math.sin(t * math.pi);
  }
}

class MicroComponent extends StatefulWidget {
  MicroComponent({
    this.size = 80.0,
    this.color = Colors.red,
    required this.onPressed,
    required this.status,
    required this.onPressedEnd,
  });
  final double size;
  final Color color;
  final VoidCallback onPressed;
  final VoidCallback onPressedEnd;
  bool status;
  @override
  _RipplesAnimationState createState() => _RipplesAnimationState();
}

class _RipplesAnimationState extends State<MicroComponent>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _button() {
    return GestureDetector(
      // highlightColor: Colors.transparent,
      // splashColor: Colors.transparent,
      onLongPress: () {
        widget.onPressed();
      },
      onLongPressEnd: (details) {
        widget.onPressedEnd();
      },
      // onLongPressEnd: () {
      //   widget.onPressedEnd();
      // },
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.size),
          child: widget.status
              ? ScaleTransition(
                  scale: Tween(begin: 0.95, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: const CurveWave(),
                    ),
                  ),
                  child: Icon(
                    Icons.mic_rounded,
                    size: 44,
                    color: Colors.white,
                  ),
                )
              : Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    color: Color(0xff3B3B98),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(1),
                        blurRadius: 4,
                        offset: Offset(4, 8), // Shadow position
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.mic_rounded,
                    color: Colors.white,
                    size: 44,
                  ),
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.status)
      _controller.stop();
    else
      _controller.repeat();

    return Center(
      child: Column(
        children: [
          CustomPaint(
            painter: widget.status
                ? CirclePainter(
              _controller,
              color: widget.color,
            )
                : null,
            child: Container(

              width: widget.size * 2,
              height: widget.size*2,
              child: _button(),
            ),
          ),
          widget.status ?   Text(
            "Listening...",
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.orange,
              fontWeight: FontWeight.w600,
            ),
          ):Container(),
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  CirclePainter(
    this._animation, {
    required this.color,
  }) : super(repaint: _animation);
  final Color color;
  final Animation<double> _animation;
  void circle(Canvas canvas, Rect rect, double value) {
    final double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final Color _color = color.withOpacity(opacity);
    final double size = rect.width / 2;
    final double area = size * size;
    final double radius = math.sqrt(area * value / 4);
    final Paint paint = Paint()..color = _color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => true;
}
