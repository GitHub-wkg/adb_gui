class Device {
  late String id;
  late String model;
  late String status;


  Device(this.id, this.model, this.status);

  @override
  String toString() {
    return 'Device{id: $id, model: $model}';
  }
}
