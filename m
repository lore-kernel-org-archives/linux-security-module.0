Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FDF6F2F2;
	Wed, 25 Sep 2024 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727257841; cv=fail; b=Zxv+nFOO4cC+6VAoEYQNsQsLw4Cm7HdmfJFvPJFpEpZjzDRU3hF71kitetJBt9JG+VMlPer1IDpsZpiGseUaXjgk3jgZQW3YUUZ6tx3s7+Nnu96an/zYgK4oFykgLq+ut+Eu3ElQ5I3gv4TFAwCiwJOEotvUfwIXQlQLjw0v5UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727257841; c=relaxed/simple;
	bh=qw8jHEshDnn9MwHzU+Zcd/mZtKvwRF4XkLd4ulLddXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xf2oqceeE/F8JjXNDfEs2dVxJqa5NaQoowOaonIFbNZWfVK1SBkpvJVhvFISxEdsEmkFhusD6yOF3RgnXCWP06yhCaxUAkEhDgNrPRVz4auksZ5DnncjJ9Ux2APfGNvqPcMwFeipNBdIHsL+UYys0pcSUpi9YKJFKYOvwM4q3kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SYgS6TOi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=scQeTVCT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SYgS6TOi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="scQeTVCT"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48P1tlQw000489;
	Wed, 25 Sep 2024 09:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=aI24sXQvphfxm0l
	Uvw4xPnwUZJ1+sDkeQtis53ZkHsg=; b=SYgS6TOiE9KHklKS1cWBUm3i1BwDO83
	YWZ4VrwlSYyvfeU3fGl4fLMWxzcadw4w7R/ww/ipRR5PaZz4nT35MzCwrjOLXwSt
	2CdZ2wAo1kFbrU0xam+a8IFKsyc9vCc7f7yjmqCFvMxtUzkh0HKiHnp6ua0Fl/YS
	ZaossE+8UcFUJ5PoMWxz96lkVV3ZXplb9n8lUL/YcbaTgu+5yfCdQqfjgIYtX4fE
	svcR9Qs4oWU7Vk0k0qupOcSAx9IlSTF6jTaobwbUFwQb36vvNRByPYyRDt9Hu35/
	kyCc8/nMqmV+KbAsesFt6hLEicwHGk6phiygLpPoWJhN1IETZRt4A4Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41snrt7amt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 09:50:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48P9mXgE025223;
	Wed, 25 Sep 2024 09:50:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkafrf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 09:50:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhR2vS+H3wvEp2wsKVVwM4sO00RFkfk6lT90c7sj6IU3ZLAIJrukukvVi0YbblBwHOwiPtFaodAxoq5+/YVftIlg4WX6FOHfUpKkSP3hl7ihhGvp6TgEd0DAf/k5wZgnHjE101aS+eR75zsSOkqsM+7J/ENYP8dDTOPuMrqgzikZmwHx34Kbr81t0W83WDrY43QfELU286z7/qXKaa0NJsO1WOaAqcx1iIMq2flb2LMuqr5dR51hC2YlVkTDzOxia0dMazCaRObCuEYV2zM6oib6Tls+p/snMSpIIPDe8GUc4k/buyKb970bLpSrITT8V3LmOVMg+c4DhjphX0/8Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aI24sXQvphfxm0lUvw4xPnwUZJ1+sDkeQtis53ZkHsg=;
 b=I9lidPPht/2kMKbT5VSi2LgvBuPqcOW0zng4oP/tt2KLJ82VRswaN1n0Q+L3KQND8Jxcqyg8ICcX6WzPYTtBl2OCC1E1j+zUIhhT8A5L1uNucA6rCRrgcA7yWkXhpmiAvESopSO9uI5a45IATxeDX3ioh23ev2u0c55H48kIDeuwKz+n6IOQ2yEVkBUv1E1qV+7wo8P1OiejmvpET8XhL8/KvmfMgQIcUWMiKg6lwFLH9V/JGBI1F+H2koOFVPqiRUpsYnjkHvFVM/ANpG0d62e0BlPYn6dnqMY4zCobDtWxjzO+pf5zM0fgKdD9nDadV2dagOvbQzK2fVI8tdEZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aI24sXQvphfxm0lUvw4xPnwUZJ1+sDkeQtis53ZkHsg=;
 b=scQeTVCTe4BulVgpn0jhuK4ofrv193uGxTRz4EDPlDQZwa0/AZuPSPtbt8CfQEGi4NIgBXaTRW7vuOFHz6GIcO2+/XFFi3lhPIR8BfF3g31+SYhkb5b72HHKwf9EbtU/sc0k1LJrhqI1ckxrpgKZPJtPRM37z/0okmoA0vsZWpY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BN0PR10MB4838.namprd10.prod.outlook.com (2603:10b6:408:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Wed, 25 Sep
 2024 09:50:24 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 09:50:24 +0000
Date: Wed, 25 Sep 2024 10:50:21 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shu Han <ebpqwerty472123@gmail.com>
Cc: akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] mm: move the check of READ_IMPLIES_EXEC out of do_mmap()
Message-ID: <78a854db-e8ea-475c-950d-2d9faf72f2b4@lucifer.local>
References: <20240925063034.169-1-ebpqwerty472123@gmail.com>
 <72050879-4546-4bc7-9983-79ad437594d4@lucifer.local>
 <CAHQche8ijvNfKHBLV8BWWq85rjKQbjO+0w2s6kj4V3OpBANcuA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQche8ijvNfKHBLV8BWWq85rjKQbjO+0w2s6kj4V3OpBANcuA@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0044.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::13) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BN0PR10MB4838:EE_
