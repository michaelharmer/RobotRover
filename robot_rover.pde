#include <Servo.h>
 
Servo myservo;  // create servo object to control a servo
                // a maximum of eight servo objects can be created
 
int pos = 0;    // variable to store the servo position 

int E1 = 5;	//M1 Speed Control
int E2 = 6;	//M2 Speed Control
int M1 = 4;	//M1 Direction Control
int M2 = 7;	//M1 Direction Control

int ultraSoundSignal = 1; // Ultrasound signal pin ANALOG-0
int val = 0;
int ultrasoundValue = 0;

int turnButton = 3;

void stop_moving(void)	//Stop
{
digitalWrite(E1,LOW);
digitalWrite(E2,LOW);
}
void turn_right(char a,char b)	
{
analogWrite (E1,a);	//PWM Speed Control
digitalWrite(M1,HIGH);
analogWrite (E2,b);
digitalWrite(M2,HIGH);
}
void turn_left (char a,char b)	
{
analogWrite (E1,a);
digitalWrite(M1,LOW);
analogWrite (E2,b);
digitalWrite(M2,LOW);
}
void backward (char a,char b)	
{
analogWrite (E1,a);
digitalWrite(M1,LOW);
analogWrite (E2,b);
digitalWrite(M2,HIGH);
}
void forward (char a,char b)	
{
analogWrite (E1,a);
digitalWrite(M1,HIGH);
analogWrite (E2,b);
digitalWrite(M2,LOW);
}

void turnRight()
{
  turn_right(150,150);
  delay(2000);
  stop_moving();
}


void setup(void)
{
  for(int i=4;i<=7;i++)
    pinMode(i, OUTPUT);
    
  myservo.attach(10,800,2200);  
  myservo.write(90);
  delay(50);
  //Serial.begin(19200);
  pinMode(ultraSoundSignal, INPUT);
}

void writeDistance()
{
  val = analogRead(ultraSoundSignal); 
 Serial.println(val); 
}

void loop()
{
  val = analogRead(ultraSoundSignal); 
  //Serial.println(val);
  if (val > 35)
  {
    forward(130,130);
    delay(30);  
  } else if (val < 25)
  {
    backward(130, 130);
   delay(30); 
  } else
  {
   stop_moving(); 
  }
  
  /*if (digitalRead(turnButton) == LOW)
  {
  for(pos = 0; pos < 180; pos += 1)  // goes from 0 degrees to 180 degrees
  {                                  // in steps of 1 degree
    myservo.write(pos);              // tell servo to go to position in variable 'pos'
    delay(15);                       // waits 15ms for the servo to reach the position
    //writeDistance();
  }
  for(pos = 180; pos>=1; pos-=1)     // goes from 180 degrees to 0 degrees
  {                                
    myservo.write(pos);              // tell servo to go to position in variable 'pos'
    delay(15);                       // waits 15ms for the servo to reach the position
    //writeDistance();
  }
      
}
  
  
  myservo.write(90); 
  writeDistance();
  delay(1000);
  
 
  
  for(pos = 0; pos < 180; pos += 1)  // goes from 0 degrees to 180 degrees
  {                                  // in steps of 1 degree
    myservo.write(pos);              // tell servo to go to position in variable 'pos'
    delay(15);                       // waits 15ms for the servo to reach the position
    writeDistance();
  }
  for(pos = 180; pos>=1; pos-=1)     // goes from 180 degrees to 0 degrees
  {                                
    myservo.write(pos);              // tell servo to go to position in variable 'pos'
    delay(15);                       // waits 15ms for the servo to reach the position
    writeDistance();
  }
  
  */
}


