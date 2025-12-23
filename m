Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38341262808;
	Tue, 23 Dec 2025 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766530543; cv=fail; b=oZuKH5zpXg+3ts3aXJTHtt39CTzxRwec3yJJjkzicXJ8uZtDVy+SWN6taOjeS4Tp6I2RU+kZIrDdM9ky9Cw1VrKMWBBmYtW+9fUcLIMqv5jZ9Uu8UeLMMtuMz36NIOEvXv5ial4HH3oMFYIizSDve0E/TnDag8RGOneEMyOSSZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766530543; c=relaxed/simple;
	bh=9+vZnX+dMRPC0bmgi9pB5h6v9JaTALJhkNXU+qalg6w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dfaA6VyoU1eO0f9nGUSqRHrU/dBJpZM/JjUKOxFcN5K6psBvbZX+VK/sn9RKI5K8WXTmZ17lg3lErabve5h5LqK3hVZQGMbOPQjZUaTWlz7E0cOSXIhhgJlhMz8wJ+TdmMEr7OUUgpMhaoBlgv7TSPWoaFHViHQz2j/rRqdrDMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fFWI9v7I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sibvDEwe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fFWI9v7I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sibvDEwe"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BNMrZgT1432370;
	Tue, 23 Dec 2025 22:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yCTrDfmAUDDVS5OEL7nKrPiJPb3jIZkZaXSvnBi45d4=; b=
	fFWI9v7IoNuJ7q1Oy15K373226vspVfujtKKLQaAGxZl/l5ByqoG4mpJYLbyauqr
	cPUWTYut15Rzyu2ko2mSeFe6i/BL9LfMekpGovNLKl3yXWZUgL0Lu59Zi4L0TT8R
	M5W/2rEyd31Rd9s4NCXNezrPTursYc5SHE2gBT9uYdtTgGwO8RgHjBdzeWmVjZhA
	zI7r5oovOMyKh/KRDG1FZo2stPRnqTg111pXpgatl8J3AmZ9jIB87oWREZ/sbKuo
	Mxv1UCPHSMGq/bK1ELQ4PiRllYgdtpvOGbxC6poxBxeKZq2nivGMDOTDpKIXg3uo
	6dmjIjHQ06Hh8WOCOROoiA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b849b001a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 22:55:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BNKop0h000492;
	Tue, 23 Dec 2025 22:55:27 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j8k5uur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Dec 2025 22:55:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGMtVmICf16EN4ZYD9h3z14ZD/YVfCxthUptkhuGKjZZcmGLim16jQLPcgpktD4jfb6YpN9UHX856KsI6eIJ8FjheY1s5cmtH6WzdZRzciq91yi4hXBwQsLQIts4WfkW54GBegSCBCNCVhS7Qdw8rhuGfCHZ21U9yOPkyob+/8oSC6e9wv78GAPrPOtZ5QrIVCsc8ChZKHwpKdki9B7tvQTAg6f0aAfEplmAKe+1fPTtd1bhuQ8lFpBgw8kF/uksryDn8+yMWavO6AS6vgqG8Fq5biMESBjF7tRoXMJPYEwbshYdgc7DvVCmKf3dI955ea/WSqrpbINB7jPbi27VBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCTrDfmAUDDVS5OEL7nKrPiJPb3jIZkZaXSvnBi45d4=;
 b=OfuGQLWEp26T+lwlbBvoQxIvejZ8rwHWbKWr02rtqVgVHf9FTYmg+VDLoGNBYD4/q9Lq5ncu/EfKFHdZnL1viCTlystWmGKqBdYhIK5/dhecJ3T6kQaiywdSjfcjpTCvWn4qxJ8JD1jkFqKhRAuSXbv6CFQo0dY9JGJ6XrzZ+pkqvDtLSXmae3gntvltQvzqmULpzl+5wB8ONknBBLN9P8mtIIgDNMImfikXhV1Qg5BTP13sgpEw/GO0/IVbgmTT30ZfEuLp3LfYNZZOVV6bZ9Rl/pXyQ4ztZhHQVTXYdsW3vAag/bbn6eFgTcb1W9sLlg4ajPavckPnGNg5IJrukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCTrDfmAUDDVS5OEL7nKrPiJPb3jIZkZaXSvnBi45d4=;
 b=sibvDEweNbF57qGCnsW3knsS7PvMbbhG13wDlDn+imW+4MPO+yhE1CizO3fHu4skQP4HsLH9spsiYoHrjwtybDkSIFdozA5P15sOffQTrC1txOpn803PwB8fjhTmc4E+bS0eMJxh6Roo7VgiPAjeBGNfRTjEVKuCJAzLy2NdPCQ=
