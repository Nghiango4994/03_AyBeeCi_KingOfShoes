import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Thêm thư viện intl
import 'package:kingofshoes/models/ChiTietHoaDon.dart'; // Import tệp models

class InvoiceDetailScreen extends StatefulWidget {
  final Order order;

  InvoiceDetailScreen({required this.order});

  @override
  _InvoiceDetailScreenState createState() => _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends State<InvoiceDetailScreen> {
  void _editProductQuantity(BuildContext context, Product product, int change) {
    int newQuantity = product.quantity + change;
    if (newQuantity >= 0) {
      setState(() {
        product.quantity = newQuantity;
      });
    }
  }

  void _removeProduct(BuildContext context, Product product) {
    // Hiển thị dialog xác nhận
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Xác nhận xóa sản phẩm"),
          content: Text("Bạn có chắc chắn muốn xóa sản phẩm: ${product.name}?"),
          actions: <Widget>[
            // Nút Cancel
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: const Text("Hủy"),
            ),
            // Nút OK
            TextButton(
              onPressed: () {
                setState(() {
                  widget.order.products
                      .remove(product); // Xóa sản phẩm khỏi danh sách
                });
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: const Text("Xóa"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,##0'); // Định dạng hàng nghìn

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0), // Nền màu đen
        elevation: 2, // Thêm độ nổi
        title: const Text(
          "Chi tiết hóa đơn",
          style: TextStyle(color: Colors.white), // Màu chữ trắng
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hóa đơn ID: ${widget.order.orderCode}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Tên khách hàng: ${widget.order.customerName}",
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Ngày đặt: ${widget.order.orderDate}",
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Trạng thái: ${widget.order.status}",
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text("Hình thức thanh toán: ${widget.order.paymentMethod}",
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text(
                "Giảm giá tổng: ${widget.order.totalDiscount != null ? numberFormat.format(widget.order.totalDiscount!) + " VND" : "0 VND"}",
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 16),

            // Dòng hiển thị mã giảm giá cho tổng hóa đơn
            Text(
                "Mã giảm giá cho tổng hóa đơn: ${widget.order.totalDiscount != null ? "Có" : "Không"}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            Text("Danh sách sản phẩm:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Table(
                  border: TableBorder.all(color: Colors.grey),
                  columnWidths: const {
                    0: FlexColumnWidth(3),
                    1: FlexColumnWidth(3), // Cột tăng giảm số lượng
                    2: FlexColumnWidth(2), // Cột giá niêm yết
                    3: FlexColumnWidth(2), // Cột mã giảm giá
                    4: FlexColumnWidth(2), // Cột giá sau giảm
                    5: FlexColumnWidth(1), // Cột xóa
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
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("SL",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Giá niêm yết",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Mã giảm giá",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Giá sau giảm",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Xóa SP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                      ],
                    ),
                    ...widget.order.products.map((product) {
                      // Tính giá sau giảm
                      final discountedPrice = product.discountPercentage != null
                          ? (product.price -
                                  (product.price *
                                      (product.discountPercentage! / 100)))
                              .toInt()
                          : product.price.toInt();

                      return TableRow(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(product.name)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove,
                                      color: Colors.red),
                                  onPressed: () => _editProductQuantity(
                                      context, product, -1),
                                ),
                                Text(product.quantity.toString()),
                                IconButton(
                                  icon: const Icon(Icons.add,
                                      color: Colors.green),
                                  onPressed: () =>
                                      _editProductQuantity(context, product, 1),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "${numberFormat.format(product.price)} VND",
                                  textAlign: TextAlign.right)),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(product.discountCode ?? "Không có",
                                  textAlign: TextAlign.center)),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  "${numberFormat.format(discountedPrice)} VND",
                                  textAlign: TextAlign.right)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () => _removeProduct(context, product),
                              child: const Text(
                                "Xóa",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),
            // Tổng cộng
            Text(
              "Tổng cộng: ${numberFormat.format(widget.order.products.fold<int>(0, (sum, product) => sum + product.quantity * product.price.toInt()))} VND", // Ép kiểu thành int
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                  decoration: TextDecoration.lineThrough),
            ),
            // Tổng giá sau giảm
            Text(
              "Tổng giá sau giảm: ${numberFormat.format(widget.order.products.fold<int>(0, (sum, product) {
                    final discountedPrice = product.discountPercentage != null
                        ? (product.price -
                                (product.price *
                                    (product.discountPercentage! / 100)))
                            .toInt()
                        : product.price.toInt();
                    return sum + (product.quantity * discountedPrice);
                  }) - (widget.order.totalDiscount ?? 0))} VND", // Ép kiểu thành int
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
