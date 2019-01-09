Return-Path: <SRS0=tCoi=PR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFF0C43444
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Jan 2019 09:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30D7206BB
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Jan 2019 09:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbfAIJLL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:11:11 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36407 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbfAIJLK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Jan 2019 04:11:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so6850167wrp.3
        for <linux-security-module@vger.kernel.org>; Wed, 09 Jan 2019 01:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zrxmc4ZoG0uPCxsCMb+Z31rUb+X2m9cnghi+Jlm2Cd0=;
        b=lKrMbX8IiszPUGcjfyX3ABRUj6ole5plUV5XGvUH8LgDM0hZwmvreiQCRpDvgv2LKN
         NnzUTYK5Dcj5GCC8vEH0ghdyKPlYp36UV9L1xJchody84Ay7p8D5MpBBqTw8/58Vvl4E
         MaEmvEROE3BAOUwbkglLBhWbgG2dBsvJe315Pk1ci+7fWbI+E29UND58yNe59hKRb4hK
         3rISX/H1aV3fVD5aWbFtRloNmBd7bdt8uRqYC+reYNz9TP+WEEIMJostgXi9wUhyZX+3
         6Qs2tuZjvvDeeaf8t96rY7+UWfE4tNVBjXFiqjfoIYHymiNLlzbmvNdPuVD5qe++P0Ez
         RLEg==
X-Gm-Message-State: AJcUukdRN5rj54rYUJqU8+7RCJ1RvsH/8y+b7oHxG+61g5uJCTF98AsY
        ofO1Yb45D1pxvJ95TFY5Yrdhpg==
X-Google-Smtp-Source: ALg8bN5iqKGx6MwrVDr+EoapKKRFFrZR6co4oCg51GICTTkeu2X/ZViRDBsi6u7nTwsMtbizAk+3pQ==
X-Received: by 2002:adf:f903:: with SMTP id b3mr4487075wrr.82.1547025068043;
        Wed, 09 Jan 2019 01:11:08 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f137sm11186044wmg.29.2019.01.09.01.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 01:11:07 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH 1/3] LSM: Add new hook for generic node initialization
Date:   Wed,  9 Jan 2019 10:10:26 +0100
Message-Id: <20190109091028.24485-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109091028.24485-1-omosnace@redhat.com>
References: <20190109091028.24485-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch introduces a new security hook that is intended for
initializing the security data for newly created pseudo filesystem
objects (such as kernfs nodes) that provide a way of storing a
non-default security context, but need to operate independently from
mounts.

The main motivation is to allow kernfs nodes to inherit the context of
the parent under SELinux, similar to the behavior of
security_inode_init_security(). Other LSMs may implement their own logic
for handling the creation of new nodes.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/lsm_hooks.h |  5 +++++
 include/linux/security.h  | 12 ++++++++++++
 security/security.c       |  8 ++++++++
 3 files changed, 25 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index aaeb7fa24dc4..f2b4c0bf4a7b 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1556,6 +1556,10 @@ union security_list_options {
 	int (*inode_copy_up)(struct dentry *src, struct cred **new);
 	int (*inode_copy_up_xattr)(const char *name);
 
+	int (*object_init_security)(void *parent_ctx, u32 parent_ctxlen,
+				    const struct qstr *qstr, u16 mode,
+				    void **ctx, u32 *ctxlen);
+
 	int (*file_permission)(struct file *file, int mask);
 	int (*file_alloc_security)(struct file *file);
 	void (*file_free_security)(struct file *file);
@@ -1855,6 +1859,7 @@ struct security_hook_heads {
 	struct hlist_head inode_getsecid;
 	struct hlist_head inode_copy_up;
 	struct hlist_head inode_copy_up_xattr;
+	struct hlist_head object_init_security;
 	struct hlist_head file_permission;
 	struct hlist_head file_alloc_security;
 	struct hlist_head file_free_security;
diff --git a/include/linux/security.h b/include/linux/security.h
index d170a5b031f3..e20d1f378ea4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -315,6 +315,9 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 void security_inode_getsecid(struct inode *inode, u32 *secid);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
+int security_object_init_security(void *parent_ctx, u32 parent_ctxlen,
+				  const struct qstr *qstr, u16 mode,
+				  void **ctx, u32 *ctxlen);
 int security_file_permission(struct file *file, int mask);
 int security_file_alloc(struct file *file);
 void security_file_free(struct file *file);
@@ -815,6 +818,15 @@ static inline int security_inode_copy_up_xattr(const char *name)
 	return -EOPNOTSUPP;
 }
 
+static inline int security_object_init_security(void *parent_ctx,
+						u32 parent_ctxlen,
+						const struct qstr *qstr,
+						u16 mode, void **ctx,
+						u32 *ctxlen)
+{
+	return 0;
+}
+
 static inline int security_file_permission(struct file *file, int mask)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index 04d173eb93f6..56e77368b87f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -879,6 +879,14 @@ int security_inode_copy_up_xattr(const char *name)
 }
 EXPORT_SYMBOL(security_inode_copy_up_xattr);
 
+int security_object_init_security(void *parent_ctx, u32 parent_ctxlen,
+				  const struct qstr *qstr, u16 mode,
+				  void **ctx, u32 *ctxlen)
+{
+	return call_int_hook(object_init_security, 0, parent_ctx, parent_ctxlen,
+			     qstr, mode, ctx, ctxlen);
+}
+
 int security_file_permission(struct file *file, int mask)
 {
 	int ret;
-- 
2.20.1

