Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8794C7EE23
	for <linux-security-module@archiver.kernel.org>; Sat, 20 May 2023 19:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjETTpj (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 20 May 2023 15:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjETTpi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 20 May 2023 15:45:38 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B67D119
        for <linux-security-module@vger.kernel.org>; Sat, 20 May 2023 12:45:37 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-563b1e5f701so15224457b3.3
        for <linux-security-module@vger.kernel.org>; Sat, 20 May 2023 12:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684611936; x=1687203936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZlVnEh//Bei2m+UVIdsQB+nBXgq06/R1aKG4StaR3o=;
        b=FnzMU1aUoc7SgSOL/mPW53PZpJyW0QODMJwvVAOT79n7yp38qMGF2RSZosec1+4DrW
         VoXtvBr1bP9na/mFACe3/fllqDJNSB3K6jxIpBoLyEDrObr8AiigD6BhVluWRMA8sZ9s
         PngVEUPthGXg0sPG6MymZSxBUmlZXXo5ba1r+6DJ98uzH6oVx5zDvwXRqQnmToC/Juv4
         QZGd+48avKflhCdQ22aS5msAbrdgWiVX0Jt2ujo4zF/VdNyjk3IWxwfCoJKK3UdAzPOS
         Sfbt0vUIEU2ML4Jy5BTKEMXxNH+6ZlNf+WYmrLycmnV3O4WpQxYGb40rS4QaIS4qHE9w
         yBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684611936; x=1687203936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZlVnEh//Bei2m+UVIdsQB+nBXgq06/R1aKG4StaR3o=;
        b=gMdTq59vwZ76xuLSseF8p03L0c9q5dV46luLG499MlZ72evLZGrLqtRoWUuzUL5yp3
         lCVcSMQvFEwsx+KBfUIXziGokxMW1kQsb6exLriNcm3np8X8vmV5RnbMyrJF0jmszHHd
         KUr17LbS6JUQJ0REvhUXNF+7pQW/oNC1CxY4IbnL7axuOymiMWEfIohPqv12RmrrV9BS
         2lsYaQRwFywWksdbVr6VIwloJNtiLj0jhCA7MPtbfsvQm7TGiMOQwn8uUI21V6sN5unJ
         stXynOctbA1sCPH3fjp14qyNjN8zaTR/IYqDPVZRIXV3hcmxJqB1j5n7olpxmcZRqsm0
         I4BQ==
X-Gm-Message-State: AC+VfDwm9gNUYMi2z+60jED0jd8l64F2nreiCXi0nEmGbD5OSiwPNcS9
        fDwkTQhAH2T3y9Pijt02lmYLeoku8T5Vt6QdKOe8qmurShmLqC4=
X-Google-Smtp-Source: ACHHUZ4ZOYYVm+bVl5KotfIu7KqaAHnx26WQXQgYT8zL+9I8uNyx4rKL3TydJ6mqeupD/aoI/ZdUkIvhrqrbKNMKmq8=
X-Received: by 2002:a0d:d993:0:b0:556:b11e:ec34 with SMTP id
 b141-20020a0dd993000000b00556b11eec34mr6451026ywe.50.1684611936390; Sat, 20
 May 2023 12:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhRPvkdk6t1zkx+Y-QVP_vJRSxp+wuOO0YjyppNDLTNg7g@mail.gmail.com>
 <f5ada796-41ba-5cc8-b43d-efd639994f15@I-love.SAKURA.ne.jp>
In-Reply-To: <f5ada796-41ba-5cc8-b43d-efd639994f15@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 20 May 2023 15:45:25 -0400
Message-ID: <CAHC9VhQxCqALs9z0++ANjwQ99imkrecivMWgx0YtgBVOid9J5w@mail.gmail.com>
Subject: Re: Stable backport of de3004c874e7 ("ocfs2: Switch to security_inode_init_security()")
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, May 20, 2023 at 1:54=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2023/05/20 6:51, Paul Moore wrote:
> >    Finally, since security_inode_init_security(), unlike
> >    security_old_inode_init_security(), returns zero instead of -EOPNOTS=
UPP if
> >    no xattrs were provided by LSMs or if inodes are private, additional=
ly
> >    check in ocfs2_init_security_get() if the xattr name is set.
> >
> >    If not, act as if security_old_inode_init_security() returned -EOPNO=
TSUPP,
> >    and set si->enable to zero to notify to the functions following
> >    ocfs2_init_security_get() that no xattrs are available.
>
> Regarding security_inode_init_security(), similar problem was found on re=
iserfs ...

It is likely that reiserfs lhas other issues as well, which is why I
didn't propose the similar reiserfs patch for backporting to stable.
The request here is only for the ocfs2 patch, which has not seen any
problem reports and does fix at least one reported bug/panic.

Let's discuss the reiserfs patches in the other, relevant threads and
leave this thread dedicated to the ocfs2 backport to stable.

--=20
paul-moore.com
