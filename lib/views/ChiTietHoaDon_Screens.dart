import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kingofshoes/views/widgets/custom_widgets/custom_button.dart';

class InvoiceDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,##0');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Chi tiết hóa đơn",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CustomButton(text: "Duyệt", onClick: () {}),
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
        const Text("Trạng thái: Đã thanh toán", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        const Text("Hình thức thanh toán: Thẻ tín dụng",
            style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        const Text("Mã giảm  giá: 10,000 VND",
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
            1: FlexColumnWidth(3),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(2),
            4: FlexColumnWidth(2),
          },
          children: [
            const TableRow(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 224, 224, 224),
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
            const TableRow(
              children: [
                Padding(
                    padding: EdgeInsets.all(8.0), child: Text("Giày thể thao")),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("2", textAlign: TextAlign.center),
                ),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("500,000 VND", textAlign: TextAlign.right)),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("GIAM10", textAlign: TextAlign.center)),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("450,000 VND", textAlign: TextAlign.right)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTotalAmount(NumberFormat numberFormat) {
    return const Text(
      "Tổng cộng: 1,000,000 VND",
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.red,
          decoration: TextDecoration.lineThrough),
    );
  }

  Widget _buildTotalAfterDiscount(NumberFormat numberFormat) {
    return const Text(
      "Tổng giá sau giảm: 900,000 VND",
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
    );
  }
}
