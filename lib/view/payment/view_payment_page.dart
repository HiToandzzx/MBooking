import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Payment',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thông tin phim
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://m.media-amazon.com/images/I/71niXI3lxlL._AC_SY679_.jpg', // Ảnh đại diện
                    width: 80,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Avengers: Infinity War',
                      style: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '🎭 Action, adventure, sci-fi',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '📍 Vincom Ocean Park CGV',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '🗓 10.12.2022 • 14:15',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),

            // Mã giảm giá
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Discount code',
                      hintStyle: TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Apply',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Tổng tiền
            Text(
              'Total',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              '189.000 VND',
              style: TextStyle(
                  color: Colors.yellowAccent,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Phương thức thanh toán
            Text(
              'Payment Method',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  PaymentOption(
                    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/a/a6/ZaloPay_Logo.png',
                    title: 'Zalo Pay',
                  ),
                  PaymentOption(
                    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/5/5a/MoMo_Logo.png',
                    title: 'MoMo',
                  ),
                  PaymentOption(
                    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/6/6f/Shopee_Logo.png',
                    title: 'Shopee Pay',
                    isSelected: true,
                  ),
                  PaymentOption(
                    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/c/c3/ATM_Card.png',
                    title: 'ATM Card',
                  ),
                  PaymentOption(
                    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/0/04/Credit_Card_Logo.png',
                    title: 'International payments',
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            Text(
              'Complete your payment in    15:00',
              style: TextStyle(color: Colors.yellowAccent, fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 16),
            // Nút Continue
            Row(
              children: [
                // Nút Continue
                ElevatedButton(
                  onPressed: () {
                    // Xử lý sự kiện
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text(
                      'Continue',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentOption extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool isSelected;

  const PaymentOption({
    Key? key,
    required this.imageUrl,
    required this.title,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey[900] : Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
        border: isSelected
            ? Border.all(color: Colors.yellowAccent, width: 2)
            : null,
      ),
      child: Row(
        children: [
          Image.network(imageUrl, width: 40, height: 40, fit: BoxFit.cover),
          SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
        ],
      ),
    );
  }
}
