Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23AC13FEE;
	Mon,  1 Dec 2025 03:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764560403; cv=fail; b=hrnog1pgUkudpe64KoHmLl2WfNV1w8bs1fpBU0rY9+6ipv0aLO/lSB6mZmY3AZ9FXrZsTPIaAOuSn+ULuZtcYpoll6syKL/3TuauhowYmP0O2b88Ehn+dsndHDYo0af0jE+gpcQ+I3LnA1IWlGTk47rM599MgUggMpIqyZxValI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764560403; c=relaxed/simple;
	bh=fVK7vMKzPFr+UyrmH4gZTOeSgN0awdN2/7mpSHUwuMI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=g3ohDlCiYWbzfuSX4MgRmdwrL5XUuMZu+4jCqAU8Yg5qAf8nuOvT9BtDDwzqe9kU8sYSM4RjZN3ZEjiDKBn9fpWc681U4Dt15h6sOOZBsl6qsaO9OwXciEleNuZ+yDj3+aIrDNxSZLrSC4Zpo1YkT4ly/s633X8470n0Q7oZBFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a+84LJeE; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a+84LJeE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vB8o9uwEDjstXNAxQacAZIBhm1fMVBjWdbUWjDLyQPjGjlvsUaUc49xAkIPFQ+/f6wzu1PgmFyq3TQacLh6Hz+OL/IWGmzW+I7GJxB7rgvcfoY58RrKlfd6RF6ZNk+v2+34JsRoua+ReTdB2IHfmAwj3s+8U8KdwnnCIAiizh2l1JSUnkm7XnAQXUU2fUNa5+fzkcegMD/5z3HSrBVH9GZDpvPrIqQpPZO/uXxbj0jvA5Ikax3dqOofOJ4+SY/P/Ru3sI7fkTYhLCeu3GpaUEafZOLE2chH5y4f/1mrlL4oL7BoOC3HSKku725PjTuZi3qvlV2e0Mrp+gprmEeBO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRJNRkgV1GuU1ymfJqzpJkcfSJVIprB0vf9tjlytSxU=;
 b=pJMAy5rD91BwIsofsbrj/Oyzqw6XMOP2KSdP95+IPVAB9NqVg0pVpnSkfTJrBacZoOE7MQMxgeOziCEybePD7vKpdRLNskhrLQV99sDXcY/DjLYSGBoEt5IFPFSBL07CaNXAvtZYu79qCjchrXnnFqBQ+kMyHYzzFjrZU+C6sxaEEe2FYowQ6AEh4AWdlbYaBxZXtSHpu+X17jDsw7AtcjOmdW/V/RN2+8EvHykgOb7kTTOrE0Fb9s9coHJMissg2QFdB2B4Q8FP5VP32Q+TxRAVOYM1T9f/+3jniHTFwMccNAXDdzaOksKmOct5bYSnlut6b6ib2Y+NeJDaasiSbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRJNRkgV1GuU1ymfJqzpJkcfSJVIprB0vf9tjlytSxU=;
 b=a+84LJeEqGOuAEFbr6wmv2dNV0ulJuM0s2qvEktfyJAG5uyqo2xnOaHMIFjEOmtD6nc/SMq+N5z8dNVLuLENqWXJhBGf5G7HMqlndex2TS+/Xt14BZeYb59G745ypZAhmPyIHeEiEZ3L1q67yTJahUEatprCG/Yr5vZfJ4ij3W6tuV1RNzIV+IZ3a5+jfu3iNJgeXY4yKEfuZkk6eDW8alHHKcGQxCuQeprDkF1gZ8hKxbHHflHKz2nqn5br+UqiaIn1B5XxfbsZeBIZqvhfbb81nhil53u+jnVxgmZxzUV2b21mQZ8Jzt+HQqBquR6MbWou4rO0AhKpshzxptFUqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV5PR12MB9777.namprd12.prod.outlook.com (2603:10b6:408:2b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 03:39:58 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 03:39:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Dec 2025 12:39:54 +0900
Message-Id: <DEMKGE8GI716.EVHQMIKCKQKX@nvidia.com>
Cc: <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <dakr@kernel.org>,
 <linux-security-module@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: security: use `pin_init::zeroed()` for LSM
 context initialization
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Atharv Dubey" <atharvd440@gmail.com>, <paul@paul-moore.com>,
 <jmorris@namei.org>, <serge@hallyn.com>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251129135657.36144-1-atharvd440@gmail.com>
In-Reply-To: <20251129135657.36144-1-atharvd440@gmail.com>
X-ClientProxiedBy: TYCP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV5PR12MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bdcb81-5367-4d7a-1af6-08de308b4c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHNVRjdFSjBLbzNGbmtSSWl2emJORG53QnhHc0p6U2pJTzFiZG1Nb0htbllu?=
 =?utf-8?B?UVZ5NnpVUTVNM2VBUzlLcU5ZSVhHZnJyZkc3NFVuWmdSdnlBRDFuL1dYekVN?=
 =?utf-8?B?bW40c0taYmxOMjIxQ3V5MWRDMFRaNFF4OG13SHh3UDhJNW85YUlQVUlud2gz?=
 =?utf-8?B?ckN6MEdyV1kwVWpEVVdXZFIxZzlSemhCSi9UNnMzREZ5ZWdGQ0xKbE1uQUZF?=
 =?utf-8?B?ZG5lSDRkdFlxZHNlTlJYMGJ3eGtxZmNKaFMxZmZrbEMvcU1TQ0pRZmtJb3RX?=
 =?utf-8?B?T2JybDJUVVJnZlBHU1VvS3gyekVhamVhNzFIU3FzNUdmYlQ0SllPY1NySVlR?=
 =?utf-8?B?QVFZY1BGWTVCQkdpQkZUUVlxVFRSdUxMSmpmUGl3VFlWNXozaW1ScWkxOW0w?=
 =?utf-8?B?RmpkRVR4R2hwVFNyekZsTnNWcCtwVE1aUWw1S0ZHVGZVR3pKQlZCTjJlSWho?=
 =?utf-8?B?cnJGUmJGK3VmcEg1bTFvMnVkb3VHSUdBSzNzUStUSGNya0NhSUdFTDlFUDd4?=
 =?utf-8?B?QUpUTndmWDZaV2VXOTZRb21MaDU0NFZlU0lQL1NSVjcyQkRvei9KTEZjb1U4?=
 =?utf-8?B?NVEySFp4OFlybUhDZ1h4aHEvQ3Z3SzE3QzhVcjYybFNUZmtpNHVLS2U3YUlD?=
 =?utf-8?B?bG5LdFRoTTRPcUc3RmJVTFBIN3FURkp1ZjRVcXZGbUQ1cmJLMy96RFFSQmlO?=
 =?utf-8?B?bHllclUwbDFZSWdEMGFBd0xvQXlCNVZTYVNVTnNYeS9JRkxZaDNRVEpnYmFM?=
 =?utf-8?B?amZpRjQxaW5UZDJxV2FuMDNMYUdqek5hbXFyWWowZXkzaUNGbFplU2RxVGtR?=
 =?utf-8?B?M3RtYnNwcTh3NXRsZDYvV29TQkJkU052OGZhQ0E4R2tFSEZxZnk0NmhwalpP?=
 =?utf-8?B?NTZiV05nV2NBOERQOWR3Z2VRTEFiSmxsb1haSjJwQVJkcjB2Zm51dXRzVjVP?=
 =?utf-8?B?bHlxZTRpWkNESnVwQjF1N0VuUkY2L20reHdEVjZWZzZiRnpRRlNQYXhMM2E2?=
 =?utf-8?B?elVHQ3dOaHp3YkNvV3FpVVFpZFl5c0FlZ2hGNnArV0JLK2JTSXR6aGhBdENL?=
 =?utf-8?B?cFpGTE1JWGplNERKc1pMcmdyQndabTNlTjA4RWpLaWlTMCtNVkhVRWo3YlBz?=
 =?utf-8?B?cy9tTlFFU2JLYlZtQUE2bXhzYkRQL0hhRVEyTm40Z1JBdmhnUnBYa3pWYXB3?=
 =?utf-8?B?MkNBcy9lbnRScHBvUE85Nk05TnJJU3VuYzZhZ2RPQk45WHVJMEZVaHVPV2xs?=
 =?utf-8?B?dU8xMGdaTXQyZUhuS1lFR2pPY3ZmdElSVzFJYkN3UmVDcTQ4b0JQM2E5MjJI?=
 =?utf-8?B?eG4wVmk5eG1uOVhvbWYwd3kzbVprR29HS3ArcmNiNi9iZDIzSEdNWVVIcFg1?=
 =?utf-8?B?cTBxcFFVREdqemRuQmFyaitmMHhmRjJWazN4OEtqemRwM1ZiQllMTnAvYWds?=
 =?utf-8?B?emNaVzBycUdUN3J3QVFSYU54ZE1YV1hYa2pWOTJiTmZkdkhyLzlVaUd1VmFw?=
 =?utf-8?B?WFVJZHZ1eHdldWE0bzZYbVcyWU9ULytjM05BY2hXeTRkaW40QVRTWkRwY3RG?=
 =?utf-8?B?b0NXd0sxV3ZXbDUycGVOcEYwcE5hdDllV3FJdFJRblZ1Y1ZVYUw3WVhzTmNO?=
 =?utf-8?B?SkpaUG9ZbStJR0dMdHZTdjVBWXI2eXBFRVYzRUJ2NmdDOHRhMnhNYWUxYjE5?=
 =?utf-8?B?c29hUDlMTkVEb0c2cHpNdDlUMzVYMk1zMjN5OEo5b25XRDFHL1p1a3A4TVhR?=
 =?utf-8?B?UlF3UnhPT0RkeHlQSXdLYllpR0I5OGgwOTB0TVBKeEphalJsOEdWV0FkY0Y1?=
 =?utf-8?B?TVdPSVZHSHJ0WitoVVdvaXc0Qnl3amZwcVRsRXVCcjI5KytrcTBGMGRoR3NY?=
 =?utf-8?B?VzI0d3dwYmZ6Zk8yWHZwMlVscHlQSVJ4TExzL0wvRGcvdmxtL1VTR2c1S3B2?=
 =?utf-8?B?WE1UemYvSlRGelNGWDZYd2VOMEYxSHI2TXBrUkNBTitnVHlLaFVhWExwM0Zw?=
 =?utf-8?B?WTR5V0YxajNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXN3Q1lzSlZDYitqR1lxRzRtbko2cEdEU3JPb1RQR1BLcmVSUEpaRXhwcUJk?=
 =?utf-8?B?WEVMS002YW85UG0yRTIxV3RkdUcrN2xxb0JkNzBSN0FSdGQ0Nk9ZMnh5VExi?=
 =?utf-8?B?aDF3Um94UllRZTU2V1RIcC9sQUFHanEza0VuTmZQWEpEd0srUlNaWVU0ek9q?=
 =?utf-8?B?R0FmKzdQUVZ6a1pyYnRyT1J3b1NHZHJCNkxEUWRWODdKT3FaSGp3TnF5dElG?=
 =?utf-8?B?N011RFowaG9PM2JIQVphNDk1YjZrbmhld2YwZ1hmbW00dTFpM2tReXBIdnZ4?=
 =?utf-8?B?UUMwWFUzQXQvTlhKOENOT1FUdzZTUjFPQTIwN1NhU1VkaTd3SVNBOElLRFla?=
 =?utf-8?B?K0FsWnZrVGRqckFTNG1kT0MwRXdQMTFlK3dHRjNiN3lYaW9Ta2V6aTJFTzdq?=
 =?utf-8?B?aU42aUVRc2VCcUpJR0lQOVNuODlsRjJJT1Y5WnNtRytodXZjTnE0RmFad1JK?=
 =?utf-8?B?WFBIVGIwYVMxb0R1VXQrbkhFUnM1MlRCaHd2MG11QWVCZlBCYyt6STRNdmgy?=
 =?utf-8?B?UHpITkJJc21WQ3Z6U1diWmF3aklJckFsQzE1OXFuaDArenZ1STg3VC96Smlw?=
 =?utf-8?B?aTk3ZEZhVW02eS9Tek9LRnRiYkplSEpUSTdteXc0d3Y2Vk9QYlh4b2lDRVNY?=
 =?utf-8?B?YlV5WXV1c0ZVMk1MQVVWbEpNZmp4cmRGa01RcW5mcVljTTY3YWpHK1F4NEM3?=
 =?utf-8?B?YkEza1VKRktVd3ZrQ3dXNWxKYm8vUGh1cUNsOURCc3JtWmtCSFRtcWo3dDhp?=
 =?utf-8?B?YUlBaDluK2hkb0h5aXp5cXlIT2ZZd3VOYTVtZktJNy8zOTh3WEpWeVdHNDdX?=
 =?utf-8?B?SVhUbGQxN3AycVZmV2FnV09EK2VMSGszR2JTcEhBWjhjRndMR2tLRVVCMjNt?=
 =?utf-8?B?T2VtNm5xU2VocEozN0I4WmhFZUpWU3dZU25IbUpjTzNOMWRjYW8wZDAzTVVq?=
 =?utf-8?B?WU5WaVdBOHR0cHRHUnRQWjUxSUNlSis1dDJRdEhHRGxLWDRabUVrRTFUZk9C?=
 =?utf-8?B?S1RBTS9CcFdYUUZoTWZtUnJyUGVjRnBvSjhPelA5dTdUMVNrNmpXRWtQN3RN?=
 =?utf-8?B?OG90MVFkKzVlTGVDMVRXV3p1VXBXb1MxaWhQNURLMUVEU2U5UXdmZmhMeWg2?=
 =?utf-8?B?SUJQNkJtOFdXRHplajExVkhxdnNHSnV1SlVJM0g5cGc3RC9QVmNmS2YvQVIr?=
 =?utf-8?B?T2dWQXYweTlyaHA5dE1xZW9hYzJFUVpkVDQrWWdkSUU4SjU0RnJOYWpVRy85?=
 =?utf-8?B?NVdVRFdSYm5pemlKUGs4MjdvQ29rbWZtN045YmFJcWMxUldPK0ZkUnMyNGRR?=
 =?utf-8?B?MFVUWVlxbFdobmZNU29yTm5ZUnl0ZE9XVnV0QmRBZWtxTVY0VGhaTmpMMmo3?=
 =?utf-8?B?dXQvK2N2UGVGWVg0d3ZvOGxrUzdMa3R1SWpXUTJYWGJReEt6RUhobEd6cC9U?=
 =?utf-8?B?Rk8yeFhEZUFkSDVJK29OMkxwVVJxT1VWa0dUaUxyODk2ODRSRHZGZFZ5L2U0?=
 =?utf-8?B?WS93ajBycW01UVRad1ZOVWdjbVpGS2tycDZ5UUZHbXN4cFdWZEM4MllFTnN6?=
 =?utf-8?B?Rm5iUkVqYUFsZSt5QTdPM1lneG9TdjV3WWZJQUlEanMvak9wZHAvUGRmVThz?=
 =?utf-8?B?UU9iSUgxNjYzRzNkaEVoK0FqbHdVcUoxL2Qza2JTeitHdFg3a1VDZUh0Tm9U?=
 =?utf-8?B?Z2VnVUdlSElPNjBHTEExT3ZNQmpGeGhQSVAyOVFyc0k3S1ptZGZIT01uSmxR?=
 =?utf-8?B?UVlZUGRyWU96QXpyclRBRkxxQmR3UGNFbnlBME1ULzAxK1pmZHNuQVkyWGJt?=
 =?utf-8?B?OFJXdW1SVjMwenZtNng2MHVIYXFUK0llV3BTTUZnVGlSOVBmaUloQ3FGbFJa?=
 =?utf-8?B?aHcrOTdQWHpWY3JiYnR6OHljZHVpQUFicUp2OUc4SUcydGVnbThGRHN2eW9M?=
 =?utf-8?B?SytyYzBxeWhmODBMR3VBOFlhRzJLR0RnMUxtRTVsUm5Ya2hZd2pKWW83bzdR?=
 =?utf-8?B?LzRHSWtlbll6UC8wSlBNTUN2bzl1azRDa1JZTlpGaUZoWDdMY3JHY2U4a0ZP?=
 =?utf-8?B?YzFaOFk4WGdpM2t1QVFwcmg2a05nZDMzLytVT2NoMUkzaDhEY3lJUWRCRC9F?=
 =?utf-8?B?OU9zMFViKzgzdUJ3M1BhaXZPQXViUVJVZ1JNUlhXbWE4YmtUcHc3VjlTSis5?=
 =?utf-8?Q?DPHoI+SVUn98S/PCFVnJNsPrYXD3Ltlhfp9hXRV7z1Uy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bdcb81-5367-4d7a-1af6-08de308b4c9d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 03:39:58.7808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOHMtERWRUSRjl8bfuInBJ9lSbbFmiGG9a2Y9xZ62da2uemyY3qQyXqYhi180C/k/GiLL5IyhHJanrNhRFyMzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9777

On Sat Nov 29, 2025 at 10:56 PM JST, Atharv Dubey wrote:
> Replace the previous `unsafe { core::mem::zeroed() }` initialization of
> `bindings::lsm_context` with `pin_init::zeroed()`.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1189
> Signed-off-by: Atharv Dubey <atharvd440@gmail.com>
> ---
>  rust/kernel/security.rs | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
> index 9d271695265f..4dc3eba6ce84 100644
> --- a/rust/kernel/security.rs
> +++ b/rust/kernel/security.rs
> @@ -62,8 +62,7 @@ impl SecurityCtx {
>      /// Get the security context given its id.
>      #[inline]
>      pub fn from_secid(secid: u32) -> Result<Self> {
> -        // SAFETY: `struct lsm_context` can be initialized to all zeros.
> -        let mut ctx: bindings::lsm_context =3D unsafe { core::mem::zeroe=
d() };
> +        let mut ctx: bindings::lsm_context =3D pin_init::zeroed();

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
