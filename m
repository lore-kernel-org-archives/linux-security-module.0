Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ED0157A48
	for <linux-security-module@vger.kernel.org>; Wed, 26 Mar 2025 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976028; cv=fail; b=aKBfsnMTgW8tWPgmUhTbixSCiojhWX/CdzgBpdqZka343gzP8yvo+TTi+pjTDrNJsfK26Xk90pF/t3tVrjweEjRIdVb6pV+t87iX6VLuthQ6w61yu35ezP0tFBQoScjNOvjlFYIltiigGC1SotSRXKhx6GvmOeodx5KmXLVSzco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976028; c=relaxed/simple;
	bh=xGPI9CCpfE5Zc+WP+CpqxONyt1yWDlN4dbI4W8oEV9Q=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=osLrBeWp54T6FPHy9WkGejvxZkkK9YnKZHAocqEPOgOGVTaydw4Dcg/+kRI4bhFO8bqopYbqPle53IeYDPHRVLAKuIACi/w2K3rshKbullL9Q1V2FmS8Pn7qmieLQgSggXOwANmXUEDyiSSnReC7bXTl4qD6sJv18Ov8b4vtcCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBSlebo0; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBSlebo0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742976026; x=1774512026;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=xGPI9CCpfE5Zc+WP+CpqxONyt1yWDlN4dbI4W8oEV9Q=;
  b=HBSlebo0k19c3nbmXPWQTWhoSpf0hw6baS3W16hXxsOJOdt24SY9uL2W
   2d3DcPO9gXh9mjDSzQAlH2ZRGhG1oc0ehCtLHmNNB9WDu/WQ0X9OInrqp
   wmN4zMAEnelOugfncS5Hyg2H9/yIXUlku/e39e0ZqE+gz5KZhDzah8S8K
   NkNI2DBpWTJ27BTexde7frVhlSHXk8AJ9C0K7gQNTclbOL8x19WHy+cJr
   TYgRheVQSJK5poDVTp6fl8gXgaolhpYDrdK+kVcyAumwpqP578xdSXlwS
   NIxOiY/fzcRNBL7AnmKQSC/LVaYjnjO5Yx4TrYdRcfHt+WK2DmTPhXRCF
   A==;
