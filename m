Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E5BC636D4
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Feb 2023 03:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjBQD1N (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 16 Feb 2023 22:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjBQD0z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Feb 2023 22:26:55 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ECD4FC8C
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:47 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id t16so1773169qto.3
        for <linux-security-module@vger.kernel.org>; Thu, 16 Feb 2023 19:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8LhYESzoJTyJbG8UIuPE/K4ImH+HITUZGlYLJUGWzzo=;
        b=A2tugsMP0O89l/YxZNSbNoXq8klBsK36+Q+l6p7qbiGnQ2uB0peO8I91eFGXfY0z7t
         uuOF0KTDk69WRcEhSisN+B3W20dzpUZ3J1Ij4ojcZFy8PmvU547pqqBrXQ4uJGcJcGud
         IsA9PcttjxH/Sszid8Uy3xnpJ3gu7CyRBpLrv7AXWa+DhpPaR4rMAIyDOpBdRgq4Wi6S
         I/7IC3rb6nj2FZi3VevPzgZWkJpveqQYl0QFT3D/wkWOCC3ODNNWrsW5JXg9x40/BlJu
         i1lhkCuUfaZY/gJAaMVdxsCe3jsFhnzoDLyyM85LY7CxqntGPeXEORZzPB9TbSVDqYRQ
         BhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LhYESzoJTyJbG8UIuPE/K4ImH+HITUZGlYLJUGWzzo=;
        b=vnvBZgSSINqVA9LkyAj95gQlqMDkuWlB3M/R3qsMQbk9BX5CVUS2reyqjtuolMUkZ+
         BJMgBhN3ifxPd8xZIWcj5ItoTEsAXqjnFP07tXrKCWp3wBxI2f+VXoxToO7fjmY5bSyE
         pCHi7dztSkbzwXtNlKGOUbTgG2Tdld0lgBfr+G079jVGyvflBcGEW+ucjLcqmMtVACa9
         9H7mNk+wJP/9UcJOTyJ8aDPti/fOs8JAXXoLIy0o/BH9EtCdcGiSqYJJYfmpGrQ2YlzG
         kYl6dwXZkABL1g/JjGmddPJ+yOodnflpPs/Ey6aX7sEX9pQFfb2NmZRHaLtEsrTeZKRi
         fqNg==
X-Gm-Message-State: AO0yUKWHkruQlja1o6kp9MGu6rIwyuQkuGYrLL1LlsHJYpBCOXtodNVE
        3W1+Hiq+Eei6kt+oCGBgulqNjfUiLdVX0mE=
X-Google-Smtp-Source: AK7set8b4bFnSukwn9+qTUO90lQN7tzqgi9t4NxT0UTmn9ZwOqFRiAVICX/upGH0sdT4zIjz5672HQ==
X-Received: by 2002:ac8:7d84:0:b0:3ba:1acd:4f8 with SMTP id c4-20020ac87d84000000b003ba1acd04f8mr12496537qtd.42.1676604406212;
        Thu, 16 Feb 2023 19:26:46 -0800 (PST)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id jt12-20020a05622aa00c00b003bd0d04bf1esm2108011qtb.90.2023.02.16.19.26.45
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 19:26:45 -0800 (PST)
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Subject: [PATCH 13/22] lsm: move the xfrm hook comments to security/security.c
Date:   Thu, 16 Feb 2023 22:26:16 -0500
Message-Id: <20230217032625.678457-14-paul@paul-moore.com>
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
 include/linux/lsm_hooks.h |  73 ---------------------------
 security/security.c       | 103 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 73 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 9fc6417af980..9c5254e4e9d1 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -32,79 +32,6 @@
 /**
  * union security_list_options - Linux Security Module hook function list
  *
- * Security hooks for XFRM operations.
- *
- * @xfrm_policy_alloc_security:
- *	@ctxp is a pointer to the xfrm_sec_ctx being added to Security Policy
- *	Database used by the XFRM system.
- *	@sec_ctx contains the security context information being provided by
- *	the user-level policy update program (e.g., setkey).
- *	@gfp is to specify the context for the allocation.
- *	Allocate a security structure to the xp->security field; the security
- *	field is initialized to NULL when the xfrm_policy is allocated.
- *	Return 0 if operation was successful (memory to allocate, legal
- *	context).
- * @xfrm_policy_clone_security:
- *	@old_ctx contains an existing xfrm_sec_ctx.
- *	@new_ctxp contains a new xfrm_sec_ctx being cloned from old.
- *	Allocate a security structure in new_ctxp that contains the
- *	information from the old_ctx structure.
- *	Return 0 if operation was successful (memory to allocate).
- * @xfrm_policy_free_security:
- *	@ctx contains the xfrm_sec_ctx.
- *	Deallocate xp->security.
- * @xfrm_policy_delete_security:
- *	@ctx contains the xfrm_sec_ctx.
- *	Authorize deletion of xp->security.
- *	Return 0 if permission is granted.
- * @xfrm_state_alloc:
- *	@x contains the xfrm_state being added to the Security Association
- *	Database by the XFRM system.
- *	@sec_ctx contains the security context information being provided by
- *	the user-level SA generation program (e.g., setkey or racoon).
- *	Allocate a security structure to the x->security field; the security
- *	field is initialized to NULL when the xfrm_state is allocated. Set the
- *	context to correspond to sec_ctx. Return 0 if operation was successful
- *	(memory to allocate, legal context).
- * @xfrm_state_alloc_acquire:
- *	@x contains the xfrm_state being added to the Security Association
- *	Database by the XFRM system.
- *	@polsec contains the policy's security context.
- *	@secid contains the secid from which to take the mls portion of the
- *	context.
- *	Allocate a security structure to the x->security field; the security
- *	field is initialized to NULL when the xfrm_state is allocated. Set the
- *	context to correspond to secid. Return 0 if operation was successful
- *	(memory to allocate, legal context).
- * @xfrm_state_free_security:
- *	@x contains the xfrm_state.
- *	Deallocate x->security.
- * @xfrm_state_delete_security:
- *	@x contains the xfrm_state.
- *	Authorize deletion of x->security.
- *	Return 0 if permission is granted.
- * @xfrm_policy_lookup:
- *	@ctx contains the xfrm_sec_ctx for which the access control is being
- *	checked.
- *	@fl_secid contains the flow security label that is used to authorize
- *	access to the policy xp.
- *	@dir contains the direction of the flow (input or output).
- *	Check permission when a flow selects a xfrm_policy for processing
- *	XFRMs on a packet.  The hook is called when selecting either a
- *	per-socket policy or a generic xfrm policy.
- *	Return 0 if permission is granted, -ESRCH otherwise, or -errno
- *	on other errors.
- * @xfrm_state_pol_flow_match:
- *	@x contains the state to match.
- *	@xp contains the policy to check for a match.
- *	@flic contains the flowi_common struct to check for a match.
- *	Return 1 if there is a match.
- * @xfrm_decode_session:
- *	@skb points to skb to decode.
- *	@secid points to the flow key secid to set.
- *	@ckall says if all xfrms used should be checked for same secid.
- *	Return 0 if ckall is zero or all xfrms used have the same secid.
- *
  * Security hooks affecting all Key Management operations
  *
  * @key_alloc:
diff --git a/security/security.c b/security/security.c
index 3b713ed3d29c..f06b95a9705c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -4268,6 +4268,17 @@ EXPORT_SYMBOL(security_ib_free_security);
 
 #ifdef CONFIG_SECURITY_NETWORK_XFRM
 
+/**
+ * security_xfrm_policy_alloc() - Allocate a xfrm policy LSM blob
+ * @ctxp: xfrm security context being added to the SPD
+ * @sec_ctx: security label provided by userspace
+ * @gfp: gfp flags
+ *
+ * Allocate a security structure to the xp->security field; the security field
+ * is initialized to NULL when the xfrm_policy is allocated.
+ *
+ * Return:  Return 0 if operation was successful.
+ */
 int security_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,
 			       struct xfrm_user_sec_ctx *sec_ctx,
 			       gfp_t gfp)
