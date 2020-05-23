import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
  String Function(dynamic) integerValidator = FormBuilderValidators.pattern(
    r'^\-?\d+$',
    errorText: 'Value must be whole integer.',
  );
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool withPeriod;
  Color color;

  @override
  void initState() {
    withPeriod = widget.tracker?.period != null;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // depends on context
    color = widget.tracker?.color ?? Theme.of(context).primaryColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.isEdit ? 'Edit' : 'Add'} Tracker'),
        backgroundColor: color,
        actions: widget.isEdit
            ? <Widget>[
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
              ]
            : <Widget>[],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: FormBuilder(
          key: _fbKey,
          child: ListView(
            children: <Widget>[
              FormBuilderTextField(
                attribute: 'title',
                decoration: const InputDecoration(labelText: 'Title'),
                initialValue: widget.tracker?.title,
                validators: [FormBuilderValidators.required()],
              ),
              FormBuilderTextField(
                attribute: 'current',
                decoration: const InputDecoration(labelText: 'Current'),
                initialValue: '${widget.tracker?.current ?? 0}',
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
                decoration: const InputDecoration(labelText: 'Offset'),
                initialValue: '${widget.tracker?.offset ?? 0}',
                keyboardType: TextInputType.number,
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                  integerValidator,
                ],
              ),
              FormBuilderColorPicker(
                attribute: 'color',
                decoration: const InputDecoration(labelText: 'Color'),
                initialValue: color,
                onChanged: (dynamic c) => setState(() => color = c as Color),
                colorPickerType: ColorPickerType.BlockPicker,
              ),
              const Divider(),
              FormBuilderCheckbox(
                attribute: 'period',
                initialValue: withPeriod,
                label: const Text('Period?'),
                onChanged: (dynamic val) =>
                    setState(() => withPeriod = val as bool),
              ),
              FormBuilderTouchSpin(
                attribute: 'days',
                decoration:
                    const InputDecoration(labelText: 'Period length (days)'),
                initialValue: widget.tracker?.period?.days ?? 7,
                readOnly: !withPeriod,
                step: 1,
                min: 1,
              ),
              FormBuilderDateTimePicker(
                attribute: 'start',
                decoration: const InputDecoration(labelText: 'Start'),
                initialValue: widget.tracker?.period?.start ?? DateTime.now(),
                readOnly: !withPeriod,
              ),
              FormBuilderTextField(
                attribute: 'notes',
                decoration: const InputDecoration(labelText: 'Notes'),
                initialValue: widget.tracker?.notes,
                minLines: 3,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color,
        onPressed: () {
          if (_fbKey.currentState.saveAndValidate()) {
            final map = _fbKey.currentState.value;
            print(map);
            final newTracker = Tracker(
              uuid: widget.tracker?.id,
              title: map['title'] as String,
              current: int.parse(map['current'] as String),
              offset: int.parse(map['offset'] as String),
              colorInt: (map['color'] as Color).value,
              period: withPeriod
                  ? Period(
                      days: map['days'] as int,
                      start: map['start'] as DateTime,
                    )
                  : null,
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
