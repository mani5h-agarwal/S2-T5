// module adder_8bit(
//     input [7:0] A,       // 8-bit input A
//     input [7:0] B,       // 8-bit input B
//     input Cin,           // Carry-in
//     output [7:0] Sum,    // 8-bit Sum output
//     output Cout          // Carry-out
// );
//     wire [7:0] carry;    // Intermediate carries between the stages

//     // First bit addition (least significant bit) using gate-level full adder
//     full_adder fa0 (
//         .A(A[0]), 
//         .B(B[0]), 
//         .Cin(Cin), 
//         .Sum(Sum[0]), 
//         .Cout(carry[0])
//     );

//     // Remaining bits addition using gate-level full adder
//     genvar i;
//     generate
//         for (i = 1; i < 8; i = i + 1) begin: full_adder_stage
//             full_adder fa (
//                 .A(A[i]), 
//                 .B(B[i]), 
//                 .Cin(carry[i-1]), 
//                 .Sum(Sum[i]), 
//                 .Cout(carry[i])
//             );
//         end
//     endgenerate

//     // Carry-out of the final adder stage
//     assign Cout = carry[7];
// endmodule

// module full_adder(
//     input A, B, Cin,
//     output Sum, Cout
// );
//     wire AxorB, AB_and, AxorB_Cin_and;
    
//     // Sum calculation: Sum = A ⊕ B ⊕ Cin
//     xor (AxorB, A, B);          // A ⊕ B
//     xor (Sum, AxorB, Cin);      // (A ⊕ B) ⊕ Cin

//     // Carry-out calculation: Cout = (A AND B) OR (Cin AND (A ⊕ B))
//     and (AB_and, A, B);                 // A AND B
//     and (AxorB_Cin_and, AxorB, Cin);    // (A ⊕ B) AND Cin
//     or (Cout, AB_and, AxorB_Cin_and);   // (A AND B) OR ((A ⊕ B) AND Cin)
// endmodule



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

module full_adder(
    input A, 
    input B, 
    input Cin, 
    output Sum, 
    output Cout
);
    assign Sum = A ^ B ^ Cin;  // Sum is XOR of A, B, and Cin
    assign Cout = (A & B) | (Cin & (A ^ B));  // Carry-out logic
endmodule


module multiplier_8bit (
    input [7:0] A,        // 8-bit input A (Multiplicand)
    input [7:0] B,        // 8-bit input B (Multiplier)
    output reg [15:0] P   // 16-bit product output
);

    always @(*) begin
        // Perform direct multiplication
        P = A * B;  // Direct multiplication
    end
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
    localparam [7:0] constant_a1 = 8'd5;  // Constant for activity 1
    localparam [7:0] constant_a2 = 8'd8;  // Constant for activity 2
    localparam [7:0] constant_a3 = 8'd10; // Constant for activity 3

    wire [15:0] weight_time_a1; // Intermediate product for activity 1
    wire [15:0] weight_time_a2; // Intermediate product for activity 2
    wire [15:0] weight_time_a3; // Intermediate product for activity 3

    // Instantiate the multipliers for the first stage (8x8 -> 16)
    multiplier_8bit mult_a1 (
        .A(weight),          // User's weight
        .B(constant_a1),    // Activity 1 constant
        .P(weight_time_a1)   // Output product for activity 1
    );

    multiplier_8bit mult_a2 (
        .A(weight),          // User's weight
        .B(constant_a2),    // Activity 2 constant
        .P(weight_time_a2)   // Output product for activity 2
    );

    multiplier_8bit mult_a3 (
        .A(weight),          // User's weight
        .B(constant_a3),    // Activity 3 constant
        .P(weight_time_a3)   // Output product for activity 3
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

// Include the full adder and adder modules here or ensure they are accessible

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
