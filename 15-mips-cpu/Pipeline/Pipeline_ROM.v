module Pipeline_ROM(reset,PC,enable,Instruct_o);
input[6:0] PC;  //only require PC[8:2]
input reset,enable;
output[31:0] Instruct_o;
reg[31:0] Instruct;
assign Instruct_o=enable? Instruct:32'b0;
always@(*) 
 begin
	if(reset) Instruct<=32'b0;
	else 
	 begin
		case(PC[6:0])
			0: Instruct<=00001000000000000000000001001101;
	1: Instruct<=00001000000000000000000001010011;
	2: Instruct<=00000011010000000000000000001000;
	3: Instruct<=00100100000010000000000011000000;
	4: Instruct<=10101100000010000000000000000000;
	5: Instruct<=00100100000010000000000011111001;
	6: Instruct<=10101100000010000000000000000100;
	7: Instruct<=00100100000010000000000010100100;
	8: Instruct<=10101100000010000000000000001000;
	9: Instruct<=00100100000010000000000010110000;
	10: Instruct<=10101100000010000000000000001100;
	11: Instruct<=00100100000010000000000010011001;
	12: Instruct<=10101100000010000000000000010000;
	13: Instruct<=00100100000010000000000010010010;
	14: Instruct<=10101100000010000000000000010100;
	15: Instruct<=00100100000010000000000010000010;
	16: Instruct<=10101100000010000000000000011000;
	17: Instruct<=00100100000010000000000011111000;
	18: Instruct<=10101100000010000000000000011100;
	19: Instruct<=00100100000010000000000010000000;
	20: Instruct<=10101100000010000000000000100000;
	21: Instruct<=00100100000010000000000010010000;
	22: Instruct<=10101100000010000000000000100100;
	23: Instruct<=00100100000010000000000010001000;
	24: Instruct<=10101100000010000000000000101000;
	25: Instruct<=00100100000010000000000010000011;
	26: Instruct<=10101100000010000000000000101100;
	27: Instruct<=00100100000010000000000011000110;
	28: Instruct<=10101100000010000000000000110000;
	29: Instruct<=00100100000010000000000010100001;
	30: Instruct<=10101100000010000000000000110100;
	31: Instruct<=00100100000010000000000010000110;
	32: Instruct<=10101100000010000000000000111000;
	33: Instruct<=00100100000010000000000010001110;
	34: Instruct<=10101100000010000000000000111100;
	35: Instruct<=00100100000000100000000000000001;
	36: Instruct<=00000000000000000000000000000000;
	37: Instruct<=10001110000100010000000000011100;
	38: Instruct<=00000010001000000100100000100000;
	39: Instruct<=10001110000100100000000000011100;
	40: Instruct<=00000010010000000101000000100000;
	41: Instruct<=00010000000010010000000000001000;
	42: Instruct<=00010000000010100000000000001001;
	43: Instruct<=00010001010010010000000000001000;
	44: Instruct<=00000001001010100100000000101010;
	45: Instruct<=00010100000010000000000000000010;
	46: Instruct<=00000001001010100100100000100010;
	47: Instruct<=00001000000000000000000000101011;
	48: Instruct<=00000001010010010101000000100010;
	49: Instruct<=00001000000000000000000000101011;
	50: Instruct<=00000001010000000001100000100000;
	51: Instruct<=00001000000000000000000000110101;
	52: Instruct<=00000001001000000001100000100000;
	53: Instruct<=00000000000000100101100001000010;
	54: Instruct<=00010000000010110000000000001000;
	55: Instruct<=00000000000000100101100010000010;
	56: Instruct<=00010000000010110000000000001001;
	57: Instruct<=00000000000000100101100011000010;
	58: Instruct<=00010000000010110000000000001010;
	59: Instruct<=00100100000000100000000000000001;
	60: Instruct<=00110010001100110000000000001111;
	61: Instruct<=00000000000100111001100010000000;
	62: Instruct<=00001000000000000000000001001001;
	63: Instruct<=00000000000100011001100100000010;
	64: Instruct<=00000000000100111001100010000000;
	65: Instruct<=00001000000000000000000001001000;
	66: Instruct<=00110010010100110000000000001111;
	67: Instruct<=00000000000100111001100010000000;
	68: Instruct<=00001000000000000000000001001000;
	69: Instruct<=00000000000100101001100100000010;
	70: Instruct<=00000000000100111001100010000000;
	71: Instruct<=00001000000000000000000001001000;
	72: Instruct<=00000000000000100001000001000000;
	73: Instruct<=00001000000000000000000001001001;
	74: Instruct<=00000000000000000000000000000000;
	75: Instruct<=11111111111111111111111111111111;
	76: Instruct<=00001000000000000000000000100100;
	77: Instruct<=00100100000101000000000000000011;
	78: Instruct<=00100000000100000100000000000000;
	79: Instruct<=10101110000101000000000000001000;
	80: Instruct<=00100100000101110000000000000011;
	81: Instruct<=00000000000101111011100010000000;
	82: Instruct<=00000010111000000000000000001000;
	83: Instruct<=10101110000101000000000000001000;
	84: Instruct<=10001110011101010000000000000000;
	85: Instruct<=00000000000000101011001000000000;
	86: Instruct<=00000010101101101011000000100000;
	87: Instruct<=10101110000101100000000000010100;
	88: Instruct<=10101110000000110000000000001100;
	89: Instruct<=10101110000000110000000000011000;
	90: Instruct<=00000011111000000000000000001000;
                 default:    Instruct<=32'b0;
		endcase
	 end
 end
endmodule