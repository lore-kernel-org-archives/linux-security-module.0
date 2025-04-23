Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3852701BC
	for <linux-security-module@vger.kernel.org>; Wed, 23 Apr 2025 20:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745441670; cv=fail; b=ZS+rBWbeXat5kczRXAvCtPOhqY0+YVHyt1AzgJi1GKz6OsEi8rBzQfly9Bu7Uu6UZYQ8nlmBgDLcCyz2BXhbv0HncTcnGsRK4fsringukD1Biuvtd1G1zlfG7onqbpSA/d6MZGTRiPtddE0wBpdO8wDSYF8Ewd9LozQ4Xjl9DIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745441670; c=relaxed/simple;
	bh=wjnYX/PaElSPqfQXbwIBTdo2qH604qIBgmYH15QyW48=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pvjBGSY5g/5NVsRZhPQU/xc729cJCiP39ub+oAHXzC3vKYl3p95AyC+1RAKH/HZC98bgRfIgfw/DtaedUqYEQPnfCjWY5tskSI/rvS6FPN8/x0eedI5kWAr1U9UryCy7/eCl0A8Ds2G71bWZwRMqCqP8NCGGUyS/G4gnsM6VbqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=aAluJO76; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="aAluJO76"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 53NI8D2h004001
	for <linux-security-module@vger.kernel.org>; Wed, 23 Apr 2025 13:54:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=wjnYX/PaElSPqfQXbwIBTdo2qH604qIBgmYH15QyW48=; b=
	aAluJO768G6s+SGiFEMCw/r03ThrboTwtb2InOHuM+21EolRn7cJFRBNZopyU1D7
	1jUZRMXnUz6LuUosgKz6RkANUXO+h1H7qxpXwzfYYRlLR72omKOMWsWO9p/uWO/v
	0yN868VG3+ozZP9z6EmZK9NbkF1yRsZrBUcBbVRZwazMROO7MKZjLaSsIbeVhsx+
	D60fWfLd17YmLFVs32NUe5s6OdUl7ohIuMEYXld9I26apECn+qxcXBDtRpzFI7GK
	xCmxezheV7AOoVEZGqq5g+cv/KBfzLx+3XdZ9PFdgWsUCEA23FHxvSZ2/CCXhjoZ
	kdh2XFbhWWURAhOInhGBRQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by m0089730.ppops.net (PPS) with ESMTPS id 466u3h7jdg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-security-module@vger.kernel.org>; Wed, 23 Apr 2025 13:54:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1usmZH1P5xsh7YDujqG9/9/MxC5W1bGi1dq8m2tLMoG8mBrsGVNZwKv4tSfAK/mSNZYehXm8Mq43K2asb72YWQuy4LGYDJX1aBrKrb4L40z2W+HmtI/ttXnb0z7umpelR/xGTYdpgP6V5xrBkuut0En0CFc+L+NTsL7R2NKVMzlLuCmkPz87JZ4as9TL658SB90VAKlezZ18L7EuU80CzSJ9iTNP3oV4fN6tEm623rG/V2m0cCIntz4RXamrrnkzjSm/nyf7vhVTVU9J1MwUfo2m7Ac2hw/gq6eT7QoxNMjYEYK2EqpkdKSCHfI5HvBEAbtmKj9xH8gHbhwiXAaWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjnYX/PaElSPqfQXbwIBTdo2qH604qIBgmYH15QyW48=;
 b=MxFqeHrwEAjmALfxz35LTGW7exUeisW3K6Dnetq4e26D8oKhYx2S47oumEutgWPApViXQiCxMziEuDZ7uYtmXti7GWYOx+ku/EMLuqgyaWt5mF/XEhufQnJz0CwifNEcrYXE5IU8QcXKLjGJ0faZP5mdFrOa1klzvrrnX6O71IDENCNMOtVxvRJnqP8Qz7aJ+xgDmu1j5irxhKkhXUzw5Nr96FVk4iue+zu2Tvp5RyBhQY67DaxcEPx8H/jc+7ruLB7unKsY7OsFv1MBOAYvTQs7PfmoGkk4PmPD4yJjlvRHC7hJSqF5olR2jfGNOHkmNZX7pkxjBy80Kz4ise5SpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DS0PR15MB6260.namprd15.prod.outlook.com (2603:10b6:8:167::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 23 Apr
 2025 20:54:24 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%4]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 20:54:24 +0000
