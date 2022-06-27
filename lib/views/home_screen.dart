import 'package:flutter/material.dart';
import 'package:stateflutter/resources/strings.dart';
import 'package:stateflutter/resources/widgets/input_widget.dart';
import 'package:stateflutter/views/information.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // Bước 1. Tạo ra State và tạo ra BuildContext(context) gắn với State
  //        => state thay đổi thì widget thay đổi vì nó gắn với BuildContext
  //        Widget: cái tiện ích có sẵn gắn kết với nhau để build nội dung
  //        context: hỗ trợ nhau nội dung để build giao diện
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Bước 2. mounted = true; - Biến mounted Sử dụng để kiểm tra xem có state tồn tại hay chưa
  TextEditingController? mathController, englishController, litetureController;
  double? averagePoint;
  String? adjustmentResult = "Chưa xác định";

  // Bước 3: Khởi động State, chưa dùng context ở đây, và có thể đặt các lệnh chạy trước khi build
  @override
  void initState() {
    // Todo: impelement initState
    super.initState();
    mathController = TextEditingController();
    englishController = TextEditingController();
    litetureController = TextEditingController();
  }

  // Bước 4: didChangeDependencies()
  //        - Chạy khi có Dêpndendcies thay đổi: chạy khi widget chạy lần đầu và sau này có dependencies thay đổi
  //        Bản chất không gọi vẫn chạy
  //        Context có thể được dùng ở đây
  @override
  void didChangeDependencies() {
    // Todo: implement didChangeDependencies
    super.didChangeDependencies();
  }

  // Bước 8: Deactive
  @override
  void deactivate() {
    // todoL implement deactivate
    super.deactivate();
  }

  // Bước 9: dispose: Huỷ state
  @override
  void dispose() {
    // todo: implement dispose
    super.dispose();
    mathController!.dispose();
    litetureController!.dispose();
    englishController!.dispose();
  }

  // Bước 10: Khi huỷ rồi thì biến mounted = false

  // Bước 5: Hàm Build
  @override
  Widget build(BuildContext context) {
    if (mounted) {
      print("State đã tồn tại!");
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(studentAdjustment),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(right: 30, left: 30, top: 20),
                child: Column(
                  children: [
                    // TextField: Toán
                    InputWidget(
                        labelText: mathPoint,
                        hintText: mathHint,
                        controller: mathController),

                    // TextField: Văn
                    InputWidget(
                        labelText: liteturePoint,
                        hintText: litetureHint,
                        controller: litetureController),
                    // TextField: Anh
                    InputWidget(
                        labelText: englishPoint,
                        hintText: englishPoint,
                        controller: englishController),

                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          // 7 setState
                          setState(() {
                            averagePoint = (double.parse(mathController!.text) +
                                    double.parse(litetureController!.text) +
                                    double.parse(englishController!.text)) /
                                3;
                            adjustmentResult =
                                adjusmentStudent(averageMark: averagePoint!);
                          });
                        },
                        child: Text(adjustment)),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        child: SizedBox(
                            width: 300,
                            height: 100,
                            child: Container(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 20, bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(averageMark +
                                        " : ${(averagePoint == null) ? "Chưa xác định" : averagePoint.toString()}"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(adjustment +
                                        " : " +
                                        adjustmentResult.toString())
                                  ],
                                ))),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          var route = MaterialPageRoute(
                              builder: (context) => Information(
                                  averagePoint: averagePoint!,
                                  adjustmentResult: adjustmentResult!));
                          Navigator.push(context, route);
                        },
                        child: Text(information))
                  ],
                ))));
  }

  String adjusmentStudent({required double averageMark}) {
    if (averageMark < 5) return "Chưa đạt";
    if (averageMark < 8.5) return "Đạt";
    if (averageMark > 8.5) return "Xuất sắc";
    return "Không xác định";
  }
}

// Tạo 1 widget bằng hàm
// Widget inputWidget(
//     {required String labelText,
//     required String hintText,
//     required controller}) {
//   return Container(
//       padding: const EdgeInsets.only(top: 20, bottom: 10),
//       child: TextField(
//         decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           labelText: labelText,
//           hintText: hintText,
//         ),
//         controller: controller,
//       ));
// }
