const int led = 13;
const int shooter = 11;
void setup() {
  pinMode(led, OUTPUT);
}

void loop() {
  digitalWrite(led, LOW);
  digitalWrite(shooter, LOW);
  delay(2500);
  digitalWrite(led, HIGH);
  digitalWrite(shooter, HIGH);
  delay(100);
  digitalWrite(shooter, LOW);
  delay(2500);    
  delay(1);
}
