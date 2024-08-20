Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7223D1D1748;
	Tue, 20 Aug 2024 23:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198322; cv=fail; b=e6eJ2cEcyKjA9nCkO/E4NbPWKNDfDXxyOlUj0QQnrrVd/W2bmw3jMXLyfWxQbl3j6UlrSDq6FCxIKItCwwQDzGKyhBqmPDh5xBWl6yF2eX/rIdeHCJrHfu83QgYiEQv61A9Lg0iwdASSIMUaaYQOG9B/DuRV5pK2WcOEf67ADBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198322; c=relaxed/simple;
	bh=PexCzeAeNy+iFqOQ2AW+h71bjdauzJ7RGGLPBBDPFpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LFcxg+VgKEWyBai6w/P4SOYvSxLwApFs+6gZ/U1s8qBHy8qped2FuUyP/uvxH5zNGzs3XkrL3tUDtbhSmOflXG9BbkYQBiLp+dxFxtY9glxFgy344+AfShv3cRSCYGBjR5ALvLrvXE2vA7VXf27Xz3Q1DBDr9NKoUlDpFccVMY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SPDSiMuB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PIzNBwH3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SPDSiMuB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PIzNBwH3"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBXLo032213;
	Tue, 20 Aug 2024 23:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=YdZVOBe/SNp5Gyamos6vbsGOr9rKM7FOBCFAvFJ838I=; b=
	SPDSiMuBVgmFyZ1IIa5G7NUixs114aVSUM5dFdjecLs4ZuAoyCI0ciHVUVF8J3/o
	yap0kVUd2dupyHSG/xxkhEfKMb6FCzDhJna3Z5KQsSvIq1f6oz3lfXa5DLmMrimX
	a44PIc7kwWPaIyIN/aKan2uA+tBN9qeWr70qjdBeVEU8duAvFIjyeeUir5wYBU+g
	faNaXLMw2FZYwUPfrHhB6QUXy/e+8oK9FfSUUBOWpFb8yb7ElXResUcasntIm9mE
	9oq4ckKJj66gf2EdM6Xhje2s7AEV/X5iya3Kq8gFaMZDnO0arzj/S5iO3aJUuWy7
	uUWbMbQ+38grf1EP+p3TNA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4uxbks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KNY1IO023382;
	Tue, 20 Aug 2024 23:58:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4154x78g2k-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:58:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaTl0iPLw7vGliZ/7FCuPPXs8x5ySunuuJMlJSZNpMV1u95CsjDGoTl9xvitaJZf0KXC9P1vHFDYC2JPzLX52taiUhJ55M0fdvLmtT6ASQyi0qp6MaQ796hQ5VDjM7aqmpxtVri0PM/5AbLiol9W84WsDEVMozvUCCOjUB+LT5Xycoy+Ixwp+9uGoRbLJjOV97sV+bSQNzpt5sB4divv+Hiv9boQKUvorpF3PbyVnZoNyfvOddaGibwHsckLzhn7/r45xVPekMLFLt48Q29nmbBt+PIbYE9gn0lJTTPvp/Q98m8+r5u7n4fbYiXuBU9NTBgno3yIAzNz9cLL0B3IPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YdZVOBe/SNp5Gyamos6vbsGOr9rKM7FOBCFAvFJ838I=;
 b=vOmFC0OeJSBsuEURv2gkwmuz3dhdXTZ5r/BWL2oYHtVHtb4Zw/LMo3Auhr1RAw/VoXKfGbi4uD3LkOcGRNmCkO1DxzGQJiilY8arI5uFDrAwtNIn2ToyKxK+MOiXnZdSQJTrd791gj0XJFrFbFeY8H/Y+H4Aak7l17kwpfCQXMEgRdQiIwv51sQQ54Ti3VXcOiYwU0x/3yrK5qGpre+R4lZJIZ3ZQHxLSF94+6Pes2T6n0i79apOivDDP32ONYptxZg65OgUvSUhkRbpRnl4ijThUXkVfL2vHoMA8IcyC/rnsis1w+CoY9s698GQadsbjv5Y74TgzdGm+eGio1MASw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdZVOBe/SNp5Gyamos6vbsGOr9rKM7FOBCFAvFJ838I=;
 b=PIzNBwH3yo+MMFouS+WbdBsRIMZCxZ8fp/rC7c8nSgAlF2S5/JgjN7AWyV5BnfXpQBGEr6uMTzscstO7FIUDBMu7h7TSYe+Z5J9CrVnC4jFLfp3hDo8givgMANnPLZg8M4zwEIeoH0bsvRcpP9J2R1ZfHmKaGsyW3peaBx64Yho=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 23:58:18 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:58:18 +0000
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
        linux-security-module@vger.kernel.org
