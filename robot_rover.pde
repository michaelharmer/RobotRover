#include <Servo.h>
#include <stdlib.h>

#define LEFT -1
#define RIGHT 1
#define NO_TURN 0

 
Servo myservo;  // create servo object to control a servo
                // a maximum of eight servo objects can be created
 
int pos = 0;    // variable to store the servo position 

int E1 = 5;	//M1 Speed Control
int E2 = 6;	//M2 Speed Control
int M1 = 4;	//M1 Direction Control
int M2 = 7;	//M1 Direction Control

int ultraSoundSignal = 1; // Ultrasound signal pin ANALOG-0
int val = 0, left, right;
int ultrasoundValue = 0;
int current_turn = NO_TURN;

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

void setup(void)
{
  for(int i=4;i<=7;i++)
    pinMode(i, OUTPUT);
    
  myservo.attach(10);  
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


int comparison_fn(const void *a, const void *b)
{
 return ((const int *) a) < ((const int *) b); 
}

#define NUM_READINGS 7
int distanceAt(int angle)
{
  int reading[NUM_READINGS];
  myservo.write(angle);
  delay(600);
  for (int i = 0; i < NUM_READINGS; i++) 
  {
    reading[i] = analogRead(ultraSoundSignal);    
  }
  qsort(reading, sizeof(int) * NUM_READINGS, sizeof(int), comparison_fn);
  
  return reading[(int) floor(NUM_READINGS / 2.0)]; 
}

void turn_right()
{
  turn_right(180, 180); 
  delay(400);
  stop_moving();
}

void turn_left()
{
  turn_left(180, 180); 
  delay(400);
  stop_moving();
}

void forward(int time = 30)
{
  forward(130,130);
  delay(time);  
}

void backward(int time = 30)
{
  backward(130,130);
  delay(time);  
}

void loop()
{
  int left, right;
  
  val = distanceAt(90); 
  //Serial.println(val);
  //delay(1000);
  
  if (val > 30)
  {
    forward();
    current_turn = NO_TURN;
  } else
  {
    stop_moving(); 
    switch (current_turn)
    {
      case NO_TURN:
        left = distanceAt(160);
        right = distanceAt(20);
        if (left < right)
          current_turn = RIGHT;
        else
          current_turn = LEFT;
        break;
      case RIGHT:
        turn_right();
        break;
      case LEFT:
        turn_left();
        break;  
    }
    
  }
  
}


