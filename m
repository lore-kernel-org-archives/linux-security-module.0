Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24248129A7E;
	Fri, 21 Jun 2024 04:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718943162; cv=fail; b=rQzmrhKWlFuWA04hG2rAe9RMhpcQVATgYQ8oaYIqb2ardyET/YHuIl0lApk0HhxiLWywaItRh73ABszgIo+BUO4xo0LDFRVlPAK5Q3zkmcEcbt+r+PFxxFzlr1oIaQhpvQh+DmEJWhf6RqrlPl7+ma/BvW6B4KfvW+q4hhgD8us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718943162; c=relaxed/simple;
	bh=wDuUJ6nwtlTl908slojYBFnGf4G5D/AAl1SlIopYUTo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cW3br4RJEhefbHDQGrGTA/WSwE0aUiHU6MmGENJ9XACILKCIRf/8SdxcZiULeqiTlH9mP5EGZrYAZ2hJ2k5Stxx7FvJs1uuat7z1oLx+mc/Ns5HY5YNC/W2KtakentH5vE3bKSKuJ+bIc/Cxj7yE4S+fhi1YKsGPqs0H4dfWhvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lla6g636; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lla6g636"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZG7hvm7x3c1OpUKaLOwn/ghHzPBeoS996IzKGOVoRtDjsPEZ08pST0O/ifX23B4Al2iwmAS4LLmImqk49vwndhvcmBq5CS+soVsP6uSj5MiDithfeo8IstDShMggE6+C/bqL1mN5+miBYbDqXxebghRiqEQEZDx7A7XCQ3vLK/OQ0x7lXcQtUCcR6rNRjbpCkGxv8zt0juxu8LssTttPAxhZjoRq1QLh2P6WKuUdL76ZITLjuc+FALapl4Un/IgPjuP6lm82I4iN0h7Igtg2SNLdovxs7eXlO5fFGIyGg/DOr50fbEYKin5eGgc4NjRdUNR0j/vZ4hgz5eGDSD1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XIPowz7T+JjWF6FFEtXgD1omLI+a9Io5tCGekOSQLY=;
 b=jO8Hjm0U2WSdn54nxpytl/OUjzb7/ZQM9Ugle0F7ae/dB5RSYepm7i4vIoLRtoYde53PXgB9SxNxWSGWlRQ5tbiA/zw8vgr/U39k5AztQM6wmgFfaWvpA/Hn5c2iqcDxa8MS0dO6UdRgYuRLZQImMtO9+7lKpOq88ctwKBBFfL2znBRYg8B/8Ix8NelOfztcuPhg/xtaGQhcbmGEw2ExabGr+cba051CbbHNWjNuLwB1Aen10WAyfzWCBcnzKNAH7VsSIzp0cKGqheXQNP/0Me6REIf0WJ3GcZuxjlxASUDmWwyHKl3aSYow427fYFfFZlwRO7YX4zH1M138mC9o2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XIPowz7T+JjWF6FFEtXgD1omLI+a9Io5tCGekOSQLY=;
 b=Lla6g6368Te1OQnKN02Vyi11/KZ35gr21SpJ+hiaFYfJLEOfby2vAYHoLoE//eJHdu+/273U5jr1OP+f9UgaYHX2IOn4T4w3Y5ZlN9Mg3fTdHKZ9dXbAS0MfKhSiRQ5K4/e8aCPVi4O7RrLUrFmRXmH3vXwtB9gY+TskC1GnmGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 04:12:36 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%5]) with mapi id 15.20.7677.030; Fri, 21 Jun 2024
 04:12:29 +0000
Message-ID: <5daf11e0-e498-4af8-b22e-ad03c7f312c3@amd.com>
Date: Fri, 21 Jun 2024 09:42:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] apparmor: try to avoid refing the label in
 apparmor_file_open
