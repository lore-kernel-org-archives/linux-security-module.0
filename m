Return-Path: <SRS0=t07G=C2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546B2C43461
	for <linux-security-module@archiver.kernel.org>; Thu, 17 Sep 2020 12:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12AC32087D
	for <linux-security-module@archiver.kernel.org>; Thu, 17 Sep 2020 12:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgIQMbe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 17 Sep 2020 08:31:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40214 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726861AbgIQMbb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 Sep 2020 08:31:31 -0400
X-Greylist: delayed 951 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 08:30:47 EDT
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CD4F6876081258B6973F;
        Thu, 17 Sep 2020 20:14:34 +0800 (CST)
Received: from huawei.com (10.175.104.82) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 20:14:31 +0800
From:   Huang Guobin <huangguobin4@huawei.com>
To:     <john.johansen@canonical.com>, <jmorris@namei.org>,
        <serge@hallyn.com>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] apparmor: Fix several kernel-doc warnings
Date:   Thu, 17 Sep 2020 08:24:57 -0400
Message-ID: <20200917122457.206198-1-huangguobin4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fixes the following W=1 kernel build warning(s):

security/apparmor/apparmorfs.c:2127: warning: Excess function parameter 'profile' description in '__next_profile'
security/apparmor/domain.c:1292: warning: Excess function parameter 'onexec' description in 'aa_change_profile'
security/apparmor/domain.c:136: warning: Excess function parameter 'start' description in 'label_compound_match'

Rename profile to p.
@onexec in 'aa_change_profile' and @start in 'label_compound_match' are not in use, Remove it.

Signed-off-by: Huang Guobin <huangguobin4@huawei.com>
---
 security/apparmor/apparmorfs.c | 2 +-
 security/apparmor/domain.c     | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 5fd4a64e431f..f00a372be7b6 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2116,7 +2116,7 @@ static struct aa_profile *__first_profile(struct aa_ns *root,
 
 /**
  * __next_profile - step to the next profile in a profile tree
- * @profile: current profile in tree (NOT NULL)
+ * @p: current profile in tree (NOT NULL)
  *
  * Perform a depth first traversal on the profile tree in a namespace
  *
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index f919ebd042fd..12a9d80cd63a 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -178,7 +178,6 @@ static int label_compound_match(struct aa_profile *profile,
  * @profile: profile to find perms for
  * @label: label to check access permissions for
  * @stack: whether this is a stacking request
- * @start: state to start match in
  * @subns: whether to do permission checks on components in a subns
  * @request: permissions to request
  * @perms: an initialized perms struct to add accumulation to
@@ -1277,14 +1276,11 @@ static int change_profile_perms_wrapper(const char *op, const char *name,
 /**
  * aa_change_profile - perform a one-way profile transition
  * @fqname: name of profile may include namespace (NOT NULL)
- * @onexec: whether this transition is to take place immediately or at exec
  * @flags: flags affecting change behavior
  *
  * Change to new profile @name.  Unlike with hats, there is no way
  * to change back.  If @name isn't specified the current profile name is
  * used.
- * If @onexec then the transition is delayed until
- * the next exec.
  *
  * Returns %0 on success, error otherwise.
  */
-- 
2.25.1

