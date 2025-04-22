Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA6A2DCB66
	for <linux-security-module@vger.kernel.org>; Tue, 22 Apr 2025 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745353908; cv=fail; b=Mef0oEjuFzLMDFsijKIMIx5MIbFlY7oMgLznJjlEOWFoAKO46raDzNXra0M8WsrCPZzvcnMYr/vaZaS7DtxTAUoTG68hrbgKn7/nMa3GzaAxtcila6N6u6M5JsVKuQcWvdAxGUS3ktUhVx1kHTpc38isreqMVXywcIfuBhNCfbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745353908; c=relaxed/simple;
	bh=1Ky4FSJQ9063UmT2LS0FZ7Ir0W26mHpEjMOP/zs0wLs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M30cLvQhkT77C3212MdFVCQVryfwWO1X9kS2TLjdshWzkY4xkhr7RmfYv/XiObNZSSk5ljkGRyITGiIe78/G41RMuq2gHY4qQ3IE2E4XQpGF2nxjRnjjeCQ/iDzRrSssBb8Fj1OjVcYYckvUIcwI6xJK5SBEyN8fqBpUusFUIY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RiLEcWfi; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RiLEcWfi"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MIM8V1004355
	for <linux-security-module@vger.kernel.org>; Tue, 22 Apr 2025 13:31:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=1Ky4FSJQ9063UmT2LS0FZ7Ir0W26mHpEjMOP/zs0wLs=; b=
	RiLEcWfiimY4VZbpq437GrwH7GfiuaKulwGbXgyhQ38yzeUwfdRRyGLx72pAbELF
	tUYIW7y6NXZ3OiWaEc1h2irmX1sFfK+UV6oS6QsqxpnOiXhVuBLuBLo76P+lqe1z
	weSmK/3jMEGW2QBC5L9ubK0JwqgSkFzUGyu7vYBeu4VUnri+8YQajc+/fZPhT5SU
	v8dmR4wq1oo7zh2o7fV0qssvNRDoK8Iq/tQjwvPEpLtBOpLp0hXZH61cxpLYX7eQ
	iBOZDoF1JEdyCCan3AIBRXkuyRSYSb3Y32OB7tEshQszLn6NfH1StqiXTlqNoAey
	f5QNtf/B+W8JnYj041Dpjw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 466g3b98tb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-security-module@vger.kernel.org>; Tue, 22 Apr 2025 13:31:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdE0mTueuWZ+IuylGssnj0lR6vXyygaFw2m/hqmcTIHu3yb/AVwv+sqiIzOzwWodoexbir0U8W3J3rPRExh8gKDoVbxWOdXYbGBdQ8QawbDj2uj/CScxk0vlYvgyv25tjANSDsYhZByBRg559q3ZqZJy1kp+O6qHlsNjDs9L7tfyXOs1zLIO8Cn+EnLS3dK6NsjOHRra8rZxQIe0vUfOaweHKmwgcp+UbPyeR4XRGehRnsBDVckc20/XEb1njzNX5lNPxHqy8lOlPvIu0/k4Ujw1lXM0wB3r3RFCyxN4JLiNpmRfbjXLYO1lO2H+y8fa1bWeqbut3xhme+ix+PcB0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ky4FSJQ9063UmT2LS0FZ7Ir0W26mHpEjMOP/zs0wLs=;
 b=ii8iRVunU1f6Z3hpeXcg8Y1lQUr1SwV6/zHouPMbD2/JG3oxnwcHWSS80Qa7gNlJ6nkS8SLS3UeuhbWYNM1w5V8JlQoV6gXgWNGwd/1urUMlJiqZHPT9DWCuaPe9UuIrNA3G1x8tbunpiCy3rIQBILNudSh+0byDrwLHvTWrkp790pQIpSYZd1Rm3JC9jathBWlMuTTejrkdZ21yEHWaeh/2gSoKyO3pQoYxpd2P4AyHqPB/NNIspSB6AkVd5/jVvz6f3ko2HFw9h2UnsF9KAshTslNqM+FcCUyIUfta4Oyb7cDe7mXx+vZKSjwpS80NCkABG/nWKQ0q+S9Ro1p2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by LV2PR15MB5336.namprd15.prod.outlook.com (2603:10b6:408:17c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Tue, 22 Apr
 2025 20:31:42 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 20:31:42 +0000
From: Song Liu <songliubraving@meta.com>
To: Paul Moore <paul@paul-moore.com>
CC: Song Liu <song@kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "jmorris@namei.org"
	<jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Kernel Team
	<kernel-team@meta.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH] lsm: make SECURITY_PATH always enabled
