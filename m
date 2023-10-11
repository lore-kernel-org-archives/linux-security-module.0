Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC59CD6E54
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Oct 2023 09:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjJKJ31 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 Oct 2023 05:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjJKJ3Y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Oct 2023 05:29:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C280F9C;
        Wed, 11 Oct 2023 02:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697016563; x=1728552563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uOn9nCRKML7IrJqltDC1Cnn+y4rvEVeFVa1KlsqUdw8=;
  b=nKgb3IdO5KhdhbGRHSnZ45XA9BjS5Q0gwdp2TUlvYaELznpfqkqeqA5j
   a7r4e7aYWtkeuB+Ajz2YEBS7uiyW8+eQkJScuZrwTL1MsFEgvynOfx1u8
   4FDe5v6IN4PXH2r7QYEdoUbpYvMWZa6Yynq2/rcsEKlOQLJcR9qfmsaVB
   QXgnGvQ4XD9gsQpRRJCoAIAlUT5G6kgDhaqirEB12kAdzvsFnYC6FTv2K
   OfvEQcbdbIECyen7SdQYBiOwh5mTnxYMVhq0RUrZWFErNDSCWrSykWycL
   f/ztYYVPmHtf0mQqF3+P/1ab6KdcMbdnSKxv3RHQ8/doyH8aO+zpcDFnN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="364903691"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="364903691"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 02:29:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="753753766"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="753753766"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 11 Oct 2023 02:29:10 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqVWK-00024F-1o;
        Wed, 11 Oct 2023 09:28:59 +0000
Date:   Wed, 11 Oct 2023 17:27:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     KP Singh <kpsingh@kernel.org>,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, paul@paul-moore.com,
        keescook@chromium.org, casey@schaufler-ca.com, song@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, kpsingh@kernel.org,
        renauld@google.com, pabeni@redhat.com
Subject: Re: [PATCH v6 3/5] security: Replace indirect LSM hook calls with
 static calls
Message-ID: <202310111711.wLbijitj-lkp@intel.com>
References: <20231006204701.549230-4-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006204701.549230-4-kpsingh@kernel.org>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi KP,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]
[also build test ERROR on bpf/master pcmoore-selinux/next linus/master v6.6-rc5 next-20231010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/KP-Singh/kernel-Add-helper-macros-for-loop-unrolling/20231007-044922
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/20231006204701.549230-4-kpsingh%40kernel.org
patch subject: [PATCH v6 3/5] security: Replace indirect LSM hook calls with static calls
config: i386-randconfig-014-20231011 (https://download.01.org/0day-ci/archive/20231011/202310111711.wLbijitj-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231011/202310111711.wLbijitj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310111711.wLbijitj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> security/security.c:139:1: error: Only string constants are supported as initializers for randomized structures with flexible arrays
    };
    ^


vim +139 security/security.c

   118	
   119	/*
   120	 * Initialise a table of static calls for each LSM hook.
   121	 * DEFINE_STATIC_CALL_NULL invocation above generates a key (STATIC_CALL_KEY)
   122	 * and a trampoline (STATIC_CALL_TRAMP) which are used to call
   123	 * __static_call_update when updating the static call.
   124	 */
   125	struct lsm_static_calls_table static_calls_table __ro_after_init = {
   126	#define INIT_LSM_STATIC_CALL(NUM, NAME)					\
   127		(struct lsm_static_call) {					\
   128			.key = &STATIC_CALL_KEY(LSM_STATIC_CALL(NAME, NUM)),	\
   129			.trampoline = LSM_HOOK_TRAMP(NAME, NUM),		\
   130			.active = &SECURITY_HOOK_ACTIVE_KEY(NAME, NUM),		\
   131		},
   132	#define LSM_HOOK(RET, DEFAULT, NAME, ...)				\
   133		.NAME = {							\
   134			LSM_DEFINE_UNROLL(INIT_LSM_STATIC_CALL, NAME)		\
   135		},
   136	#include <linux/lsm_hook_defs.h>
   137	#undef LSM_HOOK
   138	#undef INIT_LSM_STATIC_CALL
 > 139	};
   140	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
