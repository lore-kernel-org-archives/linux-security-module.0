Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C92AE6C;
	Wed, 25 Sep 2024 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727254144; cv=fail; b=aquCcfe9AF1npBqpGIJFSj6tZFvbOMkOZZXafD/ReB1UleVUMZczHisv/9AMlPHp/udMhVHTf8A5+UjLWScHeqZgKqjZB7F2fMDSV9zAX9L3+3wd6S6x2xGRZQ2ojcAHEjVgEAPGQz50GrXLbF7+5U8SXFPb+1cq2lUq1xo/LFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727254144; c=relaxed/simple;
	bh=D/hgqMQ5pQSAHUudTxSKDokE7Hkv6sMEy9vWk6MyG5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tx6Gfz3yMtoSaPEaO/Ku6hAEqmCUxSDDhyxjSH80Rm2xqBXjrnsrBX6ld9LNUMrSsEPqv2FY2l96MI/Dsyv3Nio5lBOEXy2E3l7LCCxQzCZN1NBPy8olYkMB96DbxfXFduC4GILXii0DbyWt9XeDS6MGQSRG6opX87ittqIdMCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dEuorL/W; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IttaN+R3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dEuorL/W";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IttaN+R3"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48P1tgc2001131;
	Wed, 25 Sep 2024 08:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=jAV7A69x98rMw/e
	u7eXWfK1c8F5DpRV5HYx5taUy+R0=; b=dEuorL/WMLhGMm4tyBwUxgxL65+uTvK
	9DAXmC/usn748xfjYAbzQ5iL0XnuI7v5Rj/R9ePQK1W3BRvdQI/R/v7f2O/V1WYx
	/2VuVVhJKqUDy1uqrVYfEb228GpSFvhfcJvoBGcPRP6BD5MR9oK7EqMXnxzux2lB
	20mVkmGn8qHz6oFCKKwQWOSD8AZkfA36xZ4WimY0UotA4k96OQKNlJnkQYbfRY2N
	vbUzHuACUMonNeN5Jz51xYbpuBlzTa/mlA3xA2CkS7oYybJ5X9tGKgND3rXZ8PoI
	JTBLzrdOHB3HiAY0LxqgMvYI2HRxHrEXkKYB8QDKGvcLKeJtKRexDDA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smjd77bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 08:48:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48P810Ie026012;
	Wed, 25 Sep 2024 08:48:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smkac0yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 08:48:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwGHnU78IKHhn0szUtqJrFHV+cSdGsRrSMgiV/ecx3vAmTRb9frLhk/n2AaKmg9heA1qirPjgr6mU51ygxVOgTZAJrNh1Xr/pyr7gx1Uz/v5+rdv2zjLGvK3IAbkOxXNW3PTaRVjLz8+bXrdKsQagN7rbip860/B8wwnfejKZR4IC6FzoUg58sR8dTW5QQZOg3tkLtaYiA5aV1tOtXyZFBCCCe9octmfy8k8xytfAQOpsug9FG6YIM+v01Iv1L08uw7rJ7PaH3UnaRe9vu6Ks4qJGfWp6WjhiJhJO+Juy5KBPcJEXFh5/ufuHoy2BNx4mK7K5cKz0nLcQR/iSXaFiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAV7A69x98rMw/eu7eXWfK1c8F5DpRV5HYx5taUy+R0=;
 b=cDSVTKdk1YpVpYl43QU54yOcoiEUP5h/DL+7JnTuEPiDrhvmMeALDiF1MsENzO2hrnYNGIuv/idI2jYDOH4nnS+67XXFzC+n8QnXo0S6oSReugY0VKoa6sklstpd+GUaDUxkl8SWUeKTZ5v+ykPjnusTavV2i7WXNEOooAVoc82y+wQC08G7RSGJ75s8l/ZyXB726OTjSaOMiQ+EuiwPhtUSmuqq8lrQo6hjoJEGXzhJAvLGvGxyxqLS7kj/7Modeu7YiZqkqw5QpVKOSEvJmljEuN7Fkww/Sw5q1urYPwkPZW+UC2Mk40rOpEgYxqwE6Jwf7LVGrhg006O83BqmLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAV7A69x98rMw/eu7eXWfK1c8F5DpRV5HYx5taUy+R0=;
 b=IttaN+R3ZSns70HBRRpEAxJD5nnw/1cWi0uTP2boW6ooHSpsxvowqB5re7aB98KUBiKboFN3sMcjX+bHO9OVVVEYPL+3ABGMMYlGnT+RNPalWaSc56RdzORfhiTbCauKyyHKL1T4Tl26jvz043sfO+qKX0HeqQb7ui9ptRBjCNQ=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB7311.namprd10.prod.outlook.com (2603:10b6:208:3fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Wed, 25 Sep
 2024 08:48:40 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 08:48:39 +0000
Date: Wed, 25 Sep 2024 09:48:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shu Han <ebpqwerty472123@gmail.com>
Cc: akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] mm: move the check of READ_IMPLIES_EXEC out of do_mmap()
Message-ID: <72050879-4546-4bc7-9983-79ad437594d4@lucifer.local>
References: <20240925063034.169-1-ebpqwerty472123@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925063034.169-1-ebpqwerty472123@gmail.com>
X-ClientProxiedBy: LO4P123CA0519.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::6) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: b60ab3d9-1fdd-4b63-4497-08dcdd3ed9ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xuKeP6xOxffsgQWLP7ipuiQvoiHroXrXLSaQTqaOo11/VvGh1VRLv3oTTqRw?=
 =?us-ascii?Q?p4u9S61sWjK+/iYEMlxEca9LDRjYU/CuOetrJV8756jHunywL+gX9aBtivGd?=
 =?us-ascii?Q?ZSL2uOOSz6uoQ/PzyI9CIxLsloPydIaH2Ok+oD4gz1RGm6g21wgcGqFvKs38?=
 =?us-ascii?Q?v9IjwldbWc1z88J0FjuUoCJrz6GnwvOOB95yf1YJ1lcIAjp/aUo0wUFHkQ//?=
 =?us-ascii?Q?WsfdX8ryKPUYtjORh2Mxn52PR2vtRylX6VP+cVGMe+C3e5riayTe1SHZrt50?=
 =?us-ascii?Q?e2mMvvSH5dv+mpBgjzvZFPzgZY5Iyx2tOkN2MCX+vK8IMpxRGQSuxyJBfDpX?=
 =?us-ascii?Q?pw+H3ZHexTb8Wtn7s7ZpoCtWtMMkaoYiMyrGocJsoztilNfSSc95N3bwMSiJ?=
 =?us-ascii?Q?7SsSJoc67rSZ/xzHtf+8Sm6bsl7a7JSfofrJTQQ0dWy25j9NbAzd5SOtXZNX?=
 =?us-ascii?Q?MBqq0aaOF85XB7NlaJgjy5PQf0TrtCoUQy+PZg99AzM42I6z3uY+4/Yyoixo?=
 =?us-ascii?Q?1K0xLnbeSfpOdwvGJOcRxdFuS4trWgLtP45xqXsKLWSduuBBmMEwoAnMzC/M?=
 =?us-ascii?Q?ZT5pPQD4Aw23kWsMWunYDCV9G0UvF7EGRJLmJcFpfWK7TAKWRdWv0+xIambj?=
 =?us-ascii?Q?VUX3TlALyzxw0YfqebUZ6y0pNleHyEzbLw0B4C4FC3c3O4BcqqLNF6oplg4H?=
 =?us-ascii?Q?ivgIUhYmJ2xOuqGeHW0MXfb6Zb8PdBuHpFHtbuD4xUuaQwdMUmGgIJj3zN0s?=
 =?us-ascii?Q?BN4Hme4GlhbT+gVqS7RlSClLbFJPdyam/vFAOSzXiMvMIA2eeMQMOBwfjjoU?=
 =?us-ascii?Q?XSRDJswFlfVGfY1C8TDy9FEYLJTrFJYELUM7tJLDVUazmoTlgOkqZVz3E4H1?=
 =?us-ascii?Q?Z5AdS+EUOX+RGrrsdtiK4M7VrDojNCVDAGfvMvYUODzRnNE7H1drqeF7ZW4T?=
 =?us-ascii?Q?ViiKR2XMYbIJlpRXAB/JGlVGYRtp/ofcnMuWddMKnBdY0jImoLfm2gDDFQz8?=
 =?us-ascii?Q?8jU5nfxMvkbwyAmysCeVwfECx+p4ysmXBekSKoshQw/X4WiqxYmN6YpQILp5?=
 =?us-ascii?Q?WDMF2l0Sa3SoBCNQOSGQ/z0ZDQQM8Po8sY2FjkDcDuyZ+espP6tKM2PIF3CL?=
 =?us-ascii?Q?/GqqVOCLfpPORwBb+ViFWDiCCqixYbZ++zPC816zhC+lNfA1RFum9F28CjeO?=
 =?us-ascii?Q?Wl/ncDXwD/Q+0+LXpy3enSnVP+XQtg2TPd8xaR6bIU24yXnBYv6pFo24jrQf?=
 =?us-ascii?Q?T+wQxo5eVljUEN6kcu5IumpqGjL//kD5nsr4LimInLPHv+lX2ay3rRRi6Go2?=
 =?us-ascii?Q?3oY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4E3E/41AqLJDu3CEudUBtTJDCDwJ5qCekrbjrPszGtgAla70q6dkdWWCTf3M?=
 =?us-ascii?Q?UGZ255oTm+d69ugcSkSqYHCpTxtLmcQE1OYaTn3PzqDZVfHcu0NBo8pBy+E4?=
 =?us-ascii?Q?6eo2dVFlrXH1afwLoy+4Oufx/VYhTQWXlO0kqiTRA/PnSJe5vWApnrdc+sqs?=
 =?us-ascii?Q?V6a0WX1ofm1N7txPpGM7JEvUv352ZyUvO3skS1YxyHTPBVCJwqJzCEubh9PP?=
 =?us-ascii?Q?CAXBg/QQLD6xmhzZFzW7YEBnAjyT3YPNYyeI+SIWLnCdRqVIvVS171Z0Hmm4?=
 =?us-ascii?Q?+uoeuzw6d29klLdERXY/HJR9bpNpUw+71YZv2CR5A0kPrgJapO3aSOmjd7UT?=
 =?us-ascii?Q?RGQiIDNwew/L/1QIBOIOcspRkLc+NPTHJ9CUC06BTZI7d9jXFdAZ+x40Vrmg?=
 =?us-ascii?Q?qXwpasO55cZArgnCRwx5hRBGbaWjzo1t9VnJtCimLFrBMtk2Uq8xG66ZO5oz?=
 =?us-ascii?Q?AMMX7ESJMo+zO0WqJ2TkJMNZc12HTG+QB48n1LtGC9hz/rksJ3JL4OmyMgwh?=
 =?us-ascii?Q?bNUgUpZZLUtioN/l+JHOJr/9J//4MZWcqtU1L4P9wkskCYhjIkJfCvFmT6b3?=
 =?us-ascii?Q?UQMFX9PtBOSJ20GCRYRuf94S55Tp+WDMSvX/dh9NQvnwfIgn8jSrV0Kx9Yb6?=
 =?us-ascii?Q?mRaLYZg62UKbewrTPw/NiycU+szQoMc4DLA6X6AmcK4HA62AkXkTq2arSgdq?=
 =?us-ascii?Q?0YadKlZh86cr+EjrdLA4NP9gj8s+2rw0BoljM+EBpHCjkxK0GXGOmYbNFhks?=
 =?us-ascii?Q?G/nvE2suSK3KkDfewUBlX3206m6PjgOAkxRE4Sqou1unFaAeWlVR3dtAKiuj?=
 =?us-ascii?Q?U5Bhbu5IvtwsKgryVZ6LLCS25Lv2LxhLR0Xb36H18cx6l2cCSVB5IspiTQdk?=
 =?us-ascii?Q?dy+HDS6XCsF1mrkdKXrA8IWL0wmWvH+wzJPLw2ll5ZKH1djx+PhoyBfYwfLA?=
 =?us-ascii?Q?10cDNz6S4aokoJqnwk+/LHw5MAyQNKTwtrFVtHflCObLe0l00c5k7b09Qg1k?=
 =?us-ascii?Q?zR2fW4gBHSNSgDf+cPs5AT+xZLJiffmDuXs/Pd+4TxZFOm6Dze+NR0bAfTSY?=
 =?us-ascii?Q?Kwhi9GVspH51eab513bhsHkpikXJjeBdGhBBTfwZRxE/GghH51lcFN4ymuVK?=
 =?us-ascii?Q?xzh4hkAL4vBnROR3upuGmxJ5nFdaJWuxC2Oq5ZU//8Xl583cBqyH4jJM4Kwm?=
 =?us-ascii?Q?FOJY+YTC3cmEv4wfEnUT2D6tYtEXcFPwvKsQKZDwYl773tN8nXGXE173h7I+?=
 =?us-ascii?Q?gNawG1K4gbUPvltm9A3avjf0p7rJY3nZbZ5L4l/8DoSfZmt46woYtMfmGOGS?=
 =?us-ascii?Q?kanLGrZvOngt6wW5vIlxXGK0j+qHHrhGsd07fIpfup8bc8+hMBCu39Ht5ROn?=
 =?us-ascii?Q?9lpZc41f2ZM2Olxt2ZsywX9JnA++2yH4jvOtYqIPJyDKWDqDkn+BHYLL75XC?=
 =?us-ascii?Q?eAVvtUnOj0vBNvBGccCScPwzWxYrjv1eCrPl1NWwLuWqEpswAnZnPvVUkXLn?=
 =?us-ascii?Q?zGTMAKzBE3+fjT03tPdA9VWWTWfxPIlPIaCs2Ct28TeoQiGcxH/NvePS/Wje?=
 =?us-ascii?Q?uvwO12LfhI/ngJ+rv8m5JoGffXhmFZcvfYN6bZ+4/ew9J9SAvqgQsYlsZ9pb?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pitw9FVuww7dxIlKEUOINpdZ2rFBDrAt3GF87e+S3Bb6a3G+//sB62VzRln4vgl7qyyqRhM2EXSq3rh8Sl0acERfGo1cZhfikMAK3buhOXqfXS7eCKa8nhjwMvqLgHNxhqPmw8Nz3geAZh3Cu77Iw/izr7ivZVRwamYID2x47n/QNNRKWHj4u63/dn9MC5p2woejbCUe2yBBZbvxt0JJ2dPnr2617VP5JE9WfFzinaYcY9O8Mj4vEdhcNbriH12Eacm1s8lAcc7y9AMyqNl5TQ6H7YuPG1lsyuR4G9sb612H/btUdHAZ4t7dauS2Jvxjr/WGLcn/CTvEwyrWnIkYZxS0DJlFhzQ0NdXknGoKVyzLr8bFCTN15oKnDTH4rLm/xua12SzLQcPm9DnLLt+e+L7g4aGpZFrOK6KY+2cAh2WBGPNVp7HvXfMw/dzzI+USRVTbrFGUBEtaxOvs2lHjekJ0a8c4f52HgZuAb4xHbeIPIQhasBH6IoAsqrp79k8riE5CPVwhCwaauNE4IVuR8/AX3a9CO88BtiQ4AO9E9zK6i0+ha5XEmuyk2TVhjC8yhmNZuVWnruyWLREi1sHn5xFKgl3q+vUrxw2YS8DLcyA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60ab3d9-1fdd-4b63-4497-08dcdd3ed9ba
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 08:48:39.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6TZuNTwYGYU1Vd+KVzQep8pjKJRBAeByMHK1UnlU4ZUNrypAZA66O93qeqwfJpFEQHPgfxoUOsobflR91nv14FI9yKBjCCwlRlOPqrkflc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7311
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-25_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409250063
X-Proofpoint-ORIG-GUID: EAKTIR4vtL2cw1wEEghvZLl0Hajub2QA
X-Proofpoint-GUID: EAKTIR4vtL2cw1wEEghvZLl0Hajub2QA

