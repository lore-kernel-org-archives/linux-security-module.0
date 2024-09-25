Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAD313C67E;
	Wed, 25 Sep 2024 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727253910; cv=fail; b=nrCaNVmhw2urFSl5HBCvy8mcsSIAK3gw0xri8U/1gJGGbojIOOuf7dAF65o8AK5VtUtzN8x39UhJuZ2oxfmEvVAfpUWnqZW4MywZoKmF2oFRXexbA15enK0dEGXefFyBKHWx0+/FGuWCPIDL8HBsFHCmw8KuRTbMm754u4DV8M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727253910; c=relaxed/simple;
	bh=tX1Iu1+7dfsP07taUx6fUH5g17pq8eT5IgwTsm19QnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FRDYnFXjtA4wZrWC7LdoMzuwkkfpvYX3N5SPZGH5fEoulGYJF1oQWwpynHHHJKS5Rmw8l4Dn0tFk+nwMcfiuvQZJl1a9TPXPL93EzbhJMZSo+Z+WrOIFteGEH5C75s/JKww752yr15nd2caNUBi+VSKU5wVlxZikBh8+zMTVzBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zo9mtS5a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bD0ZbGnu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zo9mtS5a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bD0ZbGnu"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48P1tdUv008100;
	Wed, 25 Sep 2024 08:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=a8KGx+JKr+QM6TQ
	DsHTYURCXpat5Zih55rk0zTHMJCk=; b=Zo9mtS5aOqCMFkhVxscI9gc+V5FqjQK
	yAOpP9U4zHWi87+MdJRP2R0lKanngXkiJiDirb8+OhKsUDfqJc1VV7bpWlbJap2u
	PSd52TB7Hlq/ujke48zeHwqt7m2McSNqdqFGd3paFA7a449FU7II3mbigxTbTK0H
	Vy6ruWa5CkhmQO64eKjkLqRhDYgQyoBdeXqi/3oX55aiVA/AkneWayDIimefO6CH
	ZV4icPG81p86q39ceyhqYAC3aOh9eEJe2y6+RHGHVOyPrm1TPc15De0O6/M5s5Oy
	v6gA1TGSHA42UP+aBIYC3plV69RkaSOO90n/Sw7bI+06Q2QfxWE6YAg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sn2cstf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 08:44:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48P7D0X0030592;
	Wed, 25 Sep 2024 08:44:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkady0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 08:44:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhzc9c10AJGcuaqdd6iOWOFBSAsJHs5kJqloPnO3n6dYia4p4BWF4+YgXzoIM2KUL9QR5yEGOVfJT0eE+BFRfRqZIuug2RoSzB2o8Sxir16nYXiIfyA66mSYjcdBDNxqYAbP1TX5Dg64pS9id9ODfIELLIkuT+vYB6YiKMXXkQN4sgwiH1raITsoOGxKItZF/zgM28Oa4qZBVuqLoGlF8Qh/nNci60nwZ/UbxWZTwPg6uNwTFiw4aNo9g62RAVp5QPZBUVB+FshQIlCN1Gt/5p0gOoKbmndESrR1EgcmVSAg9Ab3ypCxuuBStFs1wAiwMvu3Cd13wjplgchNK9v3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8KGx+JKr+QM6TQDsHTYURCXpat5Zih55rk0zTHMJCk=;
 b=cKUX3LwELrl91eaV6PPK/u6QiUIsXIam1d4GnV/o3vnLn8RunPn50v85KHmTksyAqKH4JfOWwcZWzR/gLCApL3uO9rlG1MvBM9r8OBelwJQkBpy7w0btkQDToI58K0kR6ud+F4sZO0CadLkqHvov51TU3dpT1AIUBkVnueMrDp195AHi0alEchHOK1gp2vxAb0nNIVfBAi6a3xYwcqANIL0Km/f+Rz2KNptNZM3ory6panlSgFg78cbTO4LdozPsuE2cqpY02oYtQ55/RQJuUNXMD06tm3p/fdQxpp2JZwLCdcK/lleCHHr3e3ptQmEfRZrUieE3uvzc9euEfUlWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8KGx+JKr+QM6TQDsHTYURCXpat5Zih55rk0zTHMJCk=;
 b=bD0ZbGnuQjHukT6zCs6F730mq+GCqhBqnCYK59/dtbQKkgitN3XhtElVAs/ZV5ClnvEd897szo/UAMjpOmnxbr61E24pdl+IvjWcVg1t8k/xTlLXIeYj1jKJB+i4EYM0xpDw2rjSe9vPIrjQ/2KdelJxDhGyujB4V/EIW+otut4=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB4829.namprd10.prod.outlook.com (2603:10b6:5:38c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.14; Wed, 25 Sep
 2024 08:44:43 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 08:44:43 +0000
Date: Wed, 25 Sep 2024 09:44:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shu Han <ebpqwerty472123@gmail.com>
Cc: akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] mm: move security_file_mmap() back into do_mmap()
Message-ID: <64882dd5-5efd-4912-ab3d-0e6ee76380cf@lucifer.local>
References: <20240925081628.408-1-ebpqwerty472123@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925081628.408-1-ebpqwerty472123@gmail.com>
X-ClientProxiedBy: LO4P123CA0159.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB4829:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a8e438-ae8e-485d-77f1-08dcdd3e4d35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zRXeBYrXJ4iOk8jlGJCVTiV0cK5C3JXvaBIxJOxvVFmvrIxXwu6PhV5A71DT?=
 =?us-ascii?Q?qYeRa7gcc5uVVZvlPA+W8PWiLGp9eYy+e0svwwhUfokw4ltpW6te5eps2qku?=
 =?us-ascii?Q?P1AasOJI6NFSAHoaM2fTEVoR3vqFzUIQwjW14pGJtdI0UVg7N3OJ3RkLnQ1B?=
 =?us-ascii?Q?mX7hqAvheACGLe/9plKLCad0MEfgP8lEETZiOi+bTVPo6bgdsY0gVC8alJLq?=
 =?us-ascii?Q?Mi7P2qXpoUeuENLmavu5fghdIHNJ50rudfL8OGxofxWqVhyER5P+tFBpr0Rd?=
 =?us-ascii?Q?Fqda1soHvAyzT1WOCJSJkJYIpWPAuxJfr6sK6dGbAqsFPQgz1R3vuLo2uufo?=
 =?us-ascii?Q?JGcR5QTTB8g5hlQuEQ22ts/2AP1QuEhREz1JpODKLqGsVn8OkFJsVk5UP/NL?=
 =?us-ascii?Q?eaugibHNa2A16qkb2hoZuV4pEZRPlPNyYufTC6NGjtagFYNXH7XgSviOlm4h?=
 =?us-ascii?Q?5Cop2qIApqMvTaYGKpu7EnfSbDMfhigaRSjgC5yCj+82STxIg9ChE/FYd7cD?=
 =?us-ascii?Q?GfySiPrP9AEdB0lP1BbJ16GySEEox6EDAcb8W6FaQ/1YCJktP4dBGKh8UNIr?=
 =?us-ascii?Q?vFfTpDPCgx2x4NdudpEaQTLbBW8Gh+BgrKByIZalS5zjoQgS5wub9hEG3POc?=
 =?us-ascii?Q?caqUWW75fIxq/4pByWCJfU390MkzBFmJuVFMBt32UwEj+h7ZxsnnxJg3I3Zu?=
 =?us-ascii?Q?L76Bz0YELbIkK3qcTfSk3enckO8QbwR7u1izg/Qu8izH7iyBqH/w4EGV7j5W?=
 =?us-ascii?Q?EoOiyQQU0skbH61XguDbYbLnnwxkC8MoeROPqT0qvT3oyuRXU33k71kdeFVB?=
 =?us-ascii?Q?hrJf3xyY6MdEA6Beb7wh4f7cCA4mmUF0K4ivQrSFw2Ui/EUhyMm/gK/cH7Eg?=
 =?us-ascii?Q?rTa7cxqyDpXbEW05D4msQqDBZ3mghZI8WK71poWDyw2YtfMYy1iLGGzK7xcy?=
 =?us-ascii?Q?ci5KRXLQQR7MuSQ0yBmTYbb4HedXnp/dxFUYPhriZfliIRar2SBdRBJJDYX0?=
 =?us-ascii?Q?boOrtpsua/f25nAFWKPGqCBUV4Q/WXeQYi6QC2f0ydm96kGQfMplu/DLgjlr?=
 =?us-ascii?Q?7VF4GMuypqMK1hkLfNk7GVQW8qdXx0OU7+y+GlZzEOHaROquNj4jwjMHmdZT?=
 =?us-ascii?Q?RxKMeV0DIvGXfO7DsnRwQ6rbYVh0JwxCV6Q8+fhwn/Xu861Ld5jl4qt9Qkh9?=
 =?us-ascii?Q?hdWkb6gV1oEOqql0/eon9uaZpIvLP5+fJK9VbB+5lvQ9etI5bGpHvsfyGeo3?=
 =?us-ascii?Q?TSdHu4t705y5m8ZBcShHxrAwL3+wSq5ymzsuLh5KKmFWq1/uH7L8xrOnIL72?=
 =?us-ascii?Q?V2g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bBoIrkTgVgd+S2ux/mGa6UQ3fcBvKBqTH/f/YyVDmHF0wF1RSm7ldM+kJl58?=
 =?us-ascii?Q?T/6xEOLl7ERQEPGfBCfhian2no3eVgk93GfYc3B+okxKoM3BJv1lq+eAt1O4?=
 =?us-ascii?Q?LHNJV6zrzoulyHmGKdnXySdDpdiCsQAV5gIT1b1bJsr6tFoH6601SV4Rk6Gb?=
 =?us-ascii?Q?DHSB+KM2JGlAGRjTbHA181yA5iWWgqYFK0PmZ5uzFnv7LRfdPnaLoHSAuyl2?=
 =?us-ascii?Q?Ydls0XhUBn78ixsGHjJkfiF/vPxPmM02QvSE58vMNKUDg0YL9HwuZMbNPRvC?=
 =?us-ascii?Q?30x1SOvM+MlbmeI3KJmBUBjCuAESgKjxqz0kgUqOWRkYpSzP/T5AVKhHHNRr?=
 =?us-ascii?Q?W+73xoO2mDHEzfJ0hHQKWtNuuthD06WFjnVD58tnvLrFZICXWkmgfOR8X33o?=
 =?us-ascii?Q?wYp1BW6AbipsjjqEF0krlKWoAoHUAnk+30Z5ZZr2LTED83JJcWQVEPWxLg0q?=
 =?us-ascii?Q?POstRJjBv2o8brf7HfWlu7l56vQ8vnMLPrjqABNX42z1eH1xYeklyMQOVXcz?=
 =?us-ascii?Q?aSuwt8aS0iDZh9MAwnhyKazIyWr+zJEOFsJFqW73U0q58iSRh0nSGTApFSHt?=
 =?us-ascii?Q?peUUIZbctKEognAotr+3ab3D9S9gmdTPEGLLX6IeKMfQQps0neaw5cTaW2Hn?=
 =?us-ascii?Q?5HeuDY4IrF1gx+Ik1m061mbP3xTVB5yrgo4qHu2aedxkeKk+ip6EjPKrff3L?=
 =?us-ascii?Q?kA3ctFN0y3Pt0Wkz1GBkpVCEzBFETS4QuEi7gYIPgDynW+Gu8l2xwvCljJTN?=
 =?us-ascii?Q?pkvDqJEHJahwjc59sF9SHYZSf7WTaTEVz4uJ376qRmJ/9zyhG1TyKKFm+S3N?=
 =?us-ascii?Q?TuQ7ekBp4ZcxhPSXHr9ViF8l2TUG4OFASPCQttJsqK+ySns0R0Fh41+rEqL4?=
 =?us-ascii?Q?rWGp06gZmqYmIKSae5V4+sCsrF13o3IGbQrFfom6Kj/YfTbD+5I+AXdenAV4?=
 =?us-ascii?Q?SUgm0/YB0WLXmjQOfjiZrqJqMigw2KJlJa6ppSAg1U3lHS/lsn+8B1yA/LsC?=
 =?us-ascii?Q?N3V/7RMCaOn2N8BkjwJ54Qfp5kbFw9VUzDNIzkQeYG2UzYHG6rw22/c2Iyio?=
 =?us-ascii?Q?3CM6JsLTGoYWnM+30z9hJafQC/dI+68/S8vGuHMIePDibZZ6xsDA8kR5Dr8h?=
 =?us-ascii?Q?CWuNGC2ckpA1Dr+H61bJ39mluRli9nJ6t1keUfucMt3y33PCPXx3ignkY0u8?=
 =?us-ascii?Q?n1ElILc4Zo7val5Y4kC9arErrYvzvU10EOZEJrCaaJpWOzJWoH+VIh96O4X/?=
 =?us-ascii?Q?t5QDYLOuQkURaS4p6z3xxLE+VTu19rmt3EJXv9EgVMPBkEUmiOWp724iPRhV?=
 =?us-ascii?Q?P1NhX2N1vD/GTPuEw27UpxJl4lIE8i8U2Im0lKiYhOliKr4rNR+iSoD9qsBL?=
 =?us-ascii?Q?fceelQZ6ag7jimXU+mpFYBjV1eekZPjnlXnidIFwsqyCzA0pfUY/qiy7QKcu?=
 =?us-ascii?Q?iJBs7BbzAGYixw0G5+BcvN3l0IraWNDZ/QBX4+ms8VA/iyzEiVCc/IMjQMgi?=
 =?us-ascii?Q?N14hTjcaK8ARGrt1L6E7KlGqhDiOlO2XsdUKJxrwXjtrOv1qX6565K0ImNa4?=
 =?us-ascii?Q?h7tMpFW1xJnMglB533+z3pEnrEu8G4obIHMCkaqT98z7Mncq4nCUFYSL6ACG?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3m+i5QdjSbk26BTTrNrJOwoJGHerDvAYHyI1U5jf/AMDtZ21iKuZFbO52Ya4nlXq8kMO9S19CTpnrcmY9UeB9sZUb2GCc9Y2D2tzJXbY9OTYDMLW3O91S8nIpFPUeH1vvzfzT7tm2WHdSm1Xp5z6oJpT0LUPnL1AXPClhqHfHJRvviqMUFu4iwmZLuGnsr584zJsm+a8XVSomkQGGrEHJxyRWwEKj0hid0p5kARL23AQA1G8F2B8HCLdZuLX65TcKygHMFxTXUm9m3k6evZvb8xLdBz1E60g3252n7MuScNd3SJoxD70FK8KCFIADwcilNCinx15xkc1AoXxM9zEsHC0IUPQ37rXsva2wpbV7aAuKgRz8i+qHgK4CMptcTqsN9L7X8u2EhoZM9zK+P4RCHH5AJK82cqRyATNMfJdHQVImJErrCzY5SCjhD8g9lV4Ey1/shVd92TmJE9OTfktmoAN/nzFofJc7/DJSDC4pdKNi/V+h9tcYXE6qM+vsctT64ffp4zTzGTszAaV4q5Ua9P+Ont/xdlENq0zXxaA6USJjg2y28W0PHlKEv3dp9oF+7TPsqkEUL7cas7TjdB1Qt+1oSxeJdKlRi+x71rqPyU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a8e438-ae8e-485d-77f1-08dcdd3e4d35
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 08:44:43.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Itxphj4JVPSdKMiRNirsiL1B3nvUAXG24wlsg4tpOePa1mkO+kQsg9V3ntSl32AFZP5j1VsL3Own+KOqHYpI2RtXevkgOhhFsqodfjezplQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4829
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-25_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409250061
X-Proofpoint-GUID: zuUnvcvWKROox9lWMWTfKBbgkamV4Mde
X-Proofpoint-ORIG-GUID: zuUnvcvWKROox9lWMWTfKBbgkamV4Mde

