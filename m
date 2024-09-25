Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E0915C158;
	Wed, 25 Sep 2024 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727254561; cv=fail; b=e7FlbsVnQEwB6VvoW4u8wAXIMXB33Y86+VPQgWffgc6g2RRqlPbi01V12cbv9L7id44wPIqV5cUjIZHaOdnwxY6G6yY8vu7O0NpWtP/Qb+/QsxQzFAWCFosio+DXUI3aCrDr/ihLTXpfPumHYx48rgq/BDfCm5WlkI0QWCn/yMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727254561; c=relaxed/simple;
	bh=Rmpuoi67+JrcvDTxSEYRodTd8RgUyT4wRx8Ff9JLHrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IkFac4kusx2PorPqqb92f0NbqMSReIF5l5ixHZQ8wLtPIgQ9VGJnPOgxCNBMP02HIsmMOaNfKQl5i6zGjH0GV1JCDPUQYdT9d/9mhD4ttKkI0ASIQwsnv9S9DYKy+ToLYHvTBW9blxX/SFpTPo99RtLqMPLRkTlwQF86Mn/5wiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bC1qsiAn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QjdEYVrB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bC1qsiAn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QjdEYVrB"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48P1tbB3001047;
	Wed, 25 Sep 2024 08:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Rmpuoi67+JrcvDT
	xSEYRodTd8RgUyT4wRx8Ff9JLHrA=; b=bC1qsiAnjRp/GwzQDs8kWiq+6xryjWz
	kt8bnNmOc3cPI9Qxx737zJog6hhsYviqaw2yPGh47bwOJLL7mY5Tq502GSeSUPL3
	lPaZMoGfwVpYOTGYclWbeIyVj7hJVNkjqPDXuljy0JBIjkgtyEa3vsALDB6FUfup
	aDNWnvQ/7YCPogQuoCeanWdkOr7wRA9oXarK4ZJyElKkdHNCcRNf9+lACgvZMn6x
	aJ1Rst/M9J0nDmd6u0Q8bXBSRxEX4OT2npg7Wyr6WHXhJE/brNkQ/EdVnnhjcyg2
	kTLkCDgoyim69BsY+ntVBpgp7tr1FJkoED/jr+jpuyp4/tsVMWDKcEQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smjd77ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 08:55:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48P7aXAr026109;
	Wed, 25 Sep 2024 08:55:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smkac7da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 08:55:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPDd5tFCGamOOdG5DFXKtibxcgWkbtZbMQAACc08WGZ+1YCX4umaEKtNIGdejkMyoHAicmIBhw2d/ccR6S6MSbOEXHyjZF45Rft70wuSFGavusER6F8TqOgPR1vmU9jmWE0DIutNA8ufQP8L6ewu3DY8Ugo94tAVcq7xkTAxgp1DVwA3jPOoLJXuuFrDIKikky0aqlnyWv8zQliBHXnf1jVTyHBNY54kYtxyx0j22QIHSZ62ueblWBvhHvGrn4Nohwnj0swsJuRXvQCLuwD0GdMAICvKuJDjRqV6zvM6TfrXeedq0Ro4HbHnOUqhpPyzm2Vy/W3iC/ZVzGGzyTSSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rmpuoi67+JrcvDTxSEYRodTd8RgUyT4wRx8Ff9JLHrA=;
 b=HWk0dABux6CJPPMtgcarhsJ+fpc/l+4lZIHN43YiYbUKJx18CdR1vZGZMn7qh9EzXKPO+W7QsoY0XZkGGcMrhnr50STBbGoliFuz3b5VVRPwOyte34fCUGN1dXCop+n1bcrcgGOmHvADKEQPWTqLPtsN8RtvLJPp7t5QKJbtnKlBn34XC3NFKdE3rZzmZkhUb13dA6hbf4PNmO4Hf8iowICIcUeK5xYCQxQOx0Q51cTmoj/bMUqzT3bGZrvuJ2WJhy66Ez3Hnh5G/PgA7SIixc9ULDen1Jsv5D7m+VgsFXt7EgLJb8kP0haAuA0A7yxfOMxaDXyAJFOO+Xfeagjqkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rmpuoi67+JrcvDTxSEYRodTd8RgUyT4wRx8Ff9JLHrA=;
 b=QjdEYVrBHhv3MQ0gbU6Gpap61/fA+8Wiv0BH20VSRXqfALeZ8uv/TXzUOHk+Jc/2YQF4nvxn2FmpUSvUxTqZZktT8ziEKfXpCD+8QDSOwRORBPZCPeJ3TSrMhB/IMR91Xcc6/ngjsWM6J2lDpzsktWwHlntfd2pyjssWtJ+lRv0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CY5PR10MB6214.namprd10.prod.outlook.com (2603:10b6:930:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Wed, 25 Sep
 2024 08:55:46 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 08:55:45 +0000
Date: Wed, 25 Sep 2024 09:55:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shu Han <ebpqwerty472123@gmail.com>
Cc: akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] mm: move security_file_mmap() back into do_mmap()
Message-ID: <b124f2d4-c2fa-4285-a4f0-b07304f778fc@lucifer.local>
References: <20240925081628.408-1-ebpqwerty472123@gmail.com>
 <64882dd5-5efd-4912-ab3d-0e6ee76380cf@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64882dd5-5efd-4912-ab3d-0e6ee76380cf@lucifer.local>
