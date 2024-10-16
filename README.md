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

• **Speed Tracking**:
  > Calculates average speed.


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
  In this project model, users input their Weight, Resting Heart Rate(RHR) and Distance along with selecting a specific type of physical activity (namely Walking, Running or Cycling) to receive data upon certain physical attributes after performing the said activity. Once the activity is selected using a switch (which also acts as the start-stop switch for the stopwatch clock), simultaneously the sequential block of the circuit is triggered which is used to track the duration of the activity. The inputs of the users are stored in registers which relay the necessary data further to the respective modules.
  To enter the data of a new user, a reset switch is used which resets the stored values of all the registers to zero, since we have used low level trigger registers here. This allows us to change the data as we require for the new user after which we can toggle the reset switch back to zero to calculate the data for the new user.

The following components are used for the implementation of all the modules:
	
>  1) Adder
>  2) Multiplier
>  3) Multiplexer
>  4) Basic logic gates like OR, AND, NOT gates
>  5) Registers
>  6) JK flip flops

The following modules are used in the circuit: 

#### Calorie Counter
This processing unit takes time, type of activity and weight of the person as the input and provides the calories burned by the user while performing the activity. At a time only one activity can be selected. According to the activity selected, the MET(Metabolic Equivalent of Task) data is then further passed in the unit for processing. MET values are 10(1010) for running, 5(0101) for walking and 8(1000) for cycling. The ongoing time, MET and weight are multiplied together using the formula:
				
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

