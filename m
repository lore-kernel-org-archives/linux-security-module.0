Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76917C7EE25
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Jun 2023 13:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbjFHN6l (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 8 Jun 2023 09:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbjFHN6j (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Jun 2023 09:58:39 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CD62736;
        Thu,  8 Jun 2023 06:58:38 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 0D0EA186917A;
        Thu,  8 Jun 2023 16:58:35 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wPWuzr6m1Cyn; Thu,  8 Jun 2023 16:58:34 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id B2C4318684B8;
        Thu,  8 Jun 2023 16:58:34 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1GAq5gwtRosd; Thu,  8 Jun 2023 16:58:34 +0300 (MSK)
Received: from localhost.localdomain (unknown [192.168.32.67])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 46CE81866D57;
        Thu,  8 Jun 2023 16:58:34 +0300 (MSK)
From:   Dmitry Mastykin <dmastykin@astralinux.ru>
To:     paul@paul-moore.com, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Dmitry Mastykin <dmastykin@astralinux.ru>
Subject: [PATCH] netlabel: fix shift wrapping bug in netlbl_catmap_setlong()
Date:   Thu,  8 Jun 2023 16:57:54 +0300
Message-Id: <20230608135754.25044-1-dmastykin@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

There is a shift wrapping bug in this code on 32-bit architectures.
NETLBL_CATMAP_MAPTYPE is u64, bitmap is unsigned long.
Every second 32-bit word of catmap becomes corrupted.

Signed-off-by: Dmitry Mastykin <dmastykin@astralinux.ru>
---
 net/netlabel/netlabel_kapi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netlabel/netlabel_kapi.c b/net/netlabel/netlabel_kapi.c
index 54c083003947..27511c90a26f 100644
--- a/net/netlabel/netlabel_kapi.c
+++ b/net/netlabel/netlabel_kapi.c
@@ -857,7 +857,8 @@ int netlbl_catmap_setlong(struct netlbl_lsm_catmap **=
catmap,
=20
 	offset -=3D iter->startbit;
 	idx =3D offset / NETLBL_CATMAP_MAPSIZE;
-	iter->bitmap[idx] |=3D bitmap << (offset % NETLBL_CATMAP_MAPSIZE);
+	iter->bitmap[idx] |=3D (NETLBL_CATMAP_MAPTYPE)bitmap
+			     << (offset % NETLBL_CATMAP_MAPSIZE);
=20
 	return 0;
 }
--=20
2.30.2

