`timescale 1ns/1ps

module pd_controller_tb;

    reg clk;
    reg reset;

    reg signed [15:0] desired_angle;
    reg signed [15:0] actual_angle;
    reg signed [15:0] angular_velocity;

    wire signed [31:0] control_torque;

    pd_controller uut (
        .clk(clk),
        .reset(reset),
        .desired_angle(desired_angle),
        .actual_angle(actual_angle),
        .angular_velocity(angular_velocity),
        .control_torque(control_torque)
    );

    // Clock: 10 ns period
    always #5 clk = ~clk;

    initial begin

        clk = 0;
        reset = 1;

        desired_angle = 0;
        actual_angle = 0;
        angular_velocity = 0;

        #10;

        reset = 0;

        // Test 1
        desired_angle = 20;
        actual_angle = 0;
        angular_velocity = 0;
        #10;
        $display("Test 1: Torque = %d", control_torque);

        // Test 2
        actual_angle = 10;
        angular_velocity = 2;
        #10;
        $display("Test 2: Torque = %d", control_torque);

        // Test 3
        actual_angle = 20;
        angular_velocity = 0;
        #10;
        $display("Test 3: Torque = %d", control_torque);

        // Test 4
        actual_angle = 25;
        angular_velocity = 3;
        #10;
        $display("Test 4: Torque = %d", control_torque);

        $finish;

    end

endmodule