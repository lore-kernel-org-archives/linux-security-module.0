Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4908614E2C9;
	Fri, 30 Aug 2024 04:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990532; cv=fail; b=kooRAyE7rDsWxDBniOjO0IZdMGUzt+S+lK02p9kq6TcLnCMdvxkCcY0qXDm9vaKIgueWd+Jq/QBJoqYCM2UKZ4kJTvR1UFhy3ooGUK0ADBdFygAiSHxFcXLDo8IuAkVBZQ3xE8h9lwfub28Dri6dorIvp4eXwxPslwnPQV81Cc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990532; c=relaxed/simple;
	bh=jy2CptCrzMacNUzsOBU4+1ShZQi4OmSKl+ctyA0PRXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QdpC5Y1Ux/3InA53WKIzRTCliyFw9lt0bb02ei3f78Q+QXsgHLggGahOCtq40RQx2eJ747QpeIWz6DoPI2slgeJXVgwnevCEqb492VSnk5cKEtcRVfBEel8t39MLbLAC0G1+7ch656KNcMi1Z/hER3eNChURkWVzGmUVzwgqL18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AW8qP50Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zOX0Lq1h; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AW8qP50Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zOX0Lq1h"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U2spMJ011846;
	Fri, 30 Aug 2024 04:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=Fh3l+ME+2D7vTnslOnVr5R+ASSp1cx2+4oj0ezr+S0o=; b=
	AW8qP50ZdPrr59k0Awon0f7KVdHmNpQrg7DMAvLeIzrTQQmhWtoWiJJ4AtFPc1aF
	9La/UHDdTtIfDDKAfdLLVXfpDHJUTlNIu5XPrFdtlgBi1a62bLs4D6z9Wc+D5hjA
	d5lolj5Rd5iKbpSJXRX/41feo1UFvExpNp7k2A4J4CHPuIZ2Jgy+V3UBkIPacmQM
	0riDZcYKvhEUEVI9Cuc4i7iEhvw+GtVEfQFZpgAR0ZUnGWruOi1Lh1mHq0D1dmTr
	Ji8LKK1cg+Jme8F+bYGxb11b+DSnReNo2daOGaWC5lgwAWzW8j6oRl6DAY6KIOkR
	OIzRrVTXhytj0D4GtzUrcQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b5q3r1vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U0LvZl036604;
	Fri, 30 Aug 2024 04:01:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jp2tga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVg/LzYQS2LiG4JE1LgW87riTPnFevCF/vBEXKvGQBGtEppzcGZis0QsF4+pa8iaax/d+5jFMzst4Vg9OFNBBBkNIY93exbajigYPcRJSLFqQiogBp0UG46/696+NMTV/sF1PtK421N/+71pIfHpDmltceE/HMRyVVgyML22wgI21mRG4NtN9w3sd34ULUqfoflsi38aqKyKEsifJw4Gj/ltElwxWcLlftsDBPSu8qYytURjz+And/HIjxwTEVgQ/H1bOdNghTubexI19/tiJCQBz9w6nZ8hrwuqog5R6bIdzkGfVIz3TBgebECOlKUH0P3pG/KsceBm/g/qv/USyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fh3l+ME+2D7vTnslOnVr5R+ASSp1cx2+4oj0ezr+S0o=;
 b=VYFAcJ6lY8BddNaoQV+/bchKu/odF0gPZLXn+AILZwx8P1AMnF8AZdwUNrjXWfhWJrAdYjTZRw2hzbIR7bzhD9itm6seN6SaKPDSq9TEjdWoZ0cJi5TAdkGIgI8h+J7RZOff277Tp7nLqdvOkH5AYZgBgcFTWGSB80HxFW/z2LmX80MWco1gJ1RzTKn8QR84GrlCF/cOjM5um2tZop0E/B2PBrysxc4VdJ++Gomtf9Wpjd6Kz0CryivKepa83zB7FEjxwN2z/CU6tgFS8gv1955fbUGS87ExN+QuaxA5bZtViYRYvm6DOkmBCBcXjsrGGLxzAKz8NNFmDfpWrDcYwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fh3l+ME+2D7vTnslOnVr5R+ASSp1cx2+4oj0ezr+S0o=;
 b=zOX0Lq1hj2KUseFK1BpoKXzRr1RiLEd3Ugr6EWY5trF5Qq/qiNpbTJtTHpoKzdXovIo8ywOhaOLS+QwLs8Bs+bI5w3sJCWt4rx/52vBjFHWA2a1lYe9+w0PwECrz0PASqFsFKL5dOT2LlXglCY+r37SRhpauKg+NCTs/p9eBOHw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA3PR10MB8115.namprd10.prod.outlook.com (2603:10b6:208:506::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 04:01:45 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:45 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH v8 17/21] mm/mmap: Use vms accounted pages in mmap_region()
