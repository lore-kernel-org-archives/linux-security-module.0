Return-Path: <SRS0=CLHo=AE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A462BC433DF
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jun 2020 00:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8655E2053B
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jun 2020 00:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FPiNWHnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732077AbgFWAe7 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:34:59 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47448 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731889AbgFWAeQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Jun 2020 20:34:16 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0B61B20B4781;
        Mon, 22 Jun 2020 17:34:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0B61B20B4781
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592872455;
        bh=tPM2cLdleiXTdhTcx3SJbwPTbqR3C7p+Rm6GApOkV+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FPiNWHnk28C2EkEMbDX9KqsktQr53PywyM67fEEx9JgBdcaTX8KRLOPzjOPcJ1iFv
         pw/EA03DivehJgoaKkKBepalnBbg02L5fJ/duZScba+5aJB8KRfJ7G5qXs6KCq5szL
         JpPT8UiDfTI5BLJgyOS83vUbKG7MSukUiZ4TAUTQ=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 04/12] ima: Free the entire rule if it fails to parse
Date:   Mon, 22 Jun 2020 19:32:28 -0500
Message-Id: <20200623003236.830149-5-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
References: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Use ima_free_rule() to fix memory leaks of allocated ima_rule_entry
members, such as .fsname and .keyrings, when an error is encountered
during rule parsing.

Set the args_p pointer to NULL after freeing it in the error path of
ima_lsm_rule_init() so that it isn't freed twice.

This fixes a memory leak seen when loading an rule that contains an
additional piece of allocated memory, such as an fsname, followed by an
invalid conditional:

 # echo "measure fsname=tmpfs bad=cond" > /sys/kernel/security/ima/policy
 -bash: echo: write error: Invalid argument
 # echo scan > /sys/kernel/debug/kmemleak
 # cat /sys/kernel/debug/kmemleak
 unreferenced object 0xffff98e7e4ece6c0 (size 8):
   comm "bash", pid 672, jiffies 4294791843 (age 21.855s)
   hex dump (first 8 bytes):
     74 6d 70 66 73 00 6b a5                          tmpfs.k.
   backtrace:
     [<00000000abab7413>] kstrdup+0x2e/0x60
     [<00000000f11ede32>] ima_parse_add_rule+0x7d4/0x1020
     [<00000000f883dd7a>] ima_write_policy+0xab/0x1d0
     [<00000000b17cf753>] vfs_write+0xde/0x1d0
     [<00000000b8ddfdea>] ksys_write+0x68/0xe0
     [<00000000b8e21e87>] do_syscall_64+0x56/0xa0
     [<0000000089ea7b98>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: f1b08bbcbdaf ("ima: define a new policy condition based on the filesystem name")
Fixes: 2b60c0ecedf8 ("IMA: Read keyrings= option from the IMA policy")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 security/integrity/ima/ima_policy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 94ca3b8abb69..ee5152ecd3d9 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -919,6 +919,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 
 		if (ima_rules == &ima_default_rules) {
 			kfree(entry->lsm[lsm_rule].args_p);
+			entry->lsm[lsm_rule].args_p = NULL;
 			result = -EINVAL;
 		} else
 			result = 0;
@@ -1410,7 +1411,7 @@ ssize_t ima_parse_add_rule(char *rule)
 
 	result = ima_parse_rule(p, entry);
 	if (result) {
-		kfree(entry);
+		ima_free_rule(entry);
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL,
 				    NULL, op, "invalid-policy", result,
 				    audit_info);
-- 
2.25.1

