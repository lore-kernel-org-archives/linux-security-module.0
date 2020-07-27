Return-Path: <SRS0=m40R=BG=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876D1C433E3
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jul 2020 21:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6576620809
	for <linux-security-module@archiver.kernel.org>; Mon, 27 Jul 2020 21:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Flsp2quf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgG0Vak (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:30:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47951 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgG0Vak (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Jul 2020 17:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595885438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=xRQavoTxy6WU9VHdh3GgKlMshVx0eklnqw7rYScM/Kk=;
        b=Flsp2qufDNZifSDdKbYse81JUJj3yik7u9hOeQvq2khpcpOuBX6y7FFogN7nM1qvt9ud5k
        tD+wHb7Q6E4zs3503nkCjrFnZgAU9OJNujV41NS/cICPYt83OCMgJsy+gnaTnp7STssDBp
        nO7oNjWLH059ndByNnzKmYCINyVPTHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-TgKhn0k2MF-dUgH99Yy8Qw-1; Mon, 27 Jul 2020 17:30:34 -0400
X-MC-Unique: TgKhn0k2MF-dUgH99Yy8Qw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B71B1932490;
        Mon, 27 Jul 2020 21:30:33 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFBAC10013C4;
        Mon, 27 Jul 2020 21:30:25 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>, eparis@parisplace.org,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH V3fix ghak120] audit: initialize context values in case of mandatory events
Date:   Mon, 27 Jul 2020 17:29:59 -0400
Message-Id: <e3e9c9da9115fd233c5a7895dbb4a698a365b1b0.1595884394.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Issue ghak120 enabled syscall records to accompany required records when
no rules are present to trigger the storage of syscall context.  A
reported issue showed that the cwd was not always initialized.  That
issue was already resolved, but a review of all other records that could
be triggered at the time of a syscall record revealed other potential
values that could be missing or misleading.  Initialize them.

The fds array is reset to -1 after the first syscall to indicate it
isn't valid any more, but was never set to -1 when the context was
allocated to indicate it wasn't yet valid.

The audit_inode* functions can be called without going through
getname_flags() or getname_kernel() that sets audit_names and cwd, so
set the cwd if it has not already been done so due to audit_names being
valid.

The LSM dump_common_audit_data() LSM_AUDIT_DATA_NET:AF_UNIX case was
missed with the ghak96 patch, so add that case here.

Please see issue https://github.com/linux-audit/audit-kernel/issues/120
Please see issue https://github.com/linux-audit/audit-kernel/issues/96
Passes audit-testsuite.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditsc.c     | 3 +++
 security/lsm_audit.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6884b50069d1..2f97618e6a34 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -929,6 +929,7 @@ static inline struct audit_context *audit_alloc_context(enum audit_state state)
 	context->prio = state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0;
 	INIT_LIST_HEAD(&context->killed_trees);
 	INIT_LIST_HEAD(&context->names_list);
+	context->fds[0] = -1;
 	return context;
 }
 
@@ -2076,6 +2077,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 	}
 	handle_path(dentry);
 	audit_copy_inode(n, dentry, inode, flags & AUDIT_INODE_NOEVAL);
+	_audit_getcwd(context);
 }
 
 void __audit_file(const struct file *file)
@@ -2194,6 +2196,7 @@ void __audit_inode_child(struct inode *parent,
 		audit_copy_inode(found_child, dentry, inode, 0);
 	else
 		found_child->ino = AUDIT_INO_UNSET;
+	_audit_getcwd(context);
 }
 EXPORT_SYMBOL_GPL(__audit_inode_child);
 
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 53d0d183db8f..e93077612246 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -369,6 +369,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 					audit_log_untrustedstring(ab, p);
 				else
 					audit_log_n_hex(ab, p, len);
+				audit_getcwd();
 				break;
 			}
 		}
-- 
1.8.3.1

