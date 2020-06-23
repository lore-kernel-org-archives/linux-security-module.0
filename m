Return-Path: <SRS0=CLHo=AE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6A6C433E1
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jun 2020 00:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2806220809
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jun 2020 00:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nzgJGY7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbgFWAeO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:34:14 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47402 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731810AbgFWAeM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Jun 2020 20:34:12 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2781D20B4781;
        Mon, 22 Jun 2020 17:34:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2781D20B4781
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592872451;
        bh=HChxERWUuKwjZ6R4JVcz82wzO1+OLldut5JYoeoGT9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nzgJGY7Uf9mbUguoerps5DSxzKd5vMC5C9cSL7iFFECcIwyYO4d6+qI3xOHZmjRUP
         KZlR4//r3cfGsh+TM1NQ06cAwc1otxTTHB79mKO1Bvcn6VKMSavjFb3z6w89l7RcRF
         qNL8WGZPbdjJjLtgTblm5ZPzV6n4U7daB0s1PLQQ=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 02/12] ima: Create a function to free a rule entry
Date:   Mon, 22 Jun 2020 19:32:26 -0500
Message-Id: <20200623003236.830149-3-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
References: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

There are several possible pieces of allocated memory in a rule entry.
Create a function that can free all allocated memory for a given rule
entry.

This patch introduces no functional changes but sets the groundwork for
some memory leak fixes.

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 security/integrity/ima/ima_policy.c | 33 +++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 236a731492d1..1320333201c6 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -261,6 +261,27 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
 		security_filter_rule_free(entry->lsm[i].rule);
 		kfree(entry->lsm[i].args_p);
 	}
+}
+
+static void ima_free_rule(struct ima_rule_entry *entry)
+{
+	if (!entry)
+		return;
+
+	/*
+	 * entry->template->fields may be allocated in ima_parse_rule() but that
+	 * reference is owned by the corresponding ima_template_desc element in
+	 * the defined_templates list and cannot be freed here
+	 */
+
+	/*
+	 * When freeing newly added ima_rule_entry members, consider if you
+	 * need to disown any references after the shallow copy in
+	 * ima_lsm_copy_rule()
+	 */
+	kfree(entry->fsname);
+	kfree(entry->keyrings);
+	ima_lsm_free_rule(entry);
 	kfree(entry);
 }
 
@@ -298,10 +319,18 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 			pr_warn("rule for LSM \'%s\' is undefined\n",
 				(char *)entry->lsm[i].args_p);
 	}
+
+	/* Disown all references that were shallow copied */
+	entry->fsname = NULL;
+	entry->keyrings = NULL;
+	entry->template = NULL;
 	return nentry;
 
 out_err:
-	ima_lsm_free_rule(nentry);
+	nentry->fsname = NULL;
+	nentry->keyrings = NULL;
+	nentry->template = NULL;
+	ima_free_rule(nentry);
 	return NULL;
 }
 
@@ -315,7 +344,7 @@ static int ima_lsm_update_rule(struct ima_rule_entry *entry)
 
 	list_replace_rcu(&entry->list, &nentry->list);
 	synchronize_rcu();
-	ima_lsm_free_rule(entry);
+	ima_free_rule(entry);
 
 	return 0;
 }
-- 
2.25.1

