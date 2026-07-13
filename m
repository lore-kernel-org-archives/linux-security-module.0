Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020137.outbound.protection.outlook.com [52.101.195.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1479F435EE9;
	Mon, 13 Jul 2026 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950901; cv=fail; b=DEg4/4KGHZN8D/1Gvj/xD3tJVWsKBgTqRyTl0qmDSMlcxKI0IKiCIwdoDk338tnCJgO5f6Q2K8GBjiubAZzLf+UP18gLzWg5CLyd2SIMF1Tctcz9TVBLWq82Ut/kGZIyWOahXqIRqOsEcM29jmoG2JNREUwYzRb9w0+LRMJja4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950901; c=relaxed/simple;
	bh=+i8sJw4S43s0m7nny4Q65u1RHcbXWuK59+/+g0o+lkU=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=bkeKnPQRszoOlkw3OtZpDNN0nYOWs/D0z1ul2ZMhKLf93qvPohS9fEaF0dhnSqx29rWstUCaFY4upsGS5ymArqg7GbAmh9Kt69NeJ05y6WoHRlt2ozHASybgay+bAJcDzzf5hTTM9mMRb/pN7LKwQSX/wd87J36iSeuFBxuH90M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=kPuwcDsU; arc=fail smtp.client-ip=52.101.195.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="kPuwcDsU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjTckaSNq9rV/MVPJCQDNlqP+2fWIdHiLjdSdipjhZ0SPZ40vwqDn97JPr0gN17Xwi2si8EKieqRWPIhmoDT7WbFvqx533iVfCqw78sPYbDF00CAPngfFuI7HU4jNfG8L9jskCZZLLTf/UpVW3/LHD97ohrpPEj9tGOzLaZ06M7ZZfv/9Euev2GbogVJ7IELTqBQjVA4aB4z+ev/foMLQudqSCXaqFcDkHLfdsBNUd/qBQ6tINcHX1IsLS5LC2eUddoRRb8arO9tS9dtqiK/SUJEhuoXz6VsuiDq+uNb09GxakC90zUwBuIYw9UBZxwnXhIQ3iJrh14GCcXAp1HHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1GDEtV4QAUXkWqdMRGaZ/c1d5OUfiSiaBHhbuvrXko=;
 b=Rsnfk78Iq9hb0P4TFtg3YfsGLUi80Z/4Lzv3q6tButJAVtCMQq5DM+lIFtGVnRB+iZjDxRhNtQqCG8V6i7MQICEBRl5yhUXBSgVwsDsza9e6cwXgq/PfDsDhE/9FQJtM9DLF+7cq29EYwZDvuN2lqT45in+B0YqqHgLvMAvtN1z7xZE8OG/Xrvv/gmpffsYrXFBprqAUm6lZV2ZYamKMT5wLKakEdeDMd9fTLmrOpcBN4Lu6EXWuvfOnsMHtmP6nFupJ2wMMZiBbVJMY9HKPR5wo8Kg5qMwruykMlnV1GOs+wTfHiCGCbJAoAwyA/iHtv7UyuKF6R4/2jI6/AhznGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1GDEtV4QAUXkWqdMRGaZ/c1d5OUfiSiaBHhbuvrXko=;
 b=kPuwcDsUGtqxI4rwqNxjmpqikr1TFS1IAcWr8itBNOaVQHpowXcaIgfFZ/jWGx0eoDhXe50B6d7Z5qSHkHTpoy7TcgSCmbeyayydtx/Eyaai14m9yKyV15Lxlv4vwjBVX4lFNvfoiOTI4k2MtbWMExzSlYiaUE5o9TXACbsL7VE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO7P265MB7462.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:41a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 13:54:56 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%3]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 13:54:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 14:54:54 +0100
Message-Id: <DJXHTB615I2J.POTXT6L2LM5K@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Mark Brown" <broonie@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>
Cc: <linux-hardening@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3] hardening: Default randstruct off with rust for
 better allmodconfig support