Thread-Topic: [PATCH] lsm: make SECURITY_PATH always enabled
Thread-Index: AQHbs7aOIBtSOHMWUkq0IJkxn3NAybOwGPSAgAAKroA=
Date: Tue, 22 Apr 2025 20:31:41 +0000
Message-ID: <3897DD89-5B9F-4257-B273-A4DDEDACD56B@fb.com>
References: <20250422184407.3257964-1-song@kernel.org>
 <973cedc0d38496b2096992bf68c72e67@paul-moore.com>
In-Reply-To: <973cedc0d38496b2096992bf68c72e67@paul-moore.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.500.181.1.5)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|LV2PR15MB5336:EE_
x-ms-office365-filtering-correlation-id: ce8193d3-3a6e-4b43-f68e-08dd81dcb10f
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eG0vTjRhWUljZUo5YnBmMHFwWHZPOXRUQmFSZ2JRd0s5K0FJZ1pseE1uOGpk?=
 =?utf-8?B?UzdJTGo1N0lGZkdYYlJocFd2ZmNyNXZtUytManMwRXA1ME02ZnpNeVlxTjBU?=
 =?utf-8?B?Z2xBbGUxaHhCTVNzbHZLdnhuL2N5K0dMR3puelJjL3gvWHAwUzkzdlBXekoz?=
 =?utf-8?B?WElKSjZMd3dCNEtkenEzcWx0R25ZM3ZRcDlmcHkxZk8xQzh1ekNxR3lpVHhD?=
 =?utf-8?B?VCsxV2xPNEJJV1FJejdQdzdTNnNVa245NnpPcGVxQVBoWXBDMDJ0cTlwZjNI?=
 =?utf-8?B?OW5VZHpZTWVVUDc5c3BkbHlhaHZoSXhwb1FoZ2k4YVF2VmVwYUJTU3NuanZy?=
 =?utf-8?B?ZUpIY2pKblkvNXV6RVZvZVhZbVN0ODliVmRrT0FLRFU3akhmamhRUGtpNTZx?=
 =?utf-8?B?SENYS1RuRHhZMVJxRkhpVWVGdWZmVUlJQ3FHVnlOKzZQWTVPQWxqQURHc2ZS?=
 =?utf-8?B?UVQvSlg1VlVBUkVjRW12cm9iWkNHSUZ6RjVudU42SWhWV3gvMmg0TjBXL2Fw?=
 =?utf-8?B?dTBudGluZ0lsT2h3Q2E4SWlsMWMxQnJMYTY2Tmt0WHpkWE9DaGgvWVZ5Z043?=
 =?utf-8?B?VnhZTlBMMmJXVXFMTTU0NUdwWU9aL29RUWVVUjQ4WGVMUVcwTnJ6WVdKRGI0?=
 =?utf-8?B?Ync5ZXlXTVp6aWZsNTFMWWN6Qm1QaStRbzBtdE5CQTNCR3pQUXNXdWljWmhj?=
 =?utf-8?B?bzJ0QStLVmFwY2I3M3NnUWtWYkVBemhNZzJRL1pyOGM2bVFrMUhOLzdJS290?=
 =?utf-8?B?MmtLbFM5b05uTTZSUmwyWEVMcmVZRnhvTUowNVhuNXlSenQyMVl3a2NreTM0?=
 =?utf-8?B?SE1tMUVwWFkyaHpNQmx2VUtONDhGUGhrWVpKSHE0SzRQZEZuR1R1Ujk3QmV1?=
 =?utf-8?B?eFpIbE54RC9ULyt4eDRid1RJTzJ6ZVUwOCtTK3FYSW1MNEg1a3E2WVhGRWRL?=
 =?utf-8?B?a3kydXhhNG5pczNIbkcvRitiWDJ2Z216Rk42ZmVVVWpQR1l0aE44SHBDT0Zk?=
 =?utf-8?B?di9BM3lZMVNyTGIxMGF0NkhpTE5SVW1BUXNJcUxIdElnUEFDZ0x1UzFmbW1R?=
 =?utf-8?B?NTZtREt6NEQ4S3RqN2s1OGJnRVhLM21iVjBScFNsRzhzdFUzRUNrUktVc1FO?=
 =?utf-8?B?cUoxWS85c0U0ZHpWQitQNGRDTFhnRUQrOWlWMGMzcmZKbzN0dSt4a0hhSnAy?=
 =?utf-8?B?ZElpdGl6Nld1aHE0ZXRvbFhrLzUxUmpEUVlCYm81aHE5UFd2UjhFL2RTaG1P?=
 =?utf-8?B?bERzN2l2MUJGWWhWcjZCVUQwK1NXb20yZllFUWEwTDMxTVVEeU9BVkRVNERJ?=
 =?utf-8?B?MTd6b0UrSHo0UXg5bmJHYVpLWkxSd1VkQW9WOUZia055c01YbDNDdUVnNFUx?=
 =?utf-8?B?NWRIZnFLN2J4c24xRFdVOFV6RTV1SDROSXhKZU9VQXNTU1lzRUxRNk9kWFBY?=
 =?utf-8?B?dFV3RkY5cVorNm5HNWV0aU9IejRmMUdiNXUxL3BveVlBOHNTZWtnN29CUUFs?=
 =?utf-8?B?QXJCOENiRnRkb1czZlNFTnRNU0p3MkRHb1ZqbThQSFgzUlBPY2xrQmtDc0pu?=
 =?utf-8?B?RGRCYWRpNmcwa1c2bks1VHFyREVCNkNTaXZhOHQzQ2o3ak5lbE9LMThOZWQ0?=
 =?utf-8?B?aFlmSElybHc3N2ltbllJRVJWVm1yZFFzMFFqbWlHWjE3djZ1UW9YR3ZVa0JN?=
 =?utf-8?B?enRWM2swWVhqcC9zWmszVUdLcjh4T0s3VjlaZ2lBRFBTYzMyNloyMGVSMFA3?=
 =?utf-8?B?SG8wUDROZE5ybFZ1MEYrcTQ3SG13ZVNTWVRReU5tZVc1QjNvekJPalQ0SFBE?=
 =?utf-8?B?ZEljTDg4K0tqWjErdnY0UTdkVzR2ZFBWM05wWitYUHRBWHdKOEFuL1FDaEVh?=
 =?utf-8?B?RjJyMjExdmRlWmIwVE9VSCtEUzNueE93YU5uOEtMRFMzMkFNZmM2MXNVOWpu?=
 =?utf-8?B?WW4yZkN1VC8rYnhJK0ZwNEZkOWt0VmYxbFR6TDlRVHcwdDdDVDJVZ3VRbUpm?=
 =?utf-8?Q?Qg11zwUCMvFZ/z8diRrXKacPBGy124=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y09RTkMwNytTTG45RlhpV3RIekc5Y05tb05WK1V6NVczbXNVZTdTRTl3OWFs?=
 =?utf-8?B?UjR4UGNtTkZvUVFRQS9qNWpQbHpZSWVvT0lzb1l5L1FSNlpkS2tjeVd5M0J4?=
 =?utf-8?B?MHJmM3AyVWIwSEMyOElIQ3RKdTNrcWwzNE4xWG5hYXZXcmFSZmpmbEExMlV0?=
 =?utf-8?B?RWFIQXVOd2UrUnBsUlJWVEhJM2swQ3BBTmE3SWZJbE4vd1hZMEp4Q3g3TllX?=
 =?utf-8?B?UUZwc3U5cEdoc1liZjJCSXJNeDQ3SnE4aG84dW5YZ2Q3UStqSTF5NkhEL2hX?=
 =?utf-8?B?cVVUdklXTnZZOVZxY3lDMERQVFpPSW5ObVhBR2pSMGhyZkQ0dmx1N291MGRX?=
 =?utf-8?B?cGxwenFSZzA3R2lrSUd6bmJhVlMxWlBPak9wamF1SFBHVnlDdDFCTVBmdmVY?=
 =?utf-8?B?MFlNTlBwUmEva2VUSEduUVpYRUtXTnIydHZ4dVMrc3FLc1ZCSnR6RjMvVWQz?=
 =?utf-8?B?bUs0WjZIZ1owWjBJN2V2ai93UlVraDJwSFhiT0RMTTN3SFBlRk5adUhrZi9L?=
 =?utf-8?B?YnRrcFNCMmVTUDRPejFBQjE3VHBxWXRlUWRwdTFzU2c1dGJRTkxrSUg0NkR0?=
 =?utf-8?B?S1Uxd0xTVzRkZ2ZCSU8welhRNCtsS05YL1grYW1XbWJXYm5aaWUxY2VEVDFG?=
 =?utf-8?B?QVNDUDhHa2ZDSjkwZWpJZDJJb01KSmtHRVo2dkVseXNqcEt6OWc0Q21qWktt?=
 =?utf-8?B?UTNPbVpvcTl0Q0hOeDlRRXJ5cTRWN0tRVVhqTy9HcWZSd3l0WXNaeGZPdE9Y?=
 =?utf-8?B?aTQzWFFBbmFiUy9SMnQ1VzlQVkJITWVMMnd4WkRzNFFBSXV6dGZvTm1GMWN6?=
 =?utf-8?B?UkpmME1nRmJWQ1JGUmhNdW85bjBDRVhBdTArWk1zcjFIbDUzRmJaOXE3V1pT?=
 =?utf-8?B?Ty9zdlBZSThXMUpnRjRpa0lPS2s3cEpxRHBIUHpuSERvdk1PU3d3bUJjWE03?=
 =?utf-8?B?NmlpbzFCQjRwaGZxeG5jUVhVaEtDZHd6WDBaaTFDV2tsZzNFMEV3M2Yyd05q?=
 =?utf-8?B?Tm1jMWJ5NDl4WSt4Sk1pbVdlTXY1eEYreVJ5eEJYUXNTNCtSNTdEQmpXMjBu?=
 =?utf-8?B?L0l4ZXg3bnQ2dkltMWVCZ3JlOWpEeHBpQXp6NmJ4VTZVUDZ4L0NBZ1dtNHg3?=
 =?utf-8?B?U2ZFMmg0b3JUVUJxU2NqbjhtTXEyb2JIY1JSMytCK0xvTUhDWUpQSVlMTTUw?=
 =?utf-8?B?eERibkkwaUZvUmVYS0tGNjFDaVZveXdLbWh5N0xPRWsrN2JMK0VVWlZRalNo?=
 =?utf-8?B?TGs2L3IwR2Mzem9DN0R4bHB4eGRWTXV1WXBNQnhkM3VaRy9XbERJQXRhR3l1?=
 =?utf-8?B?WXBGSitjeXBQNndjTnh4dHQvWUJEVVU1OHV2eVpwMUJlS1BkUjc3QWgwWHpi?=
 =?utf-8?B?enI0VFU5MzNtMHFuT3pQMlR4b1E0eURPdVgzZ0ZtQU9JbFV1Uk4vSG9tWmF6?=
 =?utf-8?B?VTAxRGxSZGZtaUdoNHlQbTFjYldsbGRXZ3VOSUVYR1c2Rm1jMDEwR1F3ZDV0?=
 =?utf-8?B?M0U1Vmk1K2VoN01CQ0ZiUmprck9vWko1S0F4MHJZdHBscXZpNmtJT0ZpbmZC?=
 =?utf-8?B?RDVVZXd0YUwyYzVBalJWOGFnZ2dqR3BtTWxiSlNFTDk2ODZ4aHpHaUE5VW9V?=
 =?utf-8?B?cmlmUmtrY2U2N21uMVBIR0xGSUFuS0VxVFBrUmtDYmRJTXlJWFljeUh6Q25U?=
 =?utf-8?B?dUlXd2RyajEvUGd0VzJwd0FHZnJ0RHZKSnBFYkRKWldFaHRKcEpRdEtyc1ZP?=
 =?utf-8?B?dGIxaGpLejMxK1BoSGpVb21tVWZqQ3VLalVHZFdiaHRqbEFoREh4WGRYM0Fy?=
 =?utf-8?B?OVNzOW1WZGVzczFDUVN3QzNoYmtDVzRqWC9QdU5wV3M2VDV4b2pwMVJOUDNj?=
 =?utf-8?B?VGNNd3JmQUd5aXFSYlI1cjM4UUFKQUw2c041MjBXcmhmc1gvbFF2SUpENHFJ?=
 =?utf-8?B?WEJHVzd2TDBwR3d6SlZoSWtsNjdwNFlQRkZJRWF2MHNySm1VdWRKSjVla2s2?=
 =?utf-8?B?UEVRVEljWXIxZzRHOWY5d0V3UmxIOFFMdUJqZUozS251dW5mOVlSRmlNcDli?=
 =?utf-8?B?MjhUUFNWUUFjOVRuRkVBM1NLU0NkVHpZWWdFUTN5QjNndmJPSmgzVWsyeGVF?=
 =?utf-8?B?bDVXTlQxQ2xlS0w1cWU5OW5sTVkxU0NqY2ZRZHN6Sm1VVkVjcUNjT2tHaDND?=
 =?utf-8?Q?f24f1xOVbH4PcmnRZFugDTg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <982855BAD256EE438AF903C5B5C19163@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8193d3-3a6e-4b43-f68e-08dd81dcb10f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 20:31:41.9681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eabgAIv42QAa2ZwlEFgwgDsfBAKEcSLU1isfiApqE3Wr7VjG3q8oqr7zHrJXFpEbXT8C0GKxk0soIdCeXTDlFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR15MB5336
