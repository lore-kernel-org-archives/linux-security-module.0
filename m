Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B14C43381
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B5D21738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfBSQa7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:30:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36808 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729120AbfBSQa7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:30:59 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 047467F746;
        Tue, 19 Feb 2019 16:30:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B51ED101962A;
        Tue, 19 Feb 2019 16:30:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 19/43] vfs: Put security flags into the fs_context struct
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:30:56 +0000
Message-ID: <155059385694.12449.4260302564821199185.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 19 Feb 2019 16:30:59 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Put security flags, such as SECURITY_LSM_NATIVE_LABELS, into the filesystem
context so that the filesystem can communicate them to the LSM more easily.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 include/linux/fs_context.h |    1 +
 include/linux/security.h   |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 899027c94788..d5ff3b0bc28d 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -85,6 +85,7 @@ struct fs_context {
 	void			*security;	/* Linux S&M options */
 	unsigned int		sb_flags;	/* Proposed superblock flags (SB_*) */
 	unsigned int		sb_flags_mask;	/* Superblock flags that were changed */
+	unsigned int		lsm_flags;	/* Information flags from the fs to the LSM */
 	enum fs_context_purpose	purpose:8;
 	bool			need_free:1;	/* Need to call ops->free() */
 };
diff --git a/include/linux/security.h b/include/linux/security.h
index 1cc4d7a3d6fa..2da9336a987e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -61,7 +61,7 @@ enum fs_value_type;
 #define SECURITY_CAP_NOAUDIT 0
 #define SECURITY_CAP_AUDIT 1
 
-/* LSM Agnostic defines for sb_set_mnt_opts */
+/* LSM Agnostic defines for fs_context::lsm_flags */
 #define SECURITY_LSM_NATIVE_LABELS	1
 
 struct ctl_table;