@@ -4276,23 +4287,58 @@ int security_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,
 }
 EXPORT_SYMBOL(security_xfrm_policy_alloc);
 
+/**
+ * security_xfrm_policy_clone() - Clone xfrm policy LSM state
+ * @old_ctx: xfrm security context
+ * @new_ctxp: target xfrm security context
+ *
+ * Allocate a security structure in new_ctxp that contains the information from
+ * the old_ctx structure.
+ *
+ * Return: Return 0 if operation was successful.
+ */
 int security_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx,
 			      struct xfrm_sec_ctx **new_ctxp)
 {
 	return call_int_hook(xfrm_policy_clone_security, 0, old_ctx, new_ctxp);
 }
 
+/**
+ * security_xfrm_policy_free() - Free a xfrm security context
+ * @ctx: xfrm security context
+ *
+ * Free LSM resources associated with @ctx.
+ */
 void security_xfrm_policy_free(struct xfrm_sec_ctx *ctx)
 {
 	call_void_hook(xfrm_policy_free_security, ctx);
 }
 EXPORT_SYMBOL(security_xfrm_policy_free);
 
+/**
+ * security_xfrm_policy_delete() - Check if deleting a xfrm policy is allowed
+ * @ctx: xfrm security context
+ *
+ * Authorize deletion of a SPD entry.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_xfrm_policy_delete(struct xfrm_sec_ctx *ctx)
 {
 	return call_int_hook(xfrm_policy_delete_security, 0, ctx);
 }
 
+/**
+ * security_xfrm_state_alloc() - Allocate a xfrm state LSM blob
+ * @x: xfrm state being added to the SAD
+ * @sec_ctx: security label provided by userspace
+ *
+ * Allocate a security structure to the @x->security field; the security field
+ * is initialized to NULL when the xfrm_state is allocated. Set the context to
+ * correspond to @sec_ctx.
+ *
+ * Return: Return 0 if operation was successful.
+ */
 int security_xfrm_state_alloc(struct xfrm_state *x,
 			      struct xfrm_user_sec_ctx *sec_ctx)
 {
@@ -4300,28 +4346,76 @@ int security_xfrm_state_alloc(struct xfrm_state *x,
 }
 EXPORT_SYMBOL(security_xfrm_state_alloc);
 
+/**
+ * security_xfrm_state_alloc_acquire() - Allocate a xfrm state LSM blob
+ * @x: xfrm state being added to the SAD
+ * @polsec: associated policy's security context
+ * @secid: secid from the flow
+ *
+ * Allocate a security structure to the x->security field; the security field
+ * is initialized to NULL when the xfrm_state is allocated.  Set the context to
+ * correspond to secid.
+ *
+ * Return: Returns 0 if operation was successful.
+ */
 int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
 				      struct xfrm_sec_ctx *polsec, u32 secid)
 {
 	return call_int_hook(xfrm_state_alloc_acquire, 0, x, polsec, secid);
 }
 
