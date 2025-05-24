import 'package:flutter/material.dart';
import 'package:flutter_taxi_calculate_app/views/taxi_result_ui.dart';

class TaxiHomeUI extends StatefulWidget {
  const TaxiHomeUI({super.key});

  @override
  State<TaxiHomeUI> createState() => _TaxiHomeUIState();
}

class _TaxiHomeUIState extends State<TaxiHomeUI> {
  // TextField Controllers
  TextEditingController _distanceCtrl = TextEditingController();
  TextEditingController _trafficjamTimeCtrl = TextEditingController();

  // Alert Dialog Method
  _warningDialog(msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('คำเตือน'),
        content: Text(
          msg,
        ),
        actions: [
          //  TextButton ปุ่มไม่มีพื้นหลัง
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'ตกลง',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 26, 60, 253),
        title: Text(
          'คำนวณค่า Taxi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Container(
                      padding:
                          const EdgeInsets.all(16), // เพิ่มระยะห่างภายในกรอบ
                      decoration: BoxDecoration(
                        color: Colors.yellow, // พื้นหลังสีเหลือง
                        borderRadius:
                            BorderRadius.circular(20), // ความโค้งของกรอบ
                      ),
                      child: Image.asset(
                        'assets/images/taxi.png',
                        width: 150,
                      ),
                    ),
                  ),
                  TextField(
                    controller: _distanceCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "ป้อนระยะทาง",
                        labelText: "ระยะทาง (กิโลเมตร)",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 25,
                          horizontal: 20,
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _trafficjamTimeCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "ป้อนเวลารถติด (ไม่มีป้อน 0)",
                      labelText: "เวลารถติด (นาที)",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 25,
                        horizontal: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // validate UI หากมีปัญหาแสดง alert dialog
                      if (_distanceCtrl.text.isEmpty) {
                        _warningDialog('ป้อนระยะทางด้วย...');
                      } else if (_trafficjamTimeCtrl.text.isEmpty) {
                        _warningDialog('ป้อนเวลารถติดด้วย...');
                      } else {
                        double distance = double.parse(_distanceCtrl.text);
                        double trafficjamTime =
                            double.parse(_trafficjamTimeCtrl.text);

                        double firstKmPrice = 35;
                        double notFirstKm = distance - 1;

                        double totalPay = firstKmPrice +
                            (notFirstKm * 5.50) +
                            (trafficjamTime * 0.50);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaxiResultUI(
                              distance: distance,
                              trafficjamTime: trafficjamTime,
                              totalPay: totalPay,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'คำนวณ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 26, 60, 253),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      minimumSize: Size(
                        double.infinity,
                        60,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _distanceCtrl.clear();
                      _trafficjamTimeCtrl.clear();
                    },
                    child: Text(
                      'ยกเลิก',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[900]!,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      minimumSize: Size(
                        double.infinity,
                        60,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