Date: Fri, 30 Aug 2024 00:00:57 -0400
Message-ID: <20240830040101.822209-18-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0471.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::22) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA3PR10MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: b703611d-698d-4682-b586-08dcc8a876aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MbKYf82IheOWPipB6jwqnALZ9QWjS2XCQoSs+NLxlWTTvQPaRmdPEFHS/96m?=
 =?us-ascii?Q?mS+0z9DO5OZRVc7w4saf5zbmf0ggKkE+vqgT0rMLmY+UkJbgVPRrBaJA3lCY?=
 =?us-ascii?Q?zYzibqFUgBljCYkKaB0NseDe0vc9zOPuGPmuafXEakCDJVuQEjW1SZdsgdxc?=
 =?us-ascii?Q?MHPjrzLbG6PgVGfmrllgyieJ1RiG018Q3UihvJ2jjuTu1L98pw5n+zq3Ng5b?=
 =?us-ascii?Q?6mo6SHxlpm16/eVVgPh/j3KLIrUgWaYRMliFIYodWvviT9bPsGxpHRe4QhSC?=
 =?us-ascii?Q?eNmE2Xzj+HZSJsES7pi6vqncv1utS6Uy3NidhjnAWJ5vwTcRNajbEr9WprLW?=
 =?us-ascii?Q?x+aK4EQhe3mgabnZqf63oABigQKcu7nY6AVys8f9//BjGHoDzXAOX1TwYGRe?=
 =?us-ascii?Q?JkSCW3qZmeZEzDsNzGgYbapf6z7xp4yanzBX8FE3q7YpJDsnab23Ke+GlHQa?=
 =?us-ascii?Q?jclX8KAHE1xrtQoh8W//7UfWFuo7Ax8Ih5Zok5Gxn/IXSzSi+nbYefhZeyYk?=
 =?us-ascii?Q?3+XDO2ktPa+fRtScgM7Lo/ycrj1mSZnS0OEKUV/kW5dlQUzGqfmYWOxGaEFF?=
 =?us-ascii?Q?uQ6pxOnO25sH3JXI1kZ72lrNbmc3rdDc4q7YDVEgYQSwsd3ta9HtrU0fj4kT?=
 =?us-ascii?Q?nUNBwwkxifeV1hrvPdPlxVsQblEHn2zUiOBrjlr9dm0fYATDFzEEfsjxkZ3y?=
 =?us-ascii?Q?n4fiTd6H/JAjm3fIwGhIJuI5eoIYDiD5xhW3esLEWkipfWiAxHEnOh72xf1T?=
 =?us-ascii?Q?jqgz0KTzAzGaFCRVco9jcdC9Qg1nrwneIEmHkPFKLz7IXS4ov2y2hWEmhkrV?=
 =?us-ascii?Q?r1tG+IqNXg7HRJJqVGPwzKioB38duFVs1ciM1FQo5lYUGwJjlsbTBMSFNc+Y?=
 =?us-ascii?Q?VALts2N936db/EesBX2+y9h+NISRm8TN1EGu6pc8+3E2yMibHoQu7ESWYsiX?=
 =?us-ascii?Q?vlCkc4Rz4CqevHqnLDOLYSufB+9Hl6x4jT0vQnmqkjCAB/QRkw0v91r1fUwK?=
 =?us-ascii?Q?ajsAsvuH0tecV67RhjvCFYMO1x4ut7FPvKXk3nf5VM/3E/69qFb2Wk5/ndFR?=
 =?us-ascii?Q?h5wzeS7gKuKOWrHt2lsCUHYfLZQo9LqB2E7DySkFQ30J9vaZZAydoj9vyOEN?=
 =?us-ascii?Q?p2T8UXcJjZGYzO+j/0i3Fisd3aZpzPv7qkZGrsMJXoMTzs98R0esJUeSbWWl?=
 =?us-ascii?Q?Di/qSvjA4V/y/8vnTy8WZKlMB+yEoHQvtmezPBlCbiCf5O6Rh3qRuB8B7gxb?=
 =?us-ascii?Q?iZXAUIGKop8IixPgP81Q2HO9wiXPHeyYVdgKGUiW04r5JAAmXiE9UMlGymXG?=
 =?us-ascii?Q?HoojjwBbf5odYrga/0QX7xCr75ccFthZzurL/PqVqmxHDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H/OP+8isgW2W26K7s+IcK0vFBt9txn7E4pDhvgHYPgzs6qsci+UcrzxO9ZrX?=
 =?us-ascii?Q?TYz9S4DQLx5R8KSVGAoXTYbAjPrnuEdRihpy+1fboK39wFUIFwwCRM59WYxt?=
 =?us-ascii?Q?sLTw6j1tkJJEz040YmoLeLfjK+XFN1sVWCESkJNz4KxxAhRXe5gS+P1alP/7?=
 =?us-ascii?Q?KmqUjZ/BhBN0jEXSV91v+aiS0o56RhExFDAdY2Lx+N3SQsugRJoNi4EBhg/n?=
 =?us-ascii?Q?f4aOV1ilxSjxz5nD+ijsp44rIRojhDnbCWwj1dqo2ffmuL5MKcQkcBUA9Jbi?=
 =?us-ascii?Q?HGfBz53j7h+P/pjutWVttbnJHIvVvvfWMWjZ/pNOi3Oo/eZx3hu66pb+0sjZ?=
 =?us-ascii?Q?RdaarPK87U9An6MR95EL3znuIVfJCtFPIsPHLNE25i01/+5bxqrsmY37403d?=
 =?us-ascii?Q?zvvTIAv2+oNhmusWwVLy6H8tLXej/ZxoCKXI0T2pZ2G16tLyzCx5nCreo/Ma?=
 =?us-ascii?Q?/5FEykQoI+qOfZHqeV3jtlGrMbFstd6VMYDjZNNbnvnxGjN/D1LsJv2hyh6w?=
 =?us-ascii?Q?f7YorU7MDC5e7Gzb7pyRhtNKtoW3WkOWSivy0UbC9tPAd9gGuB/iJoXRgbPr?=
 =?us-ascii?Q?l0N/OKaWUGM2cjnBnIvzKGud5ptMdw+RVAegjieAWzvdY5ZzJTIZ6TPyF4uf?=
 =?us-ascii?Q?zKn/QoPvY/ssvQxFv1QQdciOW8kEQ5EcajfnW7bOwxLCvd8wF6Nu6AgnXkrU?=
 =?us-ascii?Q?rAirKvnlGvHKq2Mb2x0x3KxdfjDO72y5JNsYkoQwyn9Waj6MFz94EDSTVeIe?=
 =?us-ascii?Q?pEuJrlMojOX7AHupDrCbvVCm7I+EK9FrVeha51s+nNA6FVcZZl/0abkNV4Mh?=
 =?us-ascii?Q?K/1C3jcUZGSdYC9vZ78jQJk3+0gQwcANsCn0Qvny2/gMLZmrfLfpBI6cVRCL?=
 =?us-ascii?Q?fwmfpwb64E+p+HJkUShPD7Ao2/hOz6uXZdcO9TUr1xyeEy4NHDqreHtUSeK+?=
 =?us-ascii?Q?EPRnXKaWjeFmeonmTU+FgytBf6l3HEQfDKpIZ/1L4Htrhh2t6ZSex2Xmc339?=
 =?us-ascii?Q?w0898xjHjruw1xJIwz66U3lKk6+cQQ2k7Sp+PKzNBVLOKqA1PEfT0Thd3lUn?=
 =?us-ascii?Q?k3QVHN7wZJxXl0YxmyczZgK91CM2TcAb4CpUQ7IM8O3ADDw7Ljmdgf+VBeoh?=
 =?us-ascii?Q?kHcXfyTcJtGBom1DUb2S+KnFOGAnijc3lATBVqKX6CCCS4XOUioIOe9dZ1wb?=
 =?us-ascii?Q?cljXS1qovdrAMABO50YW4NQv2ul4UTd1wIDWmsYDmYE6C4JHnPY2ZzxPG4FK?=
 =?us-ascii?Q?jGhLs20rbDO2yW6X+/3EbqJeb2dY/nLTN8+R9PNoaHC3ziLaX0eP8CtYoOGg?=
 =?us-ascii?Q?q/fwiFS2dHHHG5qVFxkfsatOuNUSUPOpPW05m6jncOiQmVPYmBwAA7aPG5o2?=
 =?us-ascii?Q?1wowx+5xFSAHNKcr1z3kV0y7RRTg67sAWYEF2mTMhGBs4FopBhw6CFq3TYrR?=
 =?us-ascii?Q?AVStxOBZuezqogfOULebqy1qQ2t/p9Mrti0kyCadzFUbBLwMpRLuFnZNcHfv?=
 =?us-ascii?Q?i67Zzka79SjGq/CbllsT01oAANmPjLGAakh+XBgwm613XULqQBZHlakZB61f?=
 =?us-ascii?Q?Plt9KPbsUHarCXo3rrXX0KrPa9meGi1dtG4zEv5ehazl91fGXvX1gyUSPInT?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O5BnPQCHS421i/dEpaqvmRWx7eRO17/7t7QUSgJyV7CgfeyLvpNT93TBtpAU0V2YdmikyvHOuKysjsxtG6Fr3YIAJXHh3naO18sj9ELzmPJocOES0JNdf4fFrejUN7eMk8OTLYMoRcAMSgEAyARmvVhZtnK2kX17okeoYLEtOwpRkL+jFQmj10eAVQs+mTpdVHXybhMmTpjK7QW4nvJ8to1v4Uet8bR/s+AswRT+t7dy5ERL4+RLC2d06tdkTZLYXLgcFaNbh63mk7givJTQG/rfkJ2ZXlNFAonY+SvMTeQhysZHWAIS02LFUZU6tISilzFKWl33Uu2oPIMOaFfz8QQve3J3N0QJCOdSinUqxVXKxNmTW3UjI/UNhf5LvwVMF3COBzQC0jfkhsOVftVmpuJKYmA1AKndxS2jfbocBpTfa2jE5QUGxPu1YQhcHaLMEeHKLdMEtW9P21tNHQ/lRdCOpDJ+jahsar/kaywcc7SB9WAETe8ZuFwIMxvViV5PCUDldrNKzu9e/Nik1D7COUI4Y/gP2i+0yAkg/4eXk/0Aq0MKjZmRKQk08yeDFj/J+IEzFTx8XISnU6ayeUBoef5iYO6jbJqW+vMo/aFFClM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b703611d-698d-4682-b586-08dcc8a876aa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:45.1835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8DSCd3HTkjiHgUd8TIevB3CaQsSSvjkuHDqJJT/P5MHoaYGv9kfvqh6DMqFnDw2mK23C53tyliYZipVgb37dcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: FmX4xC3_iodGktVw-_nHx0pwMM3pcAdl
X-Proofpoint-ORIG-GUID: FmX4xC3_iodGktVw-_nHx0pwMM3pcAdl

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
index cd09dd164e85..4faadc54e89d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1414,9 +1414,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
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

