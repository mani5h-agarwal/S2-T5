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