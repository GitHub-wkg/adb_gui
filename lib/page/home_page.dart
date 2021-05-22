import 'dart:io';

import 'package:adb_tools/device.dart';
import 'package:adb_tools/page/settings_dialog.dart';
import 'package:adb_tools/settings.dart';
import 'package:adb_tools/utils/adb_utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Device> _devices = [];

  void _findDevices() {
    AdbUtils.getDevices().then((devicesList) => {
          setState(() {
            _devices = devicesList;
          })
        });
  }

  @override
  void initState() {
    _findDevices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("adb 工具"),
        actions: [
          IconButton(
              onPressed: () {
                _showSettingsDialog();
              },
              icon: Icon(Icons.settings))
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _devices.length,
          itemBuilder: (BuildContext context, int index) {
            return DeviceItem(
                _devices[index] == Settings.currentDevice, _devices[index], () {
              setState(() {
                Settings.currentDevice = _devices[index];
              });
            });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _findDevices,
        tooltip: 'refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }

  _showSettingsDialog() async {
    await showDialog(
      context: context,
      builder: (context) => SettingsDialog(),
    );
  }
}

class DeviceItem extends StatelessWidget {
  final bool isChecked;
  final Device device;
  final Function() onTap;

  const DeviceItem(
    this.isChecked,
    this.device,
    this.onTap,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Container(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: new Text(
                      device.model,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    device.id,
                    style: new TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            Text(device.status),
            Checkbox(
              value: isChecked,
              onChanged: (checked) {
                onTap();
              },
            ),
          ],
        ),
      ),
    );
  }
}
