Return-Path: <SRS0=18aP=Q2=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8A7C10F00
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CDE21738
	for <linux-security-module@archiver.kernel.org>; Tue, 19 Feb 2019 16:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbfBSQaU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:30:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728984AbfBSQaU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 19 Feb 2019 11:30:20 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70B6AA8C1A;
        Tue, 19 Feb 2019 16:30:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-129.rdu2.redhat.com [10.10.121.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2695061460;
        Tue, 19 Feb 2019 16:30:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 14/43] vfs: Introduce logging functions
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-security-module@vger.kernel.org
Date:   Tue, 19 Feb 2019 16:30:17 +0000
Message-ID: <155059381736.12449.16194644068515549957.stgit@warthog.procyon.org.uk>
In-Reply-To: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
References: <155059366914.12449.4669870128936536848.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 19 Feb 2019 16:30:19 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Introduce a set of logging functions through which informational messages,
warnings and error messages incurred by the mount procedure can be logged
and, in a future patch, passed to userspace instead by way of the
filesystem configuration context file descriptor.

There are four functions:

 (1) infof(const char *fmt, ...);

     Logs an informational message.

 (2) warnf(const char *fmt, ...);

     Logs a warning message.

 (3) errorf(const char *fmt, ...);

     Logs an error message.

 (4) invalf(const char *fmt, ...);

     As errof(), but returns -EINVAL so can be used on a return statement.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 include/linux/fs_context.h |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 087c12954360..d208cc40b868 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -81,4 +81,46 @@ extern struct fs_context *fs_context_for_submount(struct file_system_type *fs_ty
 extern int vfs_get_tree(struct fs_context *fc);
 extern void put_fs_context(struct fs_context *fc);
 
+#define logfc(FC, FMT, ...) pr_notice(FMT, ## __VA_ARGS__)
+
+/**
+ * infof - Store supplementary informational message
+ * @fc: The context in which to log the informational message
+ * @fmt: The format string
+ *
+ * Store the supplementary informational message for the process if the process
+ * has enabled the facility.
+ */
+#define infof(fc, fmt, ...) ({ logfc(fc, fmt, ## __VA_ARGS__); })
+
+/**
+ * warnf - Store supplementary warning message
+ * @fc: The context in which to log the error message
+ * @fmt: The format string
+ *
+ * Store the supplementary warning message for the process if the process has
+ * enabled the facility.
+ */
+#define warnf(fc, fmt, ...) ({ logfc(fc, fmt, ## __VA_ARGS__); })
+
+/**
+ * errorf - Store supplementary error message
+ * @fc: The context in which to log the error message
+ * @fmt: The format string
+ *
+ * Store the supplementary error message for the process if the process has
+ * enabled the facility.
+ */
+#define errorf(fc, fmt, ...) ({ logfc(fc, fmt, ## __VA_ARGS__); })
+
+/**
+ * invalf - Store supplementary invalid argument error message
+ * @fc: The context in which to log the error message
+ * @fmt: The format string
+ *
+ * Store the supplementary error message for the process if the process has
+ * enabled the facility and return -EINVAL.
+ */
+#define invalf(fc, fmt, ...) ({	errorf(fc, fmt, ## __VA_ARGS__); -EINVAL; })
+
 #endif /* _LINUX_FS_CONTEXT_H */

