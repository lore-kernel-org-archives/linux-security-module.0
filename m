Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215BE12BF3A;
	Tue,  7 May 2024 07:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066011; cv=fail; b=mWAwEBmBeHihicmMCJbcB2fNGDgOpI2T+8J1EFxC3p+NoBp/DwqzGm9RaPMhAWNbYhNJPaET9Caz8tEIPf+woCdTzstYXmoAhD5U3+d9EXDdBflBA2BUbxBcpmxdacoLoVS8Z9r2gqp3JaOkPPtdLn6bTBThpSAoZNo8UExzBRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066011; c=relaxed/simple;
	bh=Vd9qjRQuDwZDmYwAS+xynUcoyoBgJvr9tph5edkHLxQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Ka61b0NJfhIng7nBGleTypqhlyfs3CVibzpjw5fClUxAJXhG/H8q18VUjI1BKNbbPMsUbxa1MV7ZRErTcWYcxrgTTr/LmhKsXcPFTT1LynM6I+t844AwP+0gUw692ZLFgB0k+RQ3gwErqjybReTsEtxRPgh4gR04Qa0eqjqMmYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cjz/M7xt; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cjz/M7xt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715066005; x=1746602005;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vd9qjRQuDwZDmYwAS+xynUcoyoBgJvr9tph5edkHLxQ=;
  b=Cjz/M7xtWphy4ZL9y9ukQk634SRfLTyfC0QKye47ugLG9RKt891+I0Gi
   1L3uOvs0b1KRq8bA4pvkDrRGBM44ZfIfWGg8QbBCK6GlyHXoW5+O4zOJ+
   Kj0rFmBtq9zJn4gJjH54PncVk6z/q7r3dSRvVgO04groxwkvC2TSNxtX3
   FlgYpUfLI2gZfDDhyStgOcUceeULsFwZrC1Xc1p/ms5p3T/p5RcaAlHN7
   iP7hILsPIzp/f7J1/n53nqLtmE/tzsnbtEqjCDCqeHmyoBLDBMK2GuOhy
   9xHkJzwjkDzdTTm3pHWId4UVKnQu9HQ+ZebaC/O2KNK5wRkv8xYqleT/o
   g==;
X-CSE-ConnectionGUID: YcywQ6KnQoSCxbR81Y4RjQ==
X-CSE-MsgGUID: ILgsbxUlS0awwP6Z40u+LA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22254255"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="xz'341?scan'341,208,341";a="22254255"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 00:13:15 -0700
X-CSE-ConnectionGUID: YahXIfwcTfWNHohvCEgp2g==
X-CSE-MsgGUID: iLbg78cdQzirKCcfrmMh1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; 
   d="xz'341?scan'341,208,341";a="33250137"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 00:13:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 00:13:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 00:13:13 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 00:13:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vm2Amir5o5JjX9ifGJMDp4IZ5y4ezDooSlrY5Xcn/bWovaMEWGgTEpx3bf5oMgtbK+vwsNJSkzL/abNod4pXir4Ztve6Su901x16Kb6NQecNWoMkzb8wwGLefEIjRrFpf+yiJaR4ayGGf2mo4YFD9VQRCKwxXxUjErN5r9FXe9sVsmFLRK9sFyMGOdMtpwvA3KjONVi8re71S6PUV+TuInNGg72mQGvsBHhERD2qEN0BdkRVLytZxuyLiDtE2CSSzAPg2wzZZVz+aFpJbDr7CQRT2VrzAYzjiOo1OHcRohph5jwHGLjpI0tVVRpNlRd0XOA1g+NbXbOlC2F0tR7b+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcU1Q48vA5pNJ4EmMd8MXRoRF2jm8ihg1XA5DQjOUv0=;
 b=UdvWjFSrbfmgw/DrXo1L0/zDY0fYeSfD/EJW9zna0c6aNGsaKjVZh7wRG5gYX8wWVl5f7Js6NjHdqABOTgqm2j41RtuXeBczxLcLkrOj8DoFnnF4zwSgVe2oMWCj7vSRJdi1lK7LRHRaXN3wQEmGd5BQpA4ohTeig1KsyeAlJ7qGlSliaABrCNP6StHQmg4d/E1fgsOTl4auSXNwvLCG7b9l8o2XshagsaQJ9oEODEFjD0Bo+Ua1Rptnaz2UjxhTQkCmoFrhSh8myeVv66s4a63fW7/G3SkFuLyeHiJKm2BGVsO4Qnka9Jgc8ogeODDTOGv1f3ZMKfDaew27Vzu7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ1PR11MB6178.namprd11.prod.outlook.com (2603:10b6:a03:45b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 07:13:00 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 07:13:00 +0000
Date: Tue, 7 May 2024 15:12:50 +0800
From: kernel test robot <oliver.sang@intel.com>
To: KP Singh <kpsingh@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Casey Schaufler
	<casey@schaufler-ca.com>, Kees Cook <keescook@chromium.org>, Song Liu
	<song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [kpsingh:static_calls_type_1] [security]  5bbd3fa92f:
 WARNING:at_kernel/static_call_inline.c:#__static_call_update
Message-ID: <202405071402.4f50149a-lkp@intel.com>
Content-Type: multipart/mixed; boundary="8bHpOPWk+C3IjkL3"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR01CA0131.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ1PR11MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b1bb8b-82c2-4f04-2f78-08dc6e6520b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+LxeWjJkI1alr+AGE6w6KcRdsiH2ibrhG1drH46+f8XFbXC6vCfLTjn6Ek3S?=
 =?us-ascii?Q?esYI6L8ldK+dBbpt6rs/xK05sUbxVxynROEIdE24KV0Y8eKeHrAkxW/Lnhij?=
 =?us-ascii?Q?weMhfGhC20+yYIpLqkuImxw5QJesee39Ak1j/Y9RiSm/XnNZgW+9LqkuIfUb?=
 =?us-ascii?Q?xqgE/o4Jh5R+kxWvITSJVP91D0+dVypiImBfosf2/9wS0jeh3uKbvyZSozJ/?=
 =?us-ascii?Q?HR+Qy5apJTy1XGQFKNkAvxHGFSM3GZjpIlpVXUHVpsj1O02f9sPv8FpM9DS2?=
 =?us-ascii?Q?SU7aonPaOqO9euPxmQUej06n0ICsBy5TyonNw0reREJ1ghxYeRx4aZwA1bAC?=
 =?us-ascii?Q?jFPQrr3N86ixxay9lMgWAvcjWdQJRiV1k78PbYhwY9+Drx4HkJ+ll7vVptS5?=
 =?us-ascii?Q?M0iNMf+z+bgzgMscz2KQeERLc2IKm92pd0Zgu/o0/3bgyqzP58XseRpWy3vb?=
 =?us-ascii?Q?yMY3NezneBp6Za8UB8SHYQs6DchBB64z4oTE6GCGKPT0+LyIKUGbkvUS+Zyi?=
 =?us-ascii?Q?i//+/eCEowgj2PKB/R95Ke8BUMFnqm/pHji44JlWGbFAESKBWekQ7HMczrih?=
 =?us-ascii?Q?MfjXL1FxwYaxJUIV8Wx74JE82t8e93gZGwDmrD4tsm34iAUvE+NQCTCS7jX2?=
 =?us-ascii?Q?w8k/doOkj1hNzrxOicMHyBU74s8dGisbvphWsGGHcfifqxr8/k9QKVcB0OTw?=
 =?us-ascii?Q?uQVNAaJq89UbQJy/smNbp+dswWaL7fIvRzxu/7SsXXVJOfBenCDPLvwBbXvP?=
 =?us-ascii?Q?sbaCXLYC0qBZMotTjgoqqGFYLHiDMV3Nv/40pBBPPrPH62oMqf6TuJjKQUZM?=
 =?us-ascii?Q?LhJp/EbjAn9AtuWfkXiCtr6LXZnqYqceGrDWLTJFfoYhUl7rhXkr39urgkhk?=
 =?us-ascii?Q?44OUtuPKnMDg+cUnJ+jMLwUsimwvf3Np1RVShtJ5eQ4keiPBccgVi/2kPG5i?=
 =?us-ascii?Q?H5v8kb4wevySym5+jlPpBte1GOEV08Q8rlVxyru+X/QQmJnIeXVa6VOYCp1Q?=
 =?us-ascii?Q?44oDIFUA9ki90zPufq6CCOrBptNY+DZEiT/gd/mUAz0HAYAeCKLBLQhp6kup?=
 =?us-ascii?Q?DFUvT9WWU+LhnHtsvU/MAUOb4QSdZ86jVDDnAK7P7UKqYKIf0c3lKipWTci8?=
 =?us-ascii?Q?Civg1bUHUMopVRpHk+DtfFf+89nuFi1MSl2EgAelYGR50RSFAJCu7gPesrIJ?=
 =?us-ascii?Q?ANlhEx4PrCJaL9Q0OkdEabDoN+9KT3YA8KcBmNTaAkkUyKn8bJfJcdZ6uKI?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z0ag/QzMJr14WMiYBrV6/kLo0fKxIgDkp454THl+FaCAZAwle7OyCwUv/9pl?=
 =?us-ascii?Q?0UjUfkiWUieORl6NnSM+mSBSCufeLShSKgYuWLu1wGzJhv2Gc3F2HntSMhMi?=
 =?us-ascii?Q?CVaEQfScWbQ0K3ykREZiKUirB5rj0QJFZoQpDaoTDQ0xVV67XAn8o9FD89iy?=
 =?us-ascii?Q?NvZA5GxVEwqcIlwIyLpjcl5sV44tq4LMSmgoTdOdeb7wkriIS+yqfj1Lcr3T?=
 =?us-ascii?Q?aTUubYvS2v5fNkVE25kTIYMkfwJ0f8QrmZnrJNLaykX+4OEgq8FPnSHopzvH?=
 =?us-ascii?Q?fhZ2hdTfjp0hrJgMyq3aIlSiSEa0CzgnaK6VpIUdNtDYd0E2Scglljnzpbi1?=
 =?us-ascii?Q?Aa7D/PaYTkVyThrAYFfP4JTEDNKMciyI7tpgWgDLrkaxuzKCoVaJ65xs/5aA?=
 =?us-ascii?Q?2jCe9lgb0/pthCRwol9tqPNkLyAhe0vTUTn1iyRbVNPyUdST/4vxKopUSjB9?=
 =?us-ascii?Q?n+EHkW1wLywAamuDfm6asjm3cGqJ1JsRnKGHVZoSwGwJNK0LdqYaaT6Ws+IC?=
 =?us-ascii?Q?F5xqoAvgwUjAGFvAXdPyZvvTL1pctdoSQowBXY0F6F8/Bjl1nWtOP0i2nUkQ?=
 =?us-ascii?Q?xIErrYgc7PYs592u0uAUCxNA/y2vdBgWmTJkZU6dDmWE01UBXmnWPnjkOKO3?=
 =?us-ascii?Q?+1X5iVxYftgX5j7hLycuYT7wNmId1sNi/ysEcHhuSfVUj/KrbesYDj+k3Rgg?=
 =?us-ascii?Q?vq+t5hL/Mycfeja2CpGqIMMwwd0A/OdJaUzO1sc8kQnF4uJ/ZpqUP6JNyt90?=
 =?us-ascii?Q?mC09lxoN9/GlpZpGrP33lQ443kPxDjowK6quptZ8IZftzsnFFbG7NPW153Zn?=
 =?us-ascii?Q?UvaINkyjWYJRnKdkYpZW2gvW3fPdpOy4NksQpYcinqGU+5YO2z4nVNbL9sqR?=
 =?us-ascii?Q?NUyrTnKIMp6OcZalo4HwApsFnUZMtxqo3/ZiX3w5aeWUzJT4MPPjkB489yFd?=
 =?us-ascii?Q?ZQrSiP3GbRTIzz8nZm4ceO9yaE8sW37MFq1GRZths11+mCvBx7wAt5cEuTbV?=
 =?us-ascii?Q?6OUWENpfrHlIfNqq+iYD3yQcGlroUMarzsp4ek/VSvPMDx391XdXKSn4pTes?=
 =?us-ascii?Q?UwB245yt0dQwdVD4E61JZu6CkX3brPcviRuUQ878d0SkKOilPmC3MgQEhQdR?=
 =?us-ascii?Q?4GDreTG6EIPsnxy/bWQtWuw9VVbBDFfvLmYioX3rH4Bgwbk+h69UpgYHxo4f?=
 =?us-ascii?Q?X1VO2yLBpXRd8OFVdtVNOoHQWn/AEi5/wdduispi+PeqM48czC5eH2KNocz7?=
 =?us-ascii?Q?O04nLlWbHn/U6NfbxA8/M84QnGCGQmosXWeHpHiYxWOoT1HFeSr4Um6IyDMJ?=
 =?us-ascii?Q?EnJkrHnBxB6SLgiSFP8ZNP1TH+LbhjYEGfRVtK/YojjinOgUwqNCCLTkZOFx?=
 =?us-ascii?Q?wKD0UbdoED8/OP+rxRO3dLRXYS6G1lyQV0lGMEnELM+aAWoGAciL3qnV6maA?=
 =?us-ascii?Q?QUHXS4lzUUHx9lIiARa0pE8Cb1dvkGVoFx+o6aOGT46UB874gru6kNkwCnyX?=
 =?us-ascii?Q?7IZOYWudpHdc7PQHf18Sa8LPp3ZkfsC9CuILXTk/9kQD+IfVdrNqNPPm/Cpr?=
 =?us-ascii?Q?g+pQqy1rzfj0ymc1NvsaPs9IqQn0I39TnT8Yy/zrf9qYVs1yvLJx7riHzi3W?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b1bb8b-82c2-4f04-2f78-08dc6e6520b0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 07:13:00.7952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdLAz1gUIfyx6VT4kc9gxioITYfwKvABGXFMIt7Uz+vZgQhCSuvX5YMz5tnT9uCv6PBZ0pVkIGNW89b7QUJCng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6178
X-OriginatorOrg: intel.com

--8bHpOPWk+C3IjkL3
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Hello,

kernel test robot noticed "WARNING:at_kernel/static_call_inline.c:#__static_call_update" on:

commit: 5bbd3fa92fe5e068bcb5599c083604534482f3ed ("security: Replace indirect LSM hook calls with static calls")
https://git.kernel.org/cgit/linux/kernel/git/kpsingh/linux.git static_calls_type_1

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------+------------+------------+
|                                                              | 95f2cb9a72 | 5bbd3fa92f |
+--------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/static_call_inline.c:#__static_call_update | 0          | 18         |
| RIP:__static_call_update                                     | 0          | 18         |
| WARNING:at_include/linux/jump_label.h:#security_add_hooks    | 0          | 18         |
| RIP:security_add_hooks                                       | 0          | 18         |
+--------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202405071402.4f50149a-lkp@intel.com


[    0.000000][    T0] ------------[ cut here ]------------
[ 0.000000][ T0] WARNING: CPU: 0 PID: 0 at kernel/static_call_inline.c:153 __static_call_update (kernel/static_call_inline.c:153 (discriminator 1)) 
[    0.000000][    T0] Modules linked in:
[    0.000000][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.9.0-rc1-00005-g5bbd3fa92fe5 #1 389a224020672eccea7146ad75c3c4c77719aafb
[ 0.000000][ T0] RIP: 0010:__static_call_update (kernel/static_call_inline.c:153 (discriminator 1)) 
[ 0.000000][ T0] Code: 80 3d 7d 82 50 05 00 0f 85 b9 fe ff ff 48 89 de 48 c7 c7 40 a1 93 84 c6 05 66 82 50 05 01 e8 66 d3 b8 ff 0f 0b e9 9c fe ff ff <0f> 0b 48 c7 c7 a0 86 e0 85 e8 91 00 f8 02 48 8b 74 24 20 48 b8 00
All code
========
   0:	80 3d 7d 82 50 05 00 	cmpb   $0x0,0x550827d(%rip)        # 0x5508284
   7:	0f 85 b9 fe ff ff    	jne    0xfffffffffffffec6
   d:	48 89 de             	mov    %rbx,%rsi
  10:	48 c7 c7 40 a1 93 84 	mov    $0xffffffff8493a140,%rdi
  17:	c6 05 66 82 50 05 01 	movb   $0x1,0x5508266(%rip)        # 0x5508284
  1e:	e8 66 d3 b8 ff       	call   0xffffffffffb8d389
  23:	0f 0b                	ud2
  25:	e9 9c fe ff ff       	jmp    0xfffffffffffffec6
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 c7 c7 a0 86 e0 85 	mov    $0xffffffff85e086a0,%rdi
  33:	e8 91 00 f8 02       	call   0x2f800c9
  38:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
  3d:	48                   	rex.W
  3e:	b8                   	.byte 0xb8
	...

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 c7 c7 a0 86 e0 85 	mov    $0xffffffff85e086a0,%rdi
   9:	e8 91 00 f8 02       	call   0x2f8009f
   e:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
  13:	48                   	rex.W
  14:	b8                   	.byte 0xb8
	...
[    0.000000][    T0] RSP: 0000:ffffffff85807db0 EFLAGS: 00010046 ORIG_RAX: 0000000000000000
[    0.000000][    T0] RAX: 0000000000000000 RBX: ffffffff84586c88 RCX: 0000000000000000
[    0.000000][    T0] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[    0.000000][    T0] RBP: dffffc0000000000 R08: 0000000000000000 R09: 0000000000000000
[    0.000000][    T0] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff855efa30
[    0.000000][    T0] R13: dffffc0000000000 R14: ffffffff861cb7c0 R15: ffffffff855efb00
[    0.000000][    T0] FS:  0000000000000000(0000) GS:ffffffff858e4000(0000) knlGS:0000000000000000
[    0.000000][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000][    T0] CR2: ffff888000013d50 CR3: 000000000760a000 CR4: 00000000000000b0
[    0.000000][    T0] Call Trace:
[    0.000000][    T0]  <TASK>
[ 0.000000][ T0] ? __warn (kernel/panic.c:694) 
[ 0.000000][ T0] ? __static_call_update (kernel/static_call_inline.c:153 (discriminator 1)) 
[ 0.000000][ T0] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 0.000000][ T0] ? early_fixup_exception (arch/x86/mm/extable.c:424) 
[ 0.000000][ T0] ? __SCT__lsm_static_call_bpf_token_capable_6 (??:?) 
[ 0.000000][ T0] ? early_idt_handler_common (arch/x86/kernel/head_64.S:542) 
[ 0.000000][ T0] ? __SCT__lsm_static_call_bpf_token_capable_6 (??:?) 
[ 0.000000][ T0] ? __static_call_update (kernel/static_call_inline.c:153 (discriminator 1)) 
[ 0.000000][ T0] ? lockdown_read (security/lockdown/lockdown.c:60) 
[ 0.000000][ T0] ? __down_trylock_console_sem (kernel/printk/printk.c:329) 
[ 0.000000][ T0] ? static_call_del_module (kernel/static_call_inline.c:135) 
[ 0.000000][ T0] ? console_trylock (kernel/printk/printk.c:2678) 
[ 0.000000][ T0] ? vprintk_emit (kernel/printk/printk.c:2342 kernel/printk/printk.c:2297) 
[ 0.000000][ T0] ? security_add_hooks (security/security.c:409 security/security.c:624) 
[ 0.000000][ T0] ? lockdown_lsm_init (security/lockdown/lockdown.c:94) 
[ 0.000000][ T0] ? initialize_lsm (security/security.c:309 (discriminator 4)) 
[ 0.000000][ T0] ? early_security_init (security/security.c:497 (discriminator 2)) 
[ 0.000000][ T0] ? start_kernel (init/main.c:898 (discriminator 3)) 
[ 0.000000][ T0] ? x86_64_start_reservations (arch/x86/kernel/head64.c:495) 
[ 0.000000][ T0] ? x86_64_start_kernel (??:?) 
[ 0.000000][ T0] ? common_startup_64 (arch/x86/kernel/head_64.S:421) 
[    0.000000][    T0]  </TASK>
[    0.000000][    T0] irq event stamp: 0
[ 0.000000][ T0] hardirqs last enabled at (0): 0x0 
[ 0.000000][ T0] hardirqs last disabled at (0): 0x0 
[ 0.000000][ T0] softirqs last enabled at (0): 0x0 
[ 0.000000][ T0] softirqs last disabled at (0): 0x0 
[    0.000000][    T0] ---[ end trace 0000000000000000 ]---



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


--8bHpOPWk+C3IjkL3
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='boot'
	export testcase='boot'
	export category='functional'
	export timeout='10m'
	export job_origin='boot-300s.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='linux-devel/devel-hourly-20240506-091733'
	export commit='5bbd3fa92fe5e068bcb5599c083604534482f3ed'
	export kconfig='x86_64-randconfig-011-20240506'
	export nr_vm=300
	export job_file='/lkp/jobs/queued/bisect/vm-snb/boot-300-yocto-x86_64-minimal-20190520.cgz-x86_64-randconfig-011-20240506-5bbd3fa92fe5-20240507-28670-rs05o-1.yaml'
	export id='47cf10cab2edef31d7a3e79f6ef57c4effc893ea'
	export queuer_version='/zday/lkp'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline_hw='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='yocto-x86_64-minimal-20190520.cgz'
	export compiler='gcc-12'
	export enqueue_time='2024-05-07 07:16:01 +0800'
	export _rt='/result/boot/300/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-randconfig-011-20240506/gcc-12/5bbd3fa92fe5e068bcb5599c083604534482f3ed'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export scheduler_version='/lkp/lkp/.src-20240506-223950'
	export arch='x86_64'
	export max_uptime=600
	export initrd='/osimage/yocto/yocto-x86_64-minimal-20190520.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/300/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-randconfig-011-20240506/gcc-12/5bbd3fa92fe5e068bcb5599c083604534482f3ed/3
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-011-20240506/gcc-12/5bbd3fa92fe5e068bcb5599c083604534482f3ed/vmlinuz-6.9.0-rc1-00005-g5bbd3fa92fe5
branch=linux-devel/devel-hourly-20240506-091733
job=/lkp/jobs/scheduled/vm-meta-208/boot-300-yocto-x86_64-minimal-20190520.cgz-x86_64-randconfig-011-20240506-5bbd3fa92fe5-20240507-28670-rs05o-1.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-011-20240506
commit=5bbd3fa92fe5e068bcb5599c083604534482f3ed
nmi_watchdog=0
intremap=posted_msi
vmalloc=256M initramfs_async=0 page_owner=on
max_uptime=600
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-randconfig-011-20240506/gcc-12/5bbd3fa92fe5e068bcb5599c083604534482f3ed/modules.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export job_initrd='/lkp/jobs/scheduled/vm-meta-208/boot-300-yocto-x86_64-minimal-20190520.cgz-x86_64-randconfig-011-20240506-5bbd3fa92fe5-20240507-28670-rs05o-1.cgz'
	export kernel='/pkg/linux/x86_64-randconfig-011-20240506/gcc-12/5bbd3fa92fe5e068bcb5599c083604534482f3ed/vmlinuz-6.9.0-rc1-00005-g5bbd3fa92fe5'
	export result_root='/result/boot/300/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-randconfig-011-20240506/gcc-12/5bbd3fa92fe5e068bcb5599c083604534482f3ed/3'
	export meta_host='vm-meta-208'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup $LKP_SRC/setup/sanity-check

	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper kmemleak
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper sleep 300
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper boot-slabinfo
	$LKP_SRC/stats/wrapper boot-meminfo
	$LKP_SRC/stats/wrapper memmap
	$LKP_SRC/stats/wrapper boot-memory
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper kernel-size
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper sleep
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper kmemleak

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--8bHpOPWk+C3IjkL3
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

To reproduce:

        # build kernel
	cd linux
	cp config-6.9.0-rc1-00005-g5bbd3fa92fe5 .config
	make -j$(nproc) HOSTCC=gcc-12 CC=gcc-12 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make -j$(nproc) HOSTCC=gcc-12 CC=gcc-12 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.

--8bHpOPWk+C3IjkL3
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-6.9.0-rc1-00005-g5bbd3fa92fe5"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 6.9.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-12 (Ubuntu 12.3.0-9ubuntu2) 12.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=120300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=24100
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=24100
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_GOTO_TIED_OUTPUT=y
CONFIG_GCC_ASM_GOTO_OUTPUT_WORKAROUND=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=126
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_SYSVIPC_COMPAT=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST_IDLE=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_TIME_KUNIT_TEST=m

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=125
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
# end of BPF subsystem

CONFIG_PREEMPT_NONE_BUILD=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
# CONFIG_FORCE_TASKS_RCU is not set
# CONFIG_FORCE_TASKS_RUDE_RCU is not set
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
CONFIG_RCU_DOUBLE_CHECK_CB_TIME=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_INDEX=y
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_GCC10_NO_ARRAY_BOUNDS=y
CONFIG_CC_NO_ARRAY_BOUNDS=y
CONFIG_GCC_NO_STRINGOP_OVERFLOW=y
CONFIG_CC_NO_STRINGOP_OVERFLOW=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
# CONFIG_CGROUP_FAVOR_DYNMODS is not set
# CONFIG_MEMCG is not set
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
CONFIG_CGROUP_MISC=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
# CONFIG_TIME_NS is not set
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
# CONFIG_PID_NS is not set
# CONFIG_NET_NS is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_LD_ORPHAN_WARN_LEVEL="warn"
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_RSEQ=y
CONFIG_CACHESTAT_SYSCALL=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_SELFTEST=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y

#
# Kexec and crash features
#
CONFIG_CRASH_RESERVE=y
CONFIG_VMCORE_INFO=y
CONFIG_KEXEC_CORE=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
# end of Kexec and crash features
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_CSUM=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_SMP is not set
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_FRED=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_HAVE_PAE=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
CONFIG_PERF_EVENTS_AMD_POWER=y
CONFIG_PERF_EVENTS_AMD_UNCORE=m
CONFIG_PERF_EVENTS_AMD_BRS=y
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_X86_MSR=m
# CONFIG_X86_CPUID is not set
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_CET=y
CONFIG_X86_KERNEL_IBT=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_USER_SHADOW_STACK=y
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_ARCH_SUPPORTS_KEXEC=y
CONFIG_ARCH_SUPPORTS_KEXEC_FILE=y
CONFIG_ARCH_SELECTS_KEXEC_FILE=y
CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY=y
CONFIG_ARCH_SUPPORTS_KEXEC_SIG=y
CONFIG_ARCH_SUPPORTS_KEXEC_SIG_FORCE=y
CONFIG_ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG=y
CONFIG_ARCH_SUPPORTS_KEXEC_JUMP=y
CONFIG_ARCH_SUPPORTS_CRASH_DUMP=y
CONFIG_ARCH_SUPPORTS_CRASH_HOTPLUG=y
CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
# CONFIG_RANDOMIZE_BASE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_ADDRESS_MASKING is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_STRICT_SIGALTSTACK_SIZE=y
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_NAMED_AS=y
CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
CONFIG_CC_HAS_ENTRY_PADDING=y
CONFIG_FUNCTION_PADDING_CFI=11
CONFIG_FUNCTION_PADDING_BYTES=16
# CONFIG_SPECULATION_MITIGATIONS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_THERMAL_LIB=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
# CONFIG_ACPI_FFH is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y

#
# CPU frequency scaling drivers
#
# CONFIG_X86_INTEL_PSTATE is not set
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_AMD_PSTATE_UT is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
# CONFIG_CPU_IDLE_GOV_MENU is not set
# CONFIG_CPU_IDLE_GOV_TEO is not set
CONFIG_CPU_IDLE_GOV_HALTPOLL=y
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_IA32_EMULATION_DEFAULT_DISABLED is not set
CONFIG_X86_X32_ABI=y
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y
CONFIG_AS_GFNI=y
CONFIG_AS_WRUSS=y

#
# General architecture-dependent options
#
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
CONFIG_STATIC_CALL_SELFTEST=y
CONFIG_OPTPROBES=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_ARCH_HAS_CPU_FINALIZE_INIT=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_RUST=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_MMU_GATHER_MERGE_VMAS=y
CONFIG_MMU_LAZY_TLB_REFCOUNT=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR_STRONG is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_ARCH_SUPPORTS_CFI_CLANG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING_USER=y
CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_PMD_MKWRITE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_PAGE_SIZE_4KB=y
CONFIG_PAGE_SIZE_4KB=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_PAGE_SHIFT=12
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_VMAP_STACK is not set
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_ARCH_HAS_HW_PTE_YOUNG=y
CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
CONFIG_FUNCTION_ALIGNMENT_4B=y
CONFIG_FUNCTION_ALIGNMENT_16B=y
CONFIG_FUNCTION_ALIGNMENT=16
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_DEBUG is not set
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
# CONFIG_MODULE_SIG_SHA3_256 is not set
# CONFIG_MODULE_SIG_SHA3_384 is not set
# CONFIG_MODULE_SIG_SHA3_512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=y
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_TRIM_UNUSED_KSYMS=y
CONFIG_UNUSED_KSYMS_WHITELIST=""
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_CGROUP_PUNT_BIO=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_WRITE_MOUNTED is not set
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
CONFIG_BLK_DEV_THROTTLING_LOW=y
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_CGROUP_IOLATENCY=y
CONFIG_BLK_CGROUP_FC_APPID=y
CONFIG_BLK_CGROUP_IOCOST=y
CONFIG_BLK_CGROUP_IOPRIO=y
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
# CONFIG_BFQ_GROUP_IOSCHED is not set
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
# CONFIG_SWAP is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_ZSMALLOC_CHAIN_SIZE=8

#
# Slab allocator options
#
CONFIG_SLUB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
CONFIG_RANDOM_KMALLOC_CACHES=y
# end of Slab allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_COMPAT_BRK=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP=y
CONFIG_ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_COMPACT_UNEVICTABLE_DEFAULT=1
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PCP_BATCH_SCALE_MAX=5
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
# CONFIG_TRANSPARENT_HUGEPAGE_NEVER is not set
CONFIG_READ_ONLY_THP_FOR_FS=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_CMA=y
CONFIG_CMA_DEBUGFS=y
# CONFIG_CMA_SYSFS is not set
CONFIG_CMA_AREAS=8
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_HMM_MIRROR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_TEST=y
CONFIG_DMAPOOL_TEST=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MEMFD_CREATE=y
CONFIG_SECRETMEM=y
CONFIG_ANON_VMA_NAME=y
# CONFIG_USERFAULTFD is not set
# CONFIG_LRU_GEN is not set
CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=y
CONFIG_LOCK_MM_AND_FIND_VMA=y

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_VADDR=y
CONFIG_DAMON_PADDR=y
CONFIG_DAMON_SYSFS=y
CONFIG_DAMON_DBGFS_DEPRECATED=y
CONFIG_DAMON_DBGFS=y
CONFIG_DAMON_RECLAIM=y
# CONFIG_DAMON_LRU_SORT is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_XGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
CONFIG_TLS=m
# CONFIG_TLS_DEVICE is not set
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
CONFIG_XFRM_INTERFACE=m
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_NET_KEY=m
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_SMC=m
CONFIG_SMC_DIAG=m
# CONFIG_XDP_SOCKETS is not set
CONFIG_NET_HANDSHAKE=y
# CONFIG_NET_HANDSHAKE_KUNIT_TEST is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_FIB_TRIE_STATS is not set
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
# CONFIG_IP_ROUTE_VERBOSE is not set
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=m
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=m
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TABLE_PERTURB_ORDER=16
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
CONFIG_INET_DIAG_DESTROY=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_SIGPOOL=y
CONFIG_TCP_AO=y
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
# CONFIG_INET6_ESPINTCP is not set
# CONFIG_INET6_IPCOMP is not set
CONFIG_IPV6_MIP6=m
CONFIG_IPV6_ILA=m
CONFIG_INET6_TUNNEL=y
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
# CONFIG_IPV6_GRE is not set
CONFIG_IPV6_FOU=m
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_IPV6_SUBTREES=y
# CONFIG_IPV6_MROUTE is not set
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_IPV6_RPL_LWTUNNEL=y
CONFIG_IPV6_IOAM6_LWTUNNEL=y
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_BPF_LINK=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
CONFIG_NETFILTER_NETLINK_ACCT=y
# CONFIG_NETFILTER_NETLINK_QUEUE is not set
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=y
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_ZONES=y
# CONFIG_NF_CONNTRACK_PROCFS is not set
# CONFIG_NF_CONNTRACK_EVENTS is not set
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
# CONFIG_NF_CONNTRACK_LABELS is not set
CONFIG_NF_CONNTRACK_OVS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
# CONFIG_NF_CT_PROTO_SCTP is not set
# CONFIG_NF_CT_PROTO_UDPLITE is not set
CONFIG_NF_CONNTRACK_AMANDA=m
# CONFIG_NF_CONNTRACK_FTP is not set
# CONFIG_NF_CONNTRACK_H323 is not set
# CONFIG_NF_CONNTRACK_IRC is not set
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
# CONFIG_NF_CONNTRACK_SNMP is not set
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
# CONFIG_NF_CT_NETLINK is not set
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NF_NAT_OVS=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
# CONFIG_NF_TABLES_NETDEV is not set
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
# CONFIG_NFT_LIMIT is not set
# CONFIG_NFT_MASQ is not set
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
CONFIG_NFT_XFRM=m
CONFIG_NFT_SOCKET=m
CONFIG_NFT_OSF=m
CONFIG_NFT_TPROXY=m
CONFIG_NFT_SYNPROXY=m
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
# CONFIG_NF_FLOW_TABLE_PROCFS is not set
CONFIG_NETFILTER_XTABLES=y
# CONFIG_NETFILTER_XTABLES_COMPAT is not set

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=y
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=y

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=y
# CONFIG_NETFILTER_XT_TARGET_CHECKSUM is not set
# CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
# CONFIG_NETFILTER_XT_TARGET_DSCP is not set
CONFIG_NETFILTER_XT_TARGET_HL=m
# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=y
# CONFIG_NETFILTER_XT_TARGET_MARK is not set
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=y
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
# CONFIG_NETFILTER_XT_MATCH_CLUSTER is not set
# CONFIG_NETFILTER_XT_MATCH_COMMENT is not set
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
# CONFIG_NETFILTER_XT_MATCH_CONNLABEL is not set
# CONFIG_NETFILTER_XT_MATCH_CONNLIMIT is not set
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
# CONFIG_NETFILTER_XT_MATCH_CONNTRACK is not set
# CONFIG_NETFILTER_XT_MATCH_CPU is not set
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
# CONFIG_NETFILTER_XT_MATCH_DSCP is not set
# CONFIG_NETFILTER_XT_MATCH_ECN is not set
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
CONFIG_NETFILTER_XT_MATCH_IPCOMP=m
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=y
# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
# CONFIG_NETFILTER_XT_MATCH_LIMIT is not set
# CONFIG_NETFILTER_XT_MATCH_MAC is not set
# CONFIG_NETFILTER_XT_MATCH_MARK is not set
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
# CONFIG_NETFILTER_XT_MATCH_OSF is not set
CONFIG_NETFILTER_XT_MATCH_OWNER=y
CONFIG_NETFILTER_XT_MATCH_POLICY=m
# CONFIG_NETFILTER_XT_MATCH_PHYSDEV is not set
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=y
CONFIG_NETFILTER_XT_MATCH_RECENT=y
CONFIG_NETFILTER_XT_MATCH_SCTP=m
# CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
CONFIG_NETFILTER_XT_MATCH_STATE=m
# CONFIG_NETFILTER_XT_MATCH_STATISTIC is not set
CONFIG_NETFILTER_XT_MATCH_STRING=y
CONFIG_NETFILTER_XT_MATCH_TCPMSS=y
CONFIG_NETFILTER_XT_MATCH_TIME=m
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=y
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
# CONFIG_IP_SET_BITMAP_IPMAC is not set
CONFIG_IP_SET_BITMAP_PORT=y
CONFIG_IP_SET_HASH_IP=m
# CONFIG_IP_SET_HASH_IPMARK is not set
CONFIG_IP_SET_HASH_IPPORT=y
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=y
CONFIG_IP_SET_HASH_IPMAC=m
# CONFIG_IP_SET_HASH_MAC is not set
CONFIG_IP_SET_HASH_NETPORTNET=y
# CONFIG_IP_SET_HASH_NET is not set
CONFIG_IP_SET_HASH_NETNET=m
# CONFIG_IP_SET_HASH_NETPORT is not set
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=y
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
CONFIG_IP_VS_DEBUG=y
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
# CONFIG_IP_VS_PROTO_ESP is not set
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
# CONFIG_IP_VS_RR is not set
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
# CONFIG_IP_VS_LBLC is not set
CONFIG_IP_VS_LBLCR=m
# CONFIG_IP_VS_DH is not set
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_MH=m
CONFIG_IP_VS_SED=m
# CONFIG_IP_VS_NQ is not set
CONFIG_IP_VS_TWOS=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
# CONFIG_IP_VS_NFCT is not set
# CONFIG_IP_VS_PE_SIP is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
# CONFIG_NF_LOG_IPV4 is not set
CONFIG_NF_REJECT_IPV4=y
CONFIG_NF_NAT_PPTP=m
# CONFIG_IP_NF_IPTABLES is not set
# CONFIG_IP_NF_ARPFILTER is not set
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_IP6_NF_IPTABLES_LEGACY=m
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=y
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
# CONFIG_IP6_NF_MATCH_HL is not set
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
# CONFIG_IP6_NF_MATCH_RPFILTER is not set
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_MATCH_SRH=m
CONFIG_IP6_NF_FILTER=m
# CONFIG_IP6_NF_TARGET_REJECT is not set
# CONFIG_IP6_NF_TARGET_SYNPROXY is not set
# CONFIG_IP6_NF_MANGLE is not set
# CONFIG_IP6_NF_RAW is not set
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
# CONFIG_IP6_NF_TARGET_NPT is not set
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
CONFIG_NFT_BRIDGE_META=m
# CONFIG_NFT_BRIDGE_REJECT is not set
CONFIG_NF_CONNTRACK_BRIDGE=m
CONFIG_BRIDGE_NF_EBTABLES_LEGACY=m
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
# CONFIG_BRIDGE_EBT_T_FILTER is not set
# CONFIG_BRIDGE_EBT_T_NAT is not set
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
# CONFIG_BRIDGE_EBT_IP is not set
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
# CONFIG_BRIDGE_EBT_MARK is not set
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
# CONFIG_BRIDGE_EBT_DNAT is not set
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
# CONFIG_BRIDGE_EBT_SNAT is not set
CONFIG_BRIDGE_EBT_LOG=m
# CONFIG_BRIDGE_EBT_NFLOG is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
CONFIG_RDS=m
# CONFIG_RDS_TCP is not set
# CONFIG_RDS_DEBUG is not set
CONFIG_TIPC=y
CONFIG_TIPC_MEDIA_UDP=y
# CONFIG_TIPC_CRYPTO is not set
CONFIG_TIPC_DIAG=y
# CONFIG_ATM is not set
CONFIG_L2TP=y
CONFIG_L2TP_DEBUGFS=y
# CONFIG_L2TP_V3 is not set
CONFIG_STP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
# CONFIG_BRIDGE_VLAN_FILTERING is not set
CONFIG_BRIDGE_MRP=y
# CONFIG_BRIDGE_CFM is not set
CONFIG_NET_DSA=m
CONFIG_NET_DSA_TAG_NONE=m
CONFIG_NET_DSA_TAG_AR9331=m
CONFIG_NET_DSA_TAG_BRCM_COMMON=m
CONFIG_NET_DSA_TAG_BRCM=m
CONFIG_NET_DSA_TAG_BRCM_LEGACY=m
CONFIG_NET_DSA_TAG_BRCM_PREPEND=m
CONFIG_NET_DSA_TAG_HELLCREEK=m
CONFIG_NET_DSA_TAG_GSWIP=m
CONFIG_NET_DSA_TAG_DSA_COMMON=m
CONFIG_NET_DSA_TAG_DSA=m
# CONFIG_NET_DSA_TAG_EDSA is not set
CONFIG_NET_DSA_TAG_MTK=m
CONFIG_NET_DSA_TAG_KSZ=m
CONFIG_NET_DSA_TAG_OCELOT=m
CONFIG_NET_DSA_TAG_OCELOT_8021Q=m
CONFIG_NET_DSA_TAG_QCA=m
# CONFIG_NET_DSA_TAG_RTL4_A is not set
# CONFIG_NET_DSA_TAG_RTL8_4 is not set
CONFIG_NET_DSA_TAG_RZN1_A5PSW=m
CONFIG_NET_DSA_TAG_LAN9303=m
CONFIG_NET_DSA_TAG_SJA1105=m
CONFIG_NET_DSA_TAG_TRAILER=m
CONFIG_NET_DSA_TAG_XRS700X=m
CONFIG_VLAN_8021Q=m
# CONFIG_VLAN_8021Q_GVRP is not set
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_LLC=y
CONFIG_LLC2=y
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
CONFIG_LAPB=m
CONFIG_PHONET=m
# CONFIG_6LOWPAN is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
# CONFIG_IEEE802154_SOCKET is not set
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_PRIO=y
# CONFIG_NET_SCH_MULTIQ is not set
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
# CONFIG_NET_SCH_TEQL is not set
CONFIG_NET_SCH_TBF=y
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
CONFIG_NET_SCH_MQPRIO_LIB=m
CONFIG_NET_SCH_TAPRIO=m
CONFIG_NET_SCH_GRED=y
# CONFIG_NET_SCH_NETEM is not set
CONFIG_NET_SCH_DRR=y
# CONFIG_NET_SCH_MQPRIO is not set
CONFIG_NET_SCH_SKBPRIO=y
# CONFIG_NET_SCH_CHOKE is not set
# CONFIG_NET_SCH_QFQ is not set
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
CONFIG_NET_SCH_CAKE=m
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=y
CONFIG_NET_SCH_FQ_PIE=y
# CONFIG_NET_SCH_PLUG is not set
CONFIG_NET_SCH_ETS=y
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
# CONFIG_DEFAULT_FQ_CODEL is not set
# CONFIG_DEFAULT_FQ_PIE is not set
# CONFIG_DEFAULT_SFQ is not set
CONFIG_DEFAULT_PFIFO_FAST=y
CONFIG_DEFAULT_NET_SCH="pfifo_fast"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=y
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_FLOW=y
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=y
# CONFIG_NET_CLS_MATCHALL is not set
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
# CONFIG_NET_EMATCH_U32 is not set
# CONFIG_NET_EMATCH_META is not set
CONFIG_NET_EMATCH_TEXT=y
CONFIG_NET_EMATCH_CANID=y
# CONFIG_NET_EMATCH_IPSET is not set
# CONFIG_NET_EMATCH_IPT is not set
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_BATMAN_V is not set
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
# CONFIG_BATMAN_ADV_NC is not set
# CONFIG_BATMAN_ADV_DEBUG is not set
# CONFIG_BATMAN_ADV_TRACING is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
# CONFIG_MPLS_ROUTING is not set
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
# CONFIG_NET_L3_MASTER_DEV is not set
CONFIG_QRTR=y
CONFIG_QRTR_SMD=m
CONFIG_QRTR_TUN=m
CONFIG_QRTR_MHI=m
# CONFIG_NET_NCSI is not set
CONFIG_MAX_SKB_FRAGS=17
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
# CONFIG_BQL is not set
# CONFIG_BPF_STREAM_PARSER is not set

#
# Network testing
#
CONFIG_NET_PKTGEN=y
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
# CONFIG_CAN_BCM is not set
CONFIG_CAN_GW=m
CONFIG_CAN_J1939=m
CONFIG_CAN_ISOTP=m
CONFIG_BT=y
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
# CONFIG_BT_BNEP is not set
# CONFIG_BT_HIDP is not set
CONFIG_BT_LE=y
CONFIG_BT_LE_L2CAP_ECRED=y
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
# CONFIG_BT_AOSPEXT is not set
# CONFIG_BT_DEBUGFS is not set
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
CONFIG_BT_QCA=m
CONFIG_BT_MTK=y
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_SERDEV=y
CONFIG_BT_HCIUART_H4=y
# CONFIG_BT_HCIUART_NOKIA is not set
# CONFIG_BT_HCIUART_BCSP is not set
# CONFIG_BT_HCIUART_ATH3K is not set
CONFIG_BT_HCIUART_LL=y
# CONFIG_BT_HCIUART_3WIRE is not set
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_BCM is not set
# CONFIG_BT_HCIUART_RTL is not set
CONFIG_BT_HCIUART_QCA=y
# CONFIG_BT_HCIUART_AG6XX is not set
CONFIG_BT_HCIUART_MRVL=y
# CONFIG_BT_HCIBCM4377 is not set
# CONFIG_BT_HCIDTL1 is not set
CONFIG_BT_HCIBT3C=m
CONFIG_BT_HCIBLUECARD=m
# CONFIG_BT_HCIVHCI is not set
CONFIG_BT_MRVL=y
CONFIG_BT_MRVL_SDIO=y
CONFIG_BT_MTKSDIO=y
CONFIG_BT_MTKUART=m
# CONFIG_BT_VIRTIO is not set
CONFIG_BT_NXPUART=m
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=y
# CONFIG_AF_RXRPC_IPV6 is not set
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
CONFIG_AF_RXRPC_INJECT_RX_DELAY=y
CONFIG_AF_RXRPC_DEBUG=y
# CONFIG_RXKAD is not set
# CONFIG_RXPERF is not set
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
# CONFIG_WIRELESS is not set
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=y
CONFIG_CEPH_LIB_PRETTYDEBUG=y
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_PAGE_POOL_STATS=y
CONFIG_FAILOVER=y
CONFIG_ETHTOOL_NETLINK=y
# CONFIG_NETDEV_ADDR_LIST_TEST is not set
CONFIG_NET_TEST=m

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
CONFIG_EISA_VLB_PRIMING=y
CONFIG_EISA_PCI_EISA=y
# CONFIG_EISA_VIRTUAL_ROOT is not set
# CONFIG_EISA_NAMES is not set
CONFIG_HAVE_PCI=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence-based PCIe controllers
#
# end of Cadence-based PCIe controllers

#
# DesignWare-based PCIe controllers
#
# end of DesignWare-based PCIe controllers

#
# Mobiveil-based PCIe controllers
#
# end of Mobiveil-based PCIe controllers
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
# CONFIG_FW_LOADER_DEBUG is not set
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_UPLOAD=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
CONFIG_DM_KUNIT_TEST=m
CONFIG_DRIVER_PE_KUNIT_TEST=m
CONFIG_GENERIC_CPU_DEVICES=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_SOC_BUS=y
CONFIG_REGMAP=y
CONFIG_REGMAP_KUNIT=m
CONFIG_REGMAP_BUILD=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_W1=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_RAM=m
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=m
# CONFIG_MHI_BUS_DEBUG is not set
# CONFIG_MHI_BUS_PCI_GENERIC is not set
# CONFIG_MHI_BUS_EP is not set
# end of Bus devices

#
# Cache Drivers
#
# end of Cache Drivers

CONFIG_CONNECTOR=m

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
CONFIG_FW_CS_DSP=m
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
# CONFIG_GOOGLE_COREBOOT_TABLE is not set
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set

#
# Qualcomm firmware drivers
#
# end of Qualcomm firmware drivers

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=m
CONFIG_GNSS_SERIAL=m
# CONFIG_GNSS_MTK_SERIAL is not set
# CONFIG_GNSS_SIRF_SERIAL is not set
CONFIG_GNSS_UBX_SERIAL=m
CONFIG_MTD=y
CONFIG_MTD_TESTS=m

#
# Partition parsers
#
CONFIG_MTD_CMDLINE_PARTS=m
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
CONFIG_FTL=m
CONFIG_NFTL=m
# CONFIG_NFTL_RW is not set
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
# CONFIG_SM_FTL is not set
CONFIG_MTD_OOPS=m
# CONFIG_MTD_PSTORE is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_COMPAT=y
CONFIG_MTD_PHYSMAP_START=0x8000000
CONFIG_MTD_PHYSMAP_LEN=0
CONFIG_MTD_PHYSMAP_BANKWIDTH=2
CONFIG_MTD_PHYSMAP_GPIO_ADDR=y
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_PCMCIA is not set
CONFIG_MTD_PLATRAM=m
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_SLRAM=y
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
CONFIG_MTD_ONENAND=m
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=m
# CONFIG_MTD_ONENAND_OTP is not set
CONFIG_MTD_ONENAND_2X_PROGRAM=y
# CONFIG_MTD_RAW_NAND is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
# CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
CONFIG_MTD_NAND_ECC_MXIC=y
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_GLUEBI=m
CONFIG_MTD_UBI_BLOCK=y
CONFIG_MTD_UBI_NVMEM=y
CONFIG_MTD_HYPERBUS=y
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_PC_PCMCIA=m
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=y
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_FD_RAWCMD is not set
CONFIG_CDROM=y
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=y
CONFIG_ZRAM_DEF_COMP_ZSTD=y
# CONFIG_ZRAM_DEF_COMP_LZ4 is not set
# CONFIG_ZRAM_DEF_COMP_LZ4HC is not set
# CONFIG_ZRAM_DEF_COMP_842 is not set
CONFIG_ZRAM_DEF_COMP="zstd"
# CONFIG_ZRAM_WRITEBACK is not set
CONFIG_ZRAM_TRACK_ENTRY_ACTIME=y
CONFIG_ZRAM_MEMORY_TRACKING=y
# CONFIG_ZRAM_MULTI_COMP is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_DRBD=y
CONFIG_DRBD_FAULT_INJECTION=y
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_VIRTIO_BLK=m
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_UBLK is not set

#
# NVME Support
#
CONFIG_NVME_KEYRING=y
CONFIG_NVME_AUTH=y
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TCP is not set
CONFIG_NVME_HOST_AUTH=y
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
CONFIG_NVME_TARGET_TCP=y
CONFIG_NVME_TARGET_TCP_TLS=y
# CONFIG_NVME_TARGET_AUTH is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=y
CONFIG_ENCLOSURE_SERVICES=y
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=m
# CONFIG_DS1682 is not set
CONFIG_SRAM=y
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
# CONFIG_TPS6594_ESM is not set
# CONFIG_TPS6594_PFSM is not set
CONFIG_NSM=y
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
CONFIG_EEPROM_IDT_89HPESX=y
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=y
# end of Texas Instruments shared transport line discipline

# CONFIG_SENSORS_LIS3_I2C is not set
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
CONFIG_ECHO=y
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_PVPANIC is not set
# CONFIG_GP_PCI1XXXX is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_PROC_FS is not set
CONFIG_SCSI_LIB_KUNIT_TEST=m

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
# CONFIG_BLK_DEV_BSG is not set
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set
CONFIG_SCSI_PROTO_TEST=m

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
# CONFIG_SCSI_SAS_ATA is not set
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=m
# CONFIG_SCSI_DH_HP_SW is not set
# CONFIG_SCSI_DH_EMC is not set
CONFIG_SCSI_DH_ALUA=m
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_AHCI_PLATFORM is not set
CONFIG_AHCI_DWC=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
# CONFIG_ATA_BMDMA is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
CONFIG_PATA_PCMCIA=m
# CONFIG_PATA_RZ1000 is not set
CONFIG_PATA_PARPORT=m

#
# Parallel IDE protocol modules
#
# CONFIG_PATA_PARPORT_ATEN is not set
CONFIG_PATA_PARPORT_BPCK=m
CONFIG_PATA_PARPORT_BPCK6=m
CONFIG_PATA_PARPORT_COMM=m
CONFIG_PATA_PARPORT_DSTR=m
CONFIG_PATA_PARPORT_FIT2=m
CONFIG_PATA_PARPORT_FIT3=m
# CONFIG_PATA_PARPORT_EPAT is not set
# CONFIG_PATA_PARPORT_EPIA is not set
CONFIG_PATA_PARPORT_FRIQ=m
CONFIG_PATA_PARPORT_FRPW=m
# CONFIG_PATA_PARPORT_KBIC is not set
CONFIG_PATA_PARPORT_KTTI=m
# CONFIG_PATA_PARPORT_ON20 is not set
CONFIG_PATA_PARPORT_ON26=m

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_LEGACY is not set
# CONFIG_MD is not set
CONFIG_TARGET_CORE=m
# CONFIG_TCM_IBLOCK is not set
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
# CONFIG_LOOPBACK_TARGET is not set
CONFIG_ISCSI_TARGET=m
CONFIG_REMOTE_TARGET=m
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
# CONFIG_NET_CORE is not set
# CONFIG_ARCNET is not set

#
# Distributed Switch Architecture drivers
#
CONFIG_B53=m
# CONFIG_B53_MDIO_DRIVER is not set
CONFIG_B53_MMAP_DRIVER=m
# CONFIG_B53_SRAB_DRIVER is not set
# CONFIG_B53_SERDES is not set
CONFIG_NET_DSA_BCM_SF2=m
CONFIG_NET_DSA_LOOP=m
CONFIG_NET_DSA_HIRSCHMANN_HELLCREEK=m
CONFIG_NET_DSA_LANTIQ_GSWIP=m
CONFIG_NET_DSA_MT7530=m
CONFIG_NET_DSA_MT7530_MDIO=m
CONFIG_NET_DSA_MT7530_MMIO=m
CONFIG_NET_DSA_MV88E6060=m
CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON=m
CONFIG_NET_DSA_MICROCHIP_KSZ9477_I2C=m
# CONFIG_NET_DSA_MICROCHIP_KSZ_PTP is not set
CONFIG_NET_DSA_MICROCHIP_KSZ8863_SMI=m
# CONFIG_NET_DSA_MV88E6XXX is not set
CONFIG_NET_DSA_AR9331=m
CONFIG_NET_DSA_QCA8K=m
# CONFIG_NET_DSA_QCA8K_LEDS_SUPPORT is not set
CONFIG_NET_DSA_XRS700X=m
CONFIG_NET_DSA_XRS700X_I2C=m
CONFIG_NET_DSA_XRS700X_MDIO=m
CONFIG_NET_DSA_REALTEK=m
CONFIG_NET_DSA_SMSC_LAN9303=m
CONFIG_NET_DSA_SMSC_LAN9303_I2C=m
CONFIG_NET_DSA_SMSC_LAN9303_MDIO=m
CONFIG_NET_DSA_VITESSE_VSC73XX=m
CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM=m
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
CONFIG_ALTERA_TSE=m
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
# CONFIG_NET_VENDOR_ARC is not set
CONFIG_NET_VENDOR_ASIX=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_CAVIUM_PTP is not set
# CONFIG_LIQUIDIO is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_NET_VENDOR_DAVICOM is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
# CONFIG_NET_VENDOR_ENGLEDER is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
# CONFIG_NET_VENDOR_FUJITSU is not set
# CONFIG_NET_VENDOR_FUNGIBLE is not set
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=y
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
# CONFIG_OCTEON_EP_VF is not set
CONFIG_PRESTERA=m
CONFIG_PRESTERA_PCI=m
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
CONFIG_MLXFW=y
# CONFIG_NET_VENDOR_MICREL is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
CONFIG_VCAP=y
# CONFIG_NET_VENDOR_MICROSEMI is not set
# CONFIG_NET_VENDOR_MICROSOFT is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
CONFIG_NI_XGE_MANAGEMENT_ENET=m
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=y
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_NET_VENDOR_PENSANDO is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
CONFIG_ATP=m
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_PCMCIA_SMC91C92=m
# CONFIG_EPIC100 is not set
CONFIG_SMSC911X=y
# CONFIG_SMSC9420 is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VERTEXCOM is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WANGXUN=y
# CONFIG_NGBE is not set
CONFIG_NET_VENDOR_WIZNET=y
CONFIG_WIZNET_W5100=m
CONFIG_WIZNET_W5300=y
# CONFIG_WIZNET_BUS_DIRECT is not set
# CONFIG_WIZNET_BUS_INDIRECT is not set
CONFIG_WIZNET_BUS_ANY=y
CONFIG_NET_VENDOR_XILINX=y
CONFIG_XILINX_EMACLITE=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
CONFIG_NET_VENDOR_XIRCOM=y
CONFIG_PCMCIA_XIRC2PS=m
CONFIG_FDDI=y
CONFIG_DEFXX=y
# CONFIG_SKFP is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
CONFIG_LED_TRIGGER_PHY=y
CONFIG_FIXED_PHY=y
CONFIG_SFP=m

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=y
# CONFIG_ADIN_PHY is not set
# CONFIG_ADIN1100_PHY is not set
CONFIG_AQUANTIA_PHY=m
# CONFIG_AX88796B_PHY is not set
# CONFIG_BROADCOM_PHY is not set
CONFIG_BCM54140_PHY=m
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM84881_PHY=m
# CONFIG_BCM87XX_PHY is not set
CONFIG_BCM_NET_PHYLIB=y
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=y
CONFIG_ICPLUS_PHY=y
CONFIG_LXT_PHY=y
CONFIG_INTEL_XWAY_PHY=y
CONFIG_LSI_ET1011C_PHY=y
CONFIG_MARVELL_PHY=y
CONFIG_MARVELL_10G_PHY=y
CONFIG_MARVELL_88Q2XXX_PHY=m
CONFIG_MARVELL_88X2222_PHY=m
# CONFIG_MAXLINEAR_GPHY is not set
CONFIG_MEDIATEK_GE_PHY=y
# CONFIG_MEDIATEK_GE_SOC_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_T1S_PHY is not set
CONFIG_MICROCHIP_PHY=m
# CONFIG_MICROCHIP_T1_PHY is not set
CONFIG_MICROSEMI_PHY=y
# CONFIG_MOTORCOMM_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_CBTX_PHY is not set
CONFIG_NXP_C45_TJA11XX_PHY=m
CONFIG_NCN26000_PHY=y
CONFIG_QCOM_NET_PHYLIB=y
# CONFIG_AT803X_PHY is not set
CONFIG_QCA83XX_PHY=y
# CONFIG_QCA808X_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=m
CONFIG_RENESAS_PHY=m
CONFIG_ROCKCHIP_PHY=m
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
CONFIG_TERANETICS_PHY=y
CONFIG_DP83822_PHY=m
CONFIG_DP83TC811_PHY=y
CONFIG_DP83848_PHY=y
CONFIG_DP83867_PHY=y
CONFIG_DP83869_PHY=y
# CONFIG_DP83TD510_PHY is not set
CONFIG_DP83TG720_PHY=y
CONFIG_VITESSE_PHY=y
CONFIG_XILINX_GMII2RGMII=y
# CONFIG_PSE_CONTROLLER is not set
CONFIG_CAN_DEV=m
# CONFIG_CAN_VCAN is not set
# CONFIG_CAN_VXCAN is not set
# CONFIG_CAN_NETLINK is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_BITBANG=m
CONFIG_MDIO_BCM_UNIMAC=m
CONFIG_MDIO_GPIO=m
CONFIG_MDIO_I2C=m
CONFIG_MDIO_MSCC_MIIM=y
CONFIG_MDIO_REGMAP=m
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
CONFIG_PCS_LYNX=m
CONFIG_PCS_MTK_LYNXI=m
# end of PCS device drivers

CONFIG_PLIP=m
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPP_DEFLATE=y
# CONFIG_PPP_FILTER is not set
# CONFIG_PPP_MPPE is not set
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPPOE is not set
CONFIG_PPPOE_HASH_BITS=4
# CONFIG_PPTP is not set
# CONFIG_PPPOL2TP is not set
# CONFIG_PPP_ASYNC is not set
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_SLIP=y
CONFIG_SLHC=y
# CONFIG_SLIP_COMPRESSED is not set
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y

#
# Host-side USB support is needed for USB Network Adapter support
#
# CONFIG_WLAN is not set
CONFIG_WAN=y
CONFIG_HDLC=y
CONFIG_HDLC_RAW=m
CONFIG_HDLC_RAW_ETH=y
# CONFIG_HDLC_CISCO is not set
CONFIG_HDLC_FR=y
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
CONFIG_FRAMER=m
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
CONFIG_IEEE802154_HWSIM=m

#
# Wireless WAN
#
CONFIG_WWAN=m
CONFIG_WWAN_DEBUGFS=y
CONFIG_WWAN_HWSIM=m
CONFIG_MHI_WWAN_CTRL=m
# CONFIG_MHI_WWAN_MBIM is not set
# CONFIG_RPMSG_WWAN_CTRL is not set
# CONFIG_IOSM is not set
# CONFIG_MTK_T7XX is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
CONFIG_HYPERV_NET=m
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=y
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_LEDS is not set
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=m
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=m
CONFIG_INPUT_KUNIT_TEST=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_PINEPHONE is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
# CONFIG_TABLET_USB_ACECAD is not set
# CONFIG_TABLET_USB_AIPTEK is not set
# CONFIG_TABLET_USB_HANWANG is not set
# CONFIG_TABLET_USB_KBTAB is not set
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=y
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_88PM860X=m
CONFIG_TOUCHSCREEN_AD7879=m
CONFIG_TOUCHSCREEN_AD7879_I2C=m
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
CONFIG_TOUCHSCREEN_BU21013=y
CONFIG_TOUCHSCREEN_BU21029=y
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
CONFIG_TOUCHSCREEN_CY8CTMG110=y
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=m
# CONFIG_TOUCHSCREEN_CYTTSP4_I2C is not set
# CONFIG_TOUCHSCREEN_CYTTSP5 is not set
CONFIG_TOUCHSCREEN_DA9034=m
CONFIG_TOUCHSCREEN_DA9052=m
CONFIG_TOUCHSCREEN_DYNAPRO=m
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
CONFIG_TOUCHSCREEN_EETI=m
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=m
CONFIG_TOUCHSCREEN_EXC3000=m
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
CONFIG_TOUCHSCREEN_GOODIX_BERLIN_CORE=m
CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C=m
CONFIG_TOUCHSCREEN_HIDEEP=y
CONFIG_TOUCHSCREEN_HYCON_HY46XX=y
CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX=m
CONFIG_TOUCHSCREEN_ILI210X=m
# CONFIG_TOUCHSCREEN_ILITEK is not set
CONFIG_TOUCHSCREEN_S6SY761=y
CONFIG_TOUCHSCREEN_GUNZE=m
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
CONFIG_TOUCHSCREEN_ELAN=m
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
CONFIG_TOUCHSCREEN_MAX11801=y
CONFIG_TOUCHSCREEN_MCS5000=y
# CONFIG_TOUCHSCREEN_MMS114 is not set
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
CONFIG_TOUCHSCREEN_MSG2638=y
# CONFIG_TOUCHSCREEN_MTOUCH is not set
CONFIG_TOUCHSCREEN_NOVATEK_NVT_TS=y
# CONFIG_TOUCHSCREEN_IMAGIS is not set
CONFIG_TOUCHSCREEN_INEXIO=m
CONFIG_TOUCHSCREEN_PENMOUNT=y
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
CONFIG_TOUCHSCREEN_TOUCHRIGHT=y
CONFIG_TOUCHSCREEN_TOUCHWIN=m
CONFIG_TOUCHSCREEN_PIXCIR=m
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
CONFIG_TOUCHSCREEN_WM831X=y
CONFIG_TOUCHSCREEN_WM97XX=m
CONFIG_TOUCHSCREEN_WM9705=y
CONFIG_TOUCHSCREEN_WM9712=y
# CONFIG_TOUCHSCREEN_WM9713 is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_MC13783=m
CONFIG_TOUCHSCREEN_TOUCHIT213=m
CONFIG_TOUCHSCREEN_TSC_SERIO=y
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
CONFIG_TOUCHSCREEN_TSC2004=m
CONFIG_TOUCHSCREEN_TSC2007=y
# CONFIG_TOUCHSCREEN_RM_TS is not set
CONFIG_TOUCHSCREEN_SILEAD=y
CONFIG_TOUCHSCREEN_SIS_I2C=y
CONFIG_TOUCHSCREEN_ST1232=y
# CONFIG_TOUCHSCREEN_STMFTS is not set
CONFIG_TOUCHSCREEN_SX8654=y
# CONFIG_TOUCHSCREEN_TPS6507X is not set
CONFIG_TOUCHSCREEN_ZET6223=y
CONFIG_TOUCHSCREEN_ZFORCE=y
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_TOUCHSCREEN_IQS5XX=m
# CONFIG_TOUCHSCREEN_IQS7211 is not set
# CONFIG_TOUCHSCREEN_ZINITIX is not set
# CONFIG_TOUCHSCREEN_HIMAX_HX83112B is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_88PM860X_ONKEY is not set
# CONFIG_INPUT_88PM80X_ONKEY is not set
CONFIG_INPUT_AD714X=y
CONFIG_INPUT_AD714X_I2C=y
CONFIG_INPUT_ATC260X_ONKEY=m
CONFIG_INPUT_BMA150=y
CONFIG_INPUT_E3X0_BUTTON=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_MC13783_PWRBUTTON=m
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GPIO_BEEPER=m
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=m
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=y
CONFIG_INPUT_RETU_PWRBUTTON=m
CONFIG_INPUT_AXP20X_PEK=m
CONFIG_INPUT_UINPUT=m
CONFIG_INPUT_PALMAS_PWRBUTTON=m
# CONFIG_INPUT_PCF50633_PMU is not set
CONFIG_INPUT_PCF8574=m
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
CONFIG_INPUT_DA7280_HAPTICS=y
CONFIG_INPUT_DA9052_ONKEY=m
CONFIG_INPUT_DA9063_ONKEY=m
CONFIG_INPUT_WM831X_ON=y
# CONFIG_INPUT_ADXL34X is not set
CONFIG_INPUT_IQS269A=y
# CONFIG_INPUT_IQS626A is not set
# CONFIG_INPUT_IQS7222 is not set
CONFIG_INPUT_CMA3000=m
CONFIG_INPUT_CMA3000_I2C=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
CONFIG_INPUT_DRV260X_HAPTICS=m
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_INPUT_RT5120_PWRKEY=m
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=m
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=m
CONFIG_GAMEPORT=m
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_LEGACY_TIOCSTI is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCILIB=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
# CONFIG_SERIAL_8250_MEN_MCB is not set
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_PCI1XXXX is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DFL is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_LANTIQ=y
# CONFIG_SERIAL_LANTIQ_CONSOLE is not set
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
CONFIG_SERIAL_SC16IS7XX_CORE=m
CONFIG_SERIAL_SC16IS7XX=m
CONFIG_SERIAL_SC16IS7XX_I2C=y
CONFIG_SERIAL_ALTERA_JTAGUART=m
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=m
CONFIG_SERIAL_FSL_LINFLEXUART=m
# CONFIG_SERIAL_MEN_Z135 is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_IPWIRELESS=m
CONFIG_N_GSM=y
# CONFIG_NOZOMI is not set
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
CONFIG_RPMSG_TTY=m
CONFIG_SERIAL_DEV_BUS=y
CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=y
CONFIG_VIRTIO_CONSOLE=m
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=y
CONFIG_HW_RANDOM_AMD=y
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=y
# CONFIG_HW_RANDOM_VIRTIO is not set
CONFIG_HW_RANDOM_XIPHERA=m
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
# CONFIG_DEVMEM is not set
CONFIG_NVRAM=y
# CONFIG_DEVPORT is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=m
# CONFIG_TCG_TIS is not set
CONFIG_TCG_TIS_I2C=m
CONFIG_TCG_TIS_I2C_CR50=y
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=y
# CONFIG_TCG_NSC is not set
CONFIG_TCG_ATMEL=m
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=m
# CONFIG_I2C_MUX_PCA954x is not set
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_ALGOPCA=m
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
CONFIG_I2C_GPIO=y
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_PARPORT=y
# CONFIG_I2C_PCI1XXXX is not set
CONFIG_I2C_TAOS_EVM=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
CONFIG_SPMI_HISI3670=m
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
CONFIG_PPS_CLIENT_LDISC=y
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
CONFIG_PTP_1588_CLOCK_IDTCM=m
CONFIG_PTP_1588_CLOCK_FC3W=m
CONFIG_PTP_1588_CLOCK_MOCK=y
# CONFIG_PTP_1588_CLOCK_VMW is not set
CONFIG_PTP_DFL_TOD=y
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_CY8C95X0=y
CONFIG_PINCTRL_DA9062=m
CONFIG_PINCTRL_MCP23S08_I2C=m
CONFIG_PINCTRL_MCP23S08=m
# CONFIG_PINCTRL_SX150X is not set
# CONFIG_PINCTRL_CS42L43 is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_INTEL_PLATFORM is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_METEORLAKE is not set
# CONFIG_PINCTRL_METEORPOINT is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_GENERIC_PLATFORM=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_MENZ127 is not set
CONFIG_GPIO_SIOX=y
CONFIG_GPIO_TANGIER=y
CONFIG_GPIO_AMD_FCH=m
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_F7188X=m
# CONFIG_GPIO_IT87 is not set
CONFIG_GPIO_SCH311X=m
CONFIG_GPIO_WINBOND=y
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_FXL6408 is not set
# CONFIG_GPIO_DS4520 is not set
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCA9570=m
CONFIG_GPIO_PCF857X=m
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ADP5520 is not set
CONFIG_GPIO_BD9571MWV=m
CONFIG_GPIO_DA9052=m
CONFIG_GPIO_ELKHARTLAKE=y
CONFIG_GPIO_KEMPLD=m
CONFIG_GPIO_LP3943=m
# CONFIG_GPIO_PALMAS is not set
CONFIG_GPIO_TPS65086=m
# CONFIG_GPIO_TPS6586X is not set
# CONFIG_GPIO_TPS65910 is not set
CONFIG_GPIO_TQMX86=m
# CONFIG_GPIO_WM831X is not set
CONFIG_GPIO_WM8350=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_LATCH=m
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
CONFIG_GPIO_SIM=m
# end of Virtual GPIO drivers

CONFIG_W1=m
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_AMD_AXI=m
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=m
CONFIG_W1_MASTER_GPIO=m
CONFIG_W1_MASTER_SGI=m
# CONFIG_W1_MASTER_UART is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
# CONFIG_W1_SLAVE_SMEM is not set
CONFIG_W1_SLAVE_DS2405=m
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=m
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=m
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2430=m
CONFIG_W1_SLAVE_DS2431=m
CONFIG_W1_SLAVE_DS2433=m
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=m
CONFIG_W1_SLAVE_DS250X=m
CONFIG_W1_SLAVE_DS2780=m
CONFIG_W1_SLAVE_DS2781=m
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_IP5XXX_POWER=m
CONFIG_WM831X_BACKUP=m
CONFIG_WM831X_POWER=m
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_88PM860X is not set
CONFIG_CHARGER_ADP5061=m
CONFIG_BATTERY_CW2015=m
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=m
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
CONFIG_BATTERY_SAMSUNG_SDI=y
# CONFIG_BATTERY_SBS is not set
CONFIG_CHARGER_SBS=y
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9030=y
CONFIG_BATTERY_DA9052=m
# CONFIG_BATTERY_DA9150 is not set
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=m
CONFIG_CHARGER_PCF50633=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_LT3651=y
# CONFIG_CHARGER_LTC4162L is not set
CONFIG_CHARGER_MAX77976=m
# CONFIG_CHARGER_MAX8998 is not set
# CONFIG_CHARGER_MT6360 is not set
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=y
CONFIG_CHARGER_BQ2515X=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=m
# CONFIG_CHARGER_BQ256XX is not set
CONFIG_CHARGER_SMB347=y
CONFIG_CHARGER_TPS65090=y
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_BATTERY_RT5033 is not set
CONFIG_CHARGER_RT5033=m
CONFIG_CHARGER_RT9455=m
CONFIG_CHARGER_RT9467=m
# CONFIG_CHARGER_RT9471 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_BATTERY_UG3105=y
CONFIG_FUEL_GAUGE_MM8013=m
# CONFIG_HWMON is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
# CONFIG_THERMAL_DEBUGFS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_INTEL_TCC=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
# CONFIG_SSB_DRIVER_GPIO is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_SFLASH=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
CONFIG_BCMA_DRIVER_GPIO=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_AS3711=y
# CONFIG_MFD_SMPRO is not set
CONFIG_PMIC_ADP5520=y
CONFIG_MFD_AAT2870_CORE=y
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_CS42L43=m
CONFIG_MFD_CS42L43_I2C=m
# CONFIG_MFD_MADERA is not set
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=m
CONFIG_MFD_DA9150=m
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_I2C=m
CONFIG_MFD_MP2629=y
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_INTEL_PMC_BXT is not set
CONFIG_MFD_IQS62X=m
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77541=y
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
CONFIG_MFD_MAX8998=y
CONFIG_MFD_MT6360=y
# CONFIG_MFD_MT6370 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=m
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=m
CONFIG_MFD_SY7636A=m
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
CONFIG_MFD_RT5033=y
CONFIG_MFD_RT5120=m
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SIMPLE_MFD_I2C=m
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
CONFIG_MFD_SKY81452=y
CONFIG_MFD_SYSCON=y
CONFIG_MFD_LP3943=m
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=m
CONFIG_TPS6105X=y
CONFIG_TPS65010=m
CONFIG_TPS6507X=m
CONFIG_MFD_TPS65086=y
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
# CONFIG_MFD_TPS65912_I2C is not set
CONFIG_MFD_TPS6594=y
CONFIG_MFD_TPS6594_I2C=y
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=y
CONFIG_MFD_TQMX86=m
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_WCD934X=y
CONFIG_MFD_ATC260X=m
CONFIG_MFD_ATC260X_I2C=m
# CONFIG_RAVE_SP_CORE is not set
CONFIG_MFD_INTEL_M10_BMC_CORE=y
CONFIG_MFD_INTEL_M10_BMC_PMCI=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_NETLINK_EVENTS=y
CONFIG_REGULATOR_88PG86X=y
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_88PM8607=m
CONFIG_REGULATOR_ACT8865=m
# CONFIG_REGULATOR_AD5398 is not set
# CONFIG_REGULATOR_AAT2870 is not set
CONFIG_REGULATOR_AS3711=m
# CONFIG_REGULATOR_ATC260X is not set
CONFIG_REGULATOR_AW37503=m
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_BD9571MWV=m
CONFIG_REGULATOR_DA903X=m
# CONFIG_REGULATOR_DA9052 is not set
CONFIG_REGULATOR_DA9062=m
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=y
# CONFIG_REGULATOR_FAN53555 is not set
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=m
# CONFIG_REGULATOR_LM363X is not set
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LTC3589=m
# CONFIG_REGULATOR_LTC3676 is not set
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX77503=y
CONFIG_REGULATOR_MAX77541=y
CONFIG_REGULATOR_MAX77857=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8893 is not set
CONFIG_REGULATOR_MAX8952=m
CONFIG_REGULATOR_MAX8998=m
CONFIG_REGULATOR_MAX20086=m
# CONFIG_REGULATOR_MAX20411 is not set
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77826=y
# CONFIG_REGULATOR_MC13783 is not set
# CONFIG_REGULATOR_MC13892 is not set
# CONFIG_REGULATOR_MP8859 is not set
CONFIG_REGULATOR_MT6311=m
# CONFIG_REGULATOR_MT6315 is not set
CONFIG_REGULATOR_MT6323=y
# CONFIG_REGULATOR_MT6331 is not set
# CONFIG_REGULATOR_MT6332 is not set
CONFIG_REGULATOR_MT6357=y
CONFIG_REGULATOR_MT6358=y
CONFIG_REGULATOR_MT6359=m
CONFIG_REGULATOR_MT6360=m
CONFIG_REGULATOR_MT6397=y
# CONFIG_REGULATOR_PALMAS is not set
# CONFIG_REGULATOR_PCA9450 is not set
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=m
CONFIG_REGULATOR_QCOM_SPMI=m
CONFIG_REGULATOR_QCOM_USB_VBUS=y
CONFIG_REGULATOR_RT4801=y
# CONFIG_REGULATOR_RT4803 is not set
CONFIG_REGULATOR_RT5033=m
CONFIG_REGULATOR_RT5120=m
# CONFIG_REGULATOR_RT5190A is not set
# CONFIG_REGULATOR_RT5739 is not set
CONFIG_REGULATOR_RT5759=m
# CONFIG_REGULATOR_RT6160 is not set
CONFIG_REGULATOR_RT6190=y
CONFIG_REGULATOR_RT6245=m
CONFIG_REGULATOR_RTQ2134=y
CONFIG_REGULATOR_RTMV20=y
CONFIG_REGULATOR_RTQ6752=y
CONFIG_REGULATOR_RTQ2208=y
CONFIG_REGULATOR_SKY81452=m
CONFIG_REGULATOR_SLG51000=y
CONFIG_REGULATOR_SY7636A=m
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
CONFIG_REGULATOR_TPS62360=m
CONFIG_REGULATOR_TPS65023=y
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65086=m
CONFIG_REGULATOR_TPS65090=y
# CONFIG_REGULATOR_TPS65132 is not set
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65910=y
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8350=y
CONFIG_REGULATOR_QCOM_LABIBB=m
CONFIG_RC_CORE=y
# CONFIG_LIRC is not set
CONFIG_RC_MAP=y
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=y
CONFIG_IR_JVC_DECODER=y
CONFIG_IR_MCE_KBD_DECODER=y
CONFIG_IR_NEC_DECODER=y
# CONFIG_IR_RC5_DECODER is not set
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
# CONFIG_IR_SANYO_DECODER is not set
CONFIG_IR_SHARP_DECODER=y
CONFIG_IR_SONY_DECODER=y
CONFIG_IR_XMP_DECODER=y
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=y

#
# CEC support
#
# CONFIG_MEDIA_CEC_RC is not set
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
# CONFIG_CEC_SECO is not set
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_APERTURE_HELPERS=y
CONFIG_SCREEN_INFO=y
CONFIG_VIDEO=y
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
CONFIG_LINEDISP=y
CONFIG_HD44780_COMMON=y
CONFIG_HD44780=y
# CONFIG_KS0108 is not set
CONFIG_IMG_ASCII_LCD=y
CONFIG_HT16K33=m
CONFIG_MAX6959=y
CONFIG_LCD2S=y
CONFIG_SEG_LED_GPIO=y
CONFIG_PARPORT_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
CONFIG_PANEL=m
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# Frame buffer Devices
#
CONFIG_FB=m
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=m
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
# CONFIG_FB_N411 is not set
CONFIG_FB_HGA=m
CONFIG_FB_OPENCORES=m
CONFIG_FB_S1D13XXX=m
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
CONFIG_FB_SM501=m
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_FB_VIRTUAL=m
CONFIG_FB_METRONOME=m
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
CONFIG_FB_SIMPLE=m
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
CONFIG_FB_CORE=m
CONFIG_FB_NOTIFY=y
CONFIG_FIRMWARE_EDID=y
CONFIG_FB_DEVICE=y
CONFIG_FB_CFB_FILLRECT=m
CONFIG_FB_CFB_COPYAREA=m
CONFIG_FB_CFB_IMAGEBLIT=m
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
CONFIG_FB_FOREIGN_ENDIAN=y
CONFIG_FB_BOTH_ENDIAN=y
# CONFIG_FB_BIG_ENDIAN is not set
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYSMEM_FOPS=m
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_IOMEM_FOPS=m
CONFIG_FB_IOMEM_HELPERS=y
CONFIG_FB_IOMEM_HELPERS_DEFERRED=y
CONFIG_FB_SYSMEM_HELPERS=y
CONFIG_FB_SYSMEM_HELPERS_DEFERRED=y
CONFIG_FB_BACKLIGHT=m
# CONFIG_FB_MODE_HELPERS is not set
# CONFIG_FB_TILEBLITTING is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=m
# CONFIG_BACKLIGHT_KTD253 is not set
CONFIG_BACKLIGHT_KTD2801=m
CONFIG_BACKLIGHT_KTZ8866=m
# CONFIG_BACKLIGHT_LM3533 is not set
CONFIG_BACKLIGHT_DA903X=m
# CONFIG_BACKLIGHT_DA9052 is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=m
CONFIG_BACKLIGHT_SAHARA=m
CONFIG_BACKLIGHT_WM831X=m
CONFIG_BACKLIGHT_ADP5520=m
CONFIG_BACKLIGHT_ADP8860=m
CONFIG_BACKLIGHT_ADP8870=m
CONFIG_BACKLIGHT_88PM860X=m
CONFIG_BACKLIGHT_PCF50633=m
CONFIG_BACKLIGHT_AAT2870=m
CONFIG_BACKLIGHT_LM3639=m
# CONFIG_BACKLIGHT_SKY81452 is not set
CONFIG_BACKLIGHT_AS3711=m
CONFIG_BACKLIGHT_GPIO=m
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=m
# end of Backlight & LCD device support

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
# CONFIG_FRAMEBUFFER_CONSOLE is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
# CONFIG_LOGO_LINUX_CLUT224 is not set
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_CORE_TEST=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
CONFIG_SND_CTL_FAST_LOOKUP=y
# CONFIG_SND_DEBUG is not set
CONFIG_SND_CTL_INPUT_VALIDATION=y
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_CTL_LED=m
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_SEQ_UMP=y
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_DRIVERS is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
# CONFIG_SND_HDA_INTEL is not set
# CONFIG_SND_HDA_HWDEP is not set
# CONFIG_SND_HDA_RECONFIG is not set
# CONFIG_SND_HDA_INPUT_BEEP is not set
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CIRRUS_SCODEC=m
CONFIG_SND_HDA_CIRRUS_SCODEC_KUNIT_TEST=m
CONFIG_SND_HDA_SCODEC_COMPONENT=m
# CONFIG_SND_HDA_SCODEC_CS35L56_I2C is not set
CONFIG_SND_HDA_CODEC_REALTEK=m
# CONFIG_SND_HDA_CODEC_ANALOG is not set
# CONFIG_SND_HDA_CODEC_SIGMATEL is not set
# CONFIG_SND_HDA_CODEC_VIA is not set
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CS8409=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
# CONFIG_SND_HDA_CODEC_CA0110 is not set
# CONFIG_SND_HDA_CODEC_CA0132 is not set
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_PCMCIA=y
# CONFIG_SND_VXPOCKET is not set
# CONFIG_SND_PDAUDIOCF is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_TOPOLOGY_BUILD=y
CONFIG_SND_SOC_TOPOLOGY_KUNIT_TEST=m
# CONFIG_SND_SOC_UTILS_KUNIT_TEST is not set
CONFIG_SND_SOC_ADI=m
# CONFIG_SND_SOC_ADI_AXI_I2S is not set
# CONFIG_SND_SOC_ADI_AXI_SPDIF is not set
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_SOC_AMD_RENOIR is not set
# CONFIG_SND_SOC_AMD_ACP5x is not set
# CONFIG_SND_SOC_AMD_ACP6x is not set
# CONFIG_SND_AMD_ACP_CONFIG is not set
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set
# CONFIG_SND_SOC_AMD_RPL_ACP6x is not set
# CONFIG_SND_SOC_AMD_PS is not set
CONFIG_SND_ATMEL_SOC=m
CONFIG_SND_BCM63XX_I2S_WHISTLER=m

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=m
CONFIG_SND_SOC_FSL_SAI=m
CONFIG_SND_SOC_FSL_MQS=m
# CONFIG_SND_SOC_FSL_AUDMIX is not set
CONFIG_SND_SOC_FSL_SSI=m
CONFIG_SND_SOC_FSL_SPDIF=m
CONFIG_SND_SOC_FSL_ESAI=m
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_FSL_EASRC is not set
CONFIG_SND_SOC_FSL_XCVR=m
CONFIG_SND_SOC_FSL_UTILS=m
CONFIG_SND_SOC_IMX_AUDMUX=m
# end of SoC Audio for Freescale CPUs

CONFIG_SND_SOC_CHV3_I2S=m
CONFIG_SND_I2S_HI6210_I2S=m
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=m
CONFIG_SND_SOC_IMG_I2S_OUT=m
# CONFIG_SND_SOC_IMG_PARALLEL_OUT is not set
CONFIG_SND_SOC_IMG_SPDIF_IN=m
# CONFIG_SND_SOC_IMG_SPDIF_OUT is not set
CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=m
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
CONFIG_SND_SOC_MTK_BTCVSD=m
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=m
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
CONFIG_SND_SOC_WM_ADSP=m
CONFIG_SND_SOC_AC97_CODEC=m
CONFIG_SND_SOC_ADAU_UTILS=m
CONFIG_SND_SOC_ADAU1372=m
CONFIG_SND_SOC_ADAU1372_I2C=m
CONFIG_SND_SOC_ADAU1701=m
# CONFIG_SND_SOC_ADAU1761_I2C is not set
CONFIG_SND_SOC_ADAU7002=m
CONFIG_SND_SOC_ADAU7118=m
# CONFIG_SND_SOC_ADAU7118_HW is not set
CONFIG_SND_SOC_ADAU7118_I2C=m
CONFIG_SND_SOC_AK4118=m
CONFIG_SND_SOC_AK4375=m
CONFIG_SND_SOC_AK4458=m
CONFIG_SND_SOC_AK4554=m
# CONFIG_SND_SOC_AK4613 is not set
CONFIG_SND_SOC_AK4642=m
# CONFIG_SND_SOC_AK5386 is not set
CONFIG_SND_SOC_AK5558=m
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_AW8738 is not set
CONFIG_SND_SOC_AW88395_LIB=m
CONFIG_SND_SOC_AW88395=m
# CONFIG_SND_SOC_AW88261 is not set
CONFIG_SND_SOC_AW87390=m
CONFIG_SND_SOC_AW88399=m
CONFIG_SND_SOC_BD28623=m
CONFIG_SND_SOC_BT_SCO=m
CONFIG_SND_SOC_CHV3_CODEC=m
# CONFIG_SND_SOC_CS_AMP_LIB_TEST is not set
CONFIG_SND_SOC_CS35L32=m
# CONFIG_SND_SOC_CS35L33 is not set
CONFIG_SND_SOC_CS35L34=m
CONFIG_SND_SOC_CS35L35=m
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS35L41_I2C is not set
CONFIG_SND_SOC_CS35L45=m
CONFIG_SND_SOC_CS35L45_I2C=m
# CONFIG_SND_SOC_CS35L56_I2C is not set
CONFIG_SND_SOC_CS42L42_CORE=m
CONFIG_SND_SOC_CS42L42=m
# CONFIG_SND_SOC_CS42L43 is not set
CONFIG_SND_SOC_CS42L51=m
CONFIG_SND_SOC_CS42L51_I2C=m
# CONFIG_SND_SOC_CS42L52 is not set
CONFIG_SND_SOC_CS42L56=m
CONFIG_SND_SOC_CS42L73=m
CONFIG_SND_SOC_CS42L83=m
CONFIG_SND_SOC_CS4234=m
CONFIG_SND_SOC_CS4265=m
CONFIG_SND_SOC_CS4270=m
# CONFIG_SND_SOC_CS4271_I2C is not set
CONFIG_SND_SOC_CS42XX8=m
CONFIG_SND_SOC_CS42XX8_I2C=m
CONFIG_SND_SOC_CS43130=m
CONFIG_SND_SOC_CS4341=m
CONFIG_SND_SOC_CS4349=m
CONFIG_SND_SOC_CS53L30=m
CONFIG_SND_SOC_CX2072X=m
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
CONFIG_SND_SOC_ES7241=m
CONFIG_SND_SOC_ES8316=m
CONFIG_SND_SOC_ES8326=m
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDA=m
# CONFIG_SND_SOC_ICS43432 is not set
CONFIG_SND_SOC_INNO_RK3036=m
CONFIG_SND_SOC_MAX98088=m
# CONFIG_SND_SOC_MAX98090 is not set
# CONFIG_SND_SOC_MAX98357A is not set
CONFIG_SND_SOC_MAX98504=m
CONFIG_SND_SOC_MAX9867=m
# CONFIG_SND_SOC_MAX98927 is not set
CONFIG_SND_SOC_MAX98520=m
# CONFIG_SND_SOC_MAX98373_I2C is not set
# CONFIG_SND_SOC_MAX98388 is not set
CONFIG_SND_SOC_MAX98390=m
# CONFIG_SND_SOC_MAX98396 is not set
CONFIG_SND_SOC_MAX9860=m
CONFIG_SND_SOC_MSM8916_WCD_ANALOG=m
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
CONFIG_SND_SOC_PCM1681=m
CONFIG_SND_SOC_PCM1789=m
CONFIG_SND_SOC_PCM1789_I2C=m
# CONFIG_SND_SOC_PCM179X_I2C is not set
CONFIG_SND_SOC_PCM186X=m
CONFIG_SND_SOC_PCM186X_I2C=m
CONFIG_SND_SOC_PCM3060=m
CONFIG_SND_SOC_PCM3060_I2C=m
CONFIG_SND_SOC_PCM3168A=m
CONFIG_SND_SOC_PCM3168A_I2C=m
CONFIG_SND_SOC_PCM5102A=m
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
# CONFIG_SND_SOC_RT5616 is not set
CONFIG_SND_SOC_RT5631=m
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5659=m
# CONFIG_SND_SOC_RT9120 is not set
CONFIG_SND_SOC_RTQ9128=m
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SIGMADSP=m
CONFIG_SND_SOC_SIGMADSP_I2C=m
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIMPLE_MUX is not set
CONFIG_SND_SOC_SMA1303=m
CONFIG_SND_SOC_SPDIF=m
CONFIG_SND_SOC_SRC4XXX_I2C=m
CONFIG_SND_SOC_SRC4XXX=m
CONFIG_SND_SOC_SSM2305=m
CONFIG_SND_SOC_SSM2518=m
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
CONFIG_SND_SOC_STA32X=m
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
CONFIG_SND_SOC_TAS2562=m
CONFIG_SND_SOC_TAS2764=m
CONFIG_SND_SOC_TAS2770=m
CONFIG_SND_SOC_TAS2780=m
CONFIG_SND_SOC_TAS2781_COMLIB=m
CONFIG_SND_SOC_TAS2781_FMWLIB=m
CONFIG_SND_SOC_TAS2781_I2C=m
CONFIG_SND_SOC_TAS5086=m
# CONFIG_SND_SOC_TAS571X is not set
CONFIG_SND_SOC_TAS5720=m
CONFIG_SND_SOC_TAS5805M=m
# CONFIG_SND_SOC_TAS6424 is not set
CONFIG_SND_SOC_TDA7419=m
# CONFIG_SND_SOC_TFA9879 is not set
CONFIG_SND_SOC_TFA989X=m
CONFIG_SND_SOC_TLV320ADC3XXX=m
CONFIG_SND_SOC_TLV320AIC23=m
CONFIG_SND_SOC_TLV320AIC23_I2C=m
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC3X_I2C is not set
CONFIG_SND_SOC_TLV320ADCX140=m
# CONFIG_SND_SOC_TS3A227E is not set
CONFIG_SND_SOC_TSCS42XX=m
CONFIG_SND_SOC_TSCS454=m
CONFIG_SND_SOC_UDA1334=m
# CONFIG_SND_SOC_WCD9335 is not set
# CONFIG_SND_SOC_WM8510 is not set
CONFIG_SND_SOC_WM8523=m
CONFIG_SND_SOC_WM8524=m
CONFIG_SND_SOC_WM8580=m
# CONFIG_SND_SOC_WM8711 is not set
CONFIG_SND_SOC_WM8728=m
# CONFIG_SND_SOC_WM8731_I2C is not set
# CONFIG_SND_SOC_WM8737 is not set
CONFIG_SND_SOC_WM8741=m
CONFIG_SND_SOC_WM8750=m
# CONFIG_SND_SOC_WM8753 is not set
CONFIG_SND_SOC_WM8776=m
# CONFIG_SND_SOC_WM8782 is not set
CONFIG_SND_SOC_WM8804=m
CONFIG_SND_SOC_WM8804_I2C=m
CONFIG_SND_SOC_WM8903=m
CONFIG_SND_SOC_WM8904=m
CONFIG_SND_SOC_WM8940=m
CONFIG_SND_SOC_WM8960=m
# CONFIG_SND_SOC_WM8961 is not set
CONFIG_SND_SOC_WM8962=m
CONFIG_SND_SOC_WM8974=m
CONFIG_SND_SOC_WM8978=m
# CONFIG_SND_SOC_WM8985 is not set
CONFIG_SND_SOC_MAX9759=m
CONFIG_SND_SOC_MT6351=m
CONFIG_SND_SOC_MT6358=m
# CONFIG_SND_SOC_MT6660 is not set
CONFIG_SND_SOC_NAU8315=m
CONFIG_SND_SOC_NAU8540=m
CONFIG_SND_SOC_NAU8810=m
CONFIG_SND_SOC_NAU8821=m
# CONFIG_SND_SOC_NAU8822 is not set
# CONFIG_SND_SOC_NAU8824 is not set
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=m
CONFIG_SND_SIMPLE_CARD=m
# CONFIG_SND_X86 is not set
CONFIG_SND_VIRTIO=m
CONFIG_AC97_BUS=m
CONFIG_HID_SUPPORT=y
# CONFIG_HID is not set

#
# Intel ISH HID support
#
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# end of AMD SFH HID Support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y
CONFIG_USB_PCI_AMD=y

#
# USB dual-mode controller drivers
#

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=y
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=y
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=y
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
# CONFIG_MMC_SDHCI_PLTFM is not set
CONFIG_MMC_WBSD=y
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
CONFIG_SCSI_UFSHCD=y
CONFIG_SCSI_UFS_BSG=y
# CONFIG_SCSI_UFSHCD_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=m
CONFIG_SCSI_UFS_CDNS_PLATFORM=m
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=m

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
CONFIG_LEDS_EXPRESSWIRE=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=m
# CONFIG_LEDS_CLASS_FLASH is not set
CONFIG_LEDS_CLASS_MULTICOLOR=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_88PM860X is not set
CONFIG_LEDS_APU=m
CONFIG_LEDS_AW200XX=m
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3532=m
# CONFIG_LEDS_LM3533 is not set
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_MT6323=m
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_PCA995X=m
# CONFIG_LEDS_WM831X_STATUS is not set
CONFIG_LEDS_WM8350=m
CONFIG_LEDS_DA903X=m
# CONFIG_LEDS_DA9052 is not set
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2606MVV is not set
CONFIG_LEDS_BD2802=m
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_ADP5520 is not set
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_LM355x=m
# CONFIG_LEDS_MENF21BMC is not set
CONFIG_LEDS_IS31FL319X=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_MLXCPLD=m
CONFIG_LEDS_MLXREG=m
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_TI_LMU_COMMON=m
CONFIG_LEDS_LM36274=m
# CONFIG_LEDS_TPS6105X is not set

#
# Flash and Torch LED drivers
#

#
# RGB LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
CONFIG_LEDS_TRIGGER_DISK=y
CONFIG_LEDS_TRIGGER_MTD=y
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
CONFIG_LEDS_TRIGGER_ACTIVITY=m
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=y

#
# iptables trigger is under Netfilter config (LED target)
#
# CONFIG_LEDS_TRIGGER_TRANSIENT is not set
CONFIG_LEDS_TRIGGER_CAMERA=y
CONFIG_LEDS_TRIGGER_PANIC=y
CONFIG_LEDS_TRIGGER_NETDEV=m
CONFIG_LEDS_TRIGGER_PATTERN=m
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
# CONFIG_INFINIBAND_ADDR_TRANS is not set
CONFIG_INFINIBAND_VIRT_DMA=y
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_MTHCA is not set
# CONFIG_INFINIBAND_OCRDMA is not set
# CONFIG_INFINIBAND_RDMAVT is not set
# CONFIG_RDMA_RXE is not set
# CONFIG_RDMA_SIW is not set
# CONFIG_INFINIBAND_IPOIB is not set
# CONFIG_INFINIBAND_OPA_VNIC is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD_COMPAT is not set
# CONFIG_INTEL_IOATDMA is not set
# CONFIG_PLX_DMA is not set
CONFIG_XILINX_DMA=y
CONFIG_XILINX_XDMA=y
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y
CONFIG_SF_PDMA=y
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
CONFIG_DMABUF_MOVE_NOTIFY=y
CONFIG_DMABUF_DEBUG=y
CONFIG_DMABUF_SELFTESTS=m
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
# CONFIG_DMABUF_HEAPS_SYSTEM is not set
CONFIG_DMABUF_HEAPS_CMA=y
# end of DMABUF options

CONFIG_UIO=m
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_UIO_DMEM_GENIRQ=m
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_UIO_HV_GENERIC is not set
CONFIG_UIO_DFL=m
# CONFIG_VFIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO_ANCHOR=y
CONFIG_VIRTIO=y
# CONFIG_VIRTIO_MENU is not set
CONFIG_VDPA=y
CONFIG_VDPA_SIM=y
CONFIG_VDPA_SIM_NET=y
CONFIG_VDPA_SIM_BLOCK=m
CONFIG_VDPA_USER=m
CONFIG_MLX5_VDPA=y
CONFIG_MLX5_VDPA_STEERING_DEBUG=y
CONFIG_VHOST_IOTLB=y
CONFIG_VHOST_RING=y
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=y
CONFIG_HYPERV_TIMER=y
# CONFIG_HYPERV_UTILS is not set
# CONFIG_HYPERV_BALLOON is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=m
CONFIG_GREYBUS_BEAGLEPLAY=m
CONFIG_COMEDI=m
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_PCMCIA_DRIVERS=m
CONFIG_COMEDI_CB_DAS16_CS=m
CONFIG_COMEDI_DAS08_CS=m
# CONFIG_COMEDI_NI_DAQ_700_CS is not set
CONFIG_COMEDI_NI_DAQ_DIO24_CS=m
CONFIG_COMEDI_NI_LABPC_CS=m
CONFIG_COMEDI_NI_MIO_CS=m
# CONFIG_COMEDI_QUATECH_DAQP_CS is not set
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=m
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_NI_LABPC=m
CONFIG_COMEDI_NI_TIO=m
CONFIG_COMEDI_NI_ROUTING=m
CONFIG_COMEDI_TESTS=m
CONFIG_COMEDI_TESTS_EXAMPLE=m
CONFIG_COMEDI_TESTS_NI_ROUTES=m
CONFIG_STAGING=y
# CONFIG_RTS5208 is not set
# CONFIG_FB_SM750 is not set
CONFIG_STAGING_MEDIA=y
CONFIG_MOST_COMPONENTS=m
CONFIG_MOST_NET=m
CONFIG_MOST_I2C=m
CONFIG_GREYBUS_AUDIO=m
CONFIG_GREYBUS_AUDIO_APB_CODEC=m
# CONFIG_GREYBUS_BOOTROM is not set
CONFIG_GREYBUS_LOG=m
CONFIG_GREYBUS_LOOPBACK=m
# CONFIG_GREYBUS_POWER is not set
# CONFIG_GREYBUS_RAW is not set
# CONFIG_GREYBUS_VIBRATOR is not set
# CONFIG_GREYBUS_BRIDGED_PHY is not set
CONFIG_FIELDBUS_DEV=m
# CONFIG_VME_BUS is not set
# CONFIG_GOLDFISH is not set
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_SURFACE_AGGREGATOR is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACPI_WMI is not set
# CONFIG_ACERHDF is not set
# CONFIG_ACER_WIRELESS is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_AMD_WBRF is not set
# CONFIG_ADV_SWBUTTON is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
# CONFIG_FUJITSU_LAPTOP is not set
# CONFIG_FUJITSU_TABLET is not set
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_X86_PLATFORM_DRIVERS_HP is not set
# CONFIG_WIRELESS_HOTKEY is not set
# CONFIG_IBM_RTL is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_SAR_INT1092 is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

#
# Intel Uncore Frequency Control
#
CONFIG_INTEL_UNCORE_FREQ_CONTROL=y
# end of Intel Uncore Frequency Control

# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
CONFIG_INTEL_PUNIT_IPC=y
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_EC is not set
# CONFIG_PCENGINES_APU2 is not set
CONFIG_BARCO_P50_GPIO=m
CONFIG_SAMSUNG_LAPTOP=m
# CONFIG_SAMSUNG_Q10 is not set
# CONFIG_TOSHIBA_BT_RFKILL is not set
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_PANASONIC_LAPTOP is not set
# CONFIG_TOPSTAR_LAPTOP is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_TOUCHSCREEN_DMI is not set
# CONFIG_INTEL_IPS is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
CONFIG_WINMATE_FM07_KEYS=y
# CONFIG_COMMON_CLK is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_IOVA=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
CONFIG_REMOTEPROC_CDEV=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=m
CONFIG_RPMSG_CHAR=m
CONFIG_RPMSG_CTRL=m
CONFIG_RPMSG_NS=m
CONFIG_RPMSG_VIRTIO=m
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# fujitsu SoC drivers
#
# end of fujitsu SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

CONFIG_WPCM450_SOC=y

#
# Qualcomm SoC drivers
#
# CONFIG_QCOM_PMIC_PDCHARGER_ULOG is not set
# CONFIG_QCOM_PBS is not set
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

#
# PM Domains
#

#
# Amlogic PM Domains
#
# end of Amlogic PM Domains

#
# Broadcom PM Domains
#
# end of Broadcom PM Domains

#
# i.MX PM Domains
#
# end of i.MX PM Domains

#
# Qualcomm PM Domains
#
# end of Qualcomm PM Domains
# end of PM Domains

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
CONFIG_DEVFREQ_GOV_POWERSAVE=m
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=m

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
CONFIG_MEMORY=y
CONFIG_FPGA_DFL_EMIF=m
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
# end of IRQ chip support

CONFIG_IPACK_BUS=m
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=m
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_GPIO=m
CONFIG_RESET_TI_SYSCON=m
# CONFIG_RESET_TI_TPS380X is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
CONFIG_PHY_CAN_TRANSCEIVER=y

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

CONFIG_POWERCAP=y
# CONFIG_INTEL_RAPL is not set
# CONFIG_IDLE_INJECT is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# CONFIG_DWC_PCIE_PMU is not set
# end of Performance monitor support

# CONFIG_RAS is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_NVDIMM_KEYS=y
# CONFIG_NVDIMM_SECURITY_TEST is not set
CONFIG_DAX=m
CONFIG_DEV_DAX=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_LAYOUTS is not set
# CONFIG_NVMEM_RMEM is not set
CONFIG_NVMEM_SPMI_SDAM=m

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
CONFIG_STM_PROTO_SYS_T=m
# CONFIG_STM_DUMMY is not set
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
# CONFIG_STM_SOURCE_FTRACE is not set
CONFIG_INTEL_TH=m
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
# CONFIG_INTEL_TH_MSU is not set
# CONFIG_INTEL_TH_PTI is not set
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
# CONFIG_FPGA_MGR_ALTERA_CVP is not set
CONFIG_FPGA_BRIDGE=y
CONFIG_ALTERA_FREEZE_BRIDGE=y
# CONFIG_XILINX_PR_DECOUPLER is not set
CONFIG_FPGA_REGION=y
CONFIG_FPGA_DFL=y
# CONFIG_FPGA_DFL_AFU is not set
# CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000 is not set
# CONFIG_FPGA_DFL_PCI is not set
# CONFIG_FPGA_M10_BMC_SEC_UPDATE is not set
# CONFIG_TEE is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
CONFIG_MUX_GPIO=m
# end of Multiplexer drivers

CONFIG_PM_OPP=y
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set
# CONFIG_INTERCONNECT is not set
CONFIG_COUNTER=m
# CONFIG_INTEL_QEP is not set
# CONFIG_INTERRUPT_CNT is not set
CONFIG_MOST=m
# CONFIG_MOST_CDEV is not set
CONFIG_MOST_SND=m
CONFIG_PECI=y
CONFIG_PECI_CPU=m
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_VALIDATE_FS_PARSER=y
CONFIG_FS_IOMAP=y
CONFIG_BUFFER_HEAD=y
CONFIG_LEGACY_DIRECT_IO=y
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_EXT4_KUNIT_TESTS=m
CONFIG_JBD2=y
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
# CONFIG_XFS_SUPPORT_ASCII_CI is not set
# CONFIG_XFS_QUOTA is not set
# CONFIG_XFS_POSIX_ACL is not set
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_DEBUG=y
# CONFIG_XFS_ASSERT_FATAL is not set
CONFIG_GFS2_FS=m
CONFIG_OCFS2_FS=y
# CONFIG_OCFS2_FS_O2CB is not set
# CONFIG_OCFS2_FS_STATS is not set
# CONFIG_OCFS2_DEBUG_MASKLOG is not set
CONFIG_OCFS2_DEBUG_FS=y
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_FS_REF_VERIFY=y
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=y
# CONFIG_F2FS_STAT_FS is not set
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
CONFIG_F2FS_FS_SECURITY=y
CONFIG_F2FS_CHECK_FS=y
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_F2FS_FS_COMPRESSION=y
# CONFIG_F2FS_FS_LZO is not set
# CONFIG_F2FS_FS_LZ4 is not set
# CONFIG_F2FS_FS_ZSTD is not set
# CONFIG_F2FS_IOSTAT is not set
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_BCACHEFS_FS=y
# CONFIG_BCACHEFS_QUOTA is not set
CONFIG_BCACHEFS_ERASURE_CODING=y
CONFIG_BCACHEFS_POSIX_ACL=y
# CONFIG_BCACHEFS_DEBUG is not set
# CONFIG_BCACHEFS_TESTS is not set
# CONFIG_BCACHEFS_LOCK_TIME_STATS is not set
CONFIG_BCACHEFS_NO_LATENCY_ACCT=y
CONFIG_MEAN_AND_VARIANCE_UNIT_TEST=m
CONFIG_ZONEFS_FS=m
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
CONFIG_FS_VERITY=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS_FS=m
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_FAT_KUNIT_TEST=m
CONFIG_EXFAT_FS=m
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS3_FS=m
CONFIG_NTFS3_64BIT_CLUSTER=y
# CONFIG_NTFS3_LZX_XPRESS is not set
# CONFIG_NTFS3_FS_POSIX_ACL is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_PROC_VMCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_TMPFS_INODE64 is not set
# CONFIG_TMPFS_QUOTA is not set
# CONFIG_HUGETLBFS is not set
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
CONFIG_AFFS_FS=y
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_HFS_FS=m
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_JFFS2_FS=m
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
# CONFIG_JFFS2_SUMMARY is not set
# CONFIG_JFFS2_FS_XATTR is not set
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
# CONFIG_JFFS2_ZLIB is not set
CONFIG_JFFS2_LZO=y
CONFIG_JFFS2_RTIME=y
# CONFIG_JFFS2_RUBIN is not set
# CONFIG_JFFS2_CMODE_NONE is not set
CONFIG_JFFS2_CMODE_PRIORITY=y
# CONFIG_JFFS2_CMODE_SIZE is not set
# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=y
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_CRAMFS_MTD=y
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
CONFIG_SQUASHFS_DECOMP_MULTI=y
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT=y
CONFIG_SQUASHFS_MOUNT_DECOMP_THREADS=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
# CONFIG_SQUASHFS_XZ is not set
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
# CONFIG_MINIX_FS is not set
CONFIG_OMFS_FS=m
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
CONFIG_QNX6FS_FS=m
CONFIG_QNX6FS_DEBUG=y
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
CONFIG_PSTORE_RAM=y
CONFIG_PSTORE_ZONE=m
CONFIG_PSTORE_BLK=m
CONFIG_PSTORE_BLK_BLKDEV=""
CONFIG_PSTORE_BLK_KMSG_SIZE=64
CONFIG_PSTORE_BLK_MAX_REASON=2
CONFIG_SYSV_FS=m
# CONFIG_UFS_FS is not set
CONFIG_EROFS_FS=y
CONFIG_EROFS_FS_DEBUG=y
# CONFIG_EROFS_FS_XATTR is not set
CONFIG_EROFS_FS_ZIP=y
CONFIG_EROFS_FS_ZIP_LZMA=y
CONFIG_EROFS_FS_ZIP_DEFLATE=y
# CONFIG_EROFS_FS_ONDEMAND is not set
CONFIG_EROFS_FS_PCPU_KTHREAD=y
CONFIG_EROFS_FS_PCPU_KTHREAD_HIPRI=y
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=y
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=m
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=m
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=m
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=m
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=m
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=m
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_ENCRYPTED_KEYS=y
CONFIG_USER_DECRYPTED_DATA=y
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_INFINIBAND=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
# CONFIG_SECURITY_SELINUX is not set
CONFIG_SECURITY_SMACK=y
# CONFIG_SECURITY_SMACK_BRINGUP is not set
CONFIG_SECURITY_SMACK_APPEND_SIGNALS=y
CONFIG_SECURITY_TOMOYO=y
CONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY=2048
CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=1024
CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER=y
CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING=y
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_DEBUG=y
CONFIG_SECURITY_APPARMOR_DEBUG_ASSERTS=y
# CONFIG_SECURITY_APPARMOR_DEBUG_MESSAGES is not set
CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_EXPORT_BINARY is not set
CONFIG_SECURITY_APPARMOR_PARANOID_LOAD=y
# CONFIG_SECURITY_APPARMOR_KUNIT_TEST is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
CONFIG_SECURITY_SAFESETID=y
CONFIG_SECURITY_LOCKDOWN_LSM=y
CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=y
# CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set
# CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
# CONFIG_SECURITY_LANDLOCK is not set
# CONFIG_INTEGRITY is not set
CONFIG_DEFAULT_SECURITY_SMACK=y
# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO_BARE=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_INIT_STACK_ALL_PATTERN is not set
CONFIG_INIT_STACK_ALL_ZERO=y
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
CONFIG_ZERO_CALL_USED_REGS=y
# end of Memory initialization

#
# Hardening of kernel data structures
#
# CONFIG_LIST_HARDENED is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Hardening of kernel data structures

CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# CONFIG_RANDSTRUCT_PERFORMANCE is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SIG2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
# end of Crypto core or helper

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_DH_RFC7919_GROUPS=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=m
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_SM2=m
# CONFIG_CRYPTO_CURVE25519 is not set
# end of Public-key cryptography

#
# Block ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_ARIA=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SM4=m
# CONFIG_CRYPTO_SM4_GENERIC is not set
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=m
# end of Block ciphers

#
# Length-preserving ciphers and modes
#
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_HCTR2=m
CONFIG_CRYPTO_KEYWRAP=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XCTR=m
CONFIG_CRYPTO_XTS=m
CONFIG_CRYPTO_NHPOLY1305=y
# end of Length-preserving ciphers and modes

#
# AEAD (authenticated encryption with associated data) ciphers
#
CONFIG_CRYPTO_AEGIS128=m
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_GENIV=m
CONFIG_CRYPTO_SEQIV=m
CONFIG_CRYPTO_ECHAINIV=m
CONFIG_CRYPTO_ESSIV=y
# end of AEAD (authenticated encryption with associated data) ciphers

#
# Hashes, digests, and MACs
#
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_POLYVAL=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_SM3_GENERIC=m
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_VMAC=y
# CONFIG_CRYPTO_WP512 is not set
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_XXHASH=y
# end of Hashes, digests, and MACs

#
# CRCs (cyclic redundancy checks)
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
# end of CRCs (cyclic redundancy checks)

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_LZO is not set
CONFIG_CRYPTO_842=m
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y
# end of Compression

#
# Random number generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKS=64
CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKSIZE=32
CONFIG_CRYPTO_JITTERENTROPY_OSR=1
# end of Random number generation

#
# Userspace interface
#
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
# CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is not set
# CONFIG_CRYPTO_STATS is not set
# end of Userspace interface

CONFIG_CRYPTO_HASH_INFO=y

#
# Accelerated Cryptographic Algorithms for CPU (x86)
#
CONFIG_CRYPTO_CURVE25519_X86=m
CONFIG_CRYPTO_AES_NI_INTEL=m
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64=m
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set
CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64=y
CONFIG_CRYPTO_CHACHA20_X86_64=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_NHPOLY1305_SSE2=m
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
CONFIG_CRYPTO_BLAKE2S_X86=y
CONFIG_CRYPTO_POLYVAL_CLMUL_NI=y
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=m
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m
CONFIG_CRYPTO_CRC32C_INTEL=m
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y
# end of Accelerated Cryptographic Algorithms for CPU (x86)

# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y
CONFIG_FIPS_SIGNATURE_SELFTEST=m

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=y
CONFIG_SECONDARY_TRUSTED_KEYRING_SIGNED_BY_BUILTIN=y
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_UTILS=y
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_GF128MUL=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA=m
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=m
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=m
CONFIG_CRYPTO_LIB_CURVE25519=m
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=m
CONFIG_CRYPTO_LIB_SHA1=y
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
# CONFIG_CRC64_ROCKSOFT is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMMON=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_MICROLZMA=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_REED_SOLOMON_ENC16=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=y
CONFIG_TEXTSEARCH_BM=y
CONFIG_TEXTSEARCH_FSM=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_CLOSURES=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_SWIOTLB_DYNAMIC is not set
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_LRU_CACHE=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=m
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_STACKDEPOT_MAX_FRAMES=64
CONFIG_SBITMAP=y
CONFIG_LWQ_TEST=y
# end of Library routines

CONFIG_ASN1_ENCODER=m
CONFIG_FIRMWARE_TABLE=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
CONFIG_STACKTRACE_BUILD_ID=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_AS_HAS_NON_CONST_ULEB128=y
# CONFIG_DEBUG_INFO_NONE is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_LANG_EXCLUDE=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_OBJTOOL=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS_STRICT=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS_STRICT=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
CONFIG_UBSAN_SIGNED_WRAP=y
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_ARCH_HAS_DEBUG_WX=y
CONFIG_DEBUG_WX=y
CONFIG_GENERIC_PTDUMP=y
CONFIG_PTDUMP_CORE=y
# CONFIG_PTDUMP_DEBUGFS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SHRINKER_DEBUG=y
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_KUNIT_TEST is not set
# CONFIG_KASAN_MODULE_TEST is not set
# CONFIG_KASAN_EXTRA_INFO is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
CONFIG_HAVE_ARCH_KMSAN=y
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_WQ_CPU_INTENSIVE_REPORT is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHEDSTATS is not set
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=y
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_NMI_CHECK_CPU is not set
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CLOSURES is not set
# CONFIG_DEBUG_MAPLE_TREE is not set
# end of Debug kernel data structures

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=y
CONFIG_RCU_SCALE_TEST=y
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_LATENCYTOP is not set
# CONFIG_DEBUG_CGROUP_REF is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_ENABLE_DEFAULT_TRACERS is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_BPF_KPROBE_OVERRIDE=y
# CONFIG_SYNTH_EVENTS is not set
# CONFIG_USER_EVENTS is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_RV is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_EARLY_PRINTK_USB=y
# CONFIG_X86_VERBOSE_BOOTUP is not set
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=m
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_TEST=m
CONFIG_KUNIT_EXAMPLE_TEST=m
# CONFIG_KUNIT_ALL_TESTS is not set
# CONFIG_KUNIT_DEFAULT_ENABLED is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
# CONFIG_KCOV_ENABLE_COMPARISONS is not set
# CONFIG_KCOV_INSTRUMENT_ALL is not set
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_TEST_DHRY=m
CONFIG_LKDTM=m
# CONFIG_CPUMASK_KUNIT_TEST is not set
# CONFIG_TEST_LIST_SORT is not set
CONFIG_TEST_MIN_HEAP=m
CONFIG_TEST_SORT=m
CONFIG_TEST_DIV64=m
CONFIG_TEST_IOV_ITER=m
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
CONFIG_REED_SOLOMON_TEST=m
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
CONFIG_STRING_KUNIT_TEST=m
# CONFIG_STRING_HELPERS_KUNIT_TEST is not set
CONFIG_TEST_KSTRTOX=y
# CONFIG_TEST_PRINTF is not set
CONFIG_TEST_SCANF=y
CONFIG_TEST_BITMAP=m
CONFIG_TEST_UUID=m
CONFIG_TEST_XARRAY=y
CONFIG_TEST_MAPLE_TREE=y
CONFIG_TEST_RHASHTABLE=y
CONFIG_TEST_IDA=y
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
# CONFIG_TEST_BPF is not set
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
CONFIG_TEST_SYSCTL=m
CONFIG_BITFIELD_KUNIT=m
CONFIG_CHECKSUM_KUNIT=m
CONFIG_HASH_KUNIT_TEST=m
CONFIG_RESOURCE_KUNIT_TEST=m
# CONFIG_SYSCTL_KUNIT_TEST is not set
CONFIG_LIST_KUNIT_TEST=m
CONFIG_HASHTABLE_KUNIT_TEST=m
CONFIG_LINEAR_RANGES_TEST=m
CONFIG_CMDLINE_KUNIT_TEST=m
CONFIG_BITS_TEST=m
CONFIG_SLUB_KUNIT_TEST=m
# CONFIG_RATIONAL_KUNIT_TEST is not set
CONFIG_MEMCPY_KUNIT_TEST=m
CONFIG_IS_SIGNED_TYPE_KUNIT_TEST=m
CONFIG_OVERFLOW_KUNIT_TEST=m
CONFIG_STACKINIT_KUNIT_TEST=m
# CONFIG_FORTIFY_KUNIT_TEST is not set
CONFIG_STRCAT_KUNIT_TEST=m
CONFIG_STRSCPY_KUNIT_TEST=m
# CONFIG_SIPHASH_KUNIT_TEST is not set
CONFIG_TEST_UDELAY=y
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_DYNAMIC_DEBUG=y
CONFIG_TEST_MEMCAT_P=y
CONFIG_TEST_MEMINIT=m
# CONFIG_TEST_FREE_PAGES is not set
CONFIG_TEST_FPU=m
CONFIG_TEST_CLOCKSOURCE_WATCHDOG=m
# CONFIG_TEST_OBJPOOL is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
CONFIG_HYPERV_TESTING=y
# end of Kernel Testing and Coverage

#
# Rust hacking
#
# end of Rust hacking
# end of Kernel hacking

--8bHpOPWk+C3IjkL3
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj629Y7/5dADKYSqt8kKSEWvAZo7Ydv/tz/AJuxJZ5vBF3
0b/4YMqRSKgGmYSWjrGKL6OMQfmWDmXhG6uqw6JHAz4DARG02K7g5WyrxH+XEJLJVT/43EOK6H3X
fn0NPBvn4V4vw5w6+2ifSUquekj1tLX2CVtM86jUyVV0qUSaIpqlWX0vOoJq61PLXh4a0mycSY/s
2W7qhAXv4kzJqWILSIyGp2gBC61b6jBYaAmcxBJ1J54pmOhOWngkH3gQ1XdlWNktgHnTF4nPO0Oq
pFEZKE2G4/8DggJZ7gVZOWU3Ibyj5blwkSdhD9PEjKlCMnKFx5Bc2WskRvzJ5/BMztxyvP+5SFf8
9+NRPRy41pC2HuhRQs7ZIfBeaxP+AdNKNXHSGqqZh6KNEXgxj7mLp0glpbxr4g1eOl04ftOeE8TE
8jst1CuwlBEBASBmVpBkDm98qF2ZGs7/j/vua9S6V4t7IQTjJRqYG5WheQ7ChBW/iPaUIzXBKv7A
ljZm46AKu3WFLAa+GfnuCq3IDBGAU1H1ScKNun4uMTH0z8Ak6J48Tu8im+vzbsSmdeuUGHyAskev
P+ES9bqiV6uxeoKKQlzEfqaV9HrYWiA0xORa+CGVbgtLi5QxDO9ZND+hMnqA1/w3gt2O1pKjmco0
L91XnO2XspE2aSFqPCMCcSFqe9y91NNVgoPstHHbqawOrcCkg3qbzXAPAnPy50Mjrak0tXPUVk+Q
vraj/UK8SLlzK3ifCztcw0k2/auAvPhAGtCFlqtO8LWG994SuFj2Yh1z1j+c8bd5sKsMZic2f0z6
Z6lnev2JCPNCN8PB4Yf9NaJHi15Hv3PdMJQj6BP9bIXdnH+beq4mfHEE4hH0fVtHlFgpLDWVI2sM
+Ob/0fvw0E2lBieCAwjmaqOVdFUwypyO4efAplLNLbKhgUVtQESa78Bb81FdIoacRXevvI2UAq7Y
/KqFSPrU6wS2IvdlcCS2uHz8PcTOdlFvqfHkORoH7z3HzHm0VG3S780+SKksHnWZci8iG9+Emd0F
xtEhwmob/dfUYUUwg+NvU3Csuv1/Q371Wjv6kXAU3H5Yu1I++m6CqRznyE40bhtxALrOhRtk/PaC
FLfPVbU1HUlE7VYJ0xhEzijzCHWUB4O+gZD1ouE1zDfNqYWlarFk8+rA2hCaH+3khdjnbu/DWfYm
pPGvx4ABc0UmLoArvkyrnM35BNxXhsddQ9lPdnHSJKyebC5JcbiUbN9/ZqBH/Ohck2b6LALCnkb2
EjBKtSdke2Y0EPBpglIMoSAIlKw5pwdV4yMWMiv4YgwJGxXlIVf5IS8Vp5EqTMMjiuojQkZSwIAB
EFDV5TQt1RECvLBX2PMD+WIaL64savpnhfXmVXZCSyUc6skFhC4YY/6FTTI7kJVwzALe4SS4QHaS
P2F/zWpUOOuwN/hJfBpqacifcgVrAzbjV7tNuo71LAzrs4YBj8fzHGXAvPuUWasPVz6YK7uQ6gNy
ybn1eTEozwIViKc1pjhtI8QNxYHe8oO8d50/S/NFvV9sKnT7beWjOUJTtXJeAQy4MUv572c/MsU0
Qd4sjVcPnzi9zBWjr0HQk6Pmbk4pRX7PqNuTCMJYRZWFrqIl0bW0NnzsqdkNj/5qFOzjO4D/IL4Z
HBFw30uyEYZIiQ9srfvLDIbZZju0MF8RqZhGWWgBwGDmHTAmrLGPxETiwchW6BkLIQ2XyOzxiyU6
qSSPe/ksc275LPRs+nkgQkNDGHXV144MFM3QybRapA0GBl1CO+SH5vqsIaugKI58bFkHpA4zv1zI
C00bRNEmVVXuMi0UxJjlEX48zHERJdfHRngKjEptQxr0fUxrKEsFshwRN50MZgmkcY4pj1RFJnFX
0DLYfjxM5BU7aRT5va+hrD2iqoSRNQRXTvgxJl1rbYKaFHRARoWL1ZSQ4Gdu3lHS1uWaBke8uhpK
goztCmi3ybQvIqLQtXbwvWvsOB/6+xyW4QXOIqW6G2tVm47RKUtBRZdQe2XdQVqg2q7TrijHtpvS
Hq7ejWQmbp9k3P00WSDSL4BOsCEEltg5eGMMLE0phwH/98buSgu7AgAQj4vUIMq0BvoqT5rfOW1j
0h7rfAJa6BATtCDMSFBgkgZUFEOiBFH+lxpV7L77NGtLY1imUwJlhDbZ3II0amq1YQt8/wwVrxnD
/8sMiHt7e9ULNUhfSyUIUcgtWO8FoH+2mUR5yo8DjmlwtXSrn2RfqySDyeXPPKGUEtEs1Vz4Lw2u
dMm67bhHi++pIdWKXPh5/wRRjvOyZNCMPrl6U/E32urQlqjzfBaZol6TO+ySpk44rS8iZU4NOwd3
vhg3WyaLGGahHT6SpGK18keFeyUSHCslW9WQy0MCbu40qSRwx2E23e1r9ty7F2ls8djxe2iR2Cbt
32exshco/xcju/2jQLJimIxBaYR/ABXC84TCuXLkFvVAMX/Tg/s6ea+/ToMoVJT7iZLAoh4iXj5k
u547J25RlmFszVySZFFeGKvpTRQ2AEiG9X5WphB++ZyM+kLmQaRBal9psXrrVCxeRDxZGbBFb6lj
6jf44+OkkMYirVpulcsvKRWKD3ljoja/xRBt8L71j7sVstsBZ8NkxmPnBdghmTL7iUHcpOVNOpn0
GvBB1ntzB6wCZbDr6+apRg7wk23n+NOdlbPgZZhu3oVsYgYZ8Eeh+3cFcuHUpxSbbk8jcayE5bKH
LY8HrTFyZX8Z1Wwa8yNq5byqYh8vDAUPUodmseX8UJjw1/0IPaeTukaNACLLecA2Y2PkgH6KBXrB
opmpwBa7L+jll0ZXk7C1rwF7cRuH3ylcOkYC872x9OkA8O8q0tvWCT5UPCk44TKJh/JAHRpakxzh
2DuxWd5flOjv8RZD1GRIa81IYQbnP0cRcOSQT3l4+8Lc/SwupB0B03oJ3nKMT3Kc5UQSqEWcyqJ/
9Lei8f+hVzMED8h/7yKGtymkxQIfQi5Auebbsp9XEwPZD+2FDHPUmsIsaeKwmVX27Q9nK0vdozCv
beoumzypnTGcKpahmpfl9rt/0LezmSzN9MEuDfPBCBbtLpiN0CjjUWEhwfWyB6I9HBDKzY1FGI+X
EyAs8292B4h11GP+G4MEDnqydD+S9KTd1FVCNZAt11y2gI69E/eTlHHRVLna75dKhGS5bY7/9pCn
Peu4c88bOJuJs/Pfq2C05lRjwaH6PuPVB4Mw1EYelNxXVgsmlABfPhbDEf/EToIhKN/vQLR4tRk5
uNCFiLhiqM3Shld8ElRQMXuhbmgxOAn7nwWsTxe1AGsdRgHRZBuUrkJI6u+zR8UYXfoL72xIA/Wx
1rGtx465oG0Uzj5OUeKPwSZ7t9nmzgSvkFiS6bEHJkW+NsHhtznY5PLiLoENDzNzXb0OiUQnNc7h
0kHn5LFBPr/7w2qs7r0kMOnUZuNPv9qW0q9G1H1qNvFvcJsJljJFR55ZCJy1H+Vbk0iH+SLYSCzS
NutbWzlJEWE6+milLxxU55Ns2saJ6fwr2raTIELanZvGDsg+l9KuD0NPY8ge2vcrQgx3+cScwB+n
verbGpXpzoiEizduAqPn3BtsiuWaoYF6o+e3pRlVXCjnn/hVoruqnsUxZFid92FLXz8+gteNwAFm
7HXkH5g4Nu2mXWCNf2UEEv+p9OTOQIapHm1itPWW6tryTKJ9U7/34aoBSoDwA5J5SeTjz/cBT0Fq
xbGMtAsXLIcVKanTqNO1FqxCtOlLV0BBNZcIlAMR2tpbFvn53MKp2B3anr/TcrlBxv+NyOoTBVkK
eq1TKrO8iuWQ6WBp6ML4timBo0ecxHAoklKmmZb2uqmb7p+5gfswHzcY6G2UPL0vbRVa3w2DIOmw
kiEXrZJ9oUqrfa0xBFEueVwv+rmmw8bziHOw77g0L4HAor7oUD12dQ6j/0raNcMFabV80suMx4NN
kB9ifiFPzBq3dt4H2afxpFLU6md1mJrTT4cZ13DJjoinuNTfAnWPdJSwrGwayRuKCDGbHilFla2u
L7P5TZwu4aX95AIkN176X2P83xelhqZKO3exPu0F2jAkcP7l6/OwodSa5iefoS0MQYAMeSQic9ME
Q6mFxKoUjVm9DKN9+vhIgTzJyg4OSluqKVUZ94CTAnGBaZZMMb2ew4EH+aEt2otns1zhfWjFqqK6
5nh+7UWN8tXiuHfESb8VNrlCTNhvld4FHWsnSCOZAPGIzRygPlI7oZRuEaTeWU2QFk2Ze2bnX2B/
f/tki40/Ohp1M54Lc2cSnqariSR7boV1c+9v8B8OBwsqkkdqhRUYPNLmRtXUsLupQ1eCTL4sw6Z7
Jfqwn14opHXvWsBZUv+suvk7rW69NpHZOHve7CSe3SfADAEzynda8pVVCa/fcrMM4GhMGMsMmlnw
TzHXcFX67QDlO0y9FL9SZ1vFdFkwWhFJTVW/ds2+SI7rfBVLZ4WGYJf3GQf3TLlA4Vj8K8G8/mxQ
MJ7eWAUmQ3+WWlu5E9R8w7VZWZ2d7C9HWVtgxDKs+kiBArDD+9cYSutN+Ti1ewyrO+w4E4rxdEX7
dcsLWAWkgYc2VszxF1SF0gPT2ZTsjhFFz+ug/J4mIChmVP3TsUwO2m47YbAWsS4SScuxaLusGpnt
CFo/bZmUxlI9ruGFTAGm2lcWTbOBrfiqF4/qlHJoK/Ma7hN6QwuV/+WqvS1p6hBzEu8qSFILvfys
g9w5HpIE68phlldkaqD/eibm3vpm4/wBysRx19vvKgSvhFgbY/wXKG0VCt9YD9jO70RsRRZ9Fh7S
A0rrzzkTHEZnLSK4B9FYWe8r2QdH1XIYhFm+6XQp4FTZdrFL9mqNyzJm6F3eAIIHEP3pzVF38vo4
MO0TMnwDfHfvNQe0zHKlb+5x6mxu0WSGyH+Y8CKW/cJhOyfEM0cEXkoUna9tqlDR7eddieuMSVCJ
FcWbuyZqbQY0WsrlX/Ix5HPZC2mv7Jcm2exDhJDPfNTo2R3nctuGU5N/nkgxyc6mGwNcNUVf+JJt
MWKBsUB1MVXlUEDY4WfGGe8ZSM9subx5FqyT2Hex54W90/16/b1QKKMWONSmPPlBP4p3O72d78Qg
qZBbMW0lPONbB8gvhDFZWm6lgCy6CI3AAQwM8mTkMWBA1el1k/OW8013//Z++IfzFVZc/5j1uVvn
wBs76bxb9l9cObFNL82xmxgb7nN/Z/WsNuuSE3488mv4CjYCASmS5vyCpXVnPCQrKtAjNUd+bVeR
n68n/xqD68hLlU/NNxcMHjmSrheRulIF81sLXUNtzBMp2Ne+0c582XdfYUWfHawppLHgpZK6OH+n
HogcRo4Z4AIuyFkKcaPBbprZUNYJXHHSbl/nI+it6u+5fLMiZ/N8/O3TeVgvGYDl+D9g4lkeNSzB
C+gKm6PHr3DIFXl3Dq3DR4WUaLn0wTyE1OET1h2M/FnN1mw6f5QDk/WucX/MZiYAc/eujLywmsFP
8iL4Ug1tBJDf2jV0fogikFoakJ7B4lMAvry1aRsrH09+Jh9VS5h1bqyE65511KhRvYFJPZt+n+Ax
2+C8MUr00AVoGKIfkfJUB66pykciQ17smLYLiMcqGpFLc2gG7V6m8q3I8h0X4hWL9vru6dpyFTHd
h5bk1lb5ycwyjHpbqDVsFAL0Wp9J8HXdkUTHuQSesgG677Z++WSC00fBtVNDtHF1autNR8lmzrv8
Eb/k/t7nOxMSK7JMmSQSIu/4IrSEsB+Y+idid7/gIRUeG59MaNBnbLR5lK6R8vUXEQ27Lnd+5t3E
KVQLsdBbe2KoyleQUOTxKkmURf16O3VtgYszjMzp08OIyBmcqqjE8Xo7UFOWFFkC1DUfqS3Fq3aK
u9zCTDMFMx09QQNspdsMvhGX/GLOz6PpRM7UJqXsr7MkTqxjCziipo6OFLrZsUYbKuo5rKnPFGFz
Z4sLkhBq5IRwM3cQauHO5a3z6VV/v+ctBV7inc/06RXnHSjxJOeQPDtzucusuKSt230RU+ddFukQ
TiBLnsJIf5D5mqwR3LPHbvk4XwMikjmGn8pkoPuvbN7onjSrbAxWpDud9/tznwYwCpNVopJIpypq
0k9doLks45lHKKpFzifIO4tPGK0Y/ItBq3+EJjtKmnuYYmRxOq6z8WgQShHHzC3CWG1kPRh35f3l
6kspZ1asZ+NQzOatxodrXJZ3pYiVED1Dg/Uc+EThMdAXrzB5KDz6UF8XvqvKeoCRSU0fpy5s5Ycv
9cCVMbBCzpBoerm9SlKYb+T6bsOYu4wjz7kAFNTu04yZmVPJnl9Xt75GzZnjzQ9U4hPGJYk95ZbD
qD6mnhohNX1kEWwrnnCI9CQbq4gs9e20RlLbeiBvx4hGIK45OAeRCyVdSekxfVNHvZFf/WFi3wPf
eraAQCw5TxpUl6RVSRZ2MO3Zx1jCLfTNNAmK0FUGFPHsXMEK66mp9FmWzws9l2c27nSWMtITHNDs
pIsWGjcVj8g49tiE5aQSSy2h0zgN6DZOeLvRkCPXPQsDMUWSaKB8C4soFd2N4SuV2xohkaR5123e
3a5/7vjdJF9GQHTEfnhLRAxXEtrOYfCp33RCaQ8FRYUw3ylZHJNimYMs4kN77l3qtfYoLPftoaDU
EjluCxTMiELNCoTQOu7E4XfCOXzuxGHV51Zd5bYs1jHfhI6vCVQO/kbwljYAY6g5FTa60O/i1QzS
h/2yZ92bSNhzpa3O+bjzwpgpAMULLWmMQZyKC8vq9mK0nsj0Bg4bKdbEcZ0uMGQZDbrCcS4JKBll
XhMjHzbFJbF2Prxvwj/ZT+/phmWfanlwA644bcF8+fvR7qO6Rvf3pA+9xtcl34kWMeXSUJfBBdBU
8hoDTB0o1MtJ+gLo9eno7ykOS2haOqwLE5cYokNSkURj1Sw7Jccf6bt6uLvpG+IbJOOrgMePIDH1
UJlg23WgWWmy8i21QVp6Xeg4adOBVG5tTsppS6hyFb6FVjr0Y8WGQ0RN+Jgs0qgoWTz2zWkRiA+M
9YO1jlsf+kwCCP0ueLaLgbN9RwcwdyqR8bfidqZWs5UdaZM6iuOCKFrnxVtYSTdq63wiLAh0HMlh
GplqbNEdxndtB5yIXV4I/MlU36shrhexScLOYy+1XyyvTpGTRRt5nAJWHDaNYzqDvrn3EmIJj/CO
ipb2YvQWtCPxbNAwCUIs1CrFKRb5UEEDYydfh7Pu2nV8vS7VAHmhIV1Hr/lAaNuDeu+dXecy0r0K
oMmsm5xQaRn5147lckVmojmUKLCMTeBpEFpBWNgMali2Ef9sdW7OobpNdewj81+yZSVqlYJrYhyk
B8hundBnWoVP1roz2GWBo8oZ5CMGDQzuin8oB+GGWTw/qdTU5JoFAMdlum7xNvnngGUmRV9wbFyw
isqFYe0MuHMVW8J3qCsSXFFvsS/pPWace4X+A0+GtkPdoJ4nznk9C82eqp2y0+4E50PEeVThySrj
w5n98/f8zkOSYnkMSaTFZXklAFC09NmkpfYNeVY1sbtNGNM4SGk/XodZ9MB0F50lTH7cPm3Y1f4L
aGv/G1IX0yG/Hmvwn+EOdNBbP1qJluGuT6Sqp104N4JxyVaTke4stlYi5xOTBUFRvmeoT0bvqGzf
C/Mj0BNaIChYEZbVmZ1dT+U0+QEqa3u0csyGj7YzLYYOvtgi8O0NRHbT2CbNAnQkNXFG0u9y+bwi
8srEXFx/z9IbP+qKt58Kn7UoI2Go5F/25//G28IWNW55JroaWAegKz7QRymU7sacpbkBv4dI5PjQ
hARC32t+mtEmz7fVuzcUlchjW3kKhxXHvrs75yATW5ocHiTM5f1/yDgo4+KoaIvEreO9E4LFsw7M
G2YTaYaTljmRmcRV9VBHBOpsTFR/GZJ1CVA0LMTQWDDOy6PeCh3eNNhp3q9uADgbgDKLhUb0cQqh
eR3cJAVqdP0zq1hm1yyiYDhfDTiYaJI2XS9HXzc8+bjhf63BMNAbELiE66vUq14kmFnBbp9JR0Yi
bOu9kWSop8MjYy0uTx2bwEzljpZcFXYJv3O19kbI7g3sknX4p4wadXtJ/2uH5oAa8ULPz6fLWUss
h9t74OzvEe8msVTtKHGjKW4XavuJFUSoCazT4MWk98m+h2Rlhu3t4xJjfr2dXdpuWhUnjZOXrdca
20BBN4s9WYkHAIfsoR1YAgsxwU8GgTRb6Zm4Ep+JKydWLVTjLbzdZu/gl0Wq5FSNSPeOON2PkbLC
g5Hu0sjsTn0SbUDLOUQwVwZoarqaviXQ4LcEGzTVMM0mndLYhCX2IJRvTAZjwtbHNvvwHwiVWsuN
Ibi4Fys4pOZdyrcu8D7ziG1nHNO9lGeDRGalDnGhiSZXECwEQN6uMgtq/iJsVf1ohbAHjWNwcLYm
Mf1fN1hSxcIppPqwYvecxL3B209kjbdyw5KOf0RtIO/sQTm8HBbx88drw2v8T13lZRlK9KGwY7Jn
T9rsNUeurnQjqG9qMhYeRgh5dT34Aijukm0yi2gY7GdQofOmJy8GxUsNEzBhVAGf68YbTchauDae
UWyq58CCf32U7pTcutkIbNtp7yDiBUHb1WP2L42h7Z3vf1fufzRRCdXEZ26F980lOKSTm/yT7X/L
9DO5Eso6cxZ1sxA44nVwRjgWjcnHdiZxwFPuJ141ZAhbqoijv77J0cyF3K6PUhGNgb+yjCLG5Bi7
1lXPNw4349xpV9SAjYSU3gN8f9SUsWXld+CM9IN82rgHu2/YyVbXqsIMaXAmaVMb/zNKPO/iaWup
BgVs/IFjz+uuLyRq0kd132QoVzBOWmYRYsGOoEv5gjee8DGPEAp8o9onVQ3tzeKg6YTEJ1gmWGB/
osq5iB6dnglxdl3RLNagWzjARA5fpoi0siJ3GvmbaI3dPNJ+RKue0OVkxCUVefAwfF7UiBf00PMA
DEYdfswsLdXSBacypqOl3DzkxfU3sU/pUDgiJ5cql9Db6S2d+hbWgCRL/CqeMMmtsbLxq7v7mx9v
xe+BXGUtHwQZJdQD9XHOj4GO3l/o0odKFtR7HMiwNazL34q4jsWr+6FmvOX2O8wwEy5Sfo48vHbU
3VHYM+H8l08dlpc49zsLpWqHHi5s2O4V+Xb6K2XYjUvTVTwJ/oCBg0+tPjT6mbUUV6gH0dD/Dpmq
WIGmHZiRZYHUVNbLKrhH0xiHXob9XC56Coc2p1fCIr6bP5JVe4FA++ywWr6pi9f4qBKfOK875YL6
kjeYtQop4hFuaG2m6Rjzm3wg7iNtgco0ohfZC2uC058tnYbla0mdFcctPenS5kWBZSiwmdR0Iai1
64GcYLuU//IZa/jYpB64gaG1qdOLwcqPduds/Oko5yCG55BMbZiLd4/Gtos/7m7zxg9CbW8plKzA
lNIpAYgEo7BrTwQVbRkLNKpUlwIhW2aG6QT6MycCXlC13i+Nm4PnemQi+4x55yuuA8+oM9r4plgp
NmVX6H3EctRkFLe76tV1ct0UUs6Xn9LYCFfzUYfddxTu/DWsH0HFzKLzKh+9qr63MdLceEs5XSia
Lr8RIjp6dPmLIskMEf+BUucu9EKj8Ab8UmqfqDHs7BIJBuxdHhG3oL6Zo9XcS5HfxzbPu0xM3hYk
11yBBfBSM8vxq6xXq5A1wIDGBJSAr5QSSGJLjknnlMyj6h1wgjeGcEP+4N6Vl4T4/0s5rZFB8rtw
XABM/CUTKdU676YrSkwz4LB7d1DUR/Zdc5LE+UxZ5qa/5+8sOP2vkbLiQn9q+6NFkO816+mOlv8O
pNMSyN8jC1Kw2Yi3E5yhPpy98yQ8myIYPWup1SvQaNk+PMp9YqoCP5FibDF5pPKWsGhr8hOCpj83
kDBtkrXh/2ap5+4tcG+Jy9V1w2H66ikFcg/txzkB6G9M8x93G+n1YbiLHW3kC2LHX/ggpd9r9mZe
E3HV+zy6giBJuYs5LxWN4EMrual4Vxc91b7dv50Qd80fnBHkGZl+KXcuu09APO/Ul81BLue4cMgL
HreRkpKCBqpYxhVDuMiZm1PqC0WpohO348RsNrtj7OQZg2vZUyiuw9VnPhMjKvlV1pxwkZyKbDSE
0xK5i2+7u8Kxp+QmJFopxyCebe3xcTJDqA3UVDokGIy86gjfJRh6+kGU9Rob8c4zllc8Vm9o1IJe
nTm8TpmV8Ug1ppu6lw4B3rJgsB9oPvIGPScgeJfR1pl7pBXaGyxc3HjX672CnhaZdnI1Rdp5fdJI
9nMvLdTLxJ6rHKicFZgByeeufs/zg2iullgpRZ/DYhCh7tdHwMi+P2WfYQO1vP780ta73Q7XFSzE
ZgBiRjPeac8mdO2imZZGmjFJudMKjqhQ6aEMaN2wxa0hYRsxpNH/Clrz623EnzwiH9N3PA7mhdWb
SfiWN1HKxzhpBs09H90O/JNcAjf6YTCzbNraL+vmG0v+VxvF8iVAdgY564b7nPAecyEnKH3VBjBG
npAN7ufAIUsHZJlaseUL/zWkSQO3ROxS/k88A5wo0iJ/tXivm24HsQJhqMDswWzPZ2tlOcINriXB
rafU4yqQxYiRFPpyW68W5fTXyuhsiL83gJI/Ys8nksehviN0tpRHuWU4pUXB15R0XE+75tNti5+l
n25oiG5fdtOewq6M/TIp65Ia7eBRUqzPqNmv+yMR23OKgW8Q9SmYz8mfBvn1G81hEh2NdScSGTkV
JHM5ppVtURN+WsTKMIeqrf/ezRktFe0xA7J7rZM8mO+ODOCqT3O5WnfOs7lKUwrAN7fpgnOXVuWZ
NuFqphSXXvPFbKoRCRS51HpFPSnlopjy78T4/jqPRTIOYOsbhHY24vmguuh6g6bo6w10aUDFLaAZ
noZffgJytOkv+WQLiSLeNOER10QWkONYET+XqFXBuzjEZCj5VlS1+QzfCF9uT9mOI1dFE4YwbJj2
p72H8WnxpU6Qd/NuVq3kmQEg4OIXeCdMFU9u7OsTjEbcZREFZXtN6+MRkcGsxs1u2gqW+v+dUGEH
ZOXiT3QUmQkjaeOqyvG6bb9RPRYyTGP4QJKTghwmpemrKsOa/YQhev4cFpOAAKawT9Bc0PvO2J0U
mi7fzkwKam6PfCOUrgSvqEfW+yIaBcbDwgrK5llt3JcuptOIeLq/S03vNVgSp9Zo+vzrKUTnOsPm
e7ZvGbwWqfkt41Awr6DzU0Qz+u/wdz3cVbvNylqEFbPIpq/IPNQvANQuDrtQOOgZxXZI5Sy1CJyx
PHB1QZ0L3mx3SNt9tX4rwjqGxaqUpgP+/vksOyn4fOMMBm5Dij5DNTjVkvaACitjxXKm33sUvPYA
jRxpxiSnWA6v0LLFBg3Na6UgP5gfjSjnp6uRFJRaXwHcJpzplu0mjfSiGpJbZ4iJE/bs01YegQQ4
0YX+KI6qL0Na99drz2RCzg90BbNtKNo0XEkAMY2ijQMVjV85hfl963Ew+jhAQoCf0V5ZQNwfYuj/
cUKh+3BMk2UM0KMlKdkGKRO2SaqC+FTBfX8izw0Z+Y042GyMajSEPR+JXNImHpJyoDJ11G/TGhJp
oOLtGv5thGH8ZFan6DQVeqT/3rQ1acsYT65pMx3qajeak30HPcbCax6duEFteUYioH7iHb1XkQzE
XhWtOqTGV63F83xf0TjmCffVUIIFa/aso6usECjF/LNmwT0wr+C5yI/6sTOoiCq17ju1UhSMnQuP
1Uu+c2oVNB2B1s+tinGfs7OwSsPshdh2hODmah95ntRCCAsn+NtoZBXIA4V63Y6l2AfCcIMgQKGt
LfHol3s6OVQLBuNmE7YB82rAPgPKgj1gTb6pY26tfHLG/Afvq0dPk83dTdfBMjNrrdt9a+UktQFw
9O6Kgj/K+72zMudE49in48sTSHaYbEcuuSvoenfr8HgT/i1xoYJZ+MxYIVxz1SeO1M1mryQOz8uJ
AC3iBGmXoG/vr9KVEyPWAadV63iCZ5MDGmkFCaCYo3VgWo1vk9heqk/qif8BmvnWcf2Ol7WUZDPG
tKrVFGbBmqCnipNjPnn8a6fnWh9OL8zMQP6sv71OHeuOrS0R2vuVT9JVjL5OyNEv+h3CkI7cBcz3
N4vuC82NLziWixlZihpDFGBejwaYjlk3WyPQ3Im5WAItKBhMnGknatwkTRfa5QGyXQZuqmSPGSHr
SMG92bC6zOshpGt0AHDZCPGkU5MCAcHumzmWYJaZrvVVb//hGlBiV9PnGQKAp7WxXPJ4aa8XMoyT
0RPWuSyWu1nj4HIj0y8OE7Z1mN2ziHYFZAfQt+3faBOZFuUu+ebzhxDsUCJrALOTTK6zQK/ohWAS
K9W1LyGrVCA2/0hIelGNf3xmiiRA+5sE1AEfARks2pALEcsxwLsjx8RL/4koGcCKhJigbFR7v/TT
Ve6y/oap+/twGORuDbOtGkC6TZSyh1kkqOQx+NX2WOuLhUe+91yoTyLNXIfSeXgngUT2MiOs4qrx
+s9me33zShpNzeYG5KriNPiqvHjJ6M4kY+3Gyp6KzUuvOb8wAwDlxNTKuyLteb7pHJXmuQjMKdvJ
zsxf0NAuKRQe41OfcOZtcC4DcYbJOy72pTvISsVZNTlz0v+6kzOeAAmdtJ/WDGeMLQfJ8e+YJ2Dw
pea0ji/4u+7j4+T1UDkAOSSacKwvWidFBdLgVbWsWcT+Gmf1idB1LN5DMiRUeryJlQd7pUKURjIW
wwim8DrLcqjaGy+yRRQEhPf3wMCb5js64553KnE1JpWMKxoR476n0UTcTNdu9nML/3Hz+wf0dReA
OvLhm057w9QBv8+FsEJjWvbKAs0iNmv7OTfO0TbZfAkFrGPuk7qgd0hIrOzuiyGFcBrw1RIZ5Muh
0DNLJKy9J0WUBRLJx/iV/UCpjlOwqGylDK2vwEYIXM8qqbIhJnnDyLzwqIn5fbrGWqXYLZOfNu2f
olACbVkl11o+6e0vembwTHFEJ2DKR4ZkoJRVpJR69KRS0Cn5SDakHcMi/tvWuHzey5L7C5w8+3WM
VGIosX0eHvlo6yMTuL8Pi8Np8I/qLvfGDgZuIm4Yn0f8aK4XRv0oQOj1peA232b65p5I80Fncqu4
kEaVm4VIE0CaJ/4NPz7AmOupSyqtxsAqnP3f+Xas4rIzYZjNtgrEoe6krG0AbIOArDzaBEW2os9u
G3xNWsluqmG/pyaPs/IBwW9DUMT/ufRazoETj/LIQ5w0Trg7UMStdlgI+6cnf/hyS1OnxU0YI8D1
5EJe4sW4+A04nM9UosfIDcOhDV5DUqv9ScuUwMHbgDiIuhFYq8AsxWy86wY6hVF9hzD4RaIHSf3M
ERsmAQWe0jrjXob6GjwDSINzQEjR0JXXI4kicxryT9UzwtTPGrWjjeHSSqeQSnGudV1EQ7pIdj9/
2rFwFb0UWFeYKn2TLWpFU05Gtu5eNbisGaeXk2YJn0W8Pv+FCMCgjTTNpsGp7ZeR4LJ97oCWPQ6X
96qAsH0XKxCsyw4yjkC26qW07uNuT8+I31fjDJFwn+zmwzlJEAU0PAbgqlRLuCEjqnhbZTSvUXiO
ZB1ExR30jejrkB+XeRWexvQShlwJwdjFwEtOdw3Ym3vVH6c1NZlSBepDFwBuCt/JAms9WvlCT/NB
Yz5tQfZSIMah7aed+Sj6srQiasW0f7xvu9/T9/O5laD8n3rnjM7GWrPbUR2ZZYZBmO0BqSuAO6gm
wXcc+DqfCQ0/uTmE0LW2OizuydWNA+4eZKAR6rr2o1mX1RLXrjx1NlxGAG9jdOok0hPp+zdF+p0u
2uQWK1UxuJLHRWg1560fPZXARYLvD1LjAuRz5bDHmOqGM2CIdCEClo2mKRQmY6xFNuPrp1O0qBY6
gNC/0MhcGEWIb6O29DT79PV0NV4+b/+hvUvHy0ZDmwCCJ2XZh2LCuJQsHK4+KQmeSrQX2A3j1FoA
3iv5XkoHOF9saCeCRR+Y9MYYtggU2iKBg++unnHM5Iq6lyWvtPIrUjDpGS4Sfpg6qpbRpEND+c6p
nfc/R1qp1rvSNQj/Dne8XPe5DDEjKGSUL17wi9fGGt9q47lGqM7lbzKXp2XUib2pTXJeEgvGC5JD
g092k7t1W3KRSHgnuqn9HbtkXShcsLZ1TweNQ4BA/cGOBGZp0q6L3kxM7Z2cpCledCrmpE3gAuEy
I+m8NiQNaa0s3zlWXK2h2nCJa83o+Wj6oe/N7ZUfXMecvFF2YCb0V2e36eBgiTQThdlEx+Es+0hw
ojdHsyujbpIzEwdBiQs+dJQajPX9MyNqyQdfyv17eXrJr9I2OPcuTjo7Y0W3S4+/1+qzzZrexFNC
MVVPUdUU5L05K8Trg+g0NxOoYWupkfSTllCSRlboHLWt0i2E8xtfb4WaCDkONNfAS0Ga0KodPWa9
xzRZvv5i/oQ6hV9V8kzV2SVw7D7lKgu5R9HBxWnagIWsf0WDpYQf1iidvClI/0qLxwrp7aluMR22
Q9mzxSopYZ1FlnIrYIretsUgPReJBf+7h+tS1EfT5GbxsXJYADfz2HIRUfTjLhSLxcMCB38l9swV
rBvresqcQ0IF236vEeXa4SiTa9aO7s3KgOMS53ewbsBPV+zrEfJtGDBy33y27X8na5dvpNbvnn/m
y1mYjTOcIxt3Fk5q48RglqUAY2O2ttYc4dWP1BfCQXtJ4Jt3nV6htNEnP3NxeUOZYdY0sv7PWkGj
w8NH5CSf7dEZbQzsr4QrTKqK+I2RJVOGMeEoCxeOb8+IQN+IjwWCojStSziZF/u60grqRB9bCwUi
Y8nKbAWAfTmiTvthH8QfgvoJ9wNmWMFAqd4A5QYOhBfe00f4Uwpwtez5kW+mWtUTxx0M4a/p/VFt
KTSbt3X6XZnkUizUCfNZof4O+idDq9gy232uTU2QQg7uGIiKbr6DiJTpE6sz3HaJ5yCH+RRydtll
Tq6mqJQy3QljMzabwzT8nK5hdKKU2ukYMfdOcAgZ8Q1gUXtn8nTSOtNvbGlOHhc3UxZ7YACvyW6u
jYQKS2Y4nc6AT+zhQR3hFXgOlksw2QlnPxrZcXP/IoU7whslmH2TCXS4gurkeu9EkW20tq31pW+M
+YgIf16rP9caikS/J/7E6i43NYaijP7d5hOiUYoAAjw67RRirmUDIQkwBnT1g3cg9yUVIFtJtU+D
glUX5sZcpTOYR5Do0VL1RHxQFFLUZHMEnAvqiYGOo+nDbXRzvoLWgHgCR8S5pC4O9QDmrYK9iWZM
PHwUp/N44un0mgOwsPfVp+57Hj6HH9mmX7l5Vk5ucw00npHnbXbikUJFNtr1VKxLRvQowzIcoa0s
sLQTTYThl4XIS42r8BLXg2xA+q0MViVOcsRC256t0+9ihzhoqQC2fs2n6jwcjjo9nSTwcTkl2W5G
Lno144aNhNkhGZFg4o7JrohWIoJlWJn/qktbb7F9Jusj2LOswASjs+EULLtxVdZtsIryBTlQm2wX
hFxKfm8VS6icIsYwFvcmO/T1TWwL+7oj+Cc+9IJABANXMWNQA1Mk0EtrgsUVCsNhQRzf7c9afhVm
IqqoMK9KIE6Y1rOW5sH97XnxU9D4LbUgdScQ46M3ZCMveXjRWeNFJiovgtXpZmKg9M5qwBHn1PGv
Pt7R99amHDn0rgO+gzpfcGrvbejVDs1IuFs8hrPriJ5lfwKNwv6ItHVOoFSSiDXHjwH/GMGoTrRL
pqJsWLeNgzxKQjRGTh4wk3d2h4zTTKI8W2/nBOMz25jr+d5UXdMbVnkmtEnhG6XhozbhAyOUOD+V
2TyBDOvcFb022JYj3DYDjgfDqeLBn+T8unL4tW2pEGva+0x3Gd3wJdC/uP+gfYQf58Bh/Om71UwE
h4Q1OEuTFbDqto0lP0ngiPI+a8RYqaZBvGG824n3rNTgJMMglSToDB+3xGPj++ru1A6Oba5peghA
HsujjLewGvHiuv+yT/rQyVHYf0DGWB01hN43gIS0rWUDng19DNBLt7X+pTMfntgLK4Q5zG36BeEV
JyGMpK02zzFUCVH/QaISIoHNqhsrzrbApD4oo8seLnCeJpR9kR5je2VsgjQJnhmiLMtsrgiawfzw
RKT45lTlvrBPUAbblar8i++RfEH9jxWZGeTJd1py6Sm1vYFum4oylVn/6rOsJYpEEAPj9cW3ZKol
mzCa1KOO4+o3l+uvW345rxRDC9JHWTzYpxPgV2cjlo448w2nHoQsr4vFjd9DfMdbar41PljdYAW9
B0Pp+4NrCWoatrgUgeziRZpAS71WJywpMTDaF/H2goQVFgrBSLJvkDU7uZRI4OYjORpopmgVUZ/Y
oABG1ae9PpnAa3k/oElZcb493SFt616ZISoTvykT499kxbHaK1o7wkIMU+W5MYsj03/1FDrjZ4Rw
rGHA1TGWuuSOUGDLFS/mB8lKxqM/xIrWlMk2Janu7LnnT6uatopaLYPRIF/LAQwF0zbjjxqSPvbC
Q97BaSw6aB4Ve2qoc032AVU23SNZoYW5ajkFxSWCE0mbnRh5AEatIR0t+7WgKbQRbfKqai8OG2PV
QMl3m8qLTeE7tN/Xlq1KcI+cj4QLWW61onwNWXomJA0aP6JlO/GQfJ9QdTbzswnJINOX2i/DwX9l
EIjvxCxN7pLJl7I3WDrxpNjFoT76U8W7DWUxKVTcic6n9cvGevrAAp/Jy9pAvgjvgf6V2lJRTDME
/RqOXUcMb6r0LA6S4F9/qKEsvyk40TwqhJUGP9s1GVSVBscCNHdXIt2BTR/wLnaQ6JD+5Tk+LzdQ
DKSSE9xLkOcQ4NWot7+4oNCytv2DkovX5YJS5uCUa5kBEDCGITXMApFP7RgSBTPkIP0ToD5cfSk3
jvl9ze8Vc9oDbHO4a1YmCbAnJB6YleB0NkXoCUUtPmRM4U+zzDA84dUgtB8FGq8gtGbi+8yn8Hbk
o4dgm9vSGSuil9C+pwIhAiknbs+s025U0+r+Ter244pC/s5/QpSU+IgakHraaSef6sY5z9LEgG4o
ibAtt9bLrz3QX5oo/JXfe2/NvyNDjNmxuENd2Mo6Joz86lRNJIAhszMcSeysDIaS+w9D22eSC6RJ
RXv5jbWw8Yt8ltxndYiiEFze3DR99KOBaAivKl5LbRcR8MUi/M4Up+nk9hZHlppmmT3LpjTk4DNV
JxpiFmuhFpIjlruESVzMdFaW630by1U0kUukbjwZGu6VBGTk6QwFNyA/9ECqa5RfrD1XbZ871XD7
ZejwDeqCAr4d5esAlVDT++fwZAobply35Op9RdFza0gq/mbtLjeTRMzbAK8XgtoScRyUYfEmLUU+
naV63TSOvAGbRKnvaoVAAGIOYU5umyr9VFZqr3vcuA+0pPTk6DORrZBj/K0wlg8zkPkLv1fDFKkN
1KzOcVayKpWyMTLmycmaGWGrJAd7fmmoliiJaBGE4lmNvbXUKNHtWFqWlMRHxpGWZlScd6yyBb4e
7e1ObOLV+oCHiXSQMpSV6WACSl7V1KCzelcJgWb52WXT8ANgPmnceOE91NSi4gy1RO1tKWFg2d/7
+XALjaqOnyivOIMGsxo/5qBi6X6HXwWJR8tJBqBchRNx3/qrURQ5e2jhUzC4WRyE0+l71dUyIySv
vo8qj4FJ8LjZqM9lXGbLjGCDTod6/Ti0K6oStNH2PurE9qErx9NWBQkERMAkUw2JKOqJGT4J6+MW
KdCccH72enO3ZDrrIfHDEFExQJ7OEIFf2FbdzX6baLFP9/6qjObDyyguujATs5w6lC7+qfOkdCon
fVZwlk7oY4mYYZMuxHlFZJG0IRliUYpMKJFtWN9RSd/hnwlZ2kLO6M0uR/2P+up9rpM+yjl7Ngst
aRQdhu/o5FsqBv3quLDgYw43QbCZ2x9AYfAT3BpqLVExUQxITmpf1Mfcai/9At4Bafaa/8NI7jdL
suA3ti2GybuUhRMRyjxtG5aqYIFH4XtYDq0ddBeSOphpbrnYLqdKaGoPyvAPl/ONackm2zwuN8aC
uU0uk2zdOvaAEx+klw6MprsUEVRe6wutnzo8pO6otpCLrW7Ry+vkm94Su3jnXiY9p8fOkn1LH/8N
7rRC9mFDMFlSxbcU6ifl1VoMr4JFq9n6czQSHT7pJtLJXJO2LT6lnotgVrNNCwsVS0w7cck1lI8c
9ewHyJIiFJpPguAkc++knnZhjAOaHYLBGrr3BOyzi7cLce79CrsO9KIH3oF87hvS8HJNKXxyq/yD
eWu9Gnj4pYKlR+p78zwyZR5jrh48w/5XoOH7BaWpmaJPlqzWMlzuOGW3zdWVuRkqgfUrMmld30KR
2IHl1sQKW1OJugvTlFCs0WxlFrU34Jwb0Qtj0OIdfDBDzWJEt429MdX6x6xmxk6stowiMrTpVIoK
dZGR4ZXH/Z7C0Vxa+95c4/yk98YAY1N9JCzO04j8v1izvQrAAav4S8WatPmUxvqD+dn/i8NA3qNj
SmT594wPUvfelveYgATzpZ0M+NtDK54EJ2cEAQQQKZ7fdNK2FxG0NjwPxfziLMBFTyYC3c9oTbU2
rKcQey0mnGzPCq+MroeVNo1ruT3wCdaON38kNReRl2h6TouNlsBB81iUCf4VNzgFLRQQj5/L5/de
cBPseiF+Q4sLtdkKLGOom3aMxYfAoXsFoA455QtUwJTz8ulflrAqW5WFIX6ATwUjX101MwaLSDAp
WWxoKR/FzgEOHg3PC5kC45lfAFUApBhPhD7myUQi67KREtfzDUK4UC6LIm+lcEs2zsPYrDbQRp3/
Dll1Us3VwC5Pubx+I1Kj4cGc82ISb+aggoEJxeBnZDa8IJ6JlB2Rfye9Dy+ks276JGsCBUjDv0i1
+a9BntzV529QFfMVupmRQySp13R3+TH8W0AlNoJvupfgsGLcn22eXjWLECC7uxiwVepqTGmj0suy
zNQ5iaRafeWBXxaI0r/D6gA0e7/GdxSkVPy6kSiZXZbeve9VFkrfaZdX4RnMG20bdroXdNviWXTx
a3S8f2/Dzct1PVCHJ1CScSfY9JYjJFNK3BjPgkZViWZlLCjzEkw3cn8kRYsUlyjnSYc++KMv3DBZ
bN91/FBSd2Yd5p5jj9r+fuqhR3PEv9p0e9AJK5ottCCZTWWG7SP1wfBgnBWKpPUDlF8iH9tQPZZo
xkbggULN1LJk/UujBjdeNJrZR9HoMJnSw8ru7XIoK8jtb+gC636gCpa9lsAHRvgxZtaysJF5QJNL
JfFhGQV4Tp8pRAqg5OHMMHFlDgcgwVn8dsfGZbc2HnMZqkiSZ4QWq7RCmidZfBECjQ9nOCZEaYNp
/al4wpTvv5cWbLIW7sYEqNH4oP/Yvpm9lVFjnEmoTmm6NS02yJsuAW0sIhzGDAztLobXf9Fs65VI
eJJmu1k/R9ssYiieFiGOzgsRi0C8dr76watpWgUvBt07p0ajgzOBeJmPLRSSke9KbwHnf/ZYgJuN
M+zYS5Y+FzPaU5R4Ep52etCrwLJl+I7O6eOchnvNx98Y+ZZPow6vmz6fdm6JCkEcN8cE9NADHFbB
noD+BxvoUHdH9xAK4cdnpgU2bkuSLCPPurps/9FJP5G9FvqmlfqrhL8QwI4AGFiMHZ1UtdiWkF3v
/OD3OIwo0WdX8VjHFVyaf4eVQlLZqK7K+57Phk2B1N9ZZ2yjo0Hu80dytGYA1gTqOmJF6wFf5lw0
ILIcZ0+L9Zg+OaGrrffy5GxxrRhAzKV/h+slhX07KRc8Aql8709Q42NhhM18GqiAAzfM4yRVgapI
lCeSpUPQQNRQzWkZvjo1y/3JEwOBE8wSWtbRU+GPNnKj4Dr/rZqPLBhMY/veAiIIeUV6UycdxW2G
sgHiPtixcNhUv2ZIrkeWCbOMDRZVSqpcP5MwweM0Qek2u3DKD2wjdTE7Euj140D/8ptPgjlLucNJ
RoRXyTLJLmHwESBSGrX8gbTFHRJjH6MwTmmIuCJ6M7uvjyDRE5x7Ora8AFvQzfD5H7UJ/h6AMrEL
jbAbPYcEOf+t9ox4q/cUqcbvzqp+z8W895Ajh0DdGf/AlqYdgCK/JIKaMGzu7fkJf+EXMMWUKasD
Cv3f8k0YgKn/4XSX7pJRLURIME7aJYeSVb32UJqBWH6p8ka3/HBgF71kL8ZW+sIzpprbWix2At9f
zLeAnVwyjDnvjvenMuCqHIKUxWiFQPNBfwgoTyBC6X++ADiqFzI2gmfjnWI0+60Fayfi32qlsbRx
zBBsM+dV6YICmcblNczGxK531MusiEY8DozwogcFfWI0Q3Iw0ZcspWrikJGvyyt51QHfyHsibT34
aca8x1wHIbHHA4ohnm54y+I4dWMKIiu8XCZ4tvVEFl7KOFyf/1mfsPGaGkGiZ3bsFU/MefGUtnxx
qfw5jZdCAPOhN1d9y7dG5N2JCfYoGIWudQSHe3pzjtJN/nRnEqN+B4FixHSgKgdvOw5oqz+XpDcO
trHGszEUrL5YHcV4/Zv4K7FMtOqBTwsaFZYyrGeq8R5cs/kLYlUy9qcdE4jD/HNepxHIQqm8hRIq
lmYay10CNKQn+fY9OI5UR5RK8yDM5xVgVM6cCR0Cy5JhEiiWEd1exueOOWxd7wDw95nMczHwX+JR
TRBtRhSPNVCW3lr84EfO2mi3CUDavoUFT/rYT7MTbUSogzIu3EHWunjMF5eq0jrPSammPwwfX13W
cGpJWmISxAHx/ICRFA6/dnlDzMQdWwa8qp2/3V36UFP6dtK86w5PsHyqYEjC64xOtbAVMpjTo0GU
f4K4n5WgVjG+A3km8UbjewCWVsSACcCUG4ZeCZyvGt4n6/g0jg36REY6UBogrtRezVXT5kB67XTU
bCwSaUW/1QU/Vt9QNflkfEokcfjU2K/UBsYidRppkEU7nvRPRQWvWMdfSCgYOCeUfCqb7ukVgsqQ
UKK4QiMKbofv27bxavYUt7t9w/iT6fyRCYGgz/Pl1PtkS7dmtKSAUbgqb5AEe+cGhwowK2s3uU+a
Lu/p085+AarmawVI/hHNUFg/jHkxxOZ36mOopR51W3gCP35E7s5jqH1aFIXAt8qKPvX0anPSva2t
jweUIytstQGhE4gsUJNs+z85L59p3iHtDQipW2OlXiast7fsezolRPwtiZZq/oF/CA6Z27t6Avzh
CXcXZykrg4/rgZVZGWp51NDKHezgDo3S2tSfrN0RP/xGy7CWg0scbzyeS5sVyY9yTiQh2hnMjcUy
ulQLoj12AYj70UV0MPH2kadk0Jlr2jfqeGxSjx8du2SV3o64ftEG7RderiyHVRWJOMK6V+/kZKd7
e6TXqnQN3xNgCfpfSeOeDDUKVpPH39BE7Ana636t3Lf9oeLedu9R17BLHVDokhLuIOT9AfOg9Ihe
v2dYkn0CECs9KWkL4xqxNKHfoOZRceF/+L1uOqhj/TlZ9fJCnM+kHfIUuV1MtkzlpBwi2sYBWK3i
ZpdkZ6CrrjYIxbpB/57OPePBHYo0Teo0qEsW4aaVarhHHlTKe9ESsfziKy8+HENXdtMWM/QplNqw
GOnEKFnPlbxmwB2Y6nIB7Mhuo4cVKLnUu2eGEbhEoMEcLG+jtY6m6tsQsETjwffOpKwSY02N1Lcq
+9dXhci59bGfVjjPpCpPanUha+DJDLShT0srZ6zCeKyyxKEqJX9xWamyqjqFq+DTYQ10xQtOswRv
1PCr/2H2DGhtGthpdQRFBBzLjyghsW5rYsLyMMqmjXpIBsd0sSuPvs+DOcKeQHljway4c+ZKiSgq
whAeX6moTfGlHkPfOMSH08rsCcmWnN9kN3A2NQ/+jrNgdsHH9SgrxTzYYIQ6rc5clZMMw9oWfplv
P/wJ7qh5D24JPU9zI9Ci4UTTpwO3j+xV0srekcYcsrce2r6z1mKSN+tVMaTtz2m3fsnNX5eeAqKT
a+QmYKpaQNfW0bX/jx2h3Q97UWPiCVlgiSCK7NObb/A85FcV3BNSdBGlRmDmBwsAmMTfTUzdHpMb
gPtZRduoo6GGVaL3ti9JAdOAo49zgid/KoR+THkVdDYfNtKO/c7tg0+xW2XYZtJsejKFXfS0nmD3
splrRQTrMCRPQU0dYyPEnPgeXWJs+bTdvwkl7HI/2QaBJHYB+7pETfM4BkxT9A9o+4NbMvJtmVo/
uWaHVCliLE/GXAnGVGD/M0pxlaBEr3DElNVhbI9BW6fT+CrwIq6i/ZAg25hi3eBk/0C3iiRNvbts
XGm7+s8MOODd+yPFhEVAL+6GJL2aGSHMK7tKSTBW2FMNQF0sfM0qkafhrIucvXYChz/gcUGDx2DN
N/+2WuxNlBrESK4/p7qPQXZCwzuRCby82bMYs1YXdR/kz+ClDS1ElOklvcSXQYydIx9dhfn1Cgxy
xzqUtp5xW//0jYNmxrhZorvE3PHgwGdbpANqYcHXc7jhBvLdxlxswoMyEw3zUn5fLjwakKoDx4s4
C1Tdm+MUBv4Xu8Zqjx+fWcSPMpB5oF6PqVleUo5LHvvfhjZx/N4DBkMFGUA7GHAJ+wA/NsnWPPq8
VxhlouMq6T8Hsw8HECeg6d2TDr6x/qGp6l4mG9I3ggo03lv8g9V53rQjW9tngKTERJdLe7tjBIVR
ws/8k9Lz2bsx/tDlZ4W07p6v6yE/4Npltlw15NRglsl0OJsry/DrjGzTFEpYv9Z2cqDA4Wo1+OMh
2h27fXS0LehFPOz4vonGzWcWNvbk7e80YFPWDpEwctdDLRY5MTcXkkBOS8Tz3Ml+8TZLVRQG/ECA
ET3I1ZrCWiK4I0jhEtiPqAGE1d2y5t1+Qn0dGOOEKaFpU/cP9vvDNBq10i/VPUcIFH08idd2RwRs
YpFernyPYf18YBbcTtTEcVULMnKbbZCS/PHgv02spYiq6e9B329wIs58z7m46yr9KcupPeE4aduF
LAo8KAcuGtxVB4KXLw81bbD4viq4iwT5oD5MMDpS+ItsXXvM0qKKMeYh8+aZUJGNCkXOUWzqrOBY
1Gp82wgeExglsya2W8TtQFAD6MITl+sSwB0DRrF3L7mIUYKWr49t/tV8zeMGqI0kFNVl8B90iN6y
63tOgjRwWYD1uYn42tslcykUwi0BI7o8WlfaFyMj5w2btbsh25x/iHUYidGfK3tbM2iD42Qw5hvg
yqcalaWbMFwUF0B6tMzpVnWZczm6QXmzshkPNZ8ON5wNTqsqdAiC1bA25NcF30uWdmD05XOXIbKC
tJP8vPSj2ef8nX+1srvDnsD8TX6jY7bE+g5bd3pLvpq5cBfdMsFpUo5/4r2t6rpXoRudCegSv0IU
vlQ4F6sXGtxbH4j5du3miSSjYm+Yl+1QKkY7OogZsvDTj2Hm0XSF6JVxCHhb9PZI8lkfRukapK5W
uq9CVxCOlBRDtoF6BpMjUEqykRp3C9s0x756pOKe1B/WUXtq7c1iWmO+j/UrO8Rx4Mp+RjyVttyZ
mhbN2D+ozXZ/ZbpJa3FPvRGsPtOKrB0gzY4bArxUw0VgZjNDMIsrSD7MygtRjm2j8AAIrbKIiuEs
BwvmiUA4VBfjV6W7hltvgxcCzOwTgNPgdZl2K9YtY13CtAw7dZq/PqWet3avvAnWd/UqZuj7ZUyB
HCcfgTj9Fs/6s0PmJwTkLObQ2czyha6wCdKmMTircyKaJSz8brM6GXdqbclb3SYPfKNsiMBiHQHc
rHtBW73dyTaycYPdDdDL0WuPVcubBfUjcaoFCvxmbZWSkJbgfXtIkwRdt1gVMFFwotFjIGEJYHdr
HEMrAgVGRtSZX/puH7uTVB2bhYeUHvWd6Sw9bjHAecYGt5vzOsgJKVwxHoG9fzyyk6eDO6aME/lF
toyWOA6iM1lFC28cyz2PREYPIOBZ15eGmt5l6YgJBtcPdhtxk+X08RlUH6YS967k0VMkKijjqsA0
py12HnecMRnxbK80pgGscQHnFO9/uGwmXts7dHAlETZxD6XXkSLcsY4l6xGmMh33H7Khf4StKg6h
0L6zbMUgexoe+imxUUlqCCO3V8b2ivzjEjQnweE3eyPtu5cwWTRdoLUJtPP8Bt0INzqw52/V8q5D
ZK+1h59r2l0GNmqJB6ImsHX8PSPGU2sMeiZOQaixyudC77IbmxRV81xXXJ5h1vtxJyhxdqd/DWAF
hheVTFdEEklTiDjzieE+mEm9J4LE2DogWWaTVpIvI51eTOqYYW62+V4as+qY6YsXclRRlzVKAElI
cGMQr1ylliKX/v5dILXOw+YAHVRhVNTgs3X6S/lUjIW/aSnBA1zPv+7jcfCUs+0ImLQcidW7Tcma
wjhv7CsV0QzVgpKXgo/9M5Sr/5/y2iG8LMIW6ClWYRGwuv3moO9eO/2xy6fQfXWn3Pmk4jWPkdNq
F6HAhoJaxu81Fgg0ZLCHNay1Cy/8OFUI2eSHSVdiPHRuAYzF3OwVHt08YtTtvx9lTsuLAAbf5aR4
dbe1Am/8hgMxMQj6sFQUyUe+gds9FEjzh3BbnbRKJ1JbdgP6Y3uGhpMq19y0q8Cl1q/2TNOduP37
8220Bbllvmai7A6aFNLLZSVhaZDHBijefE+qj5+Bas7y+FvUiKFJS742+7TN/frG4069CQUpFvQq
VpAjLI3Z4ec60lLGiwuFQAwP+dBIj6UjPxRzNuJTeYJO6JS1VsZtp3+tM8w/tRcZ9NmY9hxYuszY
0zs2Zb+eaPvyP3fjTdKdd1JmWdwqMI1APku2Q9mEwEPniWPJaqTlllUh3jzOjXM0F9vbyWt6boN6
G1vTK5SNOLg1Kw8nsXb+NqZe5JJ/JkcqcvJ9JzH7NrsPec57hnZe21HelLK7LcmvFItyObMb8Tb4
H5nQTeTkgx7bSf6wC8WwV/VZyy+wrPVLCubga5jzOW2fFNkxA6ccx5lwZinDM0hp/KciFkYCKtFF
2p/9E7o+bA5tNV6GMWrI35beDdKJPr+nACGffYlAc9SvJ6ixWxrJEasQUIbte0qF2l2cP/UUx3DN
z95dC/426VNcOkv7iQkl135sh9iggTuKkZ09c18vge67uoo8ktOer3CbFGNAcgjDHMyVjBezeSuH
GTCif1V9WRAEo9cQ5qnjjLAJ6fqPV2gWW7wPVU7DA5MPaHpCVVS+sZeBIpeFefd7w3+WfcW5y09I
vmPQMMeITHYC6M+2QfLH1/KVdk1CoxdYj5MtgwmWslrAOIhyEts2KRXqaAHBIwplMVR/5nBrB0Bt
EET4PUkbrP1MJ5cUkqire5rido/MQkLFwTkQrBeuJ/PZ+sVZW3x7isf16KpQexFs6hREvjTxvuqs
75SHxGYjA6I8HEtSEWkq1oVIyi0Toes2iFvNh2bowPh9PwRpa+2PkB5H1Q4CyH/aVpY7pFdk0bu+
+t9w3JaC/2LKI/08yzLQ8x5esUgFqbP78/mjzefU1hFpmLfgKuTnsH0u0HpS5qNo1Z5nkNczHg1l
z6r71Trh9JHZEvlyuvvR7CkFaW6yOff86tXpkuDG4d6i6gxXBoBbZApOq5NVMw16D9lZZ/hZrWgF
1qLunehDOgx4PYIB8paOF/TU6iudbeO8dsRbkcMZ626k22HqSlz/loOLgS/fsmnEeqvBmcEKnL2O
da4EQ0y8iV87yOfW//HFVxjKzA/44sJYhAEt82trHp2372zhcS1ncMhqDazzTnfwFp3kRagSJN+L
twyud3qIuoujXuysHPrj/La7htfju5Hf8p4/4lf1d5fn1Orlu0etpj+RnNbsRITolNA1eStmV8j6
LXlaTqU+uebiexeFqMMMR8zozwAerPEUK2nnxyrD35ShI4RHd3y/bg9lZKCBwZeDe2LJYatl2jcN
r2/+eQUEs8WprW6k0IQQ1y9wKJVt6UwnDVEeavTbiBKtbZJaJQUq90PP4k+L5POPm+jXgpZPu7xl
vZ0/JstkQAH3i1m0hg5NV4E8EFuP9QqhRi/Vm9dCWPTvX9gr3znoixYtOFyvweIkyg4jQ++z8NQA
J/h/VksjjSd+DEsM8lA3/6zgclPhQb37b7XmGXEdZZrm2TLX6OTi0ZhDucdlxYBhc3tHy3GsgrzC
b402GuucjyuWeIbSp8/IX9mi0F2+kfL5eZW4KthSUg0ooiUmlxfs+nQjeUtc7T4QDSR/jXaBy3y0
Y+NktH3x28Bvn0vVNOgW0N3M2t1FTOm3qP3GtwsucQISMEBxBArWyhCYGoujPDJZktkdEB4DY4px
VLD1P3a1BwSKbSor2zdzoMkxcg7MdPwKfowA2b7JWPu71dNS53aZwFMqtCuoe3WDPETYZnYhCGPd
SvLILcbR6ZXSvIWxlDPz8cTv+3ZAbHah+00Ez2RpouDTsW0gEwCKaBHhAEuOI90rBXFrqNz6x154
476SlHQbDQGGxMyKLQ42U3TrM3UM8Q3p6zGPnqxTy8IwItKPLte8GpaREqdK6VoUGSWgItYMrd0p
4OpcfMvzwHAOnE+NK8szoojNzobVJHXcOjBsLndY306JtXn2z5pEHWsKmNHVAZ2aSvnQlMQbi+wg
89T4XSLsMn5y5og9FqmLZJpNKznKwQtuhUS9CVIeuyqCYVe9+9aVLVSPReGfL68/YjcmWL5aru1S
z8oGd7cKW2t7O1MbF9yzBrtpqN4NdUexSAV1ARtTouKPrUidhpahs8keObN9vVW8EIHjVpgrEa1Y
ULKkj+x5YYnf1q2NdPwBGoRKTZdOg9P0cEyo9EgLyBWZZd9zqMBMe8xc+72mYI8Q7Que+M+rYC1W
vV6E3waO71G3ffyKzPpCTK5mRMKIsmxm63spERIUYcVFRGnpg8Z0xMmOM7qc8yVHOCud/rt37T59
uUmQRobGqUx9OhDnssONsQ5UcBB3dCdrIUmwxRq2aQwSP5EqtX1fgmmdsNFjiiTeyyJXCDQnInpd
1yZpwscJy7uN6Wi0SUQG58w6TB9tyIsG4joKA9nlKqxnWeKQXnnLN0NOkXYVfiTpxO9sApXAHvOJ
xBSU8EpqjfL4CrFBUvxKpSfnD8xh2Ey5/sO7YTu3XjKgw4fJwImmfHQCMXfIGJ0F7vFilNeKwD9W
5ZMp4NvA/bIcuMbxk8YnkOu23KP0QLKqctviCOfxnJxXbJ6/UgFSx45sy+yXzOT1vFg7JsGxiGpD
X8KSNsNf8r2xKTim1Y7ceEIvu0SRg20KnLHSGt2gVEEGvQGdFc0HRWuL4YkD0QvHvo4JL0vDmb+r
tCDshXRrOz6DHg3+QjrqXqVrpZINoyfsggkrNtGCUmAps4Rty+7bnHtAY0x5H688h3RzqrEXbJxF
MxoQBZR1rs0bqJO9PV7fGbGuEbYbMNzJ8baaEY4ahKhnVsbJZypThVLCYJJB4opoMAwI0l2dQSQh
GL/yWtc+1Aw2qK1g2VLsPfwb7XlNaEcQa4iT+jCumVrWUD0HIrrdCP4P4e1GYpdFYPswbrwzxnDe
3ilWgiOZt6MtL3UVMY2KCbFTCiKozGBPOwrdLO2NJE1FLV/5pDzoE4ZxhZ8YD2yiFMaO79rk4N2F
Dv71eNCFh0A3bvQY+IP9dshstZY/58nYmX1w/lSBXtydnEPXU5g6T2jdw/bTdFv1Fe65qduWyqt0
d7tT0/ttozkC8tS/sL95RQ5Bg0ofKZTLQT+iyUh3H08xPGrY7B9FXEpaN2quLWlnbgWfYpUpP0HT
lwYsFnufgJ09qey0SpC6wFKePciRvfBN481SjNJNPK0gYkedMs3KvRzT6aZod2vwiIzF7ZcKfXcZ
L3kZtovlGFEfriWnulAHQfSZv4vrtIa8tmljBJmhGZzFeIW3nleLZ1aVa/hE/BMnmPq/VYWN6BKL
NYt4LY+3A8y9Q07BthISRRnnHo0drHRp7ICi4weLJDb+jO7s1h1KBUoxjMq9eBRR19YXeMFsPa3v
GtSXxQKaN39oUIcdoVwAnernmSwZSoGwiR+w3Wu5PUv8GVc/NDO1ExNlK3K4vlhsdVZZ6+8a+Igd
fQM5RNegQHIrCxP0iRWGBAHYKIQyHEufgIeyGFbiH5YPOjqUC3TlgZh0Db6imX4rBIpbBNRkeX5u
09nwMXZyJ+amAOJVjOn89xbENVNy7kNN7Qsf3ZoP1VGT+34ujJ4ECuVUsJgKeV2EACDUYw3tVrqu
g/BoFbpnBz55HumizSR3OrpU7b/3yoBEqNXlp/faYVK7E3PscfAinpFpE/FyLAieejp3k1YuOXPS
mBJ/gbYqEpDrSog7tRwwwhMoEObvAYFKsWWx1NyaxorxRriZVhxiI/5dkcLoCg5Wm6czcRYtpjAa
bF+QbMOOJL6cbFIltbXgRjw2L//gHDUz6NqoGI6tbn7jpB5AXh4hx7hxcE+sHSZKglBU+WJeP1xW
3hTshOB92kIMorlx5F9ZOue2LLOjHXxGYhuKv99lOdbcXOVFRopwO1AtsQbCkMQ6eVlcqXiCDFYX
+yyap2eCsWeri7AyS3sAZe9sq63k8HDXJkWOfZH5q6Ic3Kg5O4T7vrzdUNoE6CyK+cjw6cMPnhJx
kQipyqpoIzxb8hJ21W6Kfj5FZ+BHcEVe0rHYNP74jPzV0wL7Ho0RyB/HODdDuOU72ZNnmMBsRfVx
KPp1kNU01YTPBtDnhjlaxW/iFwWqR9YGmQwP8yc9seadBlN9PzH7g/heJl3gzizlddIsHAP0wGRW
k5Vz1bA7BrYdIcXmscXXvqu7yMFJrbSQoRPYx3hmqgvoSoPhxj6Qpiqhxrp8BagmF6WmXcLKLrkU
VRSIqE+rcMY7TKTzAhDZyL21NiwpPP57304AHWn8UOBGPK9kD9PHi1a1r8el0tLYZKNRJK7Ko3rZ
DUKtx2Fy38Oehybg1HUaMHgFmvJtxtVShecKCn5nJiCCc+huhr9j64/ivE4XWZW3GuDu513todNP
P732v93BoAmfUdee1awIRL4G3MkKj1YmUCXqUdwopa3gjkKVryeWthGz+HiUcS0ZpMED+zF+d2Am
bKqPvgsD6ly9kuhidTEgDHvP9dr4JN3hlP4nE7hgediBop/JB0EqBew5isSC5p3upf8vKVcWAswQ
fmtaaZKMqxP1d2gtyKxiFnwURb91lKsj3APIu1G7jBFeJC9pEoetQDSqI79OjsOdDZ9/UE64rRIY
xF7udMhY7eamXc9fDKDSx8QRSKr+QIqA7yOeG2bQ/zRlD11TBbCmyZ1kVrUzgJ8+8Ppf32SMeW7A
3smvQH5yIfzEPVYCEH+pr/emoKuAPwc+7rY7gLaWKTZnEAlKWVzqLjB7c23WK++hYE4om7OxzjiP
7xgNYtbBVGzkBDRG6SI8BL/ciqE4aM4Qm+zhE1ZZe5K3eKZFpj9GW65lb0uzP3ZQCzDHWtYmPVnO
2R+VUUzSMl72tDlifq7fukvwacl6K44lyf6PEAXmLFs3kVxlFdpVOL5Zi7A/GAQjZQeCh0rSQ5b9
FB1xFt5m+4Fczogl9mPrQEmzalRVPWnIYWjPY4nqupXbXx31i2rdqPn3OY/6Y3rdzIcgq+DEaqAK
DCoC/rLDii08HmT4ST6OErdwTY4UrBUeQGcs1wBkWr3k7RXl6LPVdBO7ibxnt4rhuX6LZpOyZeOG
9jV1XVMUV10iK8PJG80rzK8KuRrSqBPUfKgFY9G7zfR28aXzFtquDdKs6Q+mB848Yu8jgSBLA1cn
BvmWHwgEPyC9REt7g7AfztzDvfk9u3aPCxMm1ZH0jmoS1RrmJJTonZpvWHLriNE1gVZfCZjQ54sb
a+O+9ztgaBthPkkU1UrKx2YmNVNfz+d1zQxokUzwwi4wTd9sWjzQAYPRIVloDYlt0eRO2iKew83k
IL++i0rl0OlQ+UPJWc+myx1gGO7gZTIhd0w9WxnMvc7xi3WW4Fycd0UDX+8Bb/1C8BMBqpFDhhhQ
DLKFWVv9bmtNWZPXMyFFkK4puwdK2qHa96JYUHQfmiW+noPVCsdxrrKbWX4kCAuJuOAvYUyRvJ9E
wBQcsREOt63RjdtQAmrCOZ698A/ivaDZ7wM73JZO1wJoaCmx0V/SzVrjK0H1Q2Oa+j9E+/TeWvSA
es/EesdgDy5gE2T5SUuXUaLhYn6e9Ht8GQIXfx7TEwx/7uskTiYnJDkEhNHHvQw8C0ovFTZhKIAJ
6vyjw9s2EAlwT1DPBMyWE1fh5Ozg2M32CfGT2NPUmLsvrR6YWl2Q9MJMK2caQJl44i9Gmhm1RRyX
DRhFdyctBQFxVigJBj6+gv6DHe7C86MBJ9yhOOsKcY1Guz8oEKTNrJVOFXydtuuraHrjQ8+xpnf+
upL/nlvGhT7QCAuX03VLmo7/pv2Cxpx+c4CaJiFm/RKnUnNWJXCREWh1kr8A7lzABAjnqQdwywAd
Z9qR/pQJLgew0XvQ3SKmNhkIqQavg0Oy/zqRsK8cAQydDHpunQGlzHvme58/WwBuVSbw8K0D16uo
2NDWhIoQUO8fr2HFRlRGt7oeldLd/B6Wzoeo6InSh+T0avI1dkGBwvCCmDJrYuGl1khP2ixOHq6p
u7HxppPw+07M7hVpJWPVM6F309z/rX5jyfO12gqYJOWbWYCoVogYfCnOfg2T+wS+TXoZpEQxdcOH
tHookK7Pg4ammyQ3R0GdCC3wmALoWYx9RwH9YDXdOE85p+8y+ykP3tCvfsEoblA8ll+esaPi8up2
V1jEI+PgcEIeBXAyume9/G/IV9uEZTIjU7R/utyIP8ZD+9HR02YbUR/acqT8+UVpGNRC99TDVHgu
p5WnEjBHxo6dJZAH1C1PcRqzIjzG9dv2uYe/QNwmqUuIWttNiAO/ihBUN1a7m1rQJsj6vs9FLEd4
ehfIvtsqNxG1YHwJn2s/0RmbUW2GFa+l22UWwCLjVzfDBLxRfFrDX0DwpiYUQfhFb9Hf8WrgmJwu
c0wzAzq4QBBhei6Yt5n8AU8UdoFAGvDy8RwcwSn0T7Wr4bCtnKb1/xo7MiVu1HOCU/YhIS1YQl50
/DOTimOF2ZVjF17vcMLwGbdpHNZCYYbR9R4Lo7VZYK3N76pyeG/8Wigbsvhi6aNCIsIKSc175dFH
nxkqZKB8ovapZkcQguMweTnBPcdCCTXcOWMtYUhqWya69/EGoWCyXB7GtzF0f7jUvGJMLGkBx9OS
8q45J0+Lt0x+6WYPx6d+WCBFhyFAC+aW4kpEdYLIelpgaEuSuHkOasq/gepeKCS1adG2G5I7zu78
JttfHWB+rvR2SqxpQDjUbHE9nh318gB+yhkTOFjOXz6OwjgFAazLZ8CIU2iYV9g58+HlZs00U53N
pIB2029XFHk6geqhmHjjMIGyNfkXVSFvl8UKdgCvNqPChHAk6hhKeZilzB2PMXUtLIvdtduBFxuF
e1YvFh6ad+XRllcwVHt+S/ktRQrxygdD4Bi/161pwQ1ip0sNP12MHl8clixmjaNkW1vU+MrdxjJn
J8/sedeKG6/MZ1lXWILG52tHFsbgQmN3HVdsYqXbPPT7/uWup7lnmxDkF6L5Cqna8jsGGLwqWz+6
3r9n4hB7aT5eBAyuDohb8SxY3qiBTd3wfWbZ7h5gQAO1mlJdb7UQYMj/LVdQMIlrl4Le4UFGam2Z
9nsulGe7rqQBy67nE8n62p7FCItbNiS2KYyUOURD0VoW+1AHfYrRbTTmHprxrPuLmZlFJkdELvLH
i0g62+SrE+mZb5yS2xbMJFiGayeUh1Dz5arEGSXt3119v3CaY0evkLhJQW738uaKhzqTT/X9HrIT
at/uvIy+NAOxBiFTUJ4FqPzxLWuuSkc6H38c7hGHSMbl7VOG2GpSWCT/22vOCXsBco4jv/AOUhps
lvfRI+iERGQAUc5MBQg6Vky4Yg4/2h/wqyHBzAaVq/TnBCP8Gqc+j842O2z7Y0hN5larY8pCsQ9F
uZbRDAFb0E9005YjP5W3QeNBTkVakwCrVZs/cz59vDQyuSeWrFrtVa4pDQ6jjaScTiL+7b2B+cyJ
+YFPXJoDWb4sVCqTI6p8l8ER93JyufYjshrbWRXRPcxTIw9DOOmqHofX7TbxBlo3BdNCpyeWnOI9
1Zbi8vgyhrwrsNR/R5BJWzjkBVPrjW9dJyxtmn6jyrxxGcwi6cllUGzUQCtZQNlU28jZGT4x6p2o
h/Z77mtChfUT7ISzYr7L2qFhBOho0W3wmy/pl/iHeIHKnPaEFuxz0z6c9Gaf/nKSWmD7zmjjWKOz
ElFqmjApvXtBGBYJnBHGzWE2HLjapWnJjAbpXVYEdWLimkKJf9mczdDmqwtsLCK2Hjmk6xJWYg4S
VoFCVtIpnQlJERjgXYxU5bAVzGALLcMyJK0nKn4IM9ceyKm5FZ81X3Ubl6ZpT5+t33GZv/lKvly7
yDTb/VlPc8c5TdVRTOSbDj36KChYjh282Sz5e2XeKoHZaIq6ZJYmkjHkdBuzjMZgtojJSoxiO1z8
1blQpN2HGISA0ZuVf+AGpXtF8E+4EEFBTmG83vNNS92AKiHmS+c3weZt3wR+Ty0IgBrzHE+rCrWv
YoCLKY8CARShajzyv48UnZFBWjeVAw0VCjbjGt9Bx3A0bxgrtx0bjuTnYXpUJTUnDqN4og8I0+Vd
IFV273Oo6dplre/5My4alHHcAEPhN/3s4kB9UIQoNvQBd245iAt9eARS1Y06guaLBfskbV2IZ0MO
3SVJazhuNTT0hXQi0lPTWgJAPu7wYyS3pTAkoUxg7xdFGOjNsDxKuPbi0zALaoh8ONBiEauhu6+G
LM2CNO2nN3NoRSIgsGsDiTIAPZQidXY1bbOdo6P51x9OZGqlGwpaxtZ3kRjuynUuEGgws8nYkVyc
lj9R8kq17p5YAS5Q5Idm7Tzmey4M00JOX1taEmN/x8dNYvd2KWPwXGoZkp4AhXol+rNf1O7CZ/zq
Ah0gcbN8c8uqsv4kBotic42QaBSNi68FLIfvU1qr3nQV/fZ1XRI9gcQiDwXUXUspXgY6ZCgBjyso
PMIbWfjG9wH+ju7m2jlhBblKc6TC2Q8DQ3JXi1yhGRAg2vtzmo3Zr+Y8/ljXkwbtV5kFPQzG7SqH
8xrHIG/HCr51tKyEuYJzu6d1XUkW2gZEnyMRY87HQ8FaZwYs27/Pj/Ho6AGtsBqCs+rAvNssKzzl
38rRJ+tIbH7cQ41Z6juoCpuQP1/Qbk0EjsK4iJ11XG82byYlY2HsRKksIgQ9ttcTOLFZep9ZqMhe
OUqp/XC1lqxa0UjP6BH1j6Rrlke9S5UuN41DJHD+K5PWWLjfU+aMaRJidX1HtxBi5NXKFqanM8lG
qHqlWH/t7hbqYiRK4PACekDswXvebLYJ2J2o+KWoDuWxCox5A5ZSaXEN/yBHJopqnBtXlglE3szA
Xy4ytG6HqSWgOX5iiRy0CV/eX40MyoxboI3wTMHturZzTEuWF8Ltugry5JDpRAe0CvLCyExquyk4
X/kgbj9PC//k+RU2K8KbnI3JPp97KrhQuXFF9OFf4OufdHePnUiwvSrwr/U2esaUxpGALAETNgBo
IVm0CbbCmXYw2essSuN3/pPG9AY2CU5LGtyzhR/QkzZsB4s2GZZy/8bgqsx2c1UjJgbcUSK6nRHB
HKqwsc01dqi7TLkfZZO5VoGvEkV/yV+qrqolgS6SEi4OPZZlOWXwwBGQVhkWLvipzCLfVBlZRiqQ
zp1KvChlY3ElTxEtxWFfwufCunXrOcPvY/uP8AxR3Ug52EFW49+zQN8mbJtYXCeCrmwKx6kdQoEc
3uhdgJp4ruIY51l+txY1CyzXHSbVuubamqM4N8CGF2TUcraOE8+faINftFRzV3YKFEXV5yaIVW/P
pozbyOsQYipvE+WaGNBd4rEDJz9ugZntPMeF39pEt5F+VtKfjmshsVZnyYKp8asUzfReizg4BtV0
eDG9cSkGgcaI+8eekaCIhSbvFo4S7yJwGpjwb2pzsK5Nji7+ioRSXIGnnYCGdUOTlnXqCBIOPpJk
FeHzdAjuOuEf1SQsaJVvL/84z4UgoT9ywgIgREbqmf79WL3OEz5uFuMWlQ673gyLiqAd/4UyYeGG
gCAJTL7PBQtAP9d99y7w6cFEJ6uEb9B4bXx7MLpUJuAm8DAZkTBCANDfxazIYFkxsKG/7KWioBzd
HoUL+dykR5PvexRwP2XVLKE/T+k7SxTvADh3nU3atlLhJUpJrxqqce+bqu0rwczSbNM39VALzVBK
NJqVppRx+xrMZBsgFDf3scsbQ9on/Xm8ANczY3kxCK1IO0OU6mlHmND4D35b8zQmYVf/ArdskTEY
a6N3zZxsvA967D9LUUqe+xb1fiuB4xVKerJD0Cjll4uJiiE/jdtoQM1AZicxUbH2wGS3zYzpeu/g
3lbN4ruLKmUmRBg56dtFUNuifoLwzLzpaf6W/Zm4YEtRDlqIb7AbCnH7Y2Ok7WywNgJYsYNsqjxj
/YynPplX4vWOOvNoxGvOzzOF+pz/pgjwXXZO8hR3VcLtsOee4uc8SgthElF26XF72WsaSkrDnO2O
GgNTY8iorxpTjM5dxQ0EUXu0nIiuZh18p6st6d/fSdC3jLHnz0ceXJfdI4WMCo/Phkt+YLBVpuSD
gDS8j3aPsKRadBJFQv6w9OMgrQhkh3uRh1yzFT02DqoDllxOvqddIf8VlARVqXu9BqTx2V5GU2V8
oPOS89yYiRN1BYYDX6cn4ZztmXkPes47M2HhdFQNBjuD/aI4XM5bqH31BnJpgD+85zvxn8o1nqda
fqtjdqtW9YUVHP7y7h8i4lvqB9NOncpDRZIUvfYlqA47piuGhNnIoXHq6We1KFqnnXF4vNBA6Spz
jjfI5WoihtnPu7T51hhGz2B3c81k111Ng5uBWvjJuQDOV4FO9i8zOm579wcJiyUNPkTBZIYHfYxV
Tw+dlr2/oOnDK0DDku54kaq4/98bhxDis3CR6YPIKb+cnmydNEIIBQER4GDatZJAC96UcLIguALV
RJy7sOL0cQjg57jMy10d9niICPrXYCsqanZeuDW3BGFZlxzcXwAf4ahv5kEw0O47Ecj4SA1KVCwS
sT+QQZs8nvR1D0ibEzrwQb+uJ6RTeKHAA+4hIJKMKgSfSkln/xlQQX/w0Ea89bWCHxYm5hIs23pn
1nvL/UDlCQCl/+XYWGRVRbGq/tec3ovTSVjknj3hygd6i/op44uBFZKXlRTrjo9hNBBfz/84BPSr
fx1g6vpEiqK/f0Oo3pIb0joHLWejGvsLcQXqBAJCQWqCSwJiWzlxv9Yne1lUPL22xbQq453XcJQC
kNpNAkIsfFKMBm/XrpBZxegO6kBJV6zt/7d67Kvm21TVLAsW0J1LfatWGtRW3hB00wWR5n1t/kVo
Q4VcY09Afucrngu/Tfj6s+k6yAVyUDB4an6fkYpX1fttwTdjhkuK88U7UjxYZLKpnFERcAQj7bn6
wBTU71l6Roe/zTDDdKKyJRNcFVcqcN+EMw8sDwGu4y9Ujg2fgQyyK4wpwDdAM3sA4GRYKrJUkE7G
kCxyCHaO/AaafE/ja1neCqRKlYTfpJEWA3RkhBFYj6Kcv4s/UqyompjrWYdosFmDpDVhqDbUS+p6
6VuU04738dANyZQJbwqwY8gXx0bY3kRE0R7ORzOQgpqy/8rbvP+fKxyWcX1oCzPLy75RPzT++1SO
iBMLtlqHlYRytgrYfDvmIkm4d0RqfZLBS6kmQKJBwWR7ozUV28et2Lc6CIN30znExSBIm0F5X+n6
pBkxWoXtnrKbSTELpGxMi42swfyIW0bDzosoSTWHkrmx/fJma5B8QQHnc7ahYWD82DrOB+jNnHXn
SBxDMbCFXwRIPtEAVsb9pG8i+lvcTWgKT/U5zg0hoDzucJHS6ZVnfAObtlZpyqgr0f1UsnWYlRaK
Jt/ToiqTnGwJRtQGBaFZyyrYvhB1qPBvMwSD98Iyi/CkJLnGCzfhwKIZOuZqeGKC6wTdPm/xmp+z
8toJiUsoU3i4uEBXiMJEHKzEgrXHSG3tMMNJOlEFAdBRRgpxM6GvHVi6TuiH+dX0XUIoUmoOvr7Z
0yQXqbIxC3kLHBJVcrDoe04FeRFEhdzmIfK81W1y0VEkoEkKDkJ0+3ojVWZqAmr30KZkuo0SpWnI
ldXy/cQlnTUh9gib75XpGGFBfshS7WILfWO0gFPF/F6f52BKf585jX0zM3QJD2RD4O4+c7MfouiO
jIfjidZlRC7UjmQwcHeOc7V5Ns91/Haj0LpbyhXoNmaLE/uG17bw7JMSFEv8Obus7xhGJ+c18e9c
+l0rlH9GOqEUayH9ClH1d2D+T9qdHqVbdvC6FYazscdjaCBLG+6hYY2Qo0CvYSq73rLxCENlSjMT
+d97oJlnkAhuTrPySPrQ4lMOU7mW3K6Y5P+SdY+kPoBYGxkV8bsbV7WfBPARSqvbFeHIA99r5Gc6
As6JzKMfcnDjUloA4MFFYQTYsokk1kAzUJJXl/yfVZ3KLaejJa3rsBPiwTs7ZVVtw5BBtBSBNEMJ
NuwoMbU1gUyosf/53Ht4KYGIMaiGifXivDlUsUQ3udVKQxlSYWNifelChSeg9/E9dpY/qj+Pws8d
Kgp+79DYgL8yPlxXuv7B8zvNg2b2vXklez12H+A7uThhZX9twetGSRNc1bQiCluUhWfmtcQquWL5
3VH6lNgAP/acpaDDOIvzr6IC83MWdIQpD1KV+N+pJV8zN8+ypltSJp9dC0gycgMtgM7zyZm7dGbR
p0efD0AoOBEQrDxN9I5EW4FpZzxfRSzoSDJO9U+ygxR81cFczTwIUlHKRroeDMJILQ0tSD5SVBiJ
tfEzDOuuxPnmOlEcgpRIkeQvcuaJ9UhWeAVsH/Mhv79QvTn5sW2m/Q3OV6hvP8+3SF0bh/g5PzZK
YRHGkwiUHwvrILYxHiiV/QIQj2MrhMVsErDM/nCDs2/jEDlyjB/j6Ith5+b8XfgnTDvGnKYYpDrj
gOHBVntgEFMPizGPB0QV50PLqxV0g0c1xCm92TCPztIkThgexR22z4y1DgByDuXohLnUSVGDj5uF
y0vCEFB5XbmbPDUFuHK4ZMuj+oK6834AMxQsHj4QkwffFsshFe98iu70VOxTPfxB4BVFDtE9pGcT
Tb7T+3aWriGrq8m5gRyTDJ+FHCPlhW5bn/q5dj6ODXt+GqhE5V0eOvIcBSu/F9m0ty2SMNlvw6i4
QIa9Ul5ZsDNWXUvQyJhYLw+Gb4o8RF3quF7955fsq7jK2V7itu+tAA/4hn6mQYny71ugUDhuv9Ku
DsWUGUgBaXpKqy+aeZU0uguXYaH2YSztQ8RFp9CYcMvyrNXtI2l2gT2h1vRm8Hbxwt4DyE7KSxFZ
XDFoR0FZvSLY20xRJOUe8uRXIRlgQj0/03Gu60T5UjSUENzhAl6e8Cr87EY7gZzn0aJDprkA29ff
VCWfpsXOJhKMtw8Y4PwydvOHgUJcYfX6Fq8OekfLQ7Vw2i9PT5CyOOkEOPJX9b3dpq+e4jvgG8jG
2zIwIzpgMOGeCyvQ6CMeGefwcg4GhgjDmYX5dI+VA3ycElydlwimqNeAJQD+VylHhe+DnH0aCeRK
vKInUdiJP0hhhvXOc9lWCaNpNZDAl4rJi/eRb+afvAk2su7S7HsPCRhtgcSqiprF6wJDhErJzMcJ
IiDk53VKF9T/1axYq5mKNtVtEzAkMyVvZGjirRPzgpZLg0IOVBR6CVUyrqeJqrVEPc+B5qeC+MRH
YichuwWtfwP8wWHfj13YvgeekHGOikSRxBDG0NnjpOvUJ0hjIvKrNU7J4w5k7p15ipRDhHfVK8G5
4Qr5zLdpfFH4diPOjzIeYuQNEvAJeE2PhSKkR8P7RZWrJIJa39eXOAM0QNVWT47YzvqYpF/iOIai
fdKGntQo0DMvITJmEsVxpCbuEHnbcCFPF4pTu9K1uw8ftICENjwzvddXD5Pe4M0dCYQ/ARC3k24p
Qc9R3FB7SFHKSbgTSgDCVid4zAa7d5jCH78TbH7Ng5CSAMSh9oFAzDblVr7V0+lhsdrMD+lW7gPK
TzsjpfYGLp5/Vvln2vNDGD1lzAG3AyhkUlNxdkcsJfMTgg2eaWPCDmWwv6F2/Cu1tCqMY+lmiWhY
I5tfgdpV9d6qse71P7pcF/qV4uO8+eWcIRZORDQL54wXYdxFUAlqMKhFXtOYHWRbtRgMxyyOE8Tj
PMLXapTL5G7eV3DqDBIzLisq3MrqjNVPyeS0Npifk5tXM6T75l6hHYlBpKdIHHlbj59O6LoCnDYp
v25YJ64GJfpCrVbhqm7FjMVaqxXuWa1VVGTVSacINN7cy8RciGvuwge/Twwabd7p1cpmpKAuCOQB
eunhiUPdrdFjKJ/QPx5UFZJAR1PMjxH+4bWAeGuQ4gfEEhkLP4Hu7uTHF3if1ciqwXeq7DiBSixx
MUNsVBJ8zmwDEVQBxNzQXCuqu0GeG3H9P/xOBy2O99tpxM9veEIy6f57uxcaM4iMO2zO/RhId2FJ
U8zXnXy5yM1+1CmQSWqBhg/8R0USqRY23i8UnCc6vHgmzXNkcbHfWG2Oz8WZKZSmtwMUMDN29Vox
niBeqgRqb8YzU9+X7BsadHx2hlirkpT9hW3oMD5gpTDRY1Iji5LiSdoNNJaeicY+kqjqXixrFyNJ
M/7AdUUc41W64WY53Pyww38Mv3680UhVRr3bh8ExiIJkBzMjO0ljwXHe8/bJCosw/ct7YrIWXZ81
tcLTnk4iZx6o/FG9U1zqXKKZ2wedIG37jGUrywFaYkOsWutmZzH5s1L+Aki8YP2nCUqH6U3TX0ES
21Immke7myPCcTW1D2yfqBA0AFawZJKsyEzdCOBTVtnpctrx25dDBioShwWnf1vAJnUW2qhj8FjJ
I4I7ZjH9VAsmCC4qK4Xa0BUfOVb5sScwHdB9CIFX5ygtWSF+uw5ZZf9Twk7TWulMCOqMTePn5H7H
BZ9sYslpk6DMNL4Fr1296r12thPuMYyX40JpgO4o4r4rH+5fckjCkivSNldp4bUMnqlJAEUR/hVy
W+IIk9LH6eLG/VNH+/glK34tIfA8s8BW4gejbu0P473JGOrn4THOUpT9ygUwWzLlSpEswpPKt/Gs
QgWidoPtrx/K3zQ3VOexgL4VvIMyKMtX/qfxWUWJYfT0fDuYQMx/2tA5a0oLfrEmXTrjr4UvJOot
II6Mx3GwEP6aT/MAn+RXtTIUAXYKkVL4Ht2QO1IIttLrEvg7kVPCZp6uHvRPES71tsdPdYXqqaL1
q1lOLUuoQ6yYZYmlGlnfHWz4skL+lg5WqjrKjEPnhzERoMb3tEEFXQYpAau4BKysY+4qMZ9fayxp
E+M8WettIhPsyJwOobOiEYkCojzFWrPFeAYeqBdhag3Q0e2HkVCD8js2L25VKWFxHstn7m6UzlVg
GSoLPd1UlUL/umJBwufO+TVI7dAiPI1fz3l3QpBelAy5d+JjAS/UwaB5XprrBgR7bOaUscaczUw2
2EqjfeqYqM8xvHEme78+a6wmG8q3wu6/07wb0mKMnFHJmc1N4NcHzbkPXVRZgV0cXo60l372R+Gv
D6hNO6NonRO2uZSFj0e7tqqlpbNFg4WPzApk72F5K9NZ78OqqP28Ys155bM9ZSVTLMvG26ymxfrv
4shXF47PSnWmyei9HVrHReWiVsOIbp1stA12J3w1STZEgFm2kQZ2ArttG8j44zHzvvsIXbB1nMRK
aFgL/nV2PFL8t2PEHXYRrJvBzlyMOGlJOSgL6pWym3ApXCNkm5TH5JvFqmqp2RgFX7jjY7EGYHf+
QrB+dfgNKItHZzUlmFyQ+VnNWsIY5Ypk7GvoBbaarmJUoMs/+X1YXgCP9iIGc3Sp4PjvTnXFpZIv
DuReNPjybLvBrel+jR8f+ltEUt2nmt7LkxF8Lo/nDTMpJg7lZZOzvakTdd826qLWxRW6/2b/1+qK
nNqoHH+F/xK7Z9K2P8lnhq9uYXKj7ha4FsCKq+XOheNRyz+OnMI126+8yYTWfkcfbU2faGqT3UaA
K8ceyHV6acHVBXyiNKnRW6x1tXRCikDjqLvoJ4j6p0ATEyGN1NIBOLSncz811lBBRJQ3VK615xgO
HDC8hcsEIqRlTXqLsnLQk7Wo9otL0LrNLSxGtEsV3PFVqI9CLpSEpmS56Yx6WZEKTPl2Z08H5zKO
3wNRF+ijk2niA4PoSlEAIbWmMYA+A5ZMlHxtVbGPYfiUHuc/LdmtHa/I0mSMDyQ6V2fkNRnhHy9n
GmMrkku62+m4owcSeWivmWzJEIZCIuc8e0cVQEGTioRz6Zggp9fso4AMld/jjOiaFOMR0ltatLOt
JXXIpF75QCsY7FuNPn2LsaOFekdlSlaMGzPZKnxNfUePzNTeVT9EMu4eXCPzSxX2kjY6Gd24q41h
EaK+1rs/0iOhZkhyvCbGfx7hpD8Scgs9x1Ja4D78NRF/P3smde4T27RBrEX5MSwwPyjIi6Lyg+72
9Y6T41t8H7qk3TtQmxysuiSNg7AMvBgeGzg5Vpz4GYv22ORmGE70xmZTC0ZmN5xVhtQ6WvAirfV+
r5ozayH8EWh8q6lff8m9GV8xYJxIP60IrOL4DGy0UMI80fAtvp6piNw2UKlyzfJdOcvCJTSVnZOj
ZQCHdg/PKke51gQmfmiOFZ9EhCAA8mE++EaDuMB0HM1JM5YU1kMXvGDMD5ub0avUIe/YW3dnQZdc
4+/oyJJIZfIu7+MmZXVyVBato29EAOSi7MIhuhOolm3lWNkLq+h/DL5ZhoN/zK59A5FzxviaiFlx
1SpntRgmAXFZqMkfoFseGiiDntF0fGXhSZHM7NP9Cj+aWHC1V5ooEqknunOnELs4/aufp6SuznhT
5LngsaUceReMr5EFfCUN6jQSNAW65cN6wXJlyUgLyeV1o/mBhzp4bi8T7nrNndeK7xpRcReshGp9
5iZFsD6DGxhvEWObFYrDvQAay71eWqGKFFsBFESWwk5RghMg0Om035DzV5xx+JpTVsQS7r7hWCFq
Pf2kJ4tIqyg7CkoWzYirj24B1aUVxg4FbSd41ivKcea4+6esyjf9ujOjVhYDxDYOcRFG+AwWYJOf
b4AXn3XGhnRG0OdkfUFSDdnC/+TTHqfG/CIBBn4y7zthqHBmdULDFmzihO7IZCZ98hq00ZLLCM5d
o10ASUdqJ52ctyXej0qaqYQYpEj5p+zcxLDkgZmyd01PVme/9CTiHwk36YnrTB9FySGQaASFal6F
Fn9B9On4n5FCaOWYlRotIpLifDSH9VBzzxOL7HJHAE8lOWEspNwsIDpI6I3yetOaVE7HbzXssZfQ
YbsOaFrcBJZuRrmzZv3/s20j+eobqi5GDkPJvhhyVmn3tI7JvejBHQyyD0avvwVySH/Cg8k8r3L1
kzeunH4xN5OdW7Wdst5SbUTkQb3FMIjpSCsdEzcMA6I0uOacgnbguahhoOFDBgfjHFeIA9pSsb8F
m2peHuJ0urGGOiuD3qRLnR53/b+wfJNyg2/cbBL//VmFR3OWNVpjof7yzILvvX0w45FIFQFD+0Pb
BlK5nMTcpHFWwF3+/OFePhgpMx5iexwyFvcpv97cNnIP/3Zo3o2heeIRsiq6x89O0B1vBtmws7wx
u/24aHbIFOTM3L/XjjSyBqFSXedM99Zn4XeI7YDUfVa20+kNukl120UnFDNttKYrCGtTh4wkrexW
q+1btG/uLLYGOFd4+lLrm6GkGiY8DiHzuAiAbIpee2sMH7SHk58b6Lagxp8QtOiHpT+ZemQtlbOE
M9CUVDszRxSkoJJ3n60I+MVa8bopgbqplAxqcTcjKQQ71Tx7ATxGNTdAWXpcI50OZWaeeBDnlE8M
WPiFGmOG3+mDHF1Xpnd/40khG6iXKV+vL9v65QD0Pd9myE/auyFJws6DROVklca1OEgwKdn3IJwc
OXhhvNLDF8I7Z5amXJhgkhFyJ1wwTDr8qU6/ZaP4VbpmzcpFjH74H3MOBHFTPpBL11w6BQva0kld
0QPUq0GkUyqF4L+wb+CtkcN9hQjYQsTSUsnISSGmtNQJjyndEqbtJmww43DBLa2OhWzgF28+d07z
SlVpUOsETUPm1tZSkbIbhCcuS+Rce6d0l1Giu0mv2MfxtqtyEYUTElQX0NgDZh8Xcc8ZSafUryNZ
9pORvC4XgyH4BrF09Mx70itLeXW78Ynpuxfzq4cpn1O98OG0+np7oTxMFBbJn69ZMrHQMTU5Bk8Q
nUau+JUsi2G0qxJUy44YBzDgmtL27RVMbNvuY73+4D+8+sZcKA7MRn5FwBZ8oTZ9rM4q1v/NVUqc
pKsl30kBe3S3qECIYG7UxX1kYElU6wHfQzveL6VVF3bdf0gUNyFtphmHd4BIBiuELwuFuHCbjulK
jokiXf52WbvMCtDaW4N2qrfqt3u6YDKYRBc0399YxKGy7b64PXZ/j7bcYeAL9C8eMLcM33Zu3tSv
QxAo6UShLgRz6Hy4gLz0ym8PzhGG2fBahpwgOf9kaW7TCbQ2sj5eOaKzaSjXcoSSnVUL5Fk4WEhl
Uy5/+ULbKrzd9Y/bdwx98w7Ayrz/dgp8kLTyH32/zHGYaTsWsW+ypNLwmIIFQ77AcuF4oUl9ILxl
jvB9ty5DIYD5D4KHqlgD0wFsRr1IqHxCyftR7a5oeUPuE1XlZgNcI4HqanJA1CBIGmGmXzJhm2Se
20z1exFYD99HHYQ9UM7zJBwbeiS46vdJj57f5GRGMbQNDlOqwriLZiAlG+yi+FDY6O/n5a4SS0by
DBJ2TrUeKEsvJWxFd6hxiutsiPLvjkldZFiRJ4INh2p4K40SA5Rncw1CnoZA91UWmEZZgith1i4J
G+MHSDA7naeoLXr0Tdm5EQAQRxyki5h7C1PMKYMUrycSnwUm3ghFjuqERPIsms7vsbzxOHsEB0U2
6jw/I/ZOgWSbDaPPOIVtbxHzc65Vyt0yekLwDSruMIH6Ba5W32KDx9kij1EFZ83rP1iF5XjRANhz
oLlY7wGSzDKFSIh2Et9R1066M1kPUrVsPQCRaLDIOmQ0EQE4koJw3YJ56hX5Vp13LgwNWsd9ASJZ
A22PNd08i8Hv693HXNZ6CK3poS4qsNvdu8ap8k4kx0f8eJqaecO6NE7IiH29RLQfFLrYXtmthGIL
IWE7q/xailUqcscWoZL+/sc4+iZ84zBNQYnMxjjCbN4Uz9xMAt+zuXanw7TJVfJg1wPOVK2vr+6h
c2cXUjvPDkH3u5Hn3+wfQyHWynG2jvbYSsi9FtQS05SQO9B1w042sVrHxxAmmAbmWq67qDa7KNEO
MT1MonWZwpBIVSByPduFB1GEOb0SScs1sw/2kNx9xIaefa/eERbur8D72E79dj9Rm6a5XYjfsszz
ct5izJZXlu3KmvigBpcprhc3Vheyvs7OagLWzA0mIyqMq9ilDM6JPJOhR0mVePuL+8bjSjEJTHws
hsU4jNxe4XJPUuH2AO2EPW8w5lggOFhyGM91YEBIREwFbqE+Ee1lTF/frql8QM3+66MvrPd8K6s9
J6OFD4xdT4arYOvEbkcBIkdx4yTRbxeMheoAlNMyA8qBumFRPFFyQDrHH+XF5k9miHmbJX5vfp4C
gb0gsFSggXxinwA7YyUomLloJB/bmUnADuR2DDdZmGa8oeW8o/ZG038vxqWSqMnn+AM7JzYb7ZPm
c+D3ELZmg+vcNUNVEidamAqMZOd75D8VkZwDgWsEsKqwtBBlJjcANkxwPoMXiBsXmCzk3L1owaqu
tvqFPYOC6RVgzhtIB5olUnGBNNdwNZfs33u85WPd7qz6eBcI+EiJxDD0kWeF+qweYZsJ36onrmXs
tUrxATlQTW6GrPnejsnoPjl4wLJrYDbL+mnrg09bNb02T+Wo2eyi06Gwwe/9IItUE+Us7fVCgmL7
Hrlj+GrElVZ0j0PbmQDrOBlzmgZYCvR9Kh3SK6k57NgqK6RCTqZyQDzBkpOdSg4RbPfN5SCEKemI
OyTo/F0DhYgSxOJbn2jnN2+6afzllvsf+QRsw6HJTFPMnGjubB0b9Gxn4403jAlS7iELe0b1bEw1
Nlagp6K4vDC4xWl2KhhY/QJ3IxnLFrGZUIh5nmPQkd+eP3k9PHlkLLkZsd6InnjZiyIHy7W3VKf+
Xcg4+NYzqbG0kClLGsHAuIrm885zTi4CgW2UVC3Goi4rCngg4IPU3WkCqF320NMoxYFwSpCQTpjk
2cdeEWOXoPsz8fq8fHRqYf+yk16KGLRtHqAL437kX36tQ5SacO+BAXslV1kF1q8MQs4v/mZTrrpz
KLbNSbBLtuQjyMhrbd8NfJauIlA96IW026N6iPvqEOPLkMLI99pFyIBHy+glieN53hWNLCPtKRGJ
uY4wU8IoAiP3XdgvuA3XnIt51M3kmd6zOIvKpUmIKtcIHN4BM7kw5zoOGVqJryUFLAgcnTX9Hgx/
V7q2HXbBXThNCJKA0JsSXg/lldVnqOu3t1jbiEEplDwp1UFwAeX0/UtgbZ+Tq2Auccz7fL46J2HS
gX9LuOI3qCh1M0oPb8TLxizGwxIUfTV9iJG1hV0kolBxgGiNeVP0/AWhkyZhKZL8HbIVZSGkx10s
rY7B/0Jc6oHK0lYeciQfY2hcYsVjoi3ZHBDdeB9W2aIKaIPam1x3oy1lfGRuiRVnmKgJThpT29zO
/b3Im58HzhHThNvN7ccU+lR7kr62f+LD+qvCBg8sdb6YjKmu8d4uHA3UxoNakqtZohmR48fTBes9
OZ5nRGjTBIpjTp+q6iCgsAZrRk0Qjh/Pq/yCmZEvChmdJFnsX2RPsdMwPXQHBagYUUn8HXEnRggD
tcHlsMywClTKwK0uzMu7VNNrsTQMDYVW5CXcO0V+w7+LVMq6+uQdDiEcajWA8dsPJfapwDOIFVLE
gcu3TJA8XoDEvm7keKYl0zUR+/nMXvwDFfhQdt0567IJuwX3GWjm+m4K5oKfR9BdPIlM8A0I7bkl
fyh1Gc1YHczTOPtX+dHcWwx5HDmSkfOzXYrTBRzkZnfKHO9/cEEoDnZF2+zvL+tg87Ioz671iw0V
DVUfDP/Wrz1bQH3neWTPKhGy8X0yAmliMRuYccNzF596OENTKDSV9C2PsqwwU1+XipOKvBiQATna
b3YE3F6eNss67TzGgNgzZ9RiX14V/rHOrq1Wj6DrnhyOTEhCORZso/lGdDUAdT+yL2SGOG3n7jl5
5M894GRCgjgmPQwmglbq1In7bK4hpCw8UcsTpj0SIksOtS0p86Uj3P3TDoSbBqdoPYvzxglofBdt
lxk01AMSmue95mAuT2XgW+5bE2Nel4LD6GHLwyW+lCIMo3fv7FdsE+nT0lx9CR+VqzL+/EiGXxDw
SOePMlTQR3j+zCeEwpOFICTu1DB+UD6QBu5D2R7kxWAtM9TfwcmNnzMu05f/UrTxtnmXy8BljBbZ
TX0Qiy2fp1BjXHnCzbqH8JlYNSucDDBfOf5bOTHnXJmTgxDQh5qBlE9aptg3+vflQtv1oOPIwloi
qeUr5y2O0TfzyfyoT8eEPou/EjCdKCsMIogX/5sKLpg6GXAXBdCvQC2R07o6ffAeyFgQ0rGzOtf+
lgvUt7cyORff2TmotluJv23qh8p8kg//96YEPkFHHWkyfN+hyPbAp3d4LTN/A71bgC5N92aNnrJK
ztVQi+m0RnS94fNEKe4Ll5jgPKB47itVEJnsPlbWjEsf8/KHkHSrsPq3OGL8NfG/N/BeJ9An7rc+
DvQg2r1La/pppxRUa55Trih4k39OEc/NSV0Nf62f9fQNvelNoJPWXcTUfdpir24T8RbvbkevVyFO
9Bodn6qzfMPP5cubR9bSsIx7HW6VHngU1YM8fxP83S6J4ThLz0yo9XbaPPsSV55ZGHRqhkcKfc47
p/Uch6MSgWAYivBx0D3/OsqemJXSgqEK5lg07et2op0qDwYaEvxkj/2Q+diSa2N2I0u0jgCtnIEl
0Kn7Os0gADrx8+di9el94GpIoEQpNx141UCdIA5iDgtvrJAmwSeVjY8hVv2sT8+1tFy+KF6Kazq0
NpuufgFFBC9ImpVbGgTtygT4pB1vwXjBZyE/3m3oZyHmVune3Pa3264njeLPVqh38hZ5SogTip6x
IhjGL7UsqX4iHKZMKELybEzzPhOsk4YR/ohilZCXGfQlQlWUQRKmOEk1TwFkeHloSGD/sfHeCoo+
lfsx5xPpTgfKAs/my2DdZubVw5Zttv1osm0Y7yyzoRKY9YmAs/xy2lFmOlEc/cuBfjVULphisMoc
73GbwxDZSI2sHEvfT54uWDxaCUvSz98o2WRH4vNY5Uj7cb8ZoJgTU7Y38pVgKJBrZOGAbzmYypJO
Pdg4jWm6Jkzx1dguK+l5CizBm/X+UiikeQWLIU1sw2Vz9eUO93NGTwPDieTV+BuGAgiJaN5tUQZo
WmBJ48pmfVf/YS89P5yzZkjuJ+HDP8DA2bFly9r3zDh9iUgiKkWDmvzAdL7/DjxqYjQc5XO4BqV+
uOvBlODy+hEDx3Z4pFWLp1ItaS4lDauTXdpnmcnxlJQV2z/HpNfWf5pDW2/k7E4xS0n53AIKGi1r
XFC1i60dCP5R2XaezeQfzGSlrDD/dAhZt9t1yXdtjydykAHksa5Ue6++JrFkGaIck2kxuJBU766E
IVNKDwSW1prIKfot5hRURVUYVwdEnmqP6t1wjQbJLT3iOYYezKxbjOVUwd852XIBRxyzXvJn233m
jBcAiqTdwtd8gAs0k8ZMn82TH+yA3+fUqjXDpIjtTg1tGpOFb9V41ByOUev/GPafyOlWRhPSXB9D
ak0vNi4MrQRzFw1rT8jRs5sUCHVtAM60ied1ZIZHeW2fMfsQOmk3ctFf7gRUxqEXCKHeyWgvbGcD
1w04JO/O/aFyasNNRHVU3jbumntuT60BCaxSLyHA5nd9DzqYPesWXr+xFuor3bNFVJmlgyd15QW3
Va+nyc/pr4R6LWnAx6faXGujTSUOTqFCgwvSgIhv5qzdr5UlfBMvmwVGlyzqSpod7xcIhjHwYZdW
U2ZlIQ6owlB4a1qHNoYJ6YAj8aDfk6EvQAx+7YRNNj70S2LKI6ee/VCN07bMFxOMiIKopZ1oLn1C
KIlPb8agYYmbJBqFpdncP0Re6Bu9AOdFvMLGa8bDqYs3UUZbrdG5hs0946vA7GoETB08w51VCIdZ
Evn0p2RslyOeusWBvrilwNYXHfcLGZjGsf1Cw+e90COXWppYmhvnivrHxb4CWU0hwmavfucfCHEd
4LpKmdzRKeU1NhUHRsP47UswqL0NUUfUOuAekFZZ1t1bIlsY3CI+I6aBu8ddZ5w55jkKsiUI47p0
A6h2oQp/cUF5pE46Qs95Cs1EIrRBdouqE162AxTziYuNLfA8ihJiRRF6C1oofuMgR4KEojTdwZQ/
QImLNt3pocODTa81rWHzLSvATzdqJ1k3jKpm76ywbTQoxRaZAf/pvV/q5im2kvD1GZqbf35QMGcU
jAI6dkyCneASykuHHTJ1r/jqa5BskBWFEyg4MWFDZ1ba2nV1u5rN4WTui1zFGd4Flfu8g62aCnhp
V28G/Co0L9jkyhD7z4wX6j1H2ubHkHNOikRxGh+3pLoWqKlrbZ3kTkZWmQz795GTbIATdDgEKT5j
9EKJD/nXW1TPUidiUaETb0hX69QezY/RnH/KMg6FfgDierD+Db34O0FuDrLY9cqw3xBKN+XNrqQK
VjKQ470PTQvygh7TBiUv2S8aPXxQlDd2dSBtTo4oosHtJVXaM23KtTmp9KVmw6jdFGcQ7Q+K/e28
IxoMAAX6dD1wsH4UlZ1xnze+DyMi42DQomNlzFSeogEGcZ1D/uSag9vR9f4KwQWQNzLLaJV23Bqw
k/Faxhv/BL47V8+tw6XkjIqsdx8vH6Z2JKntsEk1MMW6FrEy+cLEQi7UcLUWoPcNVH7xFWbhvAyR
ZRkO90bweYrWFoAgs+018G7YSTqCscpLTbgpc9NGvbxMWVnYEOv1l5oL0g/x5zGNsYVs3a1hid5B
3J8BKGNBUxRErM3tfpcXa5DHzc/zvl/CX1RZlLTJ+762hjKI0qiO6i8jlSejW9yG0ufndULrruu1
vRmV6sINsd0QE0L4ep/NTmmhXBN/CnzFAxYI7Qv5idyD2I8RYbjubcoOtkOo/fWqVU8QUyOsHsnz
8Jppjos80xdTt12+WcA5422Jet2qdYNgyRown+CI/avgmgvHEu4f9pTk4bjSZMAW3FsaESWoeOXh
NZMKCpbnIHluJRkbTHegRPeYiYhJkK3APFIMXwHfvCuImqGwqZx+nHvthZ+bhrXDfizrQ3zBGhAq
VI6/5IDVaqqR6B0+UNgRwC6aGWO4zbm2b+wwD6VYq+9X5+7dZpZesDr7VtzAJnlRoVfe6GIH/kVU
szwiKma3NZldzpKFR7vbf0BmaUSy5mL29CjzWpjY9vR1Jo+2uGZbzlX+ccFoNCpv5zVFsO74HWWe
7hrN1do6ulZaqs4oMN4ZyiqGfYtZfS54+ENY1vIpuC4CumijmSUUfHIX0kYdo0TXI+AmLpFbGkL2
RsRHSsf19B3SOp5HSYK5UeIE7PLdNsPGTCgSn3kToTs5/6cam4A4QWGeaTDoBlKwLNcBfhtRhJ5z
zPs5l1+TZos5EQhD1ey9cWXc722lGB5AnCqHCJPq0NEZum+f/ZYdc7mjbk+y5YRtD0wFO+W/VfdC
E9a12ZOHmSBHjW4oqJ+nJunNn5cgzol/rAJqhpIrl+03mJZa8zGjg+Ls0cYhaXQaLobptuAUC+CA
gY0XGq3v35z9eCMcXEG6qNt7QmUeGjaC//BnOfzmFz8jpPIujLh6oN76ETxU/tAYxs/Ael1mbX3z
LZxzG/6dkXLiUf58IqdPZ4yE6EJ8BryojRdTXCcse9BejShtmWWitZ26OQ9zl9eIKU1xscrge85f
pLutAFp+PvJr4p2rQwflmGSt3by8nUIfXxDUAGGOfNzHd0IUenSgbm0jSfhdji9pM60jSenykX/F
oxQKEFSxQ8d+rh5ICdPKG/M+HAp8TgXTLM8Kq50S3l0fNDwQCPlyD0De8xjSdv8R9TbOpHeCSpzV
5/hQgDdbPZ9tvhNe7F/MS4QhwDLNE5KkPbjMtAI5u8TzbGjTAboQQjVwqrdi/5+6AC1SGkA//hSE
GWc/rw1hFAy8TUO5RLldSd7JFYz6dalWwNn8H0g82wPUbBYEKrApJv0bUoWo9Ou+34ltoU+K680L
XQX7XnIxsr3HSXRM9cyDELaFqPUT7h7qBozxNjY7hdVupEozdENDs4yAti/5mBX5/scCE+xwzR5H
OloxUqy28fhYVlLhK2ZRx7uhhHqfxzMTu2BQJfVs03Gr071GQdLzgFwasBzO+g2X5eHN0laqI1uJ
aWBUHLKM6310Wxtbf2SzSUrRs6zParkRjcGlK85C5Hw8VuZyq0FxOhgwryuu0Plnb3zjVqWszLvN
zcK7eBwNGiorSX1rYEKXAb1x77iKsv4DunzMiVYaNGJhJy31dRZHDtnyZihwR2Pi3xG2x867GjzZ
oxZkkjMa0CfFfEjX35H94mfqqv3HtDuHmdfof6jrfOM8d9iEo6CE7OdPbomq7uFCW/d2/9sZJaB9
ZFZCXaSTyy8PvK+i0oSTuBHJhf1/GnnxVuY+chCfCwKwyWQaON3NLdxNBkOiR4Mkfb89hfpmcKnY
1BjIUv0SW/TfdKxrDiexJErGYAwYxJtUa0BApsLGICithf6FAEJ/U51RbG53eEKKQQOclzHRSyLV
l3yF3pNK/Kxq1Zhei4G/4cOtPy7sr/13Y5I0CKEMakQ31aB9s01oMGhuqcVlqT26tvhIyoQZsalW
qZKUYuokx8Nf167T/Qr0apmsQN8fjuMrIDbiyOMOQ1LYE92JtWhIEKQ+cfrZCsK9LD2x2/M5fMfa
g/G2yPGgGHUid3fi7Wi7QEjEPFEUpFYl8fgWe5fp+cgTKnqvwN2o3peLVFEp7/83pw1qkIrPW25c
g/yfmJDJNfLvtNEYtbbZyMHr+i6VY6RzCLEnpq9Lm5DSuytB5ITTUgs8v/JdzbaZQe+TwoEIpdIB
Xk0MT6AoqCxfHWYjUTK3MX3p9icldpMcbf95hvOBePxB4e3xA3CEmP426iEGOEbv3XAL4o+IQM5V
TXTt1dg6pHz2BpKYcefj7gOxu/wWSqRxA/oInaCxIQ9T9YBuLsqYg8sFE34HN6ueRsfeD0OTYmic
U6KDwvISoYkLBIAJD8Qj0f/yYaVTs4iz5g3xnpXhh5ffTyO7iub9xxfP5oZ8MoaE3jcmrpeoMMSH
WaSjry5gzd3BZ1an1z6az6Zi9C1140s5ngXoxG124fFnTzuPwz+sdBVy66FMW3iLjgc8PiLIJRN8
alHQo3x9Gw8IURIyehXrC1owW/P+hWl1kFIolG9IxMkAHb6DGXr7XNkUXKosMu379Au7NhLngVLD
8PKRfBZfTPwfG4HwXc+/kJvZHqiow7cRuTFEI2AnhwNcaIH8FkEj1ERZm/WqkFhRcIm5wzEoYjTC
o31URQ15eMNQPLEBjP6tJOs91i2sLrJe+Ao7V2oBsrqo5szv2HRBu6KOpnuM/D+9HKh3cgcoo+sA
qv9kDGR2hqDWBu4aGyIgEV9QUzZJ6Q7woJ+ZKGSJIciVKmahsQj9D3vh5LY53bj5C7UPcGn7YdQm
yi7R0cjYOKbQoZKtCvso4l+75NJWKETrpOABPMjJzQjoth0B8q38eEcpFln6qPpIKJi0TyDY0qZd
j8vMYvVcB060jzOslVqhBbmQ3m6DAOiQsSDqpRdohY+8CE9eZGHXc9viztr3gSW9qbTfpzHExxkJ
pDusJkI9kRyWI6qxdntqpBRjF12cDU33uZnw/cXFnJQDMPspLHsLoxm5IO4H56joAICO5nel6iWz
E0Uga6SiJe+m6Q5V68aQCUqQeT6yvTx5IKXrLnlJwgcpMdPlAOZbIg9xDt+ETPeud+Bh9DM0Ay/M
8EInN8yMtvYdpObBjvrTyzXYedyebyB+FEyeV9Ixm0ssc8HGP3+d/hephCfxi7E1YDfbpvZkCLxx
L4eDuAt7rZ7Ps/MgzjrvPX+kzQigdI8vNx4g7njGkf1OQciE7vL7w1V6YWCKg6ecOt1EeR9pLk0W
20SRaDGgpDD0NDC9FzD/YiXs6ZEePrJK4hNwBLyGYsBVNMlJVwUqIlQUgsXFG18wloID4bkZVQHp
+XqPhfuFJRpAt8D+x2cW/DT7A/QAYzACZlSA3TvirDiVy/Ay7K5BpFOk93IG3lhvRBRcfm0O88e5
bKth/ftrioGsUlJ8aGCxAnGP3pnWrSDEibbWwFft106ewx7zQqYgUXQuZxPIU4EvFWWdo6dCX8g1
yJ/p1dAnra6jo7yKYyQ8y03YDZooV7muv0SvxCSgG2Wg+3ZTTZ+48qVspDq85U3ob/SmOr95cNr7
p+wzTkjvMHvqDKkaJiyntYAsaxC0/CsP9uFfIhGwejXkiGUWEZSLGAdueS2zf20E2BRYybf35iYK
DsgEpuTL4yJqcRConh5HAzw0k+FSYG51UNqG/Pjabzit6Fs892P3Hj00okLNVAtPgxmqhEO5xHgO
GDqhllruLYTdOqvccZjauU+03OwFdwI2oyMmbH3SjrsQt4IRoNSGgrbcqtR7s0ebV+bSoHpd3NOG
AD567k9sLDaMytaYM9nfCUomzVjtH55GnDZ2Jj4VmuI0AytdPE2WYLQmqxJl5bUXjHCYzd86bKET
fLR6Qx+H+EUunFFQDlg9NUHxh9lgsUeUv1galQLidaNEgarNEOqIiKZB2h5ZUc99odc5uGfNFntr
4ANzwqiNf+bEu0CXnLjAEfoUkiyl8uc/GNjPzYORDeNIO9+i3KySz4lea06T2GW2P0SSMHZHKjhj
LPxesS3R0ni6tg0eQPkyBTwDn9/pROhuS8NtLSBD4UbYVLoxS1HKrWDyPicgSPndwNnGDhTfwpsG
IqZb+imYywl8IF/yRM9l0+kcAK/1zI6btyCo8m2DEYuoQM3yfBjW4tYQ8rYvcIv8og1EmJ4B/S25
cL2B9eV8RK26sidv7eBF7OaEp8rKqmuBYJ1bLKe36Lqyeft97VKdKuA9my+n9rgq+wbT+2+xFqjy
zPR/ZsG/lAsOtTbL6pMx9oeuxVVcEuMFnI9JcsJ05b9+2qBu7kwE9oviAe3nTf8c+HfADSDX/NH6
xJXw6e5W+UjMcGiIYXcZCygYbKFlDn5euBkihb3Pji7suqtRgtRcQmxoD1MSyYQzQgb6DwdvrjCx
ScqIcD+eJPKIGCZbDQo3RPBbbXcSFAh9kTwO24pPE5qSu+dzRovKrt7Hae2CRaho8Huw6WOohy65
JeLLg1eH7u7tJUdCo7kjyNq+BwczjhPvG4wLgY7/28kSFfUJ5OlgfVH1MoNvpKMXUZZUNLyG42vn
XvxtECOWxOvJLu/r47A7ww4iIKa0gbaRXg6F0JEejKHh3ZjohmCZpZx5DfPsrBICu8FIQWTDHWsj
J/4EEOJFCHyDh2y0MkCsEwHV8j2vyQPiAwN1Jsme+bDM2awfjEU8A2yKIwdYU2FkHLSaitxVfcOm
gF4tTQgkgtk4nLNQWtQfLTpKsvp4+uIgkHa1cyYuVjPqBsRKDhyNWl9On85kZyCPd3A2VEhUBXLc
YfoxQvNRZYIMMLRQAR+PhscKE+QgaPBiixRFyaniImsVUcaG5iHbRko9iayCOVUdO49+HFNTI4OH
UKGVBhUx2eAkW+bHqbwshiTuKyf1vr8L+QYHMU/T5i+E/03x5wC07qrNSlSwjkoH9+NxwhSndKuq
yjy9aa/mFJ+h6VGJbltyOB1zHfayW16c4ra+dU5iOSGJ2vVQen+N2JvPYO8YPnxuozhfyvgkRFlu
VNQh7XWTz6UlqfehPONejXhVEJiRIB+sC/PRSHQ4DAO7LtwrxKp8Rij+YgGTxzD5h4RneTLVq6Yq
DuatUM21KixutELoaLRfF85KAYhOv5FP9E70Mr1ddvFUsSpoxljThimjVOui8mGPxwFYbvgIoG1b
YegrPkAO+e4T2ci/WgrEJAOj3G3pit+YAQeIqLK8li5YNALYTB7DeU0+bY4uximDX0qxOxmiJzDU
d3wEeYlFajBa1uj56pDn33Yt6n7y9V+C0bK95b/rJ/Mdouna81lUg7yjxHLKE55VU9QAdnbkCmxT
mKtBxPxHtb/D1/PZK0oA6r6VBKuftOvUIUoPEnMu4aYjVDy3q+9ezDFqQrnV7d3C7YNDYOFHkg8M
Gvb8qC/dIDSA4YoBG2BP2+G22NwBm7QQCQU+vyfuNnwvUooCd50x+t3B+Ljn92cZfBbm4ANItfNi
7+2NiJBncm4HHhUEjlBrVq67i3T33QhdbyZtyfzuTYRS+Ej8KEUNkdxJoIlkg6MJMDL6I+dg1IPO
MsSUmPX2PAmj0CNCMZiqJFIR9l4jWwJ4k6wL9U31JNeZxTE6zQney/3b0XKDWmcsaugLMIRK5rTH
IMmHXXxxHQblKSnTPnDkO3AqCvIDLOCJlmTCM5c8Y7NBxMGAi1OnPgD3V4WyFw03SW+IoZ+ynG3x
9aX/XKVmJYwab6A/nGm+i72sPVyiknp5BjFpmzNBEog4Gekm/nnNqd7RZvzfCbDkZoM25cdOHX73
yfTDGNqoz5VgmuKr8MkFqoZj1p3GlMoKAGTtK01DLQjlYGPdtNbumrOs7oc84eF7S3xxxwFnryuT
OYBIn7Fxh0erOZ1oRcR+IAk7q7gC8eLcdtKChlEwjR4T6N3ISQ98FYOkfJLIDVWLv/NFENARR10h
vCEBhtAlDqmr+PvwGTv6tY5LxQB0zBfc9MA31k6A+l9rh1GqhUkJRNcOyzs/fSjFh3eNCoqD5aCI
1OqG9TPd3rmAr/37boXI8+Tbi68gYSdtVyc6h0K4dBWeTj9qFF0r3XVaY2sdbqsXjtj/IIFYUUqI
BrKD34SSPS7Lc5zS9lMtIdai6dA6In1G0B2b0xCwiPDPlZUm6hTwJR+DjqA7Bs/xRBnvopFrwU2B
pjsVdLNzJ+9LZZnPTHlLCrnyJuPnAz97W8B4bwFDOTiWB3hMNa0ZyR/4U5LacI+u3l7eEaZS/Yhz
OkI09BZOl/rH/k9BltOAGiX4qbTAXdkGq89w9jETEvFfD2vQOIeHrwdVu2kTPMH+IQd3RWjBOlF3
G2iG9RBcYZhtUI3cH0e4Bm8ClC+sq0RPg4ultJqReoKj3PH8x2jK8nVljeBWV9p5zCrKonqp+9XM
LqkJfWp9Fla4fNtvjUk/4119BRoGCl2dw6le5aNEudiZH7RyRZqXuwOMIYJ/HLoXRnFwiL844UoU
eYOUyoyfERxD7LMdqPNgZJzyZuMliiYu8WERlpI2ybvD5hTTgUc+UssrlfRvgUghS4QsbfdffZOe
eCznOSgttxCLxbSFGKPu8UNvzRkw865NE2n24em4kQx3l+kjQAD1MhslBiYbccfjWhrSHgBuUtnd
PuEvpcuqa7u4sbYww8/rB7ufFJc+l1wKlFcF+I+JzASVGx2iGlg/9Lo9xadArihOhgr77Por/4UZ
QyH46tNa3+lL7dNCYY1l9ovnmoX/PReko4Qo64LUsZl3kQws/nPiDRbuhIxAYPo8WY7H7jMZ/iy1
G8+vFXKKyzt6FPeQfE3AceqiNS0YaFzPsnIggNxXt1i2UUPfCo//luVU73Zv3x+4w9Y/TUaz/v9u
0Y69vhC9KkEd8oWhBYKXIwiqi5VP9CLTTcm4UJFFpUqsVL70VZFY4ZxAoISoFeAe5M/Ta+NZDWZk
ltVkBuoqJsFpiY6nv/FR8Rbc5vU6TFrlYuNOThYNRWhVRyq7xQ9nP2NzLE4gXF412QqLv3+l3IVV
oMY12SL9jm+J/V9Qw6UnIO7vGI+DwB3cUNo0T5p0V+knfCZVbv8Nb9QVgSKLnMZRixIZDayGRwRO
kJ9NpG2P+bM8CHS7BM48ZGYtBHlqblYc1FfRy++SgjPie0fQmKatc8jjnIybbi5jF/dLT6GKn95/
9vaS16RM24ehSCRlUm+cheLt+3LfiCW3l1uZlDIhq1U3IUXAqY7goJ0DCsRS/aZMcmzvWaKuN7BC
zyes31kihSd7VFhBWmGu1S+KiSTbbJMGE4n/2I2+13+1tak+9WOapiHIdQJehPK8+MKzp5/5/JDX
dy7s+LUHDCNIPdVIN4PEdUV2LHMnbmogP2p52Z1WAY/2ysPQQHKccsyLrXB0zsgGgw2VXOWTKEu6
yge5N4lusIvJDawnSr6WFdXeyYQRqs35OD0lWdqYXfJ4LbZ4A4lD4XRX/XVmwb1pkjq76GyFwd9z
lt44PX6JQvsh/+i7tkTMV117NIzEMPe6R64Wg9Vi4wsFkgQ3o2seTBUXZc00yDareDkKHKW96wvL
Ex2p+mY7oi5yJ0oX+TEpPu4sj0lQxAxcXwkAC1o5robqWLMJCEv2nFyXeQR8L4Qc0Xhow9oRNB1h
NLgsmihYK+uP0lVX2ZzEo24dr/QfSzji4v+SqpVjV4UumI8PFqKbrDLPynetUsERKSoFKiQiCDcs
fgJrBHGZiyVIOgcJAanZwqxb/h/IED0Rq4yXRBAy3dsbM+vZenaCZjtKNGNUErBeev0VfYIrj4Sl
1CkudEqtL/kcXY7GysgFVrsPH5Ar0Vclt9iewT+y19zTxmIkXw+vJbujGvAkaoLXCoyowksWBuJ7
ZqQic2abzhhyeofLIFGl5P42LW/QSQcBgBsPpE7SJgeqgWd6E9IRMiyxHAiXYvPWnyke3E8FCoxF
KatGa+/sazEfb2U3kcSBgJYadmJQfrlwJr/9+4hV4a0FdLtpLZBDtKsjomG2JBi5jgwBC9y71hI6
0HZXy2I5+uMTe11pOMCqYosboMK8g+ICwrWZbbXTJOU8gr9wTcBdwgTCL0w+JxKP7XhTye5BLPtk
9BibGVb19ln63xXxUCY1TArh7T59KgxkENoNw3i96EKOa7cQNZ9UUSMs1Fk18PfgUw9f8NSCNFrr
r/W2eq1nkQPczU5HvWE//KgE14GKXLEIOnGYOb0xjLUdu9E/ez2OzIeOdMzM0CiWA5Y+h2spSZEa
eMrQRIJ+ljeLPBIOuRsWcz5/AStyxX3NZhNSscekZgGx1+XSglVc51nJHqkh6C3dfCRD5cTG4qCt
k4mpTCxdED47xFo69/CUZ9pZCJLyiLqWtU+2HL+iHyWVDAxjWaTKvkdMhiusFf+2j2u7j58H3i34
r0Dsc10ax/umCOeQSCESPhGPNT/Dzn895jRCnUHjYqgxYrDNesAF8R0gwRU2dx4sD4hz4m/fs0sK
uKBRrvCR0hFci74KHZC8OBlB7CXCUt/EJKx7ywSP1wJ7bH/6/xOWObx/SxZ8jY8WIN2gO8DC/jGL
vkmBvY4EQAJ6JeRzvyh7vl1ZS0YmVZVfQsER3tbdr6QCJt17vfdesLijyLBGAZ78iAp6cMCufAdB
4S2PkbjQ3oNomIRnZFHzwP/Ey81ocYU7uq7mFgWm5d3tatpixx1oASO5NOLhAsFaNbykDshBk5GA
SmTeQItjXBXQHUUAlI2oCzClPvYxTcQK354R1CW4n9jnLfFDcH1xyR+tyo1BtHckgwqN92G9A6p9
VbuCq9Elx2VGyqQRu8+o2GLO88IxyZAUassreAt7F9zdWwsC+IxqLkgCEyAbR1jHUnY9sQ48hQwx
WLxJy3RGNdWcOkt1m17q7t0jPvggWBSpRz7Vxatl5HrS3zTA4Yy6qz+tiZt2EDQ4Q6fWzyEzeEJS
OWLBrkz9TmvTuGQqiVzSbpSOz78TuE3wvCSLkPYSAqAr8bn8XDmoGgWRGYtR1QdV0I5GbZw/yuMO
VbmQ4DIEFxr+4re08VqRDalvmeCxcaRI14224WPjc+Y59cjxP+7K48GmgQ5s90ea45EmQ/Fzfr7l
NHVAF7qG9mZL3Ek1pXteO/d+9vxR5/Tk+pxQg4rgKeEx/bqDJNhoqpgFfQQa+RpuyM5KO7HXEj2A
ZsABEdJsSVtLipJeF7UGJI9SEe8jRpVqcCLGBsE0Q3NvndwAGHS/1CJxMVJXliRe3IwqX0Vhlbcb
nU4ZOTZGpoDmHgMIe54Z3bP718ad6fRTxetkOFAKI1LkD4ivqasJWWhubRo3J9hbP63tIfXfQAO6
w/UC6w544rbE6RpkPR09MibEnrza/bTECnM1kgcryDe0o/mXpWwfSjYWevHMvSkAKx+366AEdAta
sZ3kIRSVTTRd8ixY/9vPWJ0Ba0y6LP64KRcXcZO62jGm1k3yCQSg8NDNZnXS49J95ZRgr/7Z8BKE
n0N1Hldq5X4cqUcT2UKNCdyuWuswAjEIQX0zh0WqOW++zZANEB/L5Dem93c2/IL8Poa25zVw+nc7
cGNKnMlDh4ga4/saMcdl7V0hgijnbq7LyyYySWJgE6+q+uHqK0I/5aTCzpKzdgruuG5hjjVBwF52
F2sYflaejRJ1LmoY3ZSsRyazlsF7UliouiluYPi+6fi7I8nGbg0ECmOFGnwZ1XCLeMqv/43ITRBM
P4kiES49cfLCSp4OGeetFLVGsBJEcVbXbJ/ELKoZddCEVGAXR8A4deQq7/RukEiL2acijzbG1wbF
Jl2mbsWOtaHi61tpppExhmRE3i17BhoqvnLlU9hsv6+ButXBKT2J+3K0C+MCkZMFiFw7cG0POQsK
LlxMNFHMM5pUCHBtAM1ZPpNgcopGEQdLcTiu5QjQ5/ahGE/qL88uQ1/S9ZB9SAJp+qbWflJrdf2T
DGIkop/bjpCc9y9LRTv9joiLqFuZVV3gupwt52UFbCVYkGqirNG+0N6g5bUvjj5AJ6LUhNHp2ESJ
bP6O/oScfYcwnpwqblWEmS7/HLQlUht0FbAnIu6y3q8+/ZPO/KZvHggNCmAaDhVE0qqbWTMglY4Q
Xn9yOjBChDrUp/S5AjYEEweUV7gAMJ6YYkvAV3X5OFi7yOUbJhjGsSfb1HZn6rsrKR0tbkOhgHGA
NWjWdraUy7FRF3ZumdASg3TJLy9+rebVS1H/VFBORoXTgCjfRHCGZh2dxyqosC5jd38OGTnUlbCd
tln8sICSlmvc+kZVEhfXkYMS4T5DjtV9Xhauln4qfzR8o/+CGkKV00bP0XaEKlE60zMouhQ7Awyt
TfELoChKJF+1xiEToucUnjhd2H4HICGiA/d0847/WBqJqJa45Fmi7J9oVlofvmdV+MNRolfx4pxt
skX/Jo3PesONnZ9oSahDD1CAH/Pw+u2aO2KZ+zG+wP8KKGq3iTqsjNMRD1fxvUyqG9yrSLj7LBC3
gwl3ulOR+KY3FxxdI/DFh0maIt1khdb41f6e6jt42Rp91Y6PPEKvolzEu7g60hCu0JsT5mTMd0S+
qInjv1Su/agT/0ayhDigbNcIt1x0WS5OvNha3k1B4cbjW647dEZT1mMiw6yk0UXrr2i6odl7yRHN
uF5jEUyauLipEp1wb4g1ljM1bQTmikT33/Kh28HLbl6eRGf9T0Mpapt1qp/C6p7p8hdLRLuEEXVd
zUe0J+EMnK+zwBR7KSHhbb+jNwic/ygSiVhf/dDrxILG37Ctxb49YTym/jZ7tqGCCoaPWJHzv2G6
W4hGzS/JN4SLAJg1EqhEAY/rg6uuvybJQ7CdFQ5wMwKQ8qXUO1CO3xSp/MvWST440pd6Mq11grYA
UNMAB9+Wlx15uMriEelSjHZrNDKZ31ryZbEFRqLubo8QSgfdEkP0j3iE0bNjeokuw85YLguM3vvN
3rab9LVzznIfevziBuG9PycQgpwKiOlGOynBvX0PkAintHESi906x3RiYeOmqaNt6Kvk7byoEahZ
PE1LZaU25BJnIrZovQ88GPjlOm98kSHO7rGvoBBUyU1CgiTAo5i81IAlnIIGOui/xbnNrbQaRx/S
bpXzgGiYXqQpYDs1ih5vZG4SU2MOjcoVHwCu/Etbh5M28PfD/hbdihFDLm/giUozz/NH/aiDV3LX
TQH0YvWA5N9zp4Tqi/fu5o3vPlTGpMrmqUOxTqljugf+H0Vvj8Wan3irYomi5MciI1EikjumPQKN
Hv2pcDCbK8PoYsi5DaqOReMIZRdUdmQivWJtbEgtM1+l10WJY+lJnP0SatVgRta5haebbpldUsVq
j7AYIrNsHsR1wPDqAaXQgloErfpeXmkll25TL0fpjrOvUHWIC5ASl8jUS0bfRIYnRDQmjZ8/XNHl
b1oVwYGNuOFSxM873tcGjAtbQ834hEZQ5GfrCpXSbEdxgTaK07+bku1VJSUOK5unAMAeENa/dT9w
mVKk7bg562UI7WetrrAvQmLMMkUBgsm/Jc9ftzOzeCaHbnWzxi6jZpO1aoT4Xi5+Qi4dWkbX+Mmj
v7jMEQdbK/tlIOBFtNTvYMvVc18bVSTfNSK1Gzpb7lYOH4cjz76e/x1ZOD+IpwH2H3FDh2tHjFmN
Uiw2DJ9cyV1EwaukNA87t1BVnLlgxDOko2ia1+uBWt5Auhkur5RrSp4A/gkihBUlz2Om/TFZWNaI
RtwNi6agi0qtNiTLGQcQHjK997SQqeD8HsohedMDivjrUlhU0A7Uy+0zaSJdQh3FzZG6Jg/EtVzf
VsEgGWGIaCfsleXYxgisFQFh6tMVSk1jF7Y+9NR9tvpM8VvQ+ytROuea5BhJYnHpx2Ji5rejOlqo
PHhYXhEsAVmpmxSc+3F8CHRtDzKxMflyBcpl9LM2oky7SCKWJXmmKa8iCLIryFy2gE3ZPx5XQYsX
8QMA7hmcOV5Qiqk+54QxCRc7kV+xop/GmqvkowoiLcDmf9LIBBsXy0ttOwLJjmS3hCDFuK1txGkl
Hu251GgFzGABhalE+8vjUEjzN2xGYehl0ut/8IFovnl9obvYJUDXUopqbKPJWbW6eSMIBNNRLFiI
RlB4nhHMRZ1Svh/cByQmrOF6jYctL2eCpd2IF09Z1ldMz5SbFO0uLDfWmbf/CvtvMBjVTxOx9geD
IPj198gnFmRRtAH+FCantwK+yKqyG+iUrzboEyx54YuYQV/ScmYfByMqNGfkluK71pYNK1ThRDkU
WK1kN5mbhN2RF3zu+S8cpsul+G8JWawxZ4a7chtFqTyV9gWzni/EYHqJzSQWmhCwY9Zt2xZYWmHk
QTgPFi0i1eeOai316hNdqSSj7fBsqDm3hfCw2ATMqPzt7m+V2Ka9hlvjLOo1I4iiPcMYckzOEbLS
bpcDnVWZrNLtDh//kGXoHabE4u/Huv5rEYMFpKIJ98LRRcKIik4MWnjn+i+QlDmOa7GeX1unga8V
B+3O+9JOxb9OLMwUxfggoJp+07Yhw0/o5p7UlkUBhnwvNu9h8eSpfR5Mh+GWCYKcJNKjQ5CBxMpK
pfHAEbMCC6dbvlFE2JD6iqV35WUidtETkz4CO8+u4jLFsWefXj3aZvCIm+Vi2TXnmYfaS7Lw1hYQ
tK0EXFNlLikes/YIaZsIEjNuzDZXSlCpw9e01imwSaucTUOyOogwTRwcEX2JGHxiygdoFbnldHyt
hBPEn5FRpJ/KxbU7pQiBvOx/yvRwmKaEuoQFUfnSkq40gSnBsFiM8ghYvn58uzUafCwxyFntIFLS
H8kmt4XGWplmwqBYqdZTlHzLcFm6gkGvLxvxhlFrp6yhBUT6cf4RbVK6QRSDAFoXr50IAoVyYVts
9XIVFlcHcKwRnv6xpYOn2MqK2iMBMEnzByYK+eyKkCz+nuloe1eT8HP4IT/I4dUmHfYxZnCUfVVy
mhuOut2GW86sKH82fEiFXenNXuwuYTD06nwYAEx2xoKktnKz9Q22UyNNlsmh6WRCrztsnQPm9xwA
iNYLvDkJR//FITjHjNvYo3Re08kvLN/WVp4G+gYFQSsd6EthbAlZjfZc6GoDrK4H2Ebqsr2ZQlC7
FAlIET/HkZAsATVQPx6nBinFNZ5XAoxBS1Ya971HRWHag82ziszJ6txT8PYnGzaCCe+sDxytM/Gx
A/Ix2xvigQQiZNXBo/Xv98wGwgYobdPtJIHWZVEbUIY6dH3QwuKe/M3Xlu4PrtYMRdJBwZ3CbLDA
7xOlfXHnBIgErRyUZSWp6W5q013tVBm2V8KKHeHoCcKMQd0GIf9jGlcrPM9Yd3xrDyeIB6ODWLar
QKpkbeqKo65LYs4UXAZ5ihaIwC2WE3vTbenpfAGv7rgkaPYkgNaqWmUMwtpn4aQhHiRK72b5iWCF
PzFGBV2dTWv5uQCzWqE4r3BDXGV+PH3iEc927Hd//DDRQC/qYr2910ZcQNVZwKEL0J1PkS3ZLvWq
V1PTjHTKGYa1OVFagTRputgws3LgRrIJoKQaXtKlH/iiODEq2sm4/2wEOMMUcDEUwEgtaOgp13nc
bqHChtTv73cAnlbvla+RONBNcXkr7tFDIZ9Dy0LUuwA+45I4jRnSMXDHdbQ/1vmLbC+P0FqTlnvW
dIzkBPAB0SJFVB4vEyHTfdgcSyS6nKvPRAA/ZTDdpCXr5gG+qlttCDx6CK76l+hTu5YeKqgh82fJ
uPzN0YLBJOMdORrf4mlD1QUIlENca39lhTGavzbHynAba2UjOyQ5ySm1AH1yreISEHdF3lj4JwAc
f5jeFPFFDMYX/PgMg4dasMwOho1E2x63/RUqUSzH2k20MWxCmgTR0+n6QPymASgw7nn9JxQUwT1b
8k7dRrByj0qS+/IIvuodkcaL09z/GbTjBQruaKe4I6KG6UuFoOYc351lk/3GHdhZ7mE52FwHdr7/
rF+9kJo27CnUfIt7b/2LCU2Nc20Up90NqvQK6nZRFWuvA8EtRNg4WPhN8wbrEbg+maCQ784ewaTp
SX1CWN2URyiBT/HJiRGdhCej956HFQQfB23xcMJNPJ2lE5oYCmn2gizNOOki5sYcdpnZu2A0lm9f
zQ8zd3dxd7rYcyOVR1bhR9KwUTao9XlUNcYIecmsAZl+NLlEjdY2K2uGYrS+/5KS3LTRMK/6Zc+W
W+kCiqA4gT6JGD32Umh9dZNDTDPGrzLLBClvLuJ4dRUWNSaXTyNZvIDqY2p9QugCKQUaOyhIOerQ
GCJupZhXLG/S5lOs258pPO1fpEfAbRPAeH25COFmPb+Qgy/zbzjL5h/CxiXaHG72GntcPT4UPkH8
T3zjyoUtPpB2PGL/aLC/dBR2+IcUHctGZfzN9Dbd/LCOOoWjvNa3fuwbJ8Um0O9mDZ++uffsD7UG
mefshOH/IIXbGXbY2jCnl6UbAzbCmuXa/QVrUan+hrujm+2MZulKGd3XFpLG3RnqFKrX4/KOF1QN
F7xlFrMS5coxrV9FRqM5uQgyHd5K34bnxpK2ZbhoVnfpnofhCYs+VpXZLk5eL1fgqXJjsjrf1Ovc
ukwIlpguOUOcBOg1fcc0OgSTnl9GTucdtAwV7RjZt7OVD+JKg428VWP5IkU9FLl69gFFQnsORDnE
/pN545mBinni+fBM+I8fBFGr7G3oj1fxyytUfxMqaBo6tF1NYRSw4ota4/00wughRsyCOGuH63TD
ucg1LvDQ14RGN4lf26r0AqcJSqJPzgZ5GiaCW/nZaD/S7AzQy0wI/VHS1fJphZmX2Z0J4ad8YOZ0
Rhz4ojJIa6ZbnyETVyfwqvYnpU67edRbrRLvYcNpWczc0DnPIryKA7IuLJxUsyBUaq0IhOQki/Pr
cZxQLNrZcSRhcReEBAH7eUfneo6DdpJCWxLtTSj6xb0uQs69o67951ThhQb0MQYhV39Sdbxh9xEH
K8CbyWVo/H1+293ylrPQRhQiYfWL1Sin3mLTS9ExaoXQSCyquWtSowxjs7HNCchNhDBwgTv3dUEv
iXjn2TdZExYNwFyn94bvdW8Aybe1pCY8hiDTch2nWp2Slzb+unzvvu0YBuFEbn0bdFPt3DxOBMyZ
MZnlAr6r6cRcqKQ90CQ5yKaeeuJm2q5mg/3X/kEcIhwJxAWDaQYJi829OiWHyeBOHhlWknw4NNqt
cv4/sKOP3UwhbyeHwAsI9t3axjFJLjC3Wzfb7lYCgCnDeXxq3vDXgLBXAMziwheSjwCHOmgjKWpZ
3cmmdm8Z6Dp5PFoJBg+hmVXrExoS78kLa+Y2sF+n1qY/cShJ88B76wXl/qQ5xihNMfkgWG/oJlN8
/KiMT77mxEfbgTn51H4kGyR18eesiJxw+6SzQmxgrsUlKxt6iGxiAdAdDYXJfSjkrWuv+vrOHUgV
ztw/7YiqZ5VLWJ4WOayFcQ7bZJtmN41TNOLa8NYmKysrw2o3m+vhpBrd9QzBzTUf1DHGD4Ab2urU
pkFpvIabt7GL8qDev+4EZXcmc7t8DUgWLTYO2WlyUxx9L06hSb6tsfvtmIryFnZBHopuJK7tY6mN
cWcolfcC2NXRLOvD1WV0giIbCoPZ+KM9Lxg79T0Iuzr+fYGVI3dDG1EJXfes0xwD67tmAJDTmzLI
LBymUD0oVmvmSiwkMQLM4+X4eAjMmk/nxbDjv4384yhUYtq1RoHVLbpYzpHtkLqc2fb1sb26XDzx
pjtrlxRX2EFCvjlU+n8PKPMb72Yqe6fYi0S8//p6s8aHAGASHuMUkuKSNL62w6X2STyKUecwjP+n
3d4v4MjfLujJMnPeL7UaMz6e1WxYf2LK0jo1fB4V2aZfTP2lwIQ6GWDJHBLBqabcQUydC4YQtpGU
P/ExrBvHRhOojXHLQNMK2MyZ20JQA2Bm7dz0AMrk+7Ok3y5bzNmK6CmWxteF2kZj363ZDEyvEyyF
j/9cuz+WZeltJkrmNPo930BlpsjNPRUq7uzWJkrn80mPaJ01MYmIH4Vf6hhgAzRqp7nxVy/pPVTe
vSHy8MAOyW3/oHLaQ4wPgywzmqxqrXL8JiB7YV0wEbP0Dvl4N8O/FAKFYUiHXQMVh0GgK5gE7TAq
w888grwWFtbvzByW3fL2jgmS9pD4kfvcYsNSG6nN0CgaGPqvQ+EpDmsa79uPKTj5ct7FmrsedngO
jSi5/LnXE0S58yE2q86U9Mc1AgI2U6HBAlueOtQVBYRp9Ho/GzLyNZShmtHjyXJ3Qunk76zvcKBW
8ok7xobg+BkfXfZoZ6guY8tOZDiAJfmBTFAPsdSXxg6foAyHcCKZFR0YJmKkjpMhEfkFy+4z3/H6
NSeNBIi5XWK3V8O2aAXksfW1vLDbNxXjUmYpVmmWqpQr5W8Esw1r6Dcj+XHbVjmaRyUSADh1yKUq
46r+Dyh+8KUe5hTqvoey/sPP8JwK8Tc6i1K4wrRLZhT7IK3oqnoLx3J53Mv6Httk+Sc8eQQiEhrJ
o+9brACQ1kVuoqeDJP/QWUL+61rCm9iAaewZdTMdIr1trobUim/yiG0HdzKeO7yoMOGpJW+ew6zL
igqNr9G4zVoQAqJYO9HbQlLF7zNsE7+vPlOlt/XOp9brrT/QezJgz1tNKDn3AG5O+4kPp6CnXoKS
JzaAPk7gxt3JlYglhIiCQqkirGuzhhTgXU/r8XLt+WmUqi0zLLUh3ticXp9CKerZA554rblVFDIW
MdRUZ5FSrvcJAMf/A0cVPJD+/XpVqm2zgriFbZYvb0d7uvEDoSWkAQZxw52/eGYuCe3r4VPPZN6Z
oqugmaEwqZceTKLe0e94RibvC4AHYedtoDDFke5JZ9xmDMmYeMnxTiDxgZeph4wjPwxPXuQvKJEs
HqVw35ZSQLiAHJed8aAZag9l1lUOOPjj1M8heE0zv7m1UAwOlyA+J/4CNiW3iu6R0iuu/pV66d5W
uTb445NMhZcsjYehsS+C6wzuuNCsBfuRlJDZyN1wZDpnFxAoso5KGs5nN+BSxW28oF1q+ouKwifO
zgp9KYnp0KEoiRydkGe6QkiXG4/QH3z2ocoQic6XEzT5i8vuwyBlv+5aF1RKqQWxTqZS3guG6ILK
9F9rqzAu+CtbRXrDgo/l/C7aEjYoFG53NUK2EQ0mNKPviU4keHobO5iWLYOOxhOoQtxL6q3qN4P5
8H7v3f1ZUkN0w81YFeZ51uUN1jHQ+r7UA2mc46er+MVswS3HFA7IRYi3CkDpzGcmDyR8SlJYQUR9
C/i05FriE+L9at6o28Jvh3CmUXPNRpDh1FKho73/nOmHm+3VhOj7L1vAnIDk5PMUv6KnrhGjzELm
0Iw+Bqmnc9RsHowkNy6ie7c3tvW/qF3WoZgVPW7YvcW+l7Oj+TDgahXKU7c2v/tu1AklCmGEVzA2
AI3ziumHQaSfqmtKXf4S0k+pMkO/Jb8C5YLhbSkr4oP3mMRft8yyepwAu+Ra5335mSjTcxn++hdI
mjrYBSrxcDAAPhXGXWVSy6rZUAYhDl5gm7W+xkFLWXq3+wl1nbGbiAWjZdBvlzjKaxqpr//F4smY
voyob0mZ27PIqmFCBqhEVuoPzZzfy8WyAsyoWMyYwmp4iSHP+YD2Vy7i0eMw2MSNpoa0Ipmk536J
ShD+SPbtUYhKB61D1wbSnKk6f684Z+gz1MQhBD2DpGLs32eBXbf4211LTDlb8FBIv1KZug7Sdy8a
v/FZjxD3PWO7JPYB+SPrn/WzFogwYG1m1H5y6tOETsTxE7j7I3HyL3yPN2lt4dvWlhsScOQ/Z2NB
DLS+/QARau8Z2PHs9f1aHC7KrBq9o62wtAyZHKUjXgGzjlyG3M6zCF2mY3+xoQDZUZzWyWX67iPn
0g3dWMv6pzSGkSUGpzaXcD5IlF+H6q/HlhVD8DmKubb674eSHaRW3u1cWFvO1Hv2Ywig1vNDDsXn
9Ny0JHBHlup599fzeYZeeCsijmpVzG/y1MBa4H9fBS+u0xFo8lGlH0BCR6cGP3UFGhQiF01mz7gv
bPF2fAGJHAkueZbrZDUAlWSqrilztl67gDYu+S0WgaIBe6tbNPq9pAL5p9Gpk4hrjdi/XaEa1DXr
JXowpZPua1051+XvB9TJAaH2kYud3JZodvjJT4vOIJiUB+u71lp5r58wBdEulEJIBUMIvIHe4Rdk
9+MagLhjxTbxUsuOX0539YICtPZqG/5aoJ/um1W2c0VKUSs+jR03911tcHAGoxMxk3HFq3RniEzV
C3AjxLqR9hDfctTTiav5BhcgKTT75HltD3k1pk1M/bLWSsR79PEMjy7IrTk9eIr91DpueShJh+Fq
NbE3zp4YjNrqrqDkEuU5ohhClvoBDgbbfiwLMvnqz4wEOD0lHP89XmZ6gxrKzeI1r7b65tdXHCNN
G/yW2N3ECWHwn/9mb2I0ZtZwz3XNZbHzr7rqxPrnm587uV0zjago4emHth50rKEXaPRWXNh+W+pt
2CqmD3avjNo38omMZI/jTBni0VLNreQh+uRwwpgQCZ0ISHlNcNwTf1fTkO3EA5cohFJESGYYAxu/
dcXX2VO4kq6aNYpGo8YGjuGaZCsfdXhH+LvcdiL87rco2jd86u3h1Bb2MlRMSw73+ghRaxVeA2xG
2lvBBBzlsmojIE+2l/eYa2Sbr6IjOY9DIX8ZPKsq24jqkDt+6+emlnZ2cRTPCB4TbfJsRRty7pCD
kuCMz97hlP5ESs6Zm+upYcTInOD6kHz86a4Wz4RJT6fYaSR9hD5SklJtcKc3GyNMdbZWRqnofqiK
7kWeYPo4SI2tELreEuSCs/7YaeRt23jDWdiU8huZEI9apBOXWj1SsFuAeoilx+mbhcdPmYi0tl4n
EeszUUN3zjdHuQ8sD0qCEDCKXFsD9MQkWry/+KCJlkfZtrYF/IhtzKw7eWqLWggVvkcpl4EZc4xW
p3u3xWJLmx933lBpUakyJ0bNcg5CkCUXUs821/KeVR2IcOnOTu5tzAwIW05elY4c8arn643qV5HP
WK+i6xqZFDiOpVSzHprBWyZby1l1cNHPnNpRQZYsk0GLyzl0X51ZUIcdTsUdbFCUAgh3+xbT4hgH
NZkmFzilFiaIPdO+vRxVvOk8IXprf17bgrgDDjpDDY3VfzB7b2A9oF0CvYysYcm/Lx/dYX8xtxHz
DI1Bz1XGbmOAOfgHiH7uaSlkxZi9zEqprK5yycsOun4ZyA4j4HW6hMrXXjLR8Tvy/e4uir4MAeZ2
dhldRs2H+KEpU6Opwh3Aa58ZobplrCVxhItJlt/pxwkhvNMefniFfr0c4IPDIrc+FAcKIcHeOdBY
nKUtfHc/3G7oKOiFead2pxKyJVjKa6L8OMyBi++cOfHGI9l2S1ujcPo4wFxHYMPgF/0FcvZIBMNP
XH5LjfPF9bUBgde0LCpc/f0mB5aV9HzmNwYk3qNzg++l4dGW+ytdrafpVFVqa2Ty8dV0xDSrH24d
ya4DLEah0ax5wBTcf/DoO2qgd1nB3DAiL9JKXWCQMO0Bs0g0eV+rG5jHPu8YsMrDNGlGgY8JUd3w
4oIZhvbhkbxlE/31Wy2x+kEjRvSw+pd+uQr1VR3WFbarovTU2sQ3polAQN7kJKlUKgXTGPkS+mmW
K30+ZuFMASTnGnnCsrWnGlAz4Jznsi0WVsyrDzhFraOAzQ/uvVWAc7Im8pJJYx8rimEmRCQ6UGvu
wGqQdakxDbiMfNeTE+o6WuP1kbRHLo4bNhbnzwjj0caVhh3Sppjl4zpyBuKEUM5nXw9gYUJzjK72
IJoVTwlvAxjTLhgoyG4EnCYtpguumk15INcX0xyrm4qcnBsK5f6iU11cAtmKxSlaVhgCvQ2jqAn4
0W926YHINVUIcWp6xeUQdmp3vd1qJVgqrDJvMmysLNw50FF0jsYlUbtwbLfnVmKeGvocX8JlpWam
xITf62E/uIcflExzVyCiIWXjGhCpD45vsVieYPYlf1CgNPoZGH2WBfAdC4h4ZQ8w3c2JzM+MK/5/
6BjWIomy/iZAt8bGCsDCXt0/Q7RQaT+fWt/IIVoy1fjWP5IrKJ3ITCmHORuErfm8Tb4K7LobUQgs
1YiLbBcgBTkIhvX5QXj4jGMkV0IsXCROwwQSidw1z+LLYLmweF/9KGdwHyaMz+hBOqvfvstLzk9J
16vavsHchkmDgVoqLYGfnHBnhksvrBcqgQEYf3ax1loJIEgtF98OJogJEPtX6ZkLYsxW8Bpu57R2
1OW2j1bzFtIZqIat6e1YzOCx/wwXzwIvh5TjXoPGeY5ImZHkDN805IBgUmQey17ToGNSixK1UlEc
MjLL9yHyj42E6GChBbkAeWuAix7pgUqmCTIydoxqhs8C4d8Dg0X1xO829SCyRwUaUsNMmNSVfk8Z
2ANilo4rReT1pzHUcha8YchxoU9tqOlj0NRZbSWjBzhHbM3JoCI3mAJYWkVE2liYt55mLHez0UDf
UcxLzM6t006nT2TH+rRb59ATh9ZjByj6vXyUvQdFSAhGF/uoZUh97dQXcNLLCnwcF3pfgJVQEg0p
6/Mz00Aur+lGkM+loMREjIhKPNUuJ8sDZMzS0f9bEFy2r+LOqqpNU0tInSR567Q44bwDqqVsEhKA
pCU+zCt6vFG0kvd98Tu5R/9LTrYh8iu0xxnygtoi0APwvU5MfUzx8USFerk4QowJG0fO8hZDXa42
8pF/sFS5L4Mt/ZUehrUf/9WEbJfmXV8Ghzt3f5mXDFiOxDTqtayPx6cXSW5qK0As28DZ621QH/X8
GE/QNoWBeMeG7txUUL7GJXj627BXDTWdsyxFRWYm8BujV6so4S/thOq5vAWYlFeIIwJYrMUpgfyt
EUfoCqAK3XMnAaQ8QTPtTUZoYMTbe3ynJwceq+44rM00Xg4aNbtla7sA/yFpWMibo+xWHfuYGn8v
f9h2PXCpZBWfl5wVGj20y1xTnleNXYT6830lNbv8dNzcF1hmKBzsNcYB6onsujJTcPGSZ1TWR79V
ZNH+HBXhmmcLsZ8QQC9gYmWWvRyd0ChYz1K4ZL8mn9MmqRbJRLmqdAkR3EPgujwkB67MwFeiAaSt
f38pUWxMMciQAeeWaQhuEmpNbTN/2Z68AqzX4bbsv5pCySrUHc1hNEdSdwW8b+dQRu4cjzGwcF9O
vhpxxpRwtM5mvSjr7pkjkIx2eXf6idaMGTKRs0jm9OMjDmPiVBGR6B0hSGgh1oVVX9GctxhqdOQs
PO1oB8GgP1/a/bK+maMDCmEogRHOLwpf72NI8w/pafFJODZQIUDeqTYLmOcA2TPZEtveiUK0YfKQ
C78uyfyXF3UjBwVl24Z80VYyMpBXWlYXiEW/HKcNsV81yXlhAWb8YHDBi1gODn/44QCUbH2LptbW
2eY4wUlHH7lvWqXin10G4ZsTjLZe8f+1HIAU0itGcoUx7uIIAf9sId0V2ykOdhemSzr0EgI9qgJR
847qwq9/yT9M/+rbp9IYFaS1z0zT0Pia3yk3wC7A+s8rM8pLVdxIm/t2u79LHxXWEnRZPfAIFmYs
2jFEgmjUTh+AEVLNweTF10QCjX1DxojEgF5HEDupPRgSxIMF/F1zQNouXlXbqqLWLD3al1T7H9rE
xPeSN1i3AzzuEf6XrXSqx4QisKMd3jx3rWtw+DDf1LaI+hGVkWytchWPBwXwNKMTPfewgrCiBQpm
cnKuJyIw8HQg/kLE09CX4D/WW3BXLo+vu9smcXB86TC8J1Fku+CpyvIAf+VauZrCAsYGbx5jxlXV
rcrPBBJheLRMvVcvPQz6W6vaaCuWg/6Wz7LjTU9Cl7WQtfylJ1GDEUW3EuQMXU3KZEzBsKPym7NP
MVKmBL1Ts+D8CroQ816h5z8venFSXZ2bx2nZIqcb/ekGe7UrgBCi0ptFtGQBghn0qch+zwPi7K5s
hLdy2A21CvjxXrM41xSzXSLEiE7e8veKSfAigjHrgN3iwSBMnH5V5wxaERs8FzyWBW3cKFH/34eI
3zFs04NjBjIckbDnrfGglYJ3QeJI4gJp64fc8IoSUeo9DHMM6keq4N5kg0JWrkeTAj8eMRuQck/5
fMLZFPrvKMswBiumyMkoXesll8WYUCA2SCJUMbGQaNnSlL2YPZwRiOP8J302Rg4ntaRifHO9RBLy
5bniPF9MhtxXoTHq+l3gWvz8ntn99xgl0GzUmV1KYWvWXizhGS1MDDoYbI2Iqdv8lZs5mRwp/s6J
jyZV+cULdqo8Hm9WFodWWU6UqXVwDYKWgt2HsxxKnM/+sZNsG7Tfl/9t7ZDYnVRoeZnLMQBcNPHk
FDh3rblG186Pnn0ix6xTfyWyT5vsbS306WvEWszdRHXJCfX9QpQZZU0m7yP/u/XVX+IglLFMvf06
E5JXYO96cnFX30gwDYPVCT9d6vMnIs6GepM+0cFPWg9BJO6mpEmdUS8CbK2ETE/n+duZRhF4iXc9
3YIoSRgOEVbl10qX+4IxSI4mIt6mzSxYxSfOCSeVhjfKRkU9o16Nx6qoF1MmiCle9xCMYGmCNlD1
UhYCCtdEpjIBtfBEvbmh/Y4OloB39BZ+6u5jPM95SS4lHZBNa9G/mroI5JK72xeubzvli1AUc2d/
jvOQeSsxKR+iC8xKqvoosyTFEFAvMMH/d0YtxdCrZ4476uTX++1rE9rgK5lpfQcULWqZ9US+MHuz
1fwkBpO8bIT/MxKunzBsH58k+al7kffAhgwa7RGoGuA0xUhJDRnIc6LQTmGBo4z08On0kwOipXWQ
qINTP9chANkuefhFgPzEt83ZfJFOcd14T2BI/UVMdI7Ub1NQvcUQgAvhI/uaRjjEWWxZ45UBc3Mh
MHrv4cKTNM4Kc84XdUL1t75imFf+iO9qWO5LY2dnSTD9BrG/QiZIiOWx+vuc36uZQCyDeUSMHYo5
+iybkhC5cnc9q3si1eS9CyQTWu0gCNYMGfD3UAZ7z1VMd9b4NanSrCtp+9zRJr69ACUPYcLV3HZY
uRBgakdQc2Xm5ffDYnb6N7Qt6ZfPl45iYjqso1EDImZUf7BUBVNdwYr8AxdlaNwOykoLM295IJgr
3Ec/4Py2PuNOoE4dScIpZcppTG1PQumqUyYeSDBRABzvF/qXYZpHDKSn5/DnQ4ie7EzGIa0qbnET
R28vm3vP2PiMtKE7zp/2qA58LbR13l93NvshaTV3QiyHLxYHF7Myvic50Z+R4QrZfr9WmKVxRLpa
b0DuqOwOiLoXQKY4S8zS7fyTQa363FaK8SHQJYUsmgDEi5wv94fUCwGNIGV63xl162N52S4wfOLG
KKRcvfQdIufwK1osc7Qye2rUeo/53DzJKtYMxeVBKD11T6dXzokwv+3DV3RycwQ6RmyzZkNY7jYR
J7GcFAumBP5lFB9VTETUQlCBBGFOra4n1Ghk06DCqdhv97WbY0vZ62W0Ehh44OVRqLZyKu+EKZ1l
R/M0K/S5vhWdW0QFjXb4sYZrNF5jzqALvuOPZhu7/i994Cs9JDMVcQyzB3a6cb9sbeZZ4W0+4wdx
lcB29Q9RkLe/HtY1XWq9+KswBRNillpXvj1TJXmgITpZFIZVscfxn66UqBHrOpymRfN0MF57f4gS
5eCow90NBrhLAVra+hQTSovdA5iCzR1+Aq1CKcVhyIkD3K1FMjjTY1wcCgfdgeDmPULKR5Kmx3DG
zarj7bTY82puwZoV03LRafqFs8SpMuo+WP/XANjWRHqp/ZlXIIqKEiSr/af2FZmjHWQHquDbPSDD
LdRGVO17Bo/68uueQmNd+nCWoYN2no5fTsXppPAS8jXXEYpYoFJBbNCxYkBBW8CxtsNXYRjNfApl
TRVMLqcQslvk1zpVa02vdc+6vbteh9aqHmoEPFTRxjoYA5Droaky4vihBMRASl9E1keT5/PGm0od
2lwNvpjNst2t8tS5OrgHXZsvPvRBXTdqMQpjm1q+A7qlZoxYEA8CrhDCtVmBoZt2OXqHz/hbIJ+/
SCyxA/yO/1aHXQwnuu19Tw8Y07yz7akqfGtuNZgoQ/pDmNFT5xciwu1h7MSXd7xyxJ8+Iz04E1n0
BcalwhNYRua8vCixjldDqQCT5h8OFagvsezC/iML1NIb8wXaykB9mvWTH48sMH0xP4brBwguwNUU
g2Vw4JRA/fgK+fPNSSQvNpq9n49QHa71ccbU5Xd2SUgIRCpZx5Q66MWzhY8wVT8nQ7GKTcVE+2il
RODHo4eVU9j0bHS6PfUjlDnQdVZ7ZhnWjC1L/jpmUxgxVT+rp8fUIhwt+MSo33XU5bWF1qOfB0R4
a1VAeqjScdylIfLcd5eq7NLJ43dLMtsrIvvcViUzG+9RtWayY3oY5ShAiXECgu7AcU6AgD6U0Go4
zjCXVWnERUhpvsPzNFKXaa42ZZjtMnooUrJ9Yn/F9suw8kLRRrvvpuJ6kLil+FZU17ARvZsvEgU1
Z5AnPHSOfr0aE6qIB0N2psNbH4CL32qi3dDaJ/rFES9lvB4Pri78/utHcvK1c26jAaQD6h1pqfou
h6xJTHY7xkUUTS1XtGIYQAjOdV+yO8zrWx2b4bUk3IIDx3SuOrlvTinllBSYC181itpIdmdWMGbf
1gyVoDAcYP2Arpa+iDw8n8nqsyPMVKS5luSXugmPmdp9ZNbmnZij8v1kCaEV8bNUpOUeNFIfLLWI
W2HwoF7m+aaB2Wh7873VX4at4YfW2/UJIMp2YgksjB162ZmJkexFfJBt2pLqUAuTCu9e+IALq9Mr
vU834kYzVvb5LoPD1ibZv6CfkM8bzNrcvxqEqjOOcMd2ChtdM9oS9f5fA7xI66sL1G2uRhGlUGvE
/70u47qYvjRyz87FGu1guaU8q/vf+NkEjtNMUT6uCE7ekTHW1gXleJpSa88TJjtDziDw6wS4oTo2
+5MQoLZt22xPqjPQ94x8aWudi9H2QSqO1QcPBFCbLkzu+Np7y5BIb800hH8hqJO6wQsNmNFysH2z
Gr6Iy4JJPAIrPxJ9Oye9XU9gTlu5Zbz/DxrTCS17RVk/hqUxU13WbTP3OAr7lVIOG8e8mjpZjUvF
Jz5f9DMErwkpZPh1VFI2Y9ZyuLpeDcIf6bX7QoAwOLvHcCb9wuOFKG+AQSQqB4NjmmwwyutgUJNv
h87CpnQdbEf+FqZd38HnpVulPym+s2815mw+oXOV4SHxCdYtEt9Tu7O4YE18hp4IZAuFbf5+DSPI
MT0VaX34BIwvRU9Nn0bArCFURAybs+OCT/iXb5Py6sRRBZuKpGzOrEz+y2n5iZLhDsJcPsWmELa6
3qD2Ram1Z1WAY1tqKTiYqulAdMHdzZa9tsII/vearLrudfrYRwejlgDQFsdd+bqYedZjhjDklm+Y
ZyEy2BWZFBjm0ithHOthKVdyWuPq/Q8lpx2/GPrAoi6AvgZKaSVerXDt9Ulsg69tvnwTM0x8kIHJ
eAcAhLKfOcoWpndVdKWu1RRcB4v9NvBWs0ezm0hNcO2hiVUpF1eprtVZSoKHwysu//u+v5IHiumG
YxBb/HA0qNGSFwV56lLv1VtAI1VhJxuXa6jf157txJFcFRMIguEkjwjDa05z0GRrmQyp93NAIbbf
b3nZ7Qn3s2IIOQYuMGRb3KVYbERIHRy24oldGLlV3R5X6une6AUOVBqimn3lXQHIhgPpGcGsJHnd
sJoBfSiuYiEyFp3PlcIzUfMx1wcOJmq+P6lEcM1/Ukwt1ZDhBpqwneleW4e6tfd2nTz2Er4N0iEe
MIDwKZ3xZUYdrvSifUWjl0zSIguq5Xi9/HAzOfgoRWyilXjXA+JMau7AFJBoVY2s0bCxoSLuDOxh
MjHy4KFqAF697LIWupi/K/+FGZZ7lPUc6wROiyIySESGT+VLC0/4zN3SNSgAWT/uE1nx+WJpr96z
gifcqP2IXF+d26oJqy5/LI9/MR4Bd4oh0jl/iEWv3fnWvmtWu4d6PpCZnlCKpBypH+amNea1iUtV
qW01mBXS6miDVXmsgoMNYz35bloHlVydSdTC8+a2OPJSjUdI3pvIYwDRHE7X8B9T4ocyOPEGY2pe
mSGHx7+ncCvA6jdSnZonldi9NzFVIQGs/LVQEd3FcU76UxwPWE2kcHos/+dwx9tBeMU2Sjyo4xMe
MgMSM7sMCNskKO3YeCY6tVP2c+6JLh1kQsdQ6S2MpVdUryH6lID7P0BQUu4/enNJd4E57wjS6ZEs
i6xpd0Q0lf09IOTO47Fj6qw+P+FjrjyRRG/XO/n7NTkrNi6p8BuJrDRwebalSlE3EHaFSR2yEIsH
chl+0TRjG2EsrVrSLVpCrQ0xLD5iiQPB4DBZ6vUeajm0S1UebeslN0W4ZZAJfqKuVv8+PtVymYX3
8BuIDiQtcg6vlOmGjfoE95GMp73iloXEd9zlT7VymKBwWywMzm3bO7liKWAfFP2vdZne2EMuKJGv
cJcSaHr0oP5VMgzl0Lg2jANSyJDlOMUp1yO2Mene+As2yvk7wyWRv/IDgwxTePJ4hBUxrrvjZEJ9
C5diAuMFxwVnIFLeGNaq49UWm5PkAWik+TRz7EivXZDF+iWxUtZdO61sfgN6gEScN0iMTuMmgcKX
S/hfAuiTaa7zkcWoHbgxE45igbUjz3boarVXrN9YEYG2Jt/Wo+b6nqCGlofY7GmEe+mVGSHOMHG2
vTfWrAMzk/2WrOSbD1+I3xCwMRMkfjEtv2Mbz60qLg8IjHuo9U18PjKfGxp2uZrBbctvtO4RjH/x
Y5j6cTp33kvNkb4Ew+rpf3MMu9Nvl2UTNQEN855wsAw4p4cvyukVgX/dPyeTMPvCZULKRr9GsvY4
wYEIzKwA7WLfoZfukt6XtYekld063WjTMJ2cAFrA3HyGAxBKsax1CL625QLTsMSj5znSvqKywLZ6
9PD3PVGa9ACED5c1UntK/e4vX99qoZelgBmsQplmpkdAQSAA21+He/7wG2VbwoHzVLPWBv+CZDVw
7yNYI7UqBcuKTdgC4FHJNm6V4CKWpcJplov86y2/eK/aP0e6O0An6RQ4AHuv2Ii3ZeMmq5yoB8VS
5xSl09urqzZSXmC49CEqlMbvghk2iKa3NkikF40Egt5+KtY64oNP08AhmiOHlTrs6btIpGGutOM3
Ytg/HiwMBNZPL1knb8clsZkfDGa1+lkRT10haF2nZ1tEb3Wi3VPmH+JGR8IqRXYhMDrULyrZ6/QN
i2nOxPLQKVixWb2gQba4S1l1fIvmjiVKA3BOjhD2OT0BRoxbGaoaF8Iqiog9RTRNl/uwaHAX5y+M
Rs+V6jSDlUso6T2MCm65z6VUdaq1bujOIGuON+mMrp3YWaHOGJg6VxRo+Be+7LoiIYAskqC7JD7e
XTNMqb77tA4OqNAbG8buNsBMgI9Swv11CYNdMtEn0YILkVusVLWy0gT6LQQte6ZT170toUpXiyAC
9fPIWc408WeEHAtIsP64f0PPRRob9s48ZqmaNjqlWTAC48+tI9LYO+Wmolqle0HlG5IlGPj4tU44
FqkqgLHdQO63HLRisIDWjN+u9bZ3vi8P7OJomJsw7uToFaPePENxZIUjYumyMcrr+WoU9mfkYlXu
xzHF+D6+YTZV1yhoRjhyx8A05jgA02l3MNHXHByndRWkC04+hT8N63plkLluVirTbSoCSBav6tDZ
c5lBhjnnhzQ09TttXTVgCDyPhalIhyJzLByoBMelOKGs+lWbi4TQqXbkLO7TbABDc8MeuHFJWs8q
CvIWsTs9yvE1ttb5QX+BTiY9srtRGfxK3T1lLyPvoRqiIisooskTUjgNsBWRco5Dy+D2IbT/eca0
zdsi/q3qS6aI8JzdM8ufFBnPVcIb4Gnqa9Jhjk4bD+WrlY96sqTHgJF8S/mlr2F3ARgR9swtYthI
myqF4yvqxOyASBk6wnG2uk0jlQIOxGjlV/839mhhWCiSegvi5eRVqlCt39n2OEzK+nxusCJ5Q+zi
vwxBfm0J5Z1u9g5Pr+biblwxevX8yhEAM7ZYIB7dwoP55y23EQALNsCDwjAZ809e48Phv1qJs484
LDXEruDK1g269T/LXzUGmKWInLXmukR0GljBFtFhJOObukC8wMElnAzxB0TvAv88b48l/1P5+WkC
gLUQNI0x9qFm1dWrxRM83DES1V9eu7oZznRAfYjxp8fna2ypmHKWEdg2lkfwim0lH5TcB9jmLxJV
sBVEn9Mj8d/9zruBoM1Apv2JT79WeiiTNlT5KfncD4LRBdb7/Lq/mh6FATKJshIYsyOGEmGCH6Am
vNs5Xb1d+EfPa+O09YaTgqZ5C03nY5MSr+68LBvYi5cFq3IKOSiLTaxelOuIMC9vjBfwpoJ9pgW/
0iEW6To+FXSOobvTB9l2sFimSMnhqLoMPJoqFvhTMXXqHkOYVVO7Wt0Pm6B7djcnrexp+eUZTB9B
XnkPXSK/dVH/6veDpM6wn25q0kmJHhOiR9RlWPONaLduYa4K0qyk7NQeI9xG8mh9ym5wB08CbTxX
MQGaFjUa1AUOuU6h2ljFGdY29gisfmE5G2wZcBQ+4Lan8znqpS/omC84zmsTKLib8/MpmufpmUpl
CnkxEuZORaXx7HTgHEqAhDUELXvN8NlFa+zkvwrucIelSWElcYx4cytEaFb7r7ijT9cf4TXUo8SE
sOLoMzoIX5+pfKBUNtVOxnB+yQzz1hMK8LrklaYraTTTuTy44YfBgx3/YyPXoMYb4Gb6MugxerVb
Kx1vsenIZgo1g8Z/E6YqTgY9H5i3g6A4WK790Aq87LMH1JXbI7T8XBz8eqXUudtLaRYnj4JXbEG7
pEkQ+MywpTvPbS4rbkoPpY7ToiEo7dn/v7WWaxMNOblQ814RG1AjrhCdQhZGMEFckSoWDtPFowhZ
OtSI1Y6Mhl7NMjNFeY4kgl2UpGgupLvDg+wYhrcI5FGF8FC8Kj151kHOoAIE0VxNOcBLHOssbrl/
6xtirxdeRsubixyOXdKpb+zHzFrNMYxhQ+fwuDYd2JYGYsx9Kq/IF2zhSd7UDeLBpUKM4L/mUNle
fpeU1ip6xYSdcesTToAcgBezWkL7s3Q/EL4rZ+u7UvATrO63uykl+E7nKwNsXsZx71Qyte/rwN9+
kstKli3QJR+7jdkAzpCjkOCwkB0Qquw9YJbdSnGof2dJ5bR4/theYBHYnj0rzXuUn5VVHbMDyxiW
8kxfzRPQvQ67mO32WSz1ZDhg/iaKbPgZGtnkbQ3kLwFLtkv8Nv4dTXlvZVo6IXC1faE9nYQDYHW9
khbFf3z3t/xpexJ8Cs6I4wnj7fxuBAzP418mR54JmAORDkFot38YyImLGoON/tjr99ZoyEzGlki0
HlCS9acFgrbDOQlEzAoT0PbTLHooptCNlIICdwQQMp33/LOiJ0Q9WsZf3rLnoGq+oKttATtt04TS
60xZP0UHs+y9GPdKKLnUiZse/ZJguzGY326bc1LmhbjSutLMK5E0JuPjx/VMIXOWfhKQjwp/Eixx
8adKDe3JviY7n99A41SGsDqWWjXhHspRYpzDuoFq6kdoufhOTlCqWNLyYIu6MT/YsDjg9DZbLaq7
7qaxIJA/FNUEDYzE834JsB0QV0wdSzTFtu1ZFxFb84yMlSR6GNuBjTQysEyHpVLzrzAk6gCUpmAn
yekF74cZ1P/0EWwXYS0jHi06pszKNl8rXSMHERys9YJ27wwHZgCYMAEbC7a9qrVr9K71N0kZ9MzZ
TJqxcCgg7YJ6M/G2no5booLj35KeW+Umn7TR8Z9AP8bBtUBDH0zZsZ3VslpiHv2nTIH0VwURFGAx
L5ZkIKbw/ZvpsSOiaM7ucg/0rhpkgNnbxytQutdYr2wZFBopbdHEg2CvvOswUuYAydaUabvosVWS
4dRQZ1iuDheMti85MgtiGjr+A5SweHqclTHUFVoi3yVWpZuAXY2q8d1CKMxVKKiClSwZymslgjM6
eBtpuCOVC4FvoYXdE5C5HrtFZ310LJSoUR+4rgRWRIOF4uT+2SozRYRfjc+lyHb2l5yw84EkHmNX
wTdN+9787De4K23w8+ER5DiYqCoTBo1OJfU7TnQfrAoS2f/gYRgZd/jia46Jr3muZLrW1054QkzC
GBorAImXgAf/jErtbPSX9KlcgTA7oNMU/qvgy7iUb9XXoQaw4SUl19x5uQyXIjgOeoDeh8k/zC/v
QqBlRZkc+nKDrRrhONFIdi29tcmG0zDRKVVvzFkFGRMHHgXm+x8/j1xAkxwRJD/I2Zb/67YBQNsR
odHhPe8FioLT5fyFiuZXxI153+cqxZlcAGDgT3OT7bXGi30seT4lvjz9QkRrtsD0IedpZ7l5TaJq
xL2EriBGzVobct8DgKecmz3HgByfFETGkVFoyi7c4hadZbZc1c/nrxBPS+JDspVzKFR9ElExcpwJ
QFhbkcLspORCVaoppJ+oD5F5gZQdEM7IBx/rLI6M+Wudm8PrjbJYdmLwrOnx5leWz3k/btlB0Y4C
9Qwaupiis5/78ZHg0UopZ3G4jwa2DYnV4O5qTl21BdGmhKyEQ1Tzg3c6+p4jXo3zmso+wAjJ1aIg
nx4LsQlMC1KioNo9UDda0Uidd+YbQ1AvafsyLYUTxUd6bQT7dYBZ6dYbk8gtiwTf3BA3piCUR8Lt
GqfVUWw3zEwuGFOT1kgxCFZIAo7qS7i0XGgwBXx/rp6apdqMFVUjsLLqZ0FA3b7Ys/yFabpoRZBP
oRPSnXojI6YvQmmk4eg/rljZvnyYWR+oDXGMSr+CIaHbnOsHcNFEbGdJ3EyduIw7Heqypx6/Vlc+
XRdSd/AdIvYQKNs9R/9b4qSMx4Cw1ISHcOjHK+gXo+3xAD3weO5tDlr0R7XYKDNekd3hFOt3RAU2
C655vnoGQvjKOdA+AeZar1HOCV73wLC2N1fxzSL1PHHko9z9iuAgOiR1y47w0Olzh4bcWM7gs+Rv
KY8zQJpFJhdGZQaraL4W6H4ETD/Ue7++KTS4wK6mJBbxa/LQMXU0zWHNoCcr5LLiykwAU47iqyMP
qvgfHBdUlvjHRjbd/w1iAFp/AkKmhW6TCHOBAqLkIXORCyEmxOPfFf8upSGZu5xUPHttWNtJL59K
TuieFgQMzMrN6OYGxHVrW8QwLZpw/iTf+wGlK+4KJ0dED+kul5u5hHVmVFiEKles9fMedW0KN2vq
8G3sh+RDaZTzchxfYpiPbgLStj7nXWAQUbzR3eO+qsw5vK1s7seqMvJvlijyBSxy9AGVfvVH1iJg
r4OlA8Bf1EdZxNNuWr7k2PjP9q1ea5KlLrf1WzkI2iyxM8czWhFBN2cnWwVh+cGPilOILXmHGH4l
YDPND13b6dKnv8f29b4fdNgwdfyUYpb8wT8XXBxfb/e5MaonNW636dEmaXTujQXkeptnUR1+LtSZ
oVEZIEDf2JYw1PdHKU1rJqtw7gjzkpxCePj/zt7tUSG95IjsM8V/P6ZVzpp2NVcd96hd+m6Wxgla
DO6Rwz4Y4jNu5EmIq+uAgDdycZx/u5iJEZoUMQI0UOpxJ48umKIuRlPCvTBJf6RdZuZ6ee+r1tOV
s+cWYGsxD1wlY2qBT1wNuj0cPWLyw2BD890KGoIR3Bx6R0BrAdVYmME3D+GYefH+vYqfO4Uziy2D
2N6MbYipoL6DgeFyXC1d20E060IdktPSJLiPrL4v9E/lL6ZKy9XvMXthp6K9kfP1Ey+1FOv8ZOO3
jqLY/ORsxkrYEgk/v+UCNmGQc0sxt1Ka8Ctp1g2eWRW6T3UitIt48q89hq8TumxQEPhBq9O8P0Z3
BewhPeHl/izf5c2cgD+uft919TtKQMPpSG4rJ193pQzezj6gCKAUmwlC8R1DgplTe1KYWXw8MsUC
nOADnWSBNkJTtkSr7hjpUld6ImeIjbNmi22xlhGqASCrTcmolgW7z7G5ltMDPPAJE/vOU7SfJIQo
9hgePxBW5bCjculI181qgYvAdnrbXA8B+JtcvChQja6M9PpVZII6w8hMA6ZhXGdsFTiN5fyThlJV
jomWmVk2OpiJ2qvG27qBfxpR+AAzMf3uICzNocWoHsjY0rOn5kCIF2F0MA8JuRjqzd5Um2oyZvPa
snDJhM562jZMZ4cpdvmSLIxITxJfrT31PeG8uudFs/M3eEsX8NkYzOPp7SBO23eurVEeuT70U9VJ
Z3Np6v2mI18+OOpdySbX4KuSmp/3h4DpPvbtKaXQ+FLfJjZplRgUNTUA6q3GpK1YStBi9P9NxX8C
F0gog3nn5ovRBuFAlBfTrF51G9mz0VuHjrYldRHihm95kkskvNN4lSXpwlQBr0RMZ/uTauXOL6aE
8PfwT8D87CPAgMYWhtY27g0MVhg6HySdoDwzSHCTTEcH4AlOI95jvwvkRRoKOfqjsEs9upN8UUyU
XpakNRq8cvg7pxRg6Ncv/kdXRL9ig9B3ROpeA5sSO21TLQ7tl5TVEgbHze7MaGwoXX0chD/whg+P
ond4MzaUIoNhPY/+Tcm0Alg/1PmK6X1VJLHAHcRdi0RzLQbBdBlOjAYW+AEneG6a6n6FxJJRQ4FP
xKqFhS1iEMFrYtfkyfasCFFdBJ9SgaOFTS6xlj5lWcn4bxKTUORV0j9LVULBXEh71TFZpHCFkOh4
ap1+wBo8nF4Y85q+lrot+dHmpqfbLpZjc/HpGQtEdNQ+BRj9AILUnxJHLZtSwu1kGCuDkovA4khs
AhEzpzCF4NqH6tdfbh2jPErmn5dZAC3WsthEBjCyZENpFO2KBWb3QzXT7CLdCO6oKhF+iowD/Ph6
fWDa+LC03/7niOj6fKR/cBqSvJmtejWsh4c5QeHsjC0xoNBvtKQ3+fbkHoJjjrN3wwn0QqKOtZl0
SM53CvF+9hen35r2b/5greOZGKdgdD7g1W5831lUufRo91GBU3Nw/AocrPTfI99P6TolqDh1iEAB
poLL4YCMyZuTYWl1Szw/cKe4Fbvl937FxawONvMNN8k4SFRA3RI63sYj/ksN9cb3ziG7jE0oOO2H
aDw+bPXORv2piY+sjw9VLIZ6ENc9LsKpKNnC+LLjEP5mxRBXaSrgIHOYMdgbXpvlvy+4Y5rr/yrx
QWeeWiGJ1tH8KDAfQ0eR6hlExxwGl8XF1uODr028U8UvTYUWEhvLO1r7CmQMr73y9+N5+7WZbD9K
AP0Zi7RXrHxRJ9dp3Uc2AXoxotLoHwdAiuzhUYlHlDV24Ausb1qxU2iRTucEFjxq380OiehbdUGC
zBwfPx77eQppc1+svbfRc20r/DgomRd2jkcJjYsnJo70UaEK2jxLGrLp141FPHVZbE2P5QWaPWEc
yMX4iUaiq6lKtWFUygn1l1zYshoTflCF+4XcpOdOfzTdnVrw71bNOZYXE8VlvzFCCv/IfIc74TMw
rmstYF2R9nXHt9vFLmQtGVc/yjWtNu4z7kxt+XgJ/vxR3f2UqFzuLmkSe85PlaKmDPNF8ZPQdSiA
7prOsqCr1ivV5PVrPfod9z7CXPbc9GIj/putNCNxmFRX0HYVSsubcZ1YyCeeNFgiLX463rnrDwPc
JobjFdC4RJPu1UutmzJwM4fl/3smV81XtN2eQIauKhHShPa5yj6SDbDuKrsTNRbiuveHq57eALEc
Sb8IvPCm1e8V9c3NyBz7iRv5+nWEZ3EscJkpHQoC6CohXDP/u+auWvUasT+hS8RP1g27U7NBpkB9
Fn2kWlM4D4Naw9Jo+t+T5eZepXFuO/BuFOh7307MBysf2brZu6+/uulAImwHFtkDIHjPPf9tEf8c
tWDsbmkv/GsfpjuyVeOVJN8AP136vk2rdB1QlpXjmTDWpOGbDyVatja89B3owDhkXfOmaaknkTmY
gVZHvSB3u6iotWA4SOj1RBV+NgiPi8H5B/iKy6PJ16cTktqgUqQaUXym8rRg5wvrH8cH3PT/BqrW
/0/eT++X/v8rhKL9HFMwOGDRNNYtRDoDQ+KVXXbbk6YlV6ITtdigtV3eO/qh5VH10qy6LE4jP3HY
mY5O4tJXQDnyP7+3DyfsW1xiDKhAozGTMqvLzFPZBAxw8puN4Kvb7xE+W4hRorQpKwj/MjPyzV3r
g1MMOUSJ7v4aDloXTjOd6BCAfCRqfaYjEc8u33XxQ8zUdSDbbr1kd0I5ucGLZUipyTd6VicyH+pz
EWAQ+MmyRT72UpilsPQoSJT00O/00AErNXy58b0kO5oTSIVUITujjmyjnVexIlSOK2UX2ThYk5ax
uxQ4G1R3gMY4D05sgkkPd6erJVBwrutIbI8/yvYg8UpuadcbwNqE+NkjI1qptyF2v9avQ1qhMsWK
AR6CdgIhPUwk6mjr0A6gK4u/DTK8jnA4ASQzTqFFrcMm4iWUdfF75DrzLNuPi/YHzBVdfhj8BvdD
cqXSAZXWe1FDWN0lE8RcAy4cj2HWSxkE05qUywo98ylLPLhQVuhOWci7P+ySIPNTfcfh4nloV4YD
ZBcrKmYW+GDjTOLYnc0e1SiPB+r062eJfDG77jiWvSBl1ktF2svBocC5TjLzIqIh7KTJ342iPwa1
qty3ZT2EbbfgKEEyMy/1m1FeicqeaN/CIhBbAVM+G6VoyJQ98V5rkHbasf4aEtt+RW59x6Kk8aR1
s2tJMSEeAD0mgFlaVPr/iPpqUA6OcX+VeUXiwIlL5dvJQUN8aaVp2QQ/xGdUPoe1RgqB851CyxvN
R4XpPLbDd+252XGofeE9OKlbqGGo6wCCzrAzIgCUMxtM53GDAIk6xf/PyKlBBTHeOGdrLfurFZh5
b0S8jbjclP/84UT0QonJtdBXUSw8R9BrPUxfljHZoW42Nxl68xLu8IFJAq2LE843+RdI84ueRxOi
dmaV+rB9TENS+GEiSK1BeSAW8StIXvF5HouIlrAbXTf6U0meaKaSHi/vrEmmFJjGAh+OK04oV4uT
Cn4mVqAp9HAeYI4xxy94UDgsCc83BxhtY6FDZtIsWrZUyYm9M8J4Z1+4320gYlvE4/M/2jGdADmM
WcnxseSQwI2QRR9N1oVy+j3sO4/pNoynRGJ8KFD+fueOlPSk5nU2pCys4SKIW9lEYsaCh4qPEcod
azZmSbo9hetAC+Cc69N+97tUpBG0QE5eimJr/Lc6sqkQu9oUfzimRXz0JlwoNPfz3N0YeGtuT4GA
spAbyPjuwoOhcnmlG7w6yDfqinhNVZ0/ZWMI+16cLmfFZul6PoSlBvIjj3eHx/cnPsyIVBonXgEm
1cw7PL6ZGck6KHdRtQqOdAqlf4VvNCsRz5yi/N6XTOWpCRMyGP8SR4zR44GJTHyKudnDBz89hHvq
rLWLoWvgX8AEQXUZfoASDK5cB1gIXhBBgafuKJmDy7yO1Ldy7oVff3/WuF9XKEqQjlDIMcKWPcY+
u7iXPg5aAiL6geqF76/cat6oFk66eXWQOyt2NaSIKoFYtRxiO+ZNmjyCEMs+0oxnzIvHrLLT5N6g
LOdVxnHeOxgiciIvNZQDOjvQVhdfQFL4+hYFl24FA2FzNgKviFeJMghk0Grvfr9iHMT9g1W97oDT
TT6t9uamN/nQTGSx5dnJkNeCx35BMi3fcU/oi9369Qs1AhsiNvlP3qE+3Us9qzOpnCgbi+JHa0Ag
p8VpdCxrmwBPhUq5pzU7fhA0PwR2OD/5gepXV87N8rCAQzrRl3wT+d3UExmvLizMrMwZBj2lJ4sI
cUuaRDSf8wMPrsUfgR0W3uzzO/YC/LYyFbJh4jZ52y62Za5UzciQ3q/+BaqkgS6Tws1ADsPSglXO
ihXgXWnO8uwkDReT66Ypzfj6r0+HdBOi8DlC6N6uI864DVjeZ2qwr3YlOszCMok0h6+BvY8lWGPu
3V5sfVkMekJW2P4lJeM11DH2vk2FXifm2kdh01eRi9WL1gbFyDQG79nyRwCFpR1HFOOuBIxCyR+X
3y1xCBqy6MJ0rNbyNd/4dYz3IT+xy7z/pAHs+kLrhrr0fQJt0Qr1swcXuf3LpoWHhMLWa5vpCUvR
H0cVWHdPgL7IS7N953Mpxrixkzd0v21djonRz54inKLEXbrovI3zNM30VhUOdCk65U30gBOwgIDv
YjncgK+uDW/FWtqXRqGYEe91IrVL5zC1hj/CxunW08oZLrgb7MvvtzEPXIb6K7cizkd8zpMoiRdf
YQ63MKGLzy/ONySxdESwZQ01pCHFkV4ilJFJOTy1sal/HOtgOeVe2/79QVbSjABzFSTfY5bEs073
V6rQToN9aCKzLwm9YtIKiC/C7jHzydj9ev/Q4FO8w6xFHmcEQgFTmdsjEUI3Zlk+aMaZ1ni6OYKn
jZdNgwb6y7CNdbw21gzxp1MRMdsgqL4KFHGUe0j3Q8Z5XsJ+j0c3hQAk4Jkds8M2ntV18ikSh/sU
1amuJH96ZGRz1G+7acZAUUrRSdzhCgYWDJq9lNefqDm0gItIBbNLnhWkV0MYe+Rc5/lZE1Jr7Bct
8b9p9m/pnyx3F8Wxz1Rqg1M1+7qtvYkWCqKaJErF18YlnrzMlMsXNKOcqghACc2zjzbg0Bmns6np
IhUWKdR9YAxVrsqIM83RlAn1LNDuzMGnZIK7WwcSzxpvhrTP74xyy4zXvEj69mnhyDmO1wx2MhyO
K6FW+yWchrz9h7PaX+XAfgVbXa9obJ9Syrabo3BZMwv9pqN9KEoHh2BYCRAmLTPVWnt3JOOjheR4
sxu5jXAm1FTroM3ELXvuqbIw9IAoWsMYZJYKF57OBEroJIlW3baClYX1wyh0CqwmwXCDJsCgaSAK
e/tSRqseDY5+Gcj73wpJzWbAJMg6jopYxmU5cvr4FqFnS2jQfq7vLjikg280q7bxn3RvKcGnSEdo
9CgBkzxdvj308uzX2TKZlio9BfLAZKMVsRawJL+GWuRY+/LRqnxNk+cwSwf34CxG1xprYYjtYdpB
UiV8gqkzEtwSYLSYlLB1XDTBctb5fB1Mq8Pxb7QIniJv/gHdnES9+BuOscoTuESgHONeaByghac4
Vufu2ZilYrfksCeF59qAaEsqTdkNAD/OeTNsqGIvDf8g7aLLaVZnSlGTZdsUF9wwzMpsd+9ivSSf
D2rrOGEBuoUzjZkPezITKbj7lDFrkWByu7aryOwfxM60gzkoqrCNnSyZNGF3teGJB1Z3JLPr6dri
hrRxjH5B5KG9S35qo5Zr5etvFE0og77G2oHSV7LXtrDkLb497Qps0F0G46Smg2kxP9sAPFtDoXOS
VR397EGKhhYAtFW1GzsgjTdyAmov4PTaHVbnWrsubqoOQ79fl2VeL7iSOQGwDQHO0epvZS2IQxlS
hCwfR5NHqeeL4H0vLw81ShqRE07wXM7kwPSzt9SDTLCfLodJUzy7fbxAOoLXIv1fq0pNPIwrsVxX
skJVs/XylX8T/pOFHvXgQT/sIJhIK/ZkSgKBcRStneB/dA/PW+qoA772DiYB+FqV14JpCvAZ7bSX
hjs2HgiH/OI//yHURY0X7nRoi8O1zExItGoxOsthKD5KDh0dyHqfvZO9eJKQsFuCynIn45LwG5JB
FFqU2p7wi/xeXhqyHC6BYC1ugwtkevCOgPnoh7cc6KV7jzuLByRTau9VrevRmQQ1D2kz4nwHt8Ft
MsqF31QYXXQSlbBmDWYXeph89M2HKx61dZ1Neo/GCnaF816Ah95QHXp6bezJF1bG0AfV/bREMTCK
ChoDwY7j28UUfh2JbBGponuOMpsmlXhZdglpwGAvqE+pOp9Y+BUUW3At3+5Bogq5lW8eQlz+JtLg
tq33FnqsaEPVvSSKNOGAD0pmBSAGmdSSaw7NVsKB/tRDhonckHYBVqixJCzjvU07romXTMi8MR/L
sV+8eChdiwu2eJpVM5MLy5KrO6fBHzehX5dpQueDcC0wRL3LsMM0IaxAERngar+QW37npfqLNpJ8
Jtw2vjdzUoR6D0oVIqkpLuzPftJmoRjeyB3WJHAnm02RF6/hlb8OB0Nop6us7cF0vHn/izhsgqGs
rr4SK5p/YkLEGmD5oudVRUSoN8kvHmQNDnBVoBZz783HfV1topCn8wDxIdsC3FVz6xkA9yd/XcF/
GNmUO7gxpM9RnNCZy582zDMLBaaLUpWC3a21fCD6z54zwRwArgLN5BoEfaQTiY5xPR4CfLzJmwlo
QAVJ/Sac1xArOTjCbZ72osTIpEqtReefoKg0OIuhOxdScBerBlNulf+azdj2zUH4sgktAbhwJlw/
nUx8EL4lE/mSbhmM4dTqs93RX2XbQBRqVUPeVGD0MvYrbtuksqSl2x5+DHV0QflcfR69ZroLChIN
beb2FtVgjmlitHrY1cR/0U7qSFsnxKXiFZhlIpHCzjF2+/cD2/a+HIIBcx9qmESOYnm33WjbAN9w
iBhkcAx39VWDtbdOaH0/BGJFXxEC56cVRx5XAE5koMYiKWAznntMq2uHmrE7RfbvfEzMmOgWxkzD
lfF9GL+eeZ2FV56emcBYJeYGaZjvIw0YgRwzoDOaoBGY74DCjTuhPopZJP4xO7vrft+DlO/0UmdD
Uebx9HD26+sp8CBF2adivVpwF6hd1rugZ/Q7tdi3vub2WjSC4lt4OwT5Z4R5yb6X72kI6F6oCaHD
A04MqPcdZH/lOh/HsLaw9P/6tC0g3YHg4v+3oVCeGO74vd5ntZqjUbcUMOXo6n53C8NV5GWWdmTJ
56En3iEchfV3fruh6eFuyyqJOu5NbztPfkcJawqPuEVWbdOa9iPYRvpymxGNAfDV7N3lNLIfhD7z
9sRVkMMnAw0X5vZ6KUgeKTkg+0Ym5Hka8VT5doDs0UA3yYLim10dJYXRxNDTXtyp5pwOoiTofG6d
zgLPBrjcSQvgfkZHyyHShbsS3hks8JJwdZiQJW4P4TQZmlbLbXCGqA7jblOmm0aExeHH2/AFhLhy
pevTdvcnxBopjYdFt9dc6+8Y3MJ5TVDjdbUUHZN510s2eVGwMdZ7hhCNGohn+f4aCC68nzZ2HP2P
iJG72A4SWFmJvmPt8yNf4S2ZquSb8nyosXBPnpC7C8034ksFzF/W9ixjCuHNxsqE4ue6MP+bwTHJ
wPsd3r1BKMxouW+eDUtNR1cFSdKwylWicHeoNWPullfgsNX3jKD3gRG5V8r5/du3Lg40zuGzqemb
2RvHSqi19FgMCFYF/dq+bgc/FqEJ9SmFN9/UxoWcae8FAlaB1Q1sILkDre/XeCqtK41AY6es8YkC
+SWXXyOhmxVLKatk+frxkXBoeYQvGjqmeljutv3qIs1FFLFn9Qc1PGvHm93UJ2GShnZ1WcmSardt
qeYJqffH1ePixkbr920v+xT6gGumwX3l/arnGbPcleyyCjFATdKhgiY2DODHCYkk9B6YEtr1YSiN
6iN4es6v09JhIV2gBWBsxw8Dw8zfN9QjzzXhIboH+SD+PqVYlwxdDKfLmn7XNQluw4MeEOdy292H
fMweOPSypMU/Ktp+NDppG4oq6N/2zyo59ChkDyww3vHtKvytd9OJfVxWbjfLt7xKNU91GiUKvEJG
HxL3wg5DsszBPwQG31psz66SpA/IMzM8czNh4TsjymQkgKOFEctdiwW2RXwhWtcEBeLXpMndqhFH
S0mvtMdLBHZntzbH33BR+QsJc6U8ClrbSw+FKvmjWXUjCBAZy2ZVs6A7wlT4K6BGiNbsYaG9Rg50
v3x/I0UpkL0IuhB7Hd7/ddSHUbtT1uGQMtnojh8fVS/WYnsuMYfXMjxwVKFFJPsdEpWKQhGpRSfT
SblHoxUhOenYIeARxojDjYNOw9/e0t/O5TeCpm96rA5mGH3MzfrN+uPlYz0nU4JV3xEFnX7cTI4f
c74Tl9LQtLAz9Slli1h6anlNSr8IyxseimtbHnzGDycfpKW/yUwkEczyHZEuq7bWnWOFFNmrK/9c
CPAtCWXDxZt1eP7D7jEdI69PaczraJFj3f1WZ54FAFKEx//gK4Q0egcU1U4mTznqnJTVkuRW4ZoT
hav34W+hkpCl1Ciq397Y9CI7hj29z2KCCFSPgDIzwRYATj5KjAh2IN4sAyAzosxSe7UDJWe3TyMj
iE0CTBhXilcCFb6GjScs2gLRtNywQeaoM0jK99xOt/7NUh76HXjUaQ4xlrRanQJuSmNRd3mpdQNB
piee8p70maUTYoo2fpPDBngqUFE2pGKAkxm/4SH3nyvBGFQMzZGkSTrD6Ra0UE0NE5PvI7NhSJYr
RDBF29MuJgD+pWW9vuS4L94T8svvmkFrCi4TxeIZTEY3AqVyV66IyN9xkThfWgn4v5SKwT5gG5sq
YS38EPH1JvF219K7Bh6mOiJ5D3oXUrpCMOIvfn5i1B+ygy+/YEiFlC/oaXXSSmGaLF021BtstHMN
CMtlUW7ExuZ6F4GQC4pQURgVtwqLqfIVpc6tpOboZQjr0szWmkl3U3nV2chDKCxkVS/4Va7wN8FP
17ODf9IRAz2NF/0IixsOUqoxAWjgTnmpuCYdR2lVtWk4IKs4+B6plwYeTyrT3vc3Q/qlD6Zv/wwi
/RoIfYMFmbGCnBReHcnWCDw080iyM1X3gNA2eQBZ7skXQ4OoDcTM4lQ1Crc1hRlAm+Z55o/HzNe7
qWT7Eo22gaC4HBeEsylIwpZNnHAwgPOrBg8cWcZckzK7fSJpt9k2borzeuC8ICqY3k9IOJkLPAP3
9dtL4cJ6I3amJd0z6BqWQ15Bt8qh75Tt2vtylPIJXGzVMhOpNLfVxmH4AIWpGZAkJWLBZDg7Oo2z
VCXqwT/kUmSeglp9WNq/5VbrWeibacn5d2+oXrR1N+Ju4jUaIEGNFI/VNwHg3yxVRYAVb89DvxxN
jFpMLKERC5idN1jNNwbdGspCmT1t8FROFJIagmVImnpnG8YkSOCaHteYz4ysiAJd+CBy03bEOtnx
4+fJiVL74ynLzexQ00Kel262Pu1XtfLNyukuptrPD+JHyxN/RZ+40O8Dl4bhHP9C7a3x5DzTY1WH
J/cyfyGL6AnUprkSRAg7TuZ+V3i/o23SRstAhZZQN0RZptoVH80lCXH7tBapvo9wcdmOcwabzWH/
ScPbwO6Mp9U9Jqbp+cJlNFwg+UaMxSoXLnAPTP7rF62nOw97f6oQECHpI9nlUr9MlfgrmoLSaXca
3unNS6CL8qv2qFNP8Mwe3EKij3/hovH1jf+tsS0hZqCoj9gTfQ2OJeJQlbKCQaMNUKqGV2A1OTRp
GZkR4YkFtIV+p/AFCf1XBK8YuU5qnQNfepiSpCH9yvcNar0aktFF8UCkrpuWU07eiBwN7nb67DB2
bsxM3ynlXv3xFg0+7hYV+r5x2b6bWUQ1LnYyj/1c07sWmiAfQ6STVkK+bEcR+aJGYyHUKIMWvtVa
m/Y+GJb3cojQaodaFp1VOBETzBTrpF84mQsP07IYIOp/kBme6XnI0+aT0bwEhnJxYibcAZXSI59E
Wg7ytxYocWg+U+oCePqVZHDR1oJlRR0vcD4Uub38O26xf18sX0/pX0YyrKIM9Qkhpqk79WRXcO1f
u+FvM2qvl6rKdBn2mpehsB0x+2DJTG8dxmT5DpJwPAU8LplAoBSFv25MiCPrmFnvJ0dFym0Kg4y9
Ng0AIuctQNbiFQD9aIlVgC5xvdhxeKCfyEkGCI9mmUBlIZ74dGjKXpzumSEYfxoAcP3jBjJft8VV
+TakKvy7K7ORB7OLCdrPBzr8eYwVtWs3nSFsbdQ8JrL6ikazwbdckCZR7J6XUu2LWhDSL6HNJ9pt
yBhTY2tkpU2SpIruUsNzB8gokwilE/eZHKeYHB2n1oziyHQJuA7HHKmYjiro7PEPQydUEBHMiMgC
pAJBQEfAfA1KI0WhxV9Uf+CIu772gBMrCcbnH0YUAjp0dUTddxeVo36myZ3T+gKOZVt/Xy+XIakH
WhT5D/SHggqoMSKGTJVz8d5y+SWs0s+wBg1k11eldxqymOeJCDqtCE6uvo5lKIMS83wg7bmamg8X
GrSWpq2PoR2RkDLGQGi17IhKHj6BAw4kcvgliC4cyNq3v+wAJlVGhyiQ+NlrBoTh1j/wCganaA+s
b8pEhliYO8mghysAa92cUZQC7GVgmHUxRV0/MoK8tWdMwos08sQVJa5NKMrA9aAI9OMb7TJEAgl6
vYXchOkHcZIz79k0uq+kKrvDnNkWXf2+yJMzQ0P7MBoDj/rszPCd57S2/DMx8f/v2CAzGjQ6qwYV
ZNLmVQGa+u2PSOSOD4mWVrF6szpPhAL1X6mHdQVB7M4IdyA9+Ts4n4m+1+dL5n5cZf7NO3Y6hXqn
VHtZi2VM/5KmM3hpuYlWOQOvh+X8qCTJU6240FdHob659SM1VQnYxtgR7fEhvWtm7O7Bt1uctV95
iKtuPpiszFwwpNf6MQK/W0aS7AxzVrm8RcK1fNSGRxeqSE6gJfTU0mlZENJJ06AgRid+aKxXDnya
hCmk9s9tIYyjOM7IbSPyKeg5EpEbt5o5Hk0iCur1kqtMm3gMlpiyYCCLVieQlNji/8sNQ5X4lCSy
3Lmoa9HRoIn/XagQ/PR6VrXoC4oi7ppP80+DDU2qhkAbgOdPs1eUcNDH5C8xWOPQQQHvzqrTizYi
a+DR4Yvs46r0F5KrTk/klXkIIaNXn+xh5d+ejsh9j6kh5F1z2+fTi6UmFKPhaKy22jWoDjPwCDe3
eay0zpN5A9XBlLRBonJ/RXZmwxuM9fAKkmeRKGEZpF/3/6iqIPotSJoOoxYtFd/7EqKSP76Z9XgA
eyvG/2/GQWtXfTOv2uxuaNW9jpeGILKkmuhaMReSGGtdsNk2T4ekceT8MdQlEEIG6WGebL162Axv
Y/jUAGN3i3buE8AwRKdmgzI1CNZu8y+X4JK2WEnqGoJ7nDJPHunBM66t3OX6WJDhI8i64Yyk24bN
aK2/53BKGykMb1tqFqNG10VUidJvK5wjCAlCr1ptBJ5SNluW1v38KPF7X/hS5khaszAmxCTahUDH
ly8HqFpJ1TV84R3W1yNlGt2TDAsEJcmltJE4EO0ZHLnVxTXPcEbz+lKsm29NSxeUak0UuYPw5LPs
8gJgrFoY8jCJvLQOOeHMgCeU6vsGARQFGus7QMYisX8BnZATXUVOmLSu1Rf9qhQ0wPbbiASfupb5
go0+MtjSuUnlSUoR8fhMtmjNfftTf5hbcIh8nZoR1KnBTYoxfRZ1Yhci68T4MBYCYO6ATPawbA2G
X8HBdnqFlGL0VDuTpVQLfwJl6fMNvSDLGZ+mkzHqSqhbzv1+IZtMLqiZJUjDs+nBCqUP5QSwINQP
Db2/gzB8ibLMssi6KQmkVl3+vcSXoxOLO6y8ySiwdXYkVvsKxcS+2AWmHZya6DmfDHxBBRw1GBk3
X0Q86yGDxPrvTuu6OzsEwkb2gKQogI5AXt8RJ5f4sQhkbAeUqrq2rhbTjTuOMpDV0JXPiHFSD6qI
ctmOb3TEAFwwFBAK3x92ApeQQw0wCts67TuwgabBoaXq0ihDVdQ6TldS6o39L3m7qOqoKuz29SuZ
bvGxbFo3kj4QGxE3SscoQpexGykmZOU0wZsJBTPAR3Ua9tEVcd6Iww8Vt53YO9s1Hc5O24QBC21w
rz00swisEZnG3uTYZiLVGXNy1iY6kyMa0W8wnT/t6R2lvDBJwgZyiqQT/9NTMwwf08v7OwvO/+HU
8Fg0D0Yn09D6b5CdDmc/OS6G4G1DYiSJCtQHIVmNH/NgurVa4YjT5U0loaNKCLEPc128F647hqmB
2Ox42NlXEu/YAAT3u1CHrYhVtuHqVzfGimEHtFtnihsW5qiugnhsMV4NbncVMrMJaEFsHaCXgGog
Ywnn8Nwfwox7UTTZWTuwDkO47USf/Z6TYd2A/NvNru2YPErM4BIxtQMa4xhBq/83m4yVV6T8oCwN
ZI8TkXQuKkaeq5DVUIG6aa/NgV03zh4j9QB0C0RVktUpOdbLH08Lcw50W2xYnzjeDsoo+SHhL1zJ
huAmOrikHLZx3LjIZprKvS4oWiv7wsCb+f2UNoN2m130F+gly6szraesAH86uQ3FoIlx0M+FBE75
GJX87oUpyYA+vKZaUkhMVP9HH8cyg6Ekd8wsBai+XnepHwQx9Ww+L7jdYjO+LHGVhxH/TdhYuffZ
3MmZoYNSbQOUXrxMp9d7wFFXCFUJN0IMw9dZRWoEvvml2VgkeL+FLoNN1ZLHEtQj3UEznxRvpB/c
9rG6YZ3CzvbzXyo9zTL2GGKtZVO9sYrv7C0UGo9LaaSJLvIkHRO5gRJ4aBrNENdQjpo1lFZcWqSZ
1OaTYs4DIZYiQN2gxify86GP3vQRBV2x2y1/sJLSBj/TOn1Jfc/2g8jO0UlDKPWxtCMU9355+qGJ
AAx1aNnCgdJOIY6bEfzV+NPJY5ibaxMpUVqz+WntFI7Ync41Gh0Y8N8hwNDuAZsd5q1nJZ3yD6cs
cFzeNqQRSB0/zk6NgprEzNI3jqGLtUcpW7y5k8bLSpyQjEpgQ9JdySl0yHLafis9ocTAHUPj8ISY
dsYh+NKEI9jDLTL0qq4dkybI1+AH9FB1k7xx/85B1A8B7vaLz4p2i+tFf0THm8WdQONM2ifykh/a
m0oakiMVR4ILJhg5eL92vT5GimsRcR7RI+Tz9shYs/vbPtclmSxAI2NgxGYEx0k/VGFqRZ6cnLH7
s61skSKT/qNMkvMCJ1js732aFKNO7oUfkxbAPcciq9yisprfvvLxIi85YgPyRQ17OhZvzfTt8C5z
RBwU3ugNLIRSwB9XjT+nk5NxpuHrckrSZGNVokCBc/oCOuZaYArSg1S4Rx9KLawVmPBtGKZ9gCZ+
DW5aKStzxR6HK2vEo1Z4VZEPfZRzjlsgmsQUyVm6YKX3A99QeBk1OFF3lR1BgNHPL7sxlcdj1qYh
pQB6lLB8+Pf3KsVwWg7cDMHHCKAx2cf+Xffwjjf/Vjxr1PRT7Mui8UXLhOTDoLUZFcbxoYp+p42I
zfQa197M0t7W7u18K7I4YiWR8ItSeFNsW/egmEKOHBlnH2tmbDrTmpIYY9+Z1OPVHAr0Y9PJLhab
vZAAPsci0Mc5KcwN8unFITrmXiJAe1tw2IWLmu9Cc7LoIGMNzgpb7okt2UuCX8/eGQ0lCzleP7aX
C4a56eTz3VY8vzfkkjQUhRqe3VWW943/fyTxqIqotwiOr3ibG/2Uz+mYC85661283ovdN+1MJsP+
M6mwrGUWsqoCuHdF4/vQ8ZCG1WmiBDjEH+Txjxj7/BFfVClX5eoJm71AfOdpFtvGhONksMclDQGz
4/gqFmJNlAABGJEVajiZdi9G8icBzu/C8v3sKuIv3gKCZW4suyNJkMrDn0cmcyIDPvTDGfFbmYbX
tL1+kcX7THXUoHM0T3iskhkStHAXA0ydTfTB9AEB+ltZT88fJsfJuAfEz0Q0mukzy/KBGWWNAj9w
MDY4i9nOKaibuM8rrZHbraLc0hcPmq0y18t9qGbogSjvuMLk8dpc2CRMlt6yIxVIdgk0HBrEBsW/
GIhZ1S/8WfaH3Al0POTlADxdyZnb0Byxi5Unqss3i4Yhts3uW6BjoqGuuJyi0+Q01x24v9eqAFdj
hDNyEH106kfJcTwAsGAzYO7KFs3wsCNKrlkjeOOb+Z7lzW2eDP2FWzd0aNCACXZCFdDgciFI9ifN
D9hFliZJCdmboVMmqLiDZycw52hhKUAakvKF3v9hDlaE7BywpoVIxdhTNOKQdtQt3ba5rUBxlIYJ
DUAkjTVupiwOUn/cmahLCXrq4/OfWfJmXLeiRKUMdVpBKpaHJm+CYn4fCQNEbgMM5gtN+LG8maDp
FPx33EAtmFjCUr0OaKa42rvoFSPt0Szwe2DRpxbtEAGpzxf9KrR4kQkdGe3T/aOQ/IDJzpVXAI+R
ndTOyhG/w5sAXJ2Twvgm6SaCKm/zXxOxOUFvOSe3BXEJBU9cwZ5gL5SDGS2Akzg6MAjwMmxHBiox
s9YGMFajbAeoQzKrKfzJMWS+5NyIPUWg8mAL2MqX+6D7KQyj0lka7VQy85GRPCykMODZq1QBw2We
XEi7b4vx4wuLMOAZ9cfYFkhtkWVgfpuHt8qmpECzKunMisz7DUHqEuLwmwPgTQ6IKP/0Epha+dDC
vBqlauFPq/dv95CdJ6U98ZAusbGiIB2HyhuNc2BlAxb74bz1hOmK10frPhArfcpmD/+CJVA5Semw
nCLI5v31Bm0644Sunwunc07as1dDy8XnvAc10AE8SSsRbstpzeB2zQBMr6uAZ3IRgjlpLHDwE/oU
0m9EJeiV6wkaqdI/ON6WiBTXnAJCN/bMBM9S9wX/1s483cUpgM3+POJsRR86wpyhqFHaIt5IUq2z
jRzOGrxXbyjyqw0gkhPZjF6r6OwfF+Q4pRBqo9zlniU8f3c0wkpgYdxvSBpbBWMxOZfgtTM8O7NC
RT5S15fPat2iuQFXaLH8xbBGzRUESNAFxndg83T6cSmnpV+ZGFQZGJDGsH9wC/x3TngClYu/2I8A
Ln3b3WnKMYK+qSYLugAOTgJTGCEkHp2SpVe5LnIrvRpWJ90Bvy5rQ5Vybam61vzZF7p1GODFxicS
cn34HZJJ7nuvzVCbVIBxarVlZyi9RwfImPnUt1k9tb/2E/6POahpynK3nuAsNa0z5Efe7PpeF9+Q
VIoR9qrxHVnZIKfr4FUQOEH9kiUeaLP6WLB5thofV8d6hVr1a0kEpMnATT+GiUbHVXIhJxIpCx+b
g0ZN3U4/IbpQdhXnCyd6RtHIheUZtciJO1hw4VCHWYjKV0aXbo+TsCJSk+r/UTABIJiJJG5HucF2
bIMt9Jj3twA5You4dr3HzxaZrW+l3y7eb6r7zWe5I1ABTtnyTWyiKYHB9LzGe0C/aBwVhKemhtNc
pT6Ogsl/ISM383E58d/XO3momnT8PlRGI+Zy9tyPz8Bm4RrFIpj6nmtko8CUOjyEVjPqI7jQyOZS
ut7428kKFfuIkRyny5p8Hj2AlSNWTR9QQNGGytqRx6EJD62NuFTRJCfe7IKtO4VTHp5IiMtx47J+
Hkzn6rPNpV4UGDMXeDVlKjAONd2D6kUJWLR7DyAYa5nZYwTspfmCCXmpqCDAu1CPdelcnMtNCqdo
pFeblHoE2/6XXSC6byrrT3RpSF+jM8cQmFVltyay0hQ9U2SNCAkapC5jPo7/t3uuCzGZ4yO1XMvL
n2LkEw5dqFv9DPvdfZgMPX7SYyV350P33BuSfMJK7FaS9hZ9UX6p1T3F9qmHcAVzQ73ywdaPp53w
gaYpyZ+sJ+wdAS0pYp0GDB5bfl1g3cs6Rl9ULbovO7y+YfXTCJGvu1KkBJsdAD1biR+vfBEvz5RX
yJ/M4xoLceH5Df+rt0Fy+6aHFQrKII8iFZ/7cZCtSGzfBbGl2RTyyKWKdLqlGzWYlaraA0scKfNh
MMsTz9ULURnRUw3XVC4cnsz1lfZoAl4JmY+9duAaMtPe+ohBIP/Z0Rschik6M1L2EnDdqGF1IYmh
ID3niDdehvRblQKoJ9XvObebEOUzmddQxhn6bxh228THNwQnIBdggU065mLLpOff/JgJO3QVr6zD
jQv1jrR+LhhlCdElFYoWqIxLWTd8ktyxTBG4VTshcNCMKQgQ3Z2uXxW59B2Iq9M/5egp8rK8mzMR
0TlrCHaOdf8GyvSv2yS8dn9Hb62ut8EW/DN+IPiox92bEdA3H6ZGifXpFcIQdtmZfnHhjhZs4rQP
cQFU9pleRR2ki1Gk5UgAl4hh3rQXj9xnsO0SbWKJEf7j+zziqRH9MwIZco3WhxhSLxRYweQW271I
fsj3JUJW/Srpo/shIWCOKXSVLkhWQhhNoXdVgiZlo2qM/juhOw0dzfXNc7Ug0A3kd8rKbI+m5LQS
j/OFxDh83skdHj5HusPfaC8Aaso5bqucwlPHFiwIzgtQx8/gS8PdFCPkNEsGsX7HDKb7WBGE1LDn
CTqB/2pF5S/WF5+SnIavvyF8V6RmQwX2FxYKu/hGGLecp7mXPRT9kLpTDR0rjBCG5Ccoaqm05+F0
yzKtft2wquETVE3s+hE0vIDbANL+ufu28j9S5CIsefAgUeKFGhCZKIzZE5BWvHrJTuKex9fZfpvR
cmejvAtZzSCsfAmJn+G0sQN3eH3NlC7KnbcOM15J2jAwVi64+c7I79oMpqIT0QQBzb1VSa7jxNNa
9heVmZ6NHOCjYq1ExGdZ1zXSBeD+b+NsAQ6486QRd2MKJCS6YldFUKpsVAPuaQmHlSbEF7l1T6gq
p46h872evCmjkMZGFGaCtVz1CLcSYMryATIVrgFoJE6KXqF3sSJIfBrZqx8wDU3H11BFI7KcR8vB
x3RgtM1H2LcOs4qnxZTU/jD6tjUKrzNFHNEGncLN4BbQWJuvDhDVedGC5ZSpPjlh7f7JrxtrM0QL
T4SN4bPhWwc/XoEjOzkRAhYcUFfd+wCfeDFBywDyCp2pWUCXx37N+L9hLEoSZ1RY1c7qKd4alhQZ
GwHoaERyIQYfgm1+PKYwgk1DPycbdTg9wOaRZ1ySnZDjZuCxHnglh4sAxvtE5Bd0BcTB75xtGox0
qNuD2ukjpX54dW/BNzlallNdlW04wEafsFbAB/TRhfndti9yfdhGbi0womInTzxTl8ECrhloLxv6
QY7zBtQedYH5RBgc3KXhM2nS2t0RRmpgVRV63bqYiF8y80S/pAOZCEV6E0+Kc9EIk+pfvs6gJgGQ
HdKBed/HGccGDcapDzfkiHP5Jnc5WS5N3SJPGhc5YfCfFImE09fWRAo4dPYGVbPxRjIyo9D0DqoR
IQns2HHRmwQme9KyPiRV3HLxYxcNRDLAihY78FyWj1iX8moDlq2pq2W9vMls10IaxeSdTxLtqduy
rrijnTQFpUlHZc8prx96Xwlo1s4zER6reFA/UAaVpICeQVnxqNuD0pB2ZUskrFlD+lwrSuioNBQX
zACewmJy+1OlgrJkRvaXbiAsY4twTRolQPuuSjgFJwNL6Z8/vlRTIUFduBk2/PTDxgkoUEZWkdhA
ZkKBXWHX3HnoD2dJNC3LbisqZsZ0WGlO2Z+gKZ+Ni6CWuOaBlQfirQgcxw1caX7c7vUn1lRbPTFB
1YebbOBaMDnMQeMR1KyKH3RxK9YhTQy4R05TofBBjwXND79EE9qD3tsD22pYM0XTCyjKBMOJPbWi
XOcwAwysv8Q1lOwjR+VVwRD+2q4IsQ0jr+2csiJQ/54WJIpOtTrrIfw+wOEC4eNZ7vNqYJbZMydY
GAdVkpXiuBh6VEmkpCFFzsL4fCqJjLJ5L9GGmjAXhCE2j1pDx7tg0P/aWjT0Iw8MH6QFitPCRu8B
MFFqOb2B1ndfkz0g4qXSEmnkA/Wik2LiVoYBAlTWnUhfNJYjgdb3tY1/Cm3IMiIo77CTaeOKecUG
HQ9HlWQTMe6YG492JmxmaE4oYmqFojTB8appi4mFoYgkLBzSG1+NLzTNYTUhmvOHcKpdTIiQ0esN
WzQGtofo6Z5Dk+e6+y7ogm23m7tD6p/Cz7uu3wpszGIw7EGYGO6r9PPn1EfOcLtQFY5cx0PV9jg6
efnVXaYzQdY8SuPsJOBMZcSTfSWXxVYwgpSwTOCBrbSUHskEzm8LAf2AAk/kKdlu8z5KkUnwJfQu
5UPdUBRHin1wLTKn3pqrLVFPhp1W5BA6f6vuUY2mjMSewAnHnHkE5fNZvl/PCaYwVjyXu/0B2IzL
KchNPOvDjigRLXOXsDy+QPwTyGSSxTdktgwtXK21yrQhsN8o4WbzwVTJBlLNq5bNI4NGM7djssnx
a5f7D8EuSzQUWDqRQG4rpWkgD+kJ3fVNoB4K/jpiKU0yybWl4/KO8I29uW8MgMvUEFGtknDp9V8J
W0CVV3kS9cdJXyjmyMffEWZqgQCSbBaeyjmadtPJXwrSvhSi2496MNGtE+9iUWSAltpyhc9dEiDw
SQQs9jvGO2xWLzs9FvRWvYI0MmBMfM2FnxMiALduYhCwbBcotbUXl8Cu0LiyToQaGhW4CjNvSrY4
w4tTgUxff2Iwpe1nHyf86Wel+ELrf/grVI0E4jfMXvzZF9GfqhWz9RVU+2mQXaD8fXmvSpa9bbMh
4NC3+NocRjKlFvkPv2e/vjXnxjK2KlGgDsuZBuzzwXb4qctDo+bv0g96QWu5UK5HmfiAycgITNDk
z9T8ty3Bi2VsChLposiI65ewe9wIAP3x10pLg+zBOS5PrwvXlBH6b8M8Zi/+msLHRftF79x44/Uh
IuAHmRzZZ7npq4dLf4S7eyDv0NMChpNizDIjmhpReg4MydqgRDoAfgcPzGkmtQ1GthVZgZ4xQnZG
HCpDux58tFRYz3R0blsy8/vSGFfJB/YtDZJx82MVx9MhoxKVcT0eh8S/emQ+D2DCmtBKy8yks53y
D51U8lTGkmghMtRpkY33j++FjZIiOgzd4sgAi78kAiP0eOQyOSCFqrY1LXMwtrYX/lF2Z173zS0c
d4fOpWijxeF7VJjj2BmucIw0pzDFBQivdq2IR5g0yN72G4lobODLcyRU2sVKcTsYTgMwxKkoaleQ
R36IgYr1qZB0IoenCJjGfmSKF3AQzAjnhPHvbWrWzK7y3SHPt+4X/G4MjgbSjNB9EmwhunYE2NXo
buMpF1vYQKdVNPcZHCNxb7y1Nx5Nrn7wslm8Anx/VTB549/Cb5YKkEykvawvPiAXlMDgx4maCo8H
AN15qSlEw5JPfnXvgBz8VwPMh3inUvpdkMgQJF7U5K6W3zyqHs7kgXG0o6tkI4Qic2SPB36uAQQD
zHXdxpSyIKzBpPwAq7smkrL22n0O+D+UavJoDzbp2NhZmcMppdOAivOBxmvasjuqBp9uk2sRZvV0
eIQSHzGbMAN3zse1xXiq1Q88MpZmYPMBTCjwOD1Bs7BfRzFwQkD/Tsgq02WMRoqnvLM40yAkjdzv
KN9xoKJWvI3RODqAL8b+mCvxrCE7oXCIbuIRy75fqcuHdtopA+5BIUeMWuyoESjCQmilByA/dHMA
u0R/EC5wiIn+pnwcwewa+cUN0UWqvmv9yJ923JtRPgvNtbYpeupp6AwcEXFohoAiH3XPIraIRpkr
5W+JClZCDvJlHtJ8Fbnqe+7dgar2x4foQR+wuOCSunuvig/Bt2F2tKWY2EKEsQTevRBNSF1E9Ioq
7OMJdIAf8iNsggVHe1MaKsscV1zlUVZ0YO/BJxgMxx6i/Av0NaPYXrrkQi4PQOMcGRntluY27PYE
9FjjZLnMnz1ecsLlQHA7lgnrMKFffLzKZAQfSds+6C3/vwILjvNXJD3w2pXGjeT//fJj8LiWaHgl
ZyzSazrSiqkAZlQBmIsFn1B7RAPgefET9AKzxknn11nQK3E+TuhBzULX6fcycC4Mu720fCiNrHXf
adjdyIY93J6GPnkHGAFnzHcrgIg1J2zAaezVa2e8HuIfOYI3s83GFNxIEp6SQBgENJn4ff9vX7PF
6Z0nioQ31KN8pKVD/E/LuUm8Fi1EOduZ5QF18McInY3Ibg79npho/NhJEqA4Xd+I4fMRfOWRjVtn
uKRGIzf7bfnpctlBrXjU1NoKT31F/SOjOyOjWgz+wEHcprG92r4iQOUenM50mZ2fpX+tKBmmCqQI
8GIUjzLfYgMi1iYXsT7VSWp+lVvxjhEFty3DfqPmwEZYh15zPbco+bdTzjiWzs3J4WtNGlbLSkTm
WxSQbFiNIvK4uIdrOuiCcKIGi/Bg7B5az24MOEyPLJYsmvwhj0Y/DhDgWd1XgKWXnwEVbmM/IIXd
MqTQ8/4UJacRM64MU7JoclR0/0m1EFBzP1BDZnjqhr0oeSsT4Cxm0DYSpHwVu2ukYFG/a37P+0Dx
STthFebW08fd/iH8d3UvJEXUbuTjyeJX/ndTfjofTP5P51ZWQ0sic8RNPO4pgddAhGZumTEZq02h
zvu5wMN9dICpssdINwf5rHAKigLoncMd7uFgsnTmofrhdWQ0r00XNgbU5gYlhrR9AJPReOUgo0PQ
wU7pGWz9pVYET7AbUILlUfoyJ45snaqyKc2/O28zRDnsPG+1ab4/1xSgOZieB+gspNG19r84e04g
Roms1xg4bsPcPeh0VMqt26OehTMiGIuicxG7cSuRtb91Eu0+/Ps5lH8MhO0UOn5tn5gzcMytWwgW
ix2rgYi/RYdV+5jEnFjii80kWTh9fqtuaiWmS1eMB+FZSv/akD2epgmhH/dSzT7PhbJifJZFgxQ/
98cwK6FmJjCsKtefaOa/cnx0+sKkKU1aHPcoeWMULrMtMPMv5vYLOanurvcOtC7a6xD298pvnWzB
NK+uoWD5eZyIAAAA6SC1h9pjlYwAAcLGBIr8ODdp6wqxxGf7AgAAAAAEWVo=

--8bHpOPWk+C3IjkL3--
