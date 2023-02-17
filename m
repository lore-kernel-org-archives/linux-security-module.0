Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4784C636D7
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjBQD1O (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjBQD05 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:26:57 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94A95A385
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:52 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id i5so3132547qvp.6
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6G9lKyS1KVfFFMP7ztRA7H7QDEyjlDjPSIl6UQnbPw=;
        b=dTYb7rQEfoZGgDon/mEvmnD+PmBnJABrMDd04O3HPf3TH3aYn4fMbozyc4+e2re2sY
         ASvD7j+mzTb/frfiIv0AV9O5SqTTzIgowNiPXx5E4Iye+2h2UfXjH8seFivVQUzxpeL0
         WZhQwDkQsVPDuyk4a3NZTwLPbQeZCoaiXUbbNGFdj6WsTqOEoGRYoBtuhetqNlQFdVrU
         CsgXGz8Pl/PUbH85sPXZnwYBYr7z9QsshuOfi6yAP3LzhOEO0CmVvXKgLH2GtqxdRNtk
         X6PBxUXHb8fTWCmUHYZMVO+dfQLVqaxpE69MEt4ML/hE7oYwdFKgfSygaFnwEYHB9182
         C7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6G9lKyS1KVfFFMP7ztRA7H7QDEyjlDjPSIl6UQnbPw=;
        b=DVGHlAFhrKf3gJht1nnMTaKpEUMl+bjwH1Qm0l3UmoVON1YX/YmZepL/5Dqib6jyim
         F7hr3B4mZmcU/NfzryElSfoIWimHoyOJvsxFGeRrbqLwzVnf0Jlj3+nebrT4TI4Ocwcy
         R2nO1Lhsk8raQA7V1CN9/ME7NRpHmFPWns42uwJ50qK3HhgtrQcSI2go/V7sCbeUSEx2
         N9GgFeiFnktFGCprOW7YFzJY1QXGzu3iKxsLIZB2WvKCa80cPseUc8hz0/jXkGidgtxS
         mDwNeM4UkegrCITKRX8PcZ19EuJtxu+WJsn/99Aspg4/oXOfCyrZ9PMXb3r2wwRqPleg
         hK/g==
X-Gm-Message-State: AO0yUKXAbqssWve8lCvYjFUv6bpWAKjpXcD2bX9ZxAxWEgcrlTlIPFxg
        UWX+/GRiaxa5laT5U0+wjHz4VO5fwM0ncG8=
X-Google-Smtp-Source: AK7set8g0xGc5CofamsXw7wbGwFDJmjJZbHSk4LiYb2vUJItiBwcfZM/hXnP9rdKRYQSyGtMTVy8Vw==
X-Received: by 2002:ad4:5c86:0:b0:56b:ff69:7df8 with SMTP id o6-20020ad45c86000000b0056bff697df8mr17755123qvh.51.1676604411342;
        Thu, 16 Feb 2023 19:26:51 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id b68-20020a37b247000000b0073980414888sm2483677qkf.42.2023.02.16.19.26.50
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:50 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 17/22] lsm: move the audit hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:20 -0500
Message-Id: <20230217032625.678457-18-paul@paul-moore.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230217032625.678457-1-paul@paul-moore.com>
References: <20230217032625.678457-1-paul@paul-moore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch relocates the LSM hook function comments to the function
definitions, in keeping with the current kernel conventions.  This
should make the hook descriptions more easily discoverable and easier
to maintain.

While formatting changes have been done to better fit the kernel-doc
style, content changes have been kept to a minimum and limited to
text which was obviously incorrect and/or outdated.  It is expected
the future patches will improve the quality of the function header
comments.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/lsm_hooks.h | 32 ------------------------------
 security/security.c       | 41 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 0a5b3b46fc2b..e36387f88083 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -135,38 +135,6 @@
  *	@secdata contains the security context.
  *	@seclen contains the length of the security context.
  *
- * Security hooks for Audit
- *
- * @audit_rule_init:
- *	Allocate and initialize an LSM audit rule structure.
- *	@field contains the required Audit action.
- *	Fields flags are defined in <include/linux/audit.h>
- *	@op contains the operator the rule uses.
- *	@rulestr contains the context where the rule will be applied to.
- *	@lsmrule contains a pointer to receive the result.
- *	Return 0 if @lsmrule has been successfully set,
- *	-EINVAL in case of an invalid rule.
- *
- * @audit_rule_known:
- *	Specifies whether given @krule contains any fields related to
- *	current LSM.
- *	@krule contains the audit rule of interest.
- *	Return 1 in case of relation found, 0 otherwise.
- *
- * @audit_rule_match:
- *	Determine if given @secid matches a rule previously approved
- *	by @audit_rule_known.
- *	@secid contains the security id in question.
- *	@field contains the field which relates to current LSM.
- *	@op contains the operator that will be used for matching.
- *	@lrule points to the audit rule that will be checked against.
- *	Return 1 if secid matches the rule, 0 if it does not, -ERRNO on failure.
- *
- * @audit_rule_free:
- *	Deallocate the LSM audit rule structure previously allocated by
- *	audit_rule_init.
- *	@lsmrule contains the allocated rule.
- *
  * @inode_invalidate_secctx:
  *	Notify the security module that it must revalidate the security context
  *	of an inode.
diff --git a/security/security.c b/security/security.c
index d7a07264fb73..4a2eff06f418 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4761,21 +4761,62 @@ int security_key_getsecurity(struct key *key, char **_buffer)
 
 #ifdef CONFIG_AUDIT
 
+/**
+ * security_audit_rule_init() - Allocate and init an LSM audit rule struct
+ * @field: audit action
+ * @op: rule operator
+ * @rulestr: rule context
+ * @lsmrule: receive buffer for audit rule struct
+ *
+ * Allocate and initialize an LSM audit rule structure.
+ *
+ * Return: Return 0 if @lsmrule has been successfully set, -EINVAL in case of
+ *         an invalid rule.
+ */
 int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
 {
 	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
 }
 
+/**
+ * security_audit_rule_known() - Check if an audit rule contains LSM fields
+ * @krule: audit rule
+ *
+ * Specifies whether given @krule contains any fields related to the current
+ * LSM.
+ *
+ * Return: Returns 1 in case of relation found, 0 otherwise.
+ */
 int security_audit_rule_known(struct audit_krule *krule)
 {
 	return call_int_hook(audit_rule_known, 0, krule);
 }
 
+/**
+ * security_audit_rule_free() - Free an LSM audit rule struct
+ * @lsmrule: audit rule struct
+ *
+ * Deallocate the LSM audit rule structure previously allocated by
+ * audit_rule_init().
+ */
 void security_audit_rule_free(void *lsmrule)
 {
 	call_void_hook(audit_rule_free, lsmrule);
 }
 
+/**
+ * security_audit_rule_match() - Check if a label matches an audit rule
+ * @secid: security label
+ * @field: LSM audit field
+ * @op: matching operator
+ * @lsmrule: audit rule
+ *
+ * Determine if given @secid matches a rule previously approved by
+ * security_audit_rule_known().
+ *
+ * Return: Returns 1 if secid matches the rule, 0 if it does not, -ERRNO on
+ *         failure.
+ */
 int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
 {
 	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
-- 
2.39.2

