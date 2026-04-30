Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36B127CB35;
	Thu, 30 Apr 2026 02:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777517484; cv=fail; b=XPlCAwE1BcYPaFBAvrwRk+dykENvfhIo6eTbr+FDY0eP5iBaIuyW/Mz7oB5vDlohGnnMsX7J5eEp2fWbn6Q8NxeC4AMoMXuxTccsaGjaeYuoYq3uLMoS51+Ah53Azg0nSOPbIZnLV6Tpr1TDGjt3dT2I7RAnvAmErFOpJM006Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777517484; c=relaxed/simple;
	bh=B/1nbb2drHujmXLpx2IwYSOrIrXrzGx/BkixJSORw3k=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=tLA51RdHQAq+1VtlEpJkWuv+ZFxhYDd1A77chVoTXLJOlYhhaZ+vqsNf6myKxB/oPgxAmp7Rwnqh23vMFtmUZgIq0IJRC+HQKSDg+s4zJX8XRYqItOPUJ8ufIItfgYPbpfo7X9mL4YaMMD1wcq3QHp1uYzSuQ1KU6zPV5T6rXDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cYD4XXrm; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cYD4XXrm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777517482; x=1809053482;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B/1nbb2drHujmXLpx2IwYSOrIrXrzGx/BkixJSORw3k=;
  b=cYD4XXrmZ08zp8PpDlH3s431NYa4r+AfLZ4t7koYkoRheuieTdipaAfp
   uCUGvjMWOgfj3tRum36tSRFsoY0CEpC7Lj+URRceVm+IAw4JSIAXRH6O3
   9H4F+8XQTjQuw/lwqM0FUKQYrQvSY0WOnHcGj/3VrRYcorglQGc8LDBCr
   M0uF0J2A/Smx/8dMNmxRgd4OhoeE2jgQaaW7kbB9b7oiyCEoXkHIru0SN
   XW9zQ9BICrQqzCtz/fi+n5CoZNq35L7wU7b0Ef16J6EhcNp5+FNI/K6mH
   Hm/N1kOW8Sfks81QOQL+riSWVL8S0aEZzvdMh/5/jSK2Hoq9SqtKf4nIF
   w==;
