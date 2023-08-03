Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40837C001DB
	for <linux-security-module@archiver.kernel.org>; Thu,  3 Aug 2023 17:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjHCROP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 3 Aug 2023 13:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbjHCROL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 3 Aug 2023 13:14:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576813C22
        for <linux-security-module@vger.kernel.org>; Thu,  3 Aug 2023 10:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691082807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Sd8udM4quE+FkVJlTeE6p9Jeb2cJdOzPnhjvTuy2rU=;
        b=fDcJQCQL3vAJLtUKOGzZufYEyIwkxeIcgG5D943sB0gTMKxSRvmXuOy2HyiQV3HfVgXtrM
        +4+8sJUmZzYb78rwJtNEbEHcKQXm38GOntfCm00Ti6Z+uQ6fx0vxRr5iJbPT9B8RjNfJcX
        rZMdUbeDKb4F4kcUADV0eKim8v/Fs7E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-kSsMx2D8OSKt3S0LVMVD6g-1; Thu, 03 Aug 2023 13:13:24 -0400
X-MC-Unique: kSsMx2D8OSKt3S0LVMVD6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A2858564EF;
        Thu,  3 Aug 2023 17:13:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EADE2200A7CA;
        Thu,  3 Aug 2023 17:13:22 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     linux-security-module@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH RFC 3/3] security: more call_int_hook_ignore_default use-cases
Date:   Thu,  3 Aug 2023 19:12:42 +0200
Message-ID: <d1fd42e8faeaefb2a834dde521eb3ed0528ddf2b.1691082677.git.pabeni@redhat.com>
In-Reply-To: <cover.1691082677.git.pabeni@redhat.com>
References: <cover.1691082677.git.pabeni@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The vm_enough_memory and xfrm_state_pol_flow_match behavior is somewhat
similar, as both possibly need to reconciliate multiple LSM return value
to a take a single decision. Currently xfrm_state_pol_flow_match has a
simple implementation leveraging the fact that only a LSM is supposed to
implement such hook.

This patch extend xfrm_state_pol_flow_match() to possibly cope with
multiple hooks alike what vm_enough_memory is currently doing, switch
both hooks to use the call_int_hook_ignore_default helper and change
the default hook return value to 1.

Overall the above should not lead to any functional change.

After this change, LSM returning the LSM_RET_DEFAULT value will become
a no-op for the mentioned hooks.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/lsm_hook_defs.h |  2 +-
 security/security.c           | 34 ++++++++--------------------------
 2 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 49f1f9bed958..e41ae0f90825 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -48,7 +48,7 @@ LSM_HOOK(int, 0, quota_on, struct dentry *dentry)
 LSM_HOOK(int, 0, syslog, int type)
 LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
 	 const struct timezone *tz)
-LSM_HOOK(int, 0, vm_enough_memory, struct mm_struct *mm, long pages)
+LSM_HOOK(int, 1, vm_enough_memory, struct mm_struct *mm, long pages)
 LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, struct file *file)
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
diff --git a/security/security.c b/security/security.c
index 0528cbef0624..b7b2d359c230 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1036,9 +1036,7 @@ int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
  */
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
-	struct security_hook_list *hp;
-	int cap_sys_admin = 1;
-	int rc;
+	int cap_sys_admin;
 
 	/*
 	 * The module will respond with a positive value if
@@ -1047,13 +1045,8 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	 * agree that it should be set it will. If any module
 	 * thinks it should not be set it won't.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.vm_enough_memory, list) {
-		rc = hp->hook.vm_enough_memory(mm, pages);
-		if (rc <= 0) {
-			cap_sys_admin = 0;
-			break;
-		}
-	}
+	cap_sys_admin = call_int_hook_ignore_default(vm_enough_memory, 1, mm,
+						     pages);
 	return __vm_enough_memory(mm, pages, cap_sys_admin);
 }
 
@@ -4922,24 +4915,13 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				       struct xfrm_policy *xp,
 				       const struct flowi_common *flic)
 {
-	struct security_hook_list *hp;
-	int rc = LSM_RET_DEFAULT(xfrm_state_pol_flow_match);
-
 	/*
-	 * Since this function is expected to return 0 or 1, the judgment
-	 * becomes difficult if multiple LSMs supply this call. Fortunately,
-	 * we can use the first LSM's judgment because currently only SELinux
-	 * supplies this call.
-	 *
-	 * For speed optimization, we explicitly break the loop rather than
-	 * using the macro
+	 * The module will respond with a 1 value if
+	 * it thinks there is a match. If all of the modules
+	 * agree we consider the match succesfull.
 	 */
-	hlist_for_each_entry(hp, &security_hook_heads.xfrm_state_pol_flow_match,
-			     list) {
-		rc = hp->hook.xfrm_state_pol_flow_match(x, xp, flic);
-		break;
-	}
-	return rc;
+	return call_int_hook_ignore_default(xfrm_state_pol_flow_match,
+					    1, x, xp, flic);
 }
 
 /**
-- 
2.41.0

