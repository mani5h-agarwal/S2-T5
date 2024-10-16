module fitness_tracker (
    input wire clk,          // Clock signal
    input wire rst,          // Reset signal
    input wire [7:0] RHR,  // 7-bit Resting heart rate
    input wire [7:0] weight,      // 7-bit Weight input
    input wire [7:0] age,         // 7-bit Age input
    input wire [7:0] distance,    // 8-bit Distance input
    input wire Run,         // Activity 1 button input
    input wire Walk,         // Activity 2 button input
    input wire Cycle,         // Activity 3 button input
    output wire [7:0] seconds_Run, // Time spent on activity 1 (6-bit)
    output wire [7:0] seconds_Walk, // Time spent on activity 2 (6-bit)
    output wire [7:0] seconds_Cycle, // Time spent on activity 3 (6-bit)
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