TL;DR: NACK because you sent two conflicting non-RFC patches as
'alternatives', which is not how development on-list works. Please resend
maybe one of these as an RFC...

+Al into this as he is the author of commit 8b3ec6814c83.


On Wed, Sep 25, 2024 at 04:16:28PM GMT, Shu Han wrote:
> This patch moves the security_file_mmap() back into do_mmap(), which
> revert the commit 8b3ec6814c83d76b85bd13badc48552836c24839
> ("take security_mmap_file() outside of ->mmap_sem"). Below is the reason.

Nit - we typically use the short version of the commit hash when
referencing a commit, so this would be commit 8b3ec6814c83.

Also if this is a revert this should be reflected in the subject... and
presumably given the original patch is from 2012 it's not a revert at all?

>
> Some logic may call do_mmap() without calling security_file_mmap(),
> without being aware of the harm this poses to LSM.

'Some logic'? Which?

There's no security_file_mmap() function in the kernel? You mean
security_mmap_file()? You're attempting to do something pretty major here,
so while this is obviously a typo it's pretty important you get these
details right :)

>
> For example, CVE-2016-10044[1] has reported many years ago, but the
> remap_file_pages() can still bypass the W^X policy enforced by SELinux[2]
> for a long time.
>
> Add a check is easy, but there may have more calls to do_mmap() in the
> future. Moving security_file_mmap() back into do_mmap() can avoid
> forgetting, and avoid repeated logic for whether READ_IMPLIES_EXEC should
> add PROT_EXEC for the mapping or not(In current, the !MMU case won't
> imply exec if the file's mmap_capabilities is not exist, but the
> security check logic is different).

