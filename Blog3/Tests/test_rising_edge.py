import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from cocotb.types import LogicArray
from cocotb.triggers import Timer, RisingEdge, ReadOnly, NextTimeStep, FallingEdge

@cocotb.test()
async def test_rising_edge(dut):

    clock = Clock(dut.clk, 1, units="ns")
    cocotb.start_soon(clock.start(start_high=False))
    dut.reset = 0
    dut.level = 0
    await Timer(10,'ns')
    # Assert initial output is unknown
    dut.level = 1
    await Timer(10,'ns')