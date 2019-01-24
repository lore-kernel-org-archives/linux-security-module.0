Return-Path: <SRS0=u3U2=QA=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F94C282C3
	for <linux-security-module@archiver.kernel.org>; Thu, 24 Jan 2019 09:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449F1218A2
	for <linux-security-module@archiver.kernel.org>; Thu, 24 Jan 2019 09:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfAXJhy (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:37:54 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:10680 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfAXJhy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Jan 2019 04:37:54 -0500
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x0O9biM1015232;
        Thu, 24 Jan 2019 18:37:44 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Thu, 24 Jan 2019 18:37:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x0O9bcV0015135
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 24 Jan 2019 18:37:44 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 2/2] tomoyo: Allow multiple use_group lines.
Date:   Thu, 24 Jan 2019 18:37:36 +0900
Message-Id: <1548322656-9212-2-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1548322656-9212-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
References: <1548322656-9212-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Being able to specify multiple "use_group" lines makes it
easier to write whitelisted policies.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/tomoyo/common.c | 44 +++++++++++++++++++++++++++++---------------
 security/tomoyo/common.h |  3 ++-
 security/tomoyo/domain.c | 17 +++++++++++------
 3 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 0f8079b..148ad50 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -1174,7 +1174,7 @@ static int tomoyo_write_domain(struct tomoyo_io_buffer *head)
 	struct tomoyo_domain_info *domain = head->w.domain;
 	const bool is_delete = head->w.is_delete;
 	bool is_select = !is_delete && tomoyo_str_starts(&data, "select ");
