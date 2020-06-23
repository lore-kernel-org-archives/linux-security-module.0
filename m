Return-Path: <SRS0=CLHo=AE=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161FEC433E1
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jun 2020 00:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBFD32053B
	for <linux-security-module@archiver.kernel.org>; Tue, 23 Jun 2020 00:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TgA5A8Or"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbgFWAeQ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:34:16 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47422 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731880AbgFWAeP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Jun 2020 20:34:15 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 96F8720B4780;
        Mon, 22 Jun 2020 17:34:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 96F8720B4780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1592872454;
        bh=9cmMbZau7IgzULzhkpeDyhdyU1mGv+gQ1LJ4wn9BOVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TgA5A8OrkQkazaYPBI6zwB3ntGPk/A1fkpi546LNQ6XZCW+LjzQAA2x4GP1VE6ilv
         GGKbdt5NZnz+MbkoMhqm8hPGa8gszq6aDJtWftGzk8aMjrOk3+5CnjdXHH+FaSDJmF
         q5WpDTtpH/wlH0ncHjToe6uE6zjVJF7CESrlvg88=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 03/12] ima: Free the entire rule when deleting a list of rules
Date:   Mon, 22 Jun 2020 19:32:27 -0500
Message-Id: <20200623003236.830149-4-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
References: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Use ima_free_rule() to fix memory leaks of allocated ima_rule_entry
members, such as .fsname and .keyrings, when deleting a list of rules.

This fixes a memory leak seen when loading by a valid rule that contains
an additional piece of allocated memory, such as an fsname, followed by
an invalid rule that triggers a policy load failure:

 # echo -e "dont_measure fsname=securityfs\nbad syntax" > \
    /sys/kernel/security/ima/policy
 -bash: echo: write error: Invalid argument
 # echo scan > /sys/kernel/debug/kmemleak
 # cat /sys/kernel/debug/kmemleak
 unreferenced object 0xffff9bab67ca12c0 (size 16):
   comm "tee", pid 684, jiffies 4295212803 (age 252.344s)
   hex dump (first 16 bytes):
     73 65 63 75 72 69 74 79 66 73 00 6b 6b 6b 6b a5  securityfs.kkkk.
   backtrace:
     [<00000000adc80b1b>] kstrdup+0x2e/0x60
     [<00000000d504cb0d>] ima_parse_add_rule+0x7d4/0x1020
     [<00000000444825ac>] ima_write_policy+0xab/0x1d0
     [<000000002b7f0d6c>] vfs_write+0xde/0x1d0
     [<0000000096feedcf>] ksys_write+0x68/0xe0
     [<0000000052b544a2>] do_syscall_64+0x56/0xa0
     [<000000007ead1ba7>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: f1b08bbcbdaf ("ima: define a new policy condition based on the filesystem name")
Fixes: 2b60c0ecedf8 ("IMA: Read keyrings= option from the IMA policy")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 security/integrity/ima/ima_policy.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 1320333201c6..94ca3b8abb69 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1431,15 +1431,11 @@ ssize_t ima_parse_add_rule(char *rule)
 void ima_delete_rules(void)
 {
 	struct ima_rule_entry *entry, *tmp;
-	int i;
 
 	temp_ima_appraise = 0;
 	list_for_each_entry_safe(entry, tmp, &ima_temp_rules, list) {
-		for (i = 0; i < MAX_LSM_RULES; i++)
-			kfree(entry->lsm[i].args_p);
-
 		list_del(&entry->list);
-		kfree(entry);
+		ima_free_rule(entry);
 	}
 }
 
-- 
2.25.1

