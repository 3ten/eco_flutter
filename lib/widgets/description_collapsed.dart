import 'package:eco/models/checklist_model.dart';
import 'package:eco/models/description.dart';
import 'package:eco/models/report_model.dart';
import 'package:eco/providers/checklist_provider.dart';
import 'package:eco/providers/report_provider.dart';
import 'package:eco/widgets/image_picker_button.dart';
import 'package:eco/widgets/text_input.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class DescriptionCollapsed extends StatefulWidget {
  const DescriptionCollapsed(
      {Key? key,
      this.onTitleChanged,
      this.controller,
      this.onPickImage,
      this.enabled = true})
      : super(key: key);
  final Function(String)? onTitleChanged;
  final Function(XFile)? onPickImage;
  final TextEditingController? controller;
  final bool enabled;

  @override
  _DescriptionCollapsedState createState() => _DescriptionCollapsedState();
}

class _DescriptionCollapsedState extends State<DescriptionCollapsed> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Column(
        children: <Widget>[
          ScrollOnExpand(
            scrollOnExpand: true,
            scrollOnCollapse: false,
            child: ExpandablePanel(
              theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
              ),
              header: Row(
                children: const [
                  Text(
                    "Описание мероприятия",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ],
              ),
              collapsed: Container(),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var item in context
                                .watch<ReportProvider>()
                                .report
                                .description
                                ?.images ??
                            [])
                          Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    'http://188.225.18.212/img/' + item,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ))),
                        if (widget.enabled)
                          ImagePickerButton(
                            onPickImage: widget.onPickImage,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextInput(
                    enabled: widget.enabled,
                      label: 'Описание',
                      onChanged: widget.onTitleChanged,
                      controller: widget.controller,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5)
                ],
              ),
              builder: (_, collapsed, expanded) {
                return Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                  child: Expandable(
                    collapsed: collapsed,
                    expanded: expanded,
                    theme: const ExpandableThemeData(crossFadePoint: 0),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
