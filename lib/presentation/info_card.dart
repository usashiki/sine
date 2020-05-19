import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Color barColor;
  final String title, subtitle1, subtitle2;
  final int trailingCounter;
  final VoidCallback onTap, onLongPress;

  const InfoCard({
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
    final body = <Widget>[
      Text(
        title,
        style: Theme.of(context).textTheme.headline5,
      ),
      const SizedBox(height: 2),
      Text(
        subtitle1,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    ];

    if (subtitle2 != null) {
      body.addAll([
        const SizedBox(height: 2),
        Text(
          subtitle2,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ]);
    }

    Widget trailing = Container();
    if (trailingCounter > 0) {
      trailing = Padding(
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
              '$trailingCounter',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: 10,
                decoration: BoxDecoration(color: barColor),
                margin: const EdgeInsets.only(right: 8),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: body,
                  ),
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}