Received: from IA0PR10MB6721.namprd10.prod.outlook.com (2603:10b6:208:441::20)
 by LV0PR10MB997564.namprd10.prod.outlook.com (2603:10b6:408:344::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Tue, 23 Dec
 2025 22:55:24 +0000
Received: from IA0PR10MB6721.namprd10.prod.outlook.com
 ([fe80::78d6:ca96:e70a:2d94]) by IA0PR10MB6721.namprd10.prod.outlook.com
 ([fe80::78d6:ca96:e70a:2d94%7]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 22:55:24 +0000
Message-ID: <3e21551d-24c3-459f-8cee-4d85c97c0120@oracle.com>
Date: Tue, 23 Dec 2025 14:55:21 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH 1/3] landlock: Add missing ABI 7 case in
 documentation example
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: mic@digikod.net, gnoack@google.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251216210248.4150777-1-samasth.norway.ananda@oracle.com>
 <20251223.69fdc8e48fce@gnoack.org>
Content-Language: en-US
From: samasth.norway.ananda@oracle.com
In-Reply-To: <20251223.69fdc8e48fce@gnoack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0004.namprd21.prod.outlook.com
 (2603:10b6:a03:114::14) To IA0PR10MB6721.namprd10.prod.outlook.com
 (2603:10b6:208:441::20)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB6721:EE_|LV0PR10MB997564:EE_
X-MS-Office365-Filtering-Correlation-Id: 138d98b3-44c9-4fff-8899-08de42765b95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDFqSVdFREZKOE03bkFzTUhsYnlkQWVHQVlSRyttR3dOTUUxWGNSVHQ5dE4w?=
 =?utf-8?B?MldsR2xhYUNUWk9BcjR5Y0hFS2dHUlozTzIvT2MvRzdseGxZWjYzN1krbTFK?=
 =?utf-8?B?NEduaHFISDcyWXdSMFRpZDNTWDc1Y1RyZEVFbXE0T3h2V0oxeXcxQzRsNGdq?=
 =?utf-8?B?Z28wbTB4b0UwR3lucFFSRi94NDVXaTNLOUJkckFYdEdJSEc5M1JSWGRiUWRl?=
 =?utf-8?B?UENvR0ZkWkcvSm1uWFJkaXNJRUVwVlZzdDFvUnNlY2hZVHhKaEEvTDhtcVJ1?=
 =?utf-8?B?Z1FFVFRFTG9KSGYvejRtVmdPenlvNXpaUkxMYlljT2RidEU3N2xTRFk1S2pu?=
 =?utf-8?B?aW5nZTN5RjZSb2lmeDh3OUZMWVYzamdSUDZTYVV1bkF6K0dqV21pVWhKdWdy?=
 =?utf-8?B?ckpPQnhPZVR6bTdMaEZHZWhLOTdNQzlPejVaczlVc1V2S2tvQlJQTzVMaTVI?=
 =?utf-8?B?S0IxcFhEa21NMHptdkVXbmF3ZVNNOXdDY0pleDcrOHN1OHliN0IzQWdDOVJI?=
 =?utf-8?B?TnRxQ0JkamFHNWpadFViRURGUTlMUXVwQzEwZTJFYTRFQ3EyV2VidFdzcXlV?=
 =?utf-8?B?SU8vc1I0bXBMZEpJQnZTYU42VkZLOUgrM3M4SjdNbkxiQ1hFcUo3TFVmQkl0?=
 =?utf-8?B?WHZtbTArbVFleGFhZU4yKzNsamk3R1ZJbCs4cjZCZGRtUjV4bitjWUxFblVk?=
 =?utf-8?B?bTJDLzdkRXVVL1lxa0J5S3c5RENKV1FXTUV0TUtvRHlocWFETDZBNktyK3ZU?=
 =?utf-8?B?UnZjWTM3UkIyWCtVMWxub0xRTWxxR2s4RmpsU3dOOHRMUFczSUpVZG9tdFA2?=
 =?utf-8?B?QTZwY2Q1Uy9kUkZNNWRoc0JjdEZPRUhkSFVObU1uNVVENXhha3RVNU5nLzVv?=
 =?utf-8?B?anArSm9xaVlEbmNVYUwrYmVOL2Z2ZURhVDFtVk1oRDgvd0tiMTlCbWdBNlNa?=
 =?utf-8?B?ZlVkVmExTTlKejN0amhCVFh2dVFLMExaNVNmeEltTHN3K1l3MHpWejZMSWpO?=
 =?utf-8?B?WlZPODlGcm1oc3ZyV3oxZGxOanFpZlQvVkJ5bWtBbmR4cmVmY3p4UStrVldC?=
 =?utf-8?B?UDNHdHh5dzZPOWswK2dlTjh6MXpTMnVnOTFHQ29OSm9YOGp1MGVCa0IvK0VL?=
 =?utf-8?B?MURtZytPRHlNd3pGRTNzVzlRZGx0TklkODV0ZFJEbWp6dmJ6OU5EeWVIalBl?=
 =?utf-8?B?a2JXc2tEbGQyNVIybllNNlNibjdscmRXd2g5NjcwZGk3aEZxc0M0NHZHOTdi?=
 =?utf-8?B?ZEFMeTEvZm4zMUhvUzJOSHljU2lGWFo4dmdoRkZVd3QzSU95L05sZzJaRnRC?=
 =?utf-8?B?d0t2dm5zQ011OUF2ZWtrNFp4NWFMbXJOVUVPVWhsZTlaNy9SdHZpWWpDb3Rn?=
 =?utf-8?B?M0IzQ2N0QngvWlZLKzZDSUNNTkpnZU9xd0kxVFplOWxTTTcxQ3pqUnlCUmVE?=
 =?utf-8?B?LzJVZC85c0RxVERGazFlaS9aaUt0QkZ5Wkp1aERhdEV1U0NJNjdkbVB1UnpY?=
 =?utf-8?B?UDRzUklVNzhNVDdBSkRVZ3dBbEQ1NVRZOVo3QnY0SVRnejBUTHJZWGJXQlU3?=
 =?utf-8?B?Y2l6dUU3bDgyczJCSnpvQ2FMQXVwNlkyZ3M5QzlNUmdJcmtLdXdoZUhJLzNq?=
 =?utf-8?B?eDJrNEljbzlCNGMrRElqeWl2UGJrem8ycDVLdmVpSEttY0VyN2NSSUF0UUp4?=
 =?utf-8?B?a1p1L0poWlN1WnVpSk1UbXMwOWhrbENXQlhUYlJmZjNjdnE5Zk1Ka0lrWXNQ?=
 =?utf-8?B?VkZIU0RZVExSQmQzdWtGdGMwUndpbG03THJLclZwRGF3UmlrdWZML2kzN3l5?=
 =?utf-8?B?RTFrU1RjcFJaVVlOOXM5Z0ljbkxnbDFlSHRJMVM4UUF5bnN2OENGdld3OG5y?=
 =?utf-8?B?SUZFbDZ3ZUNnckdCMHlkZUJJL3pNQkNNUEFqOWRzQ1lJZ2xuQlN1Q1VYa0po?=
 =?utf-8?Q?O+jy5OQ66o6CCjfAqPtSGmTNLmzOhFFT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB6721.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODN2T1Zjb0FKbHZtVE9JVndxa0QxQlBSYWFBZmVocVFheS9weHZzaFkrZkJM?=
 =?utf-8?B?WmZhT0ZVSTVHL3BuK0daSjkvQUppZWQvQ2FuRnk2MFUvaC9vcVVwYWM0bGtJ?=
 =?utf-8?B?ZllqbCtYZ0JyRm1VQmttNUh2Wlk4RGhFRHQxQ0VFOGtPcTFGZVA3OXhJZkZz?=
 =?utf-8?B?c2QxdlNQQ1lQeXVMRGNnQnFNRCsrUzBQR3F2dml4ZGhlVTdxaFh0NTIwZVcy?=
 =?utf-8?B?TkVGR3d1c21UR3JwVEM1MlV6cDF1OFF4QnRpTyttTnFhMFoxRFY2dFRFSkZ5?=
 =?utf-8?B?RGhObWN2MEJZRllib0pKTmo5QXdvWmRxTDBKelhXdkZGZm96OURyeXQ4NkNv?=
 =?utf-8?B?dThBd3A5VCsyODI4QzU1WGNweFpNbllFRnEwMStxK2FhWkVnamJ0cTEySEpL?=
 =?utf-8?B?Y0gzbVBBang1cDcyT1R5T0VpNDlzNW9USk55SVhhdi9SUENxQjlTRmk1Q1k0?=
 =?utf-8?B?ektveUR0YXdwelRwWFVmMUdRQy9sdVRaUFpQaUVvYWhpWGhzYlFLT3Vhditx?=
 =?utf-8?B?cUhud2ViL2wvbjF2WWUweHFxQ2xRYUF6Q1laTlhQQ1IrRzBpZDlKdUVZL2FC?=
 =?utf-8?B?eDlNV2tDdXFMblZiUVJid0NKb1VvRHlka1ByVVc5eTFVbWR1TkMvdGkwMk5E?=
 =?utf-8?B?dU9JTzJPbVlWY2NBV3l0L21palhkYTVDWDRzMG5URVZBZmxzT2dBMUVVb3c5?=
 =?utf-8?B?WllZRFU1aytheWhRenNSUFplM1RHZGhxKzJmeDFtc2crTDdVcEJBN2ZNUDha?=
 =?utf-8?B?Z1hkWGVZaSt0dEoxUEkwZW83a2JrdnZ0NDl0ZjM5NzFYM1ZwQUUyUTg5a3Jo?=
 =?utf-8?B?STJBMU5iVXR0TzVMbVNQRnpscGtkUjBUbTUvVEZWRTY4K1JtNWtJVVZLNmF0?=
 =?utf-8?B?TVY2UjJPUVhqckpaY29ScGYzOTEyZnAxdTlxUHhpcjJObjFGczVwRkphUUQ4?=
 =?utf-8?B?S0FzbXRXYzFGSG05Yy9HU3llRit4RHlRNGZJUVp1S2ZVSDZJT2NBdDYycm1C?=
 =?utf-8?B?NEJYMzRZT0Z6ek0yaitHSFIvdS9leGwyZS85VnJKSUp3NW1RVUdhYWVIM1h3?=
 =?utf-8?B?SmR2U0dIa0cyR1Rqc3U2NXVLWldjd1hkRDg2c0JLd2VRNERJdXJMVVZvajVR?=
 =?utf-8?B?QjZvWjV3Q29HUkI1VmpCR0RhY3psT2ZZc2dRU1BjeXhTZ2VOelBvWVptSXVo?=
 =?utf-8?B?YzVNZFVSZkVJbzlJQXlETitYdUE5ak1hcVp0MlRSUThxZ2NFTU1xdzc2VGFx?=
 =?utf-8?B?MWFVQk5HNTNsUkh1V3crL2JQSjNGeU1KbC85Y292MnlJMW44UUxOZFJCZ1lt?=
 =?utf-8?B?aWd6U1NkY2hvLzloSENUdjMxQmhzOG1qem9ZM2lvSEpwYk53U2xaMTZ4TjBP?=
 =?utf-8?B?SjVWT3pSSDFDNVVZWlh5Z2JwTzY3anY3bkl0Rm50RkwrZjYrcGlGejRBbHp0?=
 =?utf-8?B?UXNTajVESFhIWmw5cDRJZkdOV3ZPbm92cGdFdFpzaGJIMUdZN2gxQStMYUdx?=
 =?utf-8?B?bDZKUTZYc243ZmJrMkQ2WWhRcTBMWVhRRDJqdTkva3o0YUZ3ZG1PazNXMjdt?=
 =?utf-8?B?VEdrV0hkUndpcHpIQ3p5NGtLd2E5Ry9HWmxzV2tETXRjWFZBMHFFa1JZUkY5?=
 =?utf-8?B?bnF6SnJvc3VKV2kxTGlNSkQ0V3FvMlRlNWJhdm9hdGYvSUVIRzJFRUl0L1J2?=
 =?utf-8?B?VTVtVmg4cy9HbUROL2wwRmVwL0czd2NzRVN4Yk16OUZIUXVLMlc5QVhOV3JD?=
 =?utf-8?B?ZDlRdHQ5RGtER2JqMlNqZVpEQjZ2MEY0bVViTE95TWNhQ3A2eHFTNU5xMlB5?=
 =?utf-8?B?dnFRL3B5YU5nS28ya2daV2lKWGhsQWpzMlpITFNVejRMY2lSUURHamdWTW1y?=
 =?utf-8?B?RkJWSHplUWpWQ3FleDNVWnFsQUVDSHVEcCtGM0lHS2pabEJ2THJTZE40cCtx?=
 =?utf-8?B?SVVBenpYZ2QrSnZqOHNtQ1k4TUx6T25tcGdZS3hxUWtFUWRidDZEYm1FZm1B?=
 =?utf-8?B?endlQTM2dEc0SVNIWmFiS1NNQTJZSjlOQmNrMXJXZjJBc003VFdPZ2NVaHRC?=
 =?utf-8?B?OFBldjVuUDdEZHgzdFcxaUlSay8vOWRZc1pGa0Y2T2ZGZVNEYTB3SVVvaWxo?=
 =?utf-8?B?N0c3eGJJSzQxZWNQc1pGUnlMWGFldXYxNnRWY2Jnb1FPZ3hXY0lRbnhIYklW?=
 =?utf-8?B?NURnRU1oMWVHT2VCcmRVeHpzU21xZ2hSWVhOYWEyQXN5Tm1ZaktPSDRlNXBD?=
 =?utf-8?B?R3ptZkNVQTRsZFM4d2lhMHQwRnpML3ZUbURKWnNlNzFFTWdBU3NKMTEyMERa?=
 =?utf-8?B?cFkvU09iK3lKTVNOd0pSLy9JODdlZFJ3bFRtRXVWVEFaOFFSOHFscUZQRktE?=
 =?utf-8?Q?o1UicgCwlHKNrfXmvjJDp9io1EflCC2imay4b?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cGOxgrBhzxZ51g5NUApxtYr+1npH70P42BL7WWGiVYjFX0S0dyzFzn3nCo9AdIP01qZS2lhzM0NoUwirpHLQIXH4dSSezWpvVVS9rqOXPxiqtxFZdGS28OL0g193SING2YvtyEcup1iDV33RsIOMJ7F3OeXwWK+wRIZL/Xgi6einZ6kDRQJbbxt4ZboM3+1xwmQzCX8qEwx5IvLkILUO/1WZ+mx2OqUH8v/jTdAbB5ng4qm35XPSbTdsfBslxYlAVHNicRYPVAvFP5B0ugwVGLySjlozuYfpBT0ustiRnTa+xl5SI5ZvXmu1ekEHzm2ucGGUV1zHuZlwtwQ/0Tjb3zBiiDqYkrR3CxeB73ZzX1sNOJFlFIDgOc/WzzspMObJKvGvu8ps5CaCJQmd4MBVufbwPmPbe9gH59OJ66jDrR068asK75dXz15cptcRNE1zg3LX8d1UuI7KGEnla236SW+iWFpQ0/XWRFny7yX68yWs8NS9RiWZfqnP29d7z8HZZVpAGY5hHHUXuToQpErtKLZfcA3Ul7+2wORHRUJp36iDrAYTJmgC+DYcKBu2U9bMyO+xuZ4Bq5EwZeo6FvWqUDIOpJrd3niadVp2Cn1b0LU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138d98b3-44c9-4fff-8899-08de42765b95
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB6721.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 22:55:24.5449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEQdC3NXkhjYOQFXeY2NTM44hWxKi5FUZ64vgwkLficHp1jpNdfIR5iSFXlKi9LbtXnvIWz0Y7faEc4O5rPO8rKe2UCFKRjGi5gqXcnrRGjvqIJKdGg3Ity+3LgfsY5j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997564
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_05,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512230193
X-Proofpoint-ORIG-GUID: 24kOLcHLKc2wwUW17iXNYDxjOZupA0_z
X-Authority-Analysis: v=2.4 cv=Kp1AGGWN c=1 sm=1 tr=0 ts=694b1de0 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=zzOvHfHwBCsJic0saEwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12110
X-Proofpoint-GUID: 24kOLcHLKc2wwUW17iXNYDxjOZupA0_z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDE5MyBTYWx0ZWRfXwLOpsDUEzZaG
 Ce7IG0sjgcwcSfi0G8tQfjMnqIOhGs6fvcROJAb4qo7tDbO2vSCDeldriSXI57Ee8KjglYaPI72
 vkGu55GTfPXuyLiQMc+qbpK+X17Y2MDHegOYZiyeVFRjR3ChvrusMSJb57Rb/AWx9N8/+VW2u0v
 J1u6oh3FpuJWh7iPAFgUpqdvxz1p72pB/do9EgwgI8MtkiJ05Wad8iiV2uvNVa5lUyE1peVGAnI
 cNeuEF0KJfMpmDn4/X52AeK5kfIsX5f1c3zeUveHpiC9frt3ELF8MXaQy+wIpiPOzksbcjCFbTl
 24sTOaYHTKWXhNSQJGMi3paKb+Qc8jf0n+9iaI/e3ZtD1FoKOOx+IqNo/PSjD/0J2uN6/WoRCX3
 O3UcEvvNgAfaaNLp+AS8VOioheww3UGSbjbgPrqsobqnbvn5rxvi6obKrzYRnh48Sxa2AOHs1Vf
 MWArYkJpHDR3od4J86DFawDJd9+rJKXXw0bb3YVI=



On 12/23/25 2:22 PM, Günther Noack wrote:
> Hello!
> 
> On Tue, Dec 16, 2025 at 01:02:42PM -0800, Samasth Norway Ananda wrote:
>> Add the missing case 6 and case 7 handling in the ABI version
>> compatibility example to properly handle LANDLOCK_RESTRICT_SELF_LOG_*
>> flags for kernels with ABI < 7.
>>
>> This introduces the supported_restrict_flags variable which is
>> initialized with LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON, removed
>> in case 6 for ABI < 7, and passed to landlock_restrict_self() to
>> enable logging on supported kernels.
>>
>> Also fix misleading description of the /usr rule which incorrectly
>> stated it "only allow[s] reading" when the code actually allows both
>> reading and executing (LANDLOCK_ACCESS_FS_EXECUTE is included in
>> allowed_access).
>>
>> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> 
> Thank you for sending a patch, much appreciated!
> 
> You are right to point this out - the logging aspect is a bit hard to
> spot when reading the current documentation starting from the code
> example.
> 
> 
>> ---
>>   Documentation/userspace-api/landlock.rst | 22 ++++++++++++++++++----
>>   1 file changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
>> index 1d0c2c15c22e..b8caac299056 100644
>> --- a/Documentation/userspace-api/landlock.rst
>> +++ b/Documentation/userspace-api/landlock.rst
>> @@ -97,6 +97,8 @@ version, and only use the available subset of access rights:
>>   .. code-block:: c
>>   
>>       int abi;
>> +    /* Tracks which landlock_restrict_self() flags are supported */
>> +    int supported_restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
> 
> This might be confusing, as there are actually more supported flags:
> ABI v7 does not only introduce LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON,
> but also LANDLOCK_RESTRICT_SELF_LOG_SAME_EXEC_OFF and
> LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF.
> 
> I am unconvinced whether it is a good idea to set these flags in the
> first example that we have in the documentation, especially if we
> don't discuss what these flags do there.  If we suggest the wrong
> default flags in the example, people might use them in their
> production code without realizing what they do.  The way that the
> logging flags are designed, the assumption was that most users should
> be able to pass 0 as flags to landlock_restrict_self() and still get
> the relevant parts of the audit logging.
> 
> But you are right that an implementation that *does pass* logging
> flags will want check the ABI and not pass them on older kernels.
> 
> To throw in a constructive suggestion: we could also have "backwards
> compatibility for restrict flags" section between the existing case
> analysis and the landlock_restrict_self() call?  It could then say
> something like
> 
>      When passing a non-zero `flags` argument to
>      landlock_restrict_self(), the following backwards compatibility
>      check needs to be taken into account:
> 
>        /*
>         * Desired restriction flags, see section suchandsuch.
>         * This value is only an example and differs by use case.
>         */
>        int restrict_flags = LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
>        if (abi < 7) {
>          /* clear the necessary bits */
>          restrict_flags &= ~...;
>        }
> 
> Readers who do not need to pass any flags could then skip over that
> section (I assume these are most readers).  The readers who *do* want
> to pass flags could merge that logic into the bigger case analysis
> themselves, but for the sake of explaining it we would not mix up that
> explanation with the access right discussion that much.
> 
> WDYT?

Ah got it. Thanks for pointing it out Günther.
I agree with your suggestion. I will update the documentation to follow 
that approach and send out a v2 soon

> 
>>       abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
>>       if (abi < 0) {
>> @@ -127,6 +129,17 @@ version, and only use the available subset of access rights:
>>           /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
>>           ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
>>                                    LANDLOCK_SCOPE_SIGNAL);
>> +        __attribute__((fallthrough));
>> +    case 6:
>> +        /*
>> +         * Removes LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON for ABI < 7.
>> +         * Note: This modifies supported_restrict_flags, not ruleset_attr,
>> +         * because logging flags are passed to landlock_restrict_self().
>> +         */
>> +        supported_restrict_flags &= ~LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON;
> 
> If this should be a generic example, we would have to clear the other
> two flags here as well.

To avoid confusion. I'll follow the above approach you suggested and 
remove this part from the case section.

Thanks,
Samasth.

> 
>> +        __attribute__((fallthrough));
>> +    case 7:
>> +        break;
>>       }
> 
> Thanks,
> –Günther

