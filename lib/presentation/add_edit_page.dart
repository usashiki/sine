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
  final String Function(dynamic) integerValidator =
      FormBuilderValidators.pattern(
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
                validators: [FormBuilderValidators.required()],
              ),
            ),
            ListTile(
              leading: Icon(MdiIcons.abTesting),
              title: FormBuilderTextField(
                attribute: 'current',
                decoration: const InputDecoration(
                  labelText: 'Current',
                  suffixText: 'episodes',
                ),
                initialValue: '${widget.tracker?.current ?? ''}',
                keyboardType: TextInputType.number,
                validators: [
                  FormBuilderValidators.numeric(),
                  integerValidator,
                  FormBuilderValidators.min(0),
                ],
              ),
            ),
            ListTile(
              title: FormBuilderTextField(
                attribute: 'offset',
                decoration: const InputDecoration(
                  labelText: 'Offset',
                  suffixText: 'episodes',
                ),
                initialValue: '${widget.tracker?.offset ?? ''}',
                keyboardType: TextInputType.number,
                validators: [
                  FormBuilderValidators.numeric(),
                  integerValidator,
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
                      labelText: 'Period',
                      border: InputBorder.none,
                    ),
                    initialValue: withPeriod,
                    label: const Text('Enable auto-increment'),
                    activeColor: color,
                    onChanged: (dynamic val) =>
                        setState(() => withPeriod = val as bool),
                  ),
                  if (withPeriod)
                    FormBuilderTextField(
                      attribute: 'days',
                      decoration: const InputDecoration(
                        labelText: 'Period length',
                        suffixText: 'days',
                      ),
                      initialValue: '${widget.tracker?.period?.days ?? 7}',
                      keyboardType: TextInputType.number,
                      readOnly: !withPeriod,
                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                        integerValidator,
                        FormBuilderValidators.min(0),
                      ],
                    ),
                  if (withPeriod)
                    FormBuilderDateTimePicker(
                      attribute: 'start',
                      decoration:
                          const InputDecoration(labelText: 'Period Start'),
                      initialValue:
                          widget.tracker?.period?.start ?? DateTime.now(),
                      format: Period.longFormat,
                      readOnly: !withPeriod,
                    ),
                ],
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
            print(map);
            final newTracker = Tracker(
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

int _parseIntStr(dynamic d) {
  final s = d as String;
  if (s.isEmpty) {
    return 0;
  }
  return int.tryParse(s) ?? 0;
}
