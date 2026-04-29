Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAAA3ACF15;
	Wed, 29 Apr 2026 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451184; cv=fail; b=XrrWowPY/07+IxXd5oFmW5XuLeXJ6xh0DuzabvUbT5hDN7bIBgrxobJlHc4Fh8KAfWVeJ2X1ImcvBMKRwMrwJEUZr/IH7z9aDcinbpM9LpaBnJ925r7auSYGWPb+ZyUddL+eOV3kEwCFa+2tyX8fGKXwVW+hgGHKPtQtKcGbr6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451184; c=relaxed/simple;
	bh=VQ9Kk0kjDW66g/SbZAFsyoej50A/6HDD1loBnLu5MHQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=EtnbmjSgc4jRR8QaWQpm7CSZpDUMhYFqc38sLiC4X2NuHW3Do3JwCxOuYKFumxXIjjDBfHIdidZ+6newcUBFntZfn2DFYu++GscrYfxpM/lVRBODwvGAQ3pXyugUveSGniaECzqwiDjExxfZkjxuEkD9q7xWsYwZynLOo+0rQFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WqKAEN5E; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WqKAEN5E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777451183; x=1808987183;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VQ9Kk0kjDW66g/SbZAFsyoej50A/6HDD1loBnLu5MHQ=;
  b=WqKAEN5Ed2JZncA8x4ozaYT05OzfcJNXMxui+5Efdw3PpoJnH8JyziG6
   FeSebmIgkRh5pXh/aaST6/Ccm0YUOBjcCRD6l46pzrnXqDFhmbChU5pGQ
   AfQSH5IqbHQ5wFuwBowBPAeBvMcFwV1k0+vwj+0gZfBF4vQDVyGdCrAj6
   d0y9dSxBwJc94oZa+k8qv6C9Z43b0l1+vSHEB7YQKHXlCmX9t11uwTgDo
   O10kG06x6n+Vji3oqaEi2chZF6chcDi/2CRoT07OgXqu0WYRfJigkRl/M
   M2K4aY6qMLcQAZi/nhFKtaRrYUFhdIsDaxm4/knf3KJyvhUjhvfORiHmm
   g==;
