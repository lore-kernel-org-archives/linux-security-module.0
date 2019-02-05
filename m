Return-Path: <SRS0=6WpB=QM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556C2C282CB
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 11:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237942176F
	for <linux-security-module@archiver.kernel.org>; Tue,  5 Feb 2019 11:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfBELGy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:06:54 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34927 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbfBELGw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Feb 2019 06:06:52 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so3184061wmt.0
        for <linux-security-module@vger.kernel.org>; Tue, 05 Feb 2019 03:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3/UgfA2b1LMjP8l3IHGLgf3GGlVLs/lH9BS+aBvDM2I=;
        b=hOqcFCQMbuJOmeUCMo6tJnp2U1em10XkTvTSs9m8Yjv4etrYPDXruKS8o8v/GOW7ZF
         vxd+Am8O2eelFDhdChIWkZiqLk8ytOO4WroElFOW4mWihZZRIn8kYaG9ossEVJG8xfhQ
         ulnmoSD7w8fOrXOQYvgsOLpjTaS+31jsd//e/XB0iL9jHKX6WGXqUJ1qWG/hcjzjVh9V
         FzzXaAlYN/puWghreZd3WR8bAYaRJhly9IYh7Mu/z0FyEdspip0wcvi+sF51f2lJRrrl
         ieVACPJb+cUUH8t0GpPqrOQ+NVd0fz7Itk9Ua6v0BQ3edplNButzqt1uRtqGvhOw0yD7
         VpBg==
X-Gm-Message-State: AHQUAubuqV1FMq4XbM71UoH0cw90xJfgBfZh9T7fuIY4Cj/ikIi+X+/8
        okSSjLbbRS2x36JCwHd/jZtEvrjwnFw=
X-Google-Smtp-Source: AHgI3IY6xruLh9iK67l00gygLYpeYDFM92ZbgXYOFgp4iHRp6OAiiXLZ3IHgyfyB1lbVxiclA/BSaw==
X-Received: by 2002:a1c:1902:: with SMTP id 2mr3388784wmz.150.1549364810864;
        Tue, 05 Feb 2019 03:06:50 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x186sm26067070wmg.41.2019.02.05.03.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 03:06:49 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v5 4/5] selinux: implement the kernfs_init_security hook
Date:   Tue,  5 Feb 2019 12:06:37 +0100
Message-Id: <20190205110638.30782-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205110638.30782-1-omosnace@redhat.com>
References: <20190205110638.30782-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The hook applies the same logic as selinux_determine_inode_label(), with
the exception of the super_block handling, which will be enforced on the
actual inodes later by other hooks.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c | 62 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 758a99d1086e..e013cc02de50 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3354,6 +3354,66 @@ static int selinux_inode_copy_up_xattr(const char *name)
 	return -EOPNOTSUPP;
 }
 
+/* kernfs node operations */
+
+int selinux_kernfs_init_security(const struct qstr *qstr,
+				 const struct iattr *dir_iattr,
+				 struct simple_xattrs *dir_secattr,
+				 const struct iattr *iattr,
+				 struct simple_xattrs *secattr)
+{
+	const struct task_security_struct *tsec = current_security();
+	u32 parent_sid, newsid, clen;
+	int rc;
+	char *context;
+
+	rc = simple_xattr_get(dir_secattr, XATTR_SELINUX_SUFFIX, NULL, 0);
+	if (rc == -ENODATA)
+		return 0;
+	else if (rc < 0)
+		return rc;
+
+	clen = (u32)rc;
+	context = kmalloc(clen, GFP_KERNEL);
+	if (!context)
+		return -ENOMEM;
+
+	rc = simple_xattr_get(dir_secattr, XATTR_SELINUX_SUFFIX, context, clen);
+	if (rc < 0) {
+		kfree(context);
+		return rc;
+	}
+
+	rc = security_context_to_sid(&selinux_state, context, clen, &parent_sid,
+				     GFP_KERNEL);
+	kfree(context);
+	if (rc)
+		return rc;
+
+	if (tsec->create_sid) {
+		newsid = tsec->create_sid;
+	} else {
+		u16 secclass = inode_mode_to_security_class(iattr->ia_mode);
+
+		rc = security_transition_sid(&selinux_state, tsec->sid,
+					     parent_sid, secclass, qstr,
+					     &newsid);
+		if (rc)
+			return rc;
+	}
+
+	rc = security_sid_to_context_force(&selinux_state, newsid,
+					   &context, &clen);
+	if (rc)
+		return rc;
+
+	rc = simple_xattr_set(secattr, XATTR_SELINUX_SUFFIX, context, clen,
+			      XATTR_CREATE);
+	kfree(context);
+	return rc;
+}
+
+
 /* file security operations */
 
 static int selinux_revalidate_file_permission(struct file *file, int mask)
@@ -6800,6 +6860,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
 	LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
 
+	LSM_HOOK_INIT(kernfs_init_security, selinux_kernfs_init_security),
+
 	LSM_HOOK_INIT(file_permission, selinux_file_permission),
 	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
 	LSM_HOOK_INIT(file_free_security, selinux_file_free_security),
-- 
2.20.1

