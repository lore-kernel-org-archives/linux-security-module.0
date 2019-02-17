Return-Path: <SRS0=nw36=QY=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EDEC43381
	for <linux-security-module@archiver.kernel.org>; Sun, 17 Feb 2019 06:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13B321B69
	for <linux-security-module@archiver.kernel.org>; Sun, 17 Feb 2019 06:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfBQGxB (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 17 Feb 2019 01:53:01 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:23322 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfBQGxB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 17 Feb 2019 01:53:01 -0500
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1H6qpgT060789;
        Sun, 17 Feb 2019 15:52:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp);
 Sun, 17 Feb 2019 15:52:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1H6qlNd060757
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 17 Feb 2019 15:52:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     James Morris <jmorris@namei.org>
Cc:     linux-security-module@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        "M: Kentaro Takeda" <takedakn@nttdata.co.jp>
Subject: [PATCH] tomoyo: Bump version.
Date:   Sun, 17 Feb 2019 15:52:47 +0900
Message-Id: <1550386367-9266-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Update URLs and profile version.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 MAINTAINERS              | 11 +++++------
 security/tomoyo/common.c | 19 ++++++++++++-------
 security/tomoyo/common.h |  2 +-
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 305a30f..4f025cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15591,12 +15591,11 @@ F:	mm/shmem.c
 TOMOYO SECURITY MODULE
 M:	Kentaro Takeda <takedakn@nttdata.co.jp>
 M:	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
-L:	tomoyo-dev-en@lists.sourceforge.jp (subscribers-only, for developers in English)
-L:	tomoyo-users-en@lists.sourceforge.jp (subscribers-only, for users in English)
-L:	tomoyo-dev@lists.sourceforge.jp (subscribers-only, for developers in Japanese)
-L:	tomoyo-users@lists.sourceforge.jp (subscribers-only, for users in Japanese)
-W:	http://tomoyo.sourceforge.jp/
-T:	quilt http://svn.sourceforge.jp/svnroot/tomoyo/trunk/2.5.x/tomoyo-lsm/patches/
+L:	tomoyo-dev-en@lists.osdn.me (subscribers-only, for developers in English)
+L:	tomoyo-users-en@lists.osdn.me (subscribers-only, for users in English)
+L:	tomoyo-dev@lists.osdn.me (subscribers-only, for developers in Japanese)
+L:	tomoyo-users@lists.osdn.me (subscribers-only, for users in Japanese)
+W:	https://tomoyo.osdn.jp/
 S:	Maintained
 F:	security/tomoyo/
 
diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 148ad50..57988d9 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -354,7 +354,7 @@ void tomoyo_init_policy_namespace(struct tomoyo_policy_namespace *ns)
 		INIT_LIST_HEAD(&ns->group_list[idx]);
 	for (idx = 0; idx < TOMOYO_MAX_POLICY; idx++)
 		INIT_LIST_HEAD(&ns->policy_list[idx]);
-	ns->profile_version = 20110903;
+	ns->profile_version = 20150505;
 	tomoyo_namespace_enabled = !list_empty(&tomoyo_namespace_list);
 	list_add_tail_rcu(&ns->namespace_list, &tomoyo_namespace_list);
 }
@@ -2300,7 +2300,7 @@ static int tomoyo_write_answer(struct tomoyo_io_buffer *head)
 static void tomoyo_read_version(struct tomoyo_io_buffer *head)
 {
 	if (!head->r.eof) {
-		tomoyo_io_printf(head, "2.5.0");
+		tomoyo_io_printf(head, "2.6.0");
 		head->r.eof = true;
 	}
 }
@@ -2777,12 +2777,17 @@ void tomoyo_check_profile(void)
 	const int idx = tomoyo_read_lock();
 
 	tomoyo_policy_loaded = true;
-	pr_info("TOMOYO: 2.5.0\n");
+	pr_info("TOMOYO: 2.6.0\n");
 	list_for_each_entry_rcu(domain, &tomoyo_domain_list, list) {
 		const u8 profile = domain->profile;
-		const struct tomoyo_policy_namespace *ns = domain->ns;
+		struct tomoyo_policy_namespace *ns = domain->ns;
 
-		if (ns->profile_version != 20110903)
+		if (ns->profile_version == 20110903) {
+			pr_info_once("Converting profile version from %u to %u.\n",
+				     20110903, 20150505);
+			ns->profile_version = 20150505;
+		}
+		if (ns->profile_version != 20150505)
 			pr_err("Profile version %u is not supported.\n",
 			       ns->profile_version);
 		else if (!ns->profile_ptr[profile])
@@ -2790,8 +2795,8 @@ void tomoyo_check_profile(void)
 			       profile, domain->domainname->name);
 		else
 			continue;
-		pr_err("Userland tools for TOMOYO 2.5 must be installed and policy must be initialized.\n");
-		pr_err("Please see http://tomoyo.sourceforge.jp/2.5/ for more information.\n");
+		pr_err("Userland tools for TOMOYO 2.6 must be installed and policy must be initialized.\n");
+		pr_err("Please see https://tomoyo.osdn.jp/2.6/ for more information.\n");
 		panic("STOP!");
 	}
 	tomoyo_read_unlock(idx);
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 74dbd3b..050473d 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -910,7 +910,7 @@ struct tomoyo_policy_namespace {
 	struct list_head acl_group[TOMOYO_MAX_ACL_GROUPS];
 	/* List for connecting to tomoyo_namespace_list list. */
 	struct list_head namespace_list;
-	/* Profile version. Currently only 20110903 is defined. */
+	/* Profile version. Currently only 20150505 is defined. */
 	unsigned int profile_version;
 	/* Name of this namespace (e.g. "<kernel>", "</usr/sbin/httpd>" ). */
 	const char *name;
-- 
1.8.3.1