X-CSE-ConnectionGUID: XxFVR3NaTS2+gw6SPcXvqA==
X-CSE-MsgGUID: wOFv3bFFRHSW/TVhSTHUPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78360074"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="78360074"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 01:26:22 -0700
X-CSE-ConnectionGUID: p4Wk2kW4RfupHSX/8e1V5A==
X-CSE-MsgGUID: bu1BNtTURTOiveUxfn3fPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="231063662"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 01:26:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 01:26:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 01:26:21 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 01:26:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QeQR6Rzyfy4K4pOGIff47vaBN5HeavtCvy6cq487S/s87565KCfFxxzjY0xFNIf3sP9oB2/CS2qn7+u1q8nqNJMKgxgiN8RN8SbBsK1UkaI5FjUgNpQ0wgoO7ltS4mi16Uw0+LnKdtcGw3NuaMaUIxur2VYAfFHqLyluCkl23D5NJyZ6siGJSIp2AEns7at686O+AslZxtAVT13/tl6oa2IN1aV9CTlYBYx66TjpbwXkvIILQxaMFTvMJfoYqFBXNxEnB9CE+Hd+PHVg9TuDORMNMN5iabSY/ZL+2C8LdOdA4BuAELSjpuToV9sXQOreerGDqKkP4kKeTd/5VflgMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pi2Y1swzoKslEeTOmHFazIFELQIGQkMayD7sejUiQFw=;
 b=kef4zJpHOFHeqk8lf83Y3tS7t27djlLv6bM46m7qbUnTPysLoAmgxHFEVTXv45TaLTh+QLgqA5M8P55Y8QfPW+1Cds3JvAibDohE8gS4n6aZ81rR7Ghkzl4DeJQaE5SDmXKvPE+tA2BjrHEewgMSXH1ppwY6swY0Ui1N+tmm9CwVCdwK51TIkjF/nBHCN3l7X+cYVJc9sprpXIBrlZBiosM5O/2fxazB3AHTLJCgY4GhTdEld6QGbk30HmSe3H9he778rx9NYfwqZtOTtJ546KjH+YsmRj1Q95ll07skZfz2PsksW0IbODCaAHqfiLg4w4XZtNYvbE+XvZcEg6kUMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by IA4PR11MB9297.namprd11.prod.outlook.com (2603:10b6:208:56f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Wed, 29 Apr
 2026 08:26:17 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9870.020; Wed, 29 Apr 2026
 08:26:17 +0000
Date: Wed, 29 Apr 2026 16:26:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Mark Brown
	<broonie@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Vova Tokarev <vladimirelitokarev@gmail.com>,
	<linux-security-module@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [proc]  599bbba5a3:
 kernel-selftests.mm.ksft_mkdirty.sh.mkdirty.fail
Message-ID: <202604290921.ac2bf5ff-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TP0P295CA0044.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::6)
 To PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|IA4PR11MB9297:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa478e8-b8ff-41a5-d5fe-08dea5c8fc06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: +1Z/uoipmUi8iq0ZhD1deSCzpugi2GmjE8SE2gRxhhLc3I91dQ/OpAt/j1bapCrFC/ChfG0SO1qid6wTj0oJmfIGdwM5wuLSEV7k7c0Ed8FLfGW9daz0+t4y/9d1KJDvpPufTu0qYUKtxFJjT2RwqOHhp4MbGuSDJLIcPNn7Opl/U8yihLI8yeuNVFNHPaBEqSG0IVMuf7D/jWTdxO71m+FbvMugQC5lM1mL4uYqNR8cph+BaOnvojzSyJGdxHe0hZiXFhKSEevK+dIfcdgCTqmlsaRtxBhUsEqLRTbf/fHd5Rz69NeC+msANgocbCN6c0Zcabq7zfhOKT/E9Mh+UWFkSmbST1/GRgvbQ7UeT5UioybKdKf7o/c6NnhKVvhgN3K7VmBFXgCo9nccUPfQ0LSwFaW4/VgIwSpCBfvJyyqfCWbm56XsLmuVqziXw3Jb20MHDIoh97+SMuWn+zXUjLLsQN3Pyiddgw/rw+kdxajgImS6mI8fwiLZLBsnlMF1nE7huVhQS5561iE9RYYAuNhvnFKT04YT3LzzrMp8ydMsNUFQ8xdD0IcCNQALfinwX6LWvf247Z3InioZ/YnRmuaIS0CD6/9/FoTikUB2R3SRYo5ZqJmviWBlNsGyv9rANJKHGaHSqPdfBZ9yaRn5rferRcEbtWqclKKGsV6TW5S5qS47EkzCapHpSLhEztKtXs66lhGLd/HdrJlrHpsmxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xQDIBId+OFQRWY3Ly9dcXq6IXxurhUG1krcHfvtRHjirMJo6oQTg9CQl2JAZ?=
 =?us-ascii?Q?zH2PPRP3mas0XTaIO/Xhpxx9EFjJCG1Xv+Xhsve5F/kItfWvzGYEcBsrkMrK?=
 =?us-ascii?Q?5JY7KbSQ3L5KD1YV0h0aZl2rmq/Iy6Se2+86KWAREOwtv6TyGBd9BKmJb9A/?=
 =?us-ascii?Q?Y7q1BA9NYZSrBes16LvzOF1X/LyO7oewpP3H68/lHr3g9nQhmKN7F1xSTx6I?=
 =?us-ascii?Q?QuUM3Uswgc4E8luLYLKq64lVzCIyLeb2TpEo/FTvuseJH1r3T74FQbRwztQj?=
 =?us-ascii?Q?4faq6E5ZNIs9mHrrulsDPJ0gPvrOBkcqSeQyWu+Nt9ReCyROmgoDxkG4S6Jd?=
 =?us-ascii?Q?K65PMKrwPxbRT7FweUuQO9jg27ZDj+UrwXmzjvzZlVoa9LPOC8jR9Tqo42SS?=
 =?us-ascii?Q?bhrlP8gcz8fTL7X3tSGkImYZmJMc2/yOfcleKpv+39DZWKcu9wzzReejM8VF?=
 =?us-ascii?Q?03QcfJIRLkQLAEKJuhtOZ7xY+7fCi+jbDFJv6CuF8UkT1AsnSnTEbA3q5Yh/?=
 =?us-ascii?Q?p5midzGS72WBaMFrHgib3bSViihU/yqv91nG3os0rqLsmfeDDhuAP9iHd5iZ?=
 =?us-ascii?Q?wMdKkrjj2uHI4VUCq716qo4SLxm07EOlFGnCEJuK3+C5/FiFPTCOFpavJbxq?=
 =?us-ascii?Q?igzxR7i5fKgYPV3nKQfbwPw8SUy+IMjSjO3Oq8gDAlOEDl3mpg1Ewp1Uwvl7?=
 =?us-ascii?Q?psPNDpJhGnd8SSX5TuLB7387dYY+D/95qBupa5kqwI4wakmt+u+y2BjNnaXL?=
 =?us-ascii?Q?CMCa0a55uM2EugvXYmXHtQ1V3ABZzsXmrbC5YVvsoNgkXgrUb6t0Vs2fXY/s?=
 =?us-ascii?Q?q2B+J9pxG4/POEvWsRdbcDmHn4cr8ZFLZMvqBGOWDQstlCbn2uQndIpwCVLe?=
 =?us-ascii?Q?Z+untqEiMT9nGlo3ff95VpaSBF/2kAB+lOApVYA61feQESWCgNlgEVv24kzJ?=
 =?us-ascii?Q?bAqf2Wa1C83ZelbLcJrQIQEmDgPRb0OEL31Q0w6RAIedlfy19jNXNRDs7vhN?=
 =?us-ascii?Q?Xnp16WMCWUcRCZAfP1rNFjRYHfcWwzMleXkb1e90XOThBRl6iuOQMFSyyoBL?=
 =?us-ascii?Q?3SiKeXQEO49zG8RSVpQ+93TPkb4LkYtPL+f0VAxmyyOo7CUfSu+ZU4xO5EhS?=
 =?us-ascii?Q?CSRWzER8oBCRJyZe0dl1lUTI2O+4365Z5Jvw38/EcNqiKD4ZAZwuw8EWQ8U0?=
 =?us-ascii?Q?tG0hZqRu9tXc8EElierpWaFoFoEkvkvv3jm3E1kno/2/VHPXigU4yt0Q9EFo?=
 =?us-ascii?Q?ts/H8coZr0ydr/FzFwpr0zfMEg2dj3/7LIai0/fsm7REw/kN8uo4C+i/H/Gh?=
 =?us-ascii?Q?eo6+XD6C/H5s/gJOfGGWiKJhwRaNeX6S48co+VQ7gJupc4j9uXo4tt5/b1ws?=
 =?us-ascii?Q?ub1vsNFwaXcfpggj8AMbqjrLH8mKdBybEuBKYD2S10A8WHe0G/degRKsG6gj?=
 =?us-ascii?Q?thJ/P8hyoS6KrbewllH/T5WzOAFXIfe09GtWIQIVNkpxpL6Sp6Vbxi4s2b2i?=
 =?us-ascii?Q?GT7AnMgLP1Gs39bAeDO2UteSmeJSYY9bjHYkrJ03mq773NyDVxoI1supGyWq?=
 =?us-ascii?Q?BjNSGVBz3INvtvMRIZPgmjL6AskH1SvWU38RuGlt4dJPBXDZmw62Rnr0N+Ds?=
 =?us-ascii?Q?6t8iq9B5BZA88PfW3i+wLISI65TstSZDflBiZxYKPZP/8rQwilt8uCcNoShM?=
 =?us-ascii?Q?sGpl0AzA17a+3cn3RGtKr61fy9Jn3wn2nojvS0oCA2pKmervn1pga4a/Xhie?=
 =?us-ascii?Q?adUyOn1PZg=3D=3D?=
