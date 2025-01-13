# Basic Computer Simulation in VHDL  
A VHDL simulation model of a **common bus system** based on the architecture described in Morris Mano's "Computer System Architecture." This project simulates the functionality of a basic hard-wired computer, including components such as the ALU, RAM, AR, DR, and more.  

---

## 📖 Overview  
This project demonstrates the simulation of a basic computer architecture that utilizes a common bus system. The design is inspired by the structure outlined in Morris Mano's textbook and is implemented in VHDL for educational and demonstration purposes.  

Key components of the project:  
- **Arithmetic Logic Unit (ALU):** Performs arithmetic and logical operations.  
- **Registers (AR, DR, etc.):** Used for intermediate storage and operations.  
- **RAM:** Stores instructions and data.  
- **Control Logic:** Implements hard-wired control for instruction execution.  
- **Common Bus:** Facilitates data transfer between components.  

---

## 🚀 Features  
- **Simulated common bus architecture** to connect all components.  
- Hard-wired control logic for instruction execution.  
- Modular design for components like ALU, RAM, and registers.  
- Fully implemented in VHDL for simulation in ModelSim or similar tools.  
- Customizable and extendable for additional functionality.  

---

## 🛠 Project Structure  
The project consists of the following files and components:

# Basic Computer Simulation in VHDL  
A VHDL simulation model of a **common bus system** based on the architecture described in Morris Mano's "Computer System Architecture." This project simulates the functionality of a basic hard-wired computer, including components such as the ALU, RAM, AR, DR, and more.  

---

## 📖 Overview  
This project demonstrates the simulation of a basic computer architecture that utilizes a common bus system. The design is inspired by the structure outlined in Morris Mano's textbook and is implemented in VHDL for educational and demonstration purposes.  

Key components of the project:  
- **Arithmetic Logic Unit (ALU):** Performs arithmetic and logical operations.  
- **Registers (AR, DR, etc.):** Used for intermediate storage and operations.  
- **RAM:** Stores instructions and data.  
- **Control Logic:** Implements hard-wired control for instruction execution.  
- **Common Bus:** Facilitates data transfer between components.  

---

## 🚀 Features  
- **Simulated common bus architecture** to connect all components.  
- Hard-wired control logic for instruction execution.  
- Modular design for components like ALU, RAM, and registers.  
- Fully implemented in VHDL for simulation in ModelSim or similar tools.  
- Customizable and extendable for additional functionality.  

---

## 🛠 Project Structure  
The project consists of the following files and components:

- **`alu_block.vhd`**: Implements the Arithmetic Logic Unit (ALU), responsible for performing arithmetic and logical operations.  
- **`control_unit.vhd`**: Contains the control logic for managing the instruction cycle and directing data flow between components.  
- **`index.vhd`**: Handles component instantiation and interconnection for the simulation model.  
- **`memoryunite.vhd`**: Implements the RAM, which stores instructions and data for the basic computer.  
- **`reg_controller.vhd`**: Manages the control and interaction of various registers in the system.  
- **`registerunit.vhd`**: Implements the register units (e.g., AR, DR) for intermediate data storage and processing.  
- **`README.md`**: The project documentation.

