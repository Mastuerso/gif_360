const int button1 = 2;
const int shooter = 11;
const int led = 13;

int buttonState1 = 0;

bool on_release = false;
char msg;
char key;

void setup() {
  Serial.begin(9600);
  pinMode(button1, INPUT);
  pinMode(shooter, OUTPUT);  
}

void loop() {
  buttonState1 = digitalRead(button1);
  if (buttonState1 == HIGH) {    
    on_release = true;
    Serial.println("");
  }
  if (buttonState1 == LOW && on_release) {
    Serial.println("trigger");
    on_release = false;
  } else {
    Serial.println("");
  }
  if (Serial.available() > 0) {    
    key = Serial.read();
    if (key == 'f') {
      digitalWrite(shooter, HIGH);
      //delay(200);
      digitalWrite(shooter, LOW);
    }
  }
}