X-CSE-ConnectionGUID: rG65pQfyTM64llOuSAOFfA==
X-CSE-MsgGUID: wOqpuMffSE+NfqLc16Uw4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="81033310"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="81033310"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 19:51:22 -0700
X-CSE-ConnectionGUID: JVKSey/YTxi/wtCmTwNyoQ==
X-CSE-MsgGUID: RWwrlXe4SMKbe0xOlxheAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="229844366"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 19:51:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 19:51:20 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 29 Apr 2026 19:51:20 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.69) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 29 Apr 2026 19:51:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GY7zVIrzA8OpboqZcFflwN4EcV+w9+HhUJDaQGq6r5WmbcMGtb74+c785KFpdsBAnFm/bhnD3e3ZYfCrubK1Eef0PYGhqAlo1HsGgtDwfu6wCbActE7ZUx1DvzoPUBiOJqS5EfclHuFpoZg9OhRivN63uDi/X49uuTuaMcEKxl5y2KQFxfM8JPR8Mm2KUnHZ68g3q/SV8Seo+6SVzXiNsWBhPYwQyEHIi5apBHHOWlQJ2tnukTYrrzGk+9DHdky1tfMlM13ERbnd4kBotQUgRzT9B8jQ72vNj0f3tWJ5xmp79w684+8+y2gdlkc0O9j4rOivDPCBDbt9on6HgXZvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJty/de14af24ZT596JDIQC244/4RLIwDxyDrGTpDNU=;
 b=dTCdq8qrUBBbW/+4uOrvMblvZrjYD6uhuRphQUkhcDeNIcP7mSll91h1tYTvrm3xFHRjCesAopwGb1R+oRSW7TbRtjc9WKTjN98EitvJepJEWcv1EVVi2vCX7cyR9DYB0GPTc6j9z9wgtmp338iRPNXmD5qsPTQEygeuVMuxQBAJwkJBZx87t0ZCx37dHT26tIdXPmpWm8uE0h9rY3Juqgfm4cc5kKZa2Fs4xzHMzUCu5gAFOf9Da7bqb71YwIixZkcUdBjCXaDXYQwB5PnvljnRcPyAI5wnPorKbreGH4gLJbHwbJzUhwJJU7unfrECJ8iPM3xsGoY7BEOwvQcg3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by PH8PR11MB9723.namprd11.prod.outlook.com (2603:10b6:510:3a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Thu, 30 Apr
 2026 02:51:17 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 02:51:17 +0000
Date: Thu, 30 Apr 2026 10:51:07 +0800
From: kernel test robot <oliver.sang@intel.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>, Jann Horn
	<jannh@google.com>, =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>,
	<linux-security-module@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [landlock]  874c8f8382:
 kernel-selftests.landlock.audit_test.audit.thread.fail
Message-ID: <202604300436.a07fae12-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|PH8PR11MB9723:EE_
X-MS-Office365-Filtering-Correlation-Id: e6477afa-1562-43a8-b9a5-08dea66359a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8JwxEP87ICbNwcx3UAo7MnKyyExIkM2qiBOH3EV8z3JnML7DRMdwPzGe1pas/mJswewawzs6f0dgkow0GSQKPSPLdn90FvhVMrqwsnKrS9MxCO6ChrmKgeqiwqtYjNJoiJzE0v/rlv3078wb0aHwO+RvXqyZzdJAV8o2DbqG87mp5mf44507y2QNR/ve1HfFysTzwISvVwkbsYLPYSFLWRsbYiJ8d96Kqf1w/4Dgnyd/yCk+qdXz4GoyGyzUufXK/mJJwlxxVYgI31Z948oRBS+U4KHJBM6zVNl/psr2lpEVBNTxiUDu34W/c+ZoWjl2WOdxgcPKxXMvVUsOQapiloXOeRMln9+HjA+9GBlKiEoAeLwjB2v6BKhux2CmZzSfreQC9a/olxT65wuOkOKWTL54kK0YbhTfMTSv/U4XgKQr+Z9xVBdgERZdYCqX9J0VeaKGvsbrVoFwhr5BurrA47i4pkC+e/zdGF4UiQLOJ0rQgK/DYZJ11UxFI+7Moj+81DHCmevVzDRfIhfMvias1VfPdlwz2DNuB/+xnADvgFj+sF3mOc0azwsK79AGdIvEere+4m7oO7cupx9fN0RVoQ/Zxfi9kUdX79tB2meVAxNlP9sobfsktoPE3BTMD87+1JFpb7GARQOdeF6ZfTAzbLXrGRPDYeVYJNUqA+PRWHCFAWJl7mDLKq6B51IicB1B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e9T62REp0h9l1GbeVgVjSWBdkIetoAnl1LOSPkLXsyeAWLD+TapuVIFGSS59?=
 =?us-ascii?Q?qkBLANAx5J7pRsd17JDiko8rzBnOt5CaMobo9e3ceih1iQOWY82IdoK+K68z?=
 =?us-ascii?Q?U9Lu02mVVDMtEfiBYnDkfMCDZeAUHTA1gtXe4mXd+aebi/cdtef7nWn9mJLe?=
 =?us-ascii?Q?QvL8C6X260DkB5zk9onsIENNbt1vuFtKxWy3CBWxyOkANIIntGeibkdYDg4b?=
 =?us-ascii?Q?nKEEWrKGAIM7teNc7OSu5HxNeHkc2DkO20HDQD+v5FpFQwOa2SHQ229gngBm?=
 =?us-ascii?Q?hdXZVDkbOUnXLhT/9v7rUH7fdXh/6jo4z1XC1TfeOvzTc3gUYyloE2MB/vcd?=
 =?us-ascii?Q?FwI99YTdeV4nVBMeotWIFqsZcFnSPim3jSNAUweCbCZkOATn5eJcU4j2EQKr?=
 =?us-ascii?Q?We5zZnYol/NrXZO4bPoIbx/JPClNPnd48UZGjbTRSEvszeWtwpxl16oUwulE?=
 =?us-ascii?Q?wz/lSdBSCZZUqQc/2yBGT6ktBnBcHYiTSqIc/gC5UghXgGCZm1IC85HRZVkM?=
 =?us-ascii?Q?jDwB6bxaOYOxPVHbYSspy+jqVsnx25igvEvXf2p/wFJMUHHNggp5fQVlBIG6?=
 =?us-ascii?Q?yJwD08kE6lvLsm+3cq9tuzK//vtpCdHLcHgmfAyqffvZhp1jcl2LGKakkh1I?=
 =?us-ascii?Q?iLS2nOzVuYuSWCtyUov1B34GS98Ars2sdIHJEdr5wTwHkTCXki25ruoicQvM?=
 =?us-ascii?Q?CGf8DMcoKd9NMnWDgQwJkNa6w2YZXhoyH6m0wlZr6tLak/TxaYEjPTFJjDDv?=
 =?us-ascii?Q?tbGrbQHFLgEvuOEUCNW9EXa/wIdjkWnCKQQxk6Qe66v1L1B2cOUZVLVNkoa2?=
 =?us-ascii?Q?hUu11CUMc+AjdVkNnLy+NcEGVmFdHW9TYh7Ycy/kZ86vEh90G1O2PDqxyzt1?=
 =?us-ascii?Q?3V3SnaRFaca/ECV1TLQWYbqozYDdB2qkIOlJnJSq6v+sGjJ3SQxzZDLogKTb?=
 =?us-ascii?Q?6ZVIFdLfn75aisPxc79lxW+IgOJZLkItqqdHLuE3Swz0zcSKADgInyhpavgK?=
 =?us-ascii?Q?krEBc1B2HdU0trCeSAifgHlF/2dIZAc6VDmFjZGnIGrYVea4FysxJv1uGJ1D?=
 =?us-ascii?Q?5sR93Yy9mjOTJSrhH7TVqdK+mbckzJHLNMPYBWrs7aASxBFMqnrp1wgaDZF+?=
 =?us-ascii?Q?o6/LtCw+Di0BLIthZvLkBxti5irO+oCCE2o3QnlsW1veJjOVHX0YU6yMz79Q?=
 =?us-ascii?Q?TL2CE9DZ9rIFu1DljucOMabA2ytikZcgF63IJ4vAACLvne7eTc2zwTOousUD?=
 =?us-ascii?Q?5o5vBJSuplDpFGpmTFEgF39fmm1yOE9F5F75fLKjNhWwtTYPeoNwpuAVRBpb?=
 =?us-ascii?Q?Gb2t5ZOENworYbfDXpAktvIPA0v9bW/zU0xiHpeo5HYmC2e1PNw5auQpCKjW?=
 =?us-ascii?Q?96SxFYn36b8PUwGqxaTQT+oc/RIHSX3b/L0dU29auxVW/hosNx69LOV9C8PG?=
 =?us-ascii?Q?DMaaHHtYwP/lm9F6xbMk4XYsBGkqN0Lw7Wrff+cNjhOrFWMIK2qJRpwrIHKv?=
 =?us-ascii?Q?ms4lczSkOh5rcwNxlfs1wg7JbCHorwiJY8fl7LoKCTyuT9DO53BnQXalMtqA?=
 =?us-ascii?Q?vD4QZLFQacdkxGRH5KvyQY2BnjDmIzU2sUbRtKyVZb+8zwLO0xnyFW8r4kS4?=
 =?us-ascii?Q?QLLWrSuTfmoKKCzaCg3jl/6ZUXZfw/ZyD6AudkHX9TullXqo1HGI4kUiMlFo?=
 =?us-ascii?Q?+JQblzc9mo1l8f0u3qa/8LVdGQ8kftJ5BmVz0hXZ5+dLQqPNTJcykVifCUEr?=
 =?us-ascii?Q?8jOzMXFLLA=3D=3D?=
X-Exchange-RoutingPolicyChecked: KkdPfJ5Urkgs7S7H9Zbs78U7FWWaDAav5dCR1SDKbbAmHebJ6OjMTM0rypYOZZxhE8l16YPivs5H+XimTwEgNTcwpZZFIxLG6RZJ+gwVwd7hjglj7nXyh2EPtna3fmwLDGnWsC1H5TxNbrA+9atpolZkXPC+OfZUK+zkZpYv9/q9eK1pV7xu8l2FKUQWlrAm6hEGM8+elG2H2xeu5rHyUanA/C4yiNgYiiaEwAgnoTO0Pype1AkgE6n6Wqq5xVK2u9akg8terOiJMyqzphLf+LLYnbWplyO/pmdDoHkkn0X7XDaBpNpNFhJhhC+tVpUgV99OtYSeJJvU4cyqbNZ3TQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e6477afa-1562-43a8-b9a5-08dea66359a7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 02:51:17.0530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9201Qu3dvI52RJxMx4zgsQUi/E7xQtvH+3hsmC+3tDUXz2WHg+nFx05OEq3KzO8kWWW9b71Xa4KOPESCB+an0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9723
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.landlock.audit_test.audit.thread.fail" on:

commit: 874c8f83826c95c62c21d9edfe9ef43e5c346724 ("landlock: Fix LOG_SUBDOMAINS_OFF inheritance across fork()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      dca922e019dd758b4c1b4bec8f1d509efddeaab4]
[test failed on linux-next/master 9974969c14031a097d6b45bcb7a06bb4aa525c40]

in testcase: kernel-selftests
version: kernel-selftests-x86_64-9f2693489ef8-1_20260201
with following parameters:

	group: landlock



config: x86_64-rhel-9.4-kselftests
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202604300436.a07fae12-lkp@intel.com


# timeout set to 300
# selftests: landlock: audit_test
# TAP version 13
# 1..12
# # Starting 12 tests from 10 test cases.
# #  RUN           audit.log_subdomains_off_fork ...
# #            OK  audit.log_subdomains_off_fork
# ok 1 audit.log_subdomains_off_fork
# #  RUN           audit.thread ...
# # audit_test.c:252:thread:Expected 0 (0) == matches_log_signal(_metadata, self->audit_fd, child_data.parent_pid, &denial_dom) (-11)
# # audit_test.c:254:thread:Expected denial_dom (1) != 1 (1)
# # audit_test.c:257:thread:Expected 0 (0) == matches_log_domain_allocated(self->audit_fd, getpid(), &allocated_dom) (-11)
# # audit_test.c:259:thread:Expected denial_dom (1) == allocated_dom (2)
# DATA: audit(1777390809.810:10): domain=1a323af0a status=allocated mode=enforcing pid=2437 uid=0 exe="/opt/rootfs/tmp/kselftests/landlock/landlock/audit_test" comm="audit_test"
# ERROR: no match for pattern: ^audit([0-9.:]\+): domain=\([0-9a-f]\+\) status=deallocated denials=1$
# # audit_test.c:275:thread:Expected 0 (0) == matches_log_domain_deallocated(self->audit_fd, 1, &deallocated_dom) (-2)
# # audit_test.c:277:thread:Expected denial_dom (1) == deallocated_dom (0)
# # thread: Test failed
# #          FAIL  audit.thread
# not ok 2 audit.thread



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260430/202604300436.a07fae12-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

