import 'package:adb_tools/utils/sp_utils.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';

/// Widget that displays a text file in a dialog
class SettingsDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: Text("Settings"),
      content: SettingsDialogContent(),
    );
  }
}

class SettingsDialogContent extends StatefulWidget {
  @override
  _SettingsDialogContentState createState() => _SettingsDialogContentState();
}

class _SettingsDialogContentState extends State<SettingsDialogContent> {
  String? _scrcpyPath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getScrcpyPath();
  }

  _getScrcpyPath() async {
    var scrcpyPath = await SpUtils.getString(SpUtils.SCRCPY_PATH);
    setState(() {
      _scrcpyPath = scrcpyPath ;
    });
  }

  _saveScrcpyPath() async {
    FilePickerCross myFile = await FilePickerCross.importFromStorage(
        type: FileTypeCross.any,
        fileExtension: 'exe'
        );

    final String? fileName = myFile.fileName;
    final String? filePath = myFile.path;

    if (fileName?.isEmpty == false && filePath?.isEmpty == false) {
      SpUtils.put(SpUtils.SCRCPY_PATH, filePath! + fileName!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "scrcpy 路径:",
              style:TextStyle(
                color: Colors.grey
              ) ,
            ),
            Expanded(
              child: TextField(
                decoration: new InputDecoration(
                  hintText: 'scrcpy 路径',
                ),
                controller: TextEditingController(
                  text: _scrcpyPath,
                ),
              ),
            ),
            IconButton(onPressed: () {_saveScrcpyPath();}, icon: Icon(Icons.settings)),
          ],
        ),
      ],
    );
  }
}
