const int button1 = 2;
const int shooter = 11;
const int led = 13;

int buttonState1 = 0;

bool on_release = false;
bool image_taken = false;
bool freeze = true;
bool system_ready = false;

String monitor_msg;
int key = 0;

void setup() {
  Serial.begin(9600);
  pinMode(button1, INPUT);
  pinMode(shooter, OUTPUT);
  pinMode(led, OUTPUT);
}

void loop() {
  if (system_ready) {
    if (Serial.available() > 0) {
      key = Serial.read();
    }
    switch (key) {
      case 100://d=100 dynamic gif inc
        freeze = false;
        //monitor_msg = "Dynamic";
        break;
      case 102://f=102 freezed gif inc
        freeze = true;
        //monitor_msg = "Freezed";
        break;
      case 111://o=111 baked gif
        image_taken = false;
        //monitor_msg = "Ready";
        break;
    }
    buttonState1 = digitalRead(button1);
    if (image_taken) {
      digitalWrite(led, HIGH);
      if (freeze) {
        Serial.println("Freezed");        
      } else {
        Serial.println("Dynamic");
      }            
      digitalWrite(led, HIGH);
    } else {      
      if (buttonState1 == LOW && on_release) {
        if (freeze) {
          digitalWrite(shooter, HIGH);
          delay(150);
          digitalWrite(shooter, LOW);          
        } 
        image_taken = true;        
        on_release = false;
      } else if (buttonState1 == HIGH) {
        on_release = true;
      } else if (buttonState1 == LOW) {
        digitalWrite(shooter, LOW);
      }
      digitalWrite(led, LOW);
      //Serial.println(monitor_msg);
      Serial.println("Ready");
    }

  } else {
    digitalWrite(led, HIGH);
    if (Serial.available() > 0) {
      key = Serial.read();
      if (key == 114) {//r=114 system is ready
        system_ready = true;
      }
    }
  }
}
