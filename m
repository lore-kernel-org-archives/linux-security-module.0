Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0DD45024;
	Tue, 28 May 2024 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716879671; cv=fail; b=fRDpUtq3f9U2NNIR4Egt8UwuaD8/hE2mD5Tc/jr+HKjX9TX9rD1u2DlxYBWrQ8h0MhtHGCaxT6siz8IyzSSxAUK6lbD+P3ZWmA7QW3BrbXfEq5kz0PTgbAiThgLCAe7ONkNlhiwTV+23sp3W4T9PKeapgzHF0SNTl7jG+hr2nUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716879671; c=relaxed/simple;
	bh=vHQQcWQMPN7fOYX54UvEvZ8sC3GdupOM3UXAPhXpMww=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=pVtg+v/cp4k06k0reqqbaVi3C/cptBbUq2ULd+//w318MfKOXS71b4LtJxo9Fw8l2Y5iVAewDwS/xBtk90FKkNLPKi0RLVz0y4fQMhoKvhpI7MOdjYDaYAqAhPGaSRlvBgtCIvSXUYhwR8F4xBip2ypAYutW06ezdT2BPRYfh+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3PWiycy; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3PWiycy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716879670; x=1748415670;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vHQQcWQMPN7fOYX54UvEvZ8sC3GdupOM3UXAPhXpMww=;
  b=C3PWiycyEhET0DAxJjqQqC4AtoJ0EBmGoFOTSHHFYlphCaTw/Y6WzHQ1
   vdmEaENr/eboJJGAJC53PgFuE9jZmLnJ8XhBhhTnKSWK7lcHlKcsCrGLI
   OckiJ691CXa0V4cYgNSUtLx/UqSB/ED80lv3xpBsy05DheWXqqLis47PV
   8ZEOdpizyuDZ2xGYfXS+/daTquEEpdF0ng6tvxAuEzCjkBEJf+ebQ7B+V
   pkdEVrkJzw3oIYG0uESxPfKezUIvljub5ZuBbWSyFIifkl6vnKtam6DUf
   fyjMixF+pPU8X07/IWS3aBPcRbEm/HySzGa5IzSwQTabJENkTkro5/VMe
   g==;
