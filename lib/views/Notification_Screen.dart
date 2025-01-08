import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Thông báo",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            )
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
        leading: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 234, 233, 233),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Xóa hết",
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.grey[200], // Màu nền cho body
        constraints:
            BoxConstraints.expand(), // Đảm bảo body chiếm toàn bộ không gian
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Hôm nay",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              cardNotification(
                "https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/067ea325-267a-4c9c-8148-d62eeee1e329/W+AIR+FORCE+1+%2707+NEXT+NATURE.png", // Đường dẫn đến hình ảnh trên mạng
                "Thông báo 1",
                "Nội dung thông báo 1",
                "\$100",
                "\$80",
                "6 phút trước",
              ),
              cardNotification(
                "https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/067ea325-267a-4c9c-8148-d62eeee1e329/W+AIR+FORCE+1+%2707+NEXT+NATURE.png",
                "Thông báo 2",
                "Nội dung thông báo 2",
                "\$200",
                "\$150",
                "10 phút trước",
              ),
              cardNotification(
                "https://static.nike.com/a/images/t_PDP_936_v1/f_auto,q_auto:eco/067ea325-267a-4c9c-8148-d62eeee1e329/W+AIR+FORCE+1+%2707+NEXT+NATURE.png",
                "Thông báo 3",
                "Nội dung thông báo 3",
                "\$300",
                "\$250",
                "15 phút trước",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardNotification(String imageUrl, String title, String content,
      String originalPrice, String discountedPrice, String timeAgo) {
    return SizedBox(
      width: double.infinity, // Để card chiếm toàn bộ chiều rộng
      height: 130, // Chiều cao cố định cho card
      child: Card(
        margin: const EdgeInsets.all(5.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // Viền tròn 4 góc
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              // Cột 1: Hình ảnh từ mạng
              Container(
                width: 100, // Chiều rộng cố định cho hình ảnh
                height: 100, // Chiều cao cố định cho hình ảnh
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color:
                            Colors.grey[300], // Màu nền khi không tải được ảnh
                        child: const Center(child: Icon(Icons.error)),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10), // Khoảng cách giữa các cột

              // Cột 2: Nội dung thông báo và giá
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(content),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          originalPrice,
                          style: const TextStyle(
                            color: Colors.grey, // Màu xám cho giá gốc
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          discountedPrice,
                          style: const TextStyle(
                            color: Colors.black, // Màu đen cho giá sau giảm
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Cột 3: Thời gian
              Container(
                width: 70, // Chiều rộng cố định cho thời gian
                alignment: Alignment.centerRight,
                child: Text(
                  timeAgo,
                  style: const TextStyle(
                    color: Colors.grey, // Màu xám cho thời gian
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
