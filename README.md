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
</details>

<details>
  <summary>Behavioral</summary>
	

	
	module fitness_tracker (
	    input wire clk,          // Clock signal
	    input wire rst,          // Reset signal
	    input wire [6:0] RHR,  // 7-bit Resting heart rate
	    input wire [6:0] weight,      // 7-bit Weight input
	    input wire [6:0] age,         // 7-bit Age input
	    input wire [7:0] distance,    // 8-bit Distance input
	    input wire Run,         // Activity 1 button input
	    input wire Walk,         // Activity 2 button input
	    input wire Cycle,         // Activity 3 button input
	    output wire [5:0] seconds_Run, // Time spent on activity 1 (6-bit)
	    output wire [5:0] seconds_Walk, // Time spent on activity 2 (6-bit)
	    output wire [5:0] seconds_Cycle, // Time spent on activity 3 (6-bit)
	    output wire [15:0] calories_Run, // Calories burned in activity 1
	    output wire [15:0] calories_Walk, // Calories burned in activity 2
	    output wire [15:0] calories_Cycle, // Calories burned in activity 3
	    output wire [15:0] speed,       // Speed calculation
	    output wire [15:0] THR    // Heartbeat calculation
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
	    input wire [6:0] RHR,
	    input wire [6:0] weight,
	    input wire [6:0] age,
	    input wire [7:0] distance,
	    input wire Run,
	    input wire Walk,
	    input wire Cycle,
	    output reg [5:0] seconds_Run,  // Time counter for activity 1
	    output reg [5:0] seconds_Walk,  // Time counter for activity 2
	    output reg [5:0] seconds_Cycle   // Time counter for activity 3
	);

	reg [5:0] counter_Run, counter_Walk, counter_Cycle;
	
	always @(posedge clk or posedge rst) begin
	    if (rst) begin
	        counter_Run <= 6'd0;
	        counter_Walk <= 6'd0;
	        counter_Cycle <= 6'd0;
	        seconds_Run <= 6'd0;
	        seconds_Walk <= 6'd0;
	        seconds_Cycle <= 6'd0;
	    end else begin
	        // Activity 1 time tracking
	        if (Run) begin
	            if (counter_Run < 6'd59)
	                counter_Run <= counter_Run + 1;
	            else
	                counter_Run <= 6'd0;  // Reset counter after 59 seconds
	        end
	        seconds_a1 <= counter_a1;

	        // Activity 2 time tracking
	        if (Walk) begin
	            if (counter_a2 < 6'd59)
	                counter_Walk <= counter_Walk + 1;
	            else
	                counter_Walk <= 6'd0;
	        end
	        seconds_Walk <= counter_Walk;

	        // Activity 3 time tracking
	        if (Cycle) begin
	            if (counter_Cycle < 6'd59)
	                counter_Cycle <= counter_Cycle + 1;
	            else
	                counter_Cycle <= 6'd0;
	        end
	        seconds_Cycle <= counter_Cycle;
	    end
	end
	
	endmodule


	// Calorie Calculator Submodule
	module calorie_calculator (
	    input wire [6:0] weight,       // User's weight
	    input wire [5:0] time_Run,      // Time spent on activity 1
	    input wire [5:0] time_Walk,      // Time spent on activity 2
	    input wire [5:0] time_Cycle,      // Time spent on activity 3
	    output reg [15:0] calories_Run, // Calories burned in activity 1
	    output reg [15:0] calories_Walk, // Calories burned in activity 2
	    output reg [15:0] calories_Cycle  // Calories burned in activity 3
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
	    input wire [5:0] time_Run,     // Time spent on activity 1
	    input wire [5:0] time_Walk,     // Time spent on activity 2
	    input wire [5:0] time_Cycle,     // Time spent on activity 3
	    output reg [15:0] speed       // Calculated speed (distance / time)
	);

	reg [5:0] total_time;  // Total time spent across all activities

	always @(*) begin
	    total_time = time_Run + time_Walk + time_Cycle;  // Total time spent in all activities
	    
	    // Check if total_time is non-zero to avoid division by zero
	    if (total_time > 0) begin
	        speed = distance / total_time;  // Calculate speed (distance/time)
	    end else begin
	        speed = 16'd0;  // Set speed to zero if no time has been recorded
	    end
	end

	endmodule


	// Heartbeat Calculator Submodule
	module heartbeat_calculator (
	    input wire [6:0] RHR,   // Resting heart rate
	    input wire [6:0] weight,       // Weight of the user
	    input wire [15:0] speed,       // Speed of the user
	    output reg [15:0] THR    // Calculated heartbeat
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
	
	    // Test case 1: Start activity 1 for 10 seconds
	    #20 Run = 1;
	    #100 Run = 0;  // Simulate activity 1 for 10 seconds
	
	    // Test case 2: Start activity 2 for 15 seconds
	    #20 Walk = 1;
	    #150 Walk = 0;  // Simulate activity 2 for 15 seconds
	
	    // Test case 3: Start activity 3 for 20 seconds
	    #20 Cycle = 1;
	    #200 Cycle = 0;  // Simulate activity 3 for 20 seconds
	
	
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



