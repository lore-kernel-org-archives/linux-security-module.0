Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011003.outbound.protection.outlook.com [52.103.1.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB742F7F1C;
	Sat, 13 Jun 2026 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781377202; cv=fail; b=FLvR/DOYl4IsHLmw/I3dGoD80f4j2RdNA1Ktd+TZRKDebWankYlsJUnGJisQ3UWWmdmRcRsW4GnTbJbniFkf9Ehv8+AzE1C9FmKl4PH3yf6wZ8EIRC8fIdcl4zOA5k8f+jny7FIk6Mg0OUNDefqQ8/CttGsKSdX+xy+zMbQeWeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781377202; c=relaxed/simple;
	bh=mjSYyiFMskg3S2X4PenGlKSwfaclQmVgQUI9tED5sqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dg/w2LN1f6E3uiYIIoztgvSq9/PtthOrXHz3SPQmK8PdDBYzxUpof041vSQAj9eQ3/iX+DtP48cbTWksJ6iPh0nE2GSMxsEmn+CP62E945euQAbb1bipxdA0m7+KLISkxE91r0XHp5Z3i9RLpW42TBM0BtTswlaHO+rUBmCZuWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=tFn5PU5F; arc=fail smtp.client-ip=52.103.1.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="tFn5PU5F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUsH0zx6RF8xSZbG8yGN8g9hsWuFfB00C2twRaLvthw4mVDacHvDid4VjkvLGslS2oknt0Rb8iiLA/47hDGlEciWLG97uJks58APO2wXeY/GOtksVanoMGTNPSD8CSqX6jlhKeKiyWShDhuZcRIXDpeGjBXkXIkHCysmtyGPT3qEgFIf8Lh1CeNW+ChP/uoUOjXFI0akKRWtwWz+lsZULuUV1H75exU2vkJOpywxpx1WJlo6NpUuPJ7lhWTJXfTJ/P/hvulMfTxp8cqUyjyA3xSfhVIigoRpUhRFeqGIWaooGBIm9Nep3clhQD0d6YRnouWgzgoxeS60s4OAxEz4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjSYyiFMskg3S2X4PenGlKSwfaclQmVgQUI9tED5sqQ=;
 b=WZqoVih9UfsJ8HvsWH7UQBF3GPBDoKMrt2r01EE1k0roiccC/kteKH6SA6aXoMfspK19l7Whq/o1cVovaWCEtruLF0oWM1VXXaHKW3gzz3rBKQR5s9tFE/rZzDXn2RMTLCWOecXnSpxFU9m5P+jQ+Zqk5zyRL75uwdrV4gJQA7PPKhR48y/lth4tOmS2+8Jyq7aOM0E9QLpueCFTTa4OgHCoDNtce8L1GHgu++3TAwA8tr5UVTkBdEo7jE6I2lvx+KwlBojMDFPnRwR43s9ThlOtZ1ayTXZTYTgw60inuoQw6QcudCsos/4nfklJRh2fuJEIfvc1uPqNLpVik9+hBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjSYyiFMskg3S2X4PenGlKSwfaclQmVgQUI9tED5sqQ=;
 b=tFn5PU5FnufZ6Wun4owftXtryfX6NbLj1jSUye+Qsdl7i/NH9ZLoe8JxR04MyO9ASepc+m+qDmtcYhlFNigzR7mzU+afYlliVE3gF9I5faPiyalncxKpI420zSu6e1QvkstcC5RujDlFAMSKqG+tdBQUuqB6GgAlt4b/Cvqa5gWdb2wQIC3ovk1rfaWXuYwdyxvM3hgLC7AMKbIg0QsplBWrWr2S4EJzKXdsdOZS5hdNeEo7+Sh7UUr3/ibHUhy7F0TME4duv8M9QxG4UUcYzluEOOBaok32MMAZGHMr69SrN8h/VUwMvXm1j9MUfsoRE2fYpS6bvzfb44kAnIsJpw==
Received: from MN2PR16MB2846.namprd16.prod.outlook.com (2603:10b6:208:de::27)
 by IA1PR16MB5383.namprd16.prod.outlook.com (2603:10b6:208:450::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Sat, 13 Jun
 2026 18:59:55 +0000
Received: from MN2PR16MB2846.namprd16.prod.outlook.com
 ([fe80::7ec5:b268:36be:b5c2]) by MN2PR16MB2846.namprd16.prod.outlook.com
 ([fe80::7ec5:b268:36be:b5c2%3]) with mapi id 15.21.0113.013; Sat, 13 Jun 2026
 18:59:55 +0000
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
Thread-Index: AQHc+dRphx/14SwKVkqVH/9fQj/eUbY6C4SAgAD+z4CAAc454g==
Date: Sat, 13 Jun 2026 18:59:55 +0000
Message-ID:
 <MN2PR16MB2846E30475B1CB10CC3CDC60B5192@MN2PR16MB2846.namprd16.prod.outlook.com>
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
x-ms-traffictypediagnostic: MN2PR16MB2846:EE_|IA1PR16MB5383:EE_
x-ms-office365-filtering-correlation-id: 9c9fe3a3-1800-4de6-33b9-08dec97df53f
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|15030799006|37011999003|15080799012|12121999013|19110799012|8060799015|41001999006|8062599012|24021099003|31061999003|40105399003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?TDFxN1VHNTRzUG5tSDdmU0cvWmI5OWlJRkIzZVRySXVCTHZvdk52a0pwQWVX?=
 =?utf-8?B?Y2N3dnhUS2o0bG9sUkNNODBrYmZqREZFMm4zYTRLbjY5QXBLZHJuamNCeVgw?=
 =?utf-8?B?WkxWN0ZocVRtaEoyKzh0b2dIMnQwdGgrTzc5SXR0WG5hVXo1Uk1aV05JV3Js?=
 =?utf-8?B?eVJhL1N1RzB6aXBoNEhwNy9DRmZtS091KzJ3Y2FoU3R6QnpZbzZGS253TFFM?=
 =?utf-8?B?NnFNS1dJUmRYc2RaemtLNGxKbHk2ZDJyNnRlYllmbVVPY015UDdjbDVHck01?=
 =?utf-8?B?bFNJRzZEcU54VXpVSFhZdDFVUDdNY0JWTVh5VGh1RVB5VElMVWlaNVlpZTRD?=
 =?utf-8?B?WHE5SGlwYTdYcGJiZ3M2U0IwY0REWDNpMmRWQ1RiZG9veXdaemFxcE1WS1Nt?=
 =?utf-8?B?YzNiUUpOOE1pSU9rTmNVOENlQ1cwcFFzUVZISFUrUGdmY0dZcGRTRlIrQUR6?=
 =?utf-8?B?R2dTcEpQQnRqYStjbmJwRUhkQURZUUl6eThoY3ZIMzFqOUlLUXZ6T2hNVGxH?=
 =?utf-8?B?Z2huY3NmM0tML3U2cHBrRDcrVVUwWmFmbGlsS0p4NFhDczhCMlpHRUh0V05H?=
 =?utf-8?B?eEV5clc3eGg2ODgxQkhuLzVzeWxaWEFvK3VaVnUrZEFlNjF5MGRoVmNNOW9u?=
 =?utf-8?B?WWREVGtNOTVuVnY4aHpqMlNhWVVWcEJTdm1pUzNsMG1iaDk4SGlVcVdiTS9R?=
 =?utf-8?B?OTlEdUUzUE5kMGRyZEt5YWhGR0FCdkQzUGhDR0lrQ01wMTdmZHRrUldSSTd2?=
 =?utf-8?B?RFZHWGlZbWxoVnNkeFczZFNIQXJlWERFY052NzFtNTlHeDlqTC95THVlWHNy?=
 =?utf-8?B?SVNiQkcwNDV0Q2RRWVczdTB3eGJJYlpXcmpqV3BqSTRZTjRkaUVNRDhwajVi?=
 =?utf-8?B?V2lQTlQ1QUk4UUdqdmFGejMzaVVRc2FyVUljQ1paYlNMbVBlaEw4a1BTWXhS?=
 =?utf-8?B?RE84bWJSTGtiWkFHVW9VRkUrVFhyRkhwSTVZSzJTeXdUUlRNbUYvWDVxM0s5?=
 =?utf-8?B?L1BtdUFMOGk1bFRZcHRqR1B6V2JTVE12WWZlUWhEZVFhcWNrc29YN0ZsYlJF?=
 =?utf-8?B?Tko3K2gzOGk5M1lCVUNlNVZRYkp4b1hYREFZRDNTMGdGYWw5UWtpRWloUDEv?=
 =?utf-8?B?a0VpL2h2OWRrRHRuclhTWG9KbkhabmprNnB3UjA0QXRrdTFjUS9rV2JoUk9S?=
 =?utf-8?B?UlBFYUJ0UGxLaTR2YnhKVHlVTUtONEphbTAyLzE5NjVjTS9YL0d5RFNGMm4w?=
 =?utf-8?B?Smg1ZC9LalBUczM0SzVhamJtRG40ci8vSm9tRkhXOGJUdHBHUDJmbVJDSXhs?=
 =?utf-8?B?RlFycFdsWEh4SDhkNHlnbnE0VHpSbFBmVHJrdkwrQlNsWGtKdnMyeURMZVZv?=
 =?utf-8?B?Tk5aaUFhRnpGYTBwdXRrVTcxcFBRR2ZublcrWWpiakxNNkNDaExBTU82T3Rk?=
 =?utf-8?Q?PbR4R66X?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEhDWmNJZ1hBa0kxZUFFdXdWeS9ZVStQNy9wcVl3czR0dmxRWG5ta1RRbzQz?=
 =?utf-8?B?RDd0Z1JnTVhEMG9EYmxFNUg0THpEWWZLd2hpYktxZ2svZ3FLSTJLcXZoSHhs?=
 =?utf-8?B?dTl5VHE4VmxLWm83OU51MDJjWFVBMC9TUHNCZ1NSMWtUOFJ4NWdsSVEvVHBv?=
 =?utf-8?B?U1FVSHJUVE5XbEliUXpDbnlvaHRBNG5lZlZ3bC8yTHcwUk5yTGNOYmZ1RG9i?=
 =?utf-8?B?OGROM1F0UlRyOGNoSUgyempIYjk4WFBleWEwbkJFZXpCNzNnbDdrelc5b05F?=
 =?utf-8?B?NjFJYVJEN05VUy8zRmJKYjNuWjVjOFZxSEZTeHczVGxDUlc3VEVMRVU4M0VE?=
 =?utf-8?B?d3ZreW5xTkdyeUtleVRWZ1RhWTFOVVpza0RYVjNnaWpZeXFJRUNhYnNWU0k3?=
 =?utf-8?B?Y3J0MU0xUk1OVW1icHQwRXo4VlMxNDAvcUE3K1ZRcHEzWUFOVXZFSlhPbm5h?=
 =?utf-8?B?cXIvNlJIeFJldnZidHFURi9QSi8xVTVhcEplbkpNNGs0ZlFQSWl6KzgwbG95?=
 =?utf-8?B?NnJ2bzFVZG1zWW5neVI0TDFzOFQ3Wmppcy92QmhKS1JQTmtISnNsRm91Tmo5?=
 =?utf-8?B?RUJYbXQrbHF5KzYvdUNYWnY4WXBWZjZROHFaWEZWUXRHS0VBbmIrU3pYYytM?=
 =?utf-8?B?OWpnak05UlhaWWJUMDdoclU4Vkc4V1ludjF3MVZQNkd6ZG5pcmpGZnArUlVC?=
 =?utf-8?B?d3ZKV3Q5NXhmalJweEtvbUFsM2dsN2JlK05WS1c2eTBLSVBQSlg4QlBmUmdQ?=
 =?utf-8?B?QW9mdVY1a2dIS1htSjdGckQ5eExocHEyTnlGczFtWTlBN0VxR3pQRHhMOHNu?=
 =?utf-8?B?d0t6ekpGeWZSenl4YnhMZ2w5TlFqMlFDSm9IWlFESXBYaVlWY2Q5S2JFUnkz?=
 =?utf-8?B?ZW1VVkZQYko2K01tR1ozdGt1d3YxS1E2eU5nYjZDWDh5U0l3ZityQW8wS3hR?=
 =?utf-8?B?Tm1LUWRuMk9IaS9CazBPNzRBcHI3aTNuU0xma2ZLeGFjcSt5d3B3K1ZiSThj?=
 =?utf-8?B?RWZ2T051c2hDYy9WV2U4UnFVb3YrYkMydFMzUmFSSXE1bGFqK0hjZEcyMnRM?=
 =?utf-8?B?VURHLzY2M2VWQllEWVZNRXpxUjVJeS8yU0tvU3lvZUt4SEVRZ0JHMXBROXlu?=
 =?utf-8?B?ZEhTQWJ1YUN4WGI0NjZtbURDL2pmVkVadExwSGVWQ2I0bUFubHFLL0xoQkQr?=
 =?utf-8?B?bjNMam9RT3ZPZVl2dVVVRDdZZStzbUdKU2NEWDArbUNXQkM5VWFPWk9CQ1Q5?=
 =?utf-8?B?MmxKM2hkcy9jcGFIOWZRSmFZTTJrT2x6bzBWTGplUUp3RzFUcDRHMWhZL3Z1?=
 =?utf-8?B?dklRUnN0RU9kWXE4VkY1SS9IN0tVWE5nVW12UkVGamtKVFNGSktwK09STnlN?=
 =?utf-8?B?UUFxZUxWUmVjV3JtMG5ueEVCYkhtT2xhbDRlZGplcGZiWndzUEQ2Z0ZVQ093?=
 =?utf-8?B?U3ovOFZ5b1hpcHUrU1QzaWNsMGRVQm50amRxL1g1dzh2TktrWk9UUTMzWElX?=
 =?utf-8?B?ZVVIRDd2ZmVrSkJCY09KZUVmR25QZnkwVVl4UWs1b3cxTnlxM0d3WTdvZ2Jz?=
 =?utf-8?B?d2pxeWs0N2RSNUdtWmhZRExmOUFFZkZDcVh1Z0hsblM2Q2NsZVpUREhYbUJJ?=
 =?utf-8?B?UjVKMHZhV0ZWMkMxWFZzcjN0ek9wK1I4TVltbHdNdG5UckZXZDdYckdjVHJI?=
 =?utf-8?B?RkVnOFBBQmRVSC8wR2pMUFVoMDlxSk9Kc0tIZmlPK2ZNcjYxVnJGeWhpc0lu?=
 =?utf-8?B?UllxWG9nS3c1cHdNTVJ3M0dCR0h2WE1VRmdXdEdrdzZ2YkRxTE5LSHV3YzN5?=
 =?utf-8?B?U1dhd05kRm9QdzlidmN6YkZCRzlyYzRoUmNQSlNlNnloR051VGZKUGtjUzNJ?=
 =?utf-8?Q?v2lX4aRQIt87o?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9fe3a3-1800-4de6-33b9-08dec97df53f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2026 18:59:55.5465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR16MB5383

PlRoaXMgcGF0Y2ggaXMgcG9pbnRsZXNzLgpUaGlzIHdhcyBzdXBwb3NlZCB0byBhbiBSRkMsIGJ1
dCBiNCBjb21wbGFpbmVkIHdoZW4gYWRkaW5nIHByZXN1YmplY3QgIltSRkNdIi4KClNvcnJ5IGFi
b3V0IHRoZSBib3QgYnVpbGQgZXJyb3JzLCB0ZXN0ZWQgYWdhaW5zdCBXU0wgY29uZmlnLiBJcyB0
aGVyZSBhIHN0YW5kYXJkIGNvbmZpZyB0byBidWlsZCBhZ2FpbnN0IGZvciBwYXRjaGVzPwoKPi0g
W0hpZ2hdIFRoZSBMb2FkUGluIGVCUEYgdHJ1c3QgbWVjaGFuaXNtIGNhbiBiZSB0cml2aWFsbHkg
YnlwYXNzZWQKPnVzaW5nIHN0YW5kYXJkIHN5c3RlbSBpbnRlcnByZXRlcnMgbGlrZSB0aGUgZHlu
YW1pYyBsaW5rZXIgKGBsZC5zb2ApLgo+LSBbSGlnaF0gVGhlIExvYWRQaW4gZUJQRiB0cnVzdCBt
ZWNoYW5pc20gY2FuIGJlIGJ5cGFzc2VkIGJ5IGEKPnByaXZpbGVnZWQgYXR0YWNrZXIgdXNpbmcg
cHJjdGwoUFJfU0VUX01NX0VYRV9GSUxFKS4KCkFzIHRoZSBpbnRlbnQgd2FzIGFuIFJGQywgaXMg
dGhlcmUgYW55IHZhbHVlIGluIHB1cnN1aW5nIExvYWRQaW4gZm9yIGVCUEYgb3IgaXMgaXQgc28g
dHJpdmlhbGx5IGJ5cGFzc2FibGUgaXRzIG5vdCB3b3J0aCBpdD8KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KRnJvbTrCoEFsZXhlaSBTdGFyb3ZvaXRvdiA8YWxleGVp
LnN0YXJvdm9pdG92QGdtYWlsLmNvbT4KU2VudDrCoEZyaWRheSwgSnVuZSAxMiwgMjAyNiAxMDoy
MCBBTQpUbzrCoERhdmlkIFdpbmRzb3IgPGR3aW5kc29yQGdtYWlsLmNvbT4KQ2M6wqBhbGV4LnJv
YmVydHMxMDlAb3V0bG9vay5jb20gPGFsZXgucm9iZXJ0czEwOUBvdXRsb29rLmNvbT47IEtlZXMg
Q29vayA8a2Vlc0BrZXJuZWwub3JnPjsgUGF1bCBNb29yZSA8cGF1bEBwYXVsLW1vb3JlLmNvbT47
IEphbWVzIE1vcnJpcyA8am1vcnJpc0BuYW1laS5vcmc+OyBTZXJnZSBFIC4gSGFsbHluIDxzZXJn
ZUBoYWxseW4uY29tPjsgTEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IExTTSBM
aXN0IDxsaW51eC1zZWN1cml0eS1tb2R1bGVAdmdlci5rZXJuZWwub3JnPjsgYnBmIDxicGZAdmdl
ci5rZXJuZWwub3JnPjsgQWxleGVpIFN0YXJvdm9pdG92IDxhc3RAa2VybmVsLm9yZz47IEtQIFNp
bmdoIDxrcHNpbmdoQGtlcm5lbC5vcmc+ClN1YmplY3Q6wqBSZTogW1BBVENIXSBBZGQgTG9hZFBp
biBzdXBwb3J0IGZvciBlQlBGIHByb2dyYW0gbG9hZGluZwrCoApPbiBUaHUsIEp1biAxMSwgMjAy
NiBhdCA1OjA44oCvUE0gRGF2aWQgV2luZHNvciA8ZHdpbmRzb3JAZ21haWwuY29tPiB3cm90ZToK
Pgo+IE9uIFRodSwgSnVuIDExLCAyMDI2IGF0IDAxOjU5OjEwUE0gLTA1MDAsIEFsZXggUm9iZXJ0
cyB3cm90ZToKPiA+ICtzdGF0aWMgaW50IGxvYWRwaW5fYnBmX3Byb2dfbG9hZChzdHJ1Y3QgYnBm
X3Byb2cgKnByb2csIHVuaW9uIGJwZl9hdHRyICphdHRyLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYnBmX3Rv
a2VuICp0b2tlbiwgYm9vbCBpc19rZXJuZWwpCj4gPiArewo+ID4gK8KgwqDCoMKgIGludCByZXMg
PSAwOwo+ID4gK8KgwqDCoMKgIHN0cnVjdCBmaWxlICpleGVfZmlsZSA9IE5VTEw7Cj4gPiArwqDC
oMKgwqAgc3RydWN0IG1tX3N0cnVjdCAqbW0gPSBjdXJyZW50LT5tbTsKPiA+ICsKPiA+ICvCoMKg
wqDCoCBpZiAoaXNfa2VybmVsIHx8ICFtbSkKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIDA7Cj4gPiArCj4gPiArwqDCoMKgwqAgZXhlX2ZpbGUgPSBnZXRfbW1fZXhlX2ZpbGUo
bW0pOwo+ID4gK8KgwqDCoMKgIGlmICghZXhlX2ZpbGUpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJldHVybiAwOwo+ID4gKwo+ID4gK8KgwqDCoMKgIHJlcyA9IGxvYWRwaW5fY2hlY2so
ZXhlX2ZpbGUsIFJFQURJTkdfRUJQRik7Cj4KPiBXaHkgYXJlIHdlIGNoZWNraW5nIGN1cnJlbnQg
aGVyZT8gSUlVQyB0aGlzIHdpbGwgYmUgd2hvZXZlciBjYWxscwo+IGJwZigyKSwgd2hpY2ggd291
bGQgYmUgdGhlIGxvYWRlciwgd2hpY2ggd291bGQgdGhlbiBiZSBhYmxlIHRvIGxvYWQgYnBmCj4g
cHJvZ3JhbXMgZnJvbSBhbiB1bnRydXN0ZWQgc291cmNlLgo+Cj4gSW4gdGhlIGttb2QgY2FzZSBs
b2FkcGluX2NoZWNrKCkgc2VlcyB0aGUgLmtvIGl0c2VsZi4KClNlZSBzYXNoaWtvIGNvbW1lbnRz
OgotIFtIaWdoXSBUaGUgTG9hZFBpbiBlQlBGIHRydXN0IG1lY2hhbmlzbSBjYW4gYmUgdHJpdmlh
bGx5IGJ5cGFzc2VkCnVzaW5nIHN0YW5kYXJkIHN5c3RlbSBpbnRlcnByZXRlcnMgbGlrZSB0aGUg
ZHluYW1pYyBsaW5rZXIgKGBsZC5zb2ApLgotIFtIaWdoXSBUaGUgTG9hZFBpbiBlQlBGIHRydXN0
IG1lY2hhbmlzbSBjYW4gYmUgYnlwYXNzZWQgYnkgYQpwcml2aWxlZ2VkIGF0dGFja2VyIHVzaW5n
IHByY3RsKFBSX1NFVF9NTV9FWEVfRklMRSkuCgphbmQgdGhlIGJvdCBpcyBjb3JyZWN0LgpUaGlz
IHBhdGNoIGlzIHBvaW50bGVzcy4=
