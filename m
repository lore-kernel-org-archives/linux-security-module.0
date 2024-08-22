Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12D31D2F4A;
	Thu, 22 Aug 2024 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354829; cv=fail; b=tVJ2H8k+d4KpdOvqObCVPugLYJzSJTMbpkF+ER2jfyzWmvjeiJIBXAEjlGxEOM18qun9jy7jeNBT88GB78xhBL8gA2xZxObLsmoSedHpVLUdThSkO3JtbjS7qUxC5EY7ljWbAMRKueSc/QMl+ECfO7PweWBz03K7yt0PwVKF0TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354829; c=relaxed/simple;
	bh=8SOE8pTa7FFO3wQjbntIvjo4FOuBX8Vr4N/o9FiLxZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UT/PHQi7F8cbKc2ILWMYDDNEVh1EysqJlkZ9lhdLWPW1VJwZ7IjRd0Wre20cXkUtAaDarbpb/I0YOKJ5r86WDaW2MXj5bqPcfIL7NK17Wzp7GA6eg74gWFf8fe5YIo8zm72HTRMRP8rSdOIilelCdH40/7iMJvoZofb03R4IszE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lSHD8SxZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y8oj/EAq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lSHD8SxZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y8oj/EAq"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMUUG021048;
	Thu, 22 Aug 2024 19:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=ZVYsOiWFMcykFDuOByyZ0ITVxyXF2Jr6xdqxlzJra2c=; b=
	lSHD8SxZnLGoPKzrAV4gSu3/j2L+QLkR3IXhOXmiXh1ulVdX7dVFJXwfrmzhEOBH
	KL7o1AvF1Wzej/65bwN1WVSUxMaPQlRV4I0WyP3T4Zk1lGup4+oQ0qRsUCI37DKR
	rCTjHOGQlwhnUOozlkZkPMzFLDtczy212OCVoinngPqCV9ltiVeRt1/wt2ELJB9G
	uWMV9b03CuET+mKvyGT/9StbCWF7TPIFR00+aTgZgTXXd/R/c6bZORO8jKvOP+1l
	1+ahNvaOghhbZgK656S5r56YgD5T0Itz/2Fq4cQZKbJo8s0HkiqqJBlxIfhzQct2
	KM9UMWXshhyWZWwdBd1a6g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdt2w1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MJ3jw8020777;
	Thu, 22 Aug 2024 19:26:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 416b5jrykb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlJkLjmvD6TCzUqNzl3cuMjqyQ9qxri/ud5/ydWgFOfpkrnty1j4LItdsb8tXUG34EDTRRkjwPIqiIKqvhFSra3RBmXAs+TbwM0e4IyJOhuwKJBHrQm18zyDpkCPxfMg5sIZvTad4CV7h5rb6Mz+uz3pF+uYwDnQkUiivvSEMi5CXLMyjwfhaF0hAD3zTsJ378YNeQZYF6iJ5ZaLgtbmqTmTV7VtOp6A/mdeDgWfN7L7KSf8vmWGZGJVzMA6Xsb3rgxD2kRE6YaoZskkUii+UtMRIfBR9497o+uu785NrT6ff83hphIGk5zMRjgz3TCzJ8SF0/6MWaUAXrN1K6O+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVYsOiWFMcykFDuOByyZ0ITVxyXF2Jr6xdqxlzJra2c=;
 b=azRFUAKN2eiNDkLiPDfvecsUIDts828rz6Kei01Fp7r+DEJ+g1p+FuiNTkV8YwhsW7iYJosLXjgKlcu9g+3X79T2g6L+iqxX1l6uw2CLofmiGTNjyMJsoBxgeIi60kwkNp4zhqtpfHvN5xTza0/i+rrO070vyNjeidCyaPHh+NfLeXB1E8p0sj1M74Sgu3Uwog+QZYRlxdHqNQRI/FisxLiDEtF7u0EVXk2r0kqZLaW72cGCqpCA8J02aqql8H0zrUd308exsAz5xCq3i5zKFN2HEUHu8Qqa/dL+BeQpZYFYY7pCiLyreKv8krL/YW0vTy1j5Xu2iS4m08QFjg/AXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVYsOiWFMcykFDuOByyZ0ITVxyXF2Jr6xdqxlzJra2c=;
 b=y8oj/EAqET/pxO861qxTkpL89SjiFS+5B2kR5z+KJPUfTYAduTxtbRitsal5aMkvyVh4XyPzDjhwWXu6uVm7kjunw009aEB+T9yt3bE5NNOlP6VCDBeEd0QqWUJ3Ovw9DaixNHkLTY/6Cf9L21M6lp+G8MH9TeRruRGRAPy+o98=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7761.namprd10.prod.outlook.com (2603:10b6:610:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 19:26:42 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:41 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH v7 17/21] mm/mmap: Use vms accounted pages in mmap_region()
