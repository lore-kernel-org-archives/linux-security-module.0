Return-Path: <SRS0=TKeG=AU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CB4C433E0
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Jul 2020 06:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D2820708
	for <linux-security-module@archiver.kernel.org>; Thu,  9 Jul 2020 06:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="g7f7y5H5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgGIGUg (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 Jul 2020 02:20:36 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38096 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgGIGUM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 Jul 2020 02:20:12 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id ED52220B4909;
        Wed,  8 Jul 2020 23:20:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED52220B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594275611;
        bh=kdGo+g0Ug/+ndalVCdzuX/XIssnW7sZa5n/LdXUX1OM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g7f7y5H5XpYSW/JqRJeaI3n/zw1XVmSYLKBZA3ZBwjh3RAvvCTvC6hDloRL5oNLGT
         1ZTeusQjwRyMyX8hLF/RbnyRh9kx0ArCJoWQVWs8CB3V3xt6qevpWkxEMjlG2rTIiD
         MerMF1DJfyii9F7c6vAGHXSWuZtO3sf2EjsznJx8=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 08/12] ima: Shallow copy the args_p member of ima_rule_entry.lsm elements
Date:   Thu,  9 Jul 2020 01:19:07 -0500
Message-Id: <20200709061911.954326-9-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The args_p member is a simple string that is allocated by
ima_rule_init(). Shallow copy it like other non-LSM references in
ima_rule_entry structs.

There are no longer any necessary error path cleanups to do in
ima_lsm_copy_rule().

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---

* v3
  - No change
* v2
  - Adjusted context to account for ima_lsm_copy_rule() directly calling
    ima_lsm_free_rule() and the lack of explicit reference ownership
    transfers
  - Added comment to ima_lsm_copy_rule() to document the args_p
    reference ownership transfer

 security/integrity/ima/ima_policy.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 9842e2e0bc6d..b02e1ffd10c9 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -300,10 +300,13 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 			continue;
 
 		nentry->lsm[i].type = entry->lsm[i].type;
-		nentry->lsm[i].args_p = kstrdup(entry->lsm[i].args_p,
-						GFP_KERNEL);
-		if (!nentry->lsm[i].args_p)
-			goto out_err;
+		nentry->lsm[i].args_p = entry->lsm[i].args_p;
+		/*
+		 * Remove the reference from entry so that the associated
+		 * memory will not be freed during a later call to
+		 * ima_lsm_free_rule(entry).
+		 */
+		entry->lsm[i].args_p = NULL;
 
 		security_filter_rule_init(nentry->lsm[i].type,
 					  Audit_equal,
@@ -314,11 +317,6 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 				(char *)entry->lsm[i].args_p);
 	}
 	return nentry;
-
-out_err:
-	ima_lsm_free_rule(nentry);
-	kfree(nentry);
-	return NULL;
 }
 
 static int ima_lsm_update_rule(struct ima_rule_entry *entry)
-- 
2.25.1

