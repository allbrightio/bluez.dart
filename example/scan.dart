import 'package:bluez/bluez.dart';

void main() async {
  var client = BlueZClient();
  await client.connect();

  if (client.adapters.isEmpty) {
    print('No Bluetooth adapters found');
    await client.close();
    return;
  }
  var adapter = client.adapters[0];

  print('Searching for devices on ${adapter.name}...');
  for (var device in client.devices) {
    print('  ${device.name}');
  }
  client.deviceAddedStream.listen((device) => print('  ${device.name}'));

  await adapter.startDiscovery();

  await Future.delayed(Duration(seconds: 5));

  await adapter.stopDiscovery();

  await client.close();
}
