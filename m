Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44485143894;
	Wed, 26 Jun 2024 18:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719425118; cv=fail; b=UVCfqegm+0sve/4WZBiVmh8CMF6fGkyBfwkz1N0ozXPMxXcs4WgQS2naa5VP5El5TFqIt16JmqiIEjJ5LliQNWAff7tCSjZVTsr+ZrRbaU25+q2ZCmvUPdB1jeNpZYzPCRo15XyX05Wo8w8PGtXmZpHB9vJWUd6ko9wD6y4PfpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719425118; c=relaxed/simple;
	bh=2Un9m6eEaVFkkci43dKwihhx1RFBXCQrNpRNYvzG6xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LbFLrie9YGr0f8nWJhy87WqLZUEur1aPbVbVuLbGfMj0Xnub+IU+oSLbQK1NJ5f1DNs6u7XYMSknVBDc6ZsGNjiFbHzr3/+r/c2EdrVU60sjbQUgnM3AqqW5YHFfLwpBA1EEFLozJM6FY32tWJx3yAxh9xnzy+bwTtkSU6CZ3JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bqHbJZv5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YLRBajLJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bqHbJZv5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YLRBajLJ"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QEtWoQ019688;
	Wed, 26 Jun 2024 18:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=2vDpv6WYj26Cbyw
	HCEgq9yCHVLy0T/ZyIt/0e5gfn9o=; b=bqHbJZv58Md0X8WdENBVgHpxqaIIgBS
	aQB/1+wnh6nfl52jL4ZoZFtx9uiS1W4iUMfIqf8F5cR/pKsDnPyxbhYafSwDBJyR
	FQz0veMx7wF1IMXDy0EwbyQmZo3ldQ+5kC1ouLXAoEn99cS5RXdrFlxQ9M5R9xEU
	KD7IT+5JGqPdZPTjCuOAp01Nlt1Z8R/rRJges7CIETS+O4ALwENrnomd+bsv5uGr
	CajwV034VBx2gGeWQDlPY79JwkmJ54vHGb/Qp58pRgaYRBcOoKPXhc7rH+91TRqW
	9HYzAfC0daFuoWWeFdE9cF+SgCdpMLckHjCUsKpAUKsIgLoWycpkJ+w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7sm039-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 18:05:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45QGxJEp017872;
	Wed, 26 Jun 2024 18:04:59 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn29ajbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 18:04:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARrkk7ZZ3wm8AQo9ofi2acObfNmsesVnAGdXpKM7fYqMEyvGfb7gceUwopz3AAEKMayRvDhxOMbIK3PCDMAjqD3jpML3rx3V6tMkreaHzZnSIEsCybPYCZcvAZ/JDSZbLHg0dirZ9Lc+wO9R8BVmkZ8rqmYnIezkC5lrXQhC50iFKhbmEM7Q4aKtQh1/yZ62JdAfWjUbhTDtD0GIN8tEpPru+E3hwlkk0h4e6w+RKALlAKnOAhWKEdx52z0+BtGxiZUCGfWhLoCIkif2TDj0SlJtgd4r4bE8R/8uAR2EyUj89cOLkETQkO/g94H4ZccZMyoomaK5VzDkF9Wrt5Ma0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vDpv6WYj26CbywHCEgq9yCHVLy0T/ZyIt/0e5gfn9o=;
 b=jJ/LA1IO85WJDRP8FjWPTGt/WNEIMmLBFtGN/yGfBr8BXFv0MMtXOB5B6Z34oqPYuhgVYspgWAmWK0Vk6Q/hegVhgCZy+AD2UGHBQaAJvQYZtGR/ylaj24X/iEjVWN61VUsJh+LGYAZmmH3xd5trzqtFwTrH7Z/zqp29gux8HtifBnV9FBGjvB/S4xSgJCYjZwKdqxBLZ3Wqw6BTVYWikDeSxL5YM7qzq5L5E7Spv01RbxnaZgevvHOZ8E3oG+/NKUjxJK845p4DYF5MCNXcwL1liK9iz9s+fMM1Ab8D10+MdxM3j2d2Z5TkuDw9fbQIGWgq3m1R3MtBmV71IrT6hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vDpv6WYj26CbywHCEgq9yCHVLy0T/ZyIt/0e5gfn9o=;
 b=YLRBajLJAAaalvF5cuEu1vFBaxycFpJvYuwSrRmjhxAySE47hcjHqr1Qb1l14PP/4XH5qXCeOtixkAkQ+KCRS8dnoFYnV/gMI47bdlz8z23Fvtlc/Ohsf0JEIkt/CgeIJYt8sq01WP+3d259OVW1TSCv7rBYgaeXLzcY/R8JqJY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB4461.namprd10.prod.outlook.com (2603:10b6:a03:2d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 18:04:56 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%4]) with mapi id 15.20.7698.032; Wed, 26 Jun 2024
 18:04:56 +0000
