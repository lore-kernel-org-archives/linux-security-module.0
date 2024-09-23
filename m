Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2F01C36;
	Mon, 23 Sep 2024 05:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727068020; cv=fail; b=WpyZEV1ganeOHcM1/UCwk9W5YEEgGcz7NgI7aLW4rG+R1yaLH9JEU/+VrmyTOyCrYRUQsv2BAxUmjGgSeXdHMyBreiLdht4R7rT2svn7vHyoE5j5mejpOA/V/V9urWFNPv5QQiaiU/vOv1S6sUV7XYIreJKHLMyXxt+K/4tHVu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727068020; c=relaxed/simple;
	bh=zPI8eB95LrtFQfdMrbKP2iv1vX5aWT3sv1WpwrVW5ZU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=aRaY/7JnZMnkcCnop8e7SjZRCl5KZigmPEZXOU7IalZJuWSzj+ELC4CroXkvdKrpELAS2+y3B2oDwMjoZvDaAT3nmDUTQAth3/C6y6KiDvZfUKjXIYRKPuzl4CzfC7VQ2CNkd1NF5LbX1jeDSCrIiul17ntLT2iCqlYTrBojjkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ir6B1CFv; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ir6B1CFv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727068018; x=1758604018;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=zPI8eB95LrtFQfdMrbKP2iv1vX5aWT3sv1WpwrVW5ZU=;
  b=ir6B1CFvqgeD2QBRS/YnBWL7CmVdj7Up3gdr4vb+v7dCA/1Kwu35DF0N
   BfL4ZJFHYPDNcgjTu0EFpB5Tr4BOaX1xIhc7vzN/PnZhnFAd9iFm1/b1S
   3kmNC5zoFvGLs44ivszmNwtnE0n2QWPfAPAkyMO3HDnimEs0MYxD5PikE
   sKil9hiDAZPSm2/dBFXhJGhQnB1fHJ4RBsIx94fyhPvMy9Aoa4obs43AQ
   wo8Ko87LeTS4q4/DPqDpWO9acF8LPZDJrr4pqlSUv5gt3f+mLMfxQt4vG
   7X5cNwF6DugxXlJBR9D241oq2HFcVnyCGQYr7SndUTDeZ62EjJ2yPYlyj
   A==;
