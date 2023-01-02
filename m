Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CC2C46467
	for <linux-security-module@archiver.kernel.org>; Mon,  2 Jan 2023 20:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjABUpW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 2 Jan 2023 15:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjABUpV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Jan 2023 15:45:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4C46258
        for <linux-security-module@vger.kernel.org>; Mon,  2 Jan 2023 12:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=b5HTI95Gc+VNnu4QEJkhkMwPSqYWh1+QLzaknMGGtBo=; b=XKtvj6bn32U4Th9WoUgjgtQQiV
        YwTBhv2VW6eq6CLdI4rEDku94nl+9glBe8JF+KvV7iZJkklamZ8lKK5VFkVeVv4j1by1IVNxcKMhY
        yOcSqMICbI/mcrVGwnn5xVj+TvrK+0pJibgFPnvpvlN18iC63o0vc85KviEXrILAIK1Hq7v83zqaH
        jytUnH0SlM6+C4+ncagbz2TrnsInOOiEtW+UFozYFXh04XEG2tEy8wxczYkibRp/fr1Ow+ONldpGu
        qcV0oMvZlneurdqUI36vfLAtBietnymn0u4QzK5fcHldRwtbpcXJBkUB5QHnWO0vhwpXCexv8+Aej
        XJ1UPpRw==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCRgI-00EFXN-D7; Mon, 02 Jan 2023 20:45:14 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-security-module@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        John Johansen <john.johansen@canonical.com>,
        John Johansen <john@apparmor.net>, apparmor@lists.ubuntu.com,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH] apparmor: fix kernel-doc complaints
Date:   Mon,  2 Jan 2023 12:45:12 -0800
Message-Id: <20230102204512.3972-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Correct kernel-doc notation to placate kernel-doc W=1 warnings:

security/apparmor/policy.c:439: warning: duplicate section name 'Return'
security/apparmor/secid.c:57: warning: Cannot understand  *
security/apparmor/file.c:174: warning: cannot understand function prototype: 'struct aa_perms default_perms = '

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: John Johansen <john.johansen@canonical.com>
Cc: John Johansen <john@apparmor.net>
Cc: apparmor@lists.ubuntu.com
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
---
 security/apparmor/file.c   |    2 +-
 security/apparmor/policy.c |    7 ++-----
 security/apparmor/secid.c  |    3 +--
 3 files changed, 4 insertions(+), 8 deletions(-)

diff -- a/security/apparmor/policy.c b/security/apparmor/policy.c
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -430,11 +430,9 @@ static struct aa_policy *__lookup_parent
  * @hname: hierarchical profile name to find parent of (NOT NULL)
  * @gfp: type of allocation.
  *
- * Returns: NULL on error, parent profile on success
- *
  * Requires: ns mutex lock held
  *
- * Returns: unrefcounted parent policy or NULL if error creating
+ * Return: unrefcounted parent policy on success or %NULL if error creating
  *          place holder profiles.
  */
 static struct aa_policy *__create_missing_ancestors(struct aa_ns *ns,
@@ -828,7 +826,7 @@ bool aa_current_policy_admin_capable(str
 /**
  * aa_may_manage_policy - can the current task manage policy
  * @label: label to check if it can manage policy
- * @op: the policy manipulation operation being done
+ * @mask: contains the policy manipulation operation being done
  *
  * Returns: 0 if the task is allowed to manipulate policy else error
  */
@@ -883,7 +881,6 @@ static struct aa_profile *__list_lookup_
  * __replace_profile - replace @old with @new on a list
  * @old: profile to be replaced  (NOT NULL)
  * @new: profile to replace @old with  (NOT NULL)
- * @share_proxy: transfer @old->proxy to @new
  *
  * Will duplicate and refcount elements that @new inherits from @old
  * and will inherit @old children.
diff -- a/security/apparmor/secid.c b/security/apparmor/secid.c
--- a/security/apparmor/secid.c
+++ b/security/apparmor/secid.c
@@ -53,8 +53,7 @@ void aa_secid_update(u32 secid, struct a
 	xa_unlock_irqrestore(&aa_secids, flags);
 }
 
-/**
- *
+/*
  * see label for inverse aa_label_to_secid
  */
 struct aa_label *aa_secid_to_label(u32 secid)
diff -- a/security/apparmor/file.c b/security/apparmor/file.c
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -161,6 +161,7 @@ static int path_name(const char *op, str
 	return 0;
 }
 
+struct aa_perms default_perms = {};
 /**
  * aa_lookup_fperms - convert dfa compressed perms to internal perms
  * @dfa: dfa to lookup perms for   (NOT NULL)
@@ -171,7 +172,6 @@ static int path_name(const char *op, str
  *
  * Returns: a pointer to a file permission set
  */
-struct aa_perms default_perms = {};
 struct aa_perms *aa_lookup_fperms(struct aa_policydb *file_rules,
 				 aa_state_t state, struct path_cond *cond)
 {
