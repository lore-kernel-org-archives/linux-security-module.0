Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F2A191F77;
	Wed, 17 Jul 2024 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721246889; cv=fail; b=bPX0RopbL+WWKM5/wrl88lMhYKps0a9i6S6BKwcg916Y24lTDtQe7ht90Joq4e7Wc/EptEE1dgANXbMs3bhUNKO8/fmnYNOerjUCxgMqCeSkK6FIM143ZLFmCrINM9Lu5gDyLESWHis/x+hPf3jakCEqQPc2r6sISN5CNWv29ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721246889; c=relaxed/simple;
	bh=5qMaW8IbpjTsguxhxxc6li1pOrBHANASz+3pOMZPGjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q7oXphWQH16/C4R4WBEsXoiHoVG4U9JLTcBmaYO3uP4kCFpEHsVtRmSBmfcup/OJ+JXuqzdhNwaCYRxbPl9Y7BofKCj7sDBnEdJWH+wXdNgaRmt4o4IvCTXeu2gCZ/WzoVjWlo79hKoDZE2+dEwcdQgjJEyzkBkbrfXGLau6Qso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fbcbr5Pg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iV0/F2gR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fbcbr5Pg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iV0/F2gR"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HK506K001775;
	Wed, 17 Jul 2024 20:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=MCbfSOiY26c0tug8tqf4PmH91ko+wJF0zouXoNIkQsY=; b=
	fbcbr5PgkKibnorf25EFp7YP1VgRx2+IcisNa1tOhzkpGfdp3g2qB5oN9IYljiNt
	/xXevkti+GUGbig9fNxm605fo1v57uryEIlw8pnGNxdVvNvw5P8vIy/GgDNcz49b
	xevGR5C3foGAplAT8jTFnBCi7g4vXrKIduGhhnfLFZ5u3ODfqOcTyX3ZKHv8aYGs
	K70QFk9F6rUl+s7n2Zn6j/y41qM9Os+F/xEjjMa2wEvlLEPEJq4YfMegNKlEsETi
	ZFzZRY36B9um4IQOlmP575cfFej2bUqMTEq3aYfSvQG68J9t+gqpKJ9W2ObVuzJG
	mMs6dDGKPomOAs0546tUng==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40emp5r08d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HJ4sqC003630;
	Wed, 17 Jul 2024 20:07:53 GMT
Received: from outbound.mail.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dweyhkte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 20:07:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isvng2+bqIeHvnXEkQjGv6omCKsHzE0pwv8YMikhufc27wzT8Bs5MttC1e56YQ56fAWzTgCCxJemYzorMWaO0aDIpEQ7cJY2cCXOGWSdR6vCjUkeQaEYXq6YBzibZxiS7G/FhmRtYzDnUx1duRESG+xoHVRKV2r1VBIZrMltC2M1bmqtaNebbw4wAuKoZFa+9iFR7C1h7VGr3bCO1220Jd1uOm1Bmo0HYPU32kezGwG6iX6hMnyYPLzqRGC0vI/2t1uUsbZRR9Gvt8kzfM/7Uu5X3p6/w+TgDuvbBhzdPomQjInppwLN6bQALMEsCDwXfJGGKTixxi1RXAeBhVarWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCbfSOiY26c0tug8tqf4PmH91ko+wJF0zouXoNIkQsY=;
 b=tiGj2uaxoL+JVuF3YBwvED8hYABrcR8ZeJQo3F4SdcIVNCWhCbGx2oAQfIfwzx0s9789Zz3mWmyVv2L+RtLDNGJFCJcCFBaqZ8tDxvP9dXSc1J6YeEciIhL57PzZEQOSUgbaaMYvYrsVjbFlHF3iSxcT21UxNNLZOlKXlj9neGAtsSdvSRobW1Ro/EHR3OSMlJCwhTwitJj/dHY21zRlmfo2F0XxuJ5AvJea4hq3I98m+cLiLupjZ2bTjzBPAHiTbZjLt12oY4Oc41EeA35bWPAlh8z4h5CCtCvjHzpXc56Mo7PRKUw4+O4/+Ys5QlLKJ1w7rtIFahqIa+YAUJLlMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCbfSOiY26c0tug8tqf4PmH91ko+wJF0zouXoNIkQsY=;
 b=iV0/F2gRQRAVbH66OCrIl1dJy98XxjJHGQbD1Ow2xptRKwvHW5S3g2lUOXHIOm0M/ZIhaxdt9cTpLTVs2YnzL6QzHT0t3MJRdHAIQ8MPnXMtrGn+WXoTrSIVrmneCTgusS3UGC3QkpGHl53EA/kbm41Z4s4mbQWMNkiv0/Wb2ro=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH7PR10MB7694.namprd10.prod.outlook.com (2603:10b6:510:2e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.15; Wed, 17 Jul
 2024 20:07:49 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 20:07:48 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        linux-security-module@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v5 16/21] mm/mmap: Use vms accounted pages in mmap_region()