X-Exchange-RoutingPolicyChecked: BbQ57nz1sQoGQHFAWsE+rgqV82rXQ+bBbLePPG9n1HceClT5lgxppHHjK4S1tmOom0x9pO0uhrjWeOciSruTpCQKblIyt5ZDdMJjAjpupYuWPfz1cppFKeSsEwJrXFfgSzqJxtqnaW+nf0K7y4Lx3MQJVrIAQZd6A6wP0rGpT5uhSiF8mw/0P99JeN44KduSSMNgvOwoF0Bf/d+xpzQSryD89crsoWKk+bBS3D5drCPvifc6TDV1gy+aHfLTQrgTUK63bR9jKHfOWpYjbVFVRS9q8oEUi3O1o4jbSOPST0+SfxBkXOsKab9Oh3HybLScuHXbBtO7x7x2XYEizDCyJQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa478e8-b8ff-41a5-d5fe-08dea5c8fc06
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 08:26:17.5340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K05MPFNueKBsA218IWnpTC8LxOyvLpCap+O0RonE+jKQidM8Hlr1sAQiYFHLuOd+PW8nW9SBaaZDw9cvCtNrxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9297
X-OriginatorOrg: intel.com



Hello,


by this commit, we noticed the expected config diff:

==================== PARENT FIRST_BAD KCONFIGS fdcbb1bc06508eb7ad961b3876b16382ae678ef8 ====================
--- /pkg/linux/x86_64-rhel-9.4-kselftests/gcc-14/fdcbb1bc06508eb7ad961b3876b16382ae678ef8/.config       2026-04-26 22:54:11.801204874 +0200
+++ /pkg/linux/x86_64-rhel-9.4-kselftests/gcc-14/599bbba5a36f6de57ab14c373c25881e2b5273f5/.config       2026-04-26 22:01:12.692502621 +0200
@@ -8959,8 +8959,8 @@ CONFIG_ENCRYPTED_KEYS=y
 CONFIG_KEY_DH_OPERATIONS=y
 CONFIG_KEY_NOTIFICATIONS=y
 # CONFIG_SECURITY_DMESG_RESTRICT is not set
