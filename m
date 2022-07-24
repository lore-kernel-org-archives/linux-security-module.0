Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487F5C433EF
	for <linux-security-module@archiver.kernel.org>; Sun, 24 Jul 2022 04:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiGXED1 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sun, 24 Jul 2022 00:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiGXEDZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 24 Jul 2022 00:03:25 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2301E11448;
        Sat, 23 Jul 2022 21:03:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658635380; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=DhRurrNjLT/jQinVOHTAyXsUJ7ZU8B/aR5hHDGwSQxE1atVfIxwiP0i+/z5KJyHzh3qROgquK81vwvs9Af+nbI+va5hmlRfttAwEehgwHS/v31tN8DN44wYKkoJpyx1IiF9AXmGVokPH0lNAe1VfIlFjIXzuz8AJMdP8Ijb642g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1658635380; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=TMFu4Xh2KHJwOUP3iMlwZuM/07pSct/fqhxURPId8fc=; 
        b=ONpmwPnUmJOAPFI/U2ChDZS04c452xrBAK4YbW7WCfrO8CttpCa6dDpCaIvRJRCl0Ejvz/7Pjl3srhWrq6K6TZBev1U1PZy/tMeLcOQpqJjO7KzUjhaG14YNDkusYzHIxPNv/IMZlyrl6dP2mRuNN/onTweEX2lqMB1d9GudDE8=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658635380;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=TMFu4Xh2KHJwOUP3iMlwZuM/07pSct/fqhxURPId8fc=;
        b=bxpYFGMyphYOJFFsmVcBBjJnT5AjoSTfZgk3A3gRfmBYS9QQffMMYjDP948l+p9x
        AdMD4wJH2VNpH+mT/TafXHNCYOoA/BiOnczy9wphvM+04UBQ9KNQoS61APf4OviMyom
        3Axl6X7OUZXqJYXEvOlsSVYsINg+aSJo1wr+U8wU=
Received: from localhost.localdomain (43.250.158.127 [43.250.158.127]) by mx.zoho.in
        with SMTPS id 1658635379700905.0525639502093; Sun, 24 Jul 2022 09:32:59 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     David Howells <dhowells@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     linux-security-modules <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com
Message-ID: <20220724040240.7842-1-code@siddh.me>
Subject: [PATCH v2] kernel/watch_queue: Make pipe NULL while clearing watch_queue
Date:   Sun, 24 Jul 2022 09:32:40 +0530
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

If not done, a reference to a freed pipe remains in the watch_queue,
as this function is called before freeing a pipe in free_pipe_info()
(see line 834 of fs/pipe.c).

This causes a UAF when post_one_notification tries to access the pipe on
a key update, which is reported by syzbot.

Bug report: https://syzkaller.appspot.com/bug?id=3D1870dd7791ba05f2ea7f47f7=
cbdde701173973fc
Reported-and-tested-by: syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.c=
om

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
Changes since v1:
- Removed the superfluous ifdef guard.

 kernel/watch_queue.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index bb9962b33f95..0357e5c6cf18 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -637,8 +637,15 @@ void watch_queue_clear(struct watch_queue *wqueue)
 =09=09spin_lock_bh(&wqueue->lock);
 =09}
=20
-=09spin_unlock_bh(&wqueue->lock);
 =09rcu_read_unlock();
+
+=09/* Clearing the watch queue, so we should clean the associated pipe. */
+=09if (wqueue->pipe) {
+=09=09wqueue->pipe->watch_queue =3D NULL;
+=09=09wqueue->pipe =3D NULL;
+=09}
+
+=09spin_unlock_bh(&wqueue->lock);
 }
=20
 /**
--=20
2.35.1