Subject: [PATCH v6 17/20] mm/mmap: Use vms accounted pages in mmap_region()
Date: Tue, 20 Aug 2024 19:57:26 -0400
Message-ID: <20240820235730.2852400-18-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0360.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 2193816c-a38a-4e79-1918-08dcc173f6b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ugGUhwENs7VZ9v5D1QMnsLcJLeiWIggF0i2Usfsw8eKN09fnAJk7G0gniWkA?=
 =?us-ascii?Q?+YXDci4OtdBVkK3LJSugKmdEZGnRz7N39HQW1ynm81mVZFBjbrfP5mnZo9xH?=
 =?us-ascii?Q?n99lA3Vkq2Q4yIpf5T0qEu7TW+23sxiz37gRAAl1TyQpCPwSVSuXAlv1l8de?=
 =?us-ascii?Q?n6n5FJCuG3fLqXXoPgyNjvpVPvEAmo+l31aI6Roa57R5kkA4qSAtotflgoOw?=
 =?us-ascii?Q?6sHhgG+vl6puckbQxxqFYB5YFhfhgoC4LyXNIex7yuJe9CwApvpTp3eN5/uV?=
 =?us-ascii?Q?b60nFyCkVfA8y5VEm0Psan7Mqw6FMpc+GYEDmn6mG2A0xVUtXwlb5Pc2akxF?=
 =?us-ascii?Q?17jusaK4rTnIgd4GDskP2yx5J2EamhYXeHRBz3Hlsml0ZVRkSrYvb7zCCbL8?=
 =?us-ascii?Q?DzoEp981AjUdHyaiqsqJFS6eEOQYydC+eEcW76XIob16MYU6a5O+nMcQf4K5?=
 =?us-ascii?Q?r1jupw+y5XDnKGf52INU2OBxFtPcjXcm9dmwu+WsgOL0om8KrF0KpV3/fCBx?=
 =?us-ascii?Q?JFkSRReXeHxOB0XhiwpXv2Dts3mCLIRbD2Nce4wMtJ551Na8o8dGTvuNbxLN?=
 =?us-ascii?Q?w4gtpDQPN6s5jgXNmzR42GJ6PWX4qUmJ1EyCRWSZuA7EzEgHIxOD3nIfNDRg?=
 =?us-ascii?Q?AMZ2yOvJwefDV9oAkrmI+gI6njjebz/S/X2EozaCv0/02onDPDMZoVJZFIjW?=
 =?us-ascii?Q?5itxmkKLLQxvrOeofTTaif198HoySwzsM8lRaa6zD+FyjLBHURhx717tmzpe?=
 =?us-ascii?Q?IWl1Juj9ESaYP1zxqx6A/88le369qU3ylJ/5pJLvbUd9KMhYZ2d9AWRNb41e?=
 =?us-ascii?Q?2PMMX9SBa7wBLvJYnFon2oAP6cbrw0PC+N0NzNY/tYp4CtX1dWZEV+zbFh1n?=
 =?us-ascii?Q?wUJOlkoBTb1o3siuvjH02Hn4jITmFbp338YwdHkh/GpvELFzjcliR751WTt0?=
 =?us-ascii?Q?FIJ5iyNVo1ieFz9uKH1nkSGPHnuD3mIubwaNeORsqBDydUNe3kVKBwBXSEVH?=
 =?us-ascii?Q?5jh1xYjQCYuAt1FG8Xda1Z1Lpk77ggDuTQEKueYNy0oElrw57Gf+XgszmD43?=
 =?us-ascii?Q?9rmD5gnK2vLmcTBPwZt2T9ERXT5d/rU7sSSBD37dT0/jPv6CexiNqy0bDxME?=
 =?us-ascii?Q?pi49oA0aWx0nvh8kBUOWyt+AjryuJc/05YTG0txDBHHm0UAmG6UqdZy9pXN7?=
 =?us-ascii?Q?hScsbD2n5tPs8Mj3gwDz0gS371z4yh4wiWAutAkgjx8gRvLDZpc5RpCnk3WJ?=
 =?us-ascii?Q?uxKoxauOCFTTWmWIfMZfAmcgTFFSljKUAaFFTRytDgnf1N2UntMw94QB4Zqc?=
 =?us-ascii?Q?yRq5Qe5mUz41PaFww6VWmrkADnbfdvFoQZFb5kswYdZuuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TacRV8UCP5dQNxg0Rg4XsDdZZzT5pKWsiEQzggnVT+HZIsSkIwmpPhATT0Xg?=
 =?us-ascii?Q?+Un8p/SXWRh8WcgW0CIBMgqaUsXRHgH6GiLs2Nq3gWam31/X7MW60KpeGz8L?=
 =?us-ascii?Q?6f7JXcGUqUiI1ZD5LrKP8RTKO8Or82HNXPuB6/P1WiVaWokMdTsGSyExcgKY?=
 =?us-ascii?Q?2ywXC5pcM/Qry/mTrhGmMoSC2YbEQZwFlvHDwTtdIc0Pa58BpFLU4S1gASgn?=
 =?us-ascii?Q?6mnOGxwFh0cQJ6AczpkyERcZr5aCjiTMla07Cm6TBH2jlxIlWea5R7UTy6cT?=
 =?us-ascii?Q?jhAWrqIs9KozL6V/U9uwZH8Crzd/3CuP/juo9/5NxNkCfw29Mk+jrpGsaK7h?=
 =?us-ascii?Q?KcnRFYqqEm8Z9ErZeQNNQNoRhr+b+vCaMHwuR4oOU/fBqwZeBq3zTMawltgQ?=
 =?us-ascii?Q?xbG2KRLprCiZLtT5c5Wz/qF+QGUr+Aoq6+XfVryW8sC6L0Bcpg2T9SnFLSPS?=
 =?us-ascii?Q?JoUOwq2Vc2IxFJwc7p/04ukNAf8uHMDAUo7g9iZfJXPAxlxl0eveYGHyGfGr?=
 =?us-ascii?Q?YPlTs7xvE12sNfHDnrKyEMhHPdrl4JjAfWgI836tSMfjQyi1/XTurA2gQ1do?=
 =?us-ascii?Q?6fKmycAod+7OJUt17f/FP58uDp70+x48ck+ofEO5OVOFRc+gIKBfQab7z7+1?=
 =?us-ascii?Q?5P8V5Kx1GQ+/djXI+LBH7HexqFDhBYXgEFBDhQxovny2bll/jnf14KT7Oi6W?=
 =?us-ascii?Q?ZhZ+dTkTPYKj4rz1gfNi+qt/MpzKiMtXxTeva31gweLaphjAkfeIRNCYpM2h?=
 =?us-ascii?Q?oANIYPWGtTQ/uewPbMtp+n+obDx//oiednZCsQmTe4P8BcB8MH75sucwiC5+?=
 =?us-ascii?Q?cslouUQK2w02MGH1veJjdOy1KsFAb6ulW09KUu5iJXTIpfN47VnvO3b3DOxH?=
 =?us-ascii?Q?lDw8c4Shg30i/Zsob6XO4qNHnyDM9ABm2Z8gvczVIaGeBWgyCkzAZmquFMeD?=
 =?us-ascii?Q?nsZmtboKsrkHbIFn+NLEyI0p38mcr5CAu2ysUJ9bl9cgQcGt88W2syM0uosm?=
 =?us-ascii?Q?O0LQImuXPE+pG1uVgJeX1JUc5b2Zlj0rDQI1AaLO2ZukMakrC37Ievyt4o8P?=
 =?us-ascii?Q?wHVCvGAiufj86in33MkGoL7/mFFvTFIYXyi6H+8BCevXv2n0KKGrpAgbFUNI?=
 =?us-ascii?Q?2Pce8u0j8ybLtVzNMtXIN13lB6GLeYp1Z1Tb3zglNNkFoydFCT+lZJ98Aqu+?=
 =?us-ascii?Q?gfgu3GWcY3wYT1yCRlyiAAs8HE//KObLt26UtmM1BUHVPSmguw7AaQZLFgFU?=
 =?us-ascii?Q?9nrFqXbNdWPo628lR7OWInzvWqDjZjBCaTjY0WjciH70P5L4UBbA5OGmD0dO?=
 =?us-ascii?Q?KLj/rbBhrd/81oJ+a9+wHB0AbymxFeKbM1cJ0u3Q5efZ0+15qr7+1/xmM7jg?=
 =?us-ascii?Q?Vn96h5v/GOGG8lF8MyW0N03h2lGBrYvJY5QrIz9JR93i4T80aAmxCFaPcoyt?=
 =?us-ascii?Q?WDdL8ynwoy0z3RjaeDyEZx4pv2s+DTn6m+GNZiUpJn5YmzbSBgoYSw9V1PVM?=
 =?us-ascii?Q?qBBXuo5Xp2214XS3S8WmQ5Hd576SBll7BhRftzPVyolh3zNDi6rM4vUZseNe?=
 =?us-ascii?Q?pOvYlTDYRGrEMhQ18ucum80KrbjheuaB+3TyY1KYZwrwHWr2UY+J4upGMPTL?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0znNVfVx2+edekKECh5vd/FQ32lUrovxkBQLOk9Ox9pX3EZkhdmw6F4cfNL0gny84CKvwYTxN9FBHinvpBj+ju7+WN+YOWFexyJhOBjHlatHxaZsukXmSQmk1EUTbg+6xRI28xG+bJGV0qUmvCIPVuyUR+/hEBl9tlNXuCNVNKVmQuhANpeAdZyb+ah+SOoWOACcqBcP6o8IgQToDwF4fHkrzWhRl8EpkoPfBPz7LFtdg41i2Dqaoyfr5zRU7nh6QM+6n9WtQR+iJfhyL9/oHa5vXNTfkBAAWFaU1p093q3oXaSn4/t29zaMWZmZmXwuX0Ejg4RNktncrJCkJrBoJKDjw5pNOlO2wG0ixTMM3UfXN23p34DGHtaEe2JYpOaknPcEKzW+KKNjXRUFk2OJXjywOrIZHkRyqErW6rEaDVyhfUcI3xby8hjlNwFS6pti2GNQT/EnVRh6ko+NVlU1an6tC2QoUKsoGVkjlXiUOC9//db/rO5jRRdG9kki0pnSKPfdAaQUD1zxcUIvPYdhBkYpLpCrDYISc/L7oX0RPkHttrU3veU8IcznW59tZp+D5A2U4WIvFqi5VNsqmx7uKfl7WuNcE5e6LcEL3lKqR88=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2193816c-a38a-4e79-1918-08dcc173f6b8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:58:18.5569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Jj2PIDkCJD4oWjXiw9tY3lMwC/PRFLQhmHvo6ei71lPhmto05fKv+GIhF99984VGHU2DNGJfQryRavaVBhryQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408200176
X-Proofpoint-ORIG-GUID: ygTRTKSU41nIUsQshqcdOFq9RGQOWhFt
X-Proofpoint-GUID: ygTRTKSU41nIUsQshqcdOFq9RGQOWhFt

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
 mm/mmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 19dac138f913..2a4f1df96f94 100644
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

