Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012014.outbound.protection.outlook.com [52.103.14.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E71B19992C;
	Sat, 13 Jun 2026 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781376887; cv=fail; b=SCtnh7aqrl/tsME2037eJmkCD7JKzkGRAkxXjsACX6+kF2HaF1oGc8P34loK/sZGypsUXUXF5m0q5aWXSWDuPyUMHS0E4ykXTViUaiq/IE+skIotDRK6kXoGy1xLXvujjhBr7UM/YoUyjUZs94fMnqKDX+QbdBJgSGxYSiQEx9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781376887; c=relaxed/simple;
	bh=k/FecD/wO7L5sOcUMEubRcI+bdToHihWz1ndtBQqUs8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bdpI/gc5acE3QLNuzWmcVf7/+/uAItfi4i94XkjsOku1elCkyUvZ4YWDE6uA1aEWD2/wmYpL6KSuh+swM+EBUk68VXr75iUbcovbLHSNqICYZI5GGJBSbZv1yCZspGwVMnfEadKGJsGtwsI3LyICo0LD/ezJokBsCt+kNoafp+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=I7PKQo13; arc=fail smtp.client-ip=52.103.14.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="I7PKQo13"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpMBo52RkALVDI18py11MiIfKJ41BcvM2gdp7lFXUNEIO2DTISkB+cjVetiQI9vXTGIOu1p5r4pE8mYYtjErVK2bGkGWhrqSLMGwGXIpY1lV+QeYm/vgUBpVk43sLCObev5vwUtjKzCbCeiT0aCzJ763+t8rSVVAwsMS9tg6TQe0ZCGeJ5i9S5DGX2ZOgj7rk5+K1jFDFlJzOAKWR2ksxgJGrcBp9aUCTAn+VFYuUs04OnNBmfY6UVu+xo4LlmVrOuQWJ3eQk+5ZOLWDVuO3HxvxT+TsbYK58cM9GDyMAF8vQFHy2MTJwXhGNzlKqgxoF37FQZ+VU2MCCsjboGrDyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/FecD/wO7L5sOcUMEubRcI+bdToHihWz1ndtBQqUs8=;
 b=q/7Df6WFFJ2T/1v6Sd1d25YoyrEgTld/gz33lkFHlj+1jC0x5SXO9IZofGYCH4N3tgbAzmFWZZs4sWg5SBTHrU/wFYiCnry/H/KftmCwDovHcb748j/segJJXQav9UKO+VPQLIv/Rt7A6t885mUqJeS3/ncO/HjWoxpunjFMQzKhlu4b63rXFFyESqnRYeJn8R7oD+1quZPfRy6L/JIM9cBxfeW6+X+pHvXeKBZr7WsD/t3w21W28OWsvTNba+5kacEvQtBW0uiqWRgvol2KP64mgNvecbpLRIWU9zLxm+K65yPITue+sHUSLhNVy5DF11m36rm8baKwAQR5il53ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/FecD/wO7L5sOcUMEubRcI+bdToHihWz1ndtBQqUs8=;
 b=I7PKQo13PPreyuKVWSrq2WCZypOzlzEyGGmhRY2LMR+BjGqI9H3B0xJIISZRADLbNlaFkexjFmgiyoN/JvLftXWJlKCU2hm5Xt64NYnDS8XydoKDC1ptlqcL+2miHrtbcv2aUhR6SQs+2SSdGWtWKDmNHTM7kZoKSqSvcCB1z5fHjOwYlzZdFUdPLAiuGKd74lab8fKU+1A/F2MUdO3FiR/RESiNXe7yFYM4mcrmDsoNJnGa6zI/pej6Pws3QJxbcAfY5tkdRClFq/bDOFRh6awS5AxqgHSNrd6uZ6H3cbozHqaSmcyicCkBXwdAKa52tNASsV3CsZvdIG4emh6rlg==
Received: from MN2PR16MB2846.namprd16.prod.outlook.com (2603:10b6:208:de::27)
 by SA0PR16MB3805.namprd16.prod.outlook.com (2603:10b6:806:8d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Sat, 13 Jun
 2026 18:54:43 +0000
Received: from MN2PR16MB2846.namprd16.prod.outlook.com
 ([fe80::7ec5:b268:36be:b5c2]) by MN2PR16MB2846.namprd16.prod.outlook.com
 ([fe80::7ec5:b268:36be:b5c2%3]) with mapi id 15.21.0113.013; Sat, 13 Jun 2026
 18:54:43 +0000
From: Alex Roberts <alex.roberts109@outlook.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, David Windsor
	<dwindsor@gmail.com>
CC: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, LKML
	<linux-kernel@vger.kernel.org>, LSM List
	<linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH] Add LoadPin support for eBPF program loading
Thread-Topic: [PATCH] Add LoadPin support for eBPF program loading
Thread-Index: AQHc+dRphx/14SwKVkqVH/9fQj/eUbY6C4SAgAD+z4CAAczoJg==
Date: Sat, 13 Jun 2026 18:54:43 +0000
Message-ID:
 <MN2PR16MB2846E47917277B4209758D6BB5192@MN2PR16MB2846.namprd16.prod.outlook.com>
References: <20260611-b4-rfc-loadpin-ebpf-v1-1-11a6c8e6170d@outlook.com>
 <20260612000825.105100-1-dwindsor@gmail.com>
 <CAADnVQL9CJMY9h8haj5+99x-0GmiaHv3wDWuZ_YCYETKTznBbw@mail.gmail.com>
In-Reply-To:
 <CAADnVQL9CJMY9h8haj5+99x-0GmiaHv3wDWuZ_YCYETKTznBbw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR16MB2846:EE_|SA0PR16MB3805:EE_
x-ms-office365-filtering-correlation-id: d1927287-695a-4d19-8944-08dec97d3b3e
x-ms-exchange-slblob-mailprops:
 ZILSnhm0P3mCYd7/icPJlj+s+m08RC6k3brU7MIGil1vh1Fjat75tIuyvY2/YjpD3ZBfr3F+cixiZg1DJPvE8Xc6xytFSfP/zKllk3uoy9cLwE3wmJU6eGDqng7xS7B4nYWGKpxslCq4OK1VIlqTK0n3y7Wc9+ESJHNxaIkZaJDgroFiDWt4e1TY4b/EiArmmWZagK3FRGXdcE5RM+zVDWcDH9wo+bFd9sS9ov2pJYByGXPfLZMXZpeVLsw4hiQJBrB+oZ1UFr10ZJsW4lAHogCEIyS6bGktriIDzYTVxGYj5Q/m9ph+43CoG5l+j8l6ukf5sjOWtNzEVkoHpknv+Oi2NtwqWPkMdMQLMb82/gxAF9smhuKAovnyB2Y+1tNRtASuCkCPovfVXoQItrdVdnBkDI8DGvtJLAiglDnyKhT0MClLn4oXv4CoBraSnNklM7UCbfAf4hslwZoLaXhFjrwRFPsydcBwkSegg+UTehfnfZlT7IkFZ+vbhscBiOMKxFpu92DSC2zxyp24gEQ67mUP+wWBBoOVLZqeGzQuDFsizrC01hCJnarzHIzt9lWOdTCuRbCeEt75A0Td+sM/WWdsiLzCSHUhDNmMVkoUx5TYeuqvJvAub1Sqbwegzpmfb1QpNZKOCCGS0mCFSeGyP3JDmVRJ+oWN0CVxVYYHc0lTYrAasRFJuSDKYoB3arbUAdOa9jhd3hXb3YnWNQVapETGIFayCVfzTnQmF1eoTjl8c/KHJDSR9b/xqE+2pubiEPbVwLGV0qQPg0SamKhkPpZLfOz6z5uR
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|15030799006|15080799012|7071999006|37011999003|31061999003|19110799012|8062599012|8060799015|12121999013|41001999006|20031999006|39105399006|102099032|41105399003|40105399003|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?utf-8?B?VjhJdllxMUR3YkVvTEJJTkFVRVdXS0tnRVpINzNsdmNwMFVJd2NXV0R1a0o4?=
 =?utf-8?B?MFdTOXdXSjJaUXdTdmJ1RlJnSVgydDR6N0NIQXBFY2kvZ3A3b0p1YXVFNFJl?=
 =?utf-8?B?ZFpLczJHeHJkOW00RWt0b2hsYTI1andOalR6UkxIbVljNFE1RG5EWmxyQ1lw?=
 =?utf-8?B?WTYveHl2dytsYzBUVUhvYnRIRkF4cC9ZRHRjZ3hjYTROaVFQaFQ2OFY1My9W?=
 =?utf-8?B?UnU0THY3YVlvWG1SY3piVG1pM3NMdkZHSVJxUVZFZUkrRnNoZGFKU0hEN3NE?=
 =?utf-8?B?MlhsN1U5QmpFcHI0ZmVMM1BVSmMvMkV0cmxVUDhDTmVIRnZmMHBDWW1mVW5H?=
 =?utf-8?B?SjZRcTdydFA0ZTAyRFRrUzBKTExYUkhEYWJXYkw2TnU4VHFHbWIvN0JzQjdD?=
 =?utf-8?B?c0ZiQU9aWVBWREpIdXBLQU5ZVjdYTWI2bnJFY3grSVFnL2U5ZEJMbHIxZklq?=
 =?utf-8?B?VVEydHUxZFY4azc3Ykd3TW5peGUySThpb2xEdmZxR09iRFhmMzFCY3haQXgv?=
 =?utf-8?B?RGhCMEl5UUw5bFR5cmRFbTd1M2VYNjdkaGovUHNyOWRoYTBZNUFlQ0x6bWVT?=
 =?utf-8?B?Ym9TZjBNTW1sb1lrcERtREtweTc1cFNnamlwbzg1a1F6WEJrdXZNQmliOWl2?=
 =?utf-8?B?M05HNG04K2FPellWZDFRWlM5ZEMycW84QW5CbFpxb0N6QzNMeFFLRk1EWjIz?=
 =?utf-8?B?cDNqalNzTWVsVDZjSnhGZkl6d1c1RDJBaERjakt6MzdTTHdnOXRjejNaSnhq?=
 =?utf-8?B?QTBtRGZkbU5Nbk9MUklXeG00REVEaEhNZjQ0MitXVWdLcnY2RCtKampVbjdy?=
 =?utf-8?B?S3JCL01PTHJweVhEa0hURkRsRTcvYzVHYTI0Z0c0K2pwQ2wyRjhzVDJxb3By?=
 =?utf-8?B?RjRNN09vSjQrY2VNM245MWVsaDAyS3NoL1VQdmFJYTAxU1pQSnZaSDlYRzVk?=
 =?utf-8?B?cEpSZGF5NXZTbnlsZnpQN0tMSGFEamc2MGFKNmpHWUNjbDdyODBGUnJUaUVE?=
 =?utf-8?B?bXBPQmNNZ0xRVFdsZnMvcEVTVFpOQmJKKzNxWlFOcFg5bHZSTmRwSEVOSElu?=
 =?utf-8?B?dlU5WXBlTzRYMkdyeC9GREtsRGV4STJzL0tvcGV5RmtkdXhTUVhSUUZyUEJP?=
 =?utf-8?B?ZW16VEwweDJTQ2ZhT05xcGJORldXd0ZmYW1XYkp2V1I2UUhobG5La3IzRTgx?=
 =?utf-8?B?U1pkM2R1cjJMRWhIWXozdFVzSmlzSXFpVEhUYTJrZ25NYUVvTVJDTEwzZCsy?=
 =?utf-8?B?VjM2MmVWckk4R1RzSmtHcVoxbGE2TGNRRG1tRFc2K1E5S3hUNGNOOUpRb3U1?=
 =?utf-8?B?cVdTWmF5ZDdnUEdOZTJsb0s0WTV1bDNQTGdQL3FhYllVbkExZjNlQnlRNGNE?=
 =?utf-8?B?OFA2azR1OGh2djdiT1JCR2JpYktGTEc0T3kxQTF1WXZHN1Z5YmJCVVAvQitL?=
 =?utf-8?B?cjVnSG9DbWhieDFqNlhYVnkvMGpkeWdybkoydUwxNHFNWVgrUzR5TVhYSzRx?=
 =?utf-8?B?eHhsM3M1TzVxU3BHdHBKUGVHbjlnUFJBdjNTdklLVFM3TzNQSDVMSDh2QzRE?=
 =?utf-8?B?d045UT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVp1bDZ0bk1TTW1VeElabCtjQVhFYmZZdDE1Y3d6R2JHNTdJK08rU3ZGSE5B?=
 =?utf-8?B?dW1NZG1IM3A0Yk9jVHlteXg5ZHNBMmJWYnZpVVNEMVZxK3VtWWRYWFdvL1JO?=
 =?utf-8?B?Zjdna2FMNWJDM1Rnb2RibGVwN1pxNFI0WUFhSHFFUS95dFZaYlVQUHEzTWdk?=
 =?utf-8?B?dHFOZXQ0N1JGc054eW9ZV2R5d1Q4WGVpbTd2UlNhdG1uNVl5ejAxTWtYZWhD?=
 =?utf-8?B?UE9sbVRWeWFJT2c4UE5LYU9FRWN2dEdGZGEyOXZtU1JCdlRBOFo5VzkvQXhy?=
 =?utf-8?B?MVIvQ05yb0RJU0FGY1pEcWp6NHVTaUpHNWtWMFJrY3BFTElDb1FOL0JJZzRo?=
 =?utf-8?B?TzEwelhHZUQvcXByQTN2N0FJVGN5N0JMOVpqdy9oOXUvVkE4M093SUNTSnR5?=
 =?utf-8?B?L2QrR2FydHJFbkFpbjY1VmFCVjhUZG9DVTFydG5CMDlyZXk3V0ovOTRRMGln?=
 =?utf-8?B?TlVJQkw2bVBWYmtzZzhoQWdDZ2ZMVEcvZUJvVTA2M3FRMVdpL29UZThTdXhi?=
 =?utf-8?B?YTlza1hVTEZnQlRsQSs5SC93RjRwZG5KWGhZOUh0Z2ZpV29jOFU3S2U3MU5P?=
 =?utf-8?B?OWlHOXdRTGI0bmZuRW9IN2FEZXVITldFWTJPR1hOQnVDSFUyUmU5ZFRiei8z?=
 =?utf-8?B?UFlJeENScXVLMDMrZUdHUnVJSm1IWmQwdCt5aXh4MlluWnN3UUE2T3lHUVBB?=
 =?utf-8?B?VFVRZi96T2JVUXFqVmZUeUVQSzBPUDZMYjZiaTd0Zzd5YktrS2phYXZqY3lr?=
 =?utf-8?B?RUM3QW53SFdvMGk3OUQ5dlZWKzg1cjBTQ013WHNJMDlsUzVOekRWdWpGb3Ay?=
 =?utf-8?B?aTNmaUtCZ0o4cjBLOUpmOHM4OWdDQWtKTCtzdWExcEZxUm1NaUg1bTB0NEd3?=
 =?utf-8?B?aXNuaUZiaUE5MDg2YVc0cm1kb0JNZklxaVlYZ0hHYjUzbUx4NUZubWEvbUpB?=
 =?utf-8?B?cTJINVVnK0liT09SUFFMU0RVSHQ1SGJ5Rmx6bVhHVVRiZDNacURMWnkzcjMr?=
 =?utf-8?B?OWVoaGQvZitwMXVsbEJNNU5jVnlQSTdXWW53Wis2bDY5YnhmRCtvaTJ2aTBr?=
 =?utf-8?B?ZlZwNE43ODZ6akVoQTFDWnc4dFMraEJyTm83eHZyKy9tVHdFRVk5bEpGWVZn?=
 =?utf-8?B?Z25rYUhGbkU5WHlPb3VKcHNMdjB5SXhuTXpWblAydDVjUUVSbmRuOEx4emhz?=
 =?utf-8?B?ZzR3dUFnVTBMZjlEaG5Ya2thK05xNW1TUlRRN0tpU3RYZE1YWGtSUWJaUVNp?=
 =?utf-8?B?dVBwSEhNdGRNbjBYWHpwTCtjQzQ4K2pOL0xWdUlOUHRmN1dycjVOWi8rbGEv?=
 =?utf-8?B?ZnV2VmR2MlEzY0hWbFl0S3d5Y3FBQ1liN2RHSDNla3g0UEw0Ylk4R1JBUFBm?=
 =?utf-8?B?dDRWUGVBbVc2a0wydXhBbUg0ekVPeVllTlJnc2IvMzVhYnNwNUFwZlpFc0Mw?=
 =?utf-8?B?WkhPU2hwNTBoT1NHQzJCVHRUY2t3endaMEFvZ1VpWE02bUpNdmMrWVVpa3dh?=
 =?utf-8?B?U2psQTZFOXAzV3RuTG5KanJJeGxCbEJuanV6NFUxUmpmb2t2dTFabHNHK0VM?=
 =?utf-8?B?SVFQSEhtdVd0UHczRDBwWit0NXMwRU54MnV6ekJtRWIzaXl6SXRuV2F3NktH?=
 =?utf-8?B?b1c0andYQzU5U3JxK2hjU3JWcUNuRk11OFdxTzdxTytRNnFiYllIUTJkeDBX?=
 =?utf-8?B?SmQ2SHllR0tVUlZROWhSMTJDS3R3d2k0M0pLSzhucWY1dmxLNUdsV3FqRUE3?=
 =?utf-8?B?azQyUlplUUYwNUF1czZreGNOejFISURKT1h3MHY4M0t3RXhGeEszc1FNek13?=
 =?utf-8?B?ZlNGbElCMDFiUm9MTm9HSWc5L09CYkZEZUUxcWhFeEVxK3JjUzN6TXBMdDlF?=
 =?utf-8?Q?3+mKUEjPfcBbq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR16MB2846.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d1927287-695a-4d19-8944-08dec97d3b3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2026 18:54:43.5028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR16MB3805

PldoeSBhcmUgd2UgY2hlY2tpbmcgY3VycmVudCBoZXJlPyBJSVVDIHRoaXMgd2lsbCBiZSB3aG9l
dmVyIGNhbGxzCmJwZigyKSwgd2hpY2ggd291bGQgYmUgdGhlIGxvYWRlciwgd2hpY2ggd291bGQg
dGhlbiBiZSBhYmxlIHRvIGxvYWQgYnBmCnByb2dyYW1zIGZyb20gYW4gdW50cnVzdGVkIHNvdXJj
ZS4KClRoZSBsb2FkZXIncyBmaWxlc3lzdGVtIHdvdWxkIGJlIHBpbm5lZC4gSWYgdGhlIGZpbGVz
eXN0ZW0gaXMgdHJ1c3RlZCwgZS5nLiwgZG0tdmVyaXR5IHdpdGggc2lnbmVkIHJvb3QgaGFzaCwg
dGhlIGxvYWRlciBpcyBpbXBsaWNpdGx5IHRydXN0ZWQuIFdvdWxkIHRoaXMgbm90IGJlIHNpbWls
YXIgdW5zaWduZWQga21vZHVsZXMgZnJvbSBhIGxvYWQtcGlubmVkIGRtLXZlcml0eSBmaWxlc3lz
dGVtPwoKT2J2aW91c2x5LCB0aGlzIHdvdWxkIGhhdmUgdG8gZXhjbHVkZSB0aGUgdXNlY2FzZSBv
ZiBkeW5hbWljYWxseSBnZW5lcmF0ZWQgQlBGIHByb2dyYW1zIGZyb20gYnBmdHJhY2UuCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkZyb206wqBBbGV4ZWkgU3Rhcm92
b2l0b3YgPGFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+ClNlbnQ6wqBGcmlkYXksIEp1bmUg
MTIsIDIwMjYgMTA6MjAgQU0KVG86wqBEYXZpZCBXaW5kc29yIDxkd2luZHNvckBnbWFpbC5jb20+
CkNjOsKgYWxleC5yb2JlcnRzMTA5QG91dGxvb2suY29tIDxhbGV4LnJvYmVydHMxMDlAb3V0bG9v
ay5jb20+OyBLZWVzIENvb2sgPGtlZXNAa2VybmVsLm9yZz47IFBhdWwgTW9vcmUgPHBhdWxAcGF1
bC1tb29yZS5jb20+OyBKYW1lcyBNb3JyaXMgPGptb3JyaXNAbmFtZWkub3JnPjsgU2VyZ2UgRSAu
IEhhbGx5biA8c2VyZ2VAaGFsbHluLmNvbT47IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc+OyBMU00gTGlzdCA8bGludXgtc2VjdXJpdHktbW9kdWxlQHZnZXIua2VybmVsLm9yZz47
IGJwZiA8YnBmQHZnZXIua2VybmVsLm9yZz47IEFsZXhlaSBTdGFyb3ZvaXRvdiA8YXN0QGtlcm5l
bC5vcmc+OyBLUCBTaW5naCA8a3BzaW5naEBrZXJuZWwub3JnPgpTdWJqZWN0OsKgUmU6IFtQQVRD
SF0gQWRkIExvYWRQaW4gc3VwcG9ydCBmb3IgZUJQRiBwcm9ncmFtIGxvYWRpbmcKwqAKT24gVGh1
LCBKdW4gMTEsIDIwMjYgYXQgNTowOOKAr1BNIERhdmlkIFdpbmRzb3IgPGR3aW5kc29yQGdtYWls
LmNvbT4gd3JvdGU6Cj4KPiBPbiBUaHUsIEp1biAxMSwgMjAyNiBhdCAwMTo1OToxMFBNIC0wNTAw
LCBBbGV4IFJvYmVydHMgd3JvdGU6Cj4gPiArc3RhdGljIGludCBsb2FkcGluX2JwZl9wcm9nX2xv
YWQoc3RydWN0IGJwZl9wcm9nICpwcm9nLCB1bmlvbiBicGZfYXR0ciAqYXR0ciwKPiA+ICsgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3RydWN0IGJwZl90b2tl
biAqdG9rZW4sIGJvb2wgaXNfa2VybmVsKQo+ID4gK3sKPiA+ICsgwqAgwqAgaW50IHJlcyA9IDA7
Cj4gPiArIMKgIMKgIHN0cnVjdCBmaWxlICpleGVfZmlsZSA9IE5VTEw7Cj4gPiArIMKgIMKgIHN0
cnVjdCBtbV9zdHJ1Y3QgKm1tID0gY3VycmVudC0+bW07Cj4gPiArCj4gPiArIMKgIMKgIGlmIChp
c19rZXJuZWwgfHwgIW1tKQo+ID4gKyDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gMDsKPiA+ICsK
PiA+ICsgwqAgwqAgZXhlX2ZpbGUgPSBnZXRfbW1fZXhlX2ZpbGUobW0pOwo+ID4gKyDCoCDCoCBp
ZiAoIWV4ZV9maWxlKQo+ID4gKyDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gMDsKPiA+ICsKPiA+
ICsgwqAgwqAgcmVzID0gbG9hZHBpbl9jaGVjayhleGVfZmlsZSwgUkVBRElOR19FQlBGKTsKPgo+
IFdoeSBhcmUgd2UgY2hlY2tpbmcgY3VycmVudCBoZXJlPyBJSVVDIHRoaXMgd2lsbCBiZSB3aG9l
dmVyIGNhbGxzCj4gYnBmKDIpLCB3aGljaCB3b3VsZCBiZSB0aGUgbG9hZGVyLCB3aGljaCB3b3Vs
ZCB0aGVuIGJlIGFibGUgdG8gbG9hZCBicGYKPiBwcm9ncmFtcyBmcm9tIGFuIHVudHJ1c3RlZCBz
b3VyY2UuCj4KPiBJbiB0aGUga21vZCBjYXNlIGxvYWRwaW5fY2hlY2soKSBzZWVzIHRoZSAua28g
aXRzZWxmLgoKU2VlIHNhc2hpa28gY29tbWVudHM6Ci0gW0hpZ2hdIFRoZSBMb2FkUGluIGVCUEYg
dHJ1c3QgbWVjaGFuaXNtIGNhbiBiZSB0cml2aWFsbHkgYnlwYXNzZWQKdXNpbmcgc3RhbmRhcmQg
c3lzdGVtIGludGVycHJldGVycyBsaWtlIHRoZSBkeW5hbWljIGxpbmtlciAoYGxkLnNvYCkuCi0g
W0hpZ2hdIFRoZSBMb2FkUGluIGVCUEYgdHJ1c3QgbWVjaGFuaXNtIGNhbiBiZSBieXBhc3NlZCBi
eSBhCnByaXZpbGVnZWQgYXR0YWNrZXIgdXNpbmcgcHJjdGwoUFJfU0VUX01NX0VYRV9GSUxFKS4K
CmFuZCB0aGUgYm90IGlzIGNvcnJlY3QuClRoaXMgcGF0Y2ggaXMgcG9pbnRsZXNzLg==