From: Song Liu <songliubraving@meta.com>
To: Paul Moore <paul@paul-moore.com>
CC: Song Liu <songliubraving@meta.com>, Song Liu <song@kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "jmorris@namei.org"
	<jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Kernel Team
	<kernel-team@meta.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] lsm: make SECURITY_PATH always enabled
Thread-Topic: [PATCH] lsm: make SECURITY_PATH always enabled
Thread-Index:
 AQHbs7aOIBtSOHMWUkq0IJkxn3NAybOwGPSAgAAKroCAAAuzgIAAgX0AgACoDgCAAGNvgA==
Date: Wed, 23 Apr 2025 20:54:24 +0000
Message-ID: <8F162586-EB42-4CFA-B97E-314AF2FDB830@fb.com>
References: <20250422184407.3257964-1-song@kernel.org>
 <973cedc0d38496b2096992bf68c72e67@paul-moore.com>
 <3897DD89-5B9F-4257-B273-A4DDEDACD56B@fb.com>
 <CAHC9VhShOxu4Q9yV3tkST3P9SoiL3j3ET_O4_cPAV1ES5usd-A@mail.gmail.com>
 <60CAF154-DADA-4C46-ADE8-403318EFDDAD@fb.com>
 <CAHC9VhRQzEGvMxyZY5Ke+GFYHr9OOF=-cTVqsK14=cfGJwy1bQ@mail.gmail.com>
In-Reply-To:
 <CAHC9VhRQzEGvMxyZY5Ke+GFYHr9OOF=-cTVqsK14=cfGJwy1bQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.500.181.1.5)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DS0PR15MB6260:EE_
