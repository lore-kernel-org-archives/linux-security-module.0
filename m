Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013052.outbound.protection.outlook.com [52.101.127.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A223F1E7C34;
	Fri, 15 Aug 2025 03:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755229209; cv=fail; b=QE6YEDGVPX0TKniP8nTq2qWCseRfangPtxt0ZQATroCQFJn3b9u0yrBpMhBeBdn/OnZ07wTHaqm+V8gY6D9hbmp1iLTn75FBLpS7fZLWX09A+6+0NCfkR6yX4DRQMwszz1g/VZDEy2YCEV1URFLUyoszNPOIQNU3j8TQFwVpCDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755229209; c=relaxed/simple;
	bh=ijTguShJ1i2qjNAv/cMiCMG782WoL1zUAdwOJQzhk98=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oQ2buGBpfMU2bG5D99TtwZCiGO/ncexE7gahJXBO7BF+QYlwbosof5HJn4DGZeIZQ08l7DkBWgRjFVZ5PyKGN/xqFNhyqEMC+ddRZHZPkG8Gd0ht9DmMi+riNQ4Dbm1GeoDiz3fMiTWUQW4Z2fSrpBu3pnqQpgYKFMx+rb+5nxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Z4W9ZWX/; arc=fail smtp.client-ip=52.101.127.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Z4W9ZWX/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmTftzaa3rv1A5B0D3hS2Xg0a27rrecmFNA1NpbgWQSZv3Sr+zffsjewjBAMmqoMw21Jglpj7xOk2/updQhQHJktuMMuEQH5TTG0jqd6l5mPo5oCPvcJR5aZMJOpqaC9q04DusmLhLLsfig4XmJtTunAo9uaRbsSwe+SGukUpNPktCYqi+7sWhf7fe4AYybX5+pHfWuJV5vQ/Fw35ZybGT2961VtRSqfs+2G+Cfln49zbfPt5iO2v1ag5DXEqndIeEhvu+gmEIZO5CiihA93b5DcA//HGdmDBFUg/IhkX8DFErsysac4uC9QMLBnZwhZUSwvIb5LrhPxcyqjvInrwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTvCHRa6NoYi0398gNXVbP1rv7qa8EndzhCFjIf61gI=;
 b=GOoH130KsQXezg+foj4Ly/Lq3+4yGP2PgMUruCwznzZRpgR43j0RfMA5l6Pu9y4pmrgwm8OSNtpcGhBdCq/LA+4HzwMjoLJeQfwn9yckcFMPU4aVyKT7p+CNfNkaL7aTJNR4iZ99XrunN9KwwFVqLY3wPmbkEDwN+ghD1fDsf/l1f+FZwx0lFJOqVHYSzUgCtcf3qjN1kt0ARKLw5F8S5dS+yX6MbOQbEbwhejRYZKqQtc7OIBFe1SV9L3xpmq9tm7EyLAzKapX5KilFgQI249kdtNkKfa5xsNn3bn6FDgm45iKGzrEbKEIcLKaNazO6YsUO12XpZiMtrjTR8W86wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTvCHRa6NoYi0398gNXVbP1rv7qa8EndzhCFjIf61gI=;
 b=Z4W9ZWX/QDRLouZmEaEtNgCYH8K5Lpt3Or4kSmmMK3RBXxath+ndFF9PuIVadr09oX/AdvYQNW+9N3/1mwJEuS63zOpNGouMD7YZOIw7Vv4hLTppZNSaPT1ewO/06fY6j+SRl3v5dZ3cSKmkBxOa/0ZLbZZUaup3iZ7oBWsTjIFR0/vuVqPFzeNAFeIbt+SvVWXOZBLsxb9f1RbpbBQcDIFOu5DTPvz2q2KNKUi9mb+cgvi1JjUSpPgTA+Pzg5plm7xDot/6UuFEG4EhUzI1erHNtMr8YaC+nJD2rH1RdtrxXuXGpihdBA9JkN6JDGNlJ2crJ+0o83K6+ZNJptpIYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 OSQPR06MB7991.apcprd06.prod.outlook.com (2603:1096:604:426::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 03:40:03 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 03:40:03 +0000
Message-ID: <1ef37cd9-9aa8-4276-9b5e-f9094effbc7d@vivo.com>
Date: Fri, 15 Aug 2025 11:39:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] security: min_addr: use max() to improve code
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250814142653.283355-1-rongqianfeng@vivo.com>
 <8ab2084cc35ddc9f2a4796ff7cd88954@paul-moore.com>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <8ab2084cc35ddc9f2a4796ff7cd88954@paul-moore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|OSQPR06MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 60bbd7ff-278c-4e53-a743-08dddbad6b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWI4dENTRFZiL01HNUZNeTBTVVJBSlJuUHZHdGRZWTVmRXJsZFFQY2pSamsv?=
 =?utf-8?B?RVFSY3ZzL0dCdFU1K0hQaklTVUZKSVNNVkFlaEY0OGd0R1FXQXZXRDYrSVdL?=
 =?utf-8?B?NWNlY25aTENkS1ZkOW0wSXAybm8wd2loVG10Z2RHMDZvdVZUSFNiUWdJeloz?=
 =?utf-8?B?b0swZ2hLbTE1WnJ3bHY1MFV6blI4SnM4b2VYYjJsbDExQXlPRUV5NG1BSERw?=
 =?utf-8?B?Z0ZINWVmK3gySDkrTFM3VTcrektPcU03enB4VFFZbDIvaDRGd0VvZ3MxSHg4?=
 =?utf-8?B?cGdrQnNPV0h6ejRwcGFzU1lNd1R1RTM1TEFvdWRHRjhxYVB5Qk1BV2o2bnc3?=
 =?utf-8?B?QnlqbldvVHVWRE1TS3BZY1Zuc25MazRyTW54QVlvdERkSGF3OFBEUDU2NE40?=
 =?utf-8?B?ekpXZitZRWZHVFVjamE5UEdZR1QyTzVUZitvQmJOSmlHVnZqMklXQnMrd28v?=
 =?utf-8?B?NzdhdlQ0aDBkU0xnMUdVczVNMW5EK3pWd3pmNFlFMmVHR0JmYXNqK09nc2pr?=
 =?utf-8?B?Ymd6OEtNM2llanVwQzN6a1IxbmRMNllCOFBETUlES2VWRjduQmlTcmxlNElR?=
 =?utf-8?B?b1BvT0Y1aTd5RGVkY0R2NTBVTVNpVlJvdFNvN0MwUGJkOU40Y3JYUTdJSjhV?=
 =?utf-8?B?NFdYTGNYaHcrdjIwLzk1d21XTlg3KzZORXdldHFPcXVXVG0yRVVnSExmL2hP?=
 =?utf-8?B?bmNwVHMwc0dVSUNKbzkvY3pUcFVsaGNqOWFVa3RmcDRnWmlPRnVITmRlV041?=
 =?utf-8?B?akZxVjR5Y2NsVkxKNW1YdVRyNU1VNEJkRlQ2dHIwbCtFWnNVUlZEcEJXeVNq?=
 =?utf-8?B?VWlZbnV4NTJrbGlCK3JLQkFyQndIaGltb3g4RkNNOXVUMnUwR0Y4aTQ3UHZk?=
 =?utf-8?B?ek96am4valFzTDNTQVZZTTJvb2RYTmxSWWNrVU5FakRxYmVSNnFLUlZEOWY3?=
 =?utf-8?B?OGUveEVFY05aTGRnVnR0QkNIbkErcTgzL1hucE9XYmtwMktkUlRwT0hYMTBY?=
 =?utf-8?B?QVNlOFhybkZmd0dxa0VMZ3hjYklpNTU3QzhGSDZCUkgrdjNjRjZhV2I5RXlq?=
 =?utf-8?B?dTBwZ2FvWENhdVBtRFBoakNXWlU0M2x5ZWhMNFhvN0xCR0w3NG4xbk4xTy9t?=
 =?utf-8?B?RWw5eWxNYTVDMFZxK3BhS2ExbGhwc3E2bTRNeU14alU3MjJ5L2s4L1JaeHpo?=
 =?utf-8?B?Y1JUTGs3MEpCZE9NbnVyVEkvQ0Y1ZHJiYkN6RGFRRHlISUIxdkdqNkZjazNn?=
 =?utf-8?B?T05MUUlMNFlqdVg3SGhCd01ydWh6WXc3MHNlRHAxc0xubnZTZ3llbnlxZ1Y1?=
 =?utf-8?B?Sk1BWkg1OWprSGY1T2l1Mzl1K3VQTlhiSnM5TTU2ZW9xeTdaV21WUFh0NjdD?=
 =?utf-8?B?em1kYnFFbHlFdnZvZktzKzJIYklrVjFuWVc4SjlqNGJPT0F0NTBWUnh3czFz?=
 =?utf-8?B?c09jM2RVOXRSTnhwNWdsNE5YSkJuUVFsZEZmNHNyYnpRU2h2WlFYN3R4L1N2?=
 =?utf-8?B?S3Q2NzZoaGtlUjh0dmpEYjZZQ21VajBLNDUrUU1WeitwNlFWOTlGdEI4TUVW?=
 =?utf-8?B?b3RTQ3prdnpUbWd0QzZIczhqNDdJQy96Yk1GL1B3Yk1xRVdyMUNCMUxmd0NW?=
 =?utf-8?B?eDJtUk9ySS8xUllZRUZOQkoxbkExcDlZNHVWQVZUOStyUkFwbzA4Tjg2VlpU?=
 =?utf-8?B?MmVBZWhiTFd3MFdDdGUvRUYwWnA0WmdCaVFIK0xiRFhaSFB2aThvbFAzbGpR?=
 =?utf-8?B?Vy9uSjFlM3RkMk1KbjR2cndZSTRyTWlRZW8xQ0JzdllGK0c5bGI3VkN0TFUz?=
 =?utf-8?B?ckNuNXBDMnowTTRENk5Vd1VLSVdCMmo5U29aaVJ4Ymw4d01QOFdoUVdsUmx4?=
 =?utf-8?B?eklTTHl4UjZOb3FqcWk5Q2p2R0ZiMXAzZkFGdW1lNGhPRTNDNFpxcithWkdK?=
 =?utf-8?Q?yV0mX+yaPk0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWRQT0hmQjFiUnJ3SkkwUGtaU2NtcGJib0pHbHJMM0NVQWJSdHh3M2lFeWdK?=
 =?utf-8?B?a05ZRExtSUs3MWtaZk1nM2RZRFpoQWFqcmd6WjdIOHVSbDRZZXE2MDZSN1F1?=
 =?utf-8?B?Y3hqa1dKSFdoUkNpQUxZK2o4OG1ucnc1VDZVZVpFSDU3cWJqRmkyN0tkZ015?=
 =?utf-8?B?aWxMVFd2K2ZPNzJrUnZvM3JhVUFMWWozVC9CZUtuSzMwbnJET1E3MzBBcGt2?=
 =?utf-8?B?TGlhUFJ2S0c4RjQzL0U1VGR5YlMxVWtQNXM3OS9YZ1hqdjlkdzg2cXNLcFl1?=
 =?utf-8?B?NkVQZ1V5MENmQnFpb1M0NFh2QkM4ellrTStWSXVmVHpRazRObjZFN3poZTBN?=
 =?utf-8?B?ZFFjTzI3NnoxM3lpYjc1aityT1B3Nmg4S1hFUE13UWhITkM1UlBCRjkvNVp5?=
 =?utf-8?B?eEVYTmpWeTBDaHpuN3BRUXdNaGZ1UkZFc3NXVmdQb2JLS2I1VEwvY0pJejNB?=
 =?utf-8?B?ckJEQTg1ZTlaVnR3ZVQyQkJibzFBY1o3ZndNR244bVBwbzE4MzJQRzFoaEl4?=
 =?utf-8?B?cjQ1VjByWVoycVA2UUZ3VktDRXhRYUFRRjVjUHpKRG9nQWdIdGk5V2pQY3kr?=
 =?utf-8?B?K2RHM0VnZmpQU28wK254QnR4QjQ4Z2I4eXNkK3VEWVhtbFgvYTNGMGtMT04v?=
 =?utf-8?B?Nk5ja1NveFVvQUxtWVFjRDNmTDNZVS91Z2FiaVZvRUx2NHVmUk43UDg0ZEcw?=
 =?utf-8?B?aStzNGZzaGs4dnU1VTZCVHkrWEtoZDRUWlgyS2xUNUZ4Z0dwbWcraXR2WGRi?=
 =?utf-8?B?ZkpIOHExOHdmTjJqV3JDNWFleVRMa0tQNkFmNkk2M0h3RTRHenpMLzdYeEw3?=
 =?utf-8?B?MjRGblNxUGZEUVdteXZjbERSRVFydkdrMitzc0ZuTnFwTWx6Vzg2N0wyNld2?=
 =?utf-8?B?Z0x0M1ZIL1doL0QvQkExTWJGYndJU3VTVnlEU2lmL1NQcy9sSXBsOGQrM25L?=
 =?utf-8?B?SkFRMTJHN2Fzb0k1LzFZdjh2SHZORlYweVhNYXk0elVUcS9URzJlVlV1Mk4y?=
 =?utf-8?B?WDIzYzNFaHlJNlNDYVBHekorSE1UQ1Vwc0puY2VEdmwrcnMwS1dDQ21OTytX?=
 =?utf-8?B?RmFQQ3piR2x6eUFZc1Y1YS9hUVU0b2tCNDI1YjVBcjBnTEFGRXE2aWZiSTVm?=
 =?utf-8?B?RzdBaHBsV0hNTW54VERiNE55dk1IRU5YQytSa05QUmIvSmZDYUd0Y29CRGxT?=
 =?utf-8?B?OHk0TmtCK2ZkYnZOMUF6TEp3bi9BelB2SUE5TGJvd3VDOFEwamM2dUxxOHpW?=
 =?utf-8?B?ZzZaaWk5ZG83Vlg4cWFDMDBPYWtXK0VSQnFtN1AwSlZTRlpZaHF4UFhuTEpv?=
 =?utf-8?B?UGxrTTQ2U0dHVGdDVVhPYzBGL21GVlpzc0hCbm5HYTAyTmhOTTJEYmkrajZB?=
 =?utf-8?B?UmF0VjE4b3BJVmlzNkhIcUtkb3p3aFNzRHorSGhsQUI4bFZaWGpRQzJmcVE4?=
 =?utf-8?B?YjZ1UFNVL1gvNWFuK0hXRDcvNWpCSjB6S0duRnUzLy9pNTFERjFla2YzMjZP?=
 =?utf-8?B?Y1RySkhrTkFDRnE4L0xhRnpkOGJtekVYVzM5Ui9WaE9Cdk1NcGh1cVpNZ1V2?=
 =?utf-8?B?RjJLZzJ5SkU0eVo2YjRvSGY1RVZ3S1pyLzhNMFVEeW5jdk1oNFoyVEx6ZFgv?=
 =?utf-8?B?Z2dlYVFlVjJ2N0pqeEcyMU5GVlhwRGhDMWc0TjFBZDJWTDhzc1ZWSDdYU1BH?=
 =?utf-8?B?Z0dxYmFnZHVkVDR5N2N0R0NKbit0WW5MTTdBSHRZdHgwSFpoeFFTd01qTFpU?=
 =?utf-8?B?R0hPM3NjRnhhdkhrd3dHL1BLRFBsN0Q4dUdhRURmeVZ1OUc3N2JJV0w3N1cr?=
 =?utf-8?B?Y2xBdTUzQmVHanA4UGQvdkRpQkdubDF3R1RwU2JPNUhZQ2N2Q3UxUWFJUnR2?=
 =?utf-8?B?eDFMQUJhNlJIdjZ0OFRMbjc5c2FFOWFvOHlKRHM0ekpjQTBzVnBDZFVOcjJn?=
 =?utf-8?B?UWNNM09MeUJKVmxXOVNlZUUxT3lwTGtqalJ4TnE5RXZxOGR5VWZ4SkZOWi9m?=
 =?utf-8?B?RHpGNWthTVFSVlErdEVlYWlGR0ZJYlVmaFRCS1M1L2I1eDBOUEZPdlhYUkhP?=
 =?utf-8?B?REF5eFVzUjdPWHo1Q3FueGlDRnpCeWxkbUppdXZnSjRaWm1lV1VST3JKelhh?=
 =?utf-8?Q?pw3NJvpZrJEDqIyrwdnOBeV/c?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bbd7ff-278c-4e53-a743-08dddbad6b58
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:40:03.5345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quB7+co+a73rGTFOJpTbF6JhAWxvQc52mbcTuwv5RRhB8DV7S7mbLKA8yKeGZj6dtxu93jgkH454k+tdzBs70g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7991


在 2025/8/15 10:17, Paul Moore 写道:
> On Aug 14, 2025 Qianfeng Rong <rongqianfeng@vivo.com> wrote:
>> Use max() to reduce the code in update_mmap_min_addr() and improve its
>> readability.
>>
>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>> ---
>>   security/min_addr.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/security/min_addr.c b/security/min_addr.c
>> index df1bc643d886..50035bc9281c 100644
>> --- a/security/min_addr.c
>> +++ b/security/min_addr.c
>> @@ -16,10 +16,7 @@ unsigned long dac_mmap_min_addr = CONFIG_DEFAULT_MMAP_MIN_ADDR;
>>   static void update_mmap_min_addr(void)
>>   {
>>   #ifdef CONFIG_LSM_MMAP_MIN_ADDR
>> -	if (dac_mmap_min_addr > CONFIG_LSM_MMAP_MIN_ADDR)
>> -		mmap_min_addr = dac_mmap_min_addr;
>> -	else
>> -		mmap_min_addr = CONFIG_LSM_MMAP_MIN_ADDR;
>> +	mmap_min_addr = max(dac_mmap_min_addr, CONFIG_LSM_MMAP_MIN_ADDR);
> It seems like the umax() macro would be a better choice here, yes?


You are right, using umax() here makes the semantics clearer.

>
> It might also be a good idea to explicitly include the
> include/linux/minmax.h header in this file.


ok, Will do in the next version.

>
>>   #else
>>   	mmap_min_addr = dac_mmap_min_addr;
>>   #endif
>> -- 
>> 2.34.1
> --
> paul-moore.com
Best regards,
Qianfeng
