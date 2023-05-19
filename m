Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757B4C77B75
	for <linux-security-module@archiver.kernel.org>; Fri, 19 May 2023 21:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjESVwn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 19 May 2023 17:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjESVwa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 May 2023 17:52:30 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9C31701
        for <linux-security-module@vger.kernel.org>; Fri, 19 May 2023 14:52:11 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5648e904593so9617317b3.3
        for <linux-security-module@vger.kernel.org>; Fri, 19 May 2023 14:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684533130; x=1687125130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ezXSeNe7/yIUHA40nQ1HzfdzkERT0quxzTGuCdKKnYc=;
        b=I61PPPq4ulT4nc6hqI7x5CMT0VuokZIcep7PHOMPcQ/p96Y/m27mzAbcpNodlOSpzw
         ezyd5jIzljQqMHJI2rXN3focGzbFt30gPTtrOglo3bFmaPY8DpAuAGXR6p2sYGSFkOfx
         OX4Pd8tkaAIrIUJ6xe5lwICzYuQUEI70OUshd82BgEI3hN79GFnF3+UBu/idgi/e7EEX
         kAg+tg2APxx/r7lDuR4er0c5yNejZZXeT+WfePwnf9pY9EP4MLYKyHj7Y2nSjRnOBfzu
         0Qq79Vk3cqdVCtm67Rjak3J7/WcWhVpOWZ0QXsmMz+D74teIM8C/VaPMgZnYFxq8u+IR
         UR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684533130; x=1687125130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezXSeNe7/yIUHA40nQ1HzfdzkERT0quxzTGuCdKKnYc=;
        b=blk4kk8ZBoABfnc/JvHGwVB1NSBjdjW2WwmkpziD07pJmDYAGScdj3smYpa0HUudXM
         DfRKlMNOYGp5jTQxyXEt85Hq4U/A6o9HypM+YlcnyPNpZ1w/JW8Q/DCACrrBem0ttLR6
         Iww+yjbLwJaaS5SO1b7NJ00pH5c6WrOhwoAfHmO31pHiRML6tX0/m2Cz2aJRfdU2ybPd
         9c/YNsCE7WBSSvpQkZk4DYSfOViph5SX8CJdsFZhuRnpsDImRLwOX9GZt4KSsQAqLfGJ
         FLF3bvYraymLmpwcZuKutHnA3iSK+SzZ4XSY2uyv7dmVF88aRnPwS/3UIYtlO2ciJ7gL
         8UGg==
X-Gm-Message-State: AC+VfDw4RJxjLdUNxIso0Tskq0YWQACCOBZ8Wk4JdxFfN2bqN4qcIOaV
        L132vH+oYleSshGztWUGA3NpdyVx4InqHtsJdhSu
X-Google-Smtp-Source: ACHHUZ7ni7yIXIClyu8KfLfSeYBwQD3QR1eReHQhnABUYS5cFfAkBOyTz77fNzOHEUdH2HkvTRuarKn1+mqHV7TGUbo=
X-Received: by 2002:a81:4854:0:b0:561:9092:d60a with SMTP id
 v81-20020a814854000000b005619092d60amr3629979ywa.42.1684533130035; Fri, 19
 May 2023 14:52:10 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 May 2023 17:51:59 -0400
Message-ID: <CAHC9VhRPvkdk6t1zkx+Y-QVP_vJRSxp+wuOO0YjyppNDLTNg7g@mail.gmail.com>
Subject: Stable backport of de3004c874e7 ("ocfs2: Switch to security_inode_init_security()")
To:     stable@vger.kernel.org
Cc:     Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,

I would like to request the backport of the commit below to address a
kernel panic in ocfs2 that was identified by Valentin Vidi=C4=87 in this
thread:

https://lore.kernel.org/linux-security-module/20230401214151.1243189-1-vvid=
ic@valentin-vidic.from.hr

While Valentin provides his own patch in the original message, the
preferred patch is one that went up to Linus during the last merge
window; Valentin has tested the patch and confirmed that it resolved
the reported problem.

  commit de3004c874e740304cc4f4a83d6200acb511bbda
  Author: Roberto Sassu <roberto.sassu@huawei.com>
  Date:   Tue Mar 14 09:17:16 2023 +0100

   ocfs2: Switch to security_inode_init_security()

   In preparation for removing security_old_inode_init_security(), switch t=
o
   security_inode_init_security().

   Extend the existing ocfs2_initxattrs() to take the
   ocfs2_security_xattr_info structure from fs_info, and populate the
   name/value/len triple with the first xattr provided by LSMs.

   As fs_info was not used before, ocfs2_initxattrs() can now handle the ca=
se
   of replicating the behavior of security_old_inode_init_security(), i.e.
   just obtaining the xattr, in addition to setting all xattrs provided by
   LSMs.

   Supporting multiple xattrs is not currently supported where
   security_old_inode_init_security() was called (mknod, symlink), as it
   requires non-trivial changes that can be done at a later time. Like for
   reiserfs, even if EVM is invoked, it will not provide an xattr (if it is
   not the first to set it, its xattr will be discarded; if it is the first=
,
   it does not have xattrs to calculate the HMAC on).

   Finally, since security_inode_init_security(), unlike
   security_old_inode_init_security(), returns zero instead of -EOPNOTSUPP =
if
   no xattrs were provided by LSMs or if inodes are private, additionally
   check in ocfs2_init_security_get() if the xattr name is set.

   If not, act as if security_old_inode_init_security() returned -EOPNOTSUP=
P,
   and set si->enable to zero to notify to the functions following
   ocfs2_init_security_get() that no xattrs are available.

   Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
   Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
   Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
   Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
   Signed-off-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
