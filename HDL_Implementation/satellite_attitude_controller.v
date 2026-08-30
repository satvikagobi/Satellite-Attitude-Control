module satellite_attitude_controller (
    input clk,
    input reset,

    input signed [15:0] desired_angle,
    input signed [15:0] actual_angle,
    input signed [15:0] angular_velocity,

    output signed [31:0] control_torque,
    output pwm,
    output direction
);

    // PD controller
    pd_controller pd_inst (
        .clk(clk),
        .reset(reset),
        .desired_angle(desired_angle),
        .actual_angle(actual_angle),
        .angular_velocity(angular_velocity),
        .control_torque(control_torque)
    );

    // PWM generator
    pwm_generator pwm_inst (
        .clk(clk),
        .reset(reset),
        .control_torque(control_torque),
        .pwm(pwm),
        .direction(direction)
    );

endmodule
