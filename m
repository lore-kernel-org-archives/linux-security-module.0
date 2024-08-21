Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725F613635E;
	Wed, 21 Aug 2024 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260630; cv=fail; b=gOumKRDCQOu7nOM7C8SwrXP/JOMXckUUd3Ffw+c0fxTM1+4///a7t7LfwpA02+EOFlYV5LWYZGLN9DEME3bO0YbBpVOr6MHQktkZsjaRfRl4GV8RniAR8w8COPJxyi5Ozi2jvTFVs8osT7Ya2M4rmI2HH/XxgFWCFIW6rWBHzZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260630; c=relaxed/simple;
	bh=vsZrd30ik8tsq2413CKJHiY1q8i+ClJVr6fHMPUOmpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pTMc6GiV5kJgTfYFVE2hKyYMIQWnsaUJZIwSPVQ8cZFKEDimCjkcu2wiYiHA82agXy33zoOwlhM48hWifQ7NpniSGr4x80U2LlJukZzLuk0ClWPoXveaQsheOBxHgs6YK3+sQ1NaD35bk+hGfGRrJreESnHPAVcXij97DgH+rIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LuEq/yCM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GmBB5R2T; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LuEq/yCM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GmBB5R2T"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LDIalc028666;
	Wed, 21 Aug 2024 17:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=Zlj066uPC/yfVo0y7nRpXP9xLCvxyuNWicljBst9aMQ=; b=
	LuEq/yCMvbvdc+LGH6lQDzYPpzwmJNv0iueibYh8jgTc4JMsk9AmBMP+9+t/56R6
	peFGudifyShjf6prI7VcKTCAg/57jWDlQQFnWHLY5SnwoUHCOCLn5NXk2NISyXpg
	W7Ii9we/Fnk5F5R40ub4xIUl15KDQGc0W1kGXLjMTEAPQbJNjlLMNRtZntMdLdSk
	sH72O/FLQgKNehRMCKBmnB3M2DzIOdeSpeArTA9VyBJGAquJxr5nX6fBATvPRuVh
	d0Gh0OMu0OY0DIaKE0u3WwJeK90tnYEDamEI+ghyC4XEAbdIj0xHvYjBDzH+B2Bh
	uHVmzrIChjd590zaGB7RPQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdt03rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 17:16:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LG3mDW016667;
	Wed, 21 Aug 2024 17:16:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 415ke63a5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 17:16:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fslgQzWJAxiqm5rCQkO20iMJ7LEg7cBUHbmKPTOR4HMYZJygwBhdBjYnZeJMVJp572MxdhAj2/rNib/BcsxneCUFnkBrneH7WT2AHqONNPRKrNUzxzrtZMs33AY1TnWgxA2YGW+f2JSF6RChc01NGvUoPCbQCNnYRTrM8lgXQB9RU5l5Gz74nJVCgj/xGPm3f0od1wFqRsEygxFlWxwsaZ4tKicJJ3+0FG4UbhW9wod+Q4MMxrey84EFCJaP7RcK22aKwwnb6bNgKEaBGejRid/KxnAPHIX89oYc2aZVKcImnratBELlNGFa77S4N8uThO/J6PaFufV1k9ExQpzieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zlj066uPC/yfVo0y7nRpXP9xLCvxyuNWicljBst9aMQ=;
 b=gNAGzWH94BFKcYzoeIOY1pZfzOADAeVXfvVU4HX4Rn3s/uIdtE8ZxkNWc/jkKxqYvb1It1LDec0XhwSV39loMgelvBpDxC9wa+heYXLj/BKtUSaW6o4FVzeQ9GDE7VS1l2NDPbtIWYr5Bo7l+r1UJk+pQkbUuAAhJor8zyevURgWBlIbN8dtyg136fwZ7l35eSNmeWjKV4MT6Ubhm+CR2muKsOSf+h4RnAVKydl2tUu0jFpB67MbXtGMaoK++48WO0F+9rlX0pnxzLX4ZLVfD8HJm7OaGUiiuqrjgB+3KzMQA4vkbMNU3R5AZI9drK0ANyFAFrDsjhGwQgMEjOAfMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zlj066uPC/yfVo0y7nRpXP9xLCvxyuNWicljBst9aMQ=;
 b=GmBB5R2TNf0xx/NXAJDVZd7cyq1NyOkLB/4T7VD23GQCS6Pts9UfJf1tumYDFhvMBv6gTxXtnaydoQj7oEsS+WIXRIN+V5aHGoSkbL3LjUr92bnCu9Z+ssgyEgXuuTExlDbxD54br0+rUHYlNuOTmzVUuUX2XC30skuLBJA2Sp0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SN7PR10MB6384.namprd10.prod.outlook.com (2603:10b6:806:26c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Wed, 21 Aug
 2024 17:15:59 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 17:15:59 +0000
Date: Wed, 21 Aug 2024 13:15:56 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 17/20] mm/mmap: Use vms accounted pages in
 mmap_region()
