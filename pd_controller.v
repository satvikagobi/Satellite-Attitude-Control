module pd_controller (
    input clk,
    input reset,

    input signed [15:0] desired_angle,
    input signed [15:0] actual_angle,
    input signed [15:0] angular_velocity,

    output reg signed [31:0] control_torque
);

    parameter KP = 10;
    parameter KI = 1;
    parameter KD = 6;

    reg signed [15:0] angle_error;
    reg signed [31:0] integral_error;

    reg signed [31:0] p_term;
    reg signed [31:0] i_term;
    reg signed [31:0] d_term;
    reg signed [31:0] torque;

    always @(posedge clk) begin

        if (reset) begin
            control_torque <= 0;
            integral_error <= 0;
        end

        else begin

            // Calculate angle error
            angle_error = desired_angle - actual_angle;

            // Integral of error
            integral_error <= integral_error + angle_error;

            // PID terms
            p_term = KP * angle_error;
            i_term = KI * integral_error;
            d_term = KD * angular_velocity;

            // Calculate control torque
            torque = p_term + i_term - d_term;

            // Torque saturation
            if (torque > 10)
                control_torque <= 10;
            else if (torque < -10)
                control_torque <= -10;
            else
                control_torque <= torque;

        end

    end

endmodule