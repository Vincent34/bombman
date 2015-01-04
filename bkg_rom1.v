module bkg_rom1(
	addr,
	q
);
input  [ 8: 0] addr;
output reg [ 2: 0] q;

always @(*)
	case(addr)
	9'd0: q = 1;
	9'd1: q = 1;
	9'd2: q = 1;
	9'd3: q = 1;
	9'd4: q = 1;
	9'd5: q = 1;
	9'd6: q = 1;
	9'd7: q = 1;
	9'd8: q = 1;
	9'd9: q = 1;
	9'd10: q = 1;
	9'd11: q = 1;
	9'd12: q = 1;
	9'd13: q = 1;
	9'd14: q = 1;
	9'd15: q = 1;
	9'd16: q = 1;
	9'd17: q = 1;
	9'd18: q = 1;
	9'd19: q = 0;
	9'd20: q = 1;
	9'd21: q = 0;
	9'd22: q = 0;
	9'd23: q = 0;
	9'd24: q = 0;
	9'd25: q = 0;
	9'd26: q = 0;
	9'd27: q = 0;
	9'd28: q = 0;
	9'd29: q = 0;
	9'd30: q = 0;
	9'd31: q = 0;
	9'd32: q = 0;
	9'd33: q = 0;
	9'd34: q = 0;
	9'd35: q = 0;
	9'd36: q = 0;
	9'd37: q = 0;
	9'd38: q = 1;
	9'd39: q = 0;
	9'd40: q = 1;
	9'd41: q = 0;
	9'd42: q = 1;
	9'd43: q = 0;
	9'd44: q = 1;
	9'd45: q = 0;
	9'd46: q = 1;
	9'd47: q = 0;
	9'd48: q = 1;
	9'd49: q = 0;
	9'd50: q = 1;
	9'd51: q = 0;
	9'd52: q = 1;
	9'd53: q = 0;
	9'd54: q = 1;
	9'd55: q = 0;
	9'd56: q = 1;
	9'd57: q = 0;
	9'd58: q = 1;
	9'd59: q = 0;
	9'd60: q = 1;
	9'd61: q = 0;
	9'd62: q = 0;
	9'd63: q = 0;
	9'd64: q = 0;
	9'd65: q = 0;
	9'd66: q = 0;
	9'd67: q = 0;
	9'd68: q = 0;
	9'd69: q = 0;
	9'd70: q = 0;
	9'd71: q = 0;
	9'd72: q = 0;
	9'd73: q = 0;
	9'd74: q = 0;
	9'd75: q = 0;
	9'd76: q = 0;
	9'd77: q = 0;
	9'd78: q = 1;
	9'd79: q = 0;
	9'd80: q = 1;
	9'd81: q = 0;
	9'd82: q = 1;
	9'd83: q = 0;
	9'd84: q = 1;
	9'd85: q = 0;
	9'd86: q = 1;
	9'd87: q = 0;
	9'd88: q = 1;
	9'd89: q = 0;
	9'd90: q = 1;
	9'd91: q = 0;
	9'd92: q = 1;
	9'd93: q = 0;
	9'd94: q = 1;
	9'd95: q = 0;
	9'd96: q = 1;
	9'd97: q = 0;
	9'd98: q = 1;
	9'd99: q = 0;
	9'd100: q = 1;
	9'd101: q = 0;
	9'd102: q = 0;
	9'd103: q = 0;
	9'd104: q = 0;
	9'd105: q = 0;
	9'd106: q = 0;
	9'd107: q = 0;
	9'd108: q = 0;
	9'd109: q = 0;
	9'd110: q = 0;
	9'd111: q = 0;
	9'd112: q = 0;
	9'd113: q = 0;
	9'd114: q = 0;
	9'd115: q = 0;
	9'd116: q = 0;
	9'd117: q = 0;
	9'd118: q = 1;
	9'd119: q = 0;
	9'd120: q = 1;
	9'd121: q = 0;
	9'd122: q = 1;
	9'd123: q = 0;
	9'd124: q = 1;
	9'd125: q = 0;
	9'd126: q = 1;
	9'd127: q = 0;
	9'd128: q = 1;
	9'd129: q = 0;
	9'd130: q = 1;
	9'd131: q = 0;
	9'd132: q = 1;
	9'd133: q = 0;
	9'd134: q = 1;
	9'd135: q = 0;
	9'd136: q = 1;
	9'd137: q = 0;
	9'd138: q = 1;
	9'd139: q = 0;
	9'd140: q = 1;
	9'd141: q = 0;
	9'd142: q = 0;
	9'd143: q = 0;
	9'd144: q = 0;
	9'd145: q = 0;
	9'd146: q = 0;
	9'd147: q = 0;
	9'd148: q = 0;
	9'd149: q = 0;
	9'd150: q = 0;
	9'd151: q = 0;
	9'd152: q = 0;
	9'd153: q = 0;
	9'd154: q = 0;
	9'd155: q = 0;
	9'd156: q = 0;
	9'd157: q = 0;
	9'd158: q = 1;
	9'd159: q = 0;
	9'd160: q = 1;
	9'd161: q = 0;
	9'd162: q = 1;
	9'd163: q = 0;
	9'd164: q = 1;
	9'd165: q = 0;
	9'd166: q = 1;
	9'd167: q = 0;
	9'd168: q = 1;
	9'd169: q = 0;
	9'd170: q = 1;
	9'd171: q = 0;
	9'd172: q = 1;
	9'd173: q = 0;
	9'd174: q = 1;
	9'd175: q = 0;
	9'd176: q = 1;
	9'd177: q = 0;
	9'd178: q = 1;
	9'd179: q = 0;
	9'd180: q = 1;
	9'd181: q = 0;
	9'd182: q = 0;
	9'd183: q = 0;
	9'd184: q = 0;
	9'd185: q = 0;
	9'd186: q = 0;
	9'd187: q = 0;
	9'd188: q = 0;
	9'd189: q = 0;
	9'd190: q = 0;
	9'd191: q = 0;
	9'd192: q = 0;
	9'd193: q = 0;
	9'd194: q = 0;
	9'd195: q = 0;
	9'd196: q = 0;
	9'd197: q = 0;
	9'd198: q = 1;
	9'd199: q = 0;
	9'd200: q = 1;
	9'd201: q = 0;
	9'd202: q = 1;
	9'd203: q = 0;
	9'd204: q = 1;
	9'd205: q = 0;
	9'd206: q = 1;
	9'd207: q = 0;
	9'd208: q = 1;
	9'd209: q = 0;
	9'd210: q = 1;
	9'd211: q = 0;
	9'd212: q = 1;
	9'd213: q = 0;
	9'd214: q = 1;
	9'd215: q = 0;
	9'd216: q = 1;
	9'd217: q = 0;
	9'd218: q = 1;
	9'd219: q = 0;
	9'd220: q = 1;
	9'd221: q = 0;
	9'd222: q = 0;
	9'd223: q = 0;
	9'd224: q = 0;
	9'd225: q = 0;
	9'd226: q = 0;
	9'd227: q = 0;
	9'd228: q = 0;
	9'd229: q = 0;
	9'd230: q = 0;
	9'd231: q = 0;
	9'd232: q = 0;
	9'd233: q = 0;
	9'd234: q = 0;
	9'd235: q = 0;
	9'd236: q = 0;
	9'd237: q = 0;
	9'd238: q = 1;
	9'd239: q = 0;
	9'd240: q = 1;
	9'd241: q = 0;
	9'd242: q = 1;
	9'd243: q = 0;
	9'd244: q = 1;
	9'd245: q = 0;
	9'd246: q = 1;
	9'd247: q = 0;
	9'd248: q = 1;
	9'd249: q = 0;
	9'd250: q = 1;
	9'd251: q = 0;
	9'd252: q = 1;
	9'd253: q = 0;
	9'd254: q = 1;
	9'd255: q = 0;
	9'd256: q = 1;
	9'd257: q = 0;
	9'd258: q = 1;
	9'd259: q = 0;
	9'd260: q = 1;
	9'd261: q = 0;
	9'd262: q = 0;
	9'd263: q = 0;
	9'd264: q = 0;
	9'd265: q = 0;
	9'd266: q = 0;
	9'd267: q = 0;
	9'd268: q = 0;
	9'd269: q = 0;
	9'd270: q = 0;
	9'd271: q = 0;
	9'd272: q = 0;
	9'd273: q = 0;
	9'd274: q = 0;
	9'd275: q = 0;
	9'd276: q = 0;
	9'd277: q = 0;
	9'd278: q = 1;
	9'd279: q = 0;
	9'd280: q = 1;
	9'd281: q = 1;
	9'd282: q = 1;
	9'd283: q = 1;
	9'd284: q = 1;
	9'd285: q = 1;
	9'd286: q = 1;
	9'd287: q = 1;
	9'd288: q = 1;
	9'd289: q = 1;
	9'd290: q = 1;
	9'd291: q = 1;
	9'd292: q = 1;
	9'd293: q = 1;
	9'd294: q = 1;
	9'd295: q = 1;
	9'd296: q = 1;
	9'd297: q = 1;
	9'd298: q = 1;
	9'd299: q = 0;
	default: q = 0;
	endcase

endmodule