-	unsigned int profile;
+	unsigned int idx;
 
 	if (*data == '<') {
 		int ret = 0;
@@ -1192,24 +1192,27 @@ static int tomoyo_write_domain(struct tomoyo_io_buffer *head)
 	if (!domain)
 		return -EINVAL;
 	ns = domain->ns;
-	if (sscanf(data, "use_profile %u", &profile) == 1
-	    && profile < TOMOYO_MAX_PROFILES) {
-		if (!tomoyo_policy_loaded || ns->profile_ptr[profile])
-			domain->profile = (u8) profile;
+	if (sscanf(data, "use_profile %u", &idx) == 1
+	    && idx < TOMOYO_MAX_PROFILES) {
+		if (!tomoyo_policy_loaded || ns->profile_ptr[idx])
+			if (!is_delete)
+				domain->profile = (u8) idx;
 		return 0;
 	}
-	if (sscanf(data, "use_group %u\n", &profile) == 1
-	    && profile < TOMOYO_MAX_ACL_GROUPS) {
+	if (sscanf(data, "use_group %u\n", &idx) == 1
+	    && idx < TOMOYO_MAX_ACL_GROUPS) {
 		if (!is_delete)
-			domain->group = (u8) profile;
+			set_bit(idx, domain->group);
+		else
+			clear_bit(idx, domain->group);
 		return 0;
 	}
-	for (profile = 0; profile < TOMOYO_MAX_DOMAIN_INFO_FLAGS; profile++) {
-		const char *cp = tomoyo_dif[profile];
+	for (idx = 0; idx < TOMOYO_MAX_DOMAIN_INFO_FLAGS; idx++) {
+		const char *cp = tomoyo_dif[idx];
 
 		if (strncmp(data, cp, strlen(cp) - 1))
 			continue;
-		domain->flags[profile] = !is_delete;
+		domain->flags[idx] = !is_delete;
 		return 0;
 	}
 	return tomoyo_write_domain2(ns, &domain->acl_info_list, data,
@@ -1629,22 +1632,33 @@ static void tomoyo_read_domain(struct tomoyo_io_buffer *head)
 			tomoyo_set_lf(head);
 			tomoyo_io_printf(head, "use_profile %u\n",
 					 domain->profile);
-			tomoyo_io_printf(head, "use_group %u\n",
-					 domain->group);
 			for (i = 0; i < TOMOYO_MAX_DOMAIN_INFO_FLAGS; i++)
 				if (domain->flags[i])
 					tomoyo_set_string(head, tomoyo_dif[i]);
+			head->r.index = 0;
 			head->r.step++;
-			tomoyo_set_lf(head);
 			/* fall through */
 		case 1:
+			while (head->r.index < TOMOYO_MAX_ACL_GROUPS) {
+				i = head->r.index++;
+				if (!test_bit(i, domain->group))
+					continue;
+				tomoyo_io_printf(head, "use_group %u\n", i);
+				if (!tomoyo_flush(head))
+					return;
+			}
+			head->r.index = 0;
+			head->r.step++;
+			tomoyo_set_lf(head);
+			/* fall through */
+		case 2:
 			if (!tomoyo_read_domain2(head, &domain->acl_info_list))
 				return;
 			head->r.step++;
 			if (!tomoyo_set_lf(head))
 				return;
 			/* fall through */
-		case 2:
+		case 3:
 			head->r.step = 0;
 			if (head->r.print_this_domain_only)
 				goto done;
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index f2c458a..74dbd3b 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -684,8 +684,9 @@ struct tomoyo_domain_info {
 	const struct tomoyo_path_info *domainname;
 	/* Namespace for this domain. Never NULL. */
 	struct tomoyo_policy_namespace *ns;
+	/* Group numbers to use.   */
+	unsigned long group[TOMOYO_MAX_ACL_GROUPS / BITS_PER_LONG];
 	u8 profile;        /* Profile number to use. */
-	u8 group;          /* Group number to use.   */
 	bool is_deleted;   /* Delete flag.           */
 	bool flags[TOMOYO_MAX_DOMAIN_INFO_FLAGS];
 	atomic_t users; /* Number of referring tasks. */
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index bf832b3..8526a0a 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -162,8 +162,8 @@ void tomoyo_check_acl(struct tomoyo_request_info *r,
 {
 	const struct tomoyo_domain_info *domain = r->domain;
 	struct tomoyo_acl_info *ptr;
-	bool retried = false;
 	const struct list_head *list = &domain->acl_info_list;
+	u16 i = 0;
 
 retry:
 	list_for_each_entry_rcu(ptr, list, list) {
@@ -177,9 +177,10 @@ void tomoyo_check_acl(struct tomoyo_request_info *r,
 		r->granted = true;
 		return;
 	}
-	if (!retried) {
-		retried = true;
-		list = &domain->ns->acl_group[domain->group];
+	for (; i < TOMOYO_MAX_ACL_GROUPS; i++) {
+		if (!test_bit(i, domain->group))
+			continue;
+		list = &domain->ns->acl_group[i++];
 		goto retry;
 	}
 	r->granted = false;
@@ -561,7 +562,7 @@ struct tomoyo_domain_info *tomoyo_assign_domain(const char *domainname,
 		const struct tomoyo_domain_info *domain = tomoyo_domain();
 
 		e.profile = domain->profile;
-		e.group = domain->group;
+		memcpy(e.group, domain->group, sizeof(e.group));
 	}
 	e.domainname = tomoyo_get_name(domainname);
 	if (!e.domainname)
@@ -583,13 +584,17 @@ struct tomoyo_domain_info *tomoyo_assign_domain(const char *domainname,
 	if (entry && transit) {
 		if (created) {
 			struct tomoyo_request_info r;
+			int i;
 
 			tomoyo_init_request_info(&r, entry,
 						 TOMOYO_MAC_FILE_EXECUTE);
 			r.granted = false;
 			tomoyo_write_log(&r, "use_profile %u\n",
 					 entry->profile);
-			tomoyo_write_log(&r, "use_group %u\n", entry->group);
+			for (i = 0; i < TOMOYO_MAX_ACL_GROUPS; i++)
+				if (test_bit(i, entry->group))
+					tomoyo_write_log(&r, "use_group %u\n",
+							 i);
 			tomoyo_update_stat(TOMOYO_STAT_POLICY_UPDATES);
 		}
 	}
-- 
1.8.3.1