Message-ID: <njy7dm425n3tjbv7zy4i66gnewz6gkxd3ou42jgk73zfn23i4k@yn7apymvp2hn>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, linux-security-module@vger.kernel.org
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
 <20240820235730.2852400-18-Liam.Howlett@oracle.com>
 <CAHC9VhTWRMKZiximDFAuhY0PwvHt8rk913LLKLQu20tjrnN7cQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHC9VhTWRMKZiximDFAuhY0PwvHt8rk913LLKLQu20tjrnN7cQ@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::27) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SN7PR10MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: 183f9cc4-c9c8-4eee-1ff9-08dcc204ecd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTBydkRoNXNiYmw5VHp5ZXZGSkd2NGp6QUVnZlp2MDFqTVN0SGRxQmYwUFJB?=
 =?utf-8?B?V3JURWxrNFIvZXp3c2w0L3c5bFVoell4WVFBT0tyVWpjQWtWdXRNZEVMYjhM?=
 =?utf-8?B?amZuaTlCQzFMSVArVEJkSC9SZmtlZXQxK29NQzhtWDhPQnFNYWRuaHJwTklQ?=
 =?utf-8?B?OEpJTlAvdkFjdUxTMS9ySkZHVkg0Z21MeVR6ZlpTMFNnT1VGYTNHLzJXVUFX?=
 =?utf-8?B?V2JBbGpMVFVISkVyUjFDbG82cjYrZENpOFkxOEJJalJ5UzZNVFlvYVJHeXZB?=
 =?utf-8?B?N1d5NGJtUVNTTStSVEVkUTgxUGJQeEtYMXRFejMwaEhlSTZvVzkvejRqZGJX?=
 =?utf-8?B?dzZ3Q2pGcDNYK2JwZloxdmxkaWlxQ0hLVXVyZ0gzcEJUbEdPSTJDU1MzQnlQ?=
 =?utf-8?B?OWkrVHllcktES01oc1NBbmU4YXV2VW1LM3JLUlozelJhdWxpOHk4akhicEM2?=
 =?utf-8?B?VHcvNWRmVVBjMTd4S2w3Y2I3UndQZE10SUQ4WHFvUlp2MFBpU2xDSGxqUEdj?=
 =?utf-8?B?NWgwTUV2dkRaT2JCREhJQkFCWGEzWmNUbDVaeVZ6dzdQUUVpL3AxT1ZhN2Qz?=
 =?utf-8?B?ZldXRDExSmJCWnRZaWttUzYzV1MydDJSUndvTFRwR2JWU3ZVN3VQSXZNYXpz?=
 =?utf-8?B?a3IxZEV3ZmxjM1l1clZWSlFsNGt6TjFBUXJFQUZBOXh0a0NzYVRIcXhQK09X?=
 =?utf-8?B?S0NUUHBwdlZLdksrVmtaN2lTaTliNmUvR2RRN1FOeUJVYmFSeklPZzg1VkNS?=
 =?utf-8?B?Tzk0aER4M2lGKzJsMzMyNkpZZVJlUlN1Nk1sZ3V2cENaUDVjbXpIMVJ1NWtv?=
 =?utf-8?B?UGpBVXBrakNUbjl5UVFxOVNzR0VoZUJGN0JwMjBPUGtsMzdubEZJNlpUTUI1?=
 =?utf-8?B?YXZtWHlOQ0wvN281UEt6Qi9wVWhvTVMxZHJCdzRvRGpNQkRPVEhGSVU5Y3ht?=
 =?utf-8?B?S3V5SzMraTh2UDhiNENiOVRVNUMrMXNSaFhrZUdXMGRDUHhVZHp4Q1dqeUJ4?=
 =?utf-8?B?a09SUExBYlB1Wi9Tc21EY3Z1azFZQ2x6OEZaMVZjNzJ1bjRudDdyRG51L1hU?=
 =?utf-8?B?cExrWWMvdDltUkZadit2dUQ0Q0hVMXRtTlpFeGNXYVM3R3JueWhEaVloQ3dY?=
 =?utf-8?B?NGtoYzlGTnJPSXlwTVowUXlaaGJ2ZjR0UVg3My82dzRYbzlVL1hLMUkrb3JI?=
 =?utf-8?B?ei85TGFvanRvWVVaaXE3em42cDNBbXQ5QjM3WWVnVjBOL0cvQisxMi9yMDE5?=
 =?utf-8?B?YkJvK3poaFpsRUJDd2ltRmNscmFEYUlpWnd5RndXYlRBZStVanFUTmYzck5r?=
 =?utf-8?B?aG9YQnU0QmlqdU9GeW16T1lxcWoyRUgrOWdLSUthdzlhU01JZEZJeS9JTFlB?=
 =?utf-8?B?Nk9ReFo5THljQ3gxUmg4Tlc3Z01EYjJlUk1LdGM0SmFienp3Wmx2NEJuS3Zx?=
 =?utf-8?B?eFk1cVZjWmEyYW9vQ04wWWtJMlhxNklkWlhZNFk4Y1llK3ZkOW9yQkVFdGVQ?=
 =?utf-8?B?elRMS2Q5UC8yY2JlTFlQcEhEVkt5OGlWcURnYkhtVjF1S0FJMC9xeWRZeDRr?=
 =?utf-8?B?OG0za09QYVp4cjNDTGdPRjJmeUdoRTZxbVFET1VDVjlGZFFZR0ZiRjJ6NDJ1?=
 =?utf-8?B?eGt2V1ZFOWp2R2Y5RXhEckZ2WERCMnJaTisyZHFtOVlNeTMwTmxIa1NMcUs4?=
 =?utf-8?B?WTFhUm14cEpBakRaK2tWaXc5ZW8xZDRIeThqUWFyTnZBTmpCTEtveGJwL3c1?=
 =?utf-8?B?Tk5iWUZMYS9Ra3RGeWZJMThWcWRUVTcwMTFlZVNIL1dHcHBBOFNmeFR3S08v?=
 =?utf-8?B?Mm1vT1lpaDE4UFVTdCtvZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkdEaWg2c0NEeDkxYUZpb3ZhR1h1dnFuK21aVHY3TDRkeVl0dWJRMmhvTzg5?=
 =?utf-8?B?Qm9wUGFXNFNMQ04xV0k3d3l2MlpYaHB4NHBmSGR0ZzJ1ZlZpQzBvUWg3N21x?=
 =?utf-8?B?aXQ3bEJNSmFkcmtlRkozeUJDZVdyb1h5akVLRGFoMWNLN2o0NVEwZVhGblFR?=
 =?utf-8?B?SlI3MTBhV2p3R1JZQVVLWkNnUXlXMjNDc0M1cFF3ZFdNMkd3QlBoVDc3ZWJG?=
 =?utf-8?B?VDNObWM2VjZaMXZwWVNmTExNaHZrNnR1VGpDYm5qYjd5ZThZY085UFJ3Zldu?=
 =?utf-8?B?NTBCQ205UXhiYWo2SHJoam91bzlHdXAzK0tBalY5NHBIRUVhdVhSb2JaODNM?=
 =?utf-8?B?Uy9MSUFFMWxHNDFXZWRWbittdUNoa1BJZ3VaalRtUzRUNlFsU0RhUmYyeHI2?=
 =?utf-8?B?RUVRWHdxRGplVWxDMG5JUTNYTy9FRGtHb2ZMYVBiU1FkeEg0MXIwVHZxRkdQ?=
 =?utf-8?B?QTZMOVVTb1FzTmtzbWVTODFqcUE3UHBLTjdpM1cyQlB3TEFVdGl2R2Jvd05S?=
 =?utf-8?B?bmlzL1B3VEh2KzFrS2tJRlpMZWNwakdqbUFvSWg0NlBJZjRTZXROT09HYjdD?=
 =?utf-8?B?ZzRZMk05aDVxOHRKYW1GOG45NndCamFacEpSb3l2Qld5bnJyN0dMSWdMTGp0?=
 =?utf-8?B?Um9vdjRkdGVCYXlaZkp3MjBIU005bWNUNTdwVWZsWUJmMUFPaFRXM3JIekpm?=
 =?utf-8?B?ZXdEalNkU281QkVNRGR5WUc2aFBmUXh0T3FNZXhDUzI2M3hLaXVvYzlIei9Y?=
 =?utf-8?B?OGpiS1Mwa1BsQ3ZkK3ZYVlExTWlib1JDclowcDVEc3A4OW0vTnZOT3NWVWxm?=
 =?utf-8?B?bHUvTTZBZElMQlZZSWZ5MktIYXBTQ0RsYjFqWThuUFc1QkViZGU2eUZzQWtZ?=
 =?utf-8?B?ZnZsZmQ3NGVCSmIyMjEwMWg1cnlVVVB2MW5XRzhMU2daVGxaL3ZUc0lWdk9i?=
 =?utf-8?B?S2l4b0J1SWhKaUVtakJvOGRvSjBhODdHMDJsUUZSSzlRMnFSTXZZVDRHTVBi?=
 =?utf-8?B?RC9nKzJJS0NUVHNHQm1IUkczVTc4TktYYUEyNXFUeEdkMDQxYXFxL0l2dm5E?=
 =?utf-8?B?c0xLZmVKUW5QOThkcE9OQnRTY1UzWitCcXI0SjlscmVQV0Jkbnc2ZjRoM2pz?=
 =?utf-8?B?RGZxR0RWSzgrVWZxSWtoS3NlRVpWK3dwcVc1dDV2ZWhiR2pvdlVsRktaNFhB?=
 =?utf-8?B?eWVIbkFPTkpFYys4akFYSFNLeExZWDdrVkJTWDVicE1KNGhxeUlIbU44RXJH?=
 =?utf-8?B?SlZFZXVyakNmQ1h4UWs2aEtyZ2V4VW9iNXBKUjhXV1ozdVlCOXlJaENuMUVO?=
 =?utf-8?B?dVR5NXp4MHVQUyszaVhpZlBDSXZRUDZhS1g4MGRvRmR2cXBqeFpkQ29ZcWEw?=
 =?utf-8?B?NU1wTmVPMGxpeDhOcGk1YnAwZTJ0SzE2UE5TQ09zSXkwMEYza2FnckZjQ1dj?=
 =?utf-8?B?eGtSTk5tYTdMMHdWeFk4SUdNZ28zRFRhSFNCUWV0SmNqLzlVNUNKRnhsc1dR?=
 =?utf-8?B?Q2s0U0pjTnN0dVFKL0N0RDJMcHc5YlNnUWVXSXZ4Ym5xNVNCaXFYSVgvNnlT?=
 =?utf-8?B?by84TlhmVzMvcC9NMXozT3g0MlJIRVNOWmtnODFxanE1MVRZaTRGemNTa3Mr?=
 =?utf-8?B?SEw3NWxZSDk5dWNYd2g5QWJVVVRwVXplc0hlVThjR1YxTFFnaENTNFdkVHM3?=
 =?utf-8?B?OTZkbEFhdWJlYjk5RnNLeXJlMlpMOFU2anFSSUdUY1EvTDgyTTY0VWVpdlE4?=
 =?utf-8?B?bEsrc2FTWEdoNWtRRmUxa3NpZTliVTdHZXlmTnhkUWladmdyaHIxS2lFR2pJ?=
 =?utf-8?B?N0VMMUdvSlluY1BvSFhkTHcyWXBRRm80NDdrejRtdFo4VnpSZVZ3OCtjdkpK?=
 =?utf-8?B?SGpUR3VoaW9sQ2NvWHA1M0d3VGQ4Uit6bDZOeEpYdGRUR3NUaHJyaEIydEli?=
 =?utf-8?B?eVRRdnB1RGFsdDBZMGx0SklLQmprb0YzMTV6Yy9hdXNKZUhJdFQyNmRIODVN?=
 =?utf-8?B?YllqVXBsdHJFV2hES25ITloyZXZnbHlqUzlMNDVzVzdvQlBWUkZoUFl5UGpQ?=
 =?utf-8?B?S0t1WlREaWRJU3ZLZnA4OS9maDM5TFhJb3pQbEI1N21FVDUrY2xsb09sK2hw?=
 =?utf-8?B?V2ZHa1JtKzdCdU9JM3liMFZyN1Rndlh1RC84cWhJUDhWR25oTXdBaVFQNXNX?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j8b7fHGYgbQc2OZYRTv15GsAMBNQnZ4REpqJQECUf7cH7BCl+RTe1WVCgUOLGIe44fZeW+bsWr337CIFxUX7HOZICFVLimNk6/WUEX8gJb5+PrdHaqaIkE147a4wb8Td8QNNkom9Vq4vZhx18rzNO/iwMLm/U04lJfcfkc1gXMm+Ia5b+Ctmesl7dsgpfMKXSr4YTCdgjIcU+B8DHmSIVRhYFoXMbz++Y8/Yhp80JF1RgEC+tCd0eCOgpj4gpiz3JKhIokfRun6gmYS/i2PuLyulZx4NxNUEvT6RbULZsAEu64kTxx/ZXFMFCPTgnw5xUnTsMI99pQMDWvxHCDli0JLqH8Hr2FKlz/jsKftO0vDNGpQOZRKGgSy4pEQ+fQVryLU0wEzqPomYRET9ZeZcaeW8BJImu7wTaxJv1IsZrb1w2NmUjlxETNe1vlzmyM8cD+J21CdYowLcCCemAI6S5vGgTl5MDZeluGCl86QAjC6kQDymaouiAFAiMJwVNTY1vpWbGjJnqPn46AXisNR0Pzh2f0UjMwrYSq/sOtYOwvcnRxaxIv/26GKtjImKsArfG4pa5uJqOEHn6wutqcweBUaD0/BkYosgSg9O7INZeBo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183f9cc4-c9c8-4eee-1ff9-08dcc204ecd9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 17:15:59.1144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwycO5HVXHmBfaoW8aACcD1N8W+UFCJ8JzWv4CkjrhxrVdMr2qZxZ/iH1OV55W/TwhNh36oZlNmjIjYtca3IPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6384
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210125
X-Proofpoint-ORIG-GUID: lln0kHQE4foe34SuKjqDFjZJO1ElYfs9
X-Proofpoint-GUID: lln0kHQE4foe34SuKjqDFjZJO1ElYfs9

