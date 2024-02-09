import '/CORE/core.dart';

class NavigateButton extends StatelessWidget {
  const NavigateButton({
    required this.text,
    required this.color,
    required this.onTap,
    super.key,
  });

  final String text;
  final Color color;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: MaterialButton(
        onPressed: onTap,
        child: Text("-- $text --"),
      ),
    );
  }
}

class PageButton extends StatelessWidget {
  const PageButton({
    required this.onTap,
    required this.color,
    super.key,
  });

  final Function() onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width - 80,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: MaterialButton(
        onPressed: onTap,
        child: SvgPicture.asset(
          search_icon,
          width: 45,
          colorFilter: const ColorFilter.mode(secondColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}

class LargeButton extends StatelessWidget {
  const LargeButton({
    required this.onTap,
    required this.color,
    required this.text,
    super.key,
  });

  final Function() onTap;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width - 80,
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      child: MaterialButton(
          onPressed: onTap,
          child: Text(
            "--  $text  --",
            style: const TextStyle(fontSize: 16),
          )),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.color,
  }) : super(key: key);

  final Function() onPressed;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: MaterialButton(
        onPressed: onPressed,
        elevation: 8,
//      minWidth: width ?? MediaQuery.of(context).size.width,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          // side: borderSide,
        ),

        height: 75,
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(),
            Text(
              title,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class PositionSeekWidget extends StatefulWidget {
  final Duration currentPosition;
  final Duration duration;
  final Function(Duration) seekTo;

  const PositionSeekWidget({
    super.key,
    required this.currentPosition,
    required this.duration,
    required this.seekTo,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PositionSeekWidgetState createState() => _PositionSeekWidgetState();
}

class _PositionSeekWidgetState extends State<PositionSeekWidget> {
  late Duration _visibleValue;
  bool listenOnlyUserInterraction = false;
  double get percent => widget.duration.inMilliseconds == 0
      ? 0
      : _visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  @override
  void initState() {
    super.initState();
    _visibleValue = widget.currentPosition;
  }

  @override
  void didUpdateWidget(PositionSeekWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInterraction) {
      _visibleValue = widget.currentPosition;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: Get.width - 20,
              child: Slider(
                min: 0,
                max: widget.duration.inMilliseconds.toDouble(),
                value: percent * widget.duration.inMilliseconds.toDouble(),
                onChangeEnd: (newValue) {
                  setState(() {
                    listenOnlyUserInterraction = false;
                    widget.seekTo(_visibleValue);
                  });
                },
                onChangeStart: (_) {
                  setState(() {
                    listenOnlyUserInterraction = true;
                  });
                },
                onChanged: (newValue) {
                  setState(() {
                    final to = Duration(milliseconds: newValue.floor());
                    _visibleValue = to;
                  });
                },
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 40,
                child: Text(
                  durationToString(widget.currentPosition),
                  style: const TextStyle(color: white),
                ),
              ),
              SizedBox(
                width: 40,
                child: Text(
                  durationToString(widget.duration),
                  style: const TextStyle(color: white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

String durationToString(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  final twoDigitMinutes =
      twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
  final twoDigitSeconds =
      twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
  return '$twoDigitMinutes:$twoDigitSeconds';
}
