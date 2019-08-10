Return-Path: <SRS0=8uvB=WG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF97C433FF
	for <linux-security-module@archiver.kernel.org>; Sat, 10 Aug 2019 06:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E11AB208C3
	for <linux-security-module@archiver.kernel.org>; Sat, 10 Aug 2019 06:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfHJG7S (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 10 Aug 2019 02:59:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:3242 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfHJG7S (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 10 Aug 2019 02:59:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 23:59:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,368,1559545200"; 
   d="scan'208";a="326834503"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Aug 2019 23:59:16 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hwLLP-0009iB-NM; Sat, 10 Aug 2019 14:59:15 +0800
Date:   Sat, 10 Aug 2019 14:58:46 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     kbuild-all@01.org, linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>
Subject: [security:next-lockdown 3/29] security/lockdown/lockdown.c:157:1-3:
 WARNING: PTR_ERR_OR_ZERO can be used
Message-ID: <201908101444.zkWryFiG%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/jmorris/linux-security.git next-lockdown
head:   05ef41e93e1a40d6b2d9846284824ec6f67fe422
commit: 80d14015a8e3109f9b5e3e39b0bc78e1c3a1f315 [3/29] security: Add a static lockdown policy LSM

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> security/lockdown/lockdown.c:157:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
