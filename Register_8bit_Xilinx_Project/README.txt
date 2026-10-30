XILINX ISE 14.7 - REGISTER AND 8-BIT ALU PROJECT

PROJECT FILE
  Register_8bit.xise

HOW TO OPEN
1. Extract this complete ZIP inside the Windows guest OS where Xilinx ISE 14.7 is installed.
2. Open Xilinx ISE Project Navigator.
3. Choose File > Open Project and select Register_8bit.xise.
4. The project contains two independent designs: register_8bit and alu_8bit.

LT #3 / 8-BIT REGISTER
  Design source: reg_8bit.vhd
  Testbench:     reg_8bit_tb.vhd
  To synthesize or view its RTL schematic, select register_8bit in the Hierarchy pane.
  To simulate, change Sources view to Simulation and select register_8bit_tb.

LT #4 / 8-BIT ALU (ADDED)
  Design source: alu_8bit.vhd
  Testbench:     alu_8bit_tb.vhd
  To synthesize or view its RTL schematic, select alu_8bit in the Hierarchy pane,
  right-click and choose Set as Top Module if needed, then run Synthesize - XST.
  To simulate, change Sources view to Simulation and select alu_8bit_tb,
  then run Simulate Behavioral Model in the Processes pane.

ALU INTERFACE
  A, B       : 8-bit operands
  OP         : 4-bit operation selector
  RESULT     : 8-bit result
  CARRY_OUT  : carry for addition; for subtraction, 1 means no borrow.

ALU OPERATION TABLE
  OP     Operation    Meaning
  0000   ADD          RESULT = A + B; CARRY_OUT = carry bit
  0001   SUB          RESULT = A - B; CARRY_OUT = 1 when A >= B
  0010   AND          bitwise A AND B
  0011   OR           bitwise A OR B
  0100   XOR          bitwise A XOR B
  0101   NOT          bitwise NOT A
  0110   NAND         bitwise A NAND B
  0111   NOR          bitwise A NOR B
  1000   XNOR         bitwise A XNOR B
  Other  DEFAULT      RESULT = 0, CARRY_OUT = 0

SIMULATION EXPECTATION
  The ALU testbench checks arithmetic, carry/borrow behavior, all logic functions,
  and an unsupported operation code. After Run All, ISim should print:
  PASS: alu_8bit testbench completed
  This is the expected testbench message; capture your own ISE/ISim output after running it.

ORIGINAL REGISTER BEHAVIOR
  Synchronous active-high RESET clears Q. Otherwise LOAD=1 captures D on the
  rising clock edge; LOAD=0 holds the previous value. RESET has priority over LOAD.

TARGET DEVICE
  The supplied project metadata remains configured for Spartan-6 xc6slx4-3tqg144.
  If that device is unavailable in your ISE installation, adjust the project device.

IMPORTANT
  Keep the folder structure intact and open the .xise project. No generated ISE
  screenshots or fabricated simulation results are included in this ZIP.
