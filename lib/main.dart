import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kasa Yönetimi',
      home: const Anasayfa(),
    );
  }
}


class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  List <String> islemGecmisi = [];

  double bakiye = 0.0;

  final TextEditingController _miktarController =
      TextEditingController(); // Miktar girişi için metin kutusu kuryesi

  final TextEditingController _aciklamaController =
      TextEditingController(); // Açıklama girişi için metin kutusu kuryesi
  
  void GelirEkle(double miktar, String aciklama) {
    setState(() {
      bakiye += miktar;
      
       final today = DateTime.now();
       
      islemGecmisi.insert(0, "$aciklama : + $miktar ₺\n(${today.day}.${today.month}.${today.year} / ${today.hour}:${today.minute})"); 
    });
  }

  void GiderEkle(double miktar, String aciklama) {
    setState(() {
      bakiye -= miktar;

      final today = DateTime.now();
       
      islemGecmisi.insert(0, "$aciklama : - $miktar ₺\n(${today.day}.${today.month}.${today.year} / ${today.hour}:${today.minute})"); 
    });
  }

  void gelirEklePenceresi(BuildContext context) {
    _miktarController.clear(); // Önceki girişi temizle
    _aciklamaController.clear(); // Önceki girişi temizle
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Gelir Ekle'),
          content: Column(
            mainAxisSize: MainAxisSize.min, //Pencere boyutunu içeriğe göre ayarla
            children: [
              //1. Miktar Girişi
              TextField(
                controller: _miktarController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                hintText: 'Miktar Girin',
                prefixIcon: Icon(Icons.arrow_upward),
            
            ),
          ),

          const SizedBox(height: 10),
          // 2. Açıklama Girişi
          TextField(
            controller: _aciklamaController,
            decoration: const InputDecoration(
              hintText: 'Açıklama Girin',
              prefixIcon: Icon(Icons.description),
            ),
          ),
        ],
      ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Pencereyi kapat
              },
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                double miktar = double.tryParse(_miktarController.text) ?? 0;
                String aciklama = _aciklamaController.text.isEmpty ? 'Gelir' : _aciklamaController.text;
                
                GelirEkle(miktar, aciklama);
                Navigator.of(context).pop(); // Pencereyi kapat
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Ekle'),
            ),
          ],
        );
      },
    );
  }

  void giderEklePenceresi(BuildContext context) {
    _miktarController.clear(); // Önceki girişi temizle
    _aciklamaController.clear(); // Önceki girişi temizle
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Gider Ekle'),
          content: Column(
            mainAxisSize: MainAxisSize.min, //Pencere boyutunu içeriğe göre ayarla
            children: [
              // Miktar Girişi
              TextField(
                controller: _miktarController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration( 
                  hintText: 'Miktar Girin',
                  prefixIcon: Icon(Icons.arrow_downward),
            ),
          ),

          const SizedBox(height: 10),
          TextField(
            controller: _aciklamaController,
            decoration: const InputDecoration(
              hintText: 'Açıklama Girin',
              prefixIcon: Icon(Icons.description),
            ),
          ),
        ],
      ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Pencereyi kapat
              },
              child: const Text('İptal'),
            ),
            ElevatedButton(
              onPressed: () {
                double miktar = double.tryParse(_miktarController.text) ?? 0;
                String aciklama = _aciklamaController.text.isEmpty ? 'Gider' : _aciklamaController.text;
                
                GiderEkle(miktar, aciklama);
                Navigator.of(context).pop(); // Pencereyi kapat
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Ekle'),
            ),
          ],
        );
      },
    );
  }

  // TASARIM
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        title: const Text('Kasa Yönetimi'),
        backgroundColor: Colors.indigo[200],
        foregroundColor: Colors.black,
        leading: const Icon(Icons.account_balance_wallet),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Kutucuk (Bakiye Gösterimi)
            Container(
              width: double.infinity, // Sağa sola tam yaslansın
              height: 120, // Sabit yükseklik
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), 
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Toplam Bakiye',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '₺ $bakiye', // Yukarıdaki değişkeni buraya bağladık!
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: bakiye >= 0 ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),

            // 2. KISIM (Orta Kısım, BUTONLAR)
            // GELİR EKLE
            Padding(
              padding: const EdgeInsets.only(top: 10), //Üst boşluk
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => gelirEklePenceresi(context),
                      child: Container(
                        height: 150,
                        margin: const EdgeInsets.all(10), //Kenar boşluk
                        decoration: BoxDecoration(
                          color: Colors.green[300],
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(
                                0,
                                3,
                              ), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // Dikeyde ortala
                          children: const [
                            Text(
                              'Gelir Ekle',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const Icon(Icons.add_circle_outline, size: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 10),

                  //İkinci Container (Gider Ekle) 2. Buton
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // Gider ekleme işlemi burada yapılacak
                        giderEklePenceresi(context);
                      },
                      child: Container(
                        height: 150,
                        margin: const EdgeInsets.all(10), //Kenar boşluk
                        decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(
                                0,
                                3,
                              ), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // Dikeyde ortala
                          children: const [
                            Text(
                              'Gider Ekle',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const Icon(Icons.remove_circle_outline, size: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 10),
            const Divider(), // Araya ayırıcı çizgi çeker
            
            // 3. KISIM (Alt Kısım)
            Expanded(
              //Alt kısım tüm boşluğu kaplasın
              child: islemGecmisi.isEmpty
              ?const Center(child: Text('Henüz işlem geçmişi yok.'))
              :ListView.builder(
                itemCount: islemGecmisi.length,
                itemBuilder: (context, index) {

                  String islem = islemGecmisi[index];
                  bool gelirMi = islem.contains('+'); // Gelir mi gider mi kontrolü

                  return Dismissible(
                    key: UniqueKey(), 
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        islemGecmisi.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('İşlem silindi')),
                      );
                    },
                  child: Card(
                    elevation:2,
                    margin: const EdgeInsets.symmetric(horizontal:10, vertical:5),
                    child: ListTile(
                      leading: Icon(
                        gelirMi ? Icons.arrow_upward : Icons.arrow_downward,
                        color: gelirMi ? Colors.green : Colors.red,
                      ),
                      title: Text(
                        islemGecmisi[index],
                        style: TextStyle(fontWeight: FontWeight.bold,
                        color: gelirMi ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
