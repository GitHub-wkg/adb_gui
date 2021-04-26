import 'package:adb_tools/device.dart';
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
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _devices.length,
          itemBuilder: (BuildContext context, int index) {
            return DeviceItem(_devices[index]);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _findDevices,
        tooltip: 'refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class DeviceItem extends StatelessWidget {
  Device _device ;

  DeviceItem(this._device);

  @override
  Widget build(BuildContext context) {
    return  Container(
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
                    _device.model,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Text(
                  _device.id,
                  style: new TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          new Text(_device.status)
        ],
      ),
    );;
  }
}