But we might want to do things internal to the kernel that don't require
this check? Drivers can map too - the only place we need to be doing the
security check is in the user-facing mmap syscall.

If something is added that calls do_mmap() without proper security checks -
that's a bug in _that_ interface.

So I disagree with this patch as a whole.

Keep in mind we _do_ perform a security-hooked free memory check in the
mmap logic security_vm_enough_memory_mm(), so it isn't as if everything is
bypassed, only this security_mmap_file() function.

Which is surely only applicable in instances of user-facing API so is... in
the right place now?

Yeah I am not convinced on any level.

>
> It is noteworthy that moving the security check in do_mmap() will let it
> in the mmap_write_lock, which slows down the performance and even have
> deadlocks if someone depends on it(Since security_file_mprotect() is
> already in the lock, this possibility is tiny).

Err what? We can't accept a patch that might deadlock even if you claim the
possibility is 'tiny'... that's a NACK in itself. You _have_ to demonstrate
that you aren't deadlocking, this isn't optional.

>
> Link: https://project-zero.issues.chromium.org/issues/42452389 [1]
> Link: https://lore.kernel.org/all/20240919080905.4506-2-paul@paul-moore.com/ [2]
> Signed-off-by: Shu Han <ebpqwerty472123@gmail.com>

You need to have a fixes tag here for Al's patch presumably.