X-ClientProxiedBy: LO4P265CA0297.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::6) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CY5PR10MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: 23df641a-63ec-4955-c3d5-08dcdd3fd7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cg9Wqi96gNFa7yy+JFQwTKml5GtlQhqgUvbGRBjAWLHmY3TjcMfIbO3ZRIXv?=
 =?us-ascii?Q?FHywg69DCUoOaeXVCemKE14FBe3vVBC40oy2Qk3VhFMc3nZwEz+bCtXH2LRY?=
 =?us-ascii?Q?vBhtZtQ684ZoZDEYkbKJQsWguQfRuLWdHUap7hGYzGecN7qkQf1mO4MKQSf3?=
 =?us-ascii?Q?NlW94sT1kMBgpBoRjtzKmGVT5//92uOqCqHmaAUtxFLYI54Lr6w4uDjAxcml?=
 =?us-ascii?Q?J3vgWdS5vQS67tvnkm99p3b5FDEmtYdHhNW6TwOoOV0AmCpBIdtTVN+bS4PR?=
 =?us-ascii?Q?fdAa2Mcs7t8Ovp8CptaHojc/sh57IIeKbrWP3WcqghnAQBCwg+NudT1nauZM?=
 =?us-ascii?Q?eRqdfXCBbZZa0kZOD/Mu3pMPHDYsYI6+xRpegi9eyS42pmJAgRJKLnGWcHZ1?=
 =?us-ascii?Q?rnRSmor5piek981OLSwq65zsVTqq7boNDm+bSkugG2N8iz0B9tbeXWZSUOw/?=
 =?us-ascii?Q?4NETRh/Klak8+C/1QzSU87NKpJ8zoW0t+dxL4vnrbnldUoo4853UCse1gXYW?=
 =?us-ascii?Q?QT6b+jPHuIo7DLW/VS8n2iRXyFN7LckFrRZ9+ceLx9PDi+jv/ETHpYkH1hY4?=
 =?us-ascii?Q?xejAYT1ZPEtfKD5fJZjBooSWu8EMJx5d4BiphVEKV0QLeq7VVQlYl26zONRD?=
 =?us-ascii?Q?0S3w1Y+Lne3KNpZ58h7hmqQiAUkdyYMYumZhuqjPh8D6kydJxkOAIHB3nJF7?=
 =?us-ascii?Q?yGFAjXQT2BAS7SM6gR5cUSIZotEMvy2GEfIXAidNrtAZdzKOtYzkSNMz375d?=
 =?us-ascii?Q?N09ub3bssU0vpm1RIN/EPrXWcLsx/5LOAke994yR3xy19rzCX/FvQ/lGe/WH?=
 =?us-ascii?Q?Dlw+ffL7hnA7jP2G+NXmwwTGju1ygpibMxkwUhOKxyQ0KKEX3SGZUgklTeMX?=
 =?us-ascii?Q?3LwUnso/BRDqcw6y4zA9coHSvkjyhFvr58h1ZYJAHhDWb2S2Xe2o0HYdrGzC?=
 =?us-ascii?Q?yalMPCeRVTMZXFevA5sG09kpQclberzgNzC2SuNDvt4HGUJDfN/1oO7L+tmt?=
 =?us-ascii?Q?KUuJyXm49l3Hxi88niJeqDJqiGbZ6gpno0rdw+KbBC/yVj7Z+NoG9KhItNq4?=
 =?us-ascii?Q?82uNlLdDbYz7ZfnQGoWXsEeo04cqXZcV81cXimifDKX9l4AC49l2aYLCZvuD?=
 =?us-ascii?Q?pFk6ayoqXraJXP9l8t6IQzdWykTbuKneBv/B4AYQoW76uoLoQWEZlmlvBZQl?=
 =?us-ascii?Q?C5LFkyFL/hGblI0792PuzxDdz9705HINbKMeK9qJIJdaUgf2FmRtkEW/9H8z?=
 =?us-ascii?Q?I2uebI8AKnxNuCfsPGxOqYq2/K1AgPli2jRqKOSH+Em7PxA7JXpYsYBSU041?=
 =?us-ascii?Q?TjZcSp/wDqia1jsv5Cwm+7y/90zYRFHezPBfTNd3KnQzVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?icHbKH/6Degmrn/B4NFmhFQNLY2ivftJt4RwuvFKHBfu5KkLvAeOalNYtGp0?=
 =?us-ascii?Q?gfO0jsKNnfzsRTkWoMfP42P75fVTvYKVubaNd9HFjEpTnf4wHfuHm1R+x+o+?=
 =?us-ascii?Q?ccUYRZTPZOIB3FAhbQDbw191ifVVKnlmEvBQjZxDsZpjgT+fR9ifdQBaoCd3?=
 =?us-ascii?Q?m21Q5N929f/I6L0+rif5UOpUpbF/IP2vJSZ4+MA7eIoR8ncna+Cw0jLoFgTs?=
 =?us-ascii?Q?c9+hntnzycOxY2JcQv48WzWViWzryq6vuGcVR+5HSQHnUptZ+iFORc8JogCn?=
 =?us-ascii?Q?9N9dhWrD7//2N8vq69Mu7x5Kgny17ioEOQ85zJob9dDcEpsZQElG9kKnL/Du?=
 =?us-ascii?Q?u1SBvh55OGRMGvsRYWtk6PDD4JjYT59bojdvqYP+W0DOjjMb3SzY9RAcd5C8?=
 =?us-ascii?Q?6QXNh4awPcMU55gfuDTpKU06elpaip8ox0vCqwPodHfuGocm6qjHy1AN58HI?=
 =?us-ascii?Q?MurifrFIdmtw7Tc5Kz6oZ3SWIwJdYNYUVqxASPnLVKVQdKhi2gIGUuz2UoZn?=
 =?us-ascii?Q?3C2gTr862iudtE6bxI7Dz913k/hftQ7yTGEsedx9bdq1sYCB3rx2Un5rgarY?=
 =?us-ascii?Q?8bmJluojjpD7zy8o8YG3riTbH1ljIo9qmxeKLduqcg0ibZF9WJJ5O9SoHFgB?=
 =?us-ascii?Q?FbHUsx3ivcT5u+G8Pcv7TWVj8YdvbLUvHykPSz4cVm8xeeLGhT1Ut5K5BGfg?=
 =?us-ascii?Q?bH6YzVVOwy99n617gXxFNVSIYxPoUV3K1kPkOygffvq1JsX5+2a8usD5NVpu?=
 =?us-ascii?Q?gyD+59thZs+jryHTYbE6XTVL6m+Sea47irlgpDw4xQ2NEbIoyJULOjCNXNwX?=
 =?us-ascii?Q?yW+kpKb5sZut8J8qtYRJHlqEVshIo/+ow6IntfW3gXf4TY4e/t9jfurLeNUm?=
 =?us-ascii?Q?SXVdHt8BW95ryflZgRTaHRAZqXbT5eC3wqnuzxxu3W+5zWY76+mHXmuV5ZqF?=
 =?us-ascii?Q?nJatvBks3Vq2VdZ9aNfnfQ+OSEgUdV+jACa8X5QuJcoveiSQK/N2JHpifm7s?=
 =?us-ascii?Q?/2S0gyUkmpzMQQoGhy8Lf7pOpJ5o59nGprin6om6ouMaKw9qYz5zKhHPN0Zi?=
 =?us-ascii?Q?YXl/kPNqRscy+/oTrEoEx1t30qTZO/tZ94uPZ95Sa61ftl+qwplIBHNihDyw?=
 =?us-ascii?Q?JeITZ6Yj2s3DgW4Ob1rC5hfZhzk+73GhhbsImSPWdSoOUfG9Aj4NojJ9f7gQ?=
 =?us-ascii?Q?LohkYq0M8fsM4+ieCM6z/KApY5PHN1DIAmbjR83UW3rnYJbudWRg99pCKbhZ?=
 =?us-ascii?Q?TKNu7GTiBExQR9n0XRSPgnLV6SRLVD5Zw151/KfT7CZEnzlSrLj6FVSQ3jJy?=
 =?us-ascii?Q?ja/TvA40O8y4zsckRoRFTvcAVQrybJn04TSAfQqBINmuZNICn/njJfMmObT3?=
 =?us-ascii?Q?GEdZra9xgQ29KHiPAwqnBOwntCW6czpyvHmDP2BsdIzszZZfrLy8oWJiGn36?=
 =?us-ascii?Q?2XpzvB3NnmfviwLWej4BpJuh5enejCs1q6rIjGC4rfoNGNwyOdDjujYXKDhw?=
 =?us-ascii?Q?jKIgAS1UchCVll/uMWl2Viy2ga+yJW9bWNtAnaPUsEiowSKsdu11selEDagn?=
 =?us-ascii?Q?mrCqfmlwtjqTuzfFTNGRFnBN98nVWAwnnz0Seab4XB1S0QiR7DrQwIweyfin?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d0mV/VpMn/5qQOzZRGgVhznZ/E4047+sLGJTzlSn0qZY4L5TACr4n/446+PIgtkV5pjRzh8wzzYr0plAcCGr0MYCZgkf44Ls9ZyuD3pS7hhf5KReAJvY9ql6Hxc2KGeBb0/isDrOkQ8z37P7Givqu0aH62/JdE+pu51/Jiwu9uPc8SoyGNLqkMgXfJ6pf86D/N4/kwRC6Xhh3TnNExdWA2Z420bbVcYvaoGDVMFKchcRFMCUWpe6c74UuPrZ/swCKqhTMAylrWPeFZHxrXaKT2sLi1ZUGA6W9wzX7GKPc2G5jEjoPSTBXVuQfjILstkvlqQB7JIKIzUSJPqQljO4OhzXOlp+gXfsmiFXKxWTQTCcs+XjXOTO2f3M2/leif/sHcli0WVCJ5LZQxEU47abBHa3V/sn4H2XDnCastca1IOhOAQIysWo+HNuyw5kHoynOoxMt1yQMTwxz4u6710Jx6+tjLFqtXt0+tv245NoK0saq3aaf7GhzqqdGG0VSwerQEdAmZrV7hMbLskEO/+IJnyi5vpDT6WoK4ZZ/EH6A7J/LNporMLX3f4HuUvw1ywbaQWfoA5U0bvlJ1HVmVVTslcxScNsD3a9X8qqwzpputE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23df641a-63ec-4955-c3d5-08dcdd3fd7ee
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 08:55:45.6010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FIh7zgiKkf991s/X9G8TQi2F4qoi1X88O5o4Pgqs/RS5Z6ek2xBvPEpjXyF/G3lWtoTKuu/jHdR4nQf8Dj/pWSXQwPf67ghcwg3gFB4IUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-25_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=818
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409250064
X-Proofpoint-ORIG-GUID: H8psoZhEZPv2kNX4w2UOERPPnmlbl5Y-
X-Proofpoint-GUID: H8psoZhEZPv2kNX4w2UOERPPnmlbl5Y-

On Wed, Sep 25, 2024 at 09:44:40AM GMT, Lorenzo Stoakes wrote:
> TL;DR: NACK because you sent two conflicting non-RFC patches as
> 'alternatives', which is not how development on-list works. Please resend
> maybe one of these as an RFC...

[snip]

> On Wed, Sep 25, 2024 at 04:16:28PM GMT, Shu Han wrote:
> > This patch moves the security_file_mmap() back into do_mmap(), which
> > revert the commit 8b3ec6814c83d76b85bd13badc48552836c24839
> > ("take security_mmap_file() outside of ->mmap_sem"). Below is the reason.
>

[snip]

Having said all the previous stuff - do_mmap() and mmap_region() very badly
need at the very least comments to explain how the interfaces differ and
what is provided (including in security terms).

Perhaps we need to go a bit further and audit how exactly they're used.

I'll add that to my TODO list!
