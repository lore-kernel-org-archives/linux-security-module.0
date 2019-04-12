Return-Path: <SRS0=JiNK=SO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A190C10F14
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Apr 2019 11:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1601D2083E
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Apr 2019 11:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDLLAc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:00:32 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59930 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfDLLAc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 12 Apr 2019 07:00:32 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3CB00T9021131;
        Fri, 12 Apr 2019 20:00:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Fri, 12 Apr 2019 20:00:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank060157095162.bbtec.net [60.157.95.162])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x3CAxsBQ021068
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 12 Apr 2019 20:00:00 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     linux-security-module@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 3/3] tomoyo: Check address length before reading address family
Date:   Fri, 12 Apr 2019 19:59:36 +0900
Message-Id: <1555066776-9758-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1555066776-9758-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
References: <1555066776-9758-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

KMSAN will complain if valid address length passed to bind()/connect()/
sendmsg() is shorter than sizeof("struct sockaddr"->sa_family) bytes.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/tomoyo/network.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/tomoyo/network.c b/security/tomoyo/network.c
index 9094f4b3b367..f9ff121d7e1e 100644
--- a/security/tomoyo/network.c
+++ b/security/tomoyo/network.c
@@ -505,6 +505,8 @@ static int tomoyo_check_inet_address(const struct sockaddr *addr,
 {
 	struct tomoyo_inet_addr_info *i = &address->inet;
 
+	if (addr_len < offsetofend(struct sockaddr, sa_family))
+		return 0;
 	switch (addr->sa_family) {
 	case AF_INET6:
 		if (addr_len < SIN6_LEN_RFC2133)
@@ -594,6 +596,8 @@ static int tomoyo_check_unix_address(struct sockaddr *addr,
 {
 	struct tomoyo_unix_addr_info *u = &address->unix0;
 
+	if (addr_len < offsetofend(struct sockaddr, sa_family))
+		return 0;
 	if (addr->sa_family != AF_UNIX)
 		return 0;
 	u->addr = ((struct sockaddr_un *) addr)->sun_path;
-- 
2.16.5

