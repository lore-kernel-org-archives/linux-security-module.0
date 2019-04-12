Return-Path: <SRS0=JiNK=SO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03118C10F13
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Apr 2019 00:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AD320818
	for <linux-security-module@archiver.kernel.org>; Fri, 12 Apr 2019 00:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfDLAYW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Apr 2019 20:24:22 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57595 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfDLAYW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Apr 2019 20:24:22 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3C0OAnL024639;
        Fri, 12 Apr 2019 09:24:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Fri, 12 Apr 2019 09:24:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x3C0OAA7024635;
        Fri, 12 Apr 2019 09:24:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x3C0OAAL024634;
        Fri, 12 Apr 2019 09:24:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201904120024.x3C0OAAL024634@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH] net: socket: Always initialize family field at
 =?ISO-2022-JP?B?bW92ZV9hZGRyX3RvX2tlcm5lbCgpLg==?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        syzbot+0049bebbf3042dbd2e8f@syzkaller.appspotmail.com,
        syzbot+915c9f99f3dbc4bd6cd1@syzkaller.appspotmail.com
MIME-Version: 1.0
Date:   Fri, 12 Apr 2019 09:24:10 +0900
References: <4d077355-03de-0b8a-b6fc-51757eafe7eb@i-love.sakura.ne.jp> <CAHC9VhQy=UheDzhpwn7S2SUq51UmZ0MrNM+JtNdkoAi5Juscpw@mail.gmail.com>
In-Reply-To: <CAHC9VhQy=UheDzhpwn7S2SUq51UmZ0MrNM+JtNdkoAi5Juscpw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Paul Moore wrote:
> > +       /*
> > +        * Nothing more to do if valid length is too short to check
> > +        * address->sa_family.
> > +        */
> > +       if (addrlen < offsetofend(struct sockaddr, sa_family))
> > +               goto out;
> 
> SELinux already checks the address length further down in
> selinux_socket_bind() for the address families it care about, although
> it does read sa_family before the address length check so no
> unfortunately it's of no help.

Exactly.

Since we will anyway have to check valid length after sa_family is checked,
reading a stale sa_family is harmless except KMSAN complains uninit-value.
Therefore,

--- a/net/socket.c
+++ b/net/socket.c
@@ -181,6 +181,7 @@ static ssize_t sock_splice_read(struct file *file, loff_t *ppos,
 
 int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr)
 {
+	kaddr->ss_family = 0;
 	if (ulen < 0 || ulen > sizeof(struct sockaddr_storage))
 		return -EINVAL;
 	if (ulen == 0)

or

--- a/net/socket.c
+++ b/net/socket.c
@@ -181,6 +181,7 @@ static ssize_t sock_splice_read(struct file *file, loff_t *ppos,
 
 int move_addr_to_kernel(void __user *uaddr, int ulen, struct sockaddr_storage *kaddr)
 {
+	memset(kaddr, 0, sizeof(struct sockaddr_storage));
 	if (ulen < 0 || ulen > sizeof(struct sockaddr_storage))
 		return -EINVAL;
 	if (ulen == 0)

will avoid adding this "addrlen < offsetofend(struct sockaddr, sa_family)" check to every
LSM module. It is a bit pity that while it is guaranteed that sizeof(struct sockaddr_storage)
bytes are accessible, it is not guaranteed that reading "struct sockaddr_storage"->family is
safe. (Thus, I wanted to hear comments from LSM people.)

> 
> I imagine you could move this new length check inside the
> PF_INET/PF_INET6 if-then code block to minimize the impact to other
> address families, but I suppose there is some value in keeping it
> where it is too.

I guess that since PF_INET/PF_INET6/PF_UNIX will be most frequently used protocols,
the impact to non-PF_INET/PF_INET6 protocols is negligible.
