import 'package:flutter/material.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_button.dart';

class QuanLyDatHangScreen extends StatefulWidget {
  const QuanLyDatHangScreen({super.key});

  @override
  State<QuanLyDatHangScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<QuanLyDatHangScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản Lý Đặt Hàng'),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Image.network(
                        'https://www.chuphinhsanpham.vn/wp-content/uploads/2021/06/chup-hinh-giay-dincox-shoes-c-photo-studio-4.jpg',
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Giày Sneaker Đen',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(height: 8.0),
                          Text('kích thước : 34'),
                          SizedBox(height: 8.0),
                          Text('số lượng : 1'),
                          SizedBox(height: 8.0),
                          Text(
                            '215.000₫ ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomButton(
                                  text: "Xem chi tiết", onClick: () {}),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