X-Mailer: aerc 0.21.0
References: <20260702-rust-reverse-randstruct-dep-v3-1-e4e09c50014e@kernel.org> <7cdb2407-924c-44a1-8c68-917efadd4e92@sirena.org.uk>
In-Reply-To: <7cdb2407-924c-44a1-8c68-917efadd4e92@sirena.org.uk>
X-ClientProxiedBy: LO4P123CA0531.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::15) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO7P265MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a9676a-b894-4599-e9ec-08dee0e651c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|23010399003|921020|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	yAC5yylWk9j0/c3rCE8hdaO5Rs8vytxsBx9Ljzf/v4EBSxuOShQuvD/isXFv/h6xhAKh2YwlbJ60ry4awRT9YjaSn4sxo1C81h5uuMxSVLe0YSokNe9XQ9l1IRDq3sUDjhugy2Nfv2G0CuzEgYCfTxNvZHGvdLEWPu4w+rGvn+pyCWzVUdHosIbP92NmjVd09VP43otskyWsAAVXVkbNnswAzLdQCactDPB10+bMcvdYdgdD0zE6b5O0g3nKSXhwK7cWL0FreSuDhQ72181kdi/1PwCimbf9YovsB0srKPHDGuySpbeNeEnAKgPUgpuy34vpDwFsFe2F7lz4iIMqbAF1MiHFV61LrnGlRHcScb+StbaOyGooFhDWsRI7s0DcMnyqLwZPkd7bWSSMm1KmOeeHaQFrdE1/M4E7lqJl3ga1qDRsl5dC5oSlXWwn/GJtzAJUKG3Nu6p9uEgT+yRKZ9wh3MFYw1sTX1R/V3AeAPotxDp5TZkaaYtSXg9/p8iZI+aJp5RnUNsUysFGatG++5X4E5Ck3TJqEh+tVamxRGaVPTb9vo2DU5+vMhMtaPy4dS4TRIJ0feS24Y8btlJRXFPj607lR3+Mc0o+Elkh102rNZziKnQdS/Uvj5KFj/x2VlTKbQCuMYblVMro8K3V1ZvJXci7V9+XOB1DbBUrbpueQCMg0MHEgcmGsOO1iSnpLl/oF0yeEGErGtGr4wuqCw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(23010399003)(921020)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjJZNHVhS2hJVzRseGVBNG9CVElmaHZ5ZytsVHZDNkdxajVxUWF0YnVWYm1q?=
 =?utf-8?B?ZGFyN1kybGhURTE0SkpIb21wTWpVWkU5a0pjOUprZzE5SVVwTmQ4TlJaN2wz?=
 =?utf-8?B?OUNuczdkam9zeWVvQ0k2UTR5Ni8wR0ZKU1RmQ0J5WDh4Q2gxdmFibjhNME14?=
 =?utf-8?B?eElJb0o1djJWdWs0N2k1cWdRcThVcFc0OU9MMDhLNnp0cEpmU0NENC9jMjM4?=
 =?utf-8?B?M3E5SGtSV0sxN2pZL3I5cCs1NjI3U3VRNk9iNno0Q3lBVUYyc0twN2VDeWh2?=
 =?utf-8?B?OTNkYzZzbk94VHE4L2Jiekg0Z2xHR0h4NHk4eUpSM05tWk1vR3VuQnczNzFa?=
 =?utf-8?B?ckF0c08vRk13NzhtZzJadVB3Q1hSVW9sM0hHdFpKd2V6UWl3NWloL2oxVXZs?=
 =?utf-8?B?Qzc0Qzl6SG1qSTQzb2JlMTFDMEVkQTBpTWFRd1RtM1M5NHE4NUNxd0F2dmJC?=
 =?utf-8?B?TnZMZ2NQaEpBUkJTNTFpWDVHTXA2SHZPRVYvQURienJ3bFR1NVNVT3hCYTdC?=
 =?utf-8?B?SlMwcXZ6Wis2VXdJWFJ4b3NLaW9BUDMyS2tYd3dNZFJQV3U1dFo4ZXRscGFX?=
 =?utf-8?B?MzBaanByR09acUppSzJJTjZ3QkhaYzRaTkJ1RXE5SU1QN1QxZUhDTmt3UGQz?=
 =?utf-8?B?RnhuYzM4N0VrVGUrZVRSbEhWaHFsUk5HaTY4a1Rva3pwcmpMOTNiYkZWZnlv?=
 =?utf-8?B?djRHc2x0c3V1UDQwUi8rSE1MVlcvNHlqY3JlM3UvT2tkV0M2by9KWCtEcWdx?=
 =?utf-8?B?NVZZSUxMTGFaa0kzaUtzeWNteENnV29EZVhsdUhXYVVzNzNRMDBzc3dGcGpo?=
 =?utf-8?B?ZjVURUtLT1J6dmJjaFlHRVp0OGovWkl2ZkptTmk4NnFKSUUrcGp1SXh2OU9I?=
 =?utf-8?B?Rm43aU93bXQzRUt2ZERtMEYrcUFxaGM2L1RON2tNL21rYXBtSW5oTHFlSzFi?=
 =?utf-8?B?ajBlajdKQXN5Qmp4K3BndkVxejZEcVlyS1dQa0NFajRqNkN4Rzd2dDY2VU5w?=
 =?utf-8?B?LzhmbW9ZdXo5aGlwR3dzNjVZTkhHdk5BU1NyNUdZd1dWYjFqMzJtMjZyYU1K?=
 =?utf-8?B?NW1aSFI3Q0RuOGhtYm9xeHhiaWlhYkZES3psZnM5aytPK1FKQkxRNWxzVjhl?=
 =?utf-8?B?K0dyMnhLTDRPZWZWdjg5bkxKSWVqT21KUDJ5MVJaSHNkbHArZHJaL1M1SUt3?=
 =?utf-8?B?M2hpSXZab2RocmFjL2VBc3plQXJUalNEWGFVSkhtdzlialhnK3NiMWVoODBl?=
 =?utf-8?B?b0Z1ZDRpZ3hNYkoxUW5KaElLbnIyOVBoTTlFVUthbVFUTCszMlRvdXQzZ0VQ?=
 =?utf-8?B?RkpTOTBtSnVTbmkwZmkzdmozM2NXSUZyUWhyd0VRNHpjRkVubURKVW5uNlN1?=
 =?utf-8?B?UXArTlJvZWxPUmVhTG9zdmt1ZktaUW0vY1dsMlJiZW1MVkd3c1JaWHcxNGtS?=
 =?utf-8?B?dUNmanVXS3pGOTRSaldlcEZILytLRWNRYzMrS0JIdGhNU2tXd09pZnpNaXNC?=
 =?utf-8?B?M2VGL011THY0YmNZTVBhRGVVS3ZlWUd5aVBiWnhRTW5QT2g3QXkzcmI0OUtu?=
 =?utf-8?B?MDZOdUtQZEpQTE5lVlpPbHhrK01KMmovaXpCWnZsbWpnWFlnSjhDbjVKOU1U?=
 =?utf-8?B?Q3hqYWxCU3B1QlZGK1NQSUhOdE1VNFZadG1SYzA5MlhkRkxhQVllMzB5SGEr?=
 =?utf-8?B?M3pUS0pkdU1CUXlndUdJNUMwOSt1dHpRZFpVRmhqN3J4WEtwTEhzaDBnRzZZ?=
 =?utf-8?B?b1NFV04xYVZ0Y0RDZTRoaW96KzQ3U3dQcTBsM3Y4SmdNVm81SDRjWFdhYnAx?=
 =?utf-8?B?YUJaOXY2VFk4MlloZXNQak8xa3MxR1phblFrN21pZ29RK3BuWEFsRG5JdHc4?=
 =?utf-8?B?SExnMVJJdFJoRDhDYnBaeTQ3L1FpKzN6bUg4aXQyNkNnQk1NZjBBSHgyb2dY?=
 =?utf-8?B?VWs2Z3JqVmNrZ3hSTmpqck8yd0o5QmVxZVlIMXBQSFhMaHZqdnAzZm83bVZ1?=
 =?utf-8?B?R2FDZG1Nd3lqQTV5a3lZYnNVMERGNFB1VXk2MTF2MWFnR2p0MGp2bmVPUm9v?=
 =?utf-8?B?YXNOeVI3TkZHWTIwVExIcE5TcnYrcUR6UUxFOW4yNDdlQ0R0anZFd3JKWGhL?=
 =?utf-8?B?U3JxR21XRTErdHh3MHdHbjZ1UGdKOGpvc3JoaEF6dENvQ1ZIR0xDc3VBenBK?=
 =?utf-8?B?czVYa1FMaXBBVitINDR4cytDY2dRMmo4Y3lBYUxqODZDdU1vZEFmdXVjUHVZ?=
 =?utf-8?B?R0VzTzJEdXFkTUFRTUYyNnFmQlEzZGx5S3VOcm40RWJES1Ardzd1d0tQUUh6?=
 =?utf-8?B?QW5RUk14emZtMlZEWG9heHNmRzhIY1VzVys2TEJnREY5cmkrakt4dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a9676a-b894-4599-e9ec-08dee0e651c8
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:54:55.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlSF+RmzshGm2uPHRM3EqwRGX6Yvkoq/QSBCXApQaMqeyMKx61/bEF7GoHJB776kC9ws0jDeHn67eA2fMUNSNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7462

On Mon Jul 13, 2026 at 1:45 PM BST, Mark Brown wrote:
> On Thu, Jul 02, 2026 at 06:37:08PM +0100, Mark Brown wrote:
>> Currently randstruct does not support rust so we have Kconfig dependenci=
es
>> which prevent rust being enabled when randstruct is. Unfortunately this
>> prevents rust being enabled in allmodconfig, our standard coverage build=
.
>> randstruct gets turned on by default, then the dependency on !RANDSTRUCT
>> causes rust to get disabled.
>
> Any news on this?  I'm flying blind doing -next merges of rust code with
> build coverage gone, and I suspect a bunch of other people think they
> have build coverage in their tests but it's silently vanished (I know at
> least one person ran into that already).

I thought Miguel wants to add support to properly support RANDSTRUCT with C=
lang?

Best,
Gary
