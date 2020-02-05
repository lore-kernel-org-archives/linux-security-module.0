Return-Path: <SRS0=9aR4=3Z=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742F2C352A2
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Feb 2020 23:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AECE20730
	for <linux-security-module@archiver.kernel.org>; Wed,  5 Feb 2020 23:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgBEXlt (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Feb 2020 18:41:49 -0500
Received: from mga02.intel.com ([134.134.136.20]:64217 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbgBEXls (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Feb 2020 18:41:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 15:41:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,407,1574150400"; 
   d="scan'208";a="264406904"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 Feb 2020 15:41:45 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1izUIj-0004sd-59; Thu, 06 Feb 2020 07:41:45 +0800
Date:   Thu, 6 Feb 2020 07:41:20 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     kbuild-all@lists.01.org, zohar@linux.ibm.com,
        James.Bottomley@HansenPartnership.com,
        jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC PATCH] ima: ima_init_ima_crypto() can be static
Message-ID: <20200205234120.5uoibrojjg66xfpe@f53c9c00458a>
References: <20200205103317.29356-7-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205103317.29356-7-roberto.sassu@huawei.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Fixes: d49f85a89d4e ("ima: Allocate and initialize tfm for each PCR bank")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 ima_crypto.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index 7b63a32eefea17..d865e26839ef6d 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -69,7 +69,7 @@ int ima_num_template_digests;
 
 static struct ima_algo_desc *ima_algo_array;
 
-int __init ima_init_ima_crypto(void)
+static int __init ima_init_ima_crypto(void)
 {
 	long rc;
 