Content-Language: en-US
To: John Johansen <john.johansen@canonical.com>,
 Mateusz Guzik <mjguzik@gmail.com>
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org
References: <20240620171528.167997-1-mjguzik@gmail.com>
 <155a24f7-8059-49b0-93fa-94bcdc058621@amd.com>
 <CAGudoHFsqDS-5ELmy=t2fdQ2Xrk8q+xyfCkZPpb4XA-+6HOpNA@mail.gmail.com>
 <809565c5-e9b0-4783-9079-db27f794d682@canonical.com>
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <809565c5-e9b0-4783-9079-db27f794d682@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0255.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::18) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|LV2PR12MB5895:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8e8fd3-b611-4dcb-656c-08dc91a85dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnJqWGc4NERud3dIcjAyKzdqd1hXWkFSQ3NTUkxiZFZ4dC9jYUh4TXUxSkNF?=
 =?utf-8?B?K2hjTklKQlFwSy9ndUxFOUptREt6b0krdUlmeDRiN0ozMERsQ2JGbGVhbjhx?=
 =?utf-8?B?dnBuekJGM1UzcThnbWRWMkZGcmZrMFVGZUcvSHpGRTZTN01nNDRXNy9JM3Vr?=
 =?utf-8?B?cWhVdUVOZnFyV053eitnRFFKZzZ3MEp5eWxHY3kxWm1EMzNPbzhKMkwzbFVD?=
 =?utf-8?B?TmtpQ3pFYXVOaEdXNDdOM1NOMEEzbVp5TGY3cHRYQmszZlYzc3ZpeTdGdk1Y?=
 =?utf-8?B?VTZ6aktnSGpvYjlHc2Y3VnVVeTlyTnpBT09kK2VzWmFXeXNNTm9kK0l5dlVC?=
 =?utf-8?B?WmJNWjJYUGRPbmZjQTdnNUVpQmorS1NTTW45UFJ2RVVpQXc5TWVaalRvT2x3?=
 =?utf-8?B?Mm5GMElmMi84b0RLeXlPazhwTjV4V3RUUFBVQzljMmZsVEp3eVZ6czU4bldz?=
 =?utf-8?B?ckV2NG9VcEM1K2F4Smgyb1U4NitPL29rNW4wWDd0djVCYzRTaEVHWTY1OXhV?=
 =?utf-8?B?NGFwNENYejJMWmg2Z0d2UmJvQzFYUVNaYmc5eEFtMUpnYVZmZGlFell2bmRk?=
 =?utf-8?B?TzczbksxblViWXkzdXV0UThld3hrMzNhRDZuZEI4ZGV3cyt4Qlo0aDZZVDBZ?=
 =?utf-8?B?VVB1T2NBQTFpNUVTeE5qNzV5UHk0aUNQN2Z6eWN1QThVTjdBc3RwSEdGUnlK?=
 =?utf-8?B?eC8yTEhvTlRsU25oWkhzd0Z4V1Q0a0pIRU1Fc2ZoUTFBQ1JTQVlNNDN5MWVU?=
 =?utf-8?B?ckNKaWVWUUF6UTdEUlFVa09Ja0grb2dPQ2dZc0NsajhYaTM5NDdRdHRMWDhp?=
 =?utf-8?B?MXg4NTN5U2w1cGlvZnNXYTBXQ0VLTGF4RXp0cUlJU2k5K2ZLbVpDUG9nNUo3?=
 =?utf-8?B?eURvS3E0V0s0bGI4QlFCZDA0RGx5M0UycXdETzdTckZkMHRYSFBqZ3VuU1l5?=
 =?utf-8?B?MTcxZGRTRHZtMWdURkxudmkzZWkzNC9ycEovT0dKaUFqekNBekU0ZUxzc2kx?=
 =?utf-8?B?YW9xNGNYSXFzd2cxSTJJRldoVzBMREN4bUgrazAyMWJQMkVRRWo3ckxLcnVH?=
 =?utf-8?B?QnlNaEMvNFFySTE2NGpjOHZqU2hYSit0c1ZOMjJRSkZHQzY2TmxuZFlJYmRn?=
 =?utf-8?B?S0RiVHBvUUVwTlVsbTBaMEJFZnBiWG9ZOWJqQ1Q5NGpaY3kvaHlSaFA1RVZz?=
 =?utf-8?B?VUpHNWwwTDRVYmZXTGtpRWhLTmFTMEZyejJ0ZkRtSzllb25FQ0w2OVNOU3lU?=
 =?utf-8?B?V1ZjUEllSG5sZk5QRlhrQWN0aGIwcm9LYzFNM0dieDd1TTVkM0p5L3VFZzJ2?=
 =?utf-8?B?blEza3Vpc0hLQ1dxcDZJSUtPR1RUcGY4OWJUbWd1Snl6Z0tPWUxJOGNqNExZ?=
 =?utf-8?B?d1JqZ3RMS2FRTi9YMjZJTGZlSkE5aXFCWENWK2hGdEhKTlhjUE9nV0tnTWlU?=
 =?utf-8?B?c2JHSkpxM2hwNDRRWk1nS3lyZkQvS0ZVdHdON2ZRK2FuaitwUmhMQk9MbWdQ?=
 =?utf-8?B?M2NuWHIvWDVCZSthWGxlZk1oejdSSVN0bnlSOWp1bGZyTWVnS0RrOXQ1Zity?=
 =?utf-8?B?clBIYURSbWg3MXdIdWFuVThwNmFNY3JwMVI1bmd3VjVZWXdIYzVWaWM3VVNR?=
 =?utf-8?B?azA0eStvSEFtQThqOXlLdkd4SzhNNXIwRUdaMmFsQkljVlBHRHNjby9iMVV1?=
 =?utf-8?Q?9VFSCEDyWrQqNK4XPwkD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk5xYkVFQlB1a05ac2taZXJmQkFaU1Nxdm9GMkRNQnpibWRNaHhTZWdNbTFi?=
 =?utf-8?B?OFNaME4yd1EyWmZMTTdjUXpJYVRKWW52QnJVZ1hzR3JKZlRLSms0ZVAzSVpk?=
 =?utf-8?B?UXFjZXNNN1h6dTdJTithMVlEZkV1eG41S1FTZWduOFVDNzRUVE52TVNhWWJX?=
 =?utf-8?B?aEdSZGpBQjhxRGh5S1o1Z3dJRUg4SnE2cnZDcWZlcG9wcURhSkxxcURMMkF6?=
 =?utf-8?B?bWJPUVpUZUI5ZTNOMXprMWpkUm9nR3VQRjhha2dLV21VaUVZZ01ISmIzeDJP?=
 =?utf-8?B?Ymo0Tnh2REZHbE96ajZiN2RvSVh4eGtnMWJ4V0FsbzQ3bXpWQ3NpVnd6UDdU?=
 =?utf-8?B?VERhcGx3UEU4R0pLcjRseEFzR2FNbWI5TU1INTNqK2YxZHBMZFlwWlJkNk5D?=
 =?utf-8?B?ZzZ6MWJibkc3M3d1dHZnVmRqdUJDbG1LaERkSUk5NDRXd3B0OHlOVU9aanVI?=
 =?utf-8?B?ZHFTSkFudjZnSDVIcE05OUtrUlNrUDUveHZ4d1cybzIveDlqSlA5SGN5N2Jp?=
 =?utf-8?B?d1NGb054T3BHZ3c3QkdpU0U4VW51eUVGQW5GTUl0aE1TZk1GWVJwcWYwK3NI?=
 =?utf-8?B?bS9wckZoR0FTU2dheWdyVEo5ZnN0WkJhMTN3SzYxVFN3TjhjZVBESHFWYmYr?=
 =?utf-8?B?aVNvN1BWNE94Tm9WSmxzR1Mrb1AwVmdma2g0MnlPOVNQYzJibWFqb1A2ckVt?=
 =?utf-8?B?dGlZZzJZaStlUWZ5ekZsUnIwS2tzWGRQWjQrR1E1Tnh3WTNnbWRDL0R1a3dR?=
 =?utf-8?B?am9FUHI2dTI4aDBST0VHdXE1cVVId0daZk03VkdFNnZ3NkpkaE9rOEorL3Fw?=
 =?utf-8?B?ZjRURmFyR01seWxpdTlxK0VXcTY3eXI3L1RSSjVDT0Z5bnUxRkFHVEI1eW9E?=
 =?utf-8?B?S1J6aEZ2OWF4dDI5d3VXbUtxTmtZZmZDcVNjVUxyNkhud2YrL2RFaEhMOTVs?=
 =?utf-8?B?K1VUU2FUZ1QrYnJkeS9JNDd5RndDZ1BVYXF4N0RyTEJSMVBvVFdwWmZxZXpv?=
 =?utf-8?B?YTVLK2NwR3hnZkJuU2daVFlrRDB6d3cvMEMvOW5Qd2lVUHhCOGlSaXRXbFNj?=
 =?utf-8?B?am4wZ2xER2IxbzU2b0NMOFdXQ2N0R0R6OTJ1U1FNdXVaV09tOG80NUVDR0Fw?=
 =?utf-8?B?RGhhaU5XYlk4KzFFSVM3UnREbkRIVmhqbEN2cjFDV2tiZG5Oa0x3Z2JYM1J0?=
 =?utf-8?B?VUszUlVOSGl0RHBWcWhpTDd3VDMwaFVZbTVMR3g0M0U0Q2E0OTFETXREYWln?=
 =?utf-8?B?YjFuUUxJQmJ4dGVkM2dMRm0zaE1Ja2REUDBPMUVZSksraGh2cUJEL09xMjhG?=
 =?utf-8?B?RnR5K3VOdXJYL081ZERtMmRKZFlsWGdyZHg2WStzT1gyamhqMEszNFVyTm44?=
 =?utf-8?B?VFZDL2ZHdlhVMTlvRjdmTk9zbW0xNS80Q0JEaWRJVnJCcnNORlZBMGN1YW9W?=
 =?utf-8?B?cWpuZ3pCMXp2dS9mVTZHblA4R1doM0RFMk1VT240dlVkVFgvNng4YkNzazl1?=
 =?utf-8?B?RlVXcEpyYTdTaEJSZ1ZwKzhKVGVXQkF4eHdZZldDK05XSTV4RS9DSHFFc0c2?=
 =?utf-8?B?ZVlvS0VsdkFVRC9yQVUxUEN2SVFxOGpQbmllYlBtejUyTDZsN052TDVXRU0v?=
 =?utf-8?B?SE8zcWdKT3VnT3JzbmtrZW9jK1ZrVXJ1UnB0UjBuU2ZTR1NPWVo5d1Q1Y1hP?=
 =?utf-8?B?WFZPZlM4NmRyV0Z3dGprSHAvVzNaQi8zc3dlQXZZKytzT2JEVi9jUjdDa0pI?=
 =?utf-8?B?RHoxT21QYXRtV2l6cjNqWHdrSUhvVVJXTUhTMStXWTU1RkFDWFhaSk40QXhB?=
 =?utf-8?B?RjM5b2RxYlNFb3B2c0ZhV0NsWXlidVp1cmxlWDhOY0I5QWkxaWN0VXVQV0FP?=
 =?utf-8?B?MHNzQkU4Qy82WThRbUppU0FnVk5zY3E4UVpMUmh2bHN5NklvMEhZR0o1R3Nv?=
 =?utf-8?B?anI0NFNjSkVXRWtENFVkZmpNWVpieVlIY3g2cUJOSkFkUzBVQ0VLRjlCU0V5?=
 =?utf-8?B?WS90TFZzK1VCdHljOTRURmtTTzlQSFJNYW10ZjZzaDd5VkRkUmg5Z2ZoaGlF?=
 =?utf-8?B?SFhuK0lCYnZyUjcxVjJlRDliT2w0QUR4MGU4aU9sZUpHK1F5RzRKQ2xEQUd0?=
 =?utf-8?Q?cqXMIn6poAXOu10gTiBfnbwE5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8e8fd3-b611-4dcb-656c-08dc91a85dde
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 04:12:29.8437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsjjDUC47fWfQutLx5vAM1ctFIYBtNdmGU8cjASkZUuHMAfz5de6238+g2BD/HZLr+9Q0lCUn3NGLPoSiAMt8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895



