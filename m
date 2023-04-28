Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CA2C77B7E
	for <linux-security-module@archiver.kernel.org>; Fri, 28 Apr 2023 16:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjD1QGE (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 28 Apr 2023 12:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjD1QGC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 28 Apr 2023 12:06:02 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D152D51
        for <linux-security-module@vger.kernel.org>; Fri, 28 Apr 2023 09:06:00 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-b99f374179bso7682585276.3
        for <linux-security-module@vger.kernel.org>; Fri, 28 Apr 2023 09:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1682697960; x=1685289960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5lwLxqW5VKmY2A43cr9IwcGLbMR5CgyRtASHDDCzvw=;
        b=Kgk4Eae1aP7UAuXMG2GCAySB2r0ZPNhQeU0yBcvJXJ6/0PIs4s7Ld+qmjhc7YMDJK8
         3CHZHe+bkXTnnwKbXaypBSa9guGEx3TJDS/789EPghQfEh2m3QBTGkLfeX9kYi8F6i9i
         YkrJ8FfhMdQbI0+Z1N3DpVbQ/F0NpEgDwHZcaFwC7KEEbTIKjW2hiUGxXwD/4ydBuAC6
         A55pwq8Txjyp/zqzRvmxQpvZb3mWtxi2BlSAgQTmHbdrD0rqISv9QNCKGLB83iOOjzsw
         /4GiOStfqQptBAeQmBGlX493AGsDpxdF2NASt1uCp/5ZLIJDbqt3D7sqalAc0gop2J75
         wtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682697960; x=1685289960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5lwLxqW5VKmY2A43cr9IwcGLbMR5CgyRtASHDDCzvw=;
        b=Nr+K6328hHpkCtqa2DXwgyut4AK25pByPXgksyiaUfQF8YLnRKX85l8x4Qg50b0QbA
         9GzLBnFl6XX9eoAHbih7A/R8shUPW9EZaxREnMve36JB8NWiIIEK4hJF0d1B30258DPv
         YYh+BUqRyP9dAKl62Uxud1WS/syKFROsjGwYOYVU9fYrCMg5czUmK3/cOBOp7LYcOvBf
         exzsu8BAUI88r0Mk9yW6c1vlDxe6ow9HuqjEM+tbEy1Ip6rpGsq3JVJDnBrKjDqnmiXn
         iEtDAMJb3LwxFm6PuiYxXftAGCufrFcHSM/EfO3K+Q96en1og5k7jwsioVp39yEKhFLe
         BheQ==
X-Gm-Message-State: AC+VfDxlpR5r/1z3/datBqW6sNPWFOCe4bOZSKeX4X9MI4HF4GiBt5Uv
        rmVODcnUNCw/3iNE9+0Na1DsbvVL1wUls/b/xwpRQK2J9jHR6gQ=
X-Google-Smtp-Source: ACHHUZ6FGZWVLRbJ0Vtr4MD2R/979p76yJnZwYUUc8G4bL5ujRwJBt2UCfCS3wLLk3W8UDR0BgoH5jCuz8afYiz+U5A=
X-Received: by 2002:a25:34c7:0:b0:b8e:e918:33ac with SMTP id
 b190-20020a2534c7000000b00b8ee91833acmr4602032yba.1.1682697959947; Fri, 28
 Apr 2023 09:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230428030916.2966-1-rdunlap@infradead.org> <CAHC9VhQoa5yw2e1jiN844pxNXXT+CosJn9ip7ysFnsnUbQUi2Q@mail.gmail.com>
 <7a8df04e-ee81-8b4a-152f-1588b8d6cb42@infradead.org>
In-Reply-To: <7a8df04e-ee81-8b4a-152f-1588b8d6cb42@infradead.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 28 Apr 2023 12:05:49 -0400
Message-ID: <CAHC9VhS0KjFRjamDZsUCZHDRk1bg08JH0iFJi9SN3ZqMOg2+xQ@mail.gmail.com>
Subject: Re: [PATCH] lsm: move hook comments docs to security/security.c
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Apr 28, 2023 at 10:46=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
> On 4/28/23 07:43, Paul Moore wrote:
> > On Thu, Apr 27, 2023 at 11:09=E2=80=AFPM Randy Dunlap <rdunlap@infradea=
d.org> wrote:
> >>
> >> Fix one kernel-doc warning, but invesigating that led to other
> >> kernel-doc movement (lsm_hooks.h to security.c) that needs to be
> >> fixed also.
> >>
> >> include/linux/lsm_hooks.h:1: warning: no structured comments found
> >>
> >> Fixes: e261301c851a ("lsm: move the remaining LSM hook comments to sec=
urity/security.c")
> >> Fixes: 1cd2aca64a5d ("lsm: move the io_uring hook comments to security=
/security.c")
> >> Fixes: 452b670c7222 ("lsm: move the perf hook comments to security/sec=
urity.c")
> >> Fixes: 55e853201a9e ("lsm: move the bpf hook comments to security/secu=
rity.c")
> >> Fixes: b14faf9c94a6 ("lsm: move the audit hook comments to security/se=
curity.c")
> >> Fixes: 1427ddbe5cc1 ("lsm: move the binder hook comments to security/s=
ecurity.c")
> >> Fixes: 43fad2821876 ("lsm: move the sysv hook comments to security/sec=
urity.c")
> >> Fixes: ecc419a44535 ("lsm: move the key hook comments to security/secu=
rity.c")
> >> Fixes: 742b99456e86 ("lsm: move the xfrm hook comments to security/sec=
urity.c")
> >> Fixes: ac318aed5498 ("lsm: move the Infiniband hook comments to securi=
ty/security.c")
> >> Fixes: 4a49f592e931 ("lsm: move the SCTP hook comments to security/sec=
urity.c")
> >> Fixes: 6b6bbe8c02a1 ("lsm: move the socket hook comments to security/s=
ecurity.c")
> >> Fixes: 2c2442fd46cd ("lsm: move the AF_UNIX hook comments to security/=
security.c")
> >> Fixes: 2bcf51bf2f03 ("lsm: move the netlink hook comments to security/=
security.c")
> >> Fixes: 130c53bfee4b ("lsm: move the task hook comments to security/sec=
urity.c")
> >> Fixes: a0fd6480de48 ("lsm: move the file hook comments to security/sec=
urity.c")
> >> Fixes: 9348944b775d ("lsm: move the kernfs hook comments to security/s=
ecurity.c")
> >> Fixes: 916e32584dfa ("lsm: move the inode hook comments to security/se=
curity.c")
> >> Fixes: 08526a902cc4 ("lsm: move the filesystem hook comments to securi=
ty/security.c")
> >> Fixes: 36819f185590 ("lsm: move the fs_context hook comments to securi=
ty/security.c")
> >> Fixes: 1661372c912d ("lsm: move the program execution hook comments to=
 security/security.c")
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Paul Moore <paul@paul-moore.com>
> >> Cc: James Morris <jmorris@namei.org>
> >> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> >> Cc: linux-security-module@vger.kernel.org
> >> Cc: Jonathan Corbet <corbet@lwn.net>
> >> Cc: linux-doc@vger.kernel.org
> >> Cc: KP Singh <kpsingh@kernel.org>
> >> Cc: bpf@vger.kernel.org
> >> ---
> >>  Documentation/bpf/prog_lsm.rst             |    2 +-
> >>  Documentation/security/lsm-development.rst |    6 +++---
> >>  Documentation/security/lsm.rst             |    2 +-
> >>  3 files changed, 5 insertions(+), 5 deletions(-)
> >
> > Thanks Randy.  Did you want to take this via the doc tree, or would
> > you prefer if I pulled this into the LSM tree?
>
> I think that the LSM tree would be appropriate for it.

Fair enough, I just merged this into the lsm/stable-6.4 branch and
I'll send this up to Linus shortly.

--=20
paul-moore.com
