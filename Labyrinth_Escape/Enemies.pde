class Enemy {
 private float x, y; // Variabel posisi musuh
 private float vx, vy; // Variabel kecepatan musuh

 // Constructor
 Enemy() {
  x = random(width);
  y = random(height);
  vx = random(-1, 1);
  vy = random(-1, 1);
 }

 // Update posisi dan pemantulan enemy
 void update() {
   x += vx; // Memberikan kecepatan enemy
   y += vy;
   // Pemantulan enemy dengan sisi layar
   if (x < 0 || x > width){
      vx *= -1; 
   }
   if (y < 0 || y > height){
      vy *= -1; 
   }
 }
}
