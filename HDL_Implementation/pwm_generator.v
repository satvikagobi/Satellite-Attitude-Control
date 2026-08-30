module pwm_generator (
    input clk,
    input reset,
    input signed [31:0] control_torque,

    output reg pwm,
    output reg direction
);

    reg [7:0] counter;
    reg [7:0] duty_cycle;

    always @(posedge clk) begin

        if (reset) begin
            counter <= 0;
            duty_cycle <= 0;
            pwm <= 0;
            direction <= 0;
        end

        else begin

            // Direction
            if (control_torque >= 0)
                direction <= 1;
            else
                direction <= 0;

            // Magnitude of torque
            if (control_torque < 0)
                duty_cycle <= (-control_torque > 255) ? 255 : -control_torque;
            else
                duty_cycle <= (control_torque > 255) ? 255 : control_torque;

            // PWM counter
            counter <= counter + 1;

            if (counter < duty_cycle)
                pwm <= 1;
            else
                pwm <= 0;

        end
    end

endmodule
