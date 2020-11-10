Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE333C56202
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Nov 2020 10:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B754207E8
	for <linux-security-module@archiver.kernel.org>; Tue, 10 Nov 2020 10:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgKJKNQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 10 Nov 2020 05:13:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:36686 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728473AbgKJKNP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 10 Nov 2020 05:13:15 -0500
IronPort-SDR: SKirVgMYjSfjbo7MtMmz3uhABGNfQpCz9teBV8oTxTrPD3FQWUQfwFhS97Q+y4Lzfcjk8vOU5b
 qzzvaudxp19w==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="170059933"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="170059933"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 02:13:14 -0800
IronPort-SDR: VH5mMqZ8qyjj2supMYqt2vFY+y34fv0MITTapi9+RRnyIKBtJXGOgT3LP7g2v2UM1O+WrCU+tE
 7KhW9wFp3yrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="473370731"
Received: from lkp-server02.sh.intel.com (HELO c6c5fbb3488a) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 10 Nov 2020 02:13:13 -0800
Received: from kbuild by c6c5fbb3488a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kcQeH-0000AB-3E; Tue, 10 Nov 2020 10:13:13 +0000
Date:   Tue, 10 Nov 2020 18:12:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>
Subject: [security:landlock_lsm 8/12] security/landlock/syscall.c:216:13:
 warning: Uninitialized variable: ruleset
Message-ID: <202011101854.zGbWwusK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git landlock_lsm
head:   96b3198c4025c11347651700b77e45a686d78553
commit: 0c901260bd29a3d6019531d3a3fdff7859aa88e1 [8/12] landlock: Add syscall implementations
compiler: powerpc64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"cppcheck warnings: (new ones prefixed by >>)"
>> security/landlock/syscall.c:216:13: warning: Uninitialized variable: ruleset [uninitvar]
    return err ? ERR_PTR(err) : ruleset;
               ^

vim +216 security/landlock/syscall.c

   189	
   190	/*
   191	 * Returns an owned ruleset from a FD. It is thus needed to call
   192	 * landlock_put_ruleset() on the return value.
   193	 */
   194	static struct landlock_ruleset *get_ruleset_from_fd(const int fd,
   195			const fmode_t mode)
   196	{
   197		struct fd ruleset_f;
   198		struct landlock_ruleset *ruleset;
   199		int err;
   200	
   201		ruleset_f = fdget(fd);
   202		if (!ruleset_f.file)
   203			return ERR_PTR(-EBADF);
   204	
   205		/* Checks FD type and access right. */
   206		err = 0;
   207		if (ruleset_f.file->f_op != &ruleset_fops)
   208			err = -EBADFD;
   209		else if (!(ruleset_f.file->f_mode & mode))
   210			err = -EPERM;
   211		if (!err) {
   212			ruleset = ruleset_f.file->private_data;
   213			landlock_get_ruleset(ruleset);
   214		}
   215		fdput(ruleset_f);
 > 216		return err ? ERR_PTR(err) : ruleset;
   217	}
   218	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