On 6/21/2024 12:33 AM, John Johansen wrote:
> On 6/20/24 11:30, Mateusz Guzik wrote:
>> On Thu, Jun 20, 2024 at 8:23 PM Neeraj Upadhyay <Neeraj.Upadhyay@amd.com> wrote:
>>>
>>>
>>>
>>> On 6/20/2024 10:45 PM, Mateusz Guzik wrote:
>>>> apparmor: try to avoid refing the label in apparmor_file_open
>>>>
>>>> If the label is not stale (which is the common case), the fact that the
>>>> passed file object holds a reference can be leverged to avoid the
>>>
>>> Minor: Typo 'leveraged'
>>>
>>>> ref/unref cycle. Doing so reduces performance impact of apparmor on
>>>> parallel open() invocations.
>>>>
>>>> When benchmarking on a 24-core vm using will-it-scale's open1_process
>>>> ("Separate file open"), the results are (ops/s):
>>>> before: 6092196
>>>> after:  8309726 (+36%)
>>>>
>>>> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
>>>> ---
>>>
>>>
>>> Trying to understand the changes done here. So, while the file cred can be updated
>>> async to the task (referring to the comment from John here [1]), the file cred label
>>> cannot change during apparmor_file_open() execution?
>>>
>>
>> Refing a label retains racy vs refing it.
>>
>> On stock code you can test the flag, determine it's not stale, grab
>> the ref and have it become stale immediately after. My patch avoids
>> the atomic dance for the common case, does not alter anything
>> correctness-wise AFAICS.
>>
>> I am assuming the race is tolerated and checking here is only done to
>> make sure the new label is seen eventually.
>>
>> Not having the race is possible with a bunch of trickery like seqc,
>> but so far does not look like this is necessary.
>>
> 
> the race is some what tolerated because of the nature of what is being
> done with the label. Basically labels go stale with policy updates, and
> we do not guarantee atomic policy updates as the locking to do so would
> cause a lot of performance issues.
> 
> Generally for mediation, the label is used in a read only fashion and
> the state is taken at the start of hook entry and used the read side
> value for the duration of the hook.
> 
> If the hook is to update the label it must take a lock and then get
> any updated state before continuing to update the label.
> 
> This case in particular is unique in that apparmor doesn't update
> the f_cred. The label can go stale but the file will continue to
> reference the original label frpm the time the f_cred was set. So there
> is no race that the f_creds reference might be put. This does however
> mean that policy updates might result in the slow path, having to do
> a refcount, getting triggered.
> 
> The afore mentioned replacement of unconfined and object delegation
> work will change what apparmor is doing here and break this but like
> I said that is a problem for those patches in the future.
> 
> 

