import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sine/models/period.dart';
import 'package:sine/models/tracker.dart';

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
  String Function(dynamic) integerValidator = FormBuilderValidators.pattern(
    r'^\-?\d+$',
    errorText: 'Value must be whole integer.',
  );
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool withPeriod;
  List<String> links;

  @override
  void initState() {
    withPeriod = widget?.tracker?.period != null;
    links = widget.tracker.links ?? [];
    super.initState();
  }

  // Widget linkField(int i) {
  //   FormBuilderTextField(
  //     attribute: '$i',
  //     initialValue: links[i],
  //     decoration: InputDecoration(
  //       labelText: 'Link ${i + 1}',
  //       border: const OutlineInputBorder(),
  //     ),
  //     validators: [
  //       FormBuilderValidators.required(),
  //       FormBuilderValidators.url(),
  //     ],
  //     maxLines: 1,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.isEdit ? 'Edit' : 'Add'} Tracker'),
        actions: widget.isEdit
            ? <Widget>[
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    widget.deleteCallback(widget.tracker.id);
                    // TODO: this is a hack to return to list screen
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ]
            : <Widget>[],
      ),
      body: FormBuilder(
        key: _fbKey,
        initialValue: <String, dynamic>{
          'title': widget?.tracker?.title,
          'current': '${widget?.tracker?.current ?? 0}',
          'offset': '${widget?.tracker?.offset ?? 0}',
          'period': withPeriod,
          'days': widget?.tracker?.period?.days ?? 7,
          'start': widget?.tracker?.period?.start ?? DateTime.now(),
          'notes': widget.tracker.notes,
        },
        child: ListView(
          children: <Widget>[
            FormBuilderTextField(
              attribute: 'title',
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validators: [FormBuilderValidators.required()],
            ),
            FormBuilderTextField(
              attribute: 'current',
              decoration: const InputDecoration(
                labelText: 'Current',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validators: [
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
                integerValidator,
                FormBuilderValidators.min(0),
              ],
            ),
            FormBuilderTextField(
              attribute: 'offset',
              decoration: const InputDecoration(
                labelText: 'Offset',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validators: [
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
                integerValidator,
              ],
            ),
            const Divider(),
            FormBuilderCheckbox(
              attribute: 'period',
              label: const Text('Period?'),
              onChanged: (dynamic val) =>
                  setState(() => withPeriod = val as bool),
            ),
            FormBuilderTouchSpin(
              attribute: 'days',
              decoration: const InputDecoration(
                labelText: 'Period length (days)',
                border: OutlineInputBorder(),
              ),
              readOnly: !withPeriod,
              step: 1,
              min: 1,
            ),
            FormBuilderDateTimePicker(
              attribute: 'start',
              decoration: const InputDecoration(
                labelText: 'Start',
                border: OutlineInputBorder(),
              ),
              readOnly: !withPeriod,
            ),
            const Divider(),
            RaisedButton(
              onPressed: () => setState(() => links.add('')),
              child: const Text('Add link'),
            ),
            for (int i = 0; i < links.length; i++)
              Row(
                children: <Widget>[
                  Expanded(
                    child: FormBuilderTextField(
                      attribute: '$i',
                      initialValue: links[i],
                      decoration: InputDecoration(
                        labelText: 'Link ${i + 1}',
                        border: const OutlineInputBorder(),
                      ),
                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.url(),
                      ],
                      maxLines: 1,
                    ),
                  ),
                  IntrinsicWidth(
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => setState(() => links.removeAt(i)),
                    ),
                  ),
                ],
              ),
            FormBuilderTextField(
              attribute: 'notes',
              decoration: const InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
              ),
              minLines: 3,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_fbKey.currentState.saveAndValidate()) {
            final map = _fbKey.currentState.value;
            final newTracker = Tracker(
              uuid: widget?.tracker?.id,
              title: map['title'] as String,
              current: int.parse(map['current'] as String),
              offset: int.parse(map['offset'] as String),
              period: withPeriod
                  ? Period(
                      days: map['days'] as int,
                      start: map['start'] as DateTime,
                    )
                  : null,
              links: [
                for (int i = 0; i < links.length; i++) map['$i'] as String
              ],
              notes: map['notes'] as String,
            );
            widget.onSaveCallback(newTracker);
            Navigator.pop(context);
          }
        },
        tooltip: 'Save Tracker',
        child: Icon(Icons.save),
      ),
    );
  }
}
