Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7877C433EF
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Sep 2021 17:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66CE61211
	for <linux-security-module@archiver.kernel.org>; Thu, 23 Sep 2021 17:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhIWRGk (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 23 Sep 2021 13:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbhIWRGj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 23 Sep 2021 13:06:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973E9C061574
        for <linux-security-module@vger.kernel.org>; Thu, 23 Sep 2021 10:05:07 -0700 (PDT)
Date:   Thu, 23 Sep 2021 19:05:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632416705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WCJoIC7W3UzoxxoBXvBipnb9QI36GbGCC8qwcvEAaBI=;
        b=PqJzVwLiZEirkUnp2VKhgf29w1YF+kBX1w5ODS6DoF0y4f4A/WQtRZWNMU09V1RhoEakD7
        WpxdXooNRZjd+XjU7R07cXapyl5Xs2fai+OnppVjqpLinWSivXxADjENiocQXA4BlmvTsA
        /iiKp+xip7B1UIHI8SByblHg2JsU6IYuNHjwJ2lG93/iPYNhowSajhlQ3jB0a/IaIjx6nX
        45G7yDinoG/N3t2M/H2vUDJ1c4XIfbiQZ3tbVDswMSqeGpgd5mckwgQEtbzo5XJ7St0+7P
        v0hx0yy2PWV6HlAoW+r0GEPs+61/mhQ3vB8mZnaFXxDcchi+c9Nvlv6GdLSWKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632416705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WCJoIC7W3UzoxxoBXvBipnb9QI36GbGCC8qwcvEAaBI=;
        b=EVoGPL7oi4V48lpoX0AIJnY9w6gnPU4uH2AxeKzdcrY6CK/FyWxx+5LhGEiw/j4Fsb92Oa
        ++tCewTvlkknRUDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH v2] smack: Guard smack_ipv6_lock definition within a
 SMACK_IPV6_PORT_LABELING block
Message-ID: <20210923170503.pvu6r3rj3z2idme2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The mutex smack_ipv6_lock is only used with the SMACK_IPV6_PORT_LABELING
block but its definition is outside of the block. This leads to a
defined-but-not-used warning on PREEMPT_RT.

Moving smack_ipv6_lock down to the block where it is used where it used
raises the question why is smk_ipv6_port_list read if nothing is added
to it.
Turns out, only smk_ipv6_port_check() is using it outside of an ifdef
SMACK_IPV6_PORT_LABELING block. However two of three caller invoke
smk_ipv6_port_check() from a ifdef block and only one is using
__is_defined() macro which requires the function and smk_ipv6_port_list
to be around.

Put the lock and list inside an ifdef SMACK_IPV6_PORT_LABELING block to
avoid the warning regarding unused mutex. Extend the ifdef-block to also
cover smk_ipv6_port_check(). Make smack_socket_connect() use ifdef
instead of __is_defined() to avoid complains about missing function.

Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2: Properly ident smk_ipv6_port_check() in that ifdef block.

 security/smack/smack_lsm.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -51,8 +51,10 @@
 #define SMK_RECEIVING	1
 #define SMK_SENDING	2
=20
+#ifdef SMACK_IPV6_PORT_LABELING
 static DEFINE_MUTEX(smack_ipv6_lock);
 static LIST_HEAD(smk_ipv6_port_list);
+#endif
 struct kmem_cache *smack_rule_cache;
 int smack_enabled __initdata;
=20
@@ -2603,7 +2605,6 @@ static void smk_ipv6_port_label(struct s
 	mutex_unlock(&smack_ipv6_lock);
 	return;
 }
-#endif
=20
 /**
  * smk_ipv6_port_check - check Smack port access
@@ -2666,6 +2667,7 @@ static int smk_ipv6_port_check(struct so
=20
 	return smk_ipv6_check(skp, object, address, act);
 }
+#endif
=20
 /**
  * smack_inode_setsecurity - set smack xattrs
@@ -2852,8 +2854,9 @@ static int smack_socket_connect(struct s
 			rc =3D smk_ipv6_check(ssp->smk_out, rsp, sip,
 					    SMK_CONNECTING);
 		}
-		if (__is_defined(SMACK_IPV6_PORT_LABELING))
-			rc =3D smk_ipv6_port_check(sock->sk, sip, SMK_CONNECTING);
+#ifdef SMACK_IPV6_PORT_LABELING
+		rc =3D smk_ipv6_port_check(sock->sk, sip, SMK_CONNECTING);
+#endif
=20
 		return rc;
 	}