x-ms-office365-filtering-correlation-id: e3ca2f0e-1999-4b9e-de17-08dd82a9077a
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aEp2bHpvekMvKzJFemhtaG9IcnZUSW04YUE1SWZmNWVreTlTdklONmdMOVdR?=
 =?utf-8?B?bUVwS2tYQW9oRW52NFlMNHZ1MWt5aXBRcEdRSkJmcjRlK0psUjhRSHlXSGdB?=
 =?utf-8?B?NlA4QWFCTmsxbWdtMTgybVNJZytEYlQ1R2pWa2hvQStWald4bW4vdWVHaDBJ?=
 =?utf-8?B?cEJocldmRkREcFVadGhHSjVYRndzVHN1eEZEeFhNRlhtRDJ6K2lFQXNXQXdD?=
 =?utf-8?B?cFNoa2RGbVVRY3pPM3p5dmRIenBPWllNUW1TWVZVVEROaXRMbFBaY2wrV0M4?=
 =?utf-8?B?UEhBZHVJVXpTRkNZalVGRVphc29qMFZpYytuS2UzeENSWS94SHFFTStLQVEv?=
 =?utf-8?B?Qmk2cXVOMzNMOHRLd3NCajRLRGdkN05jOTRROWRhTE9PWmtRdDI4TmdPK2JD?=
 =?utf-8?B?YmJFcE4wYnRFb3pzNFpBZzdkc1lnUkRqVFMwd2ZxSlIydy96ekh1TjZmNHI2?=
 =?utf-8?B?UXlWU3duM0MvVEcyWisyK1VSZmVud1dJeE5ETGtLOEgyQ0sraDV4K1ZOTXBX?=
 =?utf-8?B?R2JlbXdrUnBCYlNZR3VCQ2tRb0VibVA3WEtwMzVJS3I0OFg0YlFVR2p6VDlC?=
 =?utf-8?B?UTVpZXlYMmt4OTYyQTYrZHBaOTNCWHExNEFIdFlwdGUyYjVvc0ZDUk15bGRn?=
 =?utf-8?B?MDJXcWhwK2prSFkyQ0xIdFlJR1JXcnhueVMvZ1JWTHVXNjdFNGRLNk5BeHdt?=
 =?utf-8?B?TzdOYU9OMWxnR0thK1dIbVlqZlVXbkd1UDI0NVBEWXVVNE1RdmxMeVRtUExn?=
 =?utf-8?B?Znl2cC9mcm92VzAzVFdaUlVzWkFrRG1lcDFFaHkreS8xVjFUM3lzWWthUWlO?=
 =?utf-8?B?R0N6Rjg0MmdoM3Vma1J3dnRwbEJLdUZ5R0lHa3lsdjNTd1ZDM0J2eWVZblFz?=
 =?utf-8?B?MjZzeTdNa2FHOCtDM0dGZGJmYUFXWUU4RzNyQ2t5Wi9MQUFFK2IwdDRBL3Jw?=
 =?utf-8?B?bktDZ29YOVRNcGpUTHlDbXdFODhLRkVMZWR5M0dDemN1QnhpSExGbkNtdTFS?=
 =?utf-8?B?aTBGbmFiclA1N2lVbENCWjYxd3V0YXE1R2t1SDZndlM3T09lVVByK2lRTWhs?=
 =?utf-8?B?YmJZSXYvR3V6QkpUVHVmNUtQY3BYemNVY1VsZm9wTXh2VDJubFk1MzFYOGw5?=
 =?utf-8?B?VzFLTm9kUDRlbVR4MUVZTUVTVVBJemg0VzRZY1hyY3FUbS9QUThsZ2pPT1Jl?=
 =?utf-8?B?NFF2N0M5cjB6Zm1RUFloeFE3NGl4QW9hR0kxOUN4ZjNBTFViNXJOUFpwZlJF?=
 =?utf-8?B?S1JHS2FxQ0k0S0I2bGdDMm5NVG1nUEFLK1pGOE1sYkdwbFJCN2Q5U3ZSTzFY?=
 =?utf-8?B?WU54Q1hEOHEzTElSSjVna055MndBL2JvTHFydmNzRUlvYmNhb0dSQlhXSWJ2?=
 =?utf-8?B?amwwSFdCOVh0dENXcUVRSmF3VlhRTnR0YVg0elZUSXpMMzE0NUhqYWpHckxO?=
 =?utf-8?B?bFRIMXNRckUzcDNKbVZXN25OMFRpdVNzYzBWUjZGazMvY1pYOUdoYWg5ZXZl?=
 =?utf-8?B?WGlhRitiWEJQL2NBUURWczBNM1ZOblQ0bUJiQ3JDcjFuQzZYa3YxOGdtUlhL?=
 =?utf-8?B?em9GMUkzTTFPU0lwYlkvNkRLRk93VkdwM0pTQkRqMVJOTmUrZDdLME5mcURC?=
 =?utf-8?B?MGF2MExnOFF0NzhtSDV2L1Foc3h0amZMekhRNVRTeW5VSmY0WnVEOFRLK3RN?=
 =?utf-8?B?V3p6TkZiZytjbEJoNVNReG1vTHphVXd3RTBqVk42a3RXNEVxbVA4aXNxREM0?=
 =?utf-8?B?SlNna0d1V3ZkNTZVaWxLUEMxaWwwUW0vQk45c2JlbWlIVGZTdVNrVlhyd3Z5?=
 =?utf-8?B?U2dSZ0x3dEtNTG1WVGlpdWpGUEoyUEZCenZGRUNyVithMUtCU2xneGR1NmtU?=
 =?utf-8?B?dWZxZys4WEV4SEFUQkJQaFlKc0JQbDZtZWl2Ti9TR0NNTXVQWEFCQU1OOEdE?=
 =?utf-8?B?cHlzOXBoZ01OTFlWRitZRXFwb2FUTlh5UExUSVFxWjVIVXE5VTdxeStJT3NX?=
 =?utf-8?Q?rkgjci1eyd0ivLnGCaX1t5dohnUtvQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ODhCdkg5bXlMbVQ3aEkwRGJkNTZta1FPR0l6aHdBWjliUVQydlRqaUltL2lq?=
 =?utf-8?B?K20zMWFlWWp4ZjBRb0Znb3d0VmJPZ2MwbWd2d2Q0U0h5TGd4aml5Wm45NWEx?=
 =?utf-8?B?Z21kWGttendLOVFodEYzUm9KNDRoRy8vc0J4OW5EYlQwYmhqcityYmJlejZ6?=
 =?utf-8?B?M3FkRWgyVjZIYSszaUM5WFRqeTkxS21oa1RnUW5rUEEzSHpKUWhOQ0FCRlpq?=
 =?utf-8?B?eVFsTXZ3WDUxbFkyUU5PZjdFR3J3N24wNnIwK3V4c1VTRmR1bjRSczFLL2tH?=
 =?utf-8?B?QnNIeWRQTkFmNWFqeEkyeWpxZ2tuemRVMVBVVjJMbHhqZmE3TXhCaHFlUDVp?=
 =?utf-8?B?TkM5QUNjajJ5eWlOK0JsY0t0T0V3enNkM1Q5WWhaVGp2eVRnVlRrTE1iUzdr?=
 =?utf-8?B?dEQ0UCt2V1ZydEhOZXhTaXRyZVY0YWk1UFh2WGhoSUlOaE5yOStockc1cnM1?=
 =?utf-8?B?Vmc4TkF0Q05nNnpWaTN4NHNhVVU4cFQ5dEVaZkYwekhkdU5RZUlXWUxRcStl?=
 =?utf-8?B?SHhPcm9wK2d0RjRKSUlGcGFEWGJENWRNTEIzV3owaVdBdVowWkZ5cFJGcVdj?=
 =?utf-8?B?SXBMYnY3L2JYRVRlMHYrRzJzcFgyQm15U0IwL002dW10TXBCKzRGWURScGVP?=
 =?utf-8?B?SnN2eDV5L08raEs3Q2RtcWdDUHNMcEZFUmZPOENnNmFCa3FEQ210K3RTN0oz?=
 =?utf-8?B?QU13TFhtU1RHTmx3M0wvcmp3M1RzNFVRQ1BsUkNxTHFqWitVUHY3Yzc3SW5F?=
 =?utf-8?B?YTh4YmUvN1hWOXZYUFI4WkRsMC9vTmhXWFN2R29JTTRsRllOeEJHR1FzUXR4?=
 =?utf-8?B?TmFoMjRiUjBGRnZCU3lWeEFDRTBKanpGOC9Ybm1sdEpZTlBuajNNTkx1dWZK?=
 =?utf-8?B?Y3hFQ3A1RkFGVldtRldodlVRYmhWRkMyTGZESFJrdmRBYld2VWlTRzA2dTVB?=
 =?utf-8?B?OVRMQ0JwZHVXaHJsN1B0L21OTFVscHMwLzR1SVphSTRMaFFPREE0elp4RlhM?=
 =?utf-8?B?eFl0QjlKZkM5dHBVWkRoNmpQMXBQMWRZc0hCOU52VjRBOEk5RU9ZTmQvT1N6?=
 =?utf-8?B?dGlsY1hsRkszNFJabHJOSkdjd0NISkdNUytkVldxeCtYVHcvRFkwdUp4Wm1J?=
 =?utf-8?B?TXh3WmpCLzhtT2piZ1REbTArcGNLNUhUTURiQUVqTmQ4cU1QRFJRanc3Z3Zw?=
 =?utf-8?B?aWlhcitFdjk4ZU9LdGFHNzNBR3FXa3lvbUhBNUlyQkU0Vnp4eEpLWE5uQmNy?=
 =?utf-8?B?ZkljY2pXamdhTXZXRUg4MkhTNjkyNWFyd043Ni8rY2JTL3JkL0ZoR2hQVHZU?=
 =?utf-8?B?bi81cjJjMHN0c3d1NFJ6Q0FPQ3A0blNjUmNHRDNFN1pCR2g0UXFpeSswRTdH?=
 =?utf-8?B?ZHVRaUZSWGRtTUt4RkFGU3N0TWE3UllQWHhaN3FpTG9MV1RxK0xUNGJkVWFl?=
 =?utf-8?B?dXdweGpuK3hwL3JIVUd6Vm5DOTkrRExvSnRvdE12REJORUFlNGdmWHNST3hp?=
 =?utf-8?B?TGVORTJwOG5CMVdXMldKVHI1K3k4SHA5M3hhSjdzbTg5UXpCT24wTGlJcENU?=
 =?utf-8?B?WkR1K2MvZ2NKNDVYNmZBRVB4VGRZRFBjRlBuem9yVVZCUHAzRWpHKzRqSk9O?=
 =?utf-8?B?TE9XdmhCakllaEpMZHVCdkJNMWZGc0Nma293LzJZY1Fqa0E2N1Bja3g4azRv?=
 =?utf-8?B?bXlLdktnMjV0OWZhQ2VnQW53d1BmNVRqaDl1d2FnSnBXZit2V0M0WTFnRXZD?=
 =?utf-8?B?ZzV1eXQ2M0FwbDA1eHArdFluZjFxK1YwRXBwdTg1dGxhTExZL0RXUFV1ZEFS?=
 =?utf-8?B?WW5LSDdIWFdZcDRQUlV0M2F2S0JHYS85Yy9qWGdPNDc0WVd0dThIeUIrcytR?=
 =?utf-8?B?VVhUbEdRTEVaQ3ljb0t4Mnl3eG9PdmhGSzd1ZUVyeEMyUHFYTno5TE5pZ2VQ?=
 =?utf-8?B?ZVAzYktHdHlyMDdMQ0NmN1UwUjJQNElNNEZvMFBHR1JYaWVuWit4RWhEZlFp?=
 =?utf-8?B?eGRSNmVvRmtucDduMTdGWFhVeXN5aldsZmUxUVd1Vlpka2NCd3VITWZqTnJI?=
 =?utf-8?B?UWNlQ3Rzc2R6c0g3OU5NaUtXeEpaZUlMZHA5c01FTjRFdEpsY29NcEV1NXNH?=
 =?utf-8?B?NTBtVHRDeHYrNHpJejlwYmF2Z2RBTGdZdXFNUEVLZjY2UjN0WTNsK0VLOUNs?=
 =?utf-8?Q?yWlFUKLehd+ARYOKqd3jGA0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E285E86E8F6B0349B7694BD34DF4C0D4@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ca2f0e-1999-4b9e-de17-08dd82a9077a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 20:54:24.2630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ix4Uw7h11wGBrN+IIpRxVsATNTTXtcJgwD+uoSBibb/SiQfNZXRS1uFgGzwESkcgFC4l5Ka1fF9PhxszeMklxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6260
