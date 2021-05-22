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
              _devices[index],
            );
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

class DeviceItem extends StatefulWidget {
  Device device;

  DeviceItem(this.device);

  @override
  _DeviceItemState createState() => _DeviceItemState();
}

class _DeviceItemState extends State<DeviceItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                      widget.device.model,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  new Text(
                    widget.device.id,
                    style: new TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            new Text(widget.device.status),
            new Checkbox(
              value: widget.device == Settings.currentDevice,
              onChanged: (checked) {
                if (checked == true) {
                  Settings.currentDevice = widget.device;
                }
              },
            ),
          ],
        ),
      ),
    );
    ;
  }
}
