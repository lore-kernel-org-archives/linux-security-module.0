Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2063.outbound.protection.outlook.com [40.92.23.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D062DCC04;
	Sun,  1 Jun 2025 01:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748740190; cv=fail; b=fBIwDmhfsqWHMOsnKsowm5K9FX3LjSL2sjSpBW+Pgj++DUy24EjNyq2gZRXdR5mOmvT+KS4RRjT6eTy3vok3y26G3xqVKfy7Y3i4LJxcxhibbvnpC+56bJjEsC2ytbbJ+fw+cD0V1ylcXZfjDjQ7znSl1W5jQra0NrFXMoQb6UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748740190; c=relaxed/simple;
	bh=7/G7d4hJsX1hHbUkB7ZGziFxk0qyri0CgDDma/8bxYs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mbyemCdzNIAfzwqnqWb5g6OHKEvPZeCr5mIki8hGpeMbcQvSBhURH8tgmYfyNElfUf9B8yWXdKqUKwM+y4dBHkoZY9LV4gCFUVNsaUrCCjck9Nh/CxqRvTbTa5/zejYD9nswrB9aTTWDVOiFgK90T/Ibn1I0NaAOnyKr0xJO7XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jZmTO+E9; arc=fail smtp.client-ip=40.92.23.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jZmTO+E9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2rZCnDDGywfNBdvZxWbtHVyuGCB3z/mYgewipWY4UkXH0YLY9NbHLmTaFYHlU5edVQ2TrKmfcffw/VZ+eQEVNdQVb5mOkiPmyrFCVnr07ZhpsycKmtbhj4BX5JUIUK0kz9KdpasLaaUVt+akU0N6OqYpWT4O27wbt85odD+M17Clq1EVL+ReN1jIGzMGIav/IOY7gNLblecX+pEUmxyHL5uutuDFamegTCK5lOAgyp1SAFX1J8ouiw3TpiAadkB1DXzi4oghpaDjNJ/eknkU9jfr7AfK6BXKSbHoBMWMYzNO7OV3561jmUIYjuufemmiyJtE3JbAj+lHqBR5Bcs0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/G7d4hJsX1hHbUkB7ZGziFxk0qyri0CgDDma/8bxYs=;
 b=UcykIvwKsWbBNcHzdaGCRANE9Ey9qhNgOLfaQj1UgA9R2RtPsztTvUc52fcT/GUZ3j3e+vSOwvq1M8/5qxQoxuScX25lx+5OshYkExQkDrvLB7Gy+MBfG57PLBMGwRY3IR+9KgJvO7uHDR3O7GP0DRcPTvGKQHeQAB/h0NfWr7dYel1YKDZK/hju/P3MnHFtsURe47d8N1nYpnSvcsUARfwqmokHghHEVV8P+NFlh+itQpUDEDKw8MnTrvw35+i495QVYpkAYYqgvoqpkccR1t23cKJUb6Zq0Z+7QjfRG7+dtS8DzJEA+27jGIMtZ2IGEavDBNW8ybK6qby/BCdNeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/G7d4hJsX1hHbUkB7ZGziFxk0qyri0CgDDma/8bxYs=;
 b=jZmTO+E9wpISef1czvxKzfKIgl6fwsEKIWk4DCBM1UuNgVH5mfO79/8/4XNHIG5Dp/oMOrpYNx1F87R5HZwJdb2nK8c6/ldltoTNrJpibZrthAsQY3MuN1KNkspbjIwJH5Fsjxnkza5vtTzhMhDh7IpFrmxiuxKIjqpi4mG3WXvPrGbGbtC1Zd8g6JieBndVbd7djkLfY+vy/bSIvE0XKKpwjacYG9kBoeFCNWcRVwqbhEvgzKdRG3P4rEAa3Q4wSeeicofnQZNP6Jr2hobkiuX5wNlBQKsKjg0hZDPrlsRu49mKWOwO6CEwcepIdPS8dQxt0RHJpSBZwgz10gjaaQ==
Received: from SCYP152MB6261.LAMP152.PROD.OUTLOOK.COM (2603:10d6:300:34::10)
 by SCZP152MB5822.LAMP152.PROD.OUTLOOK.COM (2603:10d6:300:60::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Sun, 1 Jun
 2025 01:09:45 +0000
Received: from SCYP152MB6261.LAMP152.PROD.OUTLOOK.COM
 ([fe80::595f:48ad:9ed7:35a1]) by SCYP152MB6261.LAMP152.PROD.OUTLOOK.COM
 ([fe80::595f:48ad:9ed7:35a1%6]) with mapi id 15.20.8769.035; Sun, 1 Jun 2025
 01:09:45 +0000
From: =?utf-8?B?4oSw8J2Tg/Cdk4/ihLQg4oSx8J2TivCdk4DihK8=?=
	<milesonerd@outlook.com>
To: "serge@hallyn.com" <serge@hallyn.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>
Subject: [PATCH 3/3] security: add Lilium - Linux Integrity Lock-In User
 Module - MAINTAINER
Thread-Topic: [PATCH 3/3] security: add Lilium - Linux Integrity Lock-In User
 Module - MAINTAINER
Thread-Index: AQHb0pHUofmAEoa9906NW4VX3+/7xQ==
Date: Sun, 1 Jun 2025 01:09:45 +0000
Message-ID:
 <SCYP152MB626154E5E7A76479EBFAF09AB063A@SCYP152MB6261.LAMP152.PROD.OUTLOOK.COM>
Accept-Language: en-GB, pt-BR, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SCYP152MB6261:EE_|SCZP152MB5822:EE_
x-ms-office365-filtering-correlation-id: 7a1c86c7-9cf8-4c2e-6abf-08dda0a8ff14
x-ms-exchange-slblob-mailprops:
 P1EfU6pZOd+Ewy2R3Pu64sHUJuYJdjG8F1fnQM4APzKu+UfeI+QSz0EkN7jjYLU0AhhtrlEJ972rhAqmaZUxOfJpDceZTYeeMR0mcbLlG1X7YnJdiL3kmAFwc1W2LZW/VHg05iU7NAKMNi5id+95e9ViNTmAMKCr1oUvTq9sQYn91BEIifKavXsDVxH7f88fIvJSQZO6hwD4VEYcDM7f07W/2pGyX3+2t38x4oZ5xR7g0f83lKME+PUKYlIUSs+AkRPOxJn0s8DfMQbD9mAXw3ywkkIo0l0axPmrYjxQSaoGjqGXgGmvPxjPwNI5NYRTMAdD8WejRk+EMRKoj3PBrKOMbktkn61p+54qL84xsrqYxP7cbWqY5A6beYqs/JYacxqhAer/ucqXP2amuP1WPgcGKj55m322L3Ny/A5XeLx1CR2GxRbrRIs/EYbNWno0BwxOqJayO6O+EOBiFv7azzynaZoih1LQSlezKmD5aAQDjfCzONjTkri6Qmq7AhqefULZHArgfd9pEShsYY2vCEpUx3VR0JQDas/5ce02kaHfG5hFWdaR2uaVwcdjaZAwpgnLJrO9T3ylVc3OORD5EWRvOSB/UJuAAa66Oe/VIZRKc0F55XXV8KY7LKe3PBTfai5+guZzhTEFD29rcs2kfStTe7s/intygnAb4W17gnyt7yn/6MjkhMgO4RV2I+8xVbBRn0f3O76IsCahrqw+fyNwohNR+E2/WeDiKbF/KrAwvG9fs2cw6rCFz5cN3XhFAxLvoF05x21yna86KgK849ut8InZh7OVG2y+KcAdJ56r5MjuURn+TA==
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799009|461199028|21061999006|7092599006|8060799009|19110799006|8062599006|15030799003|5062599005|102099032|440099028|3412199025|10035399007;
x-microsoft-antispam-message-info:
 =?utf-8?B?NzkxYUhMZC9MUUVCWlgyTUNNc3Rtcm9qRW5pSTBnYkhWL2ZEUG5oZ1NGKzBW?=
 =?utf-8?B?eWR1U0F6N0NWcjNEMHRpS3pCdnpGVVhNUnBNeXlTQzJVT3pibGpRQSt0S1du?=
 =?utf-8?B?eDFMSWYvRkxlVlRnRGx2cG9HTDY5QjNiaWtBVDBINFU5c2ZtcW02Y09sSWdQ?=
 =?utf-8?B?cXJZWUtTeGxhOHA4TnQzYXc5UTRYUVJPaWZDVFNxclAvcjNkeGZPTjlUUHU0?=
 =?utf-8?B?SFBLZE1nMVNSZkNYSGdhM080bml4cFFVQjViVWFTZzd2MnJTWmhCa0xZR21R?=
 =?utf-8?B?NXpnNTVkV2c2cXlCTGI1UkdHdWpQNVMwUXVYcTdyeTJHU0NVNW1UZ2EwbEU2?=
 =?utf-8?B?UXFkaGNvd0hDWnFENUkzVno4cFUrL1V6TVRINkw0UTRlc0dQUTRONkp3VlUz?=
 =?utf-8?B?aE1JdUV2TEkxZU04U1I3dG8yTWgrOVlyc3RnSjhDWm8zMmxvUWxwSEt5UTNN?=
 =?utf-8?B?SG9LUUlZQnJpY0pJRExIbXZhWmd1SHhCNFJHbGkxODhtWmQzS3ZiQzJiblBF?=
 =?utf-8?B?TTBReHUwLzlhYXR2UkdGTW1RM3dpRVBhckZKNHFreGc3VkJLMXVTTWl0cGFT?=
 =?utf-8?B?UE85Y1V0WVlNeWNqY3VjMmRBTHpjdFJCNnJBUTVoMURIeXBNWU5WMmkwR1or?=
 =?utf-8?B?aDlTRlRpT3N0ak1KK21VR2tEOS9NSjJqYitOdW5RRnpPQ3oySytnby90V3BF?=
 =?utf-8?B?a0E0ellDOUJaaXBYaGFrUzQ0c29tbCtNck9TVzFsNk5CR1JRbVVIMzM0Q0J0?=
 =?utf-8?B?YURmSThZSHdITVVqZ3pySWFzckdVVkpHSGdhajVRK3hXczlVbU9PcXRSZCtG?=
 =?utf-8?B?bDRseHhYakxvbGRpUGhvRTV0RnhrTTkzREtEOENWUGdjRzRPVlZGUGN5Kzkr?=
 =?utf-8?B?MHkxelNkUytHVU1DTWlDc2xmVkpzeWpSRUYvRGxHRUl4K2hKblhLaVExdlNk?=
 =?utf-8?B?K01QK3BRcFFrczZLdktxMWlJdExvL0FaOTNZcWNwWEYraENOcE1vZWh0TlFH?=
 =?utf-8?B?VlMzdXlVVDIwNjhTcTExeENCVE1NR1daNGI3dzlzZTRCSmloUDVDYlJHQWNx?=
 =?utf-8?B?dzVhK2t0QTZTcnc5eHlzYkRlVjZKR3oxODhDOUZkQmxwcFRzWkZGU3BrK2NS?=
 =?utf-8?B?RWFBcUZhcVBoY1I5SDJvTE8xSThPbkdyRjJtOEkzUWttNmE3bUNoZjd6UVFl?=
 =?utf-8?B?UUJKMDlQTEpuaEhEK2cxL2NTbnVPZW5MRkVRMlFob0oxTi8zaWxSdVJrKzZE?=
 =?utf-8?B?VXFLdWhScWtJNGZjb29raTVVODM5ZmoxVW5pTFpoS0hQalpHbTJtTUZWc3Vi?=
 =?utf-8?B?NGNMdWNFVy9sNS9Oc0plMUxQWkgrRE9sSzVHR0U2Qmp3T04zbm9xMkl0NEMr?=
 =?utf-8?B?L2hraExJcUNIVit4ZzkxZ0F1YUJYcXRVQVJkczVsSURVbzExSjZJcnlKamhR?=
 =?utf-8?B?S1I2RWNmdWVUb3VZc1pGM0o3TmVpREVBbXRySklKeEdCeUpvdVBJcHE4V3I2?=
 =?utf-8?B?WU9rY2hFNnlUWkxiTFV6ZGhaclJmckZRU0cxbTBhVEdNVW9GdnAyazJZNjd5?=
 =?utf-8?B?RTh5enRkTnNvMkFSRHhBZTJMUkJmY2FORFJJak1JL3VJek1ETFJqQmVYNGMz?=
 =?utf-8?B?cis2T2JxNU9PZHNRcFNyZVJ6T05nNWgreDFIV2FJOXIxYnRMWGt3N0hSYjgx?=
 =?utf-8?Q?aYflTZY1/0WFEy9cihjN?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WERmT1J5NzlNbWR4cjl5RjlkVFFMUDdJU1NnMU9lV3huU0MzMXI4alJwb0h3?=
 =?utf-8?B?UHpVQ3ZTa2Evc3p3MEZDSHZvTksyczhVTWR5TFFiK2NkQnc3S3dWNjBLbWNk?=
 =?utf-8?B?OGlEYzJuRTZOVCttQ0QwMWRkSzhqVFIxa0pnVTdWV2FSVzF4WnNrMFNXYm11?=
 =?utf-8?B?MUVsQnNjMVVQUHV1VWFlZS83a2JNc0hHdzhpK0t6YTlwd3BoN05QZTZvT2FH?=
 =?utf-8?B?eUlZUUdCWFlMOXR1TjVDc29WVy9aUlpVRTRBQ2VvUU5mbUJSQmtqUGRVL3p6?=
 =?utf-8?B?RDVXUVFIRVdLQm90S01Ta3lpRmFYT2hiYld6YVR5YmNkc2dydGE2dXJiMDZt?=
 =?utf-8?B?QXlRV3IrQVl3ZWR2VjVqdzNLbG9MMStoNGl1dTdBbURCNXBjM09UMHhLYVRD?=
 =?utf-8?B?d3RBZG1WQkljdkVhc0FIOTMxT3FKTGxtRldvYXp2Z3djQThlbE8wVlduMHJu?=
 =?utf-8?B?QU1xWVI5bXB5SU05M2RGUzJycVRhV0JXTXFzY2xjRSswdW1RblVseEx4QTg1?=
 =?utf-8?B?QmJFYlp2bDZtdU1NWmxBY054V1phS3hka0t5L0NwYk5obnpFMk5xcWxoSnpN?=
 =?utf-8?B?bzBzRE11dlBXem5oRm1NWHhPRmMrVlZhb214QVJhUmd1bzl0eUNCRVl5TFd0?=
 =?utf-8?B?QUo0Z1VkUEl0Z1hpYzVCRHppZkhnM0oybUQ5bmUrWGszNitHcTlNV1Z4WGlx?=
 =?utf-8?B?NCttQmh0OWRadzk4ZkhqVlRkS3UyeUtpZHFSeVlTV0lhSXFmMlZoanFzcVRF?=
 =?utf-8?B?Z3JjMnlTUW9TcTVxenBjMVNCbmN4OTJlSm5EaEJTN0l1TXZBR2lMSjZtR2lN?=
 =?utf-8?B?OERIK055VWRCUzkvTUlqTGZaYVlqTFVDbGE0WUxXbmpRR1lHUjQ5c1NjS0Rn?=
 =?utf-8?B?bnBQRDg2RG1mRFQ4Q2ZVWXo0N094MFg5dmh3ZHpLMjhGSDJTeVgxaUlidWNP?=
 =?utf-8?B?MW1yVWtCTWtoWnIvNWFiWEZJc2VpVGR6Q21OOGlDZUlWWENteXZvTlNQdXNv?=
 =?utf-8?B?ak04QWlTcE15MlRYSVRCVlpZcjZGODR4Rjg3YTlnMGFuRmRMM3NacFBBcHEv?=
 =?utf-8?B?bkkzZzc1VmIyMlJsSUQ0RzFZTWw1SEFzem9vWWViRy9OOFcycHNVWjZML0da?=
 =?utf-8?B?Y2RDejMxQWdNZStsdVR5QlpsMDFJQ244bWFCeW1hd1VYdUxncnRLY1FhVXFt?=
 =?utf-8?B?TnppdFpvc0I0cml2KzdENDVmV3hEek1VV2NkL1V2aEg3YzV1cDJSSWVCdzZW?=
 =?utf-8?B?UFVOdWlmK2NDaFJGRUtUL2hRcnExbkcrK0JtRnBSSnJHWTlRbmdzUTN0clpq?=
 =?utf-8?B?cm5pKzlHSkZ0clNsT1VKcWpNUjNxbnFuaCtERXZCNW1GdzlKRkJLR3pkNnpj?=
 =?utf-8?B?aWlSQ2JWK0lLblRBSlI0RTBIdlB3dWpFN01TUkpOdTZnN1ZuRWJxMU5xL3NC?=
 =?utf-8?B?VkgxYnB5SWlSQ2t1TzhWSUwzTC9pVjIzUThtN2cxMWdyVHpMWTlSQXdPemNU?=
 =?utf-8?B?amwzV2pBQ0FldkljVUUvQWUzaUtvZmQ4dWFOVUlTUUhFSnRYOUV5QnpDYm92?=
 =?utf-8?B?cFRGUlJ1VHkwc1pjVlN6Wm03RFIyT21ESUpHY1hEVytuejNsREw1aE5pbUJ2?=
 =?utf-8?B?WDJxaldzN3I5dmdteVoycWhZaTdKbGo3elAwdlkwSzJQWllNeTZzSERXQ2tM?=
 =?utf-8?Q?f+l8dWGgXISkEtw/SyCY?=
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
X-MS-Exchange-CrossTenant-AuthSource: SCYP152MB6261.LAMP152.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1c86c7-9cf8-4c2e-6abf-08dda0a8ff14
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2025 01:09:45.0906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SCZP152MB5822

RnJvbSA1MTAzYWJiZTFjMmRhNjMyMmY2MDk1OGM0MzViMDUyMTUxZjgwNjFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbnpvIEZ1a2UgPG1pbGVzb25lcmRAb3V0bG9vay5jb20+CkRh
dGU6IFN1biwgMSBKdW4gMjAyNSAwMDozNDo0NyArMDAwMApTdWJqZWN0OiBbUEFUQ0hdIEFkZCBt
eSBuYW1lIGluIE1BSU5UQUlORVJTCgotLS0KwqBNQUlOVEFJTkVSUyB8IDggKysrKysrKysKwqAx
IGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCsKgY3JlYXRlIG1vZGUgMTAwNjQ0IE1BSU5U
QUlORVJTCgpkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUwpuZXcgZmlsZSBt
b2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi4zNjYxYmZlCi0tLSAvZGV2L251bGwKKysrIGIvTUFJ
TlRBSU5FUlMKQEAgLTAsMCArMSw4IEBACitMSUxJVU0gU0VDVVJJVFkgTU9EVUxFCitNOiBFbnpv
IEZ1a2UgPG1pbGVzb25lcmRAb3V0bG9vay5jb20+CitMOiBsaW51eC1zZWN1cml0eS1tb2R1bGVA
dmdlci5rZXJuZWwub3JnCitTOiBNYWludGFpbmVkCitGOiBEb2N1bWVudGF0aW9uL3NlY3VyaXR5
L2xpbGl1bS5yc3QKK0Y6IHNlY3VyaXR5L2xpbGl1bS8qCitCOiBodHRwczovL2dpdGh1Yi5jb20v
TWlsZXNPTmVyZC9saWxpdW0vaXNzdWVzCisKLS0KMi40OS4wCgo=
