# ChronoFit: The Ultimate Fitness Stopwatch

## Team Details
<details>
  <summary> Click here </summary>

  > Semester: 3rd Sem B. Tech. CSE

  > Section: S2

  > Team ID: S2-T5

  > Member-1: Atharv Rajurkar, 231CS215, atharvrajurkar.231cs215@nitk.edu.in

  > Member-2: Manish Agarwal, 231CS232, manishagarwal.231cs232@nitk.edu.in

  > Member-3: Saksham Parmar, 231CS253, sakshamparmar.231cs253@nitk.edu.in
</details>

## Abstract
<details>
  <summary>Click here</summary>
  
  ### Motivation
  
  > 
In today’s fast-paced world, maintaining a healthy lifestyle is challenging, particularly due
to the high cost of advanced fitness technology. ChronoFit helps in solving this problem by
contributing to foster a healthier, more active lifestyle in a practical and accessible manner for
college students and beyond.



 ### Problem Statement

  >
The ChronoFit project aims to develop a digital stopwatch that not only functions as a conventional lap timer but also provides fitness insights such as calorie count, heart rate estimates,
and stamina tracking—all without the use of physical sensors. By utilizing average data and
user inputs (such as weight, distance covered, age, and type of activity), ChronoFit will deliver
a unique, sensor-free approach to fitness monitoring.


### Features


•  **Implementing Stopwatch with Lap Timer**:</t>   
  > Standard stopwatch functionality to track time. Ability to record and display multiple lap times.

• **Calorie Calculation**:
  > Estimates calories burned based on user inputs (weight, age, type of activity) using established formulas.
 
• **Heart Rate Estimation**:
  > Calculates estimated heart rate based on age and activity level using standard equations.

• **Stamina Tracking**:
  > Evaluates stamina based on duration of activity.


</details>
  


## Functional Block Diagram
<details>
  <summary> Click here </summary>
  
 ![block_diagram](https://github.com/user-attachments/assets/8256d4ca-b630-43bc-86f8-6f9e13b05982)




</details>

## Working
<details>
  <summary>Click here</summary>

  ### Main Circuit's Working
  In this project model, users input their Weight, Age, Resting Heart Rate(RHR) and Distance along with selecting a specific type of physical activity (namely Walking, Running or Cycling) to receive data upon certain physical attributes after performing the said activity. Once the activity is selected using a switch (which also acts as the start-stop switch for the stopwatch clock), simultaneously the sequential block of the circuit is triggered which is used to track the duration of the activity. The inputs of the users are stored in registers which relay the necessary data further to the respective modules.
  To enter the data of a new user, a reset switch is used which resets the stored values of all the registers to zero, since we have used low level trigger registers here. This allows us to change the data as we require for the new user after which we can toggle the reset switch back to zero to calculate the data for the new user.

The following components are used for the implementation of all the modules:
	
 > 1) Adders
>  3) Subtractors
>  4) Muxipliers
>  5) Basic logic gates like OR, AND, NOT gates
>  6) Registers
>  7) JK flip flops

The following modules are used in the circuit: 

#### Calorie Counter
This processing unit takes time, type of activity and weight of the person as the input and provides the calories burned by the user while performing the activity. At a time only one activity can be selected. According to the activity selected, the MET(Metabolic Equivalent of Task) data is then further passed in the unit for processing. MET values are 8(1000) for running, 5(0101) for walking and 10(1010) for cycling. The ongoing time, MET and weight are multiplied together using the formula:
				
    Calorie Counter = time(seconds) * MET * weight(kgs)
The time and MET value is first passed into the 10 bit by 8 bit multiplier and then the output of this multiplier is passed along with the weight of the person to another 10 bit by 8 bit multiplier to generate the amount of Calories burned.

#### Speed Calculator
This unit takes the current time and amount of distance travelled in that time as input. In practical applications, distance can be measured in real time using a GPS sensor, however, due to the limited scope of theory for the given project, using sensors is not recommended. Therefore, we first give the total distance covered by the user as input using switches and then note the time taken by the user to cover the said distance using the stopwatch. 

The module therefore provides us with the actual speed only after the stopwatch for an activity has been turned off using the following formula. It divides the distance and time using an 8 bit by 6 bit divider circuit to generate the speed according to the formula:
				
    Speed = distance(meters)/time taken by the activity(seconds)

  The computation is done using a division circuit.

#### Heart Rate Estimator
This module takes in the initial or the Resting Heart Rate(RHR) of the user before performing the activity and outputs the heartbeat of the user after they have performed the given activity.
The inputs to the module block are: RHR, Weight and the output speed of the _Speed Calculator_ module. The output Target Heart Rate can then be computed using the following formula: 
				
    Target Heart Rate(THR) = RHR + (weight/2) + (speed/3)
It uses two division circuits and two adder circuits to generate the output.

#### Sequential
The sequential module consists of the components required for tracking down the time for which a particular activity has been performed. The inputs to the Sequential block consist of the timed activities and one reset button. The output consists of the activity which was being performed and the time for which it was being performed. 
The main component used inside the sequential block is a mod 60 counter clock. This clock is created using a 6-bit asynchronous counter produced using JK- flip flops.
The input activities are used as the start-stop switch for the counter clock such that if any of the three activities are switched on, the counter clock is activated and if all the three activites are switched to zero, then the clock is paused at whatever time has passed till then.
The reset button is used to reset the timer to zero. Also, since this is a minute timer, or a mod 60 counter, it also automatically resets back to zero when the counter reaches 60. 

The activity which was being performed for the given time is stored in a register because if we were to feed the activity inputs directly into the combinational modules for the calculations, then as soon as the input activities are toggled to zero, the data for the activities passed to the combinational circuits would turn to zero too. To overcome this difficulty, I used a rising edge register which stores the value of the activity which was being performed before the timer went back to zero. This way the value stored in the register is overwritten only when the activity input goes from 0 to 1, in which case the new activity would be stored in the register, which is then passed onto the further circuits for calculations.

 ![S2-T5](https://github.com/user-attachments/assets/64345885-6bbb-4856-a18b-c3e2eddb2cf0)
</details>

<!-- Fourth Section -->
## Logisim Circuit Diagram
<details>
  <summary>Click here</summary>

  > Update a neat logisim circuit diagram
</details>

<!-- Fifth Section -->
## Verilog Code
<details>
  <summary>Click here</summary>

  > Neatly update the Verilog code in code style only.
</details>

## References
<details>
  <summary>Click here</summary>
  
>[r1, ] 555 Timer IC Pin Diagram, Circuit, Working, Datasheet, Modes — electronicsforu.com.
> https://www.electronicsforu.com/technology-trends/learn-electronics/555-timer-working-specifications.

  > [gee, ] Shift Registers in Digital Logic - GeeksforGeeks — geeksforgeeks.org.                
> https://www.geeksforgeeks.org/shift-registers-in-digital-logic/.

  > [Kaminski, ] Kaminski, J. Metabolic Equivalents: What Are They & How to Calculate Them — NASM — blog.nasm.org.
> https://blog.nasm.org/metabolic-equivalents-for-weight-loss:

  > [WatElectronics, ] WatElectronics. Binary Division : Truth Table, Rules of Division & Examples
— watelectronics.com.
> https://www.watelectronics.com/binary-division/.

   
</details>



