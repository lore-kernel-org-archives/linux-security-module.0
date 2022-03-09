Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8ACC433EF
	for <linux-security-module@archiver.kernel.org>; Wed,  9 Mar 2022 21:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiCIVdK (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 9 Mar 2022 16:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbiCIVdJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Mar 2022 16:33:09 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F2111D792
        for <linux-security-module@vger.kernel.org>; Wed,  9 Mar 2022 13:32:09 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id b24so4517181edu.10
        for <linux-security-module@vger.kernel.org>; Wed, 09 Mar 2022 13:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZHkvHMA1I6eh/YZqJlZmNXRy1yBzafqBEJKVUwInNkU=;
        b=T/pixWr78MTQFIr0gZocxDvBgcUg8EdHrLBsGWDk2HasstXtU8yYvGSGdTEw8/CkBA
         p6xuAsgcGRciwA4yRltBP8eAhwCOgupho6O3XUF1RdZqzSHnIDtBStqZ6tpGLu6SBWRe
         p+Y2GF7wUVcPkKSKXNtNjFtJ64aFK78dPs5S3NKndWJ82s1AuAITJ5phuhVQCuk89zoY
         JJZijUXSZSZI4XD5jXTY7tiyn2SRbA1qcTNtz2f+WIzaEAhd2n8jreps3ybBJWe88Jq5
         5su8hAfUj0zUsNjXpL3t7X4Oxm+QgqSdxh10eIxKu7Z632mzJivSvC465shwR3HzKH2/
         AUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZHkvHMA1I6eh/YZqJlZmNXRy1yBzafqBEJKVUwInNkU=;
        b=Jwifuz7IfMjJXG101cwU3yPTBsFzxs1uyH7c9oD+ldmeJaYm4Zk+5K53EOzVHe9znt
         1mKI3ZPMKE4hweBfixVLzUsc4SISBAdtSVpjAENrpAh4ShUr7xKtx3dPm4X+qbVaEyWJ
         pIdq59LEiraP91tGvX/4sPqRTXJFl1/TKcm9SFpw0F+Bxk5T7k6FhgfomzGhuapiSeJ5
         K8qVZbUsHa1sq8WhT0n0Wm7zDDcDSHjVd0oMgD+3LBahOvtj7K88FEFiPJ5cUxPDOder
         MGT2mQ4ivS/WmPwWbcXiVWPDXfkp0Z4rAkHnP/3I+f0WTM+6IHsKJ764AbtMlBIi4le4
         ZEQg==
X-Gm-Message-State: AOAM531MP1F4t//WM4Me1RC7tnV9lbcG4/UjGUTWp1sr8bpI6l1GfYLo
        0f0JcuiLcQhXoG0RRyf3+aTo0tezZD7qdHfOgqj+
X-Google-Smtp-Source: ABdhPJwmQnZ6x8mnpsnt5Id3i1N77PSHj7DRdzEp7HrYbjMp09EZIcsmw9Xs9Ups7S4MchBRNM5VC5oXh2hJcrmwWpM=
X-Received: by 2002:a05:6402:90c:b0:415:d340:4ae2 with SMTP id
 g12-20020a056402090c00b00415d3404ae2mr1394660edz.331.1646861527956; Wed, 09
 Mar 2022 13:32:07 -0800 (PST)
MIME-Version: 1.0
References: <20220228215935.748017-1-mic@digikod.net> <20220301092232.wh7m3fxbe7hyxmcu@wittgenstein>
 <f6b63133-d555-a77c-0847-de15a9302283@digikod.net>
In-Reply-To: <f6b63133-d555-a77c-0847-de15a9302283@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Mar 2022 16:31:57 -0500
Message-ID: <CAHC9VhQd3rL-13k0u39Krkdjp2_dtPfgEPxr=kawWUM9FjjOsw@mail.gmail.com>
Subject: Re: [PATCH v1] fs: Fix inconsistent f_mode
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Steve French <sfrench@samba.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>,
        selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Mar 1, 2022 at 5:15 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
> On 01/03/2022 10:22, Christian Brauner wrote:
> > On Mon, Feb 28, 2022 at 10:59:35PM +0100, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> >> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> >>
> >> While transitionning to ACC_MODE() with commit 5300990c0370 ("Sanitize
> >> f_flags helpers") and then fixing it with commit 6d125529c6cb ("Fix
> >> ACC_MODE() for real"), we lost an open flags consistency check.  Openi=
ng
> >> a file with O_WRONLY | O_RDWR leads to an f_flags containing MAY_READ =
|
> >> MAY_WRITE (thanks to the ACC_MODE() helper) and an empty f_mode.
> >> Indeed, the OPEN_FMODE() helper transforms 3 (an incorrect value) to 0=
.
> >>
> >> Fortunately, vfs_read() and vfs_write() both check for FMODE_READ, or
> >> respectively FMODE_WRITE, and return an EBADF error if it is absent.
> >> Before commit 5300990c0370 ("Sanitize f_flags helpers"), opening a fil=
e
> >> with O_WRONLY | O_RDWR returned an EINVAL error.  Let's restore this s=
afe
> >> behavior.
> >
> > That specific part seems a bit risky at first glance. Given that the
> > patch referenced is from 2009 this means we've been allowing O_WRONLY |
> > O_RDWR to succeed for almost 13 years now.
>
> Yeah, it's an old bug, but we should keep in mind that a file descriptor
> created with such flags cannot be used to read nor write. However,
> unfortunately, it can be used for things like ioctl, fstat, chdir=E2=80=
=A6 I
> don't know if there is any user of this trick.
>
> Either way, there is an inconsistency between those using ACC_MODE() and
> those using OPEN_FMODE(). If we decide to take a side for the behavior
> of one or the other, without denying to create such FD, it could also
> break security policies. We have to choose what to potentially break=E2=
=80=A6

I'm not really liking the idea that the empty/0 f_mode field leads to
SELinux doing an ioctl access check as opposed to the expected
read|write check.  Yes, other parts of the code catch the problem, but
this is bad from a SELinux perspective.  Looking quickly at the other
LSMs, it would appear that other LSMs are affected as well.

If we're not going to fix file::f_mode, the LSMs probably need to
consider using file::f_flags directly in conjunction with a correct
OPEN_FMODE() macro (or better yet a small inline function that isn't
as ugly).

--=20
paul-moore.com
