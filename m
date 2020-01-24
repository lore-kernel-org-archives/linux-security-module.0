Return-Path: <SRS0=wJOd=3N=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9471BC2D0CE
	for <linux-security-module@archiver.kernel.org>; Fri, 24 Jan 2020 06:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDE52072C
	for <linux-security-module@archiver.kernel.org>; Fri, 24 Jan 2020 06:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgAXGZs (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 24 Jan 2020 01:25:48 -0500
Received: from relay.sw.ru ([185.231.240.75]:52000 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgAXGZs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 24 Jan 2020 01:25:48 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1iusP7-0007u1-9B; Fri, 24 Jan 2020 09:25:17 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH 1/1] proc_keys_next should increase position index
To:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Message-ID: <af9dcaa7-6e4f-281a-2bae-fb605cc55d2d@virtuozzo.com>
Date:   Fri, 24 Jan 2020 09:25:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 security/keys/proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/keys/proc.c b/security/keys/proc.c
index 415f3f1..d0cde66 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -139,6 +139,8 @@ static void *proc_keys_next(struct seq_file *p, void *v, loff_t *_pos)
 	n = key_serial_next(p, v);
 	if (n)
 		*_pos = key_node_serial(n);
+	else
+		(*_pos)++;
 	return n;
 }
 
-- 
1.8.3.1

