Return-Path: <SRS0=CLHo=AE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67709C433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jun 2020 00:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EE020720
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jun 2020 00:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bSxy2P2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbgFWAe1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:34:27 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47558 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732017AbgFWAe0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Jun 2020 20:34:26 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id F378420B4780;
        Mon, 22 Jun 2020 17:34:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F378420B4780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592872465;
        bh=4WeD0C27mVX0onraF5izAXrMPG9y5qT1kwgv9gWu4gA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSxy2P2YWMR35RPL5XjOzKnQdFN0xghqqr00ABvR6u2xQxytt5BDMXy1jt3vhUxjr
         YbsdCtO/CeyQ+cR6K2n8wHLqLYyD3alGMF6tuSFET5QTzo0K/rjxWfBK404z54j5C7
         wEQyuORzDE7/t24/56f64c/KVUCGopMjFRGpaMLw=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 09/12] ima: Use correct type for the args_p member of ima_rule_entry.lsm elements
Date:   Mon, 22 Jun 2020 19:32:33 -0500
Message-Id: <20200623003236.830149-10-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
References: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Make args_p be of the char pointer type rather than have it be a void
pointer that gets casted to char pointer when it is used. It is a simple
NUL-terminated string as returned by match_strdup().

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 security/integrity/ima/ima_policy.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e9c7d318fdd4..514baf24d6a5 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -74,7 +74,7 @@ struct ima_rule_entry {
 	int pcr;
 	struct {
 		void *rule;	/* LSM file metadata specific */
-		void *args_p;	/* audit value */
+		char *args_p;	/* audit value */
 		int type;	/* audit type */
 	} lsm[MAX_LSM_RULES];
 	char *fsname;
@@ -315,7 +315,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 					  &nentry->lsm[i].rule);
 		if (!nentry->lsm[i].rule)
 			pr_warn("rule for LSM \'%s\' is undefined\n",
-				(char *)entry->lsm[i].args_p);
+				entry->lsm[i].args_p);
 	}
 
 	/* Disown all references that were shallow copied */
@@ -917,7 +917,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 					   &entry->lsm[lsm_rule].rule);
 	if (!entry->lsm[lsm_rule].rule) {
 		pr_warn("rule for LSM \'%s\' is undefined\n",
-			(char *)entry->lsm[lsm_rule].args_p);
+			entry->lsm[lsm_rule].args_p);
 
 		if (ima_rules == &ima_default_rules) {
 			kfree(entry->lsm[lsm_rule].args_p);
@@ -1666,27 +1666,27 @@ int ima_policy_show(struct seq_file *m, void *v)
 			switch (i) {
 			case LSM_OBJ_USER:
 				seq_printf(m, pt(Opt_obj_user),
-					   (char *)entry->lsm[i].args_p);
+					   entry->lsm[i].args_p);
 				break;
 			case LSM_OBJ_ROLE:
 				seq_printf(m, pt(Opt_obj_role),
-					   (char *)entry->lsm[i].args_p);
+					   entry->lsm[i].args_p);
 				break;
 			case LSM_OBJ_TYPE:
 				seq_printf(m, pt(Opt_obj_type),
-					   (char *)entry->lsm[i].args_p);
+					   entry->lsm[i].args_p);
 				break;
 			case LSM_SUBJ_USER:
 				seq_printf(m, pt(Opt_subj_user),
-					   (char *)entry->lsm[i].args_p);
+					   entry->lsm[i].args_p);
 				break;
 			case LSM_SUBJ_ROLE:
 				seq_printf(m, pt(Opt_subj_role),
-					   (char *)entry->lsm[i].args_p);
+					   entry->lsm[i].args_p);
 				break;
 			case LSM_SUBJ_TYPE:
 				seq_printf(m, pt(Opt_subj_type),
-					   (char *)entry->lsm[i].args_p);
+					   entry->lsm[i].args_p);
 				break;
 			}
 			seq_puts(m, " ");
-- 
2.25.1

