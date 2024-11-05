import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';

class Bluetooth extends StatefulWidget {
  const Bluetooth({super.key});

  @override
  State<Bluetooth> createState() => _BluetoothState();
}

class _BluetoothState extends State<Bluetooth> {
  bool isConnect = false;
  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDevice();
  }

  void getDevice() async {
    devices = await printer.getBondedDevices();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth'),
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Pilih bluetooth',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: DropdownButton<BluetoothDevice>(
                isExpanded: true,
                dropdownColor: Colors.orange.shade400,
                iconDisabledColor: Colors.orange.shade300,
                iconEnabledColor: Colors.orange,
                underline: Container(
                  height: 2,
                  color: Colors.orange.shade300,
                ),
                items: devices
                    .map((e) => DropdownMenuItem(
                          child: Text(e.name!),
                          value: e,
                        ))
                    .toList(),
                onChanged: (device) {
                  setState(() {
                    selectedDevice = device;
                  });
                },
                value: selectedDevice,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            (isConnect)
                ? ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isConnect = !isConnect;
                      });
                      printer.disconnect();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('Disonnecting : ${selectedDevice!.name}'),
                          backgroundColor: Colors.red.shade400));
                    },
                    child: Text(
                      'Disconnect',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade400),
                  )
                : ElevatedButton(
                    onPressed: () {
                      if (selectedDevice == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Pilih bluetooth nya dulu dong'),
                            backgroundColor: Colors.blue.shade400));
                      } else {
                        setState(() {
                          isConnect = !isConnect;
                        });
                        printer.connect(selectedDevice!);
                      }

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Connecting : ${selectedDevice!.name}'),
                          backgroundColor: Colors.green.shade400));
                    },
                    child: Text(
                      'Connect',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade500),
                  )
          ],
        ),
      ),
    );
  }
}