X-CSE-ConnectionGUID: w5v5wpUxT1OGQ12LQPBH4A==
X-CSE-MsgGUID: RVNbnHhvSfWaMbs7NzuMLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="44370839"
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="44370839"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 01:00:25 -0700
X-CSE-ConnectionGUID: kNENhgGVTWaEzn1KA7gIkg==
X-CSE-MsgGUID: 0SbG2cDcQSGz4hY/YRxZmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,277,1736841600"; 
   d="scan'208";a="125199450"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 01:00:25 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Mar 2025 01:00:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Mar 2025 01:00:24 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Mar 2025 01:00:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUx8JYhgsxfGkhZzIbY4fDFNPA3mV2aj16xgT59mgzpF8gK4PIjZE8FINqLLHqvfVOhuS8Q+jzLr/8ubgzN9o6ByirrGMY3doqTCIerdr4rMVApOTkOTOHUAVQ4heZgHNpNRt32p0Y79bzrDWac9GJpxJg+YuuGzTPq28q9Moc5zaq6y1rxMd4N5DiNGtjPwnQ8MNITrq58fhjCLtawr/fYhnZJuiikE+8mTpfhTL95K24KMlN5H3X8MCt1QjHJsaAv6irq4SR7b/9+HG+o8OEABhZ5UfBNpIGTODfrAdUzV7DY+dXcyuOJz9cDqfgGyxLQPpnuyWjXeX/RKxYpwdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0cAP92auY0VqLgw4gaDLZ4bGnA/rRGXcdzTBb/3Q5g=;
 b=ul3eAl7XBtrUuKDNy4cIhoLj/F0niGkCZyetkFxqRBTADD1l7usW9fvucG/5V2Vz5vt0OQeqH4c/D/b90uZsB+/utMZEbejk6YQiStnjluY/MS/ut84TM0ssJqxVtAK/fwKwZci8VBYrrhSYshtBvhS6Sx2Y9Uh3wkjseBTGyNNV+gViuXAYyZXvcp+Pd4Rds4kdfAGhA26G345pJEILAzmwb2yvKfU87JtPDJk9Sv89lR9k7GytJt8BMQSDY1g9uaY94/+j28saazEMEB3liSEy4g9tQGtEcHsS0eskJ/MHr3Wiz0i/SDXTCe2c2lA+zvst8D6PFdcnLr0xEVny3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA3PR11MB7655.namprd11.prod.outlook.com (2603:10b6:806:307::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 08:00:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 08:00:22 +0000
Date: Wed, 26 Mar 2025 16:00:12 +0800
From: kernel test robot <oliver.sang@intel.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, "=?iso-8859-1?Q?G=FCnther?=
 Noack" <gnoack@google.com>, Paul Moore <paul@paul-moore.com>, Serge Hallyn
	<serge@hallyn.com>, Tahera Fahimi <fahimitahera@gmail.com>, Christian Brauner
	<brauner@kernel.org>, <linux-security-module@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [landlock]  9d65581539:
 WARNING:suspicious_RCU_usage
Message-ID: <202503261510.f9652c11-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA3PR11MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d3309c-6ca8-40f1-5ac0-08dd6c3c4246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?M0pVg2xxINm5aG2FYbDXGeZwTpcOTGRGy8QSm5ZgpabnrxoJ9g4ARxlyol?=
 =?iso-8859-1?Q?dsGqcIu3Sejxu+ynpiZdp1TACu9okXVuYW0l8VCB6QnSfYjDk5NssTvKdp?=
 =?iso-8859-1?Q?6Vhk1KofM/3ig9ZJr3KGVSbE4wR/ZtQyktrONDo8USdLJ0IRIwwveVVXDA?=
 =?iso-8859-1?Q?xMIlj1vpBOMTCV3pOyA70schQMv6Bl2MHTw0FGudUJRlOazJy4kh2wiQ1Z?=
 =?iso-8859-1?Q?asmYgljdl/1aSj4gq56uDCCKFzrAfjeBlFB+pLYSM2qyRnbbDgvZ31H3mY?=
 =?iso-8859-1?Q?kGt4JUD+MPN3CS0RgnPvLakmX6zIjvZUsr881wcF+pBciN5nrd/BmBiyEi?=
 =?iso-8859-1?Q?c5EakclAGHkSh1vdIdn0h6Q4z8bPZsFsc1otbhvtRCdsVYpayDNvb38p8Z?=
 =?iso-8859-1?Q?rIxiilRETIgUK4f5hjyqNpViDm0ypd5zeye4vo5YWxS+Si52+NavCYmMH3?=
 =?iso-8859-1?Q?V7SlC8wll42xj8F40KhHGynsO0DWI0RWfI+5KfiseK7+J/38y/t7rSbKtb?=
 =?iso-8859-1?Q?VaIeDHbtnmeV0zbMraDR2XuLx8xLCPriQQYXr6xX85Ms14JBNJyw7SoJtZ?=
 =?iso-8859-1?Q?yyjSWr1djKvJY/tz14RtbbjyknxJfgzVIx87+uC4CQiEds87T5uaqjsGql?=
 =?iso-8859-1?Q?ZBwiruRvvFCdZC4wVcC/EQZoecvKm7OcPcP5z7wf4hdvL8vROOXysk82MP?=
 =?iso-8859-1?Q?9w/0mP1Uc+bLw6e0Z6PmdHDEHDrUWKq/aIYjchBE///Lt9W50tVKOG78C1?=
 =?iso-8859-1?Q?ZuNrxBQkheDioDI/cFOydRKE2qASmvGHza4PSaspRkFsnd8C3CStfgOotQ?=
 =?iso-8859-1?Q?v92QD32x/8/b6hUCEnA1yQX/WfzOVbD8slLj39dqwCCrvE3hVP8PQwwETC?=
 =?iso-8859-1?Q?iAPz/AMn8XJhXWeCckQJgncl/BriEGnKHX8OxNQCkDvDTpv0ml0xuBRexB?=
 =?iso-8859-1?Q?E3GYLc+vg31vG0SPcJTcHZMJkjrlUTmZXidHVDtl4YYT4HpuZkQ3ODtmFv?=
 =?iso-8859-1?Q?6Xp1daljyI7uOGSd68cSlnnyREurd2E8+aQRT9fMKk4HDwGsdyRhKz5axw?=
 =?iso-8859-1?Q?TBu2eQ+E9NnwHMaL8pn1gJRjPFDi6dyo9AZCkLUzI1ImtehZh81jyy2E3W?=
 =?iso-8859-1?Q?yJByIp+vdWxdioQCPb0TXHSZdXALWoFoKhU78ahy3rYnylNbrHsdeqL1aK?=
 =?iso-8859-1?Q?+ijcQH14598MduErdC6X7wmISdPI6JfRCti1F6euVGPH5h7nbd9VGMkJ9T?=
 =?iso-8859-1?Q?xtgUNCRgO9x/QngISEEVIAfr5zH3evtC8+Y9wjdaLndo8IZU9W67LFw21B?=
 =?iso-8859-1?Q?iEmZmBgUxoZXpWuDfKkUosCSY+QgB282T+OokMKzhJSd65B2J3WywluKmJ?=
 =?iso-8859-1?Q?gS9fqoIqajCJkL13p7mUt8i09jlz5QKQC/kUaSJjOys8HZlZc2U7GNtn4z?=
 =?iso-8859-1?Q?vIAh/2f/1s26yxR/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?eWyLB/fjHXgnvRp55kSWFHoUqn1Cz9lfFDt2imkt5XicHR6uic7HxF7xp1?=
 =?iso-8859-1?Q?uia88tiYJ7Bi7J23E3GBcGUzrIxsQurnuhROe693vWdAF2SIPtQd0tdh4L?=
 =?iso-8859-1?Q?I09pzx59r3PD3VT4c9PZ71rjXOz/vG8ap6f4UVQWeHiK4JnV8mrTgWotD1?=
 =?iso-8859-1?Q?S1Jb9VR3WHcYfXtdGUj+gREDOmCKpHOHajZ892YjVjvBB+4yUt6dKWF5uG?=
 =?iso-8859-1?Q?rDpjBxBpc3hgmRTrdYaRaN6igtNIJkGGC9mwmYyJ4ekcQFJ+kdy+hUycFO?=
 =?iso-8859-1?Q?Pwq8ydWL1dKjlFqDRGEsUKsl71dyBeAsy6XH06L7b5Tlz1ya/3dcRtSPy1?=
 =?iso-8859-1?Q?jtT9LWFbqTPvD5RojF+10ye7gU22MVmUpDN3OxuRPJ2IZThXAeOD0V3phe?=
 =?iso-8859-1?Q?Nqe4vftHKnTWJmcPr9Ux8iovQfExmFzggTQZLOBUUaMOOAgCx+9RPvPLzn?=
 =?iso-8859-1?Q?5axE88pGAK6VyhVrcebzUP3Mg/T8V7giMpBc71RwYOCBmCHH9cPT0cUNB7?=
 =?iso-8859-1?Q?E/zffjTXTxA15AwUU22WGKaeLc9M3HsTzqJhvQVAF/nnWFXIDL0lJYo9D6?=
 =?iso-8859-1?Q?Q22fMpYhzXDztw3ETlb+tQDYDVcJxXbiauyFBEnB4TvpduQGGCjQeIGtA6?=
 =?iso-8859-1?Q?hV87IzcMHJwHQ2nIs7tPLjXI2yxfRQeE/wuz8lrpOOPxzpEYbG3TmnCOYZ?=
 =?iso-8859-1?Q?WQxdtmHwq8/5Ozc4qJeAq7AK4Re2r0qgbJODlQzv85rGARZ10SMSk+KwUP?=
 =?iso-8859-1?Q?XdcIZvYiPYqpKhd1u3CL9ONDgcbhV9G7yoXXWwOY6QOOQHvQs0kli8bUTA?=
 =?iso-8859-1?Q?MCZicFnO/HDplKz/eExhg5gLJCm2eL21Z3TgLFw8gU0x7w6uqdRYqXuEpp?=
 =?iso-8859-1?Q?mYfWdJ6ulQI7vr6amjcUqvezy95NeedozhUENCsM+e+BNrEIj/VItf2DNE?=
 =?iso-8859-1?Q?WZcfde6lUd+4k998wpmZ1zSUpt3zHDLMZ+33ZB/M17F+5p7sUySFvcWPlW?=
 =?iso-8859-1?Q?qWM+TbPsEaWwngf8/y7BgJXJSFYGJjje9oAfa+aKJJYaHur6zPnwkAH3NF?=
 =?iso-8859-1?Q?RYixeEVxlBWx7cNk6KeMyU7WyPmz+G6YWQhHWDJ/0IeKgZjzLyw/0LMr/C?=
 =?iso-8859-1?Q?aDi10Gjl2UAxtDBglooF+FIw+WwBqrbAIwF36rEhu9jwIZJ82PKua+ODf+?=
 =?iso-8859-1?Q?s8tFYBwTgCq13KH+molqFLzZWNkJm+yygpg3pvqJj/7KRqraoUTY2qQpOW?=
 =?iso-8859-1?Q?tcl0198FgYYQYvrfB9pByHiusYFiccoAhXc6kV9AbHei02XSoTz0Cfzu1Z?=
 =?iso-8859-1?Q?DBssOze7yS282gRgynXJLFKIHXshPzYhbAQc4iF1o9cafcPhTqi71diXxs?=
 =?iso-8859-1?Q?8Hc3IxlS2Qsyvd8J+pPONKpulUXgPcIjbvZgUME7D3efxf4QHyYob2xVWL?=
 =?iso-8859-1?Q?tWkNsmaMMnGAFujMPTQ64AYidW/oYRvYYQMMU4Gne3m70EZ9FroNGy2AuE?=
 =?iso-8859-1?Q?fnHVx+FM+4ovSEkwuMRHOETZeHjm9oxwagozf+DppCUFiu7RcPKvlwFDdc?=
 =?iso-8859-1?Q?A3fLJQtQW/sKzNppDL8qFin0NT7WtXeIRd+s1iTTc/9gndiIbmEgRVeAO9?=
 =?iso-8859-1?Q?Y/8gFM66tgw9FC5KfdsgqQJ2PHtE/nGjvdx1WFoXE4/6eWSZTQMZBX6Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d3309c-6ca8-40f1-5ac0-08dd6c3c4246
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 08:00:22.3441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66mgz6nR5CBNpfdzMvp2Tx04HhVtlLkA2jM+EXN5HKroa+rmZfjRPE48FkNq9GiXTdirxFqlBGO1PFqxL/8syQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7655
X-OriginatorOrg: intel.com


hi, Mickaël Salaün,

we just reported a random
"Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN"
issue in
https://lore.kernel.org/all/202503261534.22d970e8-lkp@intel.com/

now we noticed this commit is also in linux-next/master.

we don't have enough knowledge to check the difference, but we found a
persistent issue for this commit.

6d9ac5e4d70eba3e 9d65581539252fdb1666917a095
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :6          100%           6:6     dmesg.WARNING:suspicious_RCU_usage
           :6          100%           6:6     dmesg.boot_failures
           :6          100%           6:6     dmesg.kernel/pid.c:#suspicious_rcu_dereference_check()usage

below full report FYI.


Hello,

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: 9d65581539252fdb1666917a09549c13090fe9e5 ("landlock: Always allow signals between threads of the same process")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master eb4bc4b07f66f01618d9cb1aa4eaef59b1188415]