Date: Wed, 17 Jul 2024 16:07:04 -0400
Message-ID: <20240717200709.1552558-17-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1P288CA0003.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::16)
 To DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH7PR10MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cc32298-6e7c-4f7a-3ad0-08dca69c213f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TAyRJDSWQDWgGC+3RxkdDK5lS91gdClMsni/yUfZ0V/BsUGi25uwLYhAQNTr?=
 =?us-ascii?Q?0Wor/4Abj33AoNFdoHEpvoHCsoXQZSybJ5Ry4UnKSFKiK43wmKTAAJtlu/8e?=
 =?us-ascii?Q?pX15b6wxTLUmf+s1EjZM1TES0bKb7jFLRUK7YYv4f7pBxvqY50HnrV3CGO26?=
 =?us-ascii?Q?WAm6GTuxgVl4/vTh94n5jnURFfPzmzt1K3Ce2nlCfRGtbgC1LZoaYu28u6uZ?=
 =?us-ascii?Q?afVHMEM+RoDxJiCbhid/sx7cE7bETvMHZFc5NHmpD6xXvIv+A9v0VMqct11g?=
 =?us-ascii?Q?5TR+zNUdnwUACzMONpcigp3860bUIxtn6nsgsLADqA7Q1HvmCNCBSGHW9ipD?=
 =?us-ascii?Q?5rtPtImPS6CNPm22u6zP857cIPFdXXR2nuzllnZdS/9cHVjLBM3HUR/RCiDU?=
 =?us-ascii?Q?mTEsaI3RhykfKzguYXt0ErD4zhOnCxNNHjnYJjbfL/aUQRHaZubUsn5GkEZx?=
 =?us-ascii?Q?WXL2j9mbGSsc7nlhyqRncC3KbyZ54LVdIWy0t702ZZkuxZAHUptRQM1ndxlJ?=
 =?us-ascii?Q?WX1Kce6Dov7LwfInndgSrcbH9DnWmieTQOfFgZZvhBMx11dYdkpuo5T4uBMW?=
 =?us-ascii?Q?cTXzClUwcGBezzcXdMDE5iIvCCFvRFKhk1nfaC4HUZQIaX3brABIiHBCvFak?=
 =?us-ascii?Q?DL2fiq9mI4ZW9MGlR7UclnkbI7GLdec0y4Gk0C9RqHJCZnSHJ+RCp5rKEwau?=
 =?us-ascii?Q?5ZwwcuIzpqfWukQyslgeURxXPJVaVy2ia8c4k58M8rtqtG+ynA/Yd1ftOXUk?=
 =?us-ascii?Q?Ezq7blJaYK3IEasMefsLyFPsucvWemfn/wGUZHk37moyyYxpYPV9qgsJ5SOE?=
 =?us-ascii?Q?vdYAJvFnizvp+u7kcNvwiLKNIqdS42ZpRWxhKRM4LAs6DTtgNnrdESO6wYOQ?=
 =?us-ascii?Q?B1qfzf3pJqqZRoiZaZTcvjYlGbKodW67Mvc3rDECDH3r4tPqOfPXLx15QBwC?=
 =?us-ascii?Q?opXmqQHLM2IXTrGEI9Vo9Wm4X/8st/WEGeU774kieJJWqhPZAVrJabdya6gO?=
 =?us-ascii?Q?eeDWIf1ydG4ZBvwJh6ECCDluwAqPIbk+cA9QdC6dbhFN/X00m0BgcuOZbQBi?=
 =?us-ascii?Q?jc3C+b/NE5aI0XOjVOolLbZjk46/HHXmqv/14awV/lbtkfWdrvt6CVcEgdui?=
 =?us-ascii?Q?ciMoURi2IDmiV75QiODChZOogAwBqLkao3M1YOsXpMmyNlZJI7WoWosNTwQa?=
 =?us-ascii?Q?iCh4dFHOyP/KROuf38LsA3U4N9IZefpn2EbBOvPDOUgJYrlyOlxbF4N5gusP?=
 =?us-ascii?Q?jRfIH1JuBpo9+edzoHSg6P68FQvOokstyJAfPdnHwdYr+T0YHiRLbzgeAw6a?=
 =?us-ascii?Q?Y88dYm/6VAZtVfOJDPYIyTAwFLAoj8hNpB+ZJGn8mRRMIw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?RsHnykufyRporE+RyPOFAcvrQl9fDrnoSfcdG1NEVil2DTSYJFcgYuS6TqIL?=
 =?us-ascii?Q?ePuB4LFJ0c9DwcP5eFzbN+dTN65qw9ZKlx29EBN9Rd9xzJiQIxpkd7T7axgv?=
 =?us-ascii?Q?d7dTubtNnDSOlxHHV18xF6DHnt0QkM+O2ywL9YfssR8PHSlOZXHPW5RkHV4c?=
 =?us-ascii?Q?1+a1Jqjtqbapy3vOMg355CveMFRa6GF0BvkoaUjNyVj6RTNnOyQ8B0CL3y1R?=
 =?us-ascii?Q?fL1PAqmrXr3hQxKXqF0nh9ETPQe195Vk0V9Od8leEISq6rsrYx2eaP4EIJS1?=
 =?us-ascii?Q?GN4rlcBRZ/hKx1ASTeEueds6G8+qDehccHAAsIw1uYngRDvFh6cMvtyT3rjM?=
 =?us-ascii?Q?NTIOmkrj+V4gJmLZFPIYO2LFu1IQPZ8lSyfxmQvzGxQBfrK1eauCkUUmlAYr?=
 =?us-ascii?Q?uFxuiPOkI4q8zUmLckRN0emSbfULLaDYBGiCxvoefsWekUqpzLY+DJli4BVE?=
 =?us-ascii?Q?H86icv8Esv1gRUi2udefgcgEJC7Cq9Djh9CJzfi9Tm53loJhqRE2g3eocNA+?=
 =?us-ascii?Q?5kVRvZ4OFP4WI4AQYzV9fFuLuWPRLZz0IMIjI3HDqjCUTyn/Nq8mO7Z37TjY?=
 =?us-ascii?Q?9yITRv95b+wSnsUpEnFpHeNY6NVOEsL8k+TcCDSMFKucObC+YnA6S/jzLjAj?=
 =?us-ascii?Q?sikDx95l8XTbDhkzbtsJed3PilAHFvwlc1ojI8wxBEkUcc2jBVfBV78e6DO6?=
 =?us-ascii?Q?mRBLkMRkV1T+ZChDntGl0H8wSW04RrSxr7wKcLx/oWL5ZU6DXXuXuocFZyau?=
 =?us-ascii?Q?oLEnMkjZTkiFb32OoLy5nQde584qUPzXl0Msx6lMiqH/yJL4471oVPeySall?=
 =?us-ascii?Q?KU9Hy+eBTiend84cqYOzY45r7oWLONTl2b4xczBtFnjfgUa9KAg16lITmJZI?=
 =?us-ascii?Q?9/SZfJFyEPBMR4K9M6wGSXZaiNDJH3FVWRJZk250FvRb+Q/qiPWC7in36J+D?=
 =?us-ascii?Q?vamKQrjZpt31IB7Juxt4pYbPpetWem33WeM9nsQT0bk2gR4w31H3/QX39HJT?=
 =?us-ascii?Q?tNiYOIQ5W2gWNWBQwdV6wUkUyED2EzQquZsV/lh4+eVI0TTu4sp/UO0YO/aW?=
 =?us-ascii?Q?+Cb2fE1z8MW5ID7qhIhdKjv2VJLQGmrlPA5exyhoxSlZtfThY7oWicTgCr8d?=
 =?us-ascii?Q?WvPhQXd2yGhLQi0QvXtd07AWEmCoa9iWsn25hpK+LzZPydJZLYfDoayo4P/P?=
 =?us-ascii?Q?HcOPkMoVin3nRPV70YUC/r5DwRblyhvqCRJA9tQ5bjlSpGgjTi19D7p3ZjWz?=
 =?us-ascii?Q?erhLl/PiTq0cYWvWQvlWqjfM5I+r6rnskSAgrLfxNDRZXZgLxXU3ybQQ66ib?=
 =?us-ascii?Q?sPTuZP39ar5j9mHs6LY3CL+1iTn8ve+pyWrQas+ipp9+qONcOzVaNhfmY5FY?=
 =?us-ascii?Q?xUlaDHRbjCgsrqQFRF4VaV2k3+ud/WbOegqMacRU5nTmqIoRPKjzY4HT3PWs?=
 =?us-ascii?Q?Y0JodSoVwDE8ZUIBVLF0GwdordruHgjbwVvC1W6u4p9va2cItPIrXNDHPpZn?=
 =?us-ascii?Q?d1ZDdXYala0uC1Ez90MhOYhYeRtQL2kepenCZjPxinWY84SCXi1NDbd6r2K9?=
 =?us-ascii?Q?/T/XdX8F/9E38mkcvlhDFkLqoIJRKv+7FvcBcYiReY2dQbxADdi4trXdq2WQ?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BS9eoddiQlpbVQLkVZzBRseeAXbE3bSlRWMI6lIiiVlmgTo5rDJolFJcpd5BXK1cislj9KDLQeYiTpzJex/Rcoti6/9jCC3KuMDYkaTQStf289+LPO5gAK1s6+SIIhK0hZKJyXQZJWiwcopyhtgslKzhhyUxFZhKrI606sQpTZrL6iMW4Av6taP8+NvHuyMmn7pOdgOefGnYF8lnIX8/SwAorvF3HathMtuoonaERP2FRPRHkuHll/qNzFgFDBcnpezaqT0UcFdBMqS/0AZXx1NYFa36l/Lhx3hPk4H6J88WXIbk5+/VwDf8tqe9oF9+GO1G+L9QXp78zKSRd9bqqIU6XGIXu8ZS+OEGjxl0C3JwDS3lNAil/2ZafM7ALyewsVmU1FLCwX+p9tbLLt6kIlkAmLlgAH6KMU/9g32ThXnSwGTIntZlQ4/cxJPv+Yq/lUwP6G+izJu6LHGAdFwa8Os0u6d3jbpIy22Z1siF+Jjlx8Sr47JYZPJpE2/B1PzIuQ1b3AcJowbcdAjAnn4mbkFVnCjlAwJk0YvoJRkG9V0LZknoIadwfW4/EAvYmawykMXW5sD45e292Fuy6TOxnpKvUx7Ym6uHx8bIgNOR80o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc32298-6e7c-4f7a-3ad0-08dca69c213f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:07:48.3854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTolng7QH+bo7vQZGWFyqcjAOUnyUv0F1QMzjdyn+RkSdlKISRlnX7CAeMJAe+apWGHz8231pI9qqsUROJv79g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_15,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170152
X-Proofpoint-GUID: E8g3xFjVZzLUZjxdi8zZspmxq34O1EtV
X-Proofpoint-ORIG-GUID: E8g3xFjVZzLUZjxdi8zZspmxq34O1EtV

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
index 45fb8725a6c5..9f870e715a47 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3026,9 +3026,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
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