> ---
> An alternative method is moving the check of READ_IMPLIES_EXEC out of
> do_mmap() and calling the LSM hooks at the same time, which has better
> performance and compatibility but may introduce some complexity. It has
> been proposed in [3], which cannot be applied at the same time with
> this patch.
> Link: https://lore.kernel.org/all/20240925063034.169-1-ebpqwerty472123@gmail.com/ [3]

You can't send multiple conflicting non-RFC patches at once... that's
completely ridiculous.

NACK, and re-send one of these as an RFC perhaps referencing the other as
an alternative?

> ---
>  include/linux/security.h |  8 ++++----
>  ipc/shm.c                |  4 ----
>  mm/mmap.c                |  9 +++++----
>  mm/nommu.c               |  5 ++++-
>  mm/util.c                | 19 ++++++++-----------
>  security/security.c      | 41 ++++------------------------------------
>  6 files changed, 25 insertions(+), 61 deletions(-)
>
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
> index 3e3071252dac..ce02560b856f 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -1636,10 +1636,6 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
>  	sfd->vm_ops = NULL;
>  	file->private_data = sfd;
>
> -	err = security_mmap_file(file, prot, flags);
> -	if (err)
> -		goto out_fput;
> -
>  	if (mmap_write_lock_killable(current->mm)) {
>  		err = -EINTR;
>  		goto out_fput;
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 18fddcce03b8..56f9520f85ab 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1260,6 +1260,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  {
>  	struct mm_struct *mm = current->mm;
>  	int pkey = 0;
> +	unsigned long reqprot = prot, err;
>
>  	*populate = 0;
>
> @@ -1276,6 +1277,10 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  		if (!(file && path_noexec(&file->f_path)))
>  			prot |= PROT_EXEC;
>
> +	err = security_mmap_file(file, reqprot, prot, flags);
> +	if (err)
> +		return err;
> +
>  	/* force arch specific MAP_FIXED handling in get_unmapped_area */
>  	if (flags & MAP_FIXED_NOREPLACE)
>  		flags |= MAP_FIXED;
> @@ -3198,12 +3203,8 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
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
> index 7296e775e04e..e632f3105a5a 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -681,7 +681,7 @@ static int validate_mmap_request(struct file *file,
>  				 unsigned long pgoff,
>  				 unsigned long *_capabilities)
>  {
> -	unsigned long capabilities, rlen;
> +	unsigned long capabilities, rlen, reqprot = prot;
>  	int ret;
>
>  	/* do the simple checks first */
> @@ -818,6 +818,9 @@ static int validate_mmap_request(struct file *file,
>  	}
>
>  	/* allow the security API to have its say */
> +	ret = security_mmap_file(file, reqprot, prot, flags);
> +	if (ret < 0)
> +		return ret;
>  	ret = security_mmap_addr(addr);
>  	if (ret < 0)
>  		return ret;
> diff --git a/mm/util.c b/mm/util.c
> index bd283e2132e0..47345e927a8f 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -581,17 +581,14 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
>  	unsigned long populate;
>  	LIST_HEAD(uf);
>
> -	ret = security_mmap_file(file, prot, flag);
> -	if (!ret) {
> -		if (mmap_write_lock_killable(mm))
> -			return -EINTR;
> -		ret = do_mmap(file, addr, len, prot, flag, 0, pgoff, &populate,
> -			      &uf);
> -		mmap_write_unlock(mm);
> -		userfaultfd_unmap_complete(mm, &uf);
> -		if (populate)
> -			mm_populate(ret, populate);
> -	}
> +	if (mmap_write_lock_killable(mm))
> +		return -EINTR;
> +	ret = do_mmap(file, addr, len, prot, flag, 0, pgoff, &populate,
> +		      &uf);
> +	mmap_write_unlock(mm);
> +	userfaultfd_unmap_complete(mm, &uf);
> +	if (populate)
> +		mm_populate(ret, populate);
>  	return ret;
>  }
>
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

Err.... why are we removing all of this??

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
