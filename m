Return-Path: <SRS0=tCoi=PR=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53F4C43387
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Jan 2019 16:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D11E2054F
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Jan 2019 16:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfAIQ24 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:28:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36997 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfAIQ2x (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Jan 2019 11:28:53 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so8326962wrt.4
        for <linux-security-module@vger.kernel.org>; Wed, 09 Jan 2019 08:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gUKYH05t5p4O+cmOA3k/UE0l2qyG664+3B+v8a8N7S0=;
        b=LuSZ04sRNw3PYUt284obL6X9UiV8TPIgfNcoXDTYXSlQaxf1RW5hid8f8U4O4O+Wn/
         GJbdI74LF+Lu+A0adAoj46EUAC7ky7JfGeuNwNo5OMtbsYnejf0W6q5pFFHDNzbK83SX
         d5za8eM5WRzoCn0I9UX3q9nnQXYksNkwg6Z29o9s7dFQ4lKQ93E+qf+ykw5rqbKCTRs9
         3f6evMIESby1fbMAuBfJ5bxuu7PfcQdR7zHllQ+cy84EB97GybMyoxdM8FGapXky5x7T
         bp7Kcnp8VeEha2AlfkJYZe3WpRPlliDf9HzF56FSHmmAUzfYOq2BN6uHShWifxA4zYXH
         91gw==
X-Gm-Message-State: AJcUukcFW/vMRZuqdwpj246ACK+/6CAUzldZOMnLxYwTjnmMYEZqh/FS
        NSA8nL5vxystj9XGN/k05nSkZQ==
X-Google-Smtp-Source: ALg8bN6J5pHuVP32MSuo+49cH2swPLCPzGxXZqEs0yOj1SdXDlNSXWh12ZsH7rgztwgnOMf9RzRIhg==
X-Received: by 2002:a5d:6244:: with SMTP id m4mr5546430wrv.314.1547051332035;
        Wed, 09 Jan 2019 08:28:52 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a17sm13661438wma.15.2019.01.09.08.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 08:28:50 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v2 2/3] selinux: Implement the object_init_security hook
Date:   Wed,  9 Jan 2019 17:28:29 +0100
Message-Id: <20190109162830.8309-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109162830.8309-1-omosnace@redhat.com>
References: <20190109162830.8309-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The hook applies the same logic as selinux_determine_inode_label(), with
the exception of the super_block handling, which will be enforced on the
actual inodes by other hooks.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Reviewed-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c | 41 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7ce012d9ec51..29c038513504 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3526,6 +3526,45 @@ static int selinux_inode_copy_up_xattr(const char *name)
 	return -EOPNOTSUPP;
 }
 
+/* file-like object operations */
+
+/* Used e.g. for kernfs_node for newly created nodes */
+static int selinux_object_init_security(void *parent_ctx, u32 parent_ctxlen,
+					const struct qstr *qstr, u16 mode,
+					void **ctx, u32 *ctxlen)
+{
+	const struct task_security_struct *tsec = current_security();
+	u32 parent_sid, newsid, clen;
+	int rc;
+	char *context;
+
+	rc = security_context_to_sid(&selinux_state, parent_ctx, parent_ctxlen,
+				     &parent_sid, GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	if (tsec->create_sid) {
+		newsid = tsec->create_sid;
+	} else {
+		u16 secclass = inode_mode_to_security_class(mode);
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
+	*ctx = context;
+	*ctxlen = clen;
+	return 0;
+}
+
 /* file security operations */
 
 static int selinux_revalidate_file_permission(struct file *file, int mask)
@@ -6965,6 +7004,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(inode_copy_up, selinux_inode_copy_up),
 	LSM_HOOK_INIT(inode_copy_up_xattr, selinux_inode_copy_up_xattr),
 
+	LSM_HOOK_INIT(object_init_security, selinux_object_init_security),
+
 	LSM_HOOK_INIT(file_permission, selinux_file_permission),
 	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
 	LSM_HOOK_INIT(file_free_security, selinux_file_free_security),
-- 
2.20.1

