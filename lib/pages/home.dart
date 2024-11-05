import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:classy_stuff/pages/bluetooth.dart';
import 'package:classy_stuff/pages/info.dart';
import 'package:classy_stuff/utils/varglobal.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BluetoothDevice> devices = [];
  BluetoothDevice? selectedDevice;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
    TextEditingController nama = TextEditingController();
    TextEditingController alamat = TextEditingController();
    TextEditingController noHp = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoPage(),
                  ));
            },
            child: Image.asset('assets/LOGO-TRANSPARAN.png')),
        centerTitle: true,
        title: Text(
          'Home',
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Bluetooth(),
                    ));
              },
              icon: Icon(
                Icons.bluetooth,
                size: 28,
                color: Colors.blue,
              )),
          // IconButton(onPressed: () {}, icon: Icon(Icons.info_outline_rounded))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(35),
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Penerima',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nama,
                maxLines: 5,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Penerima'),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextField(
            //     controller: alamat,
            //     decoration: InputDecoration(
            //         border: OutlineInputBorder(), labelText: 'Alamat'),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextField(
            //     controller: noHp,
            //     decoration: InputDecoration(
            //         border: OutlineInputBorder(), labelText: 'No HP'),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: 100,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () async {
                    if ((await printer.isConnected)! && nama.text != '') {
                      // ignore: use_build_context_synchronously
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.question,
                        animType: AnimType.rightSlide,
                        title: 'Print data?',
                        btnOkOnPress: () {
                          templatePrint(
                            nama.text,
                          );
                        },
                      ).show();
                    } else {
                      // ignore: use_build_context_synchronously
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.rightSlide,
                        title:
                            'Printer belum connect atau data penerima belum disi',
                        btnOkOnPress: () {},
                      ).show();
                    }
                  },
                  child: Row(
                    children: [
                      Icon(Icons.print),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Print')
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void templatePrint(
    String penerima,
  ) {
    printer.printCustom('Classy Stuff', 4, 1);
    printer.printNewLine();
    printer.printCustom('--------PENGIRIM---------', 1, 1);
    printer.printCustom('Pengirim : classystuff.id._', 1, 0);
    printer.printCustom('(Tegar)', 1, 1);
    printer.printCustom('No. Hp : 081381695084', 1, 0);
    printer.printCustom(
        'Alamat : Jl. Moch khafi 1 GG.damai 1 No.79 RT 004 RW 02 Kel. Ciganjur Kec. Jagakarsa, Jakarta Selatan. Kode Pos 12630-Indonesia.',
        1,
        0);
    // printer.printCustom('Izaaz Akhdan', 1, 0);
    printer.printNewLine();
    printer.printCustom('--------PENERIMA--------', 1, 1);

    printer.printCustom('$penerima', 1, 0);
    // printer.printCustom('Penerima : $penerima', 1, 0);
    // printer.printCustom('No. Hp : $noHp', 1, 0);
    // printer.printCustom('Alamat : $alamat', 1, 0);
    // printer.print3Column('Nama', 'Qty', 'Harga', 0);

    // for (var i = 0; i <= VarGlobal.harga_barang.length; i++) {
    //   printer.print3Column('${VarGlobal.nama_barang[i]}',
    //       '${VarGlobal.qty_barang[i]}', '${VarGlobal.harga_barang[i]}', 0);
    // }

    // printer.print3Column('Crewneck', '2', '100rb', 0);
    // printer.print3Column('Hoodie', '1', '50rb', 0);
    // printer.print3Column('Tshirt', '2', '100rb', 0);
    printer.printCustom('-------------------------', 1, 1);
    printer.paperCut();
  }
}
