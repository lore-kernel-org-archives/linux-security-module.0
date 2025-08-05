Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83281D61AA;
	Tue,  5 Aug 2025 23:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754437434; cv=fail; b=JwgMLKveUN563COTpxwPF3WbflO3IZ+3UZN7+RxL41zCGjDTpjtJOclZSsNqTJoyTwEh1JW8Z6uFZOJWklbszRGYXP3QrNSujz0zw8vflUfSkm1ov7UBvOnwkJvvyWkjWLCCB39B1shvsOfe2WLXmCPMemNGggpb8klSu7+/rAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754437434; c=relaxed/simple;
	bh=wcMWa7wDrlSQ4wN99zzCVXCjc+T7LHptqt7Ebvpn0Wk=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=k3n1sr6dvIzkfJ39B1R4FDi+uQ0eqNmK6ukTHGoXvnpsW4Hr053zftFwOWUsPDvwpbOmKNHsqQZ+0Ydd12IcZUBz/RlczVpFgt4EB/M0FxZRrfmsz4aa9xPVMrCPc2CCcaB3oWId3cnoKVKJFuh1At7ZzKnXVIkFgrY+wIRv9XY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6r/mymm; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6r/mymm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754437433; x=1785973433;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=wcMWa7wDrlSQ4wN99zzCVXCjc+T7LHptqt7Ebvpn0Wk=;
  b=Q6r/mymmr+Bp/QNa2MfzWt3dpyUGRQ5Xly+F9yKYfl6bw8Mt7WviVAe8
   kC/8VHLNE97oebEl92MtdrLZm23lLiWwrDVNhbSVc2QzmTJCyk2CslHDe
   vcUuy+Wi0HIj6u9rSCfEYAiku3JqmN8fnV5N+M5wCZOB6uyLM7pZn8/30
   QCXMbjbjP2CPWiBJ9nl+dqs4J3ces3GQ8PgkUgDrETraPEM2aJLpG3miZ
   03lLz4JiG2YQmNLX2RLnxp3buKgsWv52Lx4pI/riBl4uIGtDRL3uIwp9X
   VLS8s5MXvo63gSYPcKD+Nxr4p9MmQUwYsuOG8QLvLVwuMJF+1EI/m+MXV
   A==;
X-CSE-ConnectionGUID: bFAgsyPdRXepw7u3Z6VO5Q==
X-CSE-MsgGUID: pXQOYNUAQ0SSu/X8lq0Q7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="68119226"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="68119226"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 16:43:50 -0700
X-CSE-ConnectionGUID: c5JfTjPIQJOgeO3j77MtSA==
X-CSE-MsgGUID: XHJqU92vSqCu8rjh3OD++w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="164641837"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 16:43:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 16:43:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 5 Aug 2025 16:43:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.59)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 5 Aug 2025 16:43:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9awygo/pKnJQoQ0+vDtkBUVNK0/otIKi8ipPtkCeDxmYIKc3fvgSjeacBn35JCtZm+CDngjfbdiULfvK7Mf31GObIK+A/+nEoYl3rjjERuYnd/BYR7GHDBUV1hdFb43LiZYbAU9eFXl1RcUvEuiMKaslhXjIPEwmhS7bgj0UImZDaVY3r2QHC06YZ9JQBYQhsOP1aRgSxm2gtFm2ltpA/GFdn1vkr8z6m7dGYG/svXFfoijNhFUx2zpxtt2W44DH6s7kpqPueAX4NsZptZNRe16p6LfCUT4N1TDKQljPgQUuu2Xj14GKGGhpvPQ2iiRKbmp3cFqN1L7zksZQitg4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKkBlQ7N3QHJ7akVKJC+tV0KYnl5xBdnvxrTAnqNFHw=;
 b=C+AAf0dGcy8U9vr3bUBzKdwpcf5tWEZDlAu4Q3DHif0gXSrflqS+rks1Nq+qb/SxvEMntA1vKOSrA+wNL7IOSzhfddpnjGFi/dJZi1MyD55rxilypg8QDtUQIcbhImhPRUP/aUBGpDC3+fSy/8e8Jhspjr9pBxxEQ3lp+wy6GJwv6/OPAa1RH1mKfD9R+qQiU6qxdlbSvp7N0x9LmdPyt/a0vm8rQptf8KGshxPEQtvdKrdu/DJXY0CoGBkQFwTd9aIeIUiG1+/uLdk+OOIUyvcuioE1hz2k4i53knkVYxDcNtFd3n9iPA7h7uBh4oXX+xoEkuhvkUt9Ga5rwYdFRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 23:43:31 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%2]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 23:43:30 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 5 Aug 2025 16:43:28 -0700
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Nikolay Borisov
	<nik.borisov@suse.com>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<paul@paul-moore.com>, <serge@hallyn.com>, <jmorris@namei.org>,
	<dan.j.williams@intel.com>
