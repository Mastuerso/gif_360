 const int button1 = 2;
 //const int button2 = 3;
 //const int focus = 10;
 const int shooter = 11;
 const int led = 13;

 int buttonState1 = 0;
 //int buttonState2 = 0;

void setup() {
  pinMode(button1,INPUT);
  //pinMode(button2,INPUT);
  //pinMode(focus, OUTPUT);
  pinMode(shooter,OUTPUT);  
  pinMode(led,OUTPUT);
}

void loop() {
  buttonState1 = digitalRead(button1);
  //buttonState2 = digitalRead(button2);
  //digitalWrite(focus,LOW);
  digitalWrite(shooter,LOW);
  digitalWrite(led,LOW);
  if (buttonState1 == HIGH)
  {
    //digitalWrite(focus,HIGH);
     //delay(2000);
     digitalWrite(led,HIGH);
     digitalWrite(shooter,HIGH);
     delay(1);
     //digitalWrite(focus,LOW);
     digitalWrite(shooter,LOW);
  }else
  {
    //digitalWrite(focus,LOW);
    digitalWrite(shooter,LOW);
  }

}
