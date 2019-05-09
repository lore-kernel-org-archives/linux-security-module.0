Return-Path: <SRS0=3Nce=TJ=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28687C04AB1
	for <linux-security-module@archiver.kernel.org>; Thu,  9 May 2019 12:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048A521479
	for <linux-security-module@archiver.kernel.org>; Thu,  9 May 2019 12:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfEIMhc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 9 May 2019 08:37:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbfEIMhc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 9 May 2019 08:37:32 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 52C99560F13FC958C03B;
        Thu,  9 May 2019 20:37:28 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Thu, 9 May 2019 20:37:18 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        <linux-security-module@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH next] security: smack: fix sap undeclared error in smack_socket_sendmsg
Date:   Thu, 9 May 2019 20:46:28 +0800
Message-ID: <20190509124628.189228-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

If CONFIG_IPV6 is disabled, there is build error, fix it.

security/smack/smack_lsm.c: In function ‘smack_socket_sendmsg’:
security/smack/smack_lsm.c:3698:7: error: ‘sap’ undeclared (first use in this function)
     sap->sin6_family != AF_INET6)

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 security/smack/smack_lsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index b5b333d72637..ff5b7dc6816f 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3693,6 +3693,7 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 			return -EINVAL;
 		rc = smack_netlabel_send(sock->sk, sip);
 		break;
+#if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
 		if (msg->msg_namelen < SIN6_LEN_RFC2133 ||
 		    sap->sin6_family != AF_INET6)
@@ -3707,6 +3708,7 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
 		rc = smk_ipv6_port_check(sock->sk, sap, SMK_SENDING);
 #endif
 		break;
+#endif
 	}
 	return rc;
 }
-- 
2.20.1

