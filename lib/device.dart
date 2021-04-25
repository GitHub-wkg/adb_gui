class Device {
  String? id = null;
  String? model = null;

  Device({this.id, this.model});

  @override
  String toString() {
    return 'Device{id: $id, model: $model}';
  }
}
