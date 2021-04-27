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
            return DeviceItem(
              device: _devices[index],
              onTap: () {
                debugPrint('40---home_page-----${_devices[index].id}');
                AdbUtils.showDevice('scrcpy', ['-s', '${_devices[index].id}']);
              },
            );
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
  final Device device;

  final VoidCallback onTap;

  const DeviceItem({Key? key, required this.device, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                  new Text(
                    device.id,
                    style: new TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            new Text(device.status)
          ],
        ),
      ),
    );
    ;
  }
}
