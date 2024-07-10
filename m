Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEE8198A1B;
	Wed, 10 Jul 2024 19:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639431; cv=fail; b=krowT7/8oqwq2g5bwVGnBHUKCsAZ0SU5GxeqyymUgT/53a27Nq74AvnnVZ/I2bE/E2Nqw8RCouAZ38jLIpz/gMAZawI+jLZ6zCPJd1SH3Vu0MfFm1OmBXPIDY5DgHf9Rx0FYO6joovcTPMm5mC37yt3ahGslZ7Zwn2x8J2xK96g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639431; c=relaxed/simple;
	bh=YwY1zkc1oscs+TnW8wPuI/eV4dLBt2NjOq5Fl54QhCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jPadSJ/DvSzLuP5GU7MUktWaTmb21GKtvI2B4Z/9vH27SDFWUZt4gFJNjwVNrrJqQmlusG0grOpqVydHnRgXzwowby589+xZEI67ucmQhBnYOLOTo/JkaHRd5cMdsHpXp67+yKTqS88fIGR2Hu+tI41sHdLRYVXoGxR3nKzBVVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mYnAFHUx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T3v2a1ic; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mYnAFHUx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T3v2a1ic"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AFu887003975;
	Wed, 10 Jul 2024 19:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=CVCfL5gmp1gv9bRyInG7BLU6ZsYmKEMst6LlVCnlESE=; b=
	mYnAFHUx0rfrEfIVUXMEqY9aryw/PgVRYQHpuTErDtZ4o4V/u4XSJP3SlrD//mUo
	sTm2JiCm8chRU98Tz3fichWrEHROHSzHkX9gpra2vknC4Se8c92zHJPS3mhRreC/
	QrHgN5CGftzWuXVEoZrqpZX4j1t47A8Hyp/hE5R152UxHGHoU2aZHb67VdwI1uK/
	RGiL91PFpXvNgl+E0oXS7ViDWme7jlDL6R/v7FOWBc1awe6olCO8/FYKMtYOvdeU
	GSYnae6JmLyUHqzjgeaD/3/9BoVMz4PMgIc1FD6PTwifHYCt+Rrh1KDFupxCLd54
	/WvxzMn+2JYwTpHoeFjo/g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfsr24h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AInZer030164;
	Wed, 10 Jul 2024 19:23:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vva93av-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwBqTZn+m5qnhTVD/dBDI5HXMnai3rnYoyYEEoLpjbH5fuxyymFCb8r6pxAkSrVRuUB2lJW4IujuxE0WtlNsmbiHGAU2meizbcMUFFYtQ5jtCS5CXKf3lSHQJoP4qkIgi0IEwZcJy++4AQVP83WpG05aSmkZ3hJe4ZRelA6iYBAo1oBmWT7U9Wf428XEwT3X0+ONOr9yBdgxumccWBwqS+yUEXf7Hwif24KLPeQJlCEeST0d3C3FLFROAN7m7geloVlbWMH5Nbow3W171lUCbBVlR2TtCXMkDVEVbrr7P82sjB5x31fC77WhFpqy0rhNJPyzfbb4KXJzifufbcEeHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVCfL5gmp1gv9bRyInG7BLU6ZsYmKEMst6LlVCnlESE=;
 b=ijcvWHVas7ocI5kuAn1ZKY1CrHpJwzS6XpBmeteHvs80bW/88EtYV0NSgrmP1F+2ZbParOQd5YzYsilhIGXP0Sq5p/aRLzfEm2yh8Mlhyz3sLsab+V/gS7inMW8VX99H8f55fZj66ZpjnZBlRLd4Lr4FxAVFqPsrAGxUUVBa1xjbG0Lc84cQmd8MtQOcuoCjndhg6gGfupdABWfmMCU+P8PIhcyg0kmNRVt7OnjfHX171gw0r+aJy40TvAG4U35gkGWPZQFYL2vowwZ4DgfEChW5MiRKxV2XcgCh0j8ikau839MO8ZIvef4UM/WeeMcPjfBJsYdN9Cu9tS24YkfB1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVCfL5gmp1gv9bRyInG7BLU6ZsYmKEMst6LlVCnlESE=;
 b=T3v2a1icJ7KLzBTByrsC/YDeOxr5B/mO67+VQQ8LFK18aod8MFiMjZebzSV8MCk2Lpo0e5IDJ4+YznYI0/+95eAeVx4oOKWp+8J8DC8EwkQD+uBpBu4S0BsbypCguwEVUAErZTpsNIbQpjY/kDNH6I/sdNj+rrPbV0YxVcQeb2A=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB6106.namprd10.prod.outlook.com (2603:10b6:510:1fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:23:31 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:23:31 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        linux-security-module@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v4 16/21] mm/mmap: Use vms accounted pages in mmap_region()
