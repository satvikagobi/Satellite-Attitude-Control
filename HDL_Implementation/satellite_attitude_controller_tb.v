`timescale 1ns/1ps

module satellite_attitude_controller_tb;

    reg clk;
    reg reset;

    reg signed [15:0] desired_angle;
    reg signed [15:0] actual_angle;
    reg signed [15:0] angular_velocity;

    wire signed [31:0] control_torque;
    wire pwm;
    wire direction;

    satellite_attitude_controller uut (
        .clk(clk),
        .reset(reset),
        .desired_angle(desired_angle),
        .actual_angle(actual_angle),
        .angular_velocity(angular_velocity),
        .control_torque(control_torque),
        .pwm(pwm),
        .direction(direction)
    );

    always #5 clk = ~clk;

    task reset_controller;
    begin
        reset = 1;
        #20;
        reset = 0;
        #20;
    end
    endtask

    initial begin

        clk = 0;
        reset = 1;

        desired_angle = 20;
        actual_angle = 20;
        angular_velocity = 0;

        #20;
        reset = 0;

        // TEST 1
        reset_controller;

        actual_angle = 20;
        angular_velocity = 0;

        #20;

        $display("Test 1: Actual=%d Velocity=%d Torque=%d PWM=%b Direction=%b",
                 actual_angle, angular_velocity,
                 control_torque, pwm, direction);


        // TEST 2
        reset_controller;

        actual_angle = 19;
        angular_velocity = 1;

        #20;

        $display("Test 2: Actual=%d Velocity=%d Torque=%d PWM=%b Direction=%b",
                 actual_angle, angular_velocity,
                 control_torque, pwm, direction);


        // TEST 3
        reset_controller;

        actual_angle = 19;
        angular_velocity = -1;

        #20;

        $display("Test 3: Actual=%d Velocity=%d Torque=%d PWM=%b Direction=%b",
                 actual_angle, angular_velocity,
                 control_torque, pwm, direction);


        // TEST 4
        reset_controller;

        actual_angle = 21;
        angular_velocity = -1;

        #20;

        $display("Test 4: Actual=%d Velocity=%d Torque=%d PWM=%b Direction=%b",
                 actual_angle, angular_velocity,
                 control_torque, pwm, direction);


        // TEST 5
        reset_controller;

        actual_angle = 21;
        angular_velocity = 1;

        #20;

        $display("Test 5: Actual=%d Velocity=%d Torque=%d PWM=%b Direction=%b",
                 actual_angle, angular_velocity,
                 control_torque, pwm, direction);


        #20;

        $finish;

    end

endmodule
