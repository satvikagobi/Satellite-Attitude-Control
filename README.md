# Satellite-Attitude-Control
PID-based satellite attitude control using MATLAB Simulink, Verilog HDL, and ModelSim.
# Simulation and Digital Implementation of a PID-Based Satellite Attitude Control System

## Abstract

This project presents the design and simulation of a **single-axis satellite attitude control system** using a PID controller and a reaction-wheel actuator. The system was developed using **MATLAB Simulink** for spacecraft-level modeling and **Verilog HDL with ModelSim** for digital controller implementation and verification.

The Simulink model includes attitude dynamics, reaction-wheel dynamics, actuator limitations, disturbances, sensor noise, actuator faults, and fault detection. The Verilog implementation provides the digital control logic along with torque limiting, PWM generation, and direction control.

---

## 2. Objectives

The main objectives are to:

* Develop a closed-loop satellite attitude-control system.
* Control satellite orientation using a PID controller.
* Model a reaction wheel as the actuator.
* Analyze the effect of disturbances and sensor noise.
* Simulate actuator faults and detect them.
* Test the controller with changing attitude commands.
* Implement and verify the digital controller using Verilog and ModelSim.

---

## 3. System Concept

The system follows a closed-loop feedback structure:

**Desired Attitude → Error Calculation → PID Controller → Control Torque → Reaction Wheel → Satellite Dynamics → Measured Attitude → Feedback**

The controller continuously compares the desired and actual attitude and generates the required control torque.

The reaction wheel changes the spacecraft attitude through the principle of **conservation of angular momentum**.

---

## 4. MATLAB Simulink Implementation

MATLAB Simulink was used to model the complete satellite control system.

The model contains the PID controller, reaction-wheel dynamics, actuator dynamics, torque saturation, sensor model, gyroscope measurement, disturbance input, actuator fault, and fault-detection mechanism.

The desired attitude was also made variable during the simulation:

**0° → 20° → −10° → 30° → 20°**

This was used to evaluate the controller's tracking response under different commands.

A first-order actuator model was included to represent the non-instantaneous response of a practical reaction wheel.

---

## 5. Actuator Fault Detection

An actuator fault was introduced by reducing the available actuator torque.

The commanded torque was compared with the actual actuator output. When the difference exceeded a predefined threshold, the fault detector generated a logic **1**, confirming fault detection.

This adds basic fault-monitoring capability to the attitude-control system.

---

## 6. Verilog HDL Implementation

The digital controller was implemented using Verilog HDL.

The main modules include:

* `pd_controller.v`
* `pwm_generator.v`
* `satellite_attitude_controller.v`

Testbench files were also created for functional verification.

The digital controller calculates the control torque from attitude error and angular velocity. The output is limited to the specified torque range and is used to generate PWM and direction signals.

---

## 7. ModelSim Verification

ModelSim was used to independently verify the Verilog implementation.

The testbench applies different desired-angle, actual-angle, and angular-velocity conditions. The resulting **control torque, PWM, and direction** signals are observed using ModelSim waveforms.

The simulations confirm that the controller produces the appropriate positive or negative torque depending on the attitude error and that the torque remains within the defined limits.

Direct Simulink–ModelSim co-simulation was investigated, but the installed **ModelSim Intel FPGA Starter Edition** does not provide the required FLI support. Therefore, both implementations were verified separately.

---

## 8. Performance Results

The final simulation produced approximately:

* **Desired final attitude:** 20°
* **Final actual attitude:** 21.30°
* **Steady-state error:** 1.30°
* **RMS tracking error:** 17.32°
* **Maximum overshoot:** 90.56%

The relatively high overshoot occurs mainly because of the large changes in the commanded attitude.

---

## 9. Conclusion

The project successfully demonstrates a satellite attitude-control system using **PID feedback and reaction-wheel actuation**.

Simulink was used for spacecraft-level modeling and analysis, while Verilog and ModelSim were used for digital controller implementation and verification. The inclusion of actuator dynamics, disturbances, sensor noise, and fault detection makes the system more representative of a practical control application.

The project provides a foundation for future development toward **three-axis attitude control, multiple reaction wheels, FPGA implementation, and more advanced spacecraft control techniques**.
