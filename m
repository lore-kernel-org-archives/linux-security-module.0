Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5C2C433F5
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Nov 2021 07:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 051FD61C4F
	for <linux-security-module@archiver.kernel.org>; Wed, 17 Nov 2021 07:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhKQHlH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 17 Nov 2021 02:41:07 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:43680 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231718AbhKQHlF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Nov 2021 02:41:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Ux0WGiI_1637134683;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Ux0WGiI_1637134683)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Nov 2021 15:38:05 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     john.johansen@canonical.com
Cc:     jmorris@namei.org, serge@hallyn.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] apparmor: Fix kernel-doc
Date:   Wed, 17 Nov 2021 15:37:58 +0800
Message-Id: <1637134678-81292-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fix function name in security/apparmor/label.c, policy.c, procattr.c
kernel-doc comment to remove some warnings found by clang(make W=1 LLVM=1).

security/apparmor/label.c:499: warning: expecting prototype for
aa_label_next_not_in_set(). Prototype was for
__aa_label_next_not_in_set() instead
security/apparmor/label.c:2147: warning: expecting prototype for
__aa_labelset_udate_subtree(). Prototype was for
__aa_labelset_update_subtree() instead

security/apparmor/policy.c:434: warning: expecting prototype for
aa_lookup_profile(). Prototype was for aa_lookupn_profile() instead

security/apparmor/procattr.c:101: warning: expecting prototype for
aa_setprocattr_chagnehat(). Prototype was for aa_setprocattr_changehat()
instead

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 security/apparmor/label.c    | 4 ++--
 security/apparmor/policy.c   | 2 +-
 security/apparmor/procattr.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/apparmor/label.c b/security/apparmor/label.c
index 0b0265d..e8ada60 100644
--- a/security/apparmor/label.c
+++ b/security/apparmor/label.c
@@ -485,7 +485,7 @@ int aa_label_next_confined(struct aa_label *label, int i)
 }
 
 /**
- * aa_label_next_not_in_set - return the next profile of @sub not in @set
+ * __aa_label_next_not_in_set - return the next profile of @sub not in @set
  * @I: label iterator
  * @set: label to test against
  * @sub: label to if is subset of @set
@@ -2136,7 +2136,7 @@ static void __labelset_update(struct aa_ns *ns)
 }
 
 /**
- * __aa_labelset_udate_subtree - update all labels with a stale component
+ * __aa_labelset_update_subtree - update all labels with a stale component
  * @ns: ns to start update at (NOT NULL)
  *
  * Requires: @ns lock be held
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index b0cbc4906..8357f4a 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -422,7 +422,7 @@ static struct aa_profile *__lookup_profile(struct aa_policy *base,
 }
 
 /**
- * aa_lookup_profile - find a profile by its full or partial name
+ * aa_lookupn_profile - find a profile by its full or partial name
  * @ns: the namespace to start from (NOT NULL)
  * @hname: name to do lookup on.  Does not contain namespace prefix (NOT NULL)
  * @n: size of @hname
diff --git a/security/apparmor/procattr.c b/security/apparmor/procattr.c
index fde332e..86ad26e 100644
--- a/security/apparmor/procattr.c
+++ b/security/apparmor/procattr.c
@@ -90,7 +90,7 @@ static char *split_token_from_name(const char *op, char *args, u64 *token)
 }
 
 /**
- * aa_setprocattr_chagnehat - handle procattr interface to change_hat
+ * aa_setprocattr_changehat - handle procattr interface to change_hat
  * @args: args received from writing to /proc/<pid>/attr/current (NOT NULL)
  * @size: size of the args
  * @flags: set of flags governing behavior
-- 
1.8.3.1

