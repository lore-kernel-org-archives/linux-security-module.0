Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8FEC5517A
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Nov 2020 21:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A2DC2100A
	for <linux-security-module@archiver.kernel.org>; Wed, 11 Nov 2020 21:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgKKVev (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 11 Nov 2020 16:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgKKVev (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 Nov 2020 16:34:51 -0500
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C15C0613D4
        for <linux-security-module@vger.kernel.org>; Wed, 11 Nov 2020 13:34:50 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CWdKz2lNrzlhbQT;
        Wed, 11 Nov 2020 22:34:47 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4CWdKz0tvLzlh8TF;
        Wed, 11 Nov 2020 22:34:47 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 2/9] landlock: Cosmetic fixes for filesystem management
Date:   Wed, 11 Nov 2020 22:34:35 +0100
Message-Id: <20201111213442.434639-3-mic@digikod.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111213442.434639-1-mic@digikod.net>
References: <20201111213442.434639-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Improve comments and make get_inode_object() more readable.  The kfree()
call is correct but we should mimimize as much as possible lock windows.

Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/fs.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index b67c821bb40b..33fc7ae17c7f 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -85,8 +85,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 			return object;
 		}
 		/*
-		 * We're racing with release_inode(), the object is going away.
-		 * Wait for release_inode(), then retry.
+		 * We are racing with release_inode(), the object is going
+		 * away.  Wait for release_inode(), then retry.
 		 */
 		spin_lock(&object->lock);
 		spin_unlock(&object->lock);
@@ -107,21 +107,21 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 			lockdep_is_held(&inode->i_lock));
 	if (unlikely(object)) {
 		/* Someone else just created the object, bail out and retry. */
-		kfree(new_object);
 		spin_unlock(&inode->i_lock);
+		kfree(new_object);
 
 		rcu_read_lock();
 		goto retry;
-	} else {
-		rcu_assign_pointer(inode_sec->object, new_object);
-		/*
-		 * @inode will be released by hook_sb_delete() on its
-		 * superblock shutdown.
-		 */
-		ihold(inode);
-		spin_unlock(&inode->i_lock);
-		return new_object;
 	}
+
+	rcu_assign_pointer(inode_sec->object, new_object);
+	/*
+	 * @inode will be released by hook_sb_delete() on its superblock
+	 * shutdown.
+	 */
+	ihold(inode);
+	spin_unlock(&inode->i_lock);
+	return new_object;
 }
 
 /* All access rights which can be tied to files. */
-- 
2.29.2