Date: Thu, 22 Aug 2024 15:25:39 -0400
Message-ID: <20240822192543.3359552-18-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0332.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::6) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: e3695565-e080-47fc-95f4-08dcc2e059f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?URcT6e/SAVD7Lad5bSOqLIRNxajJ0cAXHFCVm6J320bEOGtMA8qK2G/TpJRz?=
 =?us-ascii?Q?kuVgU+u9DbZSWWxgyKkZpsHR4xqi7G4ByhlRBQq9kxPWmQSOWNYcoPf71tde?=
 =?us-ascii?Q?x/SuJ9t3jF0mTmEWdaKWcbAtpBeZ5hIBPuDlURItIOU9iCpxvzBjdaWSTnkP?=
 =?us-ascii?Q?HrybBRu2ENMi1quULEsQIZmfHuCH+gvgvw+HGjr8ytgmrGIhTimiJ+MZHzAG?=
 =?us-ascii?Q?hpmgAmYfVV9nEp54V7DN38scbzonz8AN0z4Q3GQgmsH2OHY73sgow+rIIQZ4?=
 =?us-ascii?Q?gGJFYzQEWR0nZUjGW2YYD9gwXhjKG6BJcd8JiMY7dn7sgPEcD2KE1di7lbP4?=
 =?us-ascii?Q?ctH6C3tvZEu43+b1duOl4+JSG1chzMlng22/CsJDTvn0epxI5kM5pmGQb7OW?=
 =?us-ascii?Q?MaX1EMp7xrEEbzTgwb6L8+3RRblerB0JKR620euhnyRlmMovLa1P/XXnGz5D?=
 =?us-ascii?Q?UpQjHQnTr9B+OtIZtmNAuZcftXZahHIrikBuQmHuYd7gAu9pkDupuDjMRWAY?=
 =?us-ascii?Q?jejH/AwM81+08Dr6ZssMfsY/Pk1L5oPxiB0JJGDfGOfXNGZavppa7y10O1S1?=
 =?us-ascii?Q?n+OHvunodkzTzpl9akroIGKcL/JS4EGct3WaF7E/IwVQSZCFkMAk8VBNF4hG?=
 =?us-ascii?Q?kZzrbqy3QLrxJgRLyJMepeYI8dei7ZxO4MzqPoSb41WK93hDdjolTQoeoM9J?=
 =?us-ascii?Q?+0wUTSLdFOvHxPZNzezCqc9dq6vfiLBzHyxLl/gdW0Qtq9TuFWGXF6tqxXsp?=
 =?us-ascii?Q?LYncfI4yXheJIbExth3bePM78Wuc0tV+bTQj1yn90PiwE1BsV6GrBIqyAQjL?=
 =?us-ascii?Q?yESf8t1o9Y+/J4O0NclRO+9vHwJCs2xDVBmb2UY2pbwf8X5C+101nY4lGr1P?=
 =?us-ascii?Q?coy/I4S14Ileitc1gsELFgRNHOL6h+E5DRzHXl2C6mfluC38hxTKU+aq8c3c?=
 =?us-ascii?Q?Mrd1Hxqkete7/e36llXd0nxvyH+LrFUx+O5NB+NnrZWMQZUMWo57DJw/TMbM?=
 =?us-ascii?Q?QLhx6lLTu8zin8Jlm+DQCpzRU16oJ7iP1DOW6urwxxKZYhLGs+q3qakdv5UJ?=
 =?us-ascii?Q?fAkWiUSqlDJiZsChFcYfVVaahPy6eHrHGaIVcTuCmJR1aOqZD2fSF6HUsO5k?=
 =?us-ascii?Q?mGGB2a+A7FK4pSO0sbZOzAzd9WLazAi/tNEW/YurJxgNTaBBZ2Ijn3m/QW8Z?=
 =?us-ascii?Q?KhdJ7R2LfM0bxmqD07/9bTdBoHHlsGxddzY6ctUFSxwFrql/2CxqgxpAmJ7h?=
 =?us-ascii?Q?UKyuqO9UDKcvIQZsHcDWCUnTsDqwyh8xmy/iuXweDUa/xGzP19qqZ3FoSGBF?=
 =?us-ascii?Q?61WT1YpdLVFBxX70Odlowcw64sFf/Amr8iKk6fNmnH0qdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GxXykM97A893j/ki0bZbOeLVBw6pKvnMoULzeryQIn8EBKqYFXynK9st7CIT?=
 =?us-ascii?Q?1/XeZJ63X4vxEYOqDJEdh0oLJ2wp709sjyZ9FeZpwcWq4a+PNRfZPGMIiwNd?=
 =?us-ascii?Q?mhXnkPoqpLJmAfMzZF5mro6/pZf8fZrp85Ww7P8T997OwO567fBlrf2HnP1D?=
 =?us-ascii?Q?dR5RfU/QjErRGGMoE8itzvs1uf4zGXbetEV72rvwzeeH28wn95lLUpu51+dV?=
 =?us-ascii?Q?BicUiHFO+quNwDQvjPKnrL/AkDWY/0G/7YsSuVt7I3EQkL+x8216uy0pk6WF?=
 =?us-ascii?Q?ajy9rNsJ6p9hpwoOqjJ4E2dY316rINqhiLrByOPMUzBUdQllwui2Xlu5kaTp?=
 =?us-ascii?Q?pwgK4LE4zCQhOOMEvpJqOy7OPFWfbATf+OgkdJodHHnQk/xF96fF5o7O9zNY?=
 =?us-ascii?Q?nfGcsNfI/kteLfPjOcwHHh5xR787evQmUfCfBeIXoe48gOd0EHX9IZqOnCIE?=
 =?us-ascii?Q?v16VS8usqnjf/1cq58aimpVdNqIRFgMTr5Nd7Tqnd2vXbbrQR41bh9q5Y024?=
 =?us-ascii?Q?xK0niXE06yqKXX++rrbs6kWL39EmmQMAVfaFe7Vfzm6+WdzcsKWAW/WYiayz?=
 =?us-ascii?Q?AohOV3uB17s4hiR8u5r5DI6wWAHCDoyuGhox0YhygtFvUw3aYDuHj8sbMBxK?=
 =?us-ascii?Q?aLjAaw0bjOCEThoVhiY4QJgbnblsYr4GbgAyuWaXhUbmRDoOKGJG5NKBTGew?=
 =?us-ascii?Q?qSRMYBVK+bH5cuZZhY7zYrHUZ2nIqkU1fluyxbqZcRdHOYLj+dap+3aMAnyj?=
 =?us-ascii?Q?Tt1Murk/s6D+bujnFwEAyHfPvjzbKDKyw0ccaU/zKWAWWW4uwX5rg29lc3fH?=
 =?us-ascii?Q?+VZOvHuelQ9Rb+afPNl2rtlPL7Tg7Py5GhDog3H6XA5UsmeGNI93O/abPmgf?=
 =?us-ascii?Q?07cH/JijXHuEHwf1ejIcP5edbHk1KHISSjedXlCZKHEUG5eFw2S5d9a6pH/H?=
 =?us-ascii?Q?p8ZHVppSpqo4mDUxaxlLcsqtLyNh5bBA16QaHfyuFIB218oFGuQGLpt6/bW3?=
 =?us-ascii?Q?w42AClHYsL5HhqOT/LMOOmC60N3ZRriAdDDW13nWtQnrUm65Cp2CWOGpgnI7?=
 =?us-ascii?Q?7rLUyKtMFV+gYA2u5xWDgzNkKdkeHTEgXL/jxx3nKsXNhxGVm/2tSLA12wcd?=
 =?us-ascii?Q?ohw8nB3fFZdR12D2aWFmqjuniM54X3rVdl6AJZ/GUtS+kD/SomGCo5Ksrfmw?=
 =?us-ascii?Q?rLtJoXcD4zrHMzUr2X0GzXJ/3j/aFGHqw9GyNkRgcbPdabumaB+DepRTRkUM?=
 =?us-ascii?Q?4D8vcERK0azR4xYJR6BMw5gvYtgzcNEPk869QM1yJqWV6dufZ9/09Ql7y0wt?=
 =?us-ascii?Q?JbbUfXGKPJnG38jEZbdHw6gFUIrzpS/uG3T8gM7IhcRypf9pXiYA4g3FZvGv?=
 =?us-ascii?Q?rmTSg47jqLFUAprvRTCoUjRnbUQHyHXx1Gsz1MWPo0WpzMXTUSp8pluFzWfW?=
 =?us-ascii?Q?oTextj+XzGIn6ne5bY2McdPN/t5I3+HEsH97kIGAuCxvSHwIKMkDsva3lm7i?=
 =?us-ascii?Q?BiRP0uw9G9oheKYBaWRVB+mqUBF38lE+lGwUD7tFHZw3m2ksf3G5rHU3uDgG?=
 =?us-ascii?Q?adwQ5bB9wXPC+nqIqixJKfeWPwcTyz70yDChzqphY6S62wPtWlGmfJMAcJW/?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BYT82CrKXj6idFfUKVM4oeJ+gGL4MYmZ0Koy3jXqRZ9fnfwyTFxvfbAlUTz82EQ2xDEJqScVc0m3vt7bIhjVFu33b/cIg8RqZIas2jd53BDWlfnwDN53lVRlCv/2AcNqPRcakh4xIg3dRthySsGnbUnoW2RagB3KvtVWd3fULEafyBbvGk+8FDZpMoMlmKrADd89PCVJxoNlpgUT9E5cRmDAO1Dv3/KduR2VWKsXrDWhDjQRNg+YthAMo1DXMEAhl3kinU/DlSUp24524ltO5aD4n2k883ItJf5ErC4hcESssYkJkfVqxs9f5vmYDC2PJehuib6prptE4nrv1aZ1W2+/0WmTFTJCgyEd/AIJrPNJxjvrGSjVnn/gW38it4uurTRPDYDrYRgLPZaUYgnRKoi9D9PcrpgKLVD1ZccWR/W1g5PQsbNZFy0xGT0hUIm9esX9Uxov1w0enuQWX0tilMFVYMerCbB0z8TfuULOYq9i2kYn95NbYc2kKvXyiG7lLkMLSounN1EVn5q8L0nFsXTYDBcRLlL3WSQnBb4P6TuN4E0LrpXaK4248x43eBDpw0XYdZn034LMz/RLZ26RtxjHwlahvRmiVxbnYCn8EsY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3695565-e080-47fc-95f4-08dcc2e059f7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:41.9154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ljBBHeME+r/QmTipq5uY0Zw1qoeVjj+unGy/OA7tup74LJt4pSAVX/5IEG0b+s5TpiEhEerIs+VLyZpe9MInw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220146
X-Proofpoint-ORIG-GUID: wLnVLnmcQ6AXPqzwX6EZxXtDiRQHr5FG
X-Proofpoint-GUID: wLnVLnmcQ6AXPqzwX6EZxXtDiRQHr5FG

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Change from nr_pages variable to vms.nr_accounted for the charged pages
calculation.  This is necessary for a future patch.

This also avoids checking security_vm_enough_memory_mm() if the amount
of memory won't change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Kees Cook <kees@kernel.org>
Cc: linux-security-module@vger.kernel.org
Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Paul Moore <paul@paul-moore.com> (LSM)
---
 mm/mmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f8515126e435..aa4aa49f3b97 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1413,9 +1413,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 */
 	if (accountable_mapping(file, vm_flags)) {
 		charged = pglen;
-		charged -= nr_accounted;
-		if (security_vm_enough_memory_mm(mm, charged))
+		charged -= vms.nr_accounted;
+		if (charged && security_vm_enough_memory_mm(mm, charged))
 			goto abort_munmap;
+
 		vms.nr_accounted = 0;
 		vm_flags |= VM_ACCOUNT;
 	}
-- 
2.43.0