in testcase: trinity
version: trinity-x86_64-ba2360ed-1_20241228
with following parameters:

	runtime: 300s
	group: group-00
	nr_groups: 5



config: x86_64-randconfig-101-20250325
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503261510.f9652c11-lkp@intel.com


[  166.893101][ T3747] WARNING: suspicious RCU usage
[  166.893462][ T3747] 6.14.0-rc5-00006-g9d6558153925 #1 Not tainted
[  166.893895][ T3747] -----------------------------
[  166.894239][ T3747] kernel/pid.c:414 suspicious rcu_dereference_check() usage!
[  166.894747][ T3747]
[  166.894747][ T3747] other info that might help us debug this:
[  166.894747][ T3747]
[  166.895450][ T3747]
[  166.895450][ T3747] rcu_scheduler_active = 2, debug_locks = 1
[  166.896030][ T3747] 3 locks held by trinity-c2/3747:
[ 166.896415][ T3747] #0: ffff888114a5a930 (&group->mark_mutex){+.+.}-{4:4}, at: fcntl_dirnotify (include/linux/sched/mm.h:332 include/linux/sched/mm.h:386 include/linux/fsnotify_backend.h:279 fs/notify/dnotify/dnotify.c:329) 
[ 166.897165][ T3747] #1: ffff888148bbea60 (&mark->lock){+.+.}-{3:3}, at: fcntl_dirnotify (fs/notify/dnotify/dnotify.c:349) 
[ 166.897831][ T3747] #2: ffff888108a53220 (&f_owner->lock){....}-{3:3}, at: __f_setown (fs/fcntl.c:137) 
[  166.898481][ T3747]
[  166.898481][ T3747] stack backtrace:
[  166.898901][ T3747] CPU: 0 UID: 65534 PID: 3747 Comm: trinity-c2 Not tainted 6.14.0-rc5-00006-g9d6558153925 #1
[  166.898908][ T3747] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  166.898912][ T3747] Call Trace:
[  166.898916][ T3747]  <TASK>
[ 166.898921][ T3747] dump_stack_lvl (lib/dump_stack.c:123) 
[ 166.898932][ T3747] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6848) 
[ 166.898945][ T3747] pid_task (kernel/pid.c:414 (discriminator 11)) 
[ 166.898954][ T3747] hook_file_set_fowner (security/landlock/fs.c:1651 (discriminator 9)) 
[ 166.898963][ T3747] security_file_set_fowner (arch/x86/include/asm/atomic.h:23 (discriminator 4) include/linux/atomic/atomic-arch-fallback.h:457 (discriminator 4) include/linux/jump_label.h:262 (discriminator 4) security/security.c:3062 (discriminator 4)) 
[ 166.898969][ T3747] __f_setown (fs/fcntl.c:145) 
[ 166.898980][ T3747] fcntl_dirnotify (fs/notify/dnotify/dnotify.c:233 fs/notify/dnotify/dnotify.c:371) 
[ 166.898996][ T3747] do_fcntl (fs/fcntl.c:539) 
[ 166.899002][ T3747] ? f_getown (fs/fcntl.c:448) 
[ 166.899007][ T3747] ? check_prev_add (kernel/locking/lockdep.c:3862) 
[ 166.899011][ T3747] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 166.899023][ T3747] ? syscall_exit_to_user_mode (include/linux/entry-common.h:361 kernel/entry/common.c:220) 
[ 166.899038][ T3747] __x64_sys_fcntl (fs/fcntl.c:591 fs/fcntl.c:576 fs/fcntl.c:576) 
[ 166.899050][ T3747] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
[ 166.899062][ T3747] ? find_held_lock (kernel/locking/lockdep.c:5341) 
[ 166.899072][ T3747] ? __lock_release+0x10b/0x440 
[ 166.899076][ T3747] ? __task_pid_nr_ns (include/linux/rcupdate.h:347 include/linux/rcupdate.h:880 kernel/pid.c:514) 
[ 166.899082][ T3747] ? reacquire_held_locks (kernel/locking/lockdep.c:5502) 
[ 166.899087][ T3747] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4470) 
[ 166.899093][ T3747] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 166.899099][ T3747] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 166.899111][ T3747] ? syscall_exit_to_user_mode (include/linux/entry-common.h:361 kernel/entry/common.c:220) 
[ 166.899119][ T3747] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:469 kernel/locking/lockdep.c:4409) 
[ 166.899124][ T3747] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 166.899129][ T3747] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4470) 
[ 166.899134][ T3747] ? do_syscall_64 (arch/x86/entry/common.c:102) 
[ 166.899139][ T3747] ? do_int80_emulation (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:262 arch/x86/entry/common.c:230) 
[ 166.899149][ T3747] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[  166.899155][ T3747] RIP: 0033:0x7f55ad007719
[ 166.899159][ T3747] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
All code
========
   0:	08 89 e8 5b 5d c3    	or     %cl,-0x3ca2a418(%rcx)
   6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   d:	00 00 00 
  10:	90                   	nop
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06f1
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06c7
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[  166.899164][ T3747] RSP: 002b:00007ffff6eefb48 EFLAGS: 00000246 ORIG_RAX: 0000000000000048
[  166.899168][ T3747] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f55ad007719
[  166.899172][ T3747] RDX: 0000000000000027 RSI: 0000000000000402 RDI: 0000000000000043
[  166.899174][ T3747] RBP: 00007f55ab92f058 R08: 0000000099999999 R09: 00000000377dd000
[  166.899177][ T3747] R10: 0000000084848484 R11: 0000000000000246 R12: 0000000000000048
[  166.899180][ T3747] R13: 00007f55acf036c0 R14: 00007f55ab92f058 R15: 00007f55ab92f000
[  166.899203][ T3747]  </TASK>


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250326/202503261510.f9652c11-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

