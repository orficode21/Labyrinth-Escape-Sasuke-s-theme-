import processing.sound.*; // Import library sound
SoundFile file; // Deklarasi class agar bisa memakai fungsi sound

int cols = 35; // Jumlah kolom pada map
int rows = 18; // Jumlah baris pada map
int tileSize = 30; // Ukuran setiap satu kotak untuk map dengan array

Player player; // Deklarasi class agar bisa memanggil fungsi dari class Player
Enemy[] enemies; // Sama seperti player dan enemies berbentuk array karena terdapat banyak enemy
int enemyCount = 50; // Jumlah enemy (Bisa disesuaikan)

PImage bgImg, playerImg, enemyImg, wallImg; // Untuk menimpa dengan gambar

int waktuTercepat = 0; // Menyimpan waktu tercepat saat menang
int waktuBerlalu = 0; // Menyimpan waktu terakhir dari penghitungan

void settings() {
 size(cols * tileSize, rows * tileSize);
}

void setup() {
 // Menimpa background dengan gambar dan disesuaikan dengan ukuran map
 bgImg = loadImage("Background.jpg");
 bgImg.resize(cols * tileSize, rows * tileSize); 

 // Menimpa bentuk tampilan player dengan gambar
 player = new Player(80, 72.5, 50); // Posisi awal player
 playerImg = loadImage("player.png");
 playerImg.resize((int)player.diameter, (int)player.diameter); 

 // Menimpa bentuk tampilan enemy dengan gambar gagak 
 enemyImg = loadImage("enemy.png");
 enemyImg.resize(20, 20); 
 enemies = new Enemy[enemyCount];
 for (int i = 0; i < enemyCount; i++) {
  enemies[i] = new Enemy(); 
 }
 
 // Menimpa array dinding dengan gambar
 wallImg = loadImage("wall.png");
 wallImg.resize(tileSize, tileSize); 

 // Meng-display musik backsong
 file = new SoundFile(this, "Musik.mp3");
 file = new SoundFile(this, "Gagak Itachi.mp3");
 file.loop();
}

void draw() {
 // Menampilkan background
 background(bgImg);

 // Menggambar dan menampilkan map Labyrinth
 for (int i = 0; i < rows; i++) {
  for (int j = 0; j < cols; j++) {
    if (map[i][j] == 1) {
      image(wallImg, j * tileSize, i * tileSize);
    } else {
      fill(0);
    } 
  }
 }
 
 // Menampilkan player
 player.display();
 player.update();
 image(playerImg, player.x - playerImg.width / 2, player.y - playerImg.height / 2);

 // Menampilkan enemy
 for (Enemy enemy : enemies) {
  enemy.update();
  image(enemyImg, enemy.x - enemyImg.width / 2, enemy.y - enemyImg.height / 2);
 }
 
 // Menampilkan penghitungan waktu bermain
 if (player.timerStart != 0) {
  waktuBerlalu = (millis() - player.timerStart) / 1000;
  fill(255, 255, 255);
  text("Waktu: " + waktuBerlalu + " detik", 30, 20);
 } else {
  fill(255, 255, 255);
  text("Waktu: 0 detik", 30, 20);
 }
 
 // Cek kondisi menang dan reset penghitungan
 if (player.x >= 32 * tileSize && player.y >= 17 * tileSize) {
  player.timerStart = 0;
  // Menyimpan waktu terakhir sebagai waktu tercepat
  if (waktuBerlalu < waktuTercepat || waktuTercepat == 0) {
    waktuTercepat = waktuBerlalu;
  }
  // Player kembali ke posisi awal dan penghitungan waktu diulang
  player.x = player.startPosX;
  player.y = player.startPosY;
  player.timerStart = millis();
 }
 // Menampilkan waktu tercepat
 fill(255, 255, 255);
 text("Waktu tercepat: " + waktuTercepat + " detik", 900, 20);
}