X-MS-Office365-Filtering-Correlation-Id: 90d15905-d410-4281-0d58-08dcdd477a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KZGD5Hm30JZQq5fcPVX+yVR1hIxoGKapFmDKiO68GrunS9WsvLeRJH2rAcv8?=
 =?us-ascii?Q?yzYVe7Kie1YXJ2LFkzlrzI4VzCumwPYXdPS5qyYOjItdWOxw9l58DoHvFsCM?=
 =?us-ascii?Q?jh6AH+GrfhtPUfze2YRiKW+j3TEb7JVC6hogeMtKmJQQAWZfbQIp1wUEHxOr?=
 =?us-ascii?Q?jVKMdyn8rWXaMTt1OK2TTYs5comOp+Fn01ZcdxJRgle7ZKSvTxYAzeSYchQK?=
 =?us-ascii?Q?dWJ2Dh+RBOiwvXo48XLaHzU/lMMXTx90TbiD56ofob79SA0ryWWzEFih4ZfG?=
 =?us-ascii?Q?GfMGhRA2jXi58Hpxcphzt5Ng13flrEYYfjovrK0blykH2u7e9K+AR4S8Ajb/?=
 =?us-ascii?Q?6PkG9VwhhRCnyeQCSf5Pp9/eaWRBQ1zGfmDnHT/XFwM6qlZiErHFc1b9JrBH?=
 =?us-ascii?Q?Y0ReGNd2+V9+xRlnJC6Akqx3078Ql43TsnLebYbR+zjsS+l9ees8RGDjHUqp?=
 =?us-ascii?Q?ICH25ZXqNFbTkLim3+w0e8rhFLtIK1Bj0oY+FvdASV/6250+BAO8zxMnOqfC?=
 =?us-ascii?Q?QPe6mGtoIqT4cAZ0NJIgbPz7hu1BYyk9cIpH5dRWeid76DeGxtIMpzivQvEV?=
 =?us-ascii?Q?Z0f07zjxDUe/AXGevfqEvyKV1+6oYA/bVQMMYIRAXh8BqefoNaOFrT9K+3CL?=
 =?us-ascii?Q?OIZx5Ti3iMVIrHTYv+029NNvoUYRMA0EuqSrjKyQA9yYhnCK2ZkThZQBGmUK?=
 =?us-ascii?Q?hnfQ6JKD45MnTotN4gQ670ivkX2OdJJKTKs20FHJ9hSWhC+cb92nIFKibP8A?=
 =?us-ascii?Q?l2ZtovU3kAvrxnnfXXHR1CTwMSoGWb45wKhmdpGrtwEkvqUhsUyZCojcln7Y?=
 =?us-ascii?Q?AiRdT0a7bH/JnU8vsuBjzbXsSxMeTe7EXSWOloWcYsZHBcPHmTGA0jAvvMgW?=
 =?us-ascii?Q?xaf94RvcSxR0ADPeMhgc7YYF2QyujASx5vmt3udJVYSsi0GOEp1GOr0hFmAX?=
 =?us-ascii?Q?63elkIJcqGQJEXJ2iqnqI2zTd9YKCw6GEFW65n3Tw7rsp01bWKtJtbv0Dl1G?=
 =?us-ascii?Q?kAn2+ccyxG8794pknr7zZJr1VRCUbtVNSKt+dr/kn04FK7GJXsvYcQzTmj1W?=
 =?us-ascii?Q?YHbmprS2a80DDemT6TM7aH7uD82cYy+YKidR3Z4LCA7HLeMIbkrmUjHlEQRf?=
 =?us-ascii?Q?XOknG8mUCXfoF6Yq678HW+3uPCaImouMoxzl7a1g/aXA7TbDqZTbxem95kCF?=
 =?us-ascii?Q?DoPeaUSK3wO2Mrb2vGZZV8JUPTKRip3/G/N4sryzB6SDcpsYLH/SOv2OY+EQ?=
 =?us-ascii?Q?l1If/oG+IKABEVoCgTmn2FiyVpHMl41BdBz/IMSrjUTH4AJyRVC1+EgT0y37?=
 =?us-ascii?Q?crs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hVxB9unck0SMynUCx+S8deUtCEI/l1NwynwYu2Yqb/fMdWql4dTsApCvOWM+?=
 =?us-ascii?Q?4tW6a3919JkyxH7kbG7h0hL0OESZbIXsqg4bqPzv/PIs6fmtf3uLEY2I7HVZ?=
 =?us-ascii?Q?sQopDo4C4/A8lFQsFGVjDknx4l9Jw6pG7XJbTPnr0v74v2N2lRq/DdaRwve8?=
 =?us-ascii?Q?ywAefsJukd/icVmBQtDxRaMzA4pI7Q7d60DYJMeHQ7SyNhqSDRnvqBNaEL0O?=
 =?us-ascii?Q?qs3Tndbq4Ga7uypusijh8TDrqFDffMfhFXyt22iAuMv1nSx1GxnA/2lVL3dZ?=
 =?us-ascii?Q?v8RgiapcnFkhJMxJatrdl3AkKa7PT/X59QFl/i51JuMvJeW+vl13a3Q28eIT?=
 =?us-ascii?Q?lSRrjX1EgIvPfazhs1135S6BriE9PunrPcenzyWHf4BJx6eMVIQQroQuymYz?=
 =?us-ascii?Q?jOxQLjUn5rB1Av2lQg3yD0DW6H3tAn8Jlxd77wZWBOpkDWGUwso3qq7BD2bH?=
 =?us-ascii?Q?rbgqmBxGEfOuCT4wPvffFjNiy0A6sEPAISON1Dkyrin4p5ZLWRG21knRk1V3?=
 =?us-ascii?Q?WLHsJwtwIHN0WwgJeMtKqaL54Lk3ckKAIp1TYr2p3YrOD5sne/UPOae5sLSt?=
 =?us-ascii?Q?CM/JeF76PQdBTaYMqb5/O2RdZczt5yWzoTNa7R9Zg6grtwlN/szVwCL+LIpU?=
 =?us-ascii?Q?pNDAlquZLaPHWE/8N9m4lXGLmzGjyDOn/o7GxCSTrY5b9vUGtr+krokx4DVo?=
 =?us-ascii?Q?/n3+5JtVvXfaBoZQeJr/DoUDo2Vjw/HczsLRp0UXPiyVusvxwjS8pa/xHhLv?=
 =?us-ascii?Q?ujEAQrGm3yHRxrvKlFcVqpsrItCk5wEoJc3PhtV5fTcyaMbQeQOlnmh1tlvs?=
 =?us-ascii?Q?+lODLHx4A94s3KNdMp9CIb7h0eA10R4PAHPybejLXl0OJuvROBS/YN8qVWYl?=
 =?us-ascii?Q?p3bn5pdFY0TRdCm9rub4hR4atXSmQjLSJcgpQ0Q/jAAQ1KQ5Xear+yrChlil?=
 =?us-ascii?Q?iLHlnzVOWYhFE4OfAWI5EOQtBnshezcf7KQnB7Ny84EtRAtEhhDj/j+WL4P6?=
 =?us-ascii?Q?g+DG2r1QEoh0j9suv3Jy5NA4vBVL6Z8AcLFTdvl3IplTgIa+gxj8M9qYPPTA?=
 =?us-ascii?Q?YWt3bUOpEK4bT4LeHWLeelLXcVjNCiHHUoI9wjCFzftCVp6qL3e0WHyQjtqf?=
 =?us-ascii?Q?hZhzzwd5CxwxIqXS4/6JXF2S/Gk33ZoaXUq89BrdOw6lrkB2Bxvc6iiIfqS8?=
 =?us-ascii?Q?WTzx8NiQ+5C9h1z0xFrLVKcfww9PYKafz2/VJWlioEzDd+3SVtcClmQxlLrj?=
 =?us-ascii?Q?f+QGMghR4kYrbcXSa9yEH3zyi6kG02uOcnBEpaUaroAsX7EILfkvBh5V6t/S?=
 =?us-ascii?Q?W2d3kVW0GaFmt+sXGNI011pDThci3SyqEHl2i11bAwiGt3HWLQahASdxKRlZ?=
 =?us-ascii?Q?+3opwGPsWJ3ZrkeJMrOQyzsnbaCPhAXp3ecR3B0e8Yg3MshRr3FeOT450E4x?=
 =?us-ascii?Q?wkl45yZuwHovWj1JGaaaCbrIjoxmOnYKg7ZUjojkVKDegZOf3Ouv2uldh/zg?=
 =?us-ascii?Q?+cAJMBBeJMtSKnYgSDjLXUdGUaF+DZtaRwbMMANh7C687RGCLGfSKROqaU5r?=
 =?us-ascii?Q?44D4yJbIi24pZS3wY/B2Z9kd19KYdJc3iYB/vSWFMwgeI4vaWnmAG7qdET5h?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b533aUzQ1YeW/+599hKsDrxJT7GC4+hstvzHmNFq4MPPrX1w10IZcws+SnRn8+z06w9IQsMVcDTo6pZ3USDC1C0j9usf233Qq9lwz/P7T0phWWyZY0pC3algZiyk/6B+G0kRGKmV3J1+stFqmJQkxevHYfdOmb/HhyH/3XX+bhQufn0102tGdFkoj1X3ObtpAo39yUeJegZHRDPg78+Mh6rNVGmP6a9+uHHw282YTlRJy6CsQoQlKwvs3DWzWCA4o7Yl73NbmwDsHvaJswPHeNvBe58raVOvqIwd4IjYvfUTXS7K/ci7Ca3itBmZpkG7P6Rjbh6gyu1OT2SHh5/RP5G0iEM1hjzzhABZ078ysG9E+aiq9OqZEWy77o41H0s0KjhcB7PwAYpA2t424MfZMIgD25eVW2V2+7tHw22eS5xSs3vQ63zzjbDB3WJDhi29KeUAYFuySP2Jkm2gkbnYIvhUM4bp26EOx3BvHpoYMViQYSQhtbVUdYswHadGH2f2CuFAeC/05fg0xkUbb+7NEao85nd9f4QmCyUFnTAchRUwGzhEl3Vf9GPP44DpYmwiZ2jdJ1tPNkKMq0J2l3RpqmDwwytkVOP3YKJ8zX9UnEA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d15905-d410-4281-0d58-08dcdd477a5f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 09:50:24.6095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jB7y/nspdmRkJt0f6WaGxjpS+y8XjkZzVAB0+LDlW5YFX66iqrPWQkwLkszlPG2AJkLbgrjms0MCJkVULce1YAAnZxJBLP4OqjAFlAZGn+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4838
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-25_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=994 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409250067
X-Proofpoint-GUID: RIn0aSfjOGDOlKuwv-yYne6LhIDm0SYR
X-Proofpoint-ORIG-GUID: RIn0aSfjOGDOlKuwv-yYne6LhIDm0SYR

