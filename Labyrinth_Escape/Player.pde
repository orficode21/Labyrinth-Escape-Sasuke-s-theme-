class Player {
 private float x, y; // Variabel untuk posisi
 private float diameter; // Variabel untuk diameter
 private float speed = 2; // Kecepatan pemain
 private float startPosX, startPosY; // Variabel untuk posisi awal
 private int timerStart, timerReset; // Timer untuk saat pemain mulai bergerak dan mereset

 // Konstruktor
 Player(float x, float y, float diameter){
  this.x = x;
  this.y = y;
  this.diameter = diameter;
  this.startPosX = x;
  this.startPosY = y;
  this.timerStart = 0;
  this.timerReset = 0;
 }

 void display() {
   fill(0, 0, 145); // warna pemain (background)
   ellipse(x, y, 15, 15); // Ukuran pemain (disesuaikan)
 }

 // Cek pergerakan player
 boolean isValidMove(float newX, float newY) {
   int tileX = (int)newX / tileSize;
   int tileY = (int)newY / tileSize;
   if (tileX < 0 || tileY < 0 || tileX >= cols || tileY >= rows) {
     return false;
   }
   if (map[tileY][tileX] == 1) {
     return false;
   }
   return true;
 }

 // Cek jika enemy menyentuh player
 void checkCollisionWithEnemy(Enemy[] enemies){
   for (Enemy enemy : enemies) {
     float distance = dist(this.x, this.y, enemy.x, enemy.y);
     if (distance < (this.diameter / 2)){
       this.x = startPosX;
       this.y = startPosY;
       timerStart = 0; // Reset timer
     }
   }
 }

 // Menggerakkan player dan pengecekan serangan enemy
 void update() {
   if (keyPressed) {
     float newX = x;
     float newY = y;
     if (keyCode == LEFT) {
       newX -= speed;
     } else if (keyCode == RIGHT) {
       newX += speed;
     } else if (keyCode == UP) {
       newY -= speed;
     } else if (keyCode == DOWN) {
       newY += speed;
     }
     if (isValidMove(newX, newY)) {
       x = newX;
       y = newY;
     }
     if (timerStart == 0) {
       timerStart = millis();
     }
   }
   checkCollisionWithEnemy(enemies);
 }
}
