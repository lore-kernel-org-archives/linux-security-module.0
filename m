Return-Path: <SRS0=DosV=VM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CB4C7618F
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jul 2019 20:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC4821738
	for <linux-security-module@archiver.kernel.org>; Mon, 15 Jul 2019 20:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O3wJDTMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbfGOUCy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 15 Jul 2019 16:02:54 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:41320 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732166AbfGOT77 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jul 2019 15:59:59 -0400
Received: by mail-pg1-f202.google.com with SMTP id b18so11102286pgg.8
        for <linux-security-module@vger.kernel.org>; Mon, 15 Jul 2019 12:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f/RnEfWSrg+mjsb2cXMX4L7C/xNmjjOSgJcVU/cQXL4=;
        b=O3wJDTMnR9+H3RojAsFfUzZ287o93Xl/j+eBzr9xiJ7GSnL6wH09hswz5HkUJo5TO0
         zSIxrKaO7KxH1NGZU7OTkNwfKk0GwAeKc+MKisrrtdIClB8NctvgLH77qjBC5hKc/QNx
         90e0sVBG4jPv7BUvyWIiRJhlq59sTL/+jDBqvmkICOjjJPFXRubWcJBrG3bYXhIeJMTx
         WcdMWTeTFuVC1gX8BKQw0/+98YB4jYff2uID6Vz0O0yOW0JHGKEGXJHEzUU/7bJ8ovCB
         z1mfyjYl0jF0/UyMq87sSAtqXC8sIdTLF2q38qdJlTGG5wkbomCUUrM9ehm3vT5Nppbc
         C49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f/RnEfWSrg+mjsb2cXMX4L7C/xNmjjOSgJcVU/cQXL4=;
        b=VpJbRC/40Vbmd6y7R4bSY/mLvI5mk2Jl37qg2yAk8bxsC6pVYb6Ht+RrttSEJ+cqbp
         ZvChQqVh0K52mUyqvfo5vzRZ8j9e/PSLVNlSqMzNS+DX4FY39BEWhbF5RQ6UQwN/Js/Y
         d6HGr5YvT32jwa+uoHCuRzGYQyp1/vRui0YasnkXErmcVH4q2RuM+IqnVyK2OchMJhmJ
         1qd+i+wjxtqpnzzC9CMT/JrX4GXuXcc/10997rqzk2ISeklC8jY7eCKZ2CHS8TtIz4Df
         /C0Iqe8CJp8rR6BbmVu/TpWRohFOaI6HFqETodH2FD2hyXMFnt2KzrN/67gkbL+D7A/M
         /TSw==
X-Gm-Message-State: APjAAAU9j/7FJIlWgtm1E8vW+CWQ5l1EG76cpcdolmOiCCTYG1pFbOn1
        HoWY6gyuKplUaM2DQBrmcgAZKR8uiXodM97HW8QgHg==
X-Google-Smtp-Source: APXvYqwymNGgJxKQXYrvXHvEFFXosA7/epA7W3EwA368wSAhTsTwzUzG35fXHKoCej+cuEmSBj+RFWvwC9co2fGpXfPAiw==
X-Received: by 2002:a63:1310:: with SMTP id i16mr28407114pgl.187.1563220798084;
 Mon, 15 Jul 2019 12:59:58 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:19 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-3-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 02/29] security: Add a "locked down" LSM hook
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Add a mechanism to allow LSMs to make a policy decision around whether
kernel functionality that would allow tampering with or examining the
runtime state of the kernel should be permitted.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h |  2 ++
 include/linux/security.h  | 32 ++++++++++++++++++++++++++++++++
 security/security.c       |  6 ++++++
 3 files changed, 40 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index aebb0e032072..29c22cf40113 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1807,6 +1807,7 @@ union security_list_options {
 	int (*bpf_prog_alloc_security)(struct bpf_prog_aux *aux);
 	void (*bpf_prog_free_security)(struct bpf_prog_aux *aux);
 #endif /* CONFIG_BPF_SYSCALL */
+	int (*locked_down)(enum lockdown_reason what);
 };
 
 struct security_hook_heads {
@@ -2046,6 +2047,7 @@ struct security_hook_heads {
 	struct hlist_head bpf_prog_alloc_security;
 	struct hlist_head bpf_prog_free_security;
 #endif /* CONFIG_BPF_SYSCALL */
+	struct hlist_head locked_down;
 } __randomize_layout;
 
 /*
diff --git a/include/linux/security.h b/include/linux/security.h
index 66a2fcbe6ab0..c2b1204e8e26 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -77,6 +77,33 @@ enum lsm_event {
 	LSM_POLICY_CHANGE,
 };
 
+/*
+ * These are reasons that can be passed to the security_locked_down()
+ * LSM hook. Lockdown reasons that protect kernel integrity (ie, the
+ * ability for userland to modify kernel code) are placed before
+ * LOCKDOWN_INTEGRITY_MAX.  Lockdown reasons that protect kernel
+ * confidentiality (ie, the ability for userland to extract
+ * information from the running kernel that would otherwise be
+ * restricted) are placed before LOCKDOWN_CONFIDENTIALITY_MAX.
+ *
+ * LSM authors should note that the semantics of any given lockdown
+ * reason are not guaranteed to be stable - the same reason may block
+ * one set of features in one kernel release, and a slightly different
+ * set of features in a later kernel release. LSMs that seek to expose
+ * lockdown policy at any level of granularity other than "none",
+ * "integrity" or "confidentiality" are responsible for either
+ * ensuring that they expose a consistent level of functionality to
+ * userland, or ensuring that userland is aware that this is
+ * potentially a moving target. It is easy to misuse this information
+ * in a way that could break userspace. Please be careful not to do
+ * so.
+ */
+enum lockdown_reason {
+	LOCKDOWN_NONE,
+	LOCKDOWN_INTEGRITY_MAX,
+	LOCKDOWN_CONFIDENTIALITY_MAX,
+};
+
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
 		       int cap, unsigned int opts);
@@ -393,6 +420,7 @@ void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+int security_locked_down(enum lockdown_reason what);
 #else /* CONFIG_SECURITY */
 
 static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
@@ -1205,6 +1233,10 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
 {
 	return -EOPNOTSUPP;
 }
+static inline int security_locked_down(enum lockdown_reason what)
+{
+	return 0;
+}
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/security/security.c b/security/security.c
index 90f1e291c800..ce6c945bf347 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2392,3 +2392,9 @@ void security_bpf_prog_free(struct bpf_prog_aux *aux)
 	call_void_hook(bpf_prog_free_security, aux);
 }
 #endif /* CONFIG_BPF_SYSCALL */
+
+int security_locked_down(enum lockdown_reason what)
+{
+	return call_int_hook(locked_down, 0, what);
+}
+EXPORT_SYMBOL(security_locked_down);
-- 
2.22.0.510.g264f2c817a-goog

