char serialChar = NULL;
String accString = NULL;
int acc1Int = 0;
int acc2Int = 0;

int ledPin = LED_BUILTIN;
void setup() {
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  if(Serial.available())
  {
    //serial parser
    serialChar = Serial.read();
    if(isDigit(serialChar))
    {
      accString += serialChar; 
    }
    
    if(serialChar == 'R')
    {
      acc1Int = accString.toInt();
      accString = ""; 
    }
    else if(serialChar == '/n')
    {
      acc2Int = accString.toInt();
      accString = ""; 
    }
  }
  //LED test
  if(acc1Int >= 75 && acc2Int >= 75)
  {
    digitalWrite(ledPin, HIGH); 
  }
  else
  {
    digitalWrite(ledPin, LOW); 
  }
}
