Return-Path: <SRS0=ekpI=AH=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC71C433E7
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Jun 2020 22:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E12120B1F
	for <linux-security-module@archiver.kernel.org>; Fri, 26 Jun 2020 22:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="E0vgWKVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgFZWjs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:39:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37954 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgFZWjo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Jun 2020 18:39:44 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 17B9E20B4909;
        Fri, 26 Jun 2020 15:39:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 17B9E20B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1593211183;
        bh=OnoF3Cvq4ZBg8ldmzl4iVW8t9aRV7I4Rqnsmn7Rh0uU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E0vgWKVe7YVIbQjPwJuJUJttUHeG1McRiGzMYia4p4ev5d7vMEfMBJo3ZgCwKJnKe
         QKc7QOfSm8NoHnUuSqraBwhl/V30HGk6HAnJHB2HC6Tp72oHERJrrLL14fwaL5o/QO
         zUrHZthudTlom/GjtMo7CewxTtGXuOBHwOYnHIO0=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 10/11] ima: Use the common function to detect LSM conditionals in a rule
Date:   Fri, 26 Jun 2020 17:38:59 -0500
Message-Id: <20200626223900.253615-11-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Make broader use of ima_rule_contains_lsm_cond() to check if a given
rule contains an LSM conditional. This is a code cleanup and has no
user-facing change.

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---

* v2
  - No change

 security/integrity/ima/ima_policy.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 43d49ad958fb..5eb14b567a31 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -360,17 +360,10 @@ static bool ima_rule_contains_lsm_cond(struct ima_rule_entry *entry)
 static void ima_lsm_update_rules(void)
 {
 	struct ima_rule_entry *entry, *e;
-	int i, result, needs_update;
+	int result;
 
 	list_for_each_entry_safe(entry, e, &ima_policy_rules, list) {
-		needs_update = 0;
-		for (i = 0; i < MAX_LSM_RULES; i++) {
-			if (entry->lsm[i].args_p) {
-				needs_update = 1;
-				break;
-			}
-		}
-		if (!needs_update)
+		if (!ima_rule_contains_lsm_cond(entry))
 			continue;
 
 		result = ima_lsm_update_rule(entry);
-- 
2.25.1