-CONFIG_PROC_MEM_ALWAYS_FORCE=y
-# CONFIG_PROC_MEM_FORCE_PTRACE is not set
+# CONFIG_PROC_MEM_ALWAYS_FORCE is not set
+CONFIG_PROC_MEM_FORCE_PTRACE=y
 # CONFIG_PROC_MEM_NO_FORCE is not set
 CONFIG_SECURITY=y
 CONFIG_HAS_SECURITY_AUDIT=y


then we saw below two cases failed upon this commit:

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/group/sc_nr_hugepages:
  igk-rpl-d03/kernel-selftests/debian-13-x86_64-20250902.cgz/x86_64-rhel-9.4-kselftests/gcc-14/mm/2


fdcbb1bc06508eb7 599bbba5a36f6de57ab14c373c2
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :9           67%           6:6     kernel-selftests.mm.ksft_ksm.sh.fail
           :9           67%           6:6     kernel-selftests.mm.ksft_mkdirty.sh.fail


we also noticed there is a fix commit in linux-next/master now, but we still
saw same failures in our tests if directly test upon it.

below full report FYI.


kernel test robot noticed "kernel-selftests.mm.ksft_mkdirty.sh.mkdirty.fail" on:

commit: 599bbba5a36f6de57ab14c373c25881e2b5273f5 ("proc: make PROC_MEM_FORCE_PTRACE the Kconfig default")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      254f49634ee16a731174d2ae34bc50bd5f45e731]
[test failed on linux-next/master 7080e32d3f09d8688c4a87d81bdcc71f7f606b16]
[test failed on fix commit        a3907a3169d09ebaeef9631ab6a4534314545ef7]


in testcase: kernel-selftests
version: kernel-selftests-x86_64-9f2693489ef8-1_20260201
with following parameters:

	group: mm
	sc_nr_hugepages: 2



config: x86_64-rhel-9.4-kselftests
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202604290921.ac2bf5ff-lkp@intel.com


below is from commit 599bbba5a3:

# timeout set to 900
# selftests: mm: ksft_ksm.sh
# TAP version 13
# # -----------------------------
# # running ./ksm_tests -H -s 100
# # -----------------------------
# # Number of normal pages:    0
# # Number of huge pages:    50
# # Total size:    100 MiB
# # Total time:    0.196202091 s
# # Average speed:  509.679 MiB/s
# # [PASS]
# ok 1 ksm_tests -H -s 100
# # -----------------------------
# # running ./ksm_tests -P -s 100
# # -----------------------------
# # Total size:    100 MiB
# # Total time:    0.201963596 s
# # Average speed:  495.139 MiB/s
# # [PASS]
# ok 2 ksm_tests -P -s 100
# # ----------------------------
# # running ./ksm_tests -M -p 10
# # ----------------------------
# # OK
# # [PASS]
# ok 3 ksm_tests -M -p 10
# # ----------------------
# # running ./ksm_tests -U
# # ----------------------
# # OK
# # [PASS]
# ok 4 ksm_tests -U
# # ---------------------------------
# # running ./ksm_tests -Z -p 10 -z 0
# # ---------------------------------
# # OK
# # [PASS]
# ok 5 ksm_tests -Z -p 10 -z 0
# # ---------------------------------
# # running ./ksm_tests -Z -p 10 -z 1
# # ---------------------------------
# # OK
# # [PASS]
# ok 6 ksm_tests -Z -p 10 -z 1
# # ------------------------------
# # running ./ksm_functional_tests
# # ------------------------------
# # TAP version 13
# # 1..10
# # # [RUN] test_unmerge
# # ok 1 Pages were unmerged
# # # [RUN] test_unmerge_zero_pages
# # ok 2 KSM zero pages were unmerged
# # # [RUN] test_unmerge_discarded
# # ok 3 Pages were unmerged
# # # [RUN] test_unmerge_uffd_wp
# # ok 4 Pages were unmerged
# # # [RUN] test_prot_none
# # not ok 5 ptrace write failed
# # # [RUN] test_prctl
# # ok 6 Setting/clearing PR_SET_MEMORY_MERGE works
# # # [RUN] test_prctl_fork
# # ok 7 PR_SET_MEMORY_MERGE value is inherited
# # # [RUN] test_prctl_fork_exec
# # ok 8 PR_SET_MEMORY_MERGE value is inherited
# # # [RUN] test_prctl_unmerge
# # ok 9 Pages were unmerged
# # # [RUN] test_fork_ksm_merging_page_count
# # ok 10 ksm_merging_pages is not inherited after fork
# # Bail out! 1 out of 10 tests failed
# # # Totals: pass:9 fail:1 xfail:0 xpass:0 skip:0 error:0
# # [FAIL]
# not ok 7 ksm_functional_tests # exit=1
# hwpoison_inject
# # SUMMARY: PASS=6 SKIP=0 FAIL=1
# 1..7
not ok 7 selftests: mm: ksft_ksm.sh # exit=1

...

# timeout set to 900
# selftests: mm: ksft_mkdirty.sh
# TAP version 13
# # -----------------
# # running ./mkdirty
# # -----------------
# # # [INFO] detected THP size: 2048 KiB
# # TAP version 13
# # 1..6
# # # [INFO] PTRACE write access
# # not ok 1 write() failed
# # # [INFO] PTRACE write access to THP
# # not ok 2 write() failed
# # # [INFO] Page migration
# # ok 3 SIGSEGV generated, page not modified
# # # [INFO] Page migration of THP
# # ok 4 SIGSEGV generated, page not modified
# # # [INFO] PTE-mapping a THP
# # ok 5 SIGSEGV generated, page not modified
# # # [INFO] UFFDIO_COPY
# # ok 6 SIGSEGV generated, page not modified
# # Bail out! 2 out of 6 tests failed
# # # Totals: pass:4 fail:2 xfail:0 xpass:0 skip:0 error:0
# # [FAIL]
# not ok 1 mkdirty # exit=1
# hwpoison_inject
# # SUMMARY: PASS=0 SKIP=0 FAIL=1
# 1..1
not ok 14 selftests: mm: ksft_mkdirty.sh # exit=1



below is from
[test failed on fix commit        a3907a3169d09ebaeef9631ab6a4534314545ef7]