X-CSE-ConnectionGUID: a8uN3oMPSqi0NFV1WKWgXA==
X-CSE-MsgGUID: 7U3KrIjvTce4O7l9kYZyjg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13374358"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13374358"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 00:01:09 -0700
X-CSE-ConnectionGUID: LYQ8bqFHRPGnl0zSuu/vQQ==
X-CSE-MsgGUID: JIVsre+BS4m0uFiIaPzowg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="39405818"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 00:01:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 00:01:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 00:01:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 00:01:07 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 00:01:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RFumsz6TvgF6I2P2B0LOOw+3Gx5AG6xxb07rvMDXezIITA/DZ3c7sDd6xQpjcCxQwQFrxwpAIUcBfihsIHloUAO7j39dyu7YAEa/2bP1JpB5vvMy4FCDReStpJ6ozeSfzV9BkTtjw9crc+AzZOChyvDuTu3en0YSxuPVkmjGHg51Nq0CP72cXEj3azdV1MpcN/ooK0wPnt7IDhcJsWqVeOVXUglwU0ly9GmNe0njrMLZEZNzQBrtzsN1guRJTOSJ2213th4f08+qOQJLRzvNg7Qd8YQlZzbV4GB5zKGX4UxnMLWf+rHC0ey/+wIr9lx+yIOkokycZnmajNFuebcwGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjVirfZbyIO1/kSSpjCrOQdOQLat+h53MY5GiFhf/wI=;
 b=ZEUEp+XsXOXCYMZ8vpdS/pKVsi9r2iEyeq3x0atiLu21qXFdNKkVEWJ8HbM424SyuQAXdk5rXfq3GmBafIm+SsGBlDK9w748uMlnvSCPpMN7iDsaKhtAWAwUGB5zW+llUH+5UXdjeScY/VOWZWQIniEHOUGl8WXFDTiTebqtgigFFVITUaFfkBayDlkpJ77u/5hilf0AyG9LeFUkzHPKcRK8o33GyeJXqc4Sj+w9UkK/OjGIx4JtrNgyKMC/bn9BI3Xm+vYJ8cfTFFxGzFrGCqn5798XYi/I1hVRwptKFzYb5dsoj5trUcd+tdcLCA/aNXnTnwLAmZz3kRp/x9Q0AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6777.namprd11.prod.outlook.com (2603:10b6:510:1c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 07:01:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 07:01:04 +0000
Date: Tue, 28 May 2024 15:00:54 +0800
From: kernel test robot <oliver.sang@intel.com>
To: York Jasper Niebuhr <yjnworkstation@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox
	<willy@infradead.org>, Kees Cook <keescook@chromium.org>,
	<linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-security-module@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [mm]  ba42b524a0: segfault_at_ip_sp_error
Message-ID: <202405281425.92ece916-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa8f15e-c440-4440-0c6a-08dc7ee3f095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pCO0IKWd7UYMzerLGaFaZMs1s65NdbP/HCPVZu98njT/OhlwLDMUyhsXTbEp?=
 =?us-ascii?Q?5Hr0XAhGenzdoAsUIXEtR/t/4PRhB6B4N+nQWif1tBeXH9dK0eY0P6HXbkF6?=
 =?us-ascii?Q?dXNn5zYR1dMJBGOng0qEokbTY+gvuBZ8cZjDdUdB2T0C6IdS2dMZpE7gSV6m?=
 =?us-ascii?Q?QoRh4yqbCoQAjWQXDeu5EIm9gIdudHmmWXnWT7rDFQh0Q43AMLF7TjQeO8/o?=
 =?us-ascii?Q?F1VHValmxCqVZGxb4v5mX+BfpglASQdvTdwgK6q2BUZ/MazLTkweg45oOxi4?=
 =?us-ascii?Q?tcUrIsz815OkRyx8P5jKsRjLta2yL78EIRw97yD6MTV0QT4gmNYgINniHyUA?=
 =?us-ascii?Q?4Zsdz3iItihnRvB68+AGZmU1n7lkm+huVVFvMu8RpgRuNrlj7nd9ueY5T5NF?=
 =?us-ascii?Q?UfnfZWgw/e7oUsOnn6GQUvi5+QSzFaYPoKtJya9hA+r1x82F5knZpBktzJsh?=
 =?us-ascii?Q?TUg21qls6M2IToelNITrsnC3o9R69vxGgUWHDH1MU2jfNaYd8XXbVG+p1MNK?=
 =?us-ascii?Q?fTAfWES6wHfHtVpprphOGao3ew71OYgU4xk4T4hmgvY8GVAWBjhzvvlLCP9L?=
 =?us-ascii?Q?cRQDnoE05GH5TEthGiC/Lgu890OKjapql4Sn7Y59EfFskgvV0vExIZuotYd0?=
 =?us-ascii?Q?DN898ImNl5xWew2p73lfTupzTJ5rF4BP8QxmxmO3Y4ELyvdMRvMlS/kOQnA8?=
 =?us-ascii?Q?/dtVGKHJiaWwZtrMKHKIQO+0pO9pNWNytU3PUYsq5wMWaqefW3grNYvmHJ7d?=
 =?us-ascii?Q?9+pkBPFbJbGDL4efKvR+29Yo7weJ7Q8tRsLiXEDY/6gU3Mxu8I5A5gDPGTrj?=
 =?us-ascii?Q?j4n7hwrv9W5AQ22Vb3rx/NiLVF0zdohE2AWKoFirsjwbk7HNo7er4WI7wAuY?=
 =?us-ascii?Q?YVzABvtSmm5e8+az964z8CoxGLO7AE+n+m7T9CVpLRnf9ZRZ92MSPlEy74aQ?=
 =?us-ascii?Q?MNENTZgyXZNK2fEhe/dbpB8q0c27ImoQ+8NuB+fuVIHSZeHDkIDvmoVzziEG?=
 =?us-ascii?Q?MRE7ED/n8biMYlGEP7SshYRyMcy8Xrqfym2QXebe2XQMVYFMDqgNjlKB2f8Y?=
 =?us-ascii?Q?OFF7PzVkImxrOPC6tk40TKVrT30x4vHQFnFN617+m+59vY5aWLa6BLTg+cF6?=
 =?us-ascii?Q?Eqg8Nx43BAsYUJhhGIr8+JYckby6pmImo7DoZq9pni6Eui7NHedS3sQ4xZ7j?=
 =?us-ascii?Q?tZRZIJtYucMfPChOhjwCXNgaQ0l380CBmrLRgytUHtkHq7L9C6ZeB6Kpiig?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ubgEzSH/K2haSLHeOUDWcBhUDo6E82NfW2+gU5rqe12wyj/lBgleUJYAK13u?=
 =?us-ascii?Q?8V7xl6dR+I3yMewAFX6yIoDZM/T09fs3ajX5i+ml9qjdvA6xHo/CHNWVe1gg?=
 =?us-ascii?Q?FaNF3HCXJ/932pxLTJkMzevXcrOAKgdlWd1XEp+bnSORBzCtSXqlSZmXQfM6?=
 =?us-ascii?Q?eP1sCiUB5q2JPUxJE8+RlWAlU/uD/6Ns5YJg4vwAOFlg9jEAmHpeHuds9QCK?=
 =?us-ascii?Q?W9whm5zLxsujplVwLj4raeYPLBVjnjld0zb/w4pH3aldhIujWbMYttYiLzFA?=
 =?us-ascii?Q?avl/4aQIYIzJuLcWdv7Z7vw6PgAcXcVxeMCJDouaHEa3pDRaUpOygX1j9i1+?=
 =?us-ascii?Q?yYsoIk13Judaqv7OzDwfdzZC1OCjroPbO3L6GDIQ3Y2HMp+Mt83idLPf0YIT?=
 =?us-ascii?Q?kLUwAPJsQUZY01/+ueZP8h7nkuGMQvzEZDC6ZxeewZc22uNa6r+mBVhQX/kj?=
 =?us-ascii?Q?BRxunCVlz7/due7RLdJhlSWswujbwQR+fUqHaMYNfdWTm60scONhiX49V15B?=
 =?us-ascii?Q?icHB0Gl0IHgbYQQJlExWoS1cCqfl0YuX1sSYTfuMt/IGl9d+JNONd2dVb+nM?=
 =?us-ascii?Q?8bZvxfn3S5ZkQF2iw9wGnbGQ0abN6ypk37l2qs0153gaFU5A8faDhGTa82Z7?=
 =?us-ascii?Q?78iiHEEFOjFF2xCJxAKovxVJ2iztm/Up+OMv2ZS8d7jHvn7qZaVx3XU3aOyE?=
 =?us-ascii?Q?eHRbSE8f1Pe3Laa/Ooeuove+WKlNaFHJjnnsc6txs055WIT8fJm5CsVjST85?=
 =?us-ascii?Q?Yb2Gvrkygn+klVqixqfDAktS3MV4fgkl2PO+SVLAMPCE+OIq1Ecru59eJzd1?=
 =?us-ascii?Q?0+wh67urazA0QI/Mf4F/Z2cVC5lwVCaWZex7HUyo8c19xMFs0wLZ9YmqO1b3?=
 =?us-ascii?Q?AR4z57PJ95bHilvE3BFRyDFWwGJZgS7AyclsiMUCerQkyaa/oC/VSkDVL/nI?=
 =?us-ascii?Q?1uT6XS+Bq0S6RryOeBUCdhFYBrN2OhM252wNCnIX93wXYNR+IM7hkjWbJEID?=
 =?us-ascii?Q?z44MktiClYBa7QSC9G6TpcZof6qnZENQ/oEAMGQi/zVjhzrxJz5ZgZqFxu8w?=
 =?us-ascii?Q?/rmk/qLV0WySq38gvaSb6EA6CWnY0A+nojOtkI1B0ae8sdLOm4/GDPeG2gi8?=
 =?us-ascii?Q?YbwDDaBz0GKKDZxDxZHg8CQWt6V0NFi4jex73t0rdi0C35kBpen+IciEv6OT?=
 =?us-ascii?Q?rxRmWDgetJFk6FE3DIqmlACZgfeD636GEQVgC3Me+Y46dnO8I+AW7vNZzcbP?=
 =?us-ascii?Q?PjqJniSXHnd5jKBiqFw2XjgYypKMpQxRRxRxFfOxs9cQ4k7ys4S0IeCkkc90?=
 =?us-ascii?Q?G+Pm9yjrYJSTdkrJqvCyfg+CEBhHdTIncyCwrvT8Upb8pDlJEFIroWX+Ivm1?=
 =?us-ascii?Q?DTLiVdpWIPF4kxmUurZBbDd9ZbKYtf3c6WfQTaxx8tZErX/r2/8zxqtFRzvH?=
 =?us-ascii?Q?wzwyY1Jr8ayoUnXrSu7QWTiLJ60n/ufKrE+K1hcrDSg4PBP/YEHWFC0rEFF6?=
 =?us-ascii?Q?4pzzRCBcMgQwyDEmzaPofMAuDF69i1GoHHuxfF3eQMW0QnfXnwj0UhJ45qdy?=
 =?us-ascii?Q?eUbkhCbQ0uvGsXgxbSSyHFYOo7F+ZqfZdmjMb0BT9aRJkmPYm9AX977G0T8v?=
 =?us-ascii?Q?Ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa8f15e-c440-4440-0c6a-08dc7ee3f095
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 07:01:03.9613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRK5g3BiENF8ePV8DldGo8nw/VT34KXcBuVC15wxPS0/ZCSwfnTAq28EwqAb/ZUDaWfolz+w+dTNRIMzQGc/jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6777
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "segfault_at_ip_sp_error" on:

commit: ba42b524a0408b5f92bd41edaee1ea84309ab9ae ("mm: init_mlocked_on_free_v3")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      c760b3725e52403dc1b28644fb09c47a83cacea6]
[test failed on linux-next/master 3689b0ef08b70e4e03b82ebd37730a03a672853a]

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: default
	torture_type: tasks-tracing



compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


we didn't see clear hint in below dmesg information, but by further runs, the
issue looks quite persistent:


6c47de3be3a021d8 ba42b524a0408b5f92bd41edaee
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :30         100%          30:30    dmesg.segfault_at_ip_sp_error


so report this FYI what we observed and captured in our tests.


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405281425.92ece916-lkp@intel.com



[  OK  ] Started /etc/rc.local Compatibility.
[  OK  ] Started Getty on tty1.
[  OK  ] Reached target Login Prompts.
[  OK  ] Reached target Multi-User System.
Starting watchdog daemon...
[  351.243261][ T1844] watchdog[1844]: segfault at 0 ip 00000000 sp bfd01fac error 4 in watchdog[49d000+2000] likely on CPU 1 (core 1, socket 0)
[ 351.245577][ T1844] Code: Unable to access opcode bytes at 0xffffffd6.

Code starting with the faulting instruction
===========================================
[  351.253843][ T1846] watchdog[1846]: segfault at 0 ip 00000000 sp bfd01f9c error 4 in watchdog[49d000+2000] likely on CPU 0 (core 0, socket 0)
[ 351.256126][ T1846] Code: Unable to access opcode bytes at 0xffffffd6.

Code starting with the faulting instruction
===========================================
[FAILED] Failed to start watchdog daemon.
See 'systemctl status watchdog.service' for details.



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240528/202405281425.92ece916-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