Message-ID: <68929720cd3b7_184e1f100e4@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <kl4rvgnupxnz4zrwlofrawdfy23tj2ylp5s3wovnsjxkr6tbrt@x5s3avqo2e7t>
References: <20250728111517.134116-1-nik.borisov@suse.com>
 <kl4rvgnupxnz4zrwlofrawdfy23tj2ylp5s3wovnsjxkr6tbrt@x5s3avqo2e7t>
Subject: Re: [PATCH v2 0/3] Allow individual features to be locked down
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: c6bb282f-034e-4a77-dbd0-08ddd479e21a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlFjT2h4SmJUUFVRckFmTDRNYUlHVlBRWDgvNU9EcnZoUmtJSmVWWFE3MWFU?=
 =?utf-8?B?YTVhMVVSN1RSZXoxZkNUaUxhdFhrQlk3SDRhaWZXL2NmTEt3dFRPNFA2OHg2?=
 =?utf-8?B?aUpKTmcwMG5HUTJxRTNNWmQwNUp5VUllSlh0M3pxR1dKRXlyN1ZZYU5tL0tm?=
 =?utf-8?B?Ym5zVk1lb0Y0QjY4YnhrNkxuLzI5elltbWJmNWFlQzRRU0lKeG94Y29TN2NX?=
 =?utf-8?B?UXowRWlMTEdLNmZNc3Z0b0FmdGlJRDVsdE5Mc0ZUQlJwenBpMjV0TUFhZi9P?=
 =?utf-8?B?TnZYUitRYUtNU0dBbWtkTzBtbExMakpVWENCbExoNmpoZHZ5SnpDMWVSdWpN?=
 =?utf-8?B?dGZaTVZNREkxMXlCa2xqaU0vbkpRczFXcmtlQmpHVm54czRhRm5ldThwbFNt?=
 =?utf-8?B?dGg3Ri94bzF2UEdBZVVhS0lOYTZYSXEwR2xoNXA4TnpGa2VxZ3N1Qmp5eGZl?=
 =?utf-8?B?dUtsMW9XNDEyTFVCeTIyeU4xcmRzL3VTbTF2dGcvdDNuanF1cFpySkVCamZL?=
 =?utf-8?B?UTVUN0pXQ3RMSkpOK2pTREhLV1JCYWZkOVVIaTJ0dU1lcEdPTVVRZDZCZW8x?=
 =?utf-8?B?bHprRDQwWGFMY2tkYlVnenRFOExBNjc2TXY5aDk5ZStsdmt5SkxEdFZSN1VC?=
 =?utf-8?B?Y2NXR21iVEFjYkhOekNHOVpxaDhyQlRTRlZMbTc5eWNXUE1tSVdzL3FZTEhq?=
 =?utf-8?B?cnVYazdNYndHaFE2aVpuVzAxdy9Gby9QY0tCMU1WUXJlMzlCb3c2d0cvbnJO?=
 =?utf-8?B?M2FDT0toZ2hGSUlaQktacE5UZDhvL09BQjFUeVdaUC9GcStqRkpJZnlJWHM4?=
 =?utf-8?B?eTkyUDN0UDNEZW5heEk3Tzl0TVlhSDI1MEFucFVQTXU5QXZnNmJBaUNydFNs?=
 =?utf-8?B?aStvaDIzYnhZeFZtQXVlaENIQ2Y3dUZ3d29LU3NwenE2TEJITVVoV1Qxa0Zn?=
 =?utf-8?B?aWRqMU9PaVk5RGdoTWg0V0dzUXRJb08va0xJYnhadlA2dEp5ZlJsbnRPYmEy?=
 =?utf-8?B?WHdycGtxRjU1czN2UDRicDB0SzVaVmcxdTlMZXg2SnRYdTNLd0paVHJVSXM5?=
 =?utf-8?B?eHZHT2JuSnJ2L1NmMEZjdGNJL2hIbzJpL2pzQ2tncEdoM2NobURiNXRDZnEx?=
 =?utf-8?B?eHhnMlNGUGEyM1loV2d0Z3lNWnRYQm4yYVU1bStRUkRKcWwvSFFLQTdPN2pj?=
 =?utf-8?B?am9UM0lwZi9YVmxVV3R1OEE4SG1pZFFiTlk2bmRtSUZXWmtyMlhRVHp0L2pi?=
 =?utf-8?B?UDg2clkyckJvbHViUW5Zd0l5bTkra24zUFJKWXlHZnp1Y0N4SmxWa1dKeFhF?=
 =?utf-8?B?ZEJGZ1B2SmcrNzJpYTdDYmpkMlJwL0ZkVFpRbmJnK2IxTkdHL3NtcDBTaitT?=
 =?utf-8?B?N0haZXoyazFCUVJpY3l6ZDJuY2VTNkIwc01ISTZ1SVFJakFzbTJIcHRVNmFY?=
 =?utf-8?B?MUNuR3haWTdYTVpQUTFTQWxOWjFFcml6RVVXekpNWnM4MXY2eEo4SDdzSDZj?=
 =?utf-8?B?NWYxUnYyYTVzQ3hXYmdsTzZBY3FJcE14cGNEU0Y2ZFc0Y1FjaDB0eXFYOHlS?=
 =?utf-8?B?anVmcFBSRHlVeW9yNUphZlExNGI3NkRLOEJMNWZtSDdncDNJOHJySkQ2dGNE?=
 =?utf-8?B?U0NSYjl0ZFBuQ09xT3U1K1c4V2s4MWwyMU9nNmcwVXVGZlNsQlExbG5Gb0Z1?=
 =?utf-8?B?M2l4WmEyNG9MQ3djaStBbDdlQ2ttYzhEd2hEbVhub3VOK2VMcEhFK01naXRC?=
 =?utf-8?B?VWx2djJPOCsyZzJRQ2ljZEh2eWI1QmtRZTNBanZXTFhWbWJnZGtPZXc4cmtF?=
 =?utf-8?B?cVF0L0sxbWNjZzRYMksxUUs3cVdIdGFxZzU3cDdRZUU5amtHUUZ0QmpLeFgw?=
 =?utf-8?B?ZHdvaWtDaE8wNlNvWmVYOFYyMXRQYzRlNmVMN2wyN093QVpYeUxxclpMaHM4?=
 =?utf-8?Q?AsUti+7En+4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkEwaVJnMTFkVEdBQU1Wb0NYMytEOHprWlArcWUvU1FORWJNeW8yUlRraVlK?=
 =?utf-8?B?RGJxakwxU2ExN21iemFsZ2RvaDBJTDNVSTZOa0p3TEN5OFZRaUVyTDI3TmtN?=
 =?utf-8?B?ZWdsUW03eUFLNjNuaEVERytxbS9ncFQzZDdrUDNQQjJqU09oMGsyMGpSNktL?=
 =?utf-8?B?d21nYWxIVHQ5d3ZpL0tKVFRtZk1QdW5pSnJ3eUo0ZTJRaFF3Q0poeXhyZmtr?=
 =?utf-8?B?NGI1eFQ5U1o0aThaSWNyVE4zVjJXd1FwMk1CR3pVOXhCODFaMnQ4VmhjWE5F?=
 =?utf-8?B?eVlKZmNOcWU3SHllYzBpUzFSNXRUdzRyVzFQa3c2dXhEdTlmeWhDQTBtUlU4?=
 =?utf-8?B?ampTM1ZtWkdKZ2xybGpobFowUWZDRmtjMlo3ODNsejg3MDlEcFAvNktxZ3lD?=
 =?utf-8?B?Y1cwWVRScUhrYzVMKzYrZENYVUV3ME9sckdwZDR1aEEvUnhFeXZGNnRqbnl1?=
 =?utf-8?B?MXY0MmV6bUV5RHArS2wxQ0tRM3IzeWVtbVk3VE9zYk5TMnEyU2JJeVE1SDhE?=
 =?utf-8?B?MmhOc1Npb3BnU0ZBRDJUZkRxTnVOdEx0amdHVWZ1ek05Um8xM2Q1clJ6bEhY?=
 =?utf-8?B?bzFKSHduSXZBRUQ3MGFTZFVxRDhjZ1V6aWQwR2Zkck5vYmswb1NsSU5kUk9H?=
 =?utf-8?B?S3M4dE0xSU1uK3ovckVLRlNuQit0L2JQajBUeFNHd2xKL1AzRjk4OTBNbmEw?=
 =?utf-8?B?YkZNUjlCR1MzcFpBSjZQbytXUGtQOFZqRWkvcHhkYmV4TmxkaGlaK0pFdU5v?=
 =?utf-8?B?Y2x0V0Q5UHNwZzVJVy83Y1NKV1AyR0h5azhzRTZPTmVTMjNKbjI4eDFnVXc3?=
 =?utf-8?B?Q2d6c0NtaExMTGF0NUtEdGNvSFF3ckJoQkJxSmtuc0FwbWI4K0gwWGo2NHUv?=
 =?utf-8?B?bTBUTG1sTGJOYW9HVjVra0QvLzVxWUtDcUk3WmtmTmdQb2ZoZW84MWxZK2lF?=
 =?utf-8?B?QXlIM3hwTWQ3U1JVbWJXZUdOcndMYk5uMHJ2eHFUN3BTc1V0UUZ3SmZobGNV?=
 =?utf-8?B?QXBkanJwM2Y2M1REQXRiSFg1R2djRTdMZGFhcmVLaWNYdTVNVUtZYVdUUlJz?=
 =?utf-8?B?Z0oxQ1FkQSsxZENDMjJTWTVha3dIMzBTM3Zjbng2Wmx6SUZjemRYSkgvenVz?=
 =?utf-8?B?Z0tOanJ5c0kvQWEwREZPM3JXUHc3V1luOEdPSW85VEhHM1FrS0QrdEpzaUha?=
 =?utf-8?B?cldPd3NNMXBBTkFiY2pSNzl2NEdzMWNPVlNqVitDcnpyVGtPeGVqL2x0cnl6?=
 =?utf-8?B?Q1hMOW05b1FTYzlJTEdSUDd2cWdqQnJLTEIyTEdnVjY3TlBvRXB5cHFINTNW?=
 =?utf-8?B?dkhIRlgyYzY3RjJybVZtbFo0bTB3NHVyNzFubVVpTnhsM09ETHdpY2NvYTBH?=
 =?utf-8?B?RFh4NGFXM0Q2dHZUZWY2R3F5RWRWMC82NDYzSktrampmUm9sWXFQNTVhSnEv?=
 =?utf-8?B?THBqR1YzWWdNSi9KOHpMZDczd1UvS3RuT0s4OXJzajUwVlFaNmVtOFNZbm1u?=
 =?utf-8?B?Y0JSL0w0UWw3eTNYQkRaZ01VaDdSMndzNU5mRVh5QjF5M2VaNVRpbmIxMjJS?=
 =?utf-8?B?YVcwdUJWeUhWNVJSNlpNRTMyUEQ3Mm03UFVxRS9lc0F3TEhMYjdRc1VxZ2VP?=
 =?utf-8?B?Z1c3T0p3S1NoY1J5bVhrT3BLdlhyNkJ0T2NIS3VxTE82b1MvQTRSMytIVEJS?=
 =?utf-8?B?UHFsNlg0UlFaaHk1eklPR2hIMkROMDVXZHNrT1UxUmtRTUNhU2xyRGRkTTVL?=
 =?utf-8?B?b0kya3lkNUxSL2pPRWlqaDUxNi9IVDhyS3g2RWRoVXV1RVVWeXZBQ29SYjJ2?=
 =?utf-8?B?UzQwV1JtcnU4NVIxUlBMblJqTDliRGRXUFJOUFY1bS95NCtHMCtIR1NFd1U3?=
 =?utf-8?B?RXpXN2FiZVA0OXcwcW9RTml3VkhXZVJiSWtBOXdQYzAzcDc4ZFJ6bzRKdU5O?=
 =?utf-8?B?UjZzcFFZMXc4NnBsT2Z0VnBEalFjaTFYVTYyQmxDUGFNckdJVzdZc1pGUFMz?=
 =?utf-8?B?bUM1aDA4LzVTUXZ6T0k2cmFicFVaaXBqemxiRXZmOG4ySi9kUHFjVGtyZ0N1?=
 =?utf-8?B?S1ZjZTZkUFdrOHd6K3I0YVFLQWswbk9tQmlKcUV4WHZYTWVaOWpLR2tmdndP?=
 =?utf-8?B?YVVxdXBNblZ5T0IyK1RkVXdhL0NvaFVOMDY4R1ljYjlWazR6V2ZLMlNHb1R0?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bb282f-034e-4a77-dbd0-08ddd479e21a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 23:43:30.7974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPJDBzwF1X+I47T6VKp1rUKbeueeABHwaURAe88ini4NxbYH98PWryHMkjRRgcEpex9dn1LRd9ay7Qg85ef4bZyEOv3UW6HiMD+exA+KNBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7573
