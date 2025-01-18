import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_button.dart';

class ChiTietHoaDonScreen extends StatefulWidget {
  @override
  _ChiTietHoaDonScreenState createState() => _ChiTietHoaDonScreenState();
}

class _ChiTietHoaDonScreenState extends State<ChiTietHoaDonScreen> {
  int _selectedProductQuantity = 2;
  int _productPrice = 500000;
  int _discountAmount = 10000;

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,##0');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Chi tiết hóa đơn",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back, color: Colors.white)),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CustomButton(text: "Duyệt", onClick: () {}),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInvoiceInfo(numberFormat),
              const SizedBox(height: 16),
              _buildProductList(numberFormat),
              const SizedBox(height: 10),
              _buildTotalAmount(numberFormat),
              _buildTotalAfterDiscount(numberFormat),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceInfo(NumberFormat numberFormat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Hóa đơn ID: HD12345",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text("Tên khách hàng: Nguyễn Văn A",
            style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        const Text("Ngày đặt: 15/01/2025", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        const Text("Trạng thái: Chờ duyệt", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        const Text("Hình thức thanh toán: Thẻ tín dụng",
            style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Text("Mã giảm giá: ${numberFormat.format(10000)} VND",
            style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildProductList(NumberFormat numberFormat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Danh sách sản phẩm:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Table(
          border: TableBorder.all(color: Colors.grey),
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(2),
            4: FlexColumnWidth(2),
          },
          children: [
            const TableRow(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240),
              ),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Tên sản phẩm",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("SL",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Giá niêm yết",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Mã giảm giá",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Giá sau giảm",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                ),
              ],
            ),
            // Dòng sản phẩm mẫu
            TableRow(
              children: [
                Padding(
                    padding: EdgeInsets.all(8.0), child: Text("Giày thể thao")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.remove,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_selectedProductQuantity > 1) {
                            _selectedProductQuantity--;
                            _updateTotalAmount();
                          }
                        });
                      },
                    ),
                    Expanded(
                      child: Text("$_selectedProductQuantity",
                          style: TextStyle(fontSize: 16)),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedProductQuantity++;
                          _updateTotalAmount();
                        });
                      },
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(numberFormat.format(_productPrice) + " VND",
                        textAlign: TextAlign.right)),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("GIAM10", textAlign: TextAlign.center)),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        numberFormat.format(_productPrice - _discountAmount) +
                            " VND",
                        textAlign: TextAlign.right)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void _updateTotalAmount() {
    setState(() {
      _buildTotalAmount(NumberFormat('#,##0'));
      _buildTotalAfterDiscount(NumberFormat('#,##0'));
    });
  }

  Widget _buildTotalAmount(NumberFormat numberFormat) {
    int totalAmount = _productPrice * _selectedProductQuantity;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        "Tổng cộng: ${numberFormat.format(totalAmount)} VND",
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
            decoration: TextDecoration.lineThrough),
      ),
    );
  }

  Widget _buildTotalAfterDiscount(NumberFormat numberFormat) {
    int totalAmount =
        (_productPrice - _discountAmount) * _selectedProductQuantity;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        "Tổng giá sau giảm: ${numberFormat.format(totalAmount)} VND",
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
      ),
    );
  }
}
