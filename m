Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13865C388F7
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Nov 2020 07:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE7620825
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Nov 2020 07:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgKMH1b (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 Nov 2020 02:27:31 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:47857 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726133AbgKMH1b (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Nov 2020 02:27:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UFAj9js_1605252447;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFAj9js_1605252447)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Nov 2020 15:27:27 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Smack: fix kernel-doc interface on functions
Date:   Fri, 13 Nov 2020 15:26:59 +0800
Message-Id: <1605252419-64251-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The are some kernel-doc interface issues:
security/smack/smackfs.c:1950: warning: Function parameter or member
'list' not described in 'smk_parse_label_list'
security/smack/smackfs.c:1950: warning: Excess function parameter
'private' description in 'smk_parse_label_list'
security/smack/smackfs.c:1979: warning: Function parameter or member
'list' not described in 'smk_destroy_label_list'
security/smack/smackfs.c:1979: warning: Excess function parameter 'head'
description in 'smk_destroy_label_list'
security/smack/smackfs.c:2141: warning: Function parameter or member
'count' not described in 'smk_read_logging'
security/smack/smackfs.c:2141: warning: Excess function parameter 'cn'
description in 'smk_read_logging'
security/smack/smackfs.c:2278: warning: Function parameter or member
'format' not described in 'smk_user_access'

Correct them in this patch.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 security/smack/smackfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index e567b4baf3a0..5d44b7d258ef 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -1942,7 +1942,7 @@ static void smk_list_swap_rcu(struct list_head *public,
  * smk_parse_label_list - parse list of Smack labels, separated by spaces
  *
  * @data: the string to parse
- * @private: destination list
+ * @list: destination list
  *
  * Returns zero on success or error code, as appropriate
  */
@@ -1973,7 +1973,7 @@ static int smk_parse_label_list(char *data, struct list_head *list)
 
 /**
  * smk_destroy_label_list - destroy a list of smack_known_list_elem
- * @head: header pointer of the list to destroy
+ * @list: header pointer of the list to destroy
  */
 void smk_destroy_label_list(struct list_head *list)
 {
@@ -2131,7 +2131,7 @@ static const struct file_operations smk_unconfined_ops = {
  * smk_read_logging - read() for /smack/logging
  * @filp: file pointer, not actually used
  * @buf: where to put the result
- * @cn: maximum to send along
+ * @count: maximum to send along
  * @ppos: where to start
  *
  * Returns number of bytes read or error code, as appropriate
@@ -2272,6 +2272,7 @@ static const struct file_operations smk_load_self_ops = {
  * @buf: data from user space
  * @count: bytes sent
  * @ppos: where to start - must be 0
+ * @format: /smack/load or /smack/load2 or /smack/change-rule format.
  */
 static ssize_t smk_user_access(struct file *file, const char __user *buf,
 				size_t count, loff_t *ppos, int format)
-- 
2.29.GIT