X-OriginatorOrg: intel.com

Nicolas Bouchinet wrote:
> Hi Nikolay,
> 
> Thanks for you patch.
> 
> Quoting Kees [1], Lockdown is "about creating a bright line between
> uid-0 and ring-0".
> 
> Having a bitmap enabled Lockdown would mean that Lockdown reasons could
> be activated independently. I fear this would lead to a false sense of
> security, locking one reason alone often permits Lockdown restrictions
> bypass. i.e enforcing kernel module signature verification but not
> blocking accesses to `/dev/{k,}mem` or authorizing gkdb which can be
> used to disable the module signature enforcement.
> 
> If one wants to restrict accesses to `/dev/mem`,
> `security_locked_down(LOCKDOWN_DEV_MEM)` should be sufficient.
> 
> My understanding of your problem is that this locks too much for your
> usecase and you want to restrict reasons of Lockdown independently in
> case it has not been enabled in "integrity" mode by default ?
> 
> Can you elaborate more on the usecases for COCO ?

Nikolay already shared some of this but the succinct answer is that COCO
breaks the fundamental expectations of /dev/mem that the only
requirement to map memory is to install a page table entry for it.

For COCO an additional step is needed to decide if the memory is private
to the COCO guest VM (cVM) or shared with the host VMM. If it is private
it additionally must be "accepted" by the cVM before it can be mapped.

/dev/mem allows uncoordinated mapping attempts and at present causes
memory protection violations because the /dev/mem backend attetmps to
map it as shared, but another part of the kernel expects it is only
mapped as cVM-private.

The attempt to communicate the mapping type, control for the acceptance
status resulted in a pile of hacks, or even just add another
COCO-specific check near the existing
"security_locked_down(LOCKDOWN_DEV_MEM)" check were met with "please
just use LOCKDOWN_DEV_MEM" directly and be done.