+/**
+ * security_xfrm_state_delete() - Check if deleting a xfrm state is allowed
+ * @x: xfrm state
+ *
+ * Authorize deletion of x->security.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
 int security_xfrm_state_delete(struct xfrm_state *x)
 {
 	return call_int_hook(xfrm_state_delete_security, 0, x);
 }
 EXPORT_SYMBOL(security_xfrm_state_delete);
 
+/**
+ * security_xfrm_state_free() - Free a xfrm state
+ * @x: xfrm state
+ *
+ * Deallocate x->security.
+ */
 void security_xfrm_state_free(struct xfrm_state *x)
 {
 	call_void_hook(xfrm_state_free_security, x);
 }
 
+/**
+ * security_xfrm_policy_lookup() - Check if using a xfrm policy is allowed
+ * @ctx: target xfrm security context
+ * @fl_secid: flow secid used to authorize access
+ *
+ * Check permission when a flow selects a xfrm_policy for processing XFRMs on a
+ * packet.  The hook is called when selecting either a per-socket policy or a
+ * generic xfrm policy.
+ *
+ * Return: Return 0 if permission is granted, -ESRCH otherwise, or -errno on
+ *         other errors.
+ */
 int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid)
 {
 	return call_int_hook(xfrm_policy_lookup, 0, ctx, fl_secid);
 }
 
+/**
+ * security_xfrm_state_pol_flow_match() - Check for a xfrm match
+ * @x: xfrm state to match
+ * @xp xfrm policy to check for a match
+ * @flic: flow to check for a match.
+ *
+ * Check @xp and @flic for a match with @x.
+ *
+ * Return: Returns 1 if there is a match.
+ */
 int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 				       struct xfrm_policy *xp,
 				       const struct flowi_common *flic)
@@ -4346,6 +4440,15 @@ int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
 	return rc;
 }
 
+/**
+ * security_xfrm_decode_session() - Determine the xfrm secid for a packet
+ * @skb: xfrm packet
+ * @secid: secid
+ *
+ * Decode the packet in @skb and return the security label in @secid.
+ *
+ * Return: Return 0 if all xfrms used have the same secid.
+ */
 int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid)
 {
 	return call_int_hook(xfrm_decode_session, 0, skb, secid, 1);
-- 
2.39.2

