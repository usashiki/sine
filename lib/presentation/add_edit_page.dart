import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sine/models/period.dart';
import 'package:sine/models/tracker.dart';

// TODO: use color in all formfields

class AddEditPage extends StatefulWidget {
  final Tracker tracker;
  final Function(Tracker) onSaveCallback;
  final Function(String) deleteCallback;
  final bool isEdit;

  const AddEditPage({
    @required this.onSaveCallback,
    this.tracker,
    this.deleteCallback,
    Key key,
  })  : isEdit = tracker != null,
        super(key: key);

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool withPeriod;
  int tempOffset;
  int tempDays;
  DateTime tempStart;
  Color color;

  @override
  void initState() {
    withPeriod = widget.tracker?.period != null;
    tempDays = widget.tracker?.period?.days ?? 7;
    tempStart = widget.tracker?.period?.start ?? DateTime.now();
    tempOffset = widget.tracker?.offset ?? 0;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // depends on context
    color = widget.tracker?.color ?? Theme.of(context).primaryColor;
    super.didChangeDependencies();
  }

  int _parseIntStr(dynamic d) {
    final s = d as String;
    if (s == null || s.isEmpty) return null;
    return int.tryParse(s);
  }

  @override
  Widget build(BuildContext context) {
    Period tempPeriod;
    if (withPeriod && tempDays != null && tempStart != null) {
      tempPeriod = Period(days: tempDays, start: tempStart);
    }
    final tempElapsed = tempPeriod?.elapsed ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.isEdit ? 'Edit' : 'Add'} Tracker'),
        backgroundColor: color,
        actions: <Widget>[
          if (widget.isEdit)
            IconButton(
              icon: Icon(Icons.delete),
              tooltip: 'Delete Tracker',
              onPressed: () {
                widget.deleteCallback(widget.tracker.id);
                // TODO: this is a hack to return to list screen
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
        ],
      ),
      body: FormBuilder(
        key: _fbKey,
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.title),
              title: FormBuilderTextField(
                attribute: 'title',
                decoration: const InputDecoration(labelText: 'Title'),
                initialValue: widget.tracker?.title,
                autofocus: !widget.isEdit,
                autovalidate: true,
                validators: [FormBuilderValidators.required()],
              ),
            ),
            ListTile(
              leading: Icon(Icons.palette),
              title: FormBuilderColorPicker(
                attribute: 'color',
                decoration: const InputDecoration(
                  labelText: 'Color',
                  border: InputBorder.none,
                ),
                initialValue: color,
                onChanged: (dynamic c) => setState(() => color = c as Color),
                colorPickerType: ColorPickerType.BlockPicker,
                autovalidate: true,
                validators: [FormBuilderValidators.required()],
              ),
            ),
            ListTile(
              leading: Icon(MdiIcons.abTesting),
              title: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    attribute: 'current',
                    decoration: const InputDecoration(
                      labelText: 'Current',
                      suffixText: 'episodes',
                    ),
                    initialValue: '${widget.tracker?.current ?? '0'}',
                    keyboardType: TextInputType.number,
                    validators: [
                      (dynamic d) {
                        if ((_parseIntStr(d) ?? -1) < 0) {
                          return 'Must be a number >= 0.';
                        }
                      },
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: 'offset',
                    decoration: InputDecoration(
                      labelText: 'Offset',
                      suffixText: 'episodes',
                      helperText:
                          'Max = ${tempElapsed + tempOffset} ($tempElapsed elapsed + $tempOffset offset)',
                    ),
                    initialValue: '${widget.tracker?.offset ?? '0'}',
                    keyboardType: TextInputType.number,
                    onChanged: (dynamic d) =>
                        setState(() => tempOffset = _parseIntStr(d) ?? 0),
                    autovalidate: true,
                    validators: [
                      (dynamic d) {
                        if (_parseIntStr(d) == null) return 'Must be a number.';
                      }
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(MdiIcons.reload),
              title: Column(
                children: <Widget>[
                  FormBuilderSwitch(
                    attribute: 'period',
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    initialValue: withPeriod,
                    label: Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Enable auto-incrementing?',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          if (tempPeriod != null)
                            TextSpan(
                              text: '\nPrevious: ${tempPeriod.previousStr}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          if (tempPeriod != null)
                            TextSpan(
                              text: '\nNext: ${tempPeriod.nextStr}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                        ],
                      ),
                    ),
                    activeColor: color,
                    onChanged: (dynamic val) =>
                        setState(() => withPeriod = val as bool),
                  ),
                  Visibility(
                    visible: withPeriod,
                    maintainState: true,
                    child: FormBuilderTextField(
                      attribute: 'days',
                      decoration: const InputDecoration(
                        prefixText: 'Every  ',
                        suffixText: 'days',
                      ),
                      initialValue: '$tempDays',
                      keyboardType: TextInputType.number,
                      readOnly: !withPeriod,
                      onChanged: (dynamic val) {
                        setState(() {
                          final days = _parseIntStr(val);
                          if (days != null && days > 0) {
                            tempDays = days;
                          } else {
                            tempDays = null;
                          }
                        });
                      },
                      autovalidate: true,
                      validators: [
                        (dynamic d) {
                          if ((_parseIntStr(d) ?? -1) < 1) {
                            return 'Must be a postive number.';
                          }
                        },
                      ],
                    ),
                  ),
                  Visibility(
                    visible: withPeriod,
                    maintainState: true,
                    child: FormBuilderDateTimePicker(
                      attribute: 'start',
                      decoration:
                          const InputDecoration(labelText: 'Starting from'),
                      initialValue: tempStart,
                      format: Period.longFormat,
                      readOnly: !withPeriod,
                      onChanged: (dynamic val) =>
                          setState(() => tempStart = val as DateTime),
                      autovalidate: true,
                      validators: [FormBuilderValidators.required()],
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(MdiIcons.text),
              title: FormBuilderTextField(
                attribute: 'notes',
                decoration: const InputDecoration(labelText: 'Notes'),
                initialValue: widget.tracker?.notes,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color,
        onPressed: () {
          if (_fbKey.currentState.saveAndValidate()) {
            final map = _fbKey.currentState.value;
            widget.onSaveCallback(
              Tracker(
                id: widget.tracker?.id,
                title: map['title'] as String,
                current: _parseIntStr(map['current']),
                offset: _parseIntStr(map['offset']),
                colorInt: (map['color'] as Color).value,
                period: withPeriod
                    ? Period(
                        days: _parseIntStr(map['days']),
                        start: map['start'] as DateTime,
                      )
                    : null,
                notes: map['notes'] as String,
              ),
            );
            Navigator.pop(context);
          }
        },
        tooltip: 'Save Tracker',
        child: Icon(Icons.save),
      ),
    );
  }
}
