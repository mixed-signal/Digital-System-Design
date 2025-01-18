import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from cocotb.types import LogicArray
from cocotb.triggers import Timer, RisingEdge, ReadOnly, NextTimeStep, FallingEdge

@cocotb.test()
async def test_debounce(dut):

    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start(start_high=False))
    dut.reset = 1
    dut.sw = 0
    await Timer(11,'ns')
    dut.reset = 0
    await Timer(11,'ns')
    dut.sw = 1
    await Timer(11,'ns')
    dut.sw = 0
    await Timer(11,'ns')
    # Assert initial output is unknown
    dut.sw = 1
    await Timer(50,'ms')