Date: Wed, 26 Jun 2024 14:04:53 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 14/15] mm/mmap: Use vms accounted pages in
 mmap_region()
Message-ID: <yhaz3jyu6cfr637tbgywsr42e24fmjcs5cdjgggkis5acikyd7@6ejqra2w43xu>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Kees Cook <kees@kernel.org>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
 <20240625191145.3382793-15-Liam.Howlett@oracle.com>
 <202406260928.0A22BB0F0@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406260928.0A22BB0F0@keescook>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0294.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::18) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ddfacdf-cf51-4232-346a-08dc960a7c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|1800799022|7416012|376012;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?xgdQO0iPhY4SrPWh4F6DI6GVd+b5FRICU/aUhnF9iYz2DIZMja5WI9hsQ+UY?=
 =?us-ascii?Q?JKAHXMKg8HsTMZI0YQkag1YEbPA5+B2XEueqRUWrXO25/JWMipnWAvhP8PjK?=
 =?us-ascii?Q?GKWCMXfw/bGxnPcO1rrjF1cHUmoaKbZ9xBaUFvZTLuvaCQs0LUueZzVF+RNt?=
 =?us-ascii?Q?Q9TfHsmk5qpvd16ltxQO3665uIeuSgpjxmMqcoZ5fp+Jnt3JgueMHTaShKbj?=
 =?us-ascii?Q?8XiNhcS7X5XbJK+uaYjJimZWarc1vejNueew3lNaELbV3NMi0UJ6nfRgd37w?=
 =?us-ascii?Q?tDJcXqG63hRxQ7D+IOqsOZOhBuahqmVUC2Jzd1l3qcvoc7+2mQBB5OEr1CnC?=
 =?us-ascii?Q?02wvKTgd0i0dIJD0GgV3tBnTINc7EdwR9vOimq+6gCDe7UWUYklvM0Bzu6/L?=
 =?us-ascii?Q?DK62ukW6aUOdDTkfZC83uKm0wBoM3XhGLIoOhgNCq77209eLl0GGSgVJ2GKb?=
 =?us-ascii?Q?rp9kHQpJq2tZJBsAfQZ42qsf189PAQKqPEjASPBWztCVbhjr5GAXY6EsBgj5?=
 =?us-ascii?Q?KXF43V3ElPnjyHJIYkaTj01onJp3uOOHqkEW+Enh6s6numVo8f+PgOo63UGJ?=
 =?us-ascii?Q?ub/86RBO6VlF+vcWyT0BoICw88BP6jAf4H39dG7y+lgNyTJtmdJHg6WNVuUY?=
 =?us-ascii?Q?3/QsZbc8JZ7rOOGzsj8X8DvpkDxDUYiM92AhNLH6kIx0CH3TbonluMv2caMw?=
 =?us-ascii?Q?9kxm3u1Gken0lVvdoCwn8zT9HPz4OPGNamfmtOtGYVD309LsDOWpEaSDFOxZ?=
 =?us-ascii?Q?PCvtawLYlExgQiPqvwJPkES8JDRWKoju+6tlG+fQjAjUcvHAWQvWGCteXvJ2?=
 =?us-ascii?Q?7YSKRlOFxsJpr3rBpx7P+35FVzOTehPHJ21MdhOzJDcmFzoRtHhKi+e5D9ZD?=
 =?us-ascii?Q?LgjBOSKbl5gFt3BXoGXbUuhPjxkqkVrhQ7TAXLCfnVBPDIZvDzpH2HJ0ae5G?=
 =?us-ascii?Q?dWVZ3Fd2YTclqOj+9dgV3oP3Y1A3xsnCWTwZ2f+WEqpAht+/ZiO/6eWTug6t?=
 =?us-ascii?Q?lbkOyw53o1R7f0roYKSvdsXViQMEwZGljj74PGNxQ8moLgMb52nFJeZC6Kyh?=
 =?us-ascii?Q?KBfK4tiGy37bYMuE1RicJRWa/BiR6dlTHmupoUaeMBuBoJC14hiA2nzavAOz?=
 =?us-ascii?Q?9D1IEwWFgKEyCJUq2D3hFr9sbcEcZl19zX3hI0F8EzcOn2U7SySjKWA6bTlg?=
 =?us-ascii?Q?zVK6xvTWxWNuNa1fWbUDHeSKlONCPzKK/RTB0wJdekD6uvddgh+dqTNEtvBx?=
 =?us-ascii?Q?GKULc3NkUDsP4tCYwGwC9nQHXgnTX0LXv5MpZxJx95Gjj0VJjnOVCGCsvXhn?=
 =?us-ascii?Q?ieKEVf0jUSLEeReiBOD7xlrN?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(1800799022)(7416012)(376012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WqclZekgRLO22lCt0i6TKZqWZjm+aH8A8Yb/fseFtl+HAgn5ik/zmkn0u0tz?=
 =?us-ascii?Q?9t3mXccTjAw3wi6EIJZd2yE9fmeGI6bFFcV24NaKR7fiiZsDRE+tWDm9xkNq?=
 =?us-ascii?Q?PKJXUVBOXRKIdTFnzx0xC4EXL9RyBgQGVhVyH1zYKiQIKsiCSGmxmy40bxjP?=
 =?us-ascii?Q?U52i52YCI2yx6bcUh/icaK4AtN5WxnyoR75H4J7HspvaUSkAXrDGzWfUzuLV?=
 =?us-ascii?Q?RcqbCIf2yGcYR/4yzuXi3YieouEnJJZN0zx+E0r9tbzYuYsmhc/0CBLQReIO?=
 =?us-ascii?Q?XXk/USojglUvLSDat0RxddZ2yCiWpPZVxvW6y8fxvEnZpKYFVrPS0OlU0AI0?=
 =?us-ascii?Q?LUjYVndOKhRejs7Zrd/1yg95vI3COE0kiES8CQrygv1s2oWDssUPx0EvI5AG?=
 =?us-ascii?Q?SY1GnMJbKhmF5a848dppLtAIsooPGGOJ8C0JCupO3EVDB3ZuBiVIPgTE53ah?=
 =?us-ascii?Q?axNOT3Mg8lTffD/bXl2p2hO3ot/c55DXUcua38dxF7al0+TpBXCs/0WiA+Qj?=
 =?us-ascii?Q?J7CLF4inegy4sG/Wz97UDWthfzv5hD5y3x5SF5G9H75y+IizPvHwQCYfbKcY?=
 =?us-ascii?Q?DsuZD19xee5t1btlJ/h3eTbWDA2rNevLvOdtolaXRKoLraWo82g5ytnP0aMv?=
 =?us-ascii?Q?YeygFXL3LJzq/fsCpZd0N5VyDQNthbRCMLYDl4yrtdL0gOrjVTunf8mOjekw?=
 =?us-ascii?Q?ka/Yz6e61BvZYPtglehPTKMnhF/+AS0+rFARmD4BMnzV6Eff3tlVM4xOO3gi?=
 =?us-ascii?Q?MXfBJ3b71Acos6wEga8rHRseSA8wSP/5UuhwFMKlsyZQDTsp9DPiCOjhXY6L?=
 =?us-ascii?Q?jSbFvkMcltyd1utXX27O0Jai5yp4ic3nCQsZsLDTMg3S31NbG3JL3y9q2BOl?=
 =?us-ascii?Q?0MNGbt0bxohn4XGLtkBUiWZA4TYFhOM7KQOAqr3ihpdgMGHvYnbuVMEOFzsg?=
 =?us-ascii?Q?n0NOICR77xGb1hnAz74joVjRtz1tl+FDDzgDPh12wrJimLLBBq71DBn1qeuz?=
 =?us-ascii?Q?2Z8ujeCAHbTB3u1AsGY7J7PHQHKZo0A1DX8B0QcqcHtklFPb8JdA8+dECXtD?=
 =?us-ascii?Q?7VSkLzFzVkj6qMLGHZ2lTJuxTOUd56NfF63CcMRx6mSr9VbgJ07YEyTytKDd?=
 =?us-ascii?Q?llzfZyK325G8JG6P3FBC2sgicXHN+PUlVTmuCDS6GH6IUHHGtCa4pgaKv1+1?=
 =?us-ascii?Q?Z3cl7aU9hy5j+SfdpY2ESdIAnNFsNhFnI/BV/fhlAOjI80Ijt1qGWdwhL/pc?=
 =?us-ascii?Q?7xif+GTi82oa9iv3S4o3ONlHoNtoX07fm80TMPZWVtqhIKQH51XWKCT+GhF1?=
 =?us-ascii?Q?DPTA6OCxbib9GUYNuYpEGulXeqgbcK1nZzhS7NaHfzEubfcaNq69tzt8d7fl?=
 =?us-ascii?Q?8EMy7txJSEdjuSBwF8nFWYdDEAadTgmfzVOh7YEP7au9pcGvdypSCgTD/iYr?=
 =?us-ascii?Q?ciGUSoPTd5hbxGG4gm3gcGP+CXaRYXFtztHkzkG7eM1+F0aYNuuimb2Gqokr?=
 =?us-ascii?Q?azyrR5/NG0tjsRLvtDCNj9n8KWW7I4zTnPycCjqnmmoryMHCHAiXvc0wK90i?=
 =?us-ascii?Q?DFa23RMkN57jCPpHDgmNhLbHkZpCKgD0rEOWv9aFAeTbC7TC4cYYP+EIy3D0?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jNiJKZm3wt7tmBx6nS7axRy4EuOCwF6Xn5vj+olwKtrl+1ddqM6BL5jMm2RtETSZZaymZu2fRw/Vd8VC7yv9Gnd30trOxCEwpxc1uiomlKTt8ILvSSmTa8rPfK3ceBTt9uV1UTZrL3+fjR3NGokqcEXSMuI8ASrsfMruXuSdIrQbtzJy9OOQ14BlqY3Mo7OOFzqxceZmf0RzgPUfVZlFR89AG2wKdnTDYbGOg21HYS1tAB6Q7ngNSkjWJUtqOY28DYxJUVxumy3xodgFfvUiTFL+piMuSO08d8s+QkJs5ytfGoIlwuU/0UtcVpAQ13JyPI5nxrWkGGpWSMxcJ+JwOcOSadCNVeOJu4CRiODf79BAOGQan8WP2ICFEJ3haURQ/DBqHQOh/4O9qCO8qyvbth7qvO2a++hTEe1NJ/vzrJv08rd5FubjuIuamuSNGvHSDbyxQyY3MLdDwhhM4qivdyvtUOh+tI2oYCgZeei6ePOFEVGWpmb4L7ULbZd/cGFgBqwPMTc0KN2cycOhyxoVfXXXvqGPupRgIdxhz7MRC2WtHOEmWD5xxoyPZrV2E0/1AIzt7Glaa8JOX4BlQdDf/fB1uOvSKxuFuLu4Oeg0bKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddfacdf-cf51-4232-346a-08dc960a7c61
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 18:04:56.1813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZVTzEHUb2iVJkCrik+07pC6cieQsM52NatRyF6hvpvWDrmZbKN6TRovUz8Mydppfv08DuLMlzVExkCwFqQXpAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4461
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_10,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406260132
X-Proofpoint-GUID: RUpS5G4AsbIUCFYqXeDqk5k66FqqqAo3
X-Proofpoint-ORIG-GUID: RUpS5G4AsbIUCFYqXeDqk5k66FqqqAo3

* Kees Cook <kees@kernel.org> [240626 12:32]:
> On Tue, Jun 25, 2024 at 03:11:44PM -0400, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > 
> > Change from nr_pages variable to vms.nr_accounted for the charged pages
> > calculation.  This is necessary for a future patch.
> > 
> > This also avoids checking security_vm_enough_memory_mm() if the amount
> > of memory won't change.
> 
> Is there a reason for making this change? (I.e. why not leave off the
> "charged" test?)

Before, the munmap() completed prior to mmap()'ing the MAP_FIXED vma.
If we don't remove the nr_accounted from the charged, we risk hitting
the maximum limit.

> 
> Looking at the callbacks in the LSM, only capabilities and SELinux are
> hooking this, and both are checking whether a process has elevated privs
> and are ignoring the "pages" argument entirely, so I'm not sure it's
> safe to change the logic for whether to make the call based on an unused
> argument (i.e. the LSM may want to _always_ know about this). On the
> other hand, it looks like it's purely an accounting issue, and if the
> page count didn't change, there's no reason to bother calling into all
> this to make no changes to the accounting.

I didn't see any reason not to avoid the call, but your statement is
valid.  I didn't see anything looking at the callbacks that would have
issue with skipping it - but I'd like to hear what LSM has to say.

I don't have any objections to removing the extra check, if anyone
thinks it could be an issue.

> 
> I've added the LSM list to CC...

Thank you, and thanks for looking at this.

> 
> -Kees
> 
> > 
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Cc: Kees Cook <kees@kernel.org>
> > ---
> >  mm/mmap.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index f3edabf83975..adb0bb5ea344 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2970,6 +2970,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	} else {
> >  		/* Minimal setup of vms */
> >  		vms.nr_pages = 0;
> > +		vms.nr_accounted = 0;
> >  		next = vma_next(&vmi);
> >  		prev = vma_prev(&vmi);
> >  		if (prev)
> > @@ -2981,9 +2982,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	 */
> >  	if (accountable_mapping(file, vm_flags)) {
> >  		charged = pglen;
> > -		charged -= nr_accounted;
> > -		if (security_vm_enough_memory_mm(mm, charged))
> > +		charged -= vms.nr_accounted;
> > +		if (charged && security_vm_enough_memory_mm(mm, charged))
> >  			goto abort_munmap;
> > +
> >  		vms.nr_accounted = 0;
> >  		vm_flags |= VM_ACCOUNT;
> >  	}
> > -- 
> > 2.43.0
> > 
> 
> -- 
> Kees Cook