On Wed, Sep 25, 2024 at 05:09:47PM GMT, Shu Han wrote:
> > You have sent this non-RFC intentionally conflicting with [0] to provide
> > 'alternatives' that is not what a [PATCH] submission is.
> >
> > In any case, speculative changes like this should ABSOLUTELY be sent RFC,
> > and sending things that are merge conflicts as ordinary patches is actually
> > bordering on being a little rude!
> >
> > I'm sure it's unintentional :) but for the sake of us being able to work
> > with these properly you should just send one as RFC and ask whether it'd be
> > appropriate to send an alternative, and just allude to it in the one you do
> > send.
> >
> > [0]:https://lore.kernel.org/all/20240925081628.408-1-ebpqwerty472123@gmail.com/
>
> I am very sorry that I sent the wrong subject which should add "RFC",
> due to lack of experience.

No need to be sorry! :) Sorry if I sound harsh here - it's more a case of
trying to be as clear as I can be as that is the best approach for everyone
I think.

This code is sensitive, so we have to super careful!

>
> > It's a bit weird to send 'alternatives' - you should by now have a good
> > sense of which ought to work, if not perhaps more research is required on
> > your part?
>
> I think both solutions can work, and the preliminary discussion is on
> the mail list for [1]
> (as this issue is related to security before it was fixed, the
> discussion is on security@kernel.org).
> The choice depends only on taste.
>
> Link: https://lore.kernel.org/all/20240919080905.4506-2-paul@paul-moore.com/ [1]

I would disagree it's down to taste, I noted on the move the check to
do_mmap() series a number of issues and concerns, to me that seems
unworkable in it's current form, the locking thing is fatal for instance.

What you link to there seems to be neither approach (I didn't read your
second series though as that needs an RFC tag)? I mean I think perhaps what
you are doing there is the best _first step_ - simply add the checks in
each of the callsites that you feel are missing them.

This is the least controversial way and then allows maintainers of the
callers to assess whether they intended for that.

If then you end up wtih _all_ callers doing this check, we can take another
look at possibly bringing it into do_mmap() but we would absolutely have to
ensure it was done correctly, however.

I do feel we need to better document these functions, so I will add
comments. I see you did so as part of your other series, but think maybe we
need to expand this and possibly rename both and add some asserts... it's
on the todo list!

So moving forward I suggest:

1. (If you haven't already) Submit a series that adds patches to add checks
   at call sites that don't already check.

2. If these are accepted at _all_ callsites, revisit the do_mmap() change,
   properly accounting for locks (I can help with this).

Thanks for your contribution!