NACK.

You have sent this non-RFC intentionally conflicting with [0] to provide
'alternatives' that is not what a [PATCH] submission is.

It's a bit weird to send 'alternatives' - you should by now have a good
sense of which ought to work, if not perhaps more research is required on
your part?

In any case, speculative changes like this should ABSOLUTELY be sent RFC,
and sending things that are merge conflicts as ordinary patches is actually
bordering on being a little rude!

I'm sure it's unintentional :) but for the sake of us being able to work
with these properly you should just send one as RFC and ask whether it'd be
appropriate to send an alternative, and just allude to it in the one you do
send.

[0]:https://lore.kernel.org/all/20240925081628.408-1-ebpqwerty472123@gmail.com/

Also +Al whose original patch you are in effect reverting.

On Wed, Sep 25, 2024 at 02:30:34PM GMT, Shu Han wrote:
> This patch moves the check of READ_IMPLIES_EXEC out of do_mmap(), and
> calls the LSM hooks at the same time. The below is reason.
>
> Some logic may want to call do_mmap(), but they are not aware of
> the harm this poses to LSM.
>
> For example, CVE-2016-10044[1] has reported many years ago, but the
> remap_file_pages() can still bypass W^X policy enforced by SELinux[2].
>
> Add a check is easy, but there may have more calls to do_mmap() in the
> furture. And move the security check in do_mmap() will let it in the
> mmap_write_lock, which slow down the performance and even have deadlocks
> if someone depends on it.
>
> Moving the check of READ_IMPLIES_EXEC out of do_mmap() can keep the LSM
> hook is called out of the mmap_write_lock, and avoid repeated logic for
> whether READ_IMPLIES_EXEC should add PROT_EXEC for the mapping or not(In
> current, the !MMU case won't implies exec if file's mmap_capabilities is
> not exist, but the security check logic is different). And all known cases
> that call do_mmap() become secure and anyone want to apply the
> READ_IMPLIES_EXEC logic will call the LSM hook correctly.
>
> Current call sites to do_mmap():
> arch/x86/kernel/shstk.c: must not want to PROT_EXEC in any case.
> fs/aio.c: have ensured never have PROT_EXEC in the fix of CVE-2016-10044.
> mm/util.c and ipc/shm.c: the common case
> mm/mmap.c: in the history, remap_file_pages won't care about the
> READ_IMPLIES_EXEC. this side effect is introduced in the emulation
> version, after the deprecated mark exist.
>
> Link: https://project-zero.issues.chromium.org/issues/42452389 [1]
> Link: https://lore.kernel.org/all/20240919080905.4506-2-paul@paul-moore.com/ [2]
> Signed-off-by: Shu Han <ebpqwerty472123@gmail.com>
> ---
> An alternative method is moving security_file_mmap() back into do_mmap(),
> i.e. revert the commit 8b3ec6814c83d76b85bd13badc48552836c24839
> ("take security_mmap_file() outside of ->mmap_sem"), which is simpler,
> but it will affect performance.
> ---
>  include/linux/mm.h       |  2 ++
>  include/linux/security.h |  8 +++----
>  ipc/shm.c                |  2 +-
>  mm/mmap.c                | 42 ++++++++++++++++++++++------------
>  mm/nommu.c               | 49 +++++++++++++++++++++++++++++++---------
>  mm/util.c                |  2 +-
>  security/security.c      | 41 ++++-----------------------------
>  7 files changed, 78 insertions(+), 68 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c4b238a20b76..83f334590b06 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3392,6 +3392,8 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>  extern unsigned long mmap_region(struct file *file, unsigned long addr,
>  	unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
>  	struct list_head *uf);
> +extern int mmap_check_prot(struct file *file, unsigned long *prot,
> +	unsigned long flags);
>  extern unsigned long do_mmap(struct file *file, unsigned long addr,
>  	unsigned long len, unsigned long prot, unsigned long flags,
>  	vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index c37c32ebbdcd..e061bc9a0331 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -423,8 +423,8 @@ void security_file_free(struct file *file);
>  int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
>  int security_file_ioctl_compat(struct file *file, unsigned int cmd,
>  			       unsigned long arg);
> -int security_mmap_file(struct file *file, unsigned long prot,
> -			unsigned long flags);
> +int security_mmap_file(struct file *file, unsigned long reqprot,
> +		       unsigned long prot, unsigned long flags);
>  int security_mmap_addr(unsigned long addr);
>  int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
>  			   unsigned long prot);
> @@ -1077,8 +1077,8 @@ static inline int security_file_ioctl_compat(struct file *file,
>  	return 0;
>  }
>
> -static inline int security_mmap_file(struct file *file, unsigned long prot,
> -				     unsigned long flags)
> +static inline int security_mmap_file(struct file *file, unsigned long reqprot,
> +				     unsigned long prot, unsigned long flags)
>  {
>  	return 0;
>  }
> diff --git a/ipc/shm.c b/ipc/shm.c
> index 3e3071252dac..f1095ee3796d 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -1636,7 +1636,7 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
>  	sfd->vm_ops = NULL;
>  	file->private_data = sfd;
>
> -	err = security_mmap_file(file, prot, flags);
> +	err = mmap_check_prot(file, &prot, flags);
>  	if (err)
>  		goto out_fput;
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 18fddcce03b8..b8992ee202fe 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1249,8 +1249,36 @@ static inline bool file_mmap_ok(struct file *file, struct inode *inode,
>  	return true;
>  }
>
> +int mmap_check_prot(struct file *file, unsigned long *prot,
> +		    unsigned long flags)
> +{
> +	unsigned long req_prot = *prot;
> +	unsigned long new_prot = req_prot;
> +	int err;
> +
> +	/*
> +	 * Does the application expect PROT_READ to imply PROT_EXEC?
> +	 *
> +	 * (the exception is when the underlying filesystem is noexec
> +	 *  mounted, in which case we don't add PROT_EXEC.)
> +	 */
> +	if (((req_prot & (PROT_READ | PROT_EXEC)) == PROT_READ) &&
> +	    (current->personality & READ_IMPLIES_EXEC) &&
> +	    !(file && path_noexec(&file->f_path)))
> +		new_prot |= PROT_EXEC;
> +
> +	err = security_mmap_file(file, req_prot, new_prot, flags);
> +	if (err)
> +		return err;
> +
> +	*prot = new_prot;
> +	return 0;
> +}
> +
>  /*
>   * The caller must write-lock current->mm->mmap_lock.
> + * The caller must ensure security check is not needed or
> + * call to mmap_check_prot before.
>   */
>  unsigned long do_mmap(struct file *file, unsigned long addr,
>  			unsigned long len, unsigned long prot,
> @@ -1266,16 +1294,6 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  	if (!len)
>  		return -EINVAL;
>
> -	/*
> -	 * Does the application expect PROT_READ to imply PROT_EXEC?
> -	 *
> -	 * (the exception is when the underlying filesystem is noexec
> -	 *  mounted, in which case we don't add PROT_EXEC.)
> -	 */
> -	if ((prot & PROT_READ) && (current->personality & READ_IMPLIES_EXEC))
> -		if (!(file && path_noexec(&file->f_path)))
> -			prot |= PROT_EXEC;
> -
>  	/* force arch specific MAP_FIXED handling in get_unmapped_area */
>  	if (flags & MAP_FIXED_NOREPLACE)
>  		flags |= MAP_FIXED;
> @@ -3198,12 +3216,8 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  		flags |= MAP_LOCKED;
>
>  	file = get_file(vma->vm_file);
> -	ret = security_mmap_file(vma->vm_file, prot, flags);
> -	if (ret)
> -		goto out_fput;
>  	ret = do_mmap(vma->vm_file, start, size,
>  			prot, flags, 0, pgoff, &populate, NULL);
> -out_fput:
>  	fput(file);
>  out:
>  	mmap_write_unlock(mm);
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 7296e775e04e..96761add1295 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -792,12 +792,6 @@ static int validate_mmap_request(struct file *file,
>  		if (path_noexec(&file->f_path)) {
>  			if (prot & PROT_EXEC)
>  				return -EPERM;
> -		} else if ((prot & PROT_READ) && !(prot & PROT_EXEC)) {
> -			/* handle implication of PROT_EXEC by PROT_READ */
> -			if (current->personality & READ_IMPLIES_EXEC) {
> -				if (capabilities & NOMMU_MAP_EXEC)
> -					prot |= PROT_EXEC;
> -			}
>  		} else if ((prot & PROT_READ) &&
>  			 (prot & PROT_EXEC) &&
>  			 !(capabilities & NOMMU_MAP_EXEC)
> @@ -810,11 +804,6 @@ static int validate_mmap_request(struct file *file,
>  		 * privately mapped
>  		 */
>  		capabilities = NOMMU_MAP_COPY;
> -
> -		/* handle PROT_EXEC implication by PROT_READ */
> -		if ((prot & PROT_READ) &&
> -		    (current->personality & READ_IMPLIES_EXEC))
> -			prot |= PROT_EXEC;
>  	}
>
>  	/* allow the security API to have its say */
> @@ -992,6 +981,44 @@ static int do_mmap_private(struct vm_area_struct *vma,
>  	return -ENOMEM;
>  }
>
> +int mmap_check_prot(struct file *file, unsigned long *prot,
> +		    unsigned long flags)
> +{
> +	unsigned long req_prot = *prot;
> +	unsigned long new_prot = req_prot;
> +	int err;
> +
> +	/*
> +	 * Does the application expect PROT_READ to imply PROT_EXEC?
> +	 *
> +	 * (the exception is when the underlying filesystem is noexec
> +	 *  mounted or the file does not have NOMMU_MAP_EXEC
> +	 * (== VM_MAYEXEC), in which case we don't add PROT_EXEC.)
> +	 */
> +	if ((req_prot & (PROT_READ | PROT_EXEC)) != PROT_READ)
> +		goto check;
> +	if (!(current->personality & READ_IMPLIES_EXEC))
> +		goto check;
> +	if (!file) {
> +		new_prot |= PROT_EXEC;
> +		goto check;
> +	}
> +	if (file->f_op->mmap_capabilities) {
> +		unsigned int caps = file->f_op->mmap_capabilities(file);
> +
> +		if (!(caps & NOMMU_MAP_EXEC))
> +			goto check;
> +		new_prot |= PROT_EXEC;
> +	}
> +check:
> +	err = security_mmap_file(file, req_prot, new_prot, flags);
> +	if (err)
> +		return err;
> +
> +	*prot = new_prot;
> +	return 0;
> +}
> +
>  /*
>   * handle mapping creation for uClinux
>   */
> diff --git a/mm/util.c b/mm/util.c
> index bd283e2132e0..2eb4d6037610 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -581,7 +581,7 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
>  	unsigned long populate;
>  	LIST_HEAD(uf);
>
> -	ret = security_mmap_file(file, prot, flag);
> +	ret = mmap_check_prot(file, &prot, flag);
>  	if (!ret) {
>  		if (mmap_write_lock_killable(mm))
>  			return -EINTR;
> diff --git a/security/security.c b/security/security.c
> index 4564a0a1e4ef..25556629f588 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2927,42 +2927,10 @@ int security_file_ioctl_compat(struct file *file, unsigned int cmd,
>  }
>  EXPORT_SYMBOL_GPL(security_file_ioctl_compat);
>
> -static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
> -{
> -	/*
> -	 * Does we have PROT_READ and does the application expect
> -	 * it to imply PROT_EXEC?  If not, nothing to talk about...
> -	 */
> -	if ((prot & (PROT_READ | PROT_EXEC)) != PROT_READ)
> -		return prot;
> -	if (!(current->personality & READ_IMPLIES_EXEC))
> -		return prot;
> -	/*
> -	 * if that's an anonymous mapping, let it.
> -	 */
> -	if (!file)
> -		return prot | PROT_EXEC;
> -	/*
> -	 * ditto if it's not on noexec mount, except that on !MMU we need
> -	 * NOMMU_MAP_EXEC (== VM_MAYEXEC) in this case
> -	 */
> -	if (!path_noexec(&file->f_path)) {
> -#ifndef CONFIG_MMU
> -		if (file->f_op->mmap_capabilities) {
> -			unsigned caps = file->f_op->mmap_capabilities(file);
> -			if (!(caps & NOMMU_MAP_EXEC))
> -				return prot;
> -		}
> -#endif
> -		return prot | PROT_EXEC;
> -	}
> -	/* anything on noexec mount won't get PROT_EXEC */
> -	return prot;
> -}
> -
>  /**
>   * security_mmap_file() - Check if mmap'ing a file is allowed
>   * @file: file
> + * @reqprot: protection requested by user
>   * @prot: protection applied by the kernel
>   * @flags: flags
>   *
> @@ -2971,11 +2939,10 @@ static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
>   *
>   * Return: Returns 0 if permission is granted.
>   */
> -int security_mmap_file(struct file *file, unsigned long prot,
> -		       unsigned long flags)
> +int security_mmap_file(struct file *file, unsigned long reqprot,
> +		       unsigned long prot, unsigned long flags)
>  {
> -	return call_int_hook(mmap_file, file, prot, mmap_prot(file, prot),
> -			     flags);
> +	return call_int_hook(mmap_file, file, reqprot, prot, flags);
>  }
>
>  /**
>
> base-commit: f89722faa31466ff41aed21bdeb9cf34c2312858
> --
> 2.34.1
>