X-Authority-Analysis: v=2.4 cv=dtbbC0g4 c=1 sm=1 tr=0 ts=68095383 cx=c_pps a=CSNy8/ODUcREoDexjutt+g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=xVhDTqbCAAAA:8 a=zqlJT1_TZ96Cc5v5b0cA:9 a=QEXdDO2ut3YA:10 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-GUID: dPiHrYJlA-l37Btp5Xd1JaAEeGyM6qk5
X-Proofpoint-ORIG-GUID: dPiHrYJlA-l37Btp5Xd1JaAEeGyM6qk5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDE0MyBTYWx0ZWRfX1r6TOcjj12yY tf7RWadd/Nnbib+fHqSeBbtKpBdbx35tESNYEIYKIeXG+m2DSEtMzjQ+OsEPLddFSqd/o5UuvHE wqlDd5v67G0hCItPuW4NgDXY3xANGN0eoceOlyyVPhk9jie62XOScawyzfH2BrXlJx1Nc3sVut8
 I5hRx2T3FowlTonFtg3IbIdxokq/X0SLe/TBH6wp2+Oc3pMfbFJ5oglowRpZQH7uanQinmLiNta BlncxKqCSjTxLRHfoYZDIdwYh0CwJGyjRhSe3fZn13qMpCyRKEUH0m5Qms5gZ2UuE11GtXK527A PpkjhqsTczuTecnB53rE+k5hO+JYl9lyp+EX+0sj72bsNAvOEyVzQPV0ZhndyXGAGjjMMxcvDsC
 13vENxN+OymQtyTfFtHjPDcqLpRkDvrH4kqrkT0YKByPsMlfHgcuDwDr/VQ+TEuaJcGwkoVP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_11,2025-04-22_01,2025-02-21_01

