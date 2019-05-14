import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TestPage(title: 'Flutter Demo Home Page'),
    );
  }
}

/// test a implicitly animated widget
class TestPage extends StatefulWidget {
  TestPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  double testValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('test implicitly animated widget'),
            AnimatedText(
              text: testValue.toString(),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  testValue += 23.5;
                });
              },
              child: Text('Start'),
            )
          ],
        ),
      ),
    );
  }
}

class AnimatedText extends ImplicitlyAnimatedWidget {
  final String text;

  AnimatedText({@required this.text, Key key})
      : super(key: key, duration: const Duration(milliseconds: 600));

  @override
  AnimatedTextState createState() {
    return AnimatedTextState();
  }
}

class AnimatedTextState extends AnimatedWidgetBaseState<AnimatedText> {
  SwitchStringTween _switchStringTween;

  @override
  Widget build(BuildContext context) {
    return Text('${_switchStringTween.evaluate(animation)}');
  }

  @override
  void forEachTween(visitor) {
    _switchStringTween = visitor(
      _switchStringTween,
      widget.text,
      (value) => SwitchStringTween(begin: value),
    );
  }
}

class SwitchStringTween extends Tween<String> {
  SwitchStringTween({String begin, String end}) : super(begin: begin, end: end);

  String lerp(double t) {
    double beginDouble = double.parse(begin);
    double endDouble = double.parse(end);
    var diff = endDouble - beginDouble;

    return (beginDouble + (diff * t)).toStringAsFixed(1);

    // if (t < 0.5) return begin;
    // return end;
  }
}
