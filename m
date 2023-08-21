Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECDBEE49A0
	for <linux-security-module@archiver.kernel.org>; Mon, 21 Aug 2023 21:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjHUVVA (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 21 Aug 2023 17:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHUVU7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Aug 2023 17:20:59 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76280D9
        for <linux-security-module@vger.kernel.org>; Mon, 21 Aug 2023 14:20:58 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1c4c7a83bcdso2330264fac.0
        for <linux-security-module@vger.kernel.org>; Mon, 21 Aug 2023 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692652857; x=1693257657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kXQLL/tQqoFblrCpS21gCxhSOHNRrMyl0EvcluCINWs=;
        b=adBtwsEygc8n+sFCZPCfYzUiaCLpHcu5M+MSJEvXt7Z3kfAE4oK8VkP5IPaquOv/EU
         FkiDiOF6JunX4jNCYVfGXHzGYRt66mhgG64QNZRrcyQL4crVZ32IaEVhxM0QqULG0jpp
         BPOpjrnoCUBOm+ZHWY6NyEnFWRKNIJhxqkn6NpeQ4oBWbpi+bseC6zhW7LyjIF0+87E2
         Ujvf3ucibhfd+nMd8HZRu5QiIjJ6IsEcnl5HiSXOYZfUj3KoUVs4NLE1voALRSFe+sTb
         pdxKSJQzkdwfz8DZivoEcy3FpIMil1z8isVWeeMg5TTKAKIo1BJNvF6AeMSj+eOgfaVO
         wQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692652857; x=1693257657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXQLL/tQqoFblrCpS21gCxhSOHNRrMyl0EvcluCINWs=;
        b=Z1ESufbt8kBb+SNeLLq7firPMQkoZ8Gmk/b+IcRjGFgM82LBZCcMyi77Ox+J5ssRK9
         U9re1T+7y8RuwoMgCOY9qi3RBk09EvYq5NmD42fCUdFEmqhnYDqdCx8Bdld4nVbM1xXR
         qHGIpf9Pfr0XsNhJMnokl9iXB8Lqh7lvxXgnPeZN3F7IK25nGfQ9frmz2944yelgN9SW
         Fny8fn1cJQDReS4XJp9DbK4dV0eNORT/Xo128CY88aYVWSNCEqHaqmoaROecx7HVLTiD
         Znhp3uu7NIsmkbo+6Ad5vib5ESopAb8LSwKfhp2o89ZEkjB6+sLVuobKP/NYhzxXn016
         LbnQ==
X-Gm-Message-State: AOJu0YxJIEmXoEC/2QR20kpyTWC68WDhn6QVPivF7DcTrpevTmMV89Hn
        M+fz7KNWOV4e0QMZLyaNKIy9bBYQa45eY8kRFmqmguvUgYwzW+FY6w2Z
X-Google-Smtp-Source: AGHT+IF0JsWcEVdMlYbfQjVn6UDxH5Q06yGBJF74FyYf/4BoJA/N0KJG4X0r8FBPfUJOAbsOtcnK4WJaCK02MNj8hIM=
X-Received: by 2002:a05:6870:702a:b0:1bb:3f64:bb89 with SMTP id
 u42-20020a056870702a00b001bb3f64bb89mr9540871oae.24.1692652857675; Mon, 21
 Aug 2023 14:20:57 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 21 Aug 2023 17:20:47 -0400
Message-ID: <CAHC9VhTEeicj__ys3duEhmv4WuLgZupWanr_bXwObRCz_jxatw@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v6.5 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Linus,

A small SELinux patch to fix a potential problem when cleaning up on a
failed SELinux policy load (list next pointer not being properly
initialized to NULL early enough).  Please merge for the v6.5 release.

Thanks,
-Paul
--
The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5=
:

 Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

 https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20230821

for you to fetch changes up to 70d91dc9b2ac91327d0eefd86163abc3548effa6:

 selinux: set next pointer before attaching to list
   (2023-08-18 16:13:03 -0400)

----------------------------------------------------------------
selinux/stable-6.5 PR 20230821

----------------------------------------------------------------
Christian G=C3=B6ttsche (1):
     selinux: set next pointer before attaching to list

security/selinux/ss/policydb.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

--=20
paul-moore.com