Date: Wed, 10 Jul 2024 15:22:45 -0400
Message-ID: <20240710192250.4114783-17-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::30) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6a71df-74cc-42a1-08bd-08dca115c8c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZUkoAsnTo6Ct97bBG1RuJUZ9NPWUtnsApVKZnjv+/g1Ot7TJyB1/eu4yOY97?=
 =?us-ascii?Q?4ESYwmlKcrzk3T5uvXMv+tqHfgBVK2/5RaccWOgzzSY603qqazLKNPysktY7?=
 =?us-ascii?Q?cjKZf5mRug7he9TpWyZSB3odqi4Uk9xfvtEn3fdUwF+fi7p1oSy2POChqVVD?=
 =?us-ascii?Q?6Y73kVpwY+vouFR3/uxjkvO1i8n3zVban/4Mrutw1/IiFvAR1iiHkUd3vST/?=
 =?us-ascii?Q?/sq6kr/w/d2CB3NBqH8ABTe4nBOS2MIUSBC8LUlpDrot5+83rfTu4lvgvzS5?=
 =?us-ascii?Q?b1FDJ0n8uohpWnBcq5uR6Ywj0qXHg12IhD/wcX9M5+O5V3Uqoy2G9Pmskws+?=
 =?us-ascii?Q?bCtwgj626rzWJ5MzVnuN3J0wL214uSq4/mgBvgqwPWa9haPz99q9kUWO2LgO?=
 =?us-ascii?Q?jpZmErOJk/6Vueac97RJMTHo1+g1omvsQ11XpxbQSoPDf7tvvdwswn7qBw3E?=
 =?us-ascii?Q?zlXhiYCLmAU1bVcWB53Q5A+eygv9amzAJIp5eZBspWFbMsTUSPVTmObPFjBQ?=
 =?us-ascii?Q?X6sFd6ZUM+sUAmE8mQ6bOlDtIu2SlL8SwHMkNtJ9Fy+BoJEAOsWzMRfT7l9f?=
 =?us-ascii?Q?kgtgY7ZaFGnbm8cXLmgxwUsMTw1tWU73S7MjaIbovehNgkKGRxD7tcipkVww?=
 =?us-ascii?Q?3sxKR+LsUleciR+cfS1r2WfbIjkTFkmmqWy841HqKf/yWNakNAPOVhYnGaT/?=
 =?us-ascii?Q?kdjhvDt/gayXR3ULUZ7t9FQzE7YsSXlVIQhNzjvTACB5B61c5mMQVCyVliLc?=
 =?us-ascii?Q?HGeHeBuvednRP2OdWWK+EGFdwXlYNcVjP2zYtWdwFQH+Tm85hp0scH2NPndd?=
 =?us-ascii?Q?b0r/+oxEgk6lm93EY2TEWG9JPzNJo8wKiR51CX+0JlFlU/ATJNzpBqzzfNTq?=
 =?us-ascii?Q?+1rAoOPS+gBZ9/odeDhlB3LfZ2/MRhLUC1bV1OpbeivSsct0K+sJpkVsO5/j?=
 =?us-ascii?Q?v013SW/oKOkfD8j1CREBI0h5CMdSrzhLWwdBF1Xxu9wrZH5wMLBDPL07yLvN?=
 =?us-ascii?Q?nXmxn1vlSJ4H4+ScRgABEk1jtjOOBBD3AA5a8H7HVa4OWjPGQtWfJGYnQgZ+?=
 =?us-ascii?Q?otWKjcSiDqFxNhHr4UuQinayBT0c3DSDmEenLn564AlUuAm9ro9SzlruH3gH?=
 =?us-ascii?Q?qwt5KTN/nlCa+8CVNQS69lOZ0jzgZKO1gWdbUCrfGS5G0JZ8YwqIo8iIB/LS?=
 =?us-ascii?Q?sOyeiyJGs90sVkXKKGvdx1I0yuzbi2pqohfRHkoAG40Reb3l4yLrBiQVOk8g?=
 =?us-ascii?Q?JhuTlZW2Eucp7lys3bwTlanPbsSip7RnypeP+16VVTJetKBw0pXNKG43+EKO?=
 =?us-ascii?Q?dItUWw7MjNXenI6WSo07XJehtCffb6S9o+VQRGjBVLyWWQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?15IOkixtVaHnCkrzOGKmIuDfFEXj9u1Ub3fJQ30OE8uYxXJg2HyvCPwoSFue?=
 =?us-ascii?Q?Bk45PMlBtaUYLsv9/hhSwI/aLiGLGUgCpH59m8eFgF0uGqE+dp+0mXSJ8WbI?=
 =?us-ascii?Q?mslvDXox/mijYhQZ0sgrLNTzWs/eejw6E/TUoGXR2lv5BAPkxuUkPJldYRVI?=
 =?us-ascii?Q?WAMeXQaUynRt9asP3HK6eXN078bUehA63OJ25hLrj5HwDpXIbv/FNPxCUs2B?=
 =?us-ascii?Q?gGEx6iSLhtD//0z/2HSasChqyB7BHOxN/Vmfg9wlo9N7l4GJ8UNs1vThEJaq?=
 =?us-ascii?Q?qJ4N665RknQd1l1ZNavY8MkQwhqrEaMYQnt6ZQTcVqQzaoimqGMLCppeyazY?=
 =?us-ascii?Q?PMlJzOdHUSHkODTd0PySKoQPZjON541xGrrUbbrXGZ3qksiUDR0tTX4vTyHW?=
 =?us-ascii?Q?dakMSqQauc2kH+aiRcgBnDs2jIO7cHf+gfKv7cp4FxLIz9OGGeWGGmZvk/CI?=
 =?us-ascii?Q?atrqcjfPBgNjJpRsPlVDi13rehH3b4MTOMRY+HFZfhSvwu3BvJY3euTlXgrG?=
 =?us-ascii?Q?YfaSIduYKMLCu1+tY8hJ+espHBklIzz7foHuD+Vh+vQVo3jUl3TTRR/cfLpL?=
 =?us-ascii?Q?Y7Q7tdmBottHBACabsHe/msvW46qDXPAiNgDvbWFYvePtXxwlQ554xMgAo7j?=
 =?us-ascii?Q?eKmZEHy5Z9wMJK9jhjLkvRh2Rd5aj3T+icucgBQkf9sOHVGuHQyHjkvbnkrU?=
 =?us-ascii?Q?fV2pFblAWdgzKMQZEGpLTd22M0GY5YFp9m7v3GRYUkId0JRemQHzl/jrZBXg?=
 =?us-ascii?Q?s8H28/IIrbJZsmZexLdunKvKwbpT45I93kKt3G/qEIYiCyih2I7BEGspO65R?=
 =?us-ascii?Q?5CyBO7OhLAbdSRSxIGnxHDjLoT7130J2Pb2Cc2BG7VtIZ/a3XXM/IbsPQf/2?=
 =?us-ascii?Q?2ZWgBAKoA1hAgVZyXqdORD8xv6pnuhCzMG8/3zX6q81O8CwFRP9tZO59vWTu?=
 =?us-ascii?Q?hAZLaVcMy6jxlfOC95eXuhT6qzkLf0ZqpV47yPLZmo18D8ZDmRZYLYQg3Vqb?=
 =?us-ascii?Q?KHGRTwtY+uEjGbsqnhkpGILtqfQpjjDDHqUjKPt1vaeLqScJ+9E3afD3OhUI?=
 =?us-ascii?Q?B54E0vvi/7aWhitBQ9o7XXR7q06q2JaWul+5i3Z8/LibCwGgD9PsFjBramaD?=
 =?us-ascii?Q?vkk1StZBB/izR7bI4nudayjNwqbrw6PoKIZredHjDmlQbCoa2ComGKM/5o55?=
 =?us-ascii?Q?/CcVnFpS9WPPgt6ZgjWG07X9LbGTZsGha4hXkOcuSaaWqD5n8y3vMzOucuFn?=
 =?us-ascii?Q?UCu3ywXHf2cKhXUvo8JagdOqipjXULSjvaRSWYR2A4kXyFz/WQTqH2BTl9w8?=
 =?us-ascii?Q?tlDpdOsWiqvTp7nYfFs/W+zBMWiL41Q3PKcTC+sJejcH8lVjHuVXNK5WrRw8?=
 =?us-ascii?Q?Ul3C28lQVPnd7wWCTwq6reNMjY7ye1OoXxDFGDkTt120ZSSGfC/DqoFPGeZ9?=
 =?us-ascii?Q?jL+4/FcjQMambhIgaVgYsVfMcaPL2qgX+ytN+vo29Mgj7JrtKp1fcoHiKBvH?=
 =?us-ascii?Q?zT3qNGGsXL8QEfy1AHKq+/+jwfAWqlcEa4nnn78XhR/ObH3I0iljzQRH0s7h?=
 =?us-ascii?Q?m3SN6THs30hcQyjWRrSYbmnly3YCWC/HIAr4ip3cdV3rvPpErxM6yVlCYeGH?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KeMuWjhPsGyQmZhg8eCvQ+pJbrPMWlfGC3eXo/+lavIaFQajGPGOVZO6c2BBu/sil6KDwnE6Yv+Kakkm3vGavuFVBlgWEbrF8AFgVtjo3DS1YqtqLI22ezONYMjVwrfifOb+Eez8DiRnU4WJ80TBFXkGRliHJea5yvBK+CHo0NmKDvKKIakh/SnkHZf1VLiPKKmk+H6p4caf6xRMy/iMSeYTG3RUjl7yH8ZvQLdoo+hpr7lQIPLd1CTCMDbnZaUCLaYPvG/jKnW+P4fU+6/IzVwEUD7qpwcnnagIuMgfcm1SvSs69JlA/wSCjeE4IpmH9/ehBIFvWfZcLOn5Ldp43Qy+kU1KxN6KMpzbN5Vuybtw9gBHUc0gJ9zRCmg8IoXLzCN5fvz3WqSekl43DAH3WTwUsXOTHKzXBp8+E6Sqsy3yBFv8OCZZxBcnHXhbMDI+BnGe3wiPAnZAJdoDd58I00RnibPbVa8BbepifsDMPzCJENhEKU+hTuD7bW8ZbUDeVjn71LFoBUhzPxa30aIzUxDKI+OgavcyQ/lDUwn7AGNJv6rsG+WlaM5IEoKZJ0eCH+8qEOBH14SDwJMFW4UDf456bcI87oJofZ25PEDj7TY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6a71df-74cc-42a1-08bd-08dca115c8c9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:23:31.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7R/XsiT7fn0RzkZZwg76yq65gUYLQ45ZQxlpmVhNAFQUk1P1KKV8ViNgnxgCjeVQ57VWGa9EC2U7S3fyPC8Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-ORIG-GUID: i7stoI1RQm3SiOycTbMtD3-1duiN5VZd
X-Proofpoint-GUID: i7stoI1RQm3SiOycTbMtD3-1duiN5VZd

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
---
 mm/mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e13f032fa69e..d5bd404893a8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2987,7 +2987,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		prev = vms.prev;
 		vma = NULL;
 	} else {
-		/* Minimal setup of vms */
 		next = vma_next(&vmi);
 		prev = vma_prev(&vmi);
 		if (prev)
@@ -2999,9 +2998,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
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

