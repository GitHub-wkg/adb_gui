import 'dart:io';

import 'package:adb_tools/device.dart';

class AdbUtils {
  static Device? currentDevice;

  static Future<List<Device>> getDevices() async {
    ProcessResult result = await command("adb", ["devices", "-l"]);
    String stdout = result.stdout;
    print("stdout :" + stdout);
    List<String> split = stdout.split("\n");
    List<Device> devices = [];
    for (int i = 1; i < split.length; i++) {
      String line = split[i].trim();
      if (line.isEmpty) {
        continue;
      }
      print("line start:====" + line + "====end");
      List<String> deviceDescriptionSplit = line.split(RegExp("\\s+"));

      print("deviceDescriptionSplit size:${deviceDescriptionSplit.length}");
      print("deviceDescriptionSplit:" + deviceDescriptionSplit.toString());
      String model = "unknow";
      String status = "unknow";
      for (String descriptionTemp in deviceDescriptionSplit) {
        print("descriptionTemp:" + descriptionTemp.toString());
        if (descriptionTemp.contains("model:")) {
          model = descriptionTemp.split("model:")[1];
        }
      }
      if (deviceDescriptionSplit.length >= 2) {
        status = deviceDescriptionSplit[1];
      }
      Device device = new Device(deviceDescriptionSplit[0], model, status);
      devices.add(device);
    }
    return devices;
  }

  static Future<ProcessResult> command(String cmd, List<String> arguments) async {
    print("cmd :${cmd} ${arguments.toString()}");
    return Process.run(cmd, arguments);
  }

  static Future<ProcessResult> adbCommand(String cmd, [List<String>? arguments]) async {
    if (arguments == null) {
      arguments = [];
    }
    if (cmd.startsWith("adb")) {
      cmd = cmd.replaceFirst("adb", "");
      if (cmd.isNotEmpty) {
        arguments.insert(0, cmd);
      }
    }
    if (currentDevice?.id != null) {
      arguments.insert(0, "-s ${currentDevice!.id}");
    }

    return command("adb", arguments);
  }

  static showDevice(String cmd,  List<String> arguments) {
    command(cmd, arguments);
  }

  static start(){

  }
}
