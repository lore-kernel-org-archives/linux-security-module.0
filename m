Return-Path: <SRS0=sdO6=QG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE95C4151A
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Jan 2019 11:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA9F20882
	for <linux-security-module@archiver.kernel.org>; Wed, 30 Jan 2019 11:43:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbfA3LnT (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 30 Jan 2019 06:43:19 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52351 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730726AbfA3LnS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Jan 2019 06:43:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so21293229wml.2
        for <linux-security-module@vger.kernel.org>; Wed, 30 Jan 2019 03:43:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bwZaBUMbAyqtAAMHTRBptNWrdAnFHf5/tzQ1TQOEZ50=;
        b=MQ97BAKiLWhafddI+x1R2Qd69tZNshZza5aSCzmm+PtjtZibuejafuE/ETXIm6JQ5l
         lkGgqlrnBaZ94uFKRLQMIkja53hX42K6327qCHjh1beiiErxq6YpSzpcZ0eOzrIdXs7c
         eMLHCuO4/GMh0ouijh3KVv3RuJTYC4QKA4XK0mQMuLn4aG7+4zFek0rayw4jAGy63gKc
         J57PNRGCdGOIxUOGkuCizYhqG6Yei8XecwlrZH0f1EV3qZ+X0IK1/mty/n3Iz0DAVUOb
         8S4dE02rNrPh3vKDKC3epDVY8FmTJm6vq+SYQNNe4gLlAiHQND5V690vEYB723s1gIaq
         BD3w==
X-Gm-Message-State: AJcUukdYbuziXMi0PPOaL7wKY1UJFMdOBZ+LXMe058sWigEcuuivZlqt
        /5TqGqKGZcMEqtJRjUX7YJrphQ==
X-Google-Smtp-Source: ALg8bN5yG9/nB5D7U6txxrbD7EOF24JY1CuihbJGxm4O2Zny3HNx98SsFraeW/mbfiXxv8eUtwtuiQ==
X-Received: by 2002:a7b:cb18:: with SMTP id u24mr23992020wmj.138.1548848596714;
        Wed, 30 Jan 2019 03:43:16 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n124sm2417691wmd.15.2019.01.30.03.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 03:43:16 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v3 4/5] selinux: implement the kernfs_init_security hook
Date:   Wed, 30 Jan 2019 12:41:49 +0100
Message-Id: <20190130114150.27807-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130114150.27807-1-omosnace@redhat.com>
References: <20190130114150.27807-1-omosnace@redhat.com>
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
 security/selinux/hooks.c | 61 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 758a99d1086e..1f2239c191bd 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3354,6 +3354,65 @@ static int selinux_inode_copy_up_xattr(const char *name)
 	return -EOPNOTSUPP;
 }
 
+/* kernfs node operations */
+
+int selinux_kernfs_init_security(const struct qstr *qstr, struct iattr *iattr,
+				 struct simple_xattrs *secattr,
+				 struct iattr *dir_iattr,
+				 struct simple_xattrs *dir_secattr)
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
@@ -6800,6 +6859,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
 	LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
 
+	LSM_HOOK_INIT(kernfs_init_security, selinux_kernfs_init_security),
+
 	LSM_HOOK_INIT(file_permission, selinux_file_permission),
 	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
 	LSM_HOOK_INIT(file_free_security, selinux_file_free_security),
-- 
2.20.1

