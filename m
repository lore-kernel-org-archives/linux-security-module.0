Return-Path: <SRS0=9ABi=3H=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97901C33CB1
	for <linux-security-module@archiver.kernel.org>; Sat, 18 Jan 2020 10:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785952468D
	for <linux-security-module@archiver.kernel.org>; Sat, 18 Jan 2020 10:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgARKx1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 18 Jan 2020 05:53:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:61335 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbgARKx1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 18 Jan 2020 05:53:27 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2020 02:53:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,333,1574150400"; 
   d="scan'208";a="306501351"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Jan 2020 02:53:25 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1isljI-0003Ca-Hw; Sat, 18 Jan 2020 18:53:24 +0800
Date:   Sat, 18 Jan 2020 18:52:26 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Mike Salvatore <mike.salvatore@canonical.com>
Cc:     kbuild-all@lists.01.org, Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [linux-next:master 7161/9861]
 security/apparmor/policy_unpack_test.c:51:15: sparse: sparse: symbol
 'build_aa_ext_struct' was not declared. Should it be static?
Message-ID: <202001181831.bFmypzrR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   de970dffa7d19eae1d703c3534825308ef8d5dec
commit: 4d944bcd4e731ab7bfe8d01a7041ea0ebdc090f1 [7161/9861] apparmor: add AppArmor KUnit tests for policy unpack
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-131-g22978b6b-dirty
        git checkout 4d944bcd4e731ab7bfe8d01a7041ea0ebdc090f1
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> security/apparmor/policy_unpack_test.c:51:15: sparse: sparse: symbol 'build_aa_ext_struct' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
