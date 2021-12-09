// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../service/userPreferences.dart';
import '../widgets/stopwatchListViewWidget.dart';
import '../service/stopwatchService.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  late TextEditingController _textController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color _primaryColor = Theme.of(context).primaryColor;
    var _textTheme = Theme.of(context).primaryTextTheme;
    return Drawer(
        child: SafeArea(
      child: Column(
        children: [
          AppBar(
            title: Text(
              'History',
              style: _textTheme.headline6!.copyWith(color: _primaryColor),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {});
                    UserPreferences.cleanHistory();
                  },
                  icon: const Icon(Icons.cleaning_services_outlined))
            ],
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: UserPreferences.getHistory.length,
                  itemBuilder: (itemBuilder, index) {
                    var _userPreferences = UserPreferences.getHistory[index];
                    return ExpansionTile(
                        textColor: _primaryColor,
                        collapsedTextColor: Colors.white,
                        iconColor: _primaryColor,
                        collapsedIconColor: Colors.white,
                        title: Text(_userPreferences.title!),
                        subtitle: Text(
                          '${_userPreferences.date}, ${_userPreferences.time}',
                          style: Theme.of(context).primaryTextTheme.caption,
                        ),
                        leading: GestureDetector(
                          onTap: () {
                            _textController.text = _userPreferences.title!;
                            showDialog(
                                context: context,
                                builder: (builder) => AlertDialog(
                                      title: ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          trailing: const CloseButton(
                                              color: Colors.white),
                                          title: Text(
                                            'Edit',
                                            style: _textTheme.headline6!
                                                .copyWith(color: _primaryColor),
                                          )),
                                      content: TextFormField(
                                        controller: _textController,
                                        style: _textTheme.bodyText1,
                                        decoration: InputDecoration(
                                            labelText: 'Title',
                                            labelStyle: _textTheme.bodyText1!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 8),
                                            filled: true,
                                            fillColor: Colors.white10,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                      ),
                                      actions: [
                                        ButtonBar(
                                            alignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              customLocalButton(
                                                  title: 'Delete',
                                                  onPressed: () async {
                                                    setState(() {});
                                                    await UserPreferences
                                                        .deleteHistory(index);
                                                    Navigator.pop(context);
                                                  }),
                                              customLocalButton(
                                                  title: 'Update',
                                                  onPressed: () async {
                                                    setState(() {});
                                                    await UserPreferences
                                                        .UpdateHistoryTitle(
                                                            index,
                                                            _textController
                                                                .text);

                                                    Navigator.pop(context);
                                                  }),
                                            ])
                                      ],
                                    ));
                          },
                          child: SizedBox.square(
                            dimension: 32,
                            child: Image.asset(
                              'assets/icons/Textedit.png',
                              color: Colors.white,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 35),
                              Expanded(
                                child: SizedBox(
                                  height: _userPreferences.laps.length > 5
                                      ? 300
                                      : _userPreferences.laps.length * 40,
                                  child: StopwatchListViewWidget(
                                      laps: _userPreferences.laps
                                          .map((e) =>
                                              StopwatchService.toDurationFormat(
                                                  e))
                                          .toList()),
                                ),
                              ),
                            ],
                          )
                        ]);
                  }))
        ],
      ),
    ));
  }

  FlatButton customLocalButton(
      {required VoidCallback onPressed, required String title}) {
    return FlatButton.icon(
        textColor: title.toLowerCase() != 'delete'
            ? Colors.white
            : const Color(0xffcc0000),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color:
            title.toLowerCase() != 'delete' ? Colors.green : Colors.transparent,
        icon: Icon(Icons.delete_forever_rounded),
        label: Text(title),
        onPressed: onPressed);
  }
}