X-Proofpoint-ORIG-GUID: 2WZrRxMM4PEy2f3OQsQJN6pmc5xBRn1-
X-Authority-Analysis: v=2.4 cv=Ndfm13D4 c=1 sm=1 tr=0 ts=6807fcb1 cx=c_pps a=bqH6H/OQt14Rv/FmpY1ebg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8 a=hLYkHyWZc_cH2cqqN5gA:9 a=QEXdDO2ut3YA:10 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-GUID: 2WZrRxMM4PEy2f3OQsQJN6pmc5xBRn1-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_10,2025-04-22_01,2024-11-22_01

SGkgUGF1bCwgDQoNClRoYW5rcyBmb3IgeW91ciBxdWljayBjb21tZW50cyEgDQoNCj4gT24gQXBy
IDIyLCAyMDI1LCBhdCAxMjo1M+KAr1BNLCBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9vcmUuY29t
PiB3cm90ZToNCj4gDQo+IE9uIEFwciAyMiwgMjAyNSBTb25nIExpdSA8c29uZ0BrZXJuZWwub3Jn
PiB3cm90ZToNCj4+IA0KPj4gT25seSBUT01PWU8gbmVlZGVkIENPTkZJR19TRUNVUklUWV9QQVRI
IHdoZW4gaXQgd2FzIGludHJvZHVjZWQuIEJ1dCBub3csDQo+PiBBcHBBcm1vciwgRVZNLCBJTUEg
YW5kIExhbmRMb2NrIGFsc28gbmVlZCBpdC4gQW5kIGtlcm5lbHMgYXJlIGxpa2VseSBidWlsdA0K
Pj4gd2l0aCBhdCBsZWFzdCBvbmUgb2YgdGhlc2UgZW5hYmxlZCBpZiBDT05GSUdfU0VDVVJJVFkg
aXMgZW5hYmxlZC4gTGV0J3MNCj4+IHNpbXBsaWZ5IHRoZSBkZXBlbmRlbmN5Lg0KPj4gDQo+PiBT
aWduZWQtb2ZmLWJ5OiBUZXRzdW8gSGFuZGEgPHBlbmd1aW4ta2VybmVsQEktbG92ZS5TQUtVUkEu
bmUuanA+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPg0KPj4g
LS0tDQo+PiBUaGlzIHdhcyBpbml0aWFsbHkgcHJvcG9zZWQgaW4gWzFdLCBidXQgZ290IE5hY2tl
ZCBieSBQYXVsLg0KPiANCj4gSSBjaG9zZSBub3QgdG8gbWVyZ2UgdGhlIHBhdGNoIHdpdGggdGhl
IGZvbGxvd2luZyBjb21tZW50Og0KPiANCj4gIklmIGEgS2NvbmZpZyBvcHRpb24gaXMgb25seSBu
ZWVkZWQgYnkgYSBzdWJzZXQgb2YgTFNNcywgd2hpY2ggaXMgdGhlDQo+ICBjYXNlIGZvciBDT05G
SUdfU0VDVVJJVFlfUEFUSCwgaXQgc2hvdWxkIHJlbWFpbiBhIGJ1aWxkLXRpbWUgb3B0aW9uLiIN
Cj4gDQo+IC4uLiBhbmQgdGhhdCByZWFzb25pbmcgc3RpbGwgc291bmRzIHJlYXNvbmFibGUgdG8g
bWUgdG9kYXkuDQoNCkkgYWdyZWUgdGhhdCBhIHdheSB0byBkaXNhYmxlIHNvbWUgTFNNIGhvb2tz
IGF0IGJ1aWxkIHRpbWUgaXMgdmFsdWFibGUuDQoNCj4gDQo+PiAuLi4gYnV0IGl0IGlzIHJlYWxs
eSB1cCB0byB0aGUgTFNNcyB0byBkZWNpZGUgaG93DQo+PiB0aGV5IHVzZSBzdHJ1Y3QgcGF0aC4N
Cj4gDQo+IExTTXMgYXJlIGN1cnJlbnRseSBmcmVlIHRvIHNlbGVjdCBDT05GSUdfU0VDVVJJVFlf
UEFUSCBhcyBuZWVkZWQuICBJbg0KPiBmYWN0LCBpZiB5b3UgbG9vayBhbnkgbW9kZXJuIExpbnV4
IHRyZWUgeW91J2xsIHNlZSB0aGF0IFRPTU9ZTywgQXBwQXJtb3IsDQo+IExhbmRsb2NrLCBJTUEs
IGFuZCBFVk0gYWxsIHNlbGVjdCBDT05GSUdfU0VDVVJJVFlfUEFUSCBiYXNlZCBvbiB0aGVpcg0K
PiBpbmRpdmlkdWFsIEtjb25maWcgc2V0dGluZ3MuDQoNCkhvd2V2ZXIsIEkgZG9uJ3QgdGhpbmsg
ZXhpc3RpbmcgQ09ORklHX1NFQ1VSSVRZXyogYXJlIGRvaW5nIHRoZSByaWdodCANCnRoaW5ncy4g
QW1vbmcgYWxsIHRoZSBjb25maWdzLCBDT05GSUdfU0VDVVJJVFlfUEFUSCBpcyB0aGUgbW9zdCBh
d2t3YXJkDQp0byBtZS4gU2F5ICwgaWYgd2UgaGF2ZSBDT05GSUdfU0VDVVJJVFlfUEFUSCwgc2hv
dWxkbid0IHdlIGFsc28gaGF2ZSANCkNPTkZJR19TRUNVUklUWV9JTk9ERT8gSU9XLCBzb21ldGhp
bmcgbGlrZToNCg0KI2lmZGVmIENPTkZJR19TRUNVUklUWV9JTk9ERQ0KaW50IHNlY3VyaXR5X2lu
b2RlX3JtZGlyKHN0cnVjdCBpbm9kZSAqZGlyLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpOw0KI2Vu
ZGlmDQoNCiNpZmRlZiBDT05GSUdfU0VDVVJJVFlfUEFUSA0KaW50IHNlY3VyaXR5X3BhdGhfcm1k
aXIoc3RydWN0IGlub2RlICpkaXIsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSk7DQojZW5kaWYgDQoN
Ck9SLCBtYXliZSB3ZSBzaG91bGQganVzdCByZW1vdmUgc2VjdXJpdHlfaW5vZGVfcm1kaXIoKSwg
YW5kIHVzZXJzIG9mIA0Kc2VjdXJpdHlfaW5vZGVfcm1kaXIoKSBjYW4ganVzdCB1c2Ugc2VjdXJp
dHlfcGF0aF9ybWRpcigpIGluc3RlYWQ/IA0KQXMgSSB3cml0aW5nIHRoaXMsIEkgdGhpbmsgbWVy
Z2luZyBzZWN1cml0eV9pbm9kZV9ybWRpcigpIGFuZA0Kc2VjdXJpdHlfcGF0aF9ybWRpcigpIGlz
IGEgYmV0dGVyIHNvbHV0aW9uLiBCdXQgdGhlIG1vdGl2YXRpb24gc3RheXMNCnRoZSBzYW1lOiB0
aGUgc2VwYXJhdGlvbiBvZiBDT05GSUdfU0VDVVJJVFlfUEFUSCBmcm9tIENPTkZJR19TRUNVUklU
WQ0KaXMgd2VpcmQuIA0KDQpEb2VzIHRoaXMgbWFrZSBzZW5zZT8NCg0KVGhhbmtzLA0KU29uZw0K
DQpbLi4uXQ0KDQo=
