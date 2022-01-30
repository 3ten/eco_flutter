import 'package:eco/providers/user_provider.dart';
import 'package:eco/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class CityPicker extends StatefulWidget {
  const CityPicker(
      {Key? key,
      this.controller,
      this.onChanged,
      required this.setCity,
      this.enabled=true})
      : super(key: key);
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function(String) setCity;
  final bool enabled;

  @override
  State<CityPicker> createState() => _CityPickerState();
}

class _CityPickerState extends State<CityPicker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(widget.enabled==false){
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CitySelect(
                    setCity: widget.setCity,
                  )),
        );
      },
      child: AbsorbPointer(
        child: TextField(
          readOnly: true,
          enabled: widget.enabled,
          controller: widget.controller,
          onChanged: widget.onChanged,
          decoration: const InputDecoration(
            isDense: true,
            border: OutlineInputBorder(),
            labelText: 'Город',
            contentPadding: EdgeInsets.all(13),
          ),
        ),
      ),
    );
  }
}

class CitySelect extends StatefulWidget {
  const CitySelect({Key? key, required this.setCity}) : super(key: key);
  final void Function(String) setCity;

  @override
  State<CitySelect> createState() => _CitySelectState();
}

class _CitySelectState extends State<CitySelect> {
  @override
  Widget build(BuildContext context) {
    var setting = context.read<UserProvider>();
    var cities = context.watch<UserProvider>().cities;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Город'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              autofocus: true,
              onChanged: setting.getCity,
              decoration: const InputDecoration(
                labelText: 'Город',
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  for (var item in cities)
                    GestureDetector(
                      onTap: () {
                        widget.setCity(item.value);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFE5E5E5),
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(item.value),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
