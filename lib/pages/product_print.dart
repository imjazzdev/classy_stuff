import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:classy_stuff/pages/bluetooth.dart';
import 'package:classy_stuff/pages/info.dart';
import 'package:classy_stuff/utils/varglobal.dart';
import 'package:flutter/material.dart';

class ProductPrint extends StatefulWidget {
  const ProductPrint({super.key});

  @override
  State<ProductPrint> createState() => _ProductPrintState();
}

class _ProductPrintState extends State<ProductPrint> {
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

  int itemCount = 0;
  TextEditingController nama = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController penerima = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
          IconButton(onPressed: () {}, icon: Icon(Icons.info_outline_rounded))
        ],
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Penerima',
                    style: TextStyle(fontSize: 17, color: Colors.grey.shade500),
                  ),
                  SizedBox(
                    width: 180,
                    height: 40,
                    child: TextField(
                      controller: penerima,
                      textAlignVertical: TextAlignVertical.center,
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 16),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        if ((await printer.isConnected)! &&
                            penerima.text != '') {
                          // ignore: use_build_context_synchronously
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.question,
                            animType: AnimType.rightSlide,
                            title: 'Print data?',
                            btnOkOnPress: () {
                              templatePrint(penerima.text);
                            },
                          ).show();
                        } else {
                          // ignore: use_build_context_synchronously
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title:
                                'Printer belum connect atau nama penerima belum disi',
                            btnOkOnPress: () {},
                          ).show();
                        }
                      },
                      icon: Icon(
                        Icons.print,
                        size: 35,
                        color: Colors.red,
                      )),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('No', style: TextStyle(fontSize: 18)),
                      )),
                  Expanded(
                      flex: 3,
                      child: Container(
                          child: Text(
                        'Nama barang',
                        style: TextStyle(fontSize: 17),
                      ))),
                  Expanded(
                      flex: 1,
                      child: Container(
                          child: Text('Qty', style: TextStyle(fontSize: 18)))),
                  Expanded(
                      flex: 2,
                      child: Container(
                          child: Text('Harga (Rp)',
                              style: TextStyle(fontSize: 17))))
                ],
              ),
              ListView.builder(
                padding: EdgeInsets.only(left: 15, right: 15),
                itemCount: itemCount,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          margin: EdgeInsets.only(right: 10),
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.orange.shade100),
                          child: Text(
                            VarGlobal.nama_barang[index],
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 40,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.orange.shade100),
                          child: Text(
                            // controller: qty,
                            VarGlobal.qty_barang[index],
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.orange.shade100),
                          child: Text(
                            VarGlobal.harga_barang[index],
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 175,
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 150,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, -4),
                        blurRadius: 10,
                        color: Colors.orange.shade400.withOpacity(0.3))
                  ],
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text('Nama',
                                      style: TextStyle(fontSize: 18))),
                              Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 25,
                                    child: TextField(
                                      controller: nama,
                                    ),
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text('Qty',
                                      style: TextStyle(fontSize: 18))),
                              Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 25,
                                    child: TextField(
                                      controller: qty,
                                      keyboardType: TextInputType.number,
                                    ),
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Text('Harga',
                                      style: TextStyle(fontSize: 18))),
                              Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 25,
                                    child: TextField(
                                      controller: harga,
                                      keyboardType: TextInputType.number,
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  itemCount--;
                                  VarGlobal.nama_barang.removeLast();
                                  VarGlobal.qty_barang.removeLast();
                                  VarGlobal.harga_barang.removeLast();
                                });
                              },
                              icon: Icon(
                                Icons.remove,
                                size: 40,
                                color: Colors.red,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (nama.text == '' ||
                                      qty.text == '' ||
                                      harga.text == '') {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.warning,
                                      animType: AnimType.rightSlide,
                                      title: 'Isi data produk dahulu',
                                      btnOkOnPress: () {},
                                    ).show();
                                  } else {
                                    itemCount++;
                                    VarGlobal.nama_barang.add(nama.text);
                                    VarGlobal.qty_barang.add(qty.text);
                                    VarGlobal.harga_barang.add(harga.text);
                                    nama.clear();
                                    qty.clear();
                                    harga.clear();
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.add,
                                size: 40,
                                color: Colors.green,
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     // FloatingActionButton(
      //     //   onPressed: () {
      //     //     setState(() {
      //     //       itemCount--;
      //     //       VarGlobal.nama_barang.remove(nama.text);
      //     //       VarGlobal.qty_barang.remove(qty.text);
      //     //       VarGlobal.harga_barang.remove(harga.text);
      //     //     });
      //     //   },
      //     //   backgroundColor: Colors.red,
      //     //   child: Icon(
      //     //     Icons.remove,
      //     //     size: 28,
      //     //   ),
      //     // ),
      //     SizedBox(
      //       width: 10,
      //     ),
      //     FloatingActionButton(
      //       onPressed: () {
      //         // setState(() {
      //         //   itemCount++;
      //         //   VarGlobal.nama_barang.add(nama.text);
      //         //   VarGlobal.qty_barang.add(qty.text);
      //         //   VarGlobal.harga_barang.add(harga.text);
      //         // });
      //         print(VarGlobal.nama_barang);
      //         print(VarGlobal.qty_barang);
      //         print(VarGlobal.harga_barang);
      //       },
      //       backgroundColor: Colors.orange,
      //       child: Icon(
      //         Icons.add,
      //         size: 28,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  void templatePrint(String penerima) {
    printer.printNewLine();
    printer.printCustom('Classy Stuff', 4, 1);

    printer..printNewLine();
    printer.printCustom('Pengirim : classystuff.id._', 1, 0);
    printer.printCustom('(Tegar)', 1, 1);
    printer.printCustom('No. Hp : 081381695084', 1, 0);
    printer.printCustom(
        'Alamat : Jl. Moch khafi 1 GG.damai 1 No.79 RT 004 RW 02 Kel. Ciganjur Kec. Jagakarsa, Jakarta Selatan. Kode Pos 12630-Indonesia.',
        1,
        0);
    printer.printCustom('Penerima : $penerima', 1, 0);
    printer.printNewLine();
    printer.print3Column('Nama', 'Qty', 'Harga', 0);

    for (var i = 0; i <= VarGlobal.harga_barang.length; i++) {
      printer.print3Column('${VarGlobal.nama_barang[i]}',
          '${VarGlobal.qty_barang[i]}', '${VarGlobal.harga_barang[i]}', 0);
    }
    printer.paperCut();
    printer.paperCut();
    printer..printNewLine();
    printer.printCustom('-------------------------', 1, 1);
    printer.paperCut();
  }
}
