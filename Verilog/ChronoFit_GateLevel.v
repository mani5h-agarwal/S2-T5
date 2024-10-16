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
