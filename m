Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB174E7D0A2
	for <linux-security-module@archiver.kernel.org>; Thu, 21 Sep 2023 19:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjIUT3r (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 21 Sep 2023 15:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjIUT3T (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Sep 2023 15:29:19 -0400
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E05612446
        for <linux-security-module@vger.kernel.org>; Thu, 21 Sep 2023 10:06:53 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RrlY738kszMpnsb;
        Thu, 21 Sep 2023 06:16:59 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RrlY62SQNzMppKT;
        Thu, 21 Sep 2023 08:16:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1695277019;
        bh=C96mByL5VMgKe+z3S4sdB6o2Dq3umyYV2RysHQLeFgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NIh9AE6iGXfm/w7dRtI3eR/bv26/nMk6QUSrB46LLWPGRDS69Fz10CJeqMYOtM3Jf
         ptzdpk0XS+wZajN8f6q6NpzX9bYPyCWibReuzVDfHT/HDZAh7GkkTTYCTiZiNYxqj0
         1xcDI7CD86C3lYgqB/e/ZiQ2kUmJEoNIcZ/oLGME=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Ben Scarlato <akhna@google.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
        Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@google.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shervin Oloumi <enlightened@google.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [RFC PATCH v1 1/7] lsm: Add audit_log_lsm_data() helper
Date:   Thu, 21 Sep 2023 08:16:35 +0200
Message-ID: <20230921061641.273654-2-mic@digikod.net>
In-Reply-To: <20230921061641.273654-1-mic@digikod.net>
References: <20230921061641.273654-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Extract code from common_dump_audit_data() into the audit_log_lsm_data()
helper. This helps reuse common LSM audit data while not abusing
AUDIT_AVC records because of the common_lsm_audit() helper.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 include/linux/lsm_audit.h |  2 ++
 security/lsm_audit.c      | 26 +++++++++++++++++---------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/lsm_audit.h b/include/linux/lsm_audit.h
index 97a8b21eb033..5f9a7ed0e7a5 100644
--- a/include/linux/lsm_audit.h
+++ b/include/linux/lsm_audit.h
@@ -122,6 +122,8 @@ int ipv4_skb_to_auditdata(struct sk_buff *skb,
 int ipv6_skb_to_auditdata(struct sk_buff *skb,
 		struct common_audit_data *ad, u8 *proto);
 
+void audit_log_lsm_data(struct audit_buffer *ab, struct common_audit_data *a);
+
 void common_lsm_audit(struct common_audit_data *a,
 	void (*pre_audit)(struct audit_buffer *, void *),
 	void (*post_audit)(struct audit_buffer *, void *));
diff --git a/security/lsm_audit.c b/security/lsm_audit.c
index 849e832719e2..58f9b8bde22a 100644
--- a/security/lsm_audit.c
+++ b/security/lsm_audit.c
@@ -189,16 +189,12 @@ static inline void print_ipv4_addr(struct audit_buffer *ab, __be32 addr,
 }
 
 /**
- * dump_common_audit_data - helper to dump common audit data
+ * audit_log_lsm_data - helper to log common LSM audit data
  * @ab : the audit buffer
  * @a : common audit data
- *
  */
-static void dump_common_audit_data(struct audit_buffer *ab,
-				   struct common_audit_data *a)
+void audit_log_lsm_data(struct audit_buffer *ab, struct common_audit_data *a)
 {
-	char comm[sizeof(current->comm)];
-
 	/*
 	 * To keep stack sizes in check force programmers to notice if they
 	 * start making this union too large!  See struct lsm_network_audit
@@ -206,9 +202,6 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	 */
 	BUILD_BUG_ON(sizeof(a->u) > sizeof(void *)*2);
 
-	audit_log_format(ab, " pid=%d comm=", task_tgid_nr(current));
-	audit_log_untrustedstring(ab, memcpy(comm, current->comm, sizeof(comm)));
-
 	switch (a->type) {
 	case LSM_AUDIT_DATA_NONE:
 		return;
@@ -428,6 +421,21 @@ static void dump_common_audit_data(struct audit_buffer *ab,
 	} /* switch (a->type) */
 }
 
+/**
+ * dump_common_audit_data - helper to dump common audit data
+ * @ab : the audit buffer
+ * @a : common audit data
+ */
+static void dump_common_audit_data(struct audit_buffer *ab,
+				   struct common_audit_data *a)
+{
+	char comm[sizeof(current->comm)];
+
+	audit_log_format(ab, " pid=%d comm=", task_tgid_nr(current));
+	audit_log_untrustedstring(ab, memcpy(comm, current->comm, sizeof(comm)));
+	audit_log_lsm_data(ab, a);
+}
+
 /**
  * common_lsm_audit - generic LSM auditing function
  * @a:  auxiliary audit data
-- 
2.42.0

