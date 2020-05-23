import 'package:flutter/material.dart';
import 'package:sine/containers/tracker_info.dart';
import 'package:sine/models/tracker.dart';

class SummaryCard extends StatelessWidget {
  final Tracker tracker;

  const SummaryCard(this.tracker, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Card(
      barColor: tracker.color,
      title: tracker.title,
      subtitle1: '${tracker.current} / ${tracker.max} episodes',
      subtitle2:
          tracker.next != null ? 'Next: ${tracker.period.nextStrShort}' : null,
      trailingCounter: tracker.remaining,
      onTap: () => Navigator.push<PageRoute>(
        context,
        MaterialPageRoute(builder: (_) => TrackerInfo(tracker.id)),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Color barColor;
  final String title, subtitle1, subtitle2;
  final int trailingCounter;
  final VoidCallback onTap, onLongPress;

  const _Card({
    @required this.barColor,
    @required this.title,
    @required this.subtitle1,
    this.subtitle2,
    @required this.trailingCounter,
    this.onTap,
    this.onLongPress,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _ColorBar(barColor),
              _Body(title, subtitle1, subtitle2),
              if (trailingCounter > 0) _Counter(trailingCounter),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorBar extends StatelessWidget {
  final Color color;
  const _ColorBar(this.color, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      decoration: BoxDecoration(color: color),
      margin: const EdgeInsets.only(right: 8),
    );
  }
}

class _Body extends StatelessWidget {
  static const TextStyle _titleStyle = TextStyle(fontSize: 20);
  static const TextStyle _subtitleStyle = TextStyle(fontSize: 14);

  final String title, subtitle1, subtitle2;

  const _Body(this.title, this.subtitle1, this.subtitle2, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: _titleStyle),
            const SizedBox(height: 2),
            Text(subtitle1, style: _subtitleStyle),
            if (subtitle2 != null) const SizedBox(height: 2),
            if (subtitle2 != null) Text(subtitle2, style: _subtitleStyle),
          ],
        ),
      ),
    );
  }
}

class _Counter extends StatelessWidget {
  final int n;

  const _Counter(this.n, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            '${n > 99 ? '99+' : n}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
