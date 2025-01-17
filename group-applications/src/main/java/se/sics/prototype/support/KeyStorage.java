/*******************************************************************************
 * Copyright (c) 2023, RISE AB
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without 
 * modification, are permitted provided that the following conditions 
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, 
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice, 
 *    this list of conditions and the following disclaimer in the documentation 
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its
 *    contributors may be used to endorse or promote products derived from
 *    this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR 
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY 
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *******************************************************************************/
package se.sics.prototype.support;

import java.util.HashMap;
import java.util.Map;
import org.eclipse.californium.elements.util.Bytes;
import org.eclipse.californium.elements.util.StringUtil;

/**
 * Class to hold asymmetric keys for the group members to use in the OSCORE
 * group.
 *
 */
public class KeyStorage {

	/**
	 * Hold specific Sender IDs for the 2 clients
	 */
	public static Map<String, Bytes> clientIds;
	static {
		clientIds = new HashMap<>();
		clientIds.put("Client1", new Bytes(new byte[] { 0x11 }));
		clientIds.put("Client2", new Bytes(new byte[] { 0x22 }));
	}

	/**
	 * Map holding OSCORE keys (master secret) to use by the group members
	 * towards the AS
	 */
	public static Map<String, byte[]> memberAsKeys;
	static {
		memberAsKeys = new HashMap<>();
		memberAsKeys.put("Client1", new byte[] { (byte) 0xCC, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11,
				0x11, 0x11, 0x11, 0x11, 0x11, 0x11 });
		memberAsKeys.put("Client2", new byte[] { (byte) 0xCC, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22,
				0x22, 0x22, 0x22, 0x22, 0x22, 0x22 });
		memberAsKeys.put("Server1", new byte[] { 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11,
				0x11, 0x11, 0x11, 0x11 });
		memberAsKeys.put("Server2", new byte[] { 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22,
				0x22, 0x22, 0x22, 0x22 });
		memberAsKeys.put("Server3", new byte[] { 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33, 0x33,
				0x33, 0x33, 0x33, 0x33 });
		memberAsKeys.put("Server4", new byte[] { 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44,
				0x44, 0x44, 0x44, 0x44 });
		memberAsKeys.put("Server5", new byte[] { 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55,
				0x55, 0x55, 0x55, 0x55 });
		memberAsKeys.put("Server6", new byte[] { 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66, 0x66,
				0x66, 0x66, 0x66, 0x66 });
	}

	/**
	 * Map holding ACE Sender ID indexed by the member name
	 */
	public static Map<String, byte[]> aceSenderIds;
	static {
		aceSenderIds = new HashMap<>();
		aceSenderIds.put("AS", new byte[] { (byte) 0xA0 });
		aceSenderIds.put("Client1", new byte[] { (byte) 0xA3 });
		aceSenderIds.put("Client2", new byte[] { (byte) 0xA4 });
		aceSenderIds.put("Server1", new byte[] { (byte) 0xA5 });
		aceSenderIds.put("Server2", new byte[] { (byte) 0xA6 });
		aceSenderIds.put("Server3", new byte[] { (byte) 0xA7 });
		aceSenderIds.put("Server4", new byte[] { (byte) 0xA8 });
		aceSenderIds.put("Server5", new byte[] { (byte) 0xA9 });
		aceSenderIds.put("Server6", new byte[] { (byte) 0xAA });
	}

	/**
	 * Map holding CCS to use by the group members
	 */
	public static Map<String, byte[]> memberCcs;
	static {
		memberCcs = new HashMap<>();
		memberCcs.put("Client1", StringUtil.hex2ByteArray(
				"A20267436C69656E743108A101A40101032720062158202FA0554A203C150E771E19AD14D8EB90349579325096B132E3A42DD3E6721BE4"));
		memberCcs.put("Client2", StringUtil.hex2ByteArray(
				"A20267436C69656E743208A101A4010103272006215820C80240E84F3CB886D841DA6F71140F8578E7E27808672DF08521830AE1300F54"));
		memberCcs.put("Server1", StringUtil.hex2ByteArray(
				"A202675365727665723108A101A4010103272006215820A42794D9EADBE3A7327FB1997A80E648ECF88C876FEE2FBAD53B1B7266C0237D"));
		memberCcs.put("Server2", StringUtil.hex2ByteArray(
				"A202675365727665723208A101A4010103272006215820158EDB53F4373EC2FF1BA1844A1B94E2A9E9E7AE96CB15455E0AEB0475AE5481"));
		memberCcs.put("Server3", StringUtil.hex2ByteArray(
				"A202675365727665723308A101A40101032720062158205239AE299D02615D9EF210CBD263A2E3026A868C991EB7A20AB7E40804CF4D6C"));
		memberCcs.put("Server4", StringUtil.hex2ByteArray(
				"A202675365727665723408A101A40101032720062158208ED61CBEAD281DD16FD086280B207AD3FB706DF23E37BC43A00DF13047E4CDC4"));
		memberCcs.put("Server5", StringUtil.hex2ByteArray(
				"A202675365727665723508A101A40101032720062158204F8D92825564057CEAAF1CC8C2ABAD0F0542BEA9A6E171BD9C7086138AF885FB"));
		memberCcs.put("Server6", StringUtil.hex2ByteArray(
				"A202675365727665723608A101A401010327200621582003409CBD38DC73250E79B9F627739ECD78CC89651E89929983FAF8BFC94FDCA2"));
	}

	/**
	 * Map holding Private Keys to use by the group members
	 */
	public static Map<String, byte[]> memberPrivateKeys;
	static {
		memberPrivateKeys = new HashMap<>();
		memberPrivateKeys.put("Client1",
				StringUtil.hex2ByteArray("82C027A023FB522BA6B8565C73056A02BFC7C26DC89969CA15207B8FCB27A2AA"));
		memberPrivateKeys.put("Client2",
				StringUtil.hex2ByteArray("7D428B2549E7997E8D8833A17BDA1E09B65C9FDC0F69287F376D7DCE882E1C3F"));
		memberPrivateKeys.put("Server1",
				StringUtil.hex2ByteArray("77561F3438E381214F176493C01AAE1514C9D3FC05070C6026D00CBC669A86AF"));
		memberPrivateKeys.put("Server2",
				StringUtil.hex2ByteArray("EA67E40CA8E0770E9CF1EC2FDA7B2D926BBFB6CE704B2E261C751A5218B816C3"));
		memberPrivateKeys.put("Server3",
				StringUtil.hex2ByteArray("D2C6B58FAD471EDB3E17C742A332F877CEB8CE4FFB8547951BC4A9FBCF6427AA"));
		memberPrivateKeys.put("Server4",
				StringUtil.hex2ByteArray("A90B7D8A9E6D32DDFC794494D446F0E56505094203209BEF64A6800CF35F3988"));
		memberPrivateKeys.put("Server5",
				StringUtil.hex2ByteArray("B414D24D3D45D0AFA4172EE66CEC88685AFEB4FF011A9C04C0AB4CEC763616E9"));
		memberPrivateKeys.put("Server6",
				StringUtil.hex2ByteArray("F444DF1A8899E2C3733F391823A492B4607489820D0304530D15A2BB6B746D9A"));
	}

}