![flowchart](https://github.com/user-attachments/assets/44fb8f55-8d3e-4a9c-a1df-5f3381887972)


#### Functional Table(Sample Cases)
| Seconds | RHR | Weight | Distance | Activity | Reset | Calories (Run) | Calories (Walk) | Calories (Cycle) | THR | Speed |
|:-------:|:---:|:------:|:--------:|:--------:|:-----:|:--------------:|:---------------:|:----------------:|:---:|:-----:|
|000101|0111100|1000110|1100100|100|0|11011010110|0000000000000|0000000000000|01100101|00010100|
|001000|0111100|1000110|1100100|010|0|11011010110|1000110000000|0000000000000|01100001|00000111|
|001010|0111100|1000110|1100100|001|0|11011010110|1000110000000|1101101011000|01100000|00000100|
|000001|0000000|0000000|0000000|000|1|00000000000|0000000000000|0000000000000|01010100|11111111|
</details>

<!-- Fourth Section -->
## Logisim Circuit Diagram
<details>
  <summary>Click here</summary>

#### Main Circuit Diagram
 ![ChronoFit](https://github.com/user-attachments/assets/085a8d99-86e6-448e-b190-dce732be354a)
#### Calorie Calculator Module
![CaloCalc](https://github.com/user-attachments/assets/2359c578-6ed6-4ac1-b910-b31921a7b523)
#### Speed Calculator Module
![SpeedCalc](https://github.com/user-attachments/assets/ce588654-d92e-48d2-866b-88337b47ba6d)
#### Heart Rate Estimator Module
![HRcalc](https://github.com/user-attachments/assets/76bece36-5ec0-45c7-b5df-4b1db718c326)
#### Sequential Module
![Sequential](https://github.com/user-attachments/assets/a9d8659c-8432-4afb-9ce4-52932ae8ffd8)
#### Counter Clock Used in Sequential Module 
![CounterClock](https://github.com/user-attachments/assets/e12adf79-bf0e-4bcf-a6eb-0d6a2fc1a2f0)
#### Multiplier Circuit
![Multiplier](https://github.com/user-attachments/assets/85453ef2-b4f2-4b91-a96b-4427dfe4b022)
#### Divider Circuit
![Divider](https://github.com/user-attachments/assets/885f3152-a40f-4360-981e-adc0051be0a1)
#### Processing Unit used in Divider
![ProcessUnit](https://github.com/user-attachments/assets/e67d0fe7-eec0-4678-aa54-d34cd9491acf)


</details>

<!-- Fifth Section -->
## Verilog Code
<details>
	<summary>Gate Level</summary>
	
	module full_adder(
	    input A, B, Cin,
	    output Sum, Cout
	);
	    wire AxorB, AB_and, AxorB_Cin_and;
	    
	    // Sum calculation: Sum = A ⊕ B ⊕ Cin
	    xor (AxorB, A, B);          // A ⊕ B
	    xor (Sum, AxorB, Cin);      // (A ⊕ B) ⊕ Cin
	
	    // Carry-out calculation: Cout = (A AND B) OR (Cin AND (A ⊕ B))
	    and (AB_and, A, B);                 // A AND B
	    and (AxorB_Cin_and, AxorB, Cin);    // (A ⊕ B) AND Cin
	    or (Cout, AB_and, AxorB_Cin_and);   // (A AND B) OR ((A ⊕ B) AND Cin)
	endmodule
	
	module multiplier_8bit (
	    input [7:0] A, B,
	    output [15:0] product
	);
	    wire [7:0] p0, p1, p2, p3, p4, p5, p6, p7;
	    wire [7:0] s1, s2, s3, s4, s5, s6, s7;
	    wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18;
	
	    // Partial products generation using AND gates
	    and (p0[0], A[0], B[0]); and (p0[1], A[1], B[0]); and (p0[2], A[2], B[0]); and (p0[3], A[3], B[0]);
	    and (p0[4], A[4], B[0]); and (p0[5], A[5], B[0]); and (p0[6], A[6], B[0]); and (p0[7], A[7], B[0]);
	
	    and (p1[0], A[0], B[1]); and (p1[1], A[1], B[1]); and (p1[2], A[2], B[1]); and (p1[3], A[3], B[1]);
	    and (p1[4], A[4], B[1]); and (p1[5], A[5], B[1]); and (p1[6], A[6], B[1]); and (p1[7], A[7], B[1]);
	
	    and (p2[0], A[0], B[2]); and (p2[1], A[1], B[2]); and (p2[2], A[2], B[2]); and (p2[3], A[3], B[2]);
	    and (p2[4], A[4], B[2]); and (p2[5], A[5], B[2]); and (p2[6], A[6], B[2]); and (p2[7], A[7], B[2]);
	
	    and (p3[0], A[0], B[3]); and (p3[1], A[1], B[3]); and (p3[2], A[2], B[3]); and (p3[3], A[3], B[3]);
	    and (p3[4], A[4], B[3]); and (p3[5], A[5], B[3]); and (p3[6], A[6], B[3]); and (p3[7], A[7], B[3]);
	
	    and (p4[0], A[0], B[4]); and (p4[1], A[1], B[4]); and (p4[2], A[2], B[4]); and (p4[3], A[3], B[4]);
	    and (p4[4], A[4], B[4]); and (p4[5], A[5], B[4]); and (p4[6], A[6], B[4]); and (p4[7], A[7], B[4]);
	
	    and (p5[0], A[0], B[5]); and (p5[1], A[1], B[5]); and (p5[2], A[2], B[5]); and (p5[3], A[3], B[5]);
	    and (p5[4], A[4], B[5]); and (p5[5], A[5], B[5]); and (p5[6], A[6], B[5]); and (p5[7], A[7], B[5]);
	
	    and (p6[0], A[0], B[6]); and (p6[1], A[1], B[6]); and (p6[2], A[2], B[6]); and (p6[3], A[3], B[6]);
	    and (p6[4], A[4], B[6]); and (p6[5], A[5], B[6]); and (p6[6], A[6], B[6]); and (p6[7], A[7], B[6]);
	
	    and (p7[0], A[0], B[7]); and (p7[1], A[1], B[7]); and (p7[2], A[2], B[7]); and (p7[3], A[3], B[7]);
	    and (p7[4], A[4], B[7]); and (p7[5], A[5], B[7]); and (p7[6], A[6], B[7]); and (p7[7], A[7], B[7]);
	
	    // Assigning LSB to product
	    assign product[0] = p0[0];
	
	    // Stage 1
	    full_adder fa1 (.A(p0[1]), .B(p1[0]), .Cin(1'b0), .Sum(product[1]), .Cout(c1));
	    full_adder fa2 (.A(p0[2]), .B(p1[1]), .Cin(c1), .Sum(s1[0]), .Cout(c2));
	    full_adder fa3 (.A(p0[3]), .B(p1[2]), .Cin(c2), .Sum(s1[1]), .Cout(c3));
	    full_adder fa4 (.A(p0[4]), .B(p1[3]), .Cin(c3), .Sum(s1[2]), .Cout(c4));
	    full_adder fa5 (.A(p0[5]), .B(p1[4]), .Cin(c4), .Sum(s1[3]), .Cout(c5));
	    full_adder fa6 (.A(p0[6]), .B(p1[5]), .Cin(c5), .Sum(s1[4]), .Cout(c6));
	    full_adder fa7 (.A(p0[7]), .B(p1[6]), .Cin(c6), .Sum(s1[5]), .Cout(c7));
	    full_adder fa8 (.A(1'b0), .B(p1[7]), .Cin(c7), .Sum(s1[6]), .Cout(s1[7]));
	
	        // Stage 2
	    full_adder fa9  (.A(s1[0]), .B(p2[0]), .Cin(1'b0),   .Sum(product[2]), .Cout(c8));
	    full_adder fa10 (.A(s1[1]), .B(p2[1]), .Cin(c8),    .Sum(s2[0]), .Cout(c9));
	    full_adder fa11 (.A(s1[2]), .B(p2[2]), .Cin(c9),    .Sum(s2[1]), .Cout(c10));
	    full_adder fa12 (.A(s1[3]), .B(p2[3]), .Cin(c10),   .Sum(s2[2]), .Cout(c11));
	    full_adder fa13 (.A(s1[4]), .B(p2[4]), .Cin(c11),   .Sum(s2[3]), .Cout(c12));
	    full_adder fa14 (.A(s1[5]), .B(p2[5]), .Cin(c12),   .Sum(s2[4]), .Cout(c13));
	    full_adder fa15 (.A(s1[6]), .B(p2[6]), .Cin(c13),   .Sum(s2[5]), .Cout(c14));
	    full_adder fa16 (.A(s1[7]), .B(p2[7]), .Cin(c14),   .Sum(s2[6]), .Cout(s2[7]));
	
	        // Stage 3
	    full_adder fa17 (.A(s2[0]), .B(p3[0]), .Cin(1'b0),   .Sum(product[3]), .Cout(c15));
	    full_adder fa18 (.A(s2[1]), .B(p3[1]), .Cin(c15),   .Sum(s3[0]), .Cout(c16));
	    full_adder fa19 (.A(s2[2]), .B(p3[2]), .Cin(c16),   .Sum(s3[1]), .Cout(c17));
	    full_adder fa20 (.A(s2[3]), .B(p3[3]), .Cin(c17),   .Sum(s3[2]), .Cout(c18));
	    full_adder fa21 (.A(s2[4]), .B(p3[4]), .Cin(c18),   .Sum(s3[3]), .Cout(c19));
	    full_adder fa22 (.A(s2[5]), .B(p3[5]), .Cin(c19),   .Sum(s3[4]), .Cout(c20));
	    full_adder fa23 (.A(s2[6]), .B(p3[6]), .Cin(c20),   .Sum(s3[5]), .Cout(c21));
	    full_adder fa24 (.A(s2[7]), .B(p3[7]), .Cin(c21),   .Sum(s3[6]), .Cout(s3[7]));
	
	        // Stage 4
	    full_adder fa25 (.A(s3[0]), .B(p4[0]), .Cin(1'b0),   .Sum(product[4]), .Cout(c22));
	    full_adder fa26 (.A(s3[1]), .B(p4[1]), .Cin(c22),   .Sum(s4[0]), .Cout(c23));
	    full_adder fa27 (.A(s3[2]), .B(p4[2]), .Cin(c23),   .Sum(s4[1]), .Cout(c24));
	    full_adder fa28 (.A(s3[3]), .B(p4[3]), .Cin(c24),   .Sum(s4[2]), .Cout(c25));
	    full_adder fa29 (.A(s3[4]), .B(p4[4]), .Cin(c25),   .Sum(s4[3]), .Cout(c26));
	    full_adder fa30 (.A(s3[5]), .B(p4[5]), .Cin(c26),   .Sum(s4[4]), .Cout(c27));
	    full_adder fa31 (.A(s3[6]), .B(p4[6]), .Cin(c27),   .Sum(s4[5]), .Cout(c28));
	    full_adder fa32 (.A(s3[7]), .B(p4[7]), .Cin(c28),   .Sum(s4[6]), .Cout(s4[7]));
	
	        // Stage 5
	    full_adder fa33 (.A(s4[0]), .B(p5[0]), .Cin(1'b0),   .Sum(product[5]), .Cout(c29));
	    full_adder fa34 (.A(s4[1]), .B(p5[1]), .Cin(c29),   .Sum(s5[0]), .Cout(c30));
	    full_adder fa35 (.A(s4[2]), .B(p5[2]), .Cin(c30),   .Sum(s5[1]), .Cout(c31));
	    full_adder fa36 (.A(s4[3]), .B(p5[3]), .Cin(c31),   .Sum(s5[2]), .Cout(c32));
	    full_adder fa37 (.A(s4[4]), .B(p5[4]), .Cin(c32),   .Sum(s5[3]), .Cout(c33));
	    full_adder fa38 (.A(s4[5]), .B(p5[5]), .Cin(c33),   .Sum(s5[4]), .Cout(c34));
	    full_adder fa39 (.A(s4[6]), .B(p5[6]), .Cin(c34),   .Sum(s5[5]), .Cout(c35));
	    full_adder fa40 (.A(s4[7]), .B(p5[7]), .Cin(c35),   .Sum(s5[6]), .Cout(s5[7]));
	
	        // Stage 6
	    full_adder fa41 (.A(s5[0]), .B(p6[0]), .Cin(1'b0),   .Sum(product[6]), .Cout(c36));
	    full_adder fa42 (.A(s5[1]), .B(p6[1]), .Cin(c36),   .Sum(s6[0]), .Cout(c37));
	    full_adder fa43 (.A(s5[2]), .B(p6[2]), .Cin(c37),   .Sum(s6[1]), .Cout(c38));
	    full_adder fa44 (.A(s5[3]), .B(p6[3]), .Cin(c38),   .Sum(s6[2]), .Cout(c39));
	    full_adder fa45 (.A(s5[4]), .B(p6[4]), .Cin(c39),   .Sum(s6[3]), .Cout(c40));
	    full_adder fa46 (.A(s5[5]), .B(p6[5]), .Cin(c40),   .Sum(s6[4]), .Cout(c41));
	    full_adder fa47 (.A(s5[6]), .B(p6[6]), .Cin(c41),   .Sum(s6[5]), .Cout(c42));
	    full_adder fa48 (.A(s5[7]), .B(p6[7]), .Cin(c42),   .Sum(s6[6]), .Cout(s6[7]));
	
	        // Stage 7
	    full_adder fa49 (.A(s6[0]), .B(p7[0]), .Cin(1'b0),   .Sum(product[7]), .Cout(c43));
	    full_adder fa50 (.A(s6[1]), .B(p7[1]), .Cin(c43),   .Sum(product[8]), .Cout(c44));
	    full_adder fa51 (.A(s6[2]), .B(p7[2]), .Cin(c44),   .Sum(product[9]), .Cout(c45));
	    full_adder fa52 (.A(s6[3]), .B(p7[3]), .Cin(c45),   .Sum(product[10]), .Cout(c46));
	    full_adder fa53 (.A(s6[4]), .B(p7[4]), .Cin(c46),   .Sum(product[11]), .Cout(c47));
	    full_adder fa54 (.A(s6[5]), .B(p7[5]), .Cin(c47),   .Sum(product[12]), .Cout(c48));
	    full_adder fa55 (.A(s6[6]), .B(p7[6]), .Cin(c48),   .Sum(product[13]), .Cout(c49));
	    full_adder fa56 (.A(s6[7]), .B(p7[7]), .Cin(c49),   .Sum(product[14]), .Cout(product[15]));
	    
	endmodule
	
	module adder_8bit(
	    input [7:0] A,       // 8-bit input A
	    input [7:0] B,       // 8-bit input B
	    input Cin,           // Carry-in
	    output [7:0] Sum,    // 8-bit Sum output
	    output Cout          // Carry-out
	);
	    wire [7:0] carry;    // Intermediate carries between the stages
	    
	    // First bit addition (least significant bit)
	    full_adder fa0 (
	        .A(A[0]), 
	        .B(B[0]), 
	        .Cin(Cin), 
	        .Sum(Sum[0]), 
	        .Cout(carry[0])
	    );
	    
	    // Remaining bits addition
	    genvar i;
	    generate
	        for (i = 1; i < 8; i = i + 1) begin: full_adder_stage
	            full_adder fa (
	                .A(A[i]), 
	                .B(B[i]), 
	                .Cin(carry[i-1]), 
	                .Sum(Sum[i]), 
	                .Cout(carry[i])
	            );
	        end
	    endgenerate
	
	    // Carry-out of the final adder stage
	    assign Cout = carry[7];
	endmodule
	
	module multiplier_16x8bit (
	    input [15:0] A,        // 16-bit input A (Multiplicand)
	    input [7:0] B,         // 8-bit input B (Multiplier)
	    output reg [23:0] P    // 24-bit product output (16-bit A * 8-bit B)
	);
	
	    always @(*) begin
	        // Perform direct multiplication
	        P = A * B;  // Direct multiplication
	    end
	endmodule
	
	
	module Divider_8bit (
	    input [7:0] A,       // 8-bit numerator (dividend)
	    input [7:0] B,       // 8-bit denominator (divisor)
	    output reg [7:0] Q   // 8-bit quotient
	);
	
	    always @(*) begin
	        // Check for division by zero
	        if (B == 8'b0) begin
	            Q = 8'b0;   // Set quotient to 0 in case of division by zero
	        end else begin
	            // Perform division
	            Q = A / B;  // Quotient
	        end
	    end
	
	endmodule
	
	module fitness_tracker (
	    input wire clk,          // Clock signal
	    input wire rst,          // Reset signal
	    input wire [7:0] RHR,  // 8-bit Resting heart rate
	    input wire [7:0] weight,      // 8-bit Weight input
	    input wire [7:0] age,         // 8-bit Age input
	    input wire [7:0] distance,    // 8-bit Distance input
	    input wire Run,         // Activity 1 button input
	    input wire Walk,         // Activity 2 button input
	    input wire Cycle,         // Activity 3 button input
	    output wire [7:0] seconds_Run, // Time spent on activity 1 (8-bit)
	    output wire [7:0] seconds_Walk, // Time spent on activity 2 (8-bit)
	    output wire [7:0] seconds_Cycle, // Time spent on activity 3 (8-bit)
	    output wire [23:0] calories_Run, // Calories burned in activity 1
	    output wire [23:0] calories_Walk, // Calories burned in activity 2
	    output wire [23:0] calories_Cycle, // Calories burned in activity 3
	    output wire [7:0] speed,       // Speed calculation
	    output wire [7:0] THR    // THR calculation
	);
	
	// Instantiate the stopwatch module to track time for each activity
	fitness_stopwatch stopwatch_inst (
	    .clk(clk),
	    .rst(rst),
	    .RHR(RHR),
	    .weight(weight),
	    .age(age),
	    .distance(distance),
	    .Run(Run),
	    .Walk(Walk),
	    .Cycle(Cycle),
	    .seconds_Run(seconds_Run),
	    .seconds_Walk(seconds_Walk),
	    .seconds_Cycle(seconds_Cycle)
	);
	
	// Instantiate the calorie calculator module to calculate calories burned
	calorie_calculator calorie_calc_inst (
	    .weight(weight),
	    .time_a1(seconds_Run),
	    .time_a2(seconds_Walk),
	    .time_a3(seconds_Cycle),
	    .calories_Run(calories_Run),
	    .calories_Walk(calories_Walk),
	    .calories_Cycle(calories_Cycle)
	);
	
	// Instantiate the speed calculator module to calculate the speed
	speed_calculator speed_calc_inst (
	    .distance(distance),
	    .time_a1(seconds_Run),
	    .time_a2(seconds_Walk),
	    .time_a3(seconds_Cycle),
	    .speed(speed)
	);
	
	// Instantiate the THR calculator module to calculate the THR
	THR_calculator THR_calc_inst (
	    .RHR(RHR),
	    .weight(weight),
	    .speed(speed),
	    .THR(THR)
	);
	
	endmodule
	
	
	// Stopwatch Submodule to track activity time
	module fitness_stopwatch (
	    input wire clk,
	    input wire rst,
	    input wire [7:0] RHR,
	    input wire [7:0] weight,
	    input wire [7:0] age,
	    input wire [7:0] distance,
	    input wire Run,
	    input wire Walk,
	    input wire Cycle,
	    output reg [7:0] seconds_Run,  // Time counter for activity 1
	    output reg [7:0] seconds_Walk,  // Time counter for activity 2
	    output reg [7:0] seconds_Cycle   // Time counter for activity 3
	);
	
	reg [7:0] counter_a1, counter_a2, counter_a3;
	
	always @(posedge clk or posedge rst) begin
	    if (rst) begin
	        counter_a1 <= 8'd0;
	        counter_a2 <= 8'd0;
	        counter_a3 <= 8'd0;
	        seconds_Run <= 8'd0;
	        seconds_Walk <= 8'd0;
	        seconds_Cycle <= 8'd0;
	    end else begin
	        // Activity 1 time tracking
	        if (Run) begin
	            if (counter_a1 < 8'd59)
	                counter_a1 <= counter_a1 + 1;
	            else
	                counter_a1 <= 8'd0;  // Reset counter after 59 seconds
	        end
	        seconds_Run <= counter_a1;
	
	        // Activity 2 time tracking
	        if (Walk) begin
	            if (counter_a2 < 8'd59)
	                counter_a2 <= counter_a2 + 1;
	            else
	                counter_a2 <= 8'd0;
	        end
	        seconds_Walk <= counter_a2;
	
	        // Activity 3 time tracking
	        if (Cycle) begin
	            if (counter_a3 < 8'd59)
	                counter_a3 <= counter_a3 + 1;
	            else
	                counter_a3 <= 8'd0;
	        end
	        seconds_Cycle <= counter_a3;
	    end
	end
	
	endmodule
	
	
	
	module calorie_calculator (
	    input wire [7:0] weight,       // User's weight
	    input wire [7:0] time_a1,      // Time spent on activity 1
	    input wire [7:0] time_a2,      // Time spent on activity 2
	    input wire [7:0] time_a3,      // Time spent on activity 3
	    output reg [23:0] calories_Run, // Calories burned in activity 1
	    output reg [23:0] calories_Walk, // Calories burned in activity 2
	    output reg [23:0] calories_Cycle   // Calories burned in activity 3
	);
	
	    // Constants for calorie calculation, explicitly defined as 8 bits
	    localparam [7:0] constant_a1 = 8'd10;  // Constant for activity 1
	    localparam [7:0] constant_a2 = 8'd5;  // Constant for activity 2
	    localparam [7:0] constant_a3 = 8'd8; // Constant for activity 3
	
	    wire [15:0] weight_time_a1; // Intermediate product for activity 1
	    wire [15:0] weight_time_a2; // Intermediate product for activity 2
	    wire [15:0] weight_time_a3; // Intermediate product for activity 3
	
	    // Instantiate the multipliers for the first stage (8x8 -> 16)
	    multiplier_8bit mult_a1 (
	        .A(weight),          // User's weight
	        .B(constant_a1),    // Activity 1 constant
	        .product(weight_time_a1)   // Output product for activity 1
	    );
	
	    multiplier_8bit mult_a2 (
	        .A(weight),          // User's weight
	        .B(constant_a2),    // Activity 2 constant
	        .product(weight_time_a2)   // Output product for activity 2
	    );
	
	    multiplier_8bit mult_a3 (
	        .A(weight),          // User's weight
	        .B(constant_a3),    // Activity 3 constant
	        .product(weight_time_a3)   // Output product for activity 3
	    );
	
	    // Now instantiate the second stage of multipliers (16x8 -> 24)
	    wire [23:0] final_calories_Run, final_calories_Walk, final_calories_Cycle;
	
	    multiplier_16x8bit final_mult_a1 (
	        .A(weight_time_a1),  // Intermediate product (16 bits)
	        .B(time_a1),         // Time spent on activity 1 (8 bits)
	        .P(final_calories_Run) // Final calories burned in activity 1 (24 bits)
	    );
	
	    multiplier_16x8bit final_mult_a2 (
	        .A(weight_time_a2),  // Intermediate product (16 bits)
	        .B(time_a2),         // Time spent on activity 2 (8 bits)
	        .P(final_calories_Walk) // Final calories burned in activity 2 (24 bits)
	    );
	
	    multiplier_16x8bit final_mult_a3 (
	        .A(weight_time_a3),  // Intermediate product (16 bits)
	        .B(time_a3),         // Time spent on activity 3 (8 bits)
	        .P(final_calories_Cycle) // Final calories burned in activity 3 (24 bits)
	    );
	
	    // Assign the final calories to the outputs
	    always @(*) begin
	        calories_Run = final_calories_Run; // Calories burned in activity 1
	        calories_Walk = final_calories_Walk; // Calories burned in activity 2
	        calories_Cycle = final_calories_Cycle; // Calories burned in activity 3
	    end
	
	endmodule
	
	module speed_calculator (
	    input wire [7:0] distance,    // Distance travelled
	    input wire [7:0] time_a1,     // Time spent on activity 1
	    input wire [7:0] time_a2,     // Time spent on activity 2
	    input wire [7:0] time_a3,     // Time spent on activity 3
	    output reg [7:0] speed        // Calculated speed (distance / time)
	);
	
	    wire [7:0] time_sum_1;  // Intermediate sum of time_a1 + time_a2
	    wire [7:0] total_time;   // Total time (time_sum_1 + time_a3)
	    wire [7:0] final_speed;
	
	    // Instantiate the first adder (time_a1 + time_a2) with carry-in as 0
	    adder_8bit adder1 (
	        .A(time_a1),
	        .B(time_a2),
	        .Cin(1'b0),         // Carry-in set to 0
	        .Sum(time_sum_1),
	        .Cout()             // Unused carry-out
	    );
	
	    // Instantiate the second adder (time_sum_1 + time_a3) with carry-in as 0
	    adder_8bit adder2 (
	        .A(time_sum_1),
	        .B(time_a3),
	        .Cin(1'b0),         // Carry-in set to 0
	        .Sum(total_time),
	        .Cout()             // Unused carry-out
	    );
	
	    Divider_8bit distance_time (
	        .A(distance),
	        .B(total_time),
	        .Q(final_speed)
	    );
	    // Always block to calculate the speed
	    always @(*) begin
	        // Check if total_time is non-zero to avoid division by zero
	        if (total_time > 0) begin
	            speed = final_speed;  // Calculate speed (distance / total_time)
	        end else begin
	            speed = 8'd0;  // Set speed to zero if no time has been recorded
	        end
	    end
	
	endmodule
	
	
	module THR_calculator (
	    input wire [7:0] RHR,   // Resting heart rate
	    input wire [7:0] weight,        // Weight of the user
	    input wire [7:0] speed,         // Speed of the user
	    output reg [7:0] THR      // Calculated THR
	);
	
	    wire [7:0] weight_contribution;
	    wire [7:0] speed_contribution;
	    wire [7:0] weight_speed;
	    wire [7:0] THR_final;
	
	    // Instantiate multiplier for weight contribution
	    Divider_8bit weight_divider (
	        .A(weight),
	        .B(8'd2),
	        .Q(weight_contribution)
	    );
	
	    // Instantiate multiplier for speed contribution
	    Divider_8bit speed_divider (
	        .A(speed),
	        .B(8'd3),
	        .Q(speed_contribution)
	    );
	
	    adder_8bit contributor_adder(
	        .A(weight_contribution),
	        .B(speed_contribution),
	        .Cin(1'b0),         // Carry-in set to 0
	        .Sum(weight_speed),
	        .Cout()  
	    );
	
	    adder_8bit THR_adder(
	        .A(RHR),
	        .B(weight_speed),
	        .Cin(1'b0),         // Carry-in set to 0
	        .Sum(THR_final),
	        .Cout()  
	    );
	    always @(*) begin
	        // Calculate THR using contributions and resting heart rate
	        THR = THR_final;
	    end
	
	endmodule

</details>

<details>
  <summary>DataFlow</summary>
	

	module fitness_tracker (
	    input wire clk,          // Clock signal
	    input wire rst,          // Reset signal
	    input wire [7:0] RHR,  // 8-bit Resting heart rate
	    input wire [7:0] weight,      // 8-bit Weight input
	    input wire [7:0] age,         // 8-bit Age input
	    input wire [7:0] distance,    // 8-bit Distance input
	    input wire Run,         // Activity 1 button input
	    input wire Walk,         // Activity 2 button input
	    input wire Cycle,         // Activity 3 button input
	    output wire [7:0] seconds_Run, // Time spent on activity 1 (8-bit)
	    output wire [7:0] seconds_Walk, // Time spent on activity 2 (8-bit)
	    output wire [7:0] seconds_Cycle, // Time spent on activity 3 (8-bit)
	    output wire [23:0] calories_Run, // Calories burned in activity 1
	    output wire [23:0] calories_Walk, // Calories burned in activity 2
	    output wire [23:0] calories_Cycle, // Calories burned in activity 3
	    output wire [7:0] speed,       // Speed calculation
	    output wire [7:0] THR    // Heartbeat calculation
	);
	
	// Instantiate the stopwatch module to track time for each activity
	fitness_stopwatch stopwatch_inst (
	    .clk(clk),
	    .rst(rst),
	    .RHR(RHR),
	    .weight(weight),
	    .age(age),
	    .distance(distance),
	    .Run(Run),
	    .Walk(Walk),
	    .Cycle(Cycle),
	    .seconds_Run(seconds_Run),
	    .seconds_Walk(seconds_Walk),
	    .seconds_Cycle(seconds_Cycle)
	);
	
	// Instantiate the calorie calculator module to calculate calories burned
	calorie_calculator calorie_calc_inst (
	    .weight(weight),
	    .time_Run(seconds_Run),
	    .time_Walk(seconds_Walk),
	    .time_Cycle(seconds_Cycle),
	    .calories_Run(calories_Run),
	    .calories_Walk(calories_Walk),
	    .calories_Cycle(calories_Cycle)
	);
	
	// Instantiate the speed calculator module to calculate the speed
	speed_calculator speed_calc_inst (
	    .distance(distance),
	    .time_Run(seconds_Run),
	    .time_Walk(seconds_Walk),
	    .time_Cycle(seconds_Cycle),
	    .speed(speed)
	);
	
	// Instantiate the heartbeat calculator module to calculate the heartbeat
	heartbeat_calculator heartbeat_calc_inst (
	    .RHR(RHR),
	    .weight(weight),
	    .speed(speed),
	    .THR(THR)
	);
	
	endmodule
	
	
	// Stopwatch Submodule to track activity time
	module fitness_stopwatch (
	    input wire clk,
	    input wire rst,
	    input wire [7:0] RHR,
	    input wire [7:0] weight,
	    input wire [7:0] age,
	    input wire [7:0] distance,
	    input wire Run,
	    input wire Walk,
	    input wire Cycle,
	    output reg [7:0] seconds_Run,  // Time counter for activity 1
	    output reg [7:0] seconds_Walk,  // Time counter for activity 2
	    output reg [7:0] seconds_Cycle   // Time counter for activity 3
	);
	
	reg [7:0] counter_Run, counter_Walk, counter_Cycle;
	
	always @(posedge clk or posedge rst) begin
	    if (rst) begin
	        counter_Run <= 8'd0;
	        counter_Walk <= 8'd0;
	        counter_Cycle <= 8'd0;
	        seconds_Run <= 8'd0;
	        seconds_Walk <= 8'd0;
	        seconds_Cycle <= 8'd0;
	    end else begin
	        // Activity 1 time tracking
	        if (Run) begin
	            if (counter_Run < 8'd59)
	                counter_Run <= counter_Run + 1;
	            else
	                counter_Run <= 8'd0;  // Reset counter after 59 seconds
	        end
	        seconds_Run <= counter_Run;
	
	        // Activity 2 time tracking
	        if (Walk) begin
	            if (counter_Walk < 8'd59)
	                counter_Walk <= counter_Walk + 1;
	            else
	                counter_Walk <= 8'd0;
	        end
	        seconds_Walk <= counter_Walk;
	
	        // Activity 3 time tracking
	        if (Cycle) begin
	            if (counter_Cycle < 8'd59)
	                counter_Cycle <= counter_Cycle + 1;
	            else
	                counter_Cycle <= 8'd0;
	        end
	        seconds_Cycle <= counter_Cycle;
	    end
	end
	
	endmodule
	
	
	// Calorie Calculator Submodule
	module calorie_calculator (
	    input wire [7:0] weight,       // User's weight
	    input wire [7:0] time_Run,      // Time spent on activity 1
	    input wire [7:0] time_Walk,      // Time spent on activity 2
	    input wire [7:0] time_Cycle,      // Time spent on activity 3
	    output reg [23:0] calories_Run, // Calories burned in activity 1
	    output reg [23:0] calories_Walk, // Calories burned in activity 2
	    output reg [23:0] calories_Cycle  // Calories burned in activity 3
	);
	
	// Constants for calorie calculation
	localparam MET_Run = 5;
	localparam MET_Walk = 8;
	localparam MET_Cycle = 10;
	
	always @(*) begin
	    // Calorie calculation for each activity
	    calories_Run = MET_Run * weight * time_Run;
	    calories_Walk = MET_Walk * weight * time_Walk;
	    calories_Cycle = MET_Cycle * weight * time_Cycle;
	end
	
	endmodule
	
	
	// Speed Calculator Submodule
	module speed_calculator (
	    input wire [7:0] distance,    // Distance travelled
	    input wire [7:0] time_Run,     // Time spent on activity 1
	    input wire [7:0] time_Walk,     // Time spent on activity 2
	    input wire [7:0] time_Cycle,     // Time spent on activity 3
	    output reg [7:0] speed       // Calculated speed (distance / time)
	);
	
	reg [7:0] total_time;  // Total time spent across all activities
	
	always @(*) begin
	    total_time = time_Run + time_Walk + time_Cycle;  // Total time spent in all activities
	    
	    // Check if total_time is non-zero to avoid division by zero
	    if (total_time > 0) begin
	        speed = distance / total_time;  // Calculate speed (distance/time)
	    end else begin
	        speed = 7'd0;  // Set speed to zero if no time has been recorded
	    end
	end
	
	endmodule
	
	
	// Heartbeat Calculator Submodule
	module heartbeat_calculator (
	    input wire [7:0] RHR,   // Resting heart rate
	    input wire [7:0] weight,       // Weight of the user
	    input wire [7:0] speed,       // Speed of the user
	    output reg [7:0] THR    // Calculated heartbeat
	);
	
	// Fixed-point multiplication constants for weight and speed contributions
	localparam weight_factor = 5;  // Approximation for 0.5 * weight (scaled up by 10)
	localparam speed_factor = 3;   // Approximation for 0.3 * speed (scaled up by 10)
	
	always @(*) begin
	    // Heartbeat calculation: hr_resting + (0.5 * weight) + (0.3 * speed)
	    THR = RHR + (weight * weight_factor) / 10 + (speed * speed_factor) / 10;
	end
	
	endmodule

</details>
<details>
	<summary>Testbench</summary>

	module tb_fitness_tracker;

	// Inputs
	reg clk;
	reg rst;
	reg [7:0] RHR;
	reg [7:0] weight;
	reg [7:0] age;
	reg [7:0] distance;
	reg Run;
	reg Walk;
	reg Cycle;
	
	// Outputs
	wire [7:0] seconds_Run;
	wire [7:0] seconds_Walk;
	wire [7:0] seconds_Cycle;
	wire [23:0] calories_Run;
	wire [23:0] calories_Walk;
	wire [23:0] calories_Cycle;
	wire [7:0] speed;
	wire [7:0] THR;
	
	// Instantiate the Unit Under Test (UUT)
	fitness_tracker uut (
	    .clk(clk),
	    .rst(rst),
	    .RHR(RHR),
	    .weight(weight),
	    .age(age),
	    .distance(distance),
	    .Run(Run),
	    .Walk(Walk),
	    .Cycle(Cycle),
	    .seconds_Run(seconds_Run),
	    .seconds_Walk(seconds_Walk),
	    .seconds_Cycle(seconds_Cycle),
	    .calories_Run(calories_Run),
	    .calories_Walk(calories_Walk),
	    .calories_Cycle(calories_Cycle),
	    .speed(speed),
	    .THR(THR)
	);
	
	// Clock generation
	always #10 clk = ~clk;
	
	initial begin
	    // Initialize Inputs
	    clk = 0;
	    rst = 1;
	    RHR = 8'd60;  // Initial heart rate
	    weight = 8'd70;      // Weight in kg
	    distance = 8'd100;   // Distance in meters
	    Run = 0;
	    Walk = 0;
	    Cycle = 0;
	
	    // Reset the system
	    #10 rst = 0;
	
	    // Test case 1
	    #20 Run = 1;
	    #100 Run = 0;
	
	    // Test case 2
	    #20 Walk = 1;
	    #150 Walk = 0;
	
	    // Test case 3
	    #20 Cycle = 1;
	    #200 Cycle = 0;
	
	
	    #20 $display("Average Speed:%d m/s", distance/(seconds_Run+seconds_Walk+seconds_Cycle));
	    #20 $display("Total Time: %d sec", (seconds_Run+seconds_Walk+seconds_Cycle));
	    // End simulation after testing
	    #100 $finish;
	end
	
	// Monitor output for stopwatch, calorie calculation, speed, and THR
	
	initial begin
	    $monitor("Time: %0t | Run: %b | Walk: %b | Cycle: %b | Sec_Run: %d | calories_Run: %d | Sec_Walk: %d | calories_Walk: %d | Sec_Cycle: %d | calories_Cycle: %d | Speed: %d | THR: %d", 
	             $time, Run, Walk, Cycle, seconds_Run, calories_Run, seconds_Walk, calories_Walk, seconds_Cycle, calories_Cycle, speed, THR);
	end
	
	endmodule
</details>
<details>
	<summary>Output</summary>
<img width="966" alt="Screenshot 2024-10-16 at 10 37 52 PM" src="https://github.com/user-attachments/assets/aec71b03-1d40-4ef2-9aca-fb1f976d99b9">
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



