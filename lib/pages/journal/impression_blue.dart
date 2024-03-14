import 'package:flutter/material.dart';
//
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';

BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

class ImpressionBlue extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //
    return _ImpressionBlue();
  }
}

class _ImpressionBlue extends State<ImpressionBlue> {
  //
  BluetoothDevice? _device;
  //

  @override
  void initState() {
    //
    super.initState();
    //
    bluetoothPrint.startScan(timeout: const Duration(seconds: 0));
    //
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //
    dis();
  }

  dis() async {
    await bluetoothPrint.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    //
    // begin scan

// get devices
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              //
              bluetoothPrint.startScan(timeout: const Duration(seconds: 0));
            },
            icon: Icon(Icons.bluetooth),
          ),
        ],
      ),
      body: StreamBuilder<List<BluetoothDevice>>(
        stream: bluetoothPrint.scanResults,
        initialData: [],
        builder: (c, snapshot) {
          //
          print("List: ${snapshot.data}");
          //
          return Column(
            children: snapshot.data!
                .map(
                  (d) => ListTile(
                    title: Text(d.name ?? ''),
                    subtitle: Text(d.address!),
                    onTap: () async {
                      setState(() async {
                        _device = d;
                        await bluetoothPrint.connect(_device!);
                      });
                    },
                    trailing: _device != null && _device!.address == d.address
                        ? Icon(
                            Icons.check,
                            color: Colors.green,
                          )
                        : null,
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
  //
}
