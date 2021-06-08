Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEFEC48BCD
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Jun 2021 12:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355AB61352
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Jun 2021 12:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbhFHMd4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:33:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3168 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbhFHMdz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Jun 2021 08:33:55 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fzq6Y1YHhz6G862;
        Tue,  8 Jun 2021 20:19:17 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.62.217) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 14:32:00 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <sfr@canb.auug.org.au>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-next@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 1/5] doc: Fix warning in Documentation/security/IMA-templates.rst
Date:   Tue, 8 Jun 2021 14:31:20 +0200
Message-ID: <20210608123124.335868-1-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.62.217]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch fixes the warning:

Documentation/security/IMA-templates.rst:81: WARNING: Inline
substitution_reference start-string without end-string.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/IMA-templates.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index 5adc22f99496..1a91d92950a7 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -78,7 +78,7 @@ descriptors by adding their identifier to the format string
  - 'iuid': the inode UID;
  - 'igid': the inode GID;
  - 'imode': the inode mode;
- - 'xattrnames': a list of xattr names (separated by |), only if the xattr is
+ - 'xattrnames': a list of xattr names (separated by ``|``), only if the xattr is
     present;
  - 'xattrlengths': a list of xattr lengths (u32), only if the xattr is present;
  - 'xattrvalues': a list of xattr values;
-- 
2.25.1

