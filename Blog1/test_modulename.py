import cocotb
from cocotb.triggers import Timer, RisingEdge

@cocotb.test()
async def test_modulename(dut):
    a = (0,1,0,1)
    b = (0,0,1,1)
    y = (0,1,1,0)

    for i in range(4):
        dut.in0.value = a[i]
        dut.in1.value = b[i]
        await Timer(10, 'ns')
        # assert dut.out0.value == y[i], f"Error at iteration {i}"