X-CSE-ConnectionGUID: 4mxJinYESuGTQJyIJBlQEw==
X-CSE-MsgGUID: YWVHxvx6TieIoCRgStaSyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="43468583"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="43468583"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 22:06:58 -0700
X-CSE-ConnectionGUID: gRAOs4RqROC2/xWCUyw52Q==
X-CSE-MsgGUID: ARNE3EE0QySIbGwCDsJcvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="101681847"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2024 22:06:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 22 Sep 2024 22:06:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 22 Sep 2024 22:06:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 22 Sep 2024 22:06:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hw5sf26cYZQiVICp2pGg06Z/Dy9rWZ9p2fzND/5xak6zRBvWp0EzlqJ0ijh/Idf919Irq69F8mUZI1emj+4/XJyWN5lvuxuSLcjxHe1DkjDXNQCKO7wBfAUuBvEOncvE+07ITvWPcsM2U7bwcaUp4sTo8W8WqFJ0lg6CjESEnfrD97FruT6tFAnGfez2DNYumVLi725Wp2hd5SjlYB5q0GMLH2GEGDJWhixsVTfoMhiNfzEPjejdR2twh8QfDFSuQoIwOQu5ivfKpmi35sc50pxEdkZaEDq4wfk64WIYcCcONvmjIVS0R/XQUZ75R4JPt/6vE96HQywNfM9Ec0MZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLA80/COzgWrAZz+LTmSG/pv7MaC7Of65k3Ujf5emTQ=;
 b=lOQGNelcqR/s7B6FYhkivdqMdkU1gw7Tn4UJVJub8706xGt45tVDRsJ2p8aP1QZgTnGzSx4CSa5XQ+Jjw+BlGQ3xZ5brQvmonNjhnvw9DhDDfnUUEVrHe8+LNso0r0fhmMjcKWYazJ/5+YN1AWKU+J6d081a8aKq81CEpuUh5udO7Q6XHRDn6ZjRi+ZxJjVtZRS9pG9TvxIELCuGSWsLCm5xfd944NyMJRgXH0xVM+MsVI9SGffiLdX1LJAX0KhdKgtuLVv9llApUpYTI+lLJdogh6ruIGQOE7/QRsNdTgcoY8Af6elsNBRVLMOKEM+LodEoM+/BIuPwjrlBOroVJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV8PR11MB8558.namprd11.prod.outlook.com (2603:10b6:408:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 05:06:53 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 05:06:52 +0000
Date: Mon, 23 Sep 2024 13:06:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: KP Singh <kpsingh@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Paul Moore <paul@paul-moore.com>, Guenter Roeck <linux@roeck-us.net>, "Casey
 Schaufler" <casey@schaufler-ca.com>, Kees Cook <keescook@chromium.org>, "Song
 Liu" <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	<linux-security-module@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [lsm]  417c5643cd:  stress-ng.full.ops_per_sec 2.1%
 improvement
Message-ID: <202409231206.60ee5a2-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV8PR11MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: a715f5e5-0e53-4451-f99b-08dcdb8d89a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?3KHCsMAWFuwg5rGByV91WJOBT9AQmvkkIDKSZL/9Bn7XLPLbHDWTuuRJ5o?=
 =?iso-8859-1?Q?MiJnfAUpBZ5wZPWZ2ew43nAynF5q3ygbFOfVWzjp0QeEqvb1KntW+dXGZP?=
 =?iso-8859-1?Q?gN/biVhJJ9m1tvJuh8QsdpRbLTKd9jFZ3im+v6izBBUuSth3xBWa71ypkb?=
 =?iso-8859-1?Q?twbuDbNClTn7SGFbmSHKzcE7G0xlnic7Nsj+Zscd0qdfqhsPMow9mQY1Bd?=
 =?iso-8859-1?Q?uAmmKOGErrXNjK3HYTY+ZPPrG9U7y4AXYKDvJQcp0xkBIMzw8tkvv7bAVz?=
 =?iso-8859-1?Q?ULYVEPnOqJaxPpa2HseANKckKfWSouCwJZvz/7JVVA7QrD8HShJOIt8QZT?=
 =?iso-8859-1?Q?ncjKL1ou8rrglJACgRiATxLy0cF8M+thqrnwicm3+eu99HHgSP7d9OKd6c?=
 =?iso-8859-1?Q?ZeMxB5yaNHEFpzJGeVk5EaRd92rvRmK7cl7xH0uC9Hl5UpbjUPbXWsWmXh?=
 =?iso-8859-1?Q?trmujlUcFHakmm9QOW8g7LzkxVn91JLP4M4aBOY9Awpk6IC7FvM6RhzdfS?=
 =?iso-8859-1?Q?8fN57CtpXJHNB9aWIJ9zsBYxE5rHVCGC0t+gstt1p8Y28JGgey9XicgZXU?=
 =?iso-8859-1?Q?2kk6/q3MxaVr3meyQoPhfWRzASh07hjhSf8nLTDa71zYSim8ozLQyjRHY0?=
 =?iso-8859-1?Q?E4J6vS8EZt7hcBDbNi5OKy88cLGAo93D5AZqdYdiyMusHK2q4NVDuwIawN?=
 =?iso-8859-1?Q?ZFwJIkOY/KTjSHSeyMrMcs70ycIPnxjNPVi6waasYUh/wtQ822DCztOeM+?=
 =?iso-8859-1?Q?hUpQIGP6XTO3BblBnYO5biF28OLXo/6/gSP8uUcnBm8oj6PTcwW0L2iwEB?=
 =?iso-8859-1?Q?PgGXKq6hFTbUwNRyb+m2ZtLKH52Xi72urWqO9oUlrso/n4f8iW35beRAXm?=
 =?iso-8859-1?Q?qAdtZoAQmW09VByhfwf5JKOEsyypRm2Z/AgFeaur5sSCpRs9g/I78splHe?=
 =?iso-8859-1?Q?nqQ/qjkP1f8+tkzVgs9sRhimQv+pfB0HNDGLGsc3UBHNT4taiQZzSqZbpj?=
 =?iso-8859-1?Q?XSCschDBmzNjX65LbcIASvYqzbHS7KtYUbbRN2IRQ/RYrtgnNkwHUXCahO?=
 =?iso-8859-1?Q?8LcEwM8Y7RLbY2R9wUsGegpRDnqFkhGU3py35t//Ty54+/USWfTIq5fWp5?=
 =?iso-8859-1?Q?GIZxeEEupAyXQZwM48uzuLNAgKLGDM2iIbEJ5YxjhwMwq6ubKpn38dV4zt?=
 =?iso-8859-1?Q?04WWuJIYMnHCx5tdL2E0IwCjB5jZ18vsJxY6ZUA5iu9CJOVJQYRFi/61Bm?=
 =?iso-8859-1?Q?gwc1kuarmFOKcFWTGnWoEahewNJ0CZ1Rqt+U/8knuHfP5WP/Czni1oT1xc?=
 =?iso-8859-1?Q?WbtVnzPaWdT88dkW4Ea0LdKl1MOowzhYaCepv28OyIPSVXQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+5GTe2zLXCLj3KkH4S1So5bqdjyQ8MwAgTtvLCBLFsNpKV7CfTYh8NuPBr?=
 =?iso-8859-1?Q?zFobiGDgmzk8VDwjGkrDsp8wa2vuWZR0LxE/szfgxVFEg2Lt/No9WebAVk?=
 =?iso-8859-1?Q?R/1as+FqmOGZgDslmw0g/7hnS9DnmUHnrFDtDPoeVzhutqEVegClCEf0bA?=
 =?iso-8859-1?Q?rKqIJDBcHh1/vT83BjHmPvoufVgOu9I9VVJub0PozkXRFbugn2b6C7pApO?=
 =?iso-8859-1?Q?FusIY+I1kyW/W69gpk2c9KbU2fGE8yDTpPwJfsgxZ3hJEu4DGt3+38Vzw+?=
 =?iso-8859-1?Q?33XN3yN6xUC+QYL0dXgbJSA/vAOOmWte/jxMnDXzGAU52c/MY5ooS7CGMu?=
 =?iso-8859-1?Q?mdppHoKnfRzCMtjE8qmDnSvVpz1V6R9cfWKUgpqPsKDbB2yQDbDmIX4d3c?=
 =?iso-8859-1?Q?lM76gol3xmIX3kH39oJCicHIFUT6KuS7GWUZXLidHVYQ3BR2DtamofNjur?=
 =?iso-8859-1?Q?7AIULFbSO5kOFnvvdQmbwUMegW20emqEOkbrab/E4x1herFa7hc2y89vEd?=
 =?iso-8859-1?Q?QLJTEJ6x3Fr9kZVIEqfuvijnszOp0CKzAb+BlmdR92Z2A7P3nYNjekukSF?=
 =?iso-8859-1?Q?M1ZSBUl2+rPBcYatYRdqlqwsq+qEC+AEUcRgRcVLKp1tZS/hzicNcinkA3?=
 =?iso-8859-1?Q?x0wxwP8gBPfwB+JuypmgXPcDfrtOn41HNs01EA8EeybIp6+FfEG8jwWojt?=
 =?iso-8859-1?Q?tWYBDB5PqULNrPI1jVbtdy5xMvpDtSGm54AInck0X3k9LuYFSHFjO6g36u?=
 =?iso-8859-1?Q?UbgqbPwE7UDw72tZrZFHUEOfhnODV6Zsv0ZzZeMytQDera3EEkKoIhj0O/?=
 =?iso-8859-1?Q?xiOiz3nBlrTFl8LMo+OLvEPXyZqohuv5Uqz8rvHGYc097VGhiazsjGfcnC?=
 =?iso-8859-1?Q?x60MRq3/vMgVUOe4M4PD9J1iR9TRQggbU+Koh/XeJBZhwc9C/UquCCe3XD?=
 =?iso-8859-1?Q?DSnczM0Q0W6Zzkw1lCvi4NsvcQ9gTy9U5ZcrXq/zbXq7X9j024TTRulimd?=
 =?iso-8859-1?Q?xo8auMQopy5kaNq4ZbWp11szfA5PxCZ9NpQ0oeed+t7I7F817X6yzLvcXe?=
 =?iso-8859-1?Q?aZj4eQkDV514i3umhUc8w5aam7/CplAJNBownk1hugPT9ftvFPPUuttb0m?=
 =?iso-8859-1?Q?17Sv+QPGajnKD3M7+mdA4sPahNRMlBONna5bxjMWoyvjSuKb4X1iY48xU9?=
 =?iso-8859-1?Q?DjT+vqu4BozoAippigp7Bg9BmTlBrWG81EvysGYuW9zscMxNAV9uUmqMLR?=
 =?iso-8859-1?Q?ZByA5eEZTPnyBP3JLM9MrBK+WewiL/0/f29wL2OCUEve1JmjgEIEDWv+oa?=
 =?iso-8859-1?Q?IMhqxFlcoez8xI5IVGgGjFzG04xW5vDdzM8KqhD4a2y/R/wY8s+UIIe8a3?=
 =?iso-8859-1?Q?EZ0yVfZIKYAtTniIAiwGOd7A67ilZ7NKcVF4BjHmTCfF5fGdmsW7pTmVn4?=
 =?iso-8859-1?Q?JtUdDpe3G3FRcaAxtnFSG+YnFy9SGvQ1Sht2Zs+BiJBGu37syyLjQUAfN6?=
 =?iso-8859-1?Q?AlVq8HAFGFf0wefsFZOugJYI/5F4y2fJhbsMrSsev+mehyiEVI2V0Kwxo6?=
 =?iso-8859-1?Q?zESq7ZcXBJcl/NqOyw0UBOG+irmjWDek756IUVOIB0WiA8zk7KeEyNvtMj?=
 =?iso-8859-1?Q?m+I1jlfSZesTgig1t34iYEXriPCh+nE4Qy3m3aDNV812BkyKJmnFHeRQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a715f5e5-0e53-4451-f99b-08dcdb8d89a9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 05:06:52.9437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJK3iP8WmUpT4PDf+/xS0nselYvGFtNmQXDErYDmY4yTtM0QyGaG8Q49vC9trgM2FKeZ1DoK8+/3khOhcC8DlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8558
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 2.1% improvement of stress-ng.full.ops_per_sec on:


commit: 417c5643cd67a55f424b203b492082035d0236c3 ("lsm: replace indirect LSM hook calls with static calls")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: full
	cpufreq_governor: performance






Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240923/202409231206.60ee5a2-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-skl-d07/full/stress-ng/60s

commit: 
  d51e783c17 ("lsm: count the LSMs enabled at compile time")
  417c5643cd ("lsm: replace indirect LSM hook calls with static calls")

d51e783c17bab0c1 417c5643cd67a55f424b203b492 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
    722.58 ±  7%     +18.6%     857.17 ±  6%  sched_debug.cfs_rq:/.util_est.max
    209.13 ± 13%     +26.9%     265.43 ± 12%  sched_debug.cfs_rq:/.util_est.stddev
  39170933            +2.1%   39984144        stress-ng.full.ops
    652848            +2.1%     666402        stress-ng.full.ops_per_sec
      2.04            -0.5        1.56 ±  3%  perf-stat.i.branch-miss-rate%
  59014237           -23.0%   45431250 ±  2%  perf-stat.i.branch-misses
      1.83            -0.9%       1.81        perf-stat.i.cpi
      2.08            -0.5        1.60 ±  2%  perf-stat.overall.branch-miss-rate%
      1.82            -0.9%       1.81        perf-stat.overall.cpi
  58068138           -23.0%   44709984 ±  2%  perf-stat.ps.branch-misses
      1.79 ±  3%      -0.8        0.98 ±  2%  perf-profile.calltrace.cycles-pp.security_mmap_file.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
     14.76            -0.7       14.06        perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     15.54            -0.7       14.87        perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     16.04            -0.7       15.38        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
     15.92            -0.7       15.26        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
     25.34            -0.6       24.73        perf-profile.calltrace.cycles-pp.__mmap
      0.71 ±  3%      -0.4        0.34 ± 70%  perf-profile.calltrace.cycles-pp.ima_file_check.security_file_post_open.do_open.path_openat.do_filp_open
      0.58 ±  7%      -0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.apparmor_file_alloc_security.security_file_alloc.init_file.alloc_empty_file.path_openat
      0.79 ±  3%      -0.3        0.53 ±  2%  perf-profile.calltrace.cycles-pp.security_file_post_open.do_open.path_openat.do_filp_open.do_sys_openat2
      7.05            -0.2        6.82        perf-profile.calltrace.cycles-pp.fstatat64
      0.81 ±  4%      -0.2        0.60 ±  4%  perf-profile.calltrace.cycles-pp.apparmor_mmap_file.security_mmap_file.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      2.60 ±  2%      -0.2        2.40 ±  2%  perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      1.31 ±  2%      -0.2        1.13 ±  4%  perf-profile.calltrace.cycles-pp.vfs_fstat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      2.69            -0.2        2.53 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      2.75            -0.2        2.59 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatat64
      4.10            -0.2        3.94 ±  2%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      4.33            -0.1        4.18 ±  2%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      1.06 ±  4%      -0.1        0.92 ±  2%  perf-profile.calltrace.cycles-pp.init_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      0.89 ±  7%      -0.1        0.75 ±  3%  perf-profile.calltrace.cycles-pp.security_file_alloc.init_file.alloc_empty_file.path_openat.do_filp_open
      2.49            -0.1        2.36 ±  3%  perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.71 ±  9%      -0.1        0.59 ± 10%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      3.84            -0.1        3.75        perf-profile.calltrace.cycles-pp.vfs_read.__x64_sys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pread
      4.07            -0.1        3.99        perf-profile.calltrace.cycles-pp.__x64_sys_pread64.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pread
      4.25            -0.1        4.17        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_pread
      0.78 ±  2%      +0.1        0.84 ±  3%  perf-profile.calltrace.cycles-pp.cp_new_stat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.74 ±  2%      +0.1        0.80        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64.open64
      0.87 ±  3%      +0.1        0.93        perf-profile.calltrace.cycles-pp.chrdev_open.do_dentry_open.vfs_open.do_open.path_openat
      0.64 ±  4%      +0.1        0.71 ±  2%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.complete_walk.do_open.path_openat
      0.64 ±  4%      +0.1        0.71 ±  2%  perf-profile.calltrace.cycles-pp.__check_object_size.strncpy_from_user.getname_flags.do_sys_openat2.__x64_sys_openat
      0.72 ±  4%      +0.1        0.80 ±  2%  perf-profile.calltrace.cycles-pp.try_to_unlazy.complete_walk.do_open.path_openat.do_filp_open
      0.76 ±  4%      +0.1        0.86 ±  2%  perf-profile.calltrace.cycles-pp.complete_walk.do_open.path_openat.do_filp_open.do_sys_openat2
      0.92 ±  2%      +0.1        1.02 ±  2%  perf-profile.calltrace.cycles-pp.strncpy_from_user.getname_flags.do_sys_openat2.__x64_sys_openat.do_syscall_64
      0.86 ±  3%      +0.1        0.99 ±  2%  perf-profile.calltrace.cycles-pp.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      1.76 ±  2%      +0.1        1.90 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.open64
     16.74            +0.5       17.24        perf-profile.calltrace.cycles-pp.open64
      0.00            +0.5        0.53 ±  3%  perf-profile.calltrace.cycles-pp.__memcg_slab_post_alloc_hook.kmem_cache_alloc_noprof.alloc_empty_file.path_openat.do_filp_open
     47.44            -1.1       46.39        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     46.74            -1.0       45.70        perf-profile.children.cycles-pp.do_syscall_64
      1.80 ±  2%      -0.8        1.00 ±  2%  perf-profile.children.cycles-pp.security_mmap_file
     14.81            -0.7       14.12        perf-profile.children.cycles-pp.vm_mmap_pgoff
     15.58            -0.7       14.91        perf-profile.children.cycles-pp.ksys_mmap_pgoff
     25.62            -0.6       25.01        perf-profile.children.cycles-pp.__mmap
      1.19 ±  3%      -0.4        0.78 ±  5%  perf-profile.children.cycles-pp.security_file_permission
      0.71 ±  3%      -0.4        0.33 ±  6%  perf-profile.children.cycles-pp.security_current_getsecid_subj
      1.37 ±  7%      -0.4        0.99 ±  7%  perf-profile.children.cycles-pp.rw_verify_area
      1.08 ±  3%      -0.4        0.72 ±  5%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.46 ±  2%      -0.4        0.10 ± 10%  perf-profile.children.cycles-pp.__softirqentry_text_end
      0.60 ±  4%      -0.3        0.28 ±  6%  perf-profile.children.cycles-pp.apparmor_current_getsecid_subj
      0.58 ±  2%      -0.3        0.25 ±  8%  perf-profile.children.cycles-pp.ima_file_mmap
      0.79 ±  3%      -0.2        0.54 ±  2%  perf-profile.children.cycles-pp.security_file_post_open
      7.95            -0.2        7.71        perf-profile.children.cycles-pp.vfs_read
      0.43 ±  6%      -0.2        0.21 ± 10%  perf-profile.children.cycles-pp.security_file_release
      0.82 ±  4%      -0.2        0.61 ±  4%  perf-profile.children.cycles-pp.apparmor_mmap_file
      2.64 ±  2%      -0.2        2.44 ±  3%  perf-profile.children.cycles-pp.__fput
      0.71 ±  3%      -0.2        0.52 ±  2%  perf-profile.children.cycles-pp.ima_file_check
      0.32 ±  3%      -0.2        0.13 ±  9%  perf-profile.children.cycles-pp.common_perm_cond
      0.48 ±  3%      -0.2        0.29 ±  7%  perf-profile.children.cycles-pp.security_inode_getattr
      0.39 ±  2%      -0.2        0.20 ±  8%  perf-profile.children.cycles-pp.security_mmap_addr
      1.32 ±  2%      -0.2        1.14 ±  3%  perf-profile.children.cycles-pp.vfs_fstat
      0.27 ±  4%      -0.2        0.09 ± 10%  perf-profile.children.cycles-pp.cap_mmap_addr
      4.34            -0.1        4.19 ±  2%  perf-profile.children.cycles-pp.ksys_read
      1.07 ±  3%      -0.1        0.93 ±  2%  perf-profile.children.cycles-pp.init_file
      0.90 ±  7%      -0.1        0.76 ±  3%  perf-profile.children.cycles-pp.security_file_alloc
      2.51            -0.1        2.38 ±  3%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      0.73 ±  9%      -0.1        0.61 ± 10%  perf-profile.children.cycles-pp.vfs_write
      0.30 ±  6%      -0.1        0.21 ±  5%  perf-profile.children.cycles-pp.security_file_open
      0.16 ±  9%      -0.1        0.07 ± 15%  perf-profile.children.cycles-pp.ima_file_free
      0.35 ±  9%      -0.1        0.26 ± 11%  perf-profile.children.cycles-pp.security_file_free
      0.33 ± 10%      -0.1        0.24 ± 12%  perf-profile.children.cycles-pp.apparmor_file_free_security
      0.58 ±  7%      -0.1        0.50 ±  3%  perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.25 ±  6%      -0.1        0.18 ±  7%  perf-profile.children.cycles-pp.apparmor_file_open
      0.15 ± 10%      -0.1        0.09 ±  7%  perf-profile.children.cycles-pp.evm_file_release
      0.40 ±  5%      -0.0        0.36 ±  4%  perf-profile.children.cycles-pp.do_vfs_ioctl
      0.19 ±  3%      +0.0        0.21 ±  5%  perf-profile.children.cycles-pp.rep_movs_alternative
      0.30 ±  2%      +0.0        0.33 ±  3%  perf-profile.children.cycles-pp._copy_to_user
      0.03 ± 70%      +0.1        0.09 ± 10%  perf-profile.children.cycles-pp.mas_prev_setup
      0.48 ±  2%      +0.1        0.54 ±  4%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.42 ±  4%      +0.1        0.48 ±  4%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.19 ±  6%      +0.1        0.25 ±  5%  perf-profile.children.cycles-pp.memset_orig
      0.29 ±  7%      +0.1        0.35 ±  6%  perf-profile.children.cycles-pp.filp_flush
      0.64 ±  3%      +0.1        0.72 ±  2%  perf-profile.children.cycles-pp.__legitimize_path
      0.88 ±  4%      +0.1        0.96        perf-profile.children.cycles-pp.kmem_cache_free
      0.64 ±  6%      +0.1        0.72 ±  6%  perf-profile.children.cycles-pp.lockref_put_return
      0.13 ±  8%      +0.1        0.22 ±  5%  perf-profile.children.cycles-pp.mas_prev
      0.72 ±  4%      +0.1        0.81        perf-profile.children.cycles-pp.try_to_unlazy
      0.76 ±  6%      +0.1        0.85 ±  5%  perf-profile.children.cycles-pp.dput
      0.77 ±  4%      +0.1        0.86        perf-profile.children.cycles-pp.complete_walk
      0.66 ±  4%      +0.1        0.76        perf-profile.children.cycles-pp.__check_object_size
      0.92 ±  2%      +0.1        1.03 ±  2%  perf-profile.children.cycles-pp.strncpy_from_user
      1.42 ±  3%      +0.1        1.57 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      9.70            +0.2        9.93        perf-profile.children.cycles-pp.entry_SYSCALL_64
     16.89            +0.5       17.38        perf-profile.children.cycles-pp.open64
      0.98 ±  3%      -0.4        0.62 ±  6%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.41 ±  2%      -0.3        0.09 ± 10%  perf-profile.self.cycles-pp.__softirqentry_text_end
      0.54 ±  4%      -0.3        0.26 ±  7%  perf-profile.self.cycles-pp.apparmor_current_getsecid_subj
      0.30 ±  4%      -0.2        0.12 ± 12%  perf-profile.self.cycles-pp.common_perm_cond
      0.74 ±  4%      -0.2        0.56 ±  4%  perf-profile.self.cycles-pp.apparmor_mmap_file
      0.21 ±  4%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.cap_mmap_addr
      1.09 ±  2%      -0.1        1.00 ±  3%  perf-profile.self.cycles-pp.mas_empty_area_rev
      0.22 ±  7%      -0.1        0.13 ± 11%  perf-profile.self.cycles-pp.security_mmap_file
      0.15 ±  7%      -0.1        0.06 ±  7%  perf-profile.self.cycles-pp.ima_file_check
      0.15 ± 11%      -0.1        0.06 ± 14%  perf-profile.self.cycles-pp.ima_file_free
      0.55 ±  7%      -0.1        0.47 ±  2%  perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.32 ± 10%      -0.1        0.24 ± 13%  perf-profile.self.cycles-pp.apparmor_file_free_security
      0.14 ±  9%      -0.1        0.07 ± 11%  perf-profile.self.cycles-pp.evm_file_release
      0.14 ±  4%      -0.1        0.08 ±  9%  perf-profile.self.cycles-pp.ima_file_mmap
      0.22 ±  7%      -0.1        0.17 ±  8%  perf-profile.self.cycles-pp.apparmor_file_open
      0.67            -0.0        0.62 ±  2%  perf-profile.self.cycles-pp.vm_unmapped_area
      0.10 ±  9%      -0.0        0.06 ± 13%  perf-profile.self.cycles-pp.security_current_getsecid_subj
      0.10 ±  5%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.security_file_permission
      0.11 ±  9%      -0.0        0.08 ± 16%  perf-profile.self.cycles-pp.security_file_release
      0.05 ±  8%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.file_close_fd_locked
      0.27 ±  2%      +0.0        0.30 ±  3%  perf-profile.self.cycles-pp.do_filp_open
      0.07 ± 14%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.filp_flush
      0.61 ±  2%      +0.0        0.64 ±  4%  perf-profile.self.cycles-pp.do_mmap
      0.06 ± 11%      +0.0        0.10 ±  9%  perf-profile.self.cycles-pp.__check_object_size
      0.08 ± 11%      +0.0        0.13 ± 11%  perf-profile.self.cycles-pp.mas_prev
      0.26 ±  9%      +0.0        0.31 ±  5%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.21 ±  4%      +0.0        0.26 ±  4%  perf-profile.self.cycles-pp.__get_unmapped_area
      0.02 ± 99%      +0.1        0.08 ± 11%  perf-profile.self.cycles-pp.mas_prev_setup
      0.18 ±  5%      +0.1        0.24 ±  4%  perf-profile.self.cycles-pp.memset_orig
      0.42 ±  4%      +0.1        0.48 ±  4%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.40 ±  3%      +0.1        0.47 ±  3%  perf-profile.self.cycles-pp.kmem_cache_free
      0.64 ±  6%      +0.1        0.71 ±  6%  perf-profile.self.cycles-pp.lockref_put_return
      8.20            +0.2        8.44        perf-profile.self.cycles-pp.entry_SYSCALL_64




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