DQoNCj4gT24gQXByIDIzLCAyMDI1LCBhdCA3OjU44oCvQU0sIFBhdWwgTW9vcmUgPHBhdWxAcGF1
bC1tb29yZS5jb20+IHdyb3RlOg0KDQpbLi4uXQ0KDQo+Pj4gV2l0aG91dCBwdXR0aW5nIG11Y2gg
dGhvdWdodCBpbnRvIHdoYXQgd291bGQgZmFsbCB1bmRlcg0KPj4+IENPTkZJR19TRUNVUklUWV9J
Tk9ERSwgSSB0aGluayBpdCB3b3VsZCBiZSBpbnRlcmVzdGluZyB0byBzZWUgd2hhdA0KPj4+IGhv
b2tzIG9uZSBtaWdodCBiZSBhYmxlIHRvIG1ha2UgY29uZGl0aW9uYWwgb24gc3VjaCBhIEtjb25m
aWcga25vYi4NCj4+PiBVc2luZyBzZWN1cml0eV9pbm9kZV9wZXJtaXNzaW9uKCkgYXMgYSBzaW1w
bGUgdGVzdCwgaXQgbG9va3MgbGlrZSBvbmx5DQo+Pj4gU0VMaW51eCBhbmQgU21hY2sgcHJvdmlk
ZSBpbXBsZW1lbnRhdGlvbnMsIHNwb3QgY2hlY2tzIG9uIGEgZmV3IG90aGVyDQo+Pj4gc2VjdXJp
dHlfKmlub2RlKigpIGhvb2tzIHNob3dzIHNpbWlsYXIsIG9yIGV2ZW4gbW9yZSBsaW1pdGVkLCBy
ZXN1bHRzLg0KPj4+IA0KPj4+IFlvdSB3b3VsZCBuZWVkIHRvIHNwZW5kIHNvbWUgdGltZSB0byBk
ZXRlcm1pbmUgd2hhdCBMU00gaG9va3MgYXJlIHVzZWQNCj4+PiBieSB3aGljaCBMU01zIGFuZCBh
ZGp1c3QgdGhlaXIgS2NvbmZpZ3MgYXBwcm9wcmlhdGVseSBmb3IgdGhlIG5ldw0KPj4+IENPTkZJ
R19TRUNVUklUWV9JTk9ERSBrbm9iLCBidXQgaWYgeW91IGRvIHRoYXQgdGhlbiBJIHRoaW5rIHRo
YXQgd291bGQNCj4+PiBiZSBva2F5Lg0KPj4gDQo+PiBXZWxsLCBJIHdhcyBob3BpbmcgdG8gc2lt
cGxpZnkgdGhlIENPTkZJR3MgYnkgcmVtb3Zpbmcgb25lLiBTbyBJIGFtDQo+PiBub3Qgc3VyZSB3
aGV0aGVyIGFkZGluZyBhIG5ldyBDT05GSUcgaXMgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvLg0KPiAN
Cj4gQWgsIGluIHRoYXQgY2FzZSBJIHN1c3BlY3QgeW91J3JlIGdvaW5nIHRvIGJlIGRpc2FwcG9p
bnRlZCBhcyBJJ20NCj4gZmFpcmx5IGNvbmZpZGVudCB3ZSBkb24ndCB3YW50IHRvIGNvbnNvbGlk
YXRlIHRoZSBpbm9kZSBhbmQgcGF0aCBiYXNlZA0KPiBob29rcyB1bmRlciBvbmUgS2NvbmZpZyBr
bm9iIGF0IHRoaXMgcG9pbnQgaW4gdGltZS4gIElmIGFueXRoaW5nLCBJDQo+IHRoaW5rIHRoZXJl
IG1heSBiZSBzb21lIHZhbHVlIGluIGFkZGluZyBhbiBpbm9kZSBLY29uZmlnIGFzIGRlc2NyaWJl
ZA0KPiBhYm92ZSwgd2hpY2ggSSByZWFsaXplIGlzbid0IHlvdXIgb3JpZ2luYWwgZ29hbCwgYnV0
IHN0aWxsIC4uLiA6KQ0KDQpJIGFtIHRoaW5raW5nIHdoZXRoZXIgaXQgaXMgcG9zc2libGUgdG8g
aGF2ZSBlYWNoIExTTSBzZWxlY3RzIHJlcXVpcmVkIA0KaG9va3MsIGFuZCBvbmx5IGVuYWJsZSB0
aG9zZSBhdCBjb21waWxlIHRpbWUuIE9UT0gsIG15IHByaW1hcnkgZm9jdXMgaXMNCkJQRiBMU00s
IHNvIHRoZXNlIG9wdGltaXphdGlvbnMgbWF0dGVyIGxpdHRsZSBmb3IgbXkgdXNlIGNhc2VzLiAN
Cg0KDQo+Pj4+IE9SLCBtYXliZSB3ZSBzaG91bGQganVzdCByZW1vdmUgc2VjdXJpdHlfaW5vZGVf
cm1kaXIoKSwgYW5kIHVzZXJzIG9mDQo+Pj4+IHNlY3VyaXR5X2lub2RlX3JtZGlyKCkgY2FuIGp1
c3QgdXNlIHNlY3VyaXR5X3BhdGhfcm1kaXIoKSBpbnN0ZWFkPw0KPj4+IA0KPj4+IFRob3NlIHR3
byBMU00gaG9va3MgYXJlIGNhbGxlZCBmcm9tIHNsaWdodGx5IGRpZmZlcmVudCBwbGFjZXMgaW4g
dGhlDQo+Pj4gY29kZXBhdGggd2hpY2ggaGFzIGFuIGltcGFjdCBvbiB0aGVpciBlbnZpcm9ubWVu
dC4gIEZvciBleGFtcGxlLCB0aGUNCj4+PiBpbm9kZSB2YXJpYW50IGRvZXNuJ3QgaGF2ZSB0byBk
ZWFsIHdpdGggZGlyZWN0b3J5IGlub2RlcyB0aGF0IGRvbid0DQo+Pj4gaGF2ZSBhIGRlZmluZWQg
cm1kaXIgb3AsIHdoZXJlYXMgdGhlIHBhdGggdmFyaWFudCBkb2VzOyB0aGUgaW5vZGUNCj4+PiB2
YXJpYW50IGRvZXNuJ3QgaGF2ZSB0byB3b3JyeSBhYm91dCBTX0tFUk5FTF9GSUxFIGZpbGVzLCB0
aGUgaW5vZGUNCj4+PiB2YXJpYW50IGhhcyBhIHJlZmNvdW50J2QgYW5kIGxvY2tlZCBkZW50cnks
IGV0Yy4gIE1vdmluZyBhbiBleGlzdGluZw0KPj4+IExTTSwgZXNwZWNpYWxseSBjb21wbGV4IG9u
ZXMsIGZyb20gb25lIExTTSBob29rIHRvIGFub3RoZXIsIGlzIGENCj4+PiBkZWxpY2F0ZSBvcGVy
YXRpb24gYW5kIG1pZ2h0IG5vdCBiZSB3b3J0aCBpdCBmb3Igc3VjaCBhIHNtYWxsIHJldHVybi4N
Cj4+IA0KPj4gR2l2ZW4gdGhlcmUgaXMgcHVzaGJhY2sgd2hlbiBhIG5ldyBMU00gaG9vayBpcyBh
ZGRlZCwgSSBhc3N1bWUNCj4+IHJlbW92aW5nIGEgaG9vayAob3IgbWVyZ2UgdHdvIGhvb2tzIGlu
dG8gb25lKSBtYXkgYmUgYSBnb29kIG1vdmUuDQo+PiBXZWxsLCBpdCBpcyB0b3RhbGx5IHBvc3Np
YmxlIHRoYXQgSSB1bmRlcmVzdGltYXRlZCB0aGUgY29tcGxleGl0eSBvZg0KPj4gdGhlIHdvcmsu
DQo+IA0KPiBUaGUgZnVubnkgdGhpbmcgaXMgdGhhdCB0aGUgZGlmZmljdWx0eSBpbiBhZGRpbmcg
TFNNIGhvb2tzIGlzIG9uZSBvZg0KPiB0aGUgbWFpbiByZWFzb25zIHdoeSBJIGFtIHNvIGhlc2l0
YW50IHRvIHJlbW92ZSBhbiBleGlzdGluZyBob29rOyB5b3UNCj4gY2FuIGNvbnNpZGVyIGl0IGFz
IHBlcmhhcHMgYW4gdW5pbnRlbmRlZCBjb25zZXF1ZW5jZSBvZiBhIGdlbmVyYWwNCj4gaG9zdGls
aXR5IHRvd2FyZHMgdGhlIExTTS4NCg0KSSBkaWRuJ3QgZXhwZWN0IHRoaXMuIFRoYW5rcyBmb3Ig
c2hhcmluZyB5b3VyIHRob3VnaHRzLiANCg0KPiANCj4gUmVnYXJkbGVzcyBvZiB0aGUgYWJvdmUs
IHllcywgdGhlcmUgY2FuIGJlIGEgbG90IG9mIGNvbXBsZXhpdHkNCj4gaW52b2x2ZWQgaW4gYWRk
aW5nLCBtb2RpZnlpbmcsIG9yIGNvbnNvbGlkYXRpbmcgTFNNIGhvb2tzIGFzIHRoZXJlIGNhbg0K
PiBiZSBkZWNhZGVzIHdvcnRoIG9mIGFzc3VtcHRpb25zIGJvdGggaW4gdGhlIExTTXMgYW5kIGlu
IHRoZSBjYWxsZXINCj4gdGhhdCBuZWVkIHRvIGJlIGNvbnNpZGVyZWQgZm9yIGVhY2ggY2hhbmdl
LiAgT2YgY291cnNlIHRoYXQgZG9lc24ndA0KPiBtZWFuIHN1Y2ggY2hhbmdlIGNhbid0IGhhcHBl
biAtIHdlIGhhdmUgcGxlbnR5IG9mIGV4YW1wbGVzIHdoZXJlIGl0DQo+IGhhcyAtIGJ1dCBzdWNo
IGNoYW5nZXMgYXJlIG9mdGVuIG1vcmUgY29tcGxpY2F0ZWQgdGhhbiB0aGV5IGFwcGVhci4NCg0K
DQpTb25nDQoNCg0K