Thank you both for sharing the details!


Thanks
Neeraj

>>>
>>> Reviewed-by: Neeraj upadhyay <Neeraj.Upadhyay@amd.com>
>>>
>>>
>>> Thanks
>>> Neeraj
>>>
>>> [1] https://lore.kernel.org/lkml/9bfaeec2-535d-4401-8244-7560f660a065@canonical.com/
>>>
>>>
>>>>
>>>> v2:
>>>> - reword the commit message
>>>>
>>>> If you want any changes made to it can you just do them on your own
>>>> accord? :) Will be faster for both of us than another mail trip.
>>>>
>>>>   security/apparmor/include/cred.h | 20 ++++++++++++++++++++
>>>>   security/apparmor/lsm.c          |  5 +++--
>>>>   2 files changed, 23 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/security/apparmor/include/cred.h b/security/apparmor/include/cred.h
>>>> index 58fdc72af664..7265d2f81dd5 100644
>>>> --- a/security/apparmor/include/cred.h
>>>> +++ b/security/apparmor/include/cred.h
>>>> @@ -63,6 +63,26 @@ static inline struct aa_label *aa_get_newest_cred_label(const struct cred *cred)
>>>>        return aa_get_newest_label(aa_cred_raw_label(cred));
>>>>   }
>>>>
>>>> +static inline struct aa_label *aa_get_newest_cred_label_condref(const struct cred *cred,
>>>> +                                                             bool *needput)
>>>> +{
>>>> +     struct aa_label *l = aa_cred_raw_label(cred);
>>>> +
>>>> +     if (unlikely(label_is_stale(l))) {
>>>> +             *needput = true;
>>>> +             return aa_get_newest_label(l);
>>>> +     }
>>>> +
>>>> +     *needput = false;
>>>> +     return l;
>>>> +}
>>>> +
>>>> +static inline void aa_put_label_condref(struct aa_label *l, bool needput)
>>>> +{
>>>> +     if (unlikely(needput))
>>>> +             aa_put_label(l);
>>>> +}
>>>> +
>>>>   /**
>>>>    * aa_current_raw_label - find the current tasks confining label
>>>>    *
>>>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>>>> index 2cea34657a47..4bf87eac4a56 100644
>>>> --- a/security/apparmor/lsm.c
>>>> +++ b/security/apparmor/lsm.c
>>>> @@ -461,6 +461,7 @@ static int apparmor_file_open(struct file *file)
>>>>        struct aa_file_ctx *fctx = file_ctx(file);
>>>>        struct aa_label *label;
>>>>        int error = 0;
>>>> +     bool needput;
>>>>
>>>>        if (!path_mediated_fs(file->f_path.dentry))
>>>>                return 0;
>>>> @@ -477,7 +478,7 @@ static int apparmor_file_open(struct file *file)
>>>>                return 0;
>>>>        }
>>>>
>>>> -     label = aa_get_newest_cred_label(file->f_cred);
>>>> +     label = aa_get_newest_cred_label_condref(file->f_cred, &needput);
>>>>        if (!unconfined(label)) {
>>>>                struct mnt_idmap *idmap = file_mnt_idmap(file);
>>>>                struct inode *inode = file_inode(file);
>>>> @@ -494,7 +495,7 @@ static int apparmor_file_open(struct file *file)
>>>>                /* todo cache full allowed permissions set and state */
>>>>                fctx->allow = aa_map_file_to_perms(file);
>>>>        }
>>>> -     aa_put_label(label);
>>>> +     aa_put_label_condref(label, needput);
>>>>
>>>>        return error;
>>>>   }
>>
>>
>>
> 
