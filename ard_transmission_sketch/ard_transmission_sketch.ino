char acc1 = 0;
char acc2 = 0;
String transmission;

int ledPin = LED_BUILTIN;
void setup() {
  // put your setup code here, to run once:
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  if(Serial.available())
  {
    acc1 = Serial.read();
  }
  if(acc1 >= char(75) )
  {
    digitalWrite(ledPin, HIGH);
  }
  else
  {
    digitalWrite(ledPin, LOW);
  }
}