* Paul Moore <paul@paul-moore.com> [240821 12:35]:
> On Tue, Aug 20, 2024 at 8:02=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Change from nr_pages variable to vms.nr_accounted for the charged pages
> > calculation.  This is necessary for a future patch.
> >
> > This also avoids checking security_vm_enough_memory_mm() if the amount
> > of memory won't change.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: linux-security-module@vger.kernel.org
> > Reviewed-by: Kees Cook <kees@kernel.org>
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/mmap.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> I'm pretty sure I already ACK'd this, but I don't see it above so here
> it is again:
>=20
> Acked-by: Paul Moore <paul@paul-moore.com> (LSM)

Sorry for missing that.  It's here now for sure.

Thanks,
Liam

>=20
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 19dac138f913..2a4f1df96f94 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1413,9 +1413,10 @@ unsigned long mmap_region(struct file *file, uns=
igned long addr,
> >          */
> >         if (accountable_mapping(file, vm_flags)) {
> >                 charged =3D pglen;
> > -               charged -=3D nr_accounted;
> > -               if (security_vm_enough_memory_mm(mm, charged))
> > +               charged -=3D vms.nr_accounted;
> > +               if (charged && security_vm_enough_memory_mm(mm, charged=
))
> >                         goto abort_munmap;
> > +
> >                 vms.nr_accounted =3D 0;
> >                 vm_flags |=3D VM_ACCOUNT;
> >         }
> > --
> > 2.43.0
>=20
> --=20
> paul-moore.com
