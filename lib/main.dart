import 'package:flutter/material.dart';

// =========================
// DATA DIRI
// =========================
const String nama = 'Mochamad Ramdhan Irawan';
const String nim = '20240040199';
const String prodiKelas = 'Teknik Informatika / TI24G';

// =========================
// WARNA TEMA
// =========================
const Color navyBlue = Color(0xFF0D47A1);
const Color lightBlue = Color(0xFF42A5F5);
const Color profileBlue = Color(0xFF1565C0);
const Color backgroundBlue = Color(0xFFE3F2FD);
const Color amber = Color(0xFFFFC107);

void main() {
  runApp(const MyApp());
}

// =========================
// MY APP
// =========================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PPM Sesi 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: navyBlue,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F9FF),
      ),
      home: const MainPage(),
    );
  }
}

// =========================
// MAIN PAGE
// =========================
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    ProductPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedIndex == 0
              ? 'PPM Sesi 2 - Produk'
              : 'PPM Sesi 2 - Profil',
        ),
        backgroundColor: navyBlue,
        foregroundColor: Colors.white,
      ),

      body: pages[selectedIndex],

      // =========================
      // BOTTOM NAVIGATION
      // =========================
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        indicatorColor: backgroundBlue,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            selectedIcon: Icon(
              Icons.shopping_bag,
              color: navyBlue,
            ),
            label: 'Produk',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(
              Icons.person,
              color: navyBlue,
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// ======================================================
// HALAMAN PRODUK
// ======================================================
class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          PromoBanner(),
          SizedBox(height: 20),
          ProductCard(),
        ],
      ),
    );
  }
}

// ======================================================
// PROMO BANNER
// ======================================================
class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 135,
      child: Stack(
        children: [
          // =========================
          // BACKGROUND GRADIENT
          // =========================
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  navyBlue,
                  lightBlue,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),

          // =========================
          // ICON DEKORASI
          // =========================
          Positioned(
            right: -15,
            bottom: -30,
            child: Icon(
              Icons.local_offer_rounded,
              size: 135,
              color: Colors.white.withValues(alpha: 0.15),
            ),
          ),

          // =========================
          // TEKS BANNER
          // =========================
          const Positioned(
            left: 20,
            top: 22,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PROMO SPESIAL',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Dapatkan produk pilihan\n'
                  'dengan harga spesial!',
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),

          // =========================
          // BADGE
          // =========================
          Positioned(
            right: 15,
            top: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: amber,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '-50%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ======================================================
// CARD PRODUK
// ======================================================
class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;
  int like = 10;
  int jumlah = 1;

  final int harga = 350000;

  // =========================
  // FAVORITE
  // =========================
  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;

      if (isFavorite) {
        like++;
      } else {
        like--;
      }
    });
  }

  // =========================
  // TAMBAH JUMLAH
  // =========================
  void tambahJumlah() {
    setState(() {
      jumlah++;
    });
  }

  // =========================
  // KURANG JUMLAH
  // =========================
  void kurangJumlah() {
    if (jumlah > 1) {
      setState(() {
        jumlah--;
      });
    }
  }

  // =========================
  // TAMBAH KERANJANG
  // =========================
  void tambahKeKeranjang() {
    final total = harga * jumlah;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          '$jumlah produk ditambahkan ke keranjang '
          '(Rp${formatRupiah(total)})',
        ),
      ),
    );
  }

  // =========================
  // FORMAT RUPIAH
  // =========================
  String formatRupiah(int angka) {
    return angka.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalHarga = harga * jumlah;

    return Card(
      elevation: 4,
      shadowColor: navyBlue.withValues(alpha: 0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // =========================
            // GAMBAR PRODUK
            // =========================
            Container(
              height: 190,
              decoration: BoxDecoration(
                color: backgroundBlue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.shopping_bag_rounded,
                size: 85,
                color: profileBlue,
              ),
            ),

            const SizedBox(height: 16),

            // =========================
            // NAMA + FAVORITE
            // =========================
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Text(
                    'Sepatu Sneakers',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: backgroundBlue,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: toggleFavorite,
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: isFavorite ? Colors.red : navyBlue,
                    ),
                  ),
                ),
              ],
            ),

            // =========================
            // LIKE
            // =========================
            Text(
              '$like orang menyukai produk ini',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 12),

            // =========================
            // HARGA + KATEGORI
            // =========================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rp${formatRupiah(harga)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: navyBlue,
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: amber,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Fashion',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            const Divider(),

            const SizedBox(height: 8),

            // =========================
            // JUMLAH PRODUK
            // =========================
            const Text(
              'Jumlah Produk',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                color: backgroundBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton.filledTonal(
                    onPressed: kurangJumlah,
                    icon: const Icon(Icons.remove),
                  ),

                  Text(
                    '$jumlah',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: navyBlue,
                    ),
                  ),

                  IconButton.filledTonal(
                    onPressed: tambahJumlah,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // =========================
            // TOTAL
            // =========================
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(
                  color: backgroundBlue,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Harga',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rp${formatRupiah(totalHarga)}',
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: navyBlue,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // =========================
            // BUTTON KERANJANG
            // =========================
            SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: tambahKeKeranjang,
                icon: const Icon(Icons.shopping_cart_outlined),
                label: const Text(
                  'Tambah ke Keranjang',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: navyBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// HALAMAN PROFIL
// ======================================================
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: const [
          ProfileCard(
            nama: nama,
            nim: nim,
            prodiKelas: prodiKelas,
          ),
        ],
      ),
    );
  }
}

// ======================================================
// CARD PROFIL
// ======================================================
class ProfileCard extends StatelessWidget {
  final String nama;
  final String nim;
  final String prodiKelas;

  const ProfileCard({
    super.key,
    required this.nama,
    required this.nim,
    required this.prodiKelas,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: navyBlue.withValues(alpha: 0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // =========================
          // HEADER PROFIL
          // =========================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 24,
            ),
            decoration: const BoxDecoration(
              color: navyBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: const Text(
              'IDENTITAS MAHASISWA',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),

          // =========================
          // ISI PROFIL
          // =========================
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                // ICON PROFIL
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: backgroundBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 70,
                    color: profileBlue,
                  ),
                ),

                const SizedBox(height: 18),

                // NAMA
                Text(
                  nama,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: navyBlue,
                  ),
                ),

                const SizedBox(height: 6),

                // NIM
                Text(
                  nim,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 4),

                // PRODI
                Text(
                  prodiKelas,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 18),

                // =========================
                // RATING
                // =========================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (_) => const Icon(
                      Icons.star,
                      color: amber,
                      size: 26,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // =========================
                // BADGE
                // =========================
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: amber,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'MAHASISWA',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
