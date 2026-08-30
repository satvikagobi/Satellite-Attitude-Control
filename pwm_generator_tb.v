`timescale 1ns/1ps

module pwm_generator_tb;

    reg clk;
    reg reset;
    reg signed [31:0] control_torque;

    wire pwm;
    wire direction;

    pwm_generator uut (
        .clk(clk),
        .reset(reset),
        .control_torque(control_torque),
        .pwm(pwm),
        .direction(direction)
    );

    always #5 clk = ~clk;

    initial begin

        clk = 0;
        reset = 1;
        control_torque = 0;

        #20;
        reset = 0;

        // Test 1: Positive torque
        control_torque = 100;
        #2560;

        // Test 2: Negative torque
        control_torque = -100;
        #2560;

        // Test 3: Large positive torque
        control_torque = 500;
        #2560;

        // Test 4: Zero torque
        control_torque = 0;
        #2560;

        $finish;

    end

endmodule