# timeout set to 900
# selftests: mm: ksft_ksm.sh
# TAP version 13
# # -----------------------------
# # running ./ksm_tests -H -s 100
# # -----------------------------
# # Number of normal pages:    0
# # Number of huge pages:    50
# # Total size:    100 MiB
# # Total time:    0.201459173 s
# # Average speed:  496.378 MiB/s
# # [PASS]
# ok 1 ksm_tests -H -s 100
# # -----------------------------
# # running ./ksm_tests -P -s 100
# # -----------------------------
# # Total size:    100 MiB
# # Total time:    0.197418993 s
# # Average speed:  506.537 MiB/s
# # [PASS]
# ok 2 ksm_tests -P -s 100
# # ----------------------------
# # running ./ksm_tests -M -p 10
# # ----------------------------
# # OK
# # [PASS]
# ok 3 ksm_tests -M -p 10
# # ----------------------
# # running ./ksm_tests -U
# # ----------------------
# # OK
# # [PASS]
# ok 4 ksm_tests -U
# # ---------------------------------
# # running ./ksm_tests -Z -p 10 -z 0
# # ---------------------------------
# # OK
# # [PASS]
# ok 5 ksm_tests -Z -p 10 -z 0
# # ---------------------------------
# # running ./ksm_tests -Z -p 10 -z 1
# # ---------------------------------
# # OK
# # [PASS]
# ok 6 ksm_tests -Z -p 10 -z 1
# # ------------------------------
# # running ./ksm_functional_tests
# # ------------------------------
# # TAP version 13
# # 1..10
# # # [RUN] test_unmerge
# # ok 1 Pages were unmerged
# # # [RUN] test_unmerge_zero_pages
# # ok 2 KSM zero pages were unmerged
# # # [RUN] test_unmerge_discarded
# # ok 3 Pages were unmerged
# # # [RUN] test_unmerge_uffd_wp
# # ok 4 Pages were unmerged
# # # [RUN] test_prot_none
# # not ok 5 ptrace write failed
# # # [RUN] test_prctl
# # ok 6 Setting/clearing PR_SET_MEMORY_MERGE works
# # # [RUN] test_prctl_fork
# # ok 7 PR_SET_MEMORY_MERGE value is inherited
# # # [RUN] test_prctl_fork_exec
# # ok 8 PR_SET_MEMORY_MERGE value is inherited
# # # [RUN] test_prctl_unmerge
# # ok 9 Pages were unmerged
# # # [RUN] test_fork_ksm_merging_page_count
# # ok 10 ksm_merging_pages is not inherited after fork
# # Bail out! 1 out of 10 tests failed
# # # Totals: pass:9 fail:1 xfail:0 xpass:0 skip:0 error:0
# # [FAIL]
# not ok 7 ksm_functional_tests # exit=1
# hwpoison_inject
# # SUMMARY: PASS=6 SKIP=0 FAIL=1
# 1..7
not ok 7 selftests: mm: ksft_ksm.sh # exit=1


...


# timeout set to 900
# selftests: mm: ksft_mkdirty.sh
# TAP version 13
# # -----------------
# # running ./mkdirty
# # -----------------
# # # [INFO] detected THP size: 2048 KiB
# # TAP version 13
# # 1..6
# # # [INFO] PTRACE write access
# # not ok 1 write() failed
# # # [INFO] PTRACE write access to THP
# # not ok 2 write() failed
# # # [INFO] Page migration
# # ok 3 SIGSEGV generated, page not modified
# # # [INFO] Page migration of THP
# # ok 4 SIGSEGV generated, page not modified
# # # [INFO] PTE-mapping a THP
# # ok 5 SIGSEGV generated, page not modified
# # # [INFO] UFFDIO_COPY
# # ok 6 SIGSEGV generated, page not modified
# # Bail out! 2 out of 6 tests failed
# # # Totals: pass:4 fail:2 xfail:0 xpass:0 skip:0 error:0
# # [FAIL]
# not ok 1 mkdirty # exit=1
# hwpoison_inject
# # SUMMARY: PASS=0 SKIP=0 FAIL=1
# 1..1
not ok 14 selftests: mm: ksft_mkdirty.sh # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260429/202604290921.ac2bf5ff-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

