Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E09FC4332F
	for <linux-security-module@archiver.kernel.org>; Thu, 15 Dec 2022 16:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiLOQ4O (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 15 Dec 2022 11:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiLOQ4J (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Dec 2022 11:56:09 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545DAF580
        for <linux-security-module@vger.kernel.org>; Thu, 15 Dec 2022 08:56:04 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so3251638pjd.5
        for <linux-security-module@vger.kernel.org>; Thu, 15 Dec 2022 08:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOs+4sldiwGC1XG54dp5mVgT4uLPOQwpbZy8XgG5P7U=;
        b=BwAd8aLPF5gd7FIHoISnAe0Zyh/n9acpz7ASV5bArM8hi+12M+FokUGMCFBYex8YYT
         nxAxlAOtheavS0XJFp986uZEh6iP0Ge1ESokWEFBokuizRQABamacozxfHoHFFmuc1ig
         og9sJEbM9bDah05cislLrAkqozwsfBmeI2c0IATzpQQH3Shewyh+bhXQoOzGvx/VhhF4
         q0IchDuQ9ETeLCwyhWh4KMyKbH1/EIDfepr0bi0OHiqJSTjhJ7A3Nxt8kXYoynQWbMgP
         NFZaNJrEnOv3E7GDTrJU47AoUmR++UPFYGrV0RFmWai23NVv2rwcyUqZetoHP0TjnvhP
         tb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOs+4sldiwGC1XG54dp5mVgT4uLPOQwpbZy8XgG5P7U=;
        b=Ir4ZOb/KxRda1zuHZHyb5/b6RaU3oWzQqnNMymFZ8K25Ng7hKZjS5EIUy7He0rcnPD
         EFP84j1yealmxdvgEW0MMheiqxt17xQV35G2divwx8wHvJRJYBQnCjEHmxWv+jo/bKM7
         hfbNR7ElAlHoNPE7mCEg9llBgAFpp/t2ahgtxL6J1sMrHQV0cOve3xg4TTeGwsYP59SY
         Ls4z75SZDDOwjM3HwlNqkOtVrxX9+7gFVh0wC1zApsy/EYdVj8K6JjP1sWDCpHcGlbaM
         DRbTYwkMc5RDd6NRaSHDYCistsF4TkOXrBShG7w1XvPKTzPh0/YpNZpgnCvJyn8USH6D
         wfyQ==
X-Gm-Message-State: AFqh2koYNZqvQIBAI5cSrG6aR+RjSQJ3PEK0lOxv6Ydp1U4Wsv5403XL
        94W5rQ+acSldcmmIYjKz8AkIPTY0bssseyc06npeGw==
X-Google-Smtp-Source: AMrXdXtENt/mhPma/+EbgzmxkFLEmcOUooUWEz4dux8uEyqEYR9PwvfNgIzmFBek41FGvcb4TrN/AF2YjFTKl7rw3wI=
X-Received: by 2002:a17:90a:4612:b0:219:a43b:1006 with SMTP id
 w18-20020a17090a461200b00219a43b1006mr786360pjg.195.1671123363557; Thu, 15
 Dec 2022 08:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20221209160453.3246150-1-jeffxu@google.com> <202212141053.7F5D1F6@keescook>
 <CALmYWFss4hGOgJaeah8p7q86xmE7AOwOazxggGCuY=A+ZUVWhQ@mail.gmail.com> <202212141607.D2D986C076@keescook>
In-Reply-To: <202212141607.D2D986C076@keescook>
From:   Jeff Xu <jeffxu@google.com>
Date:   Thu, 15 Dec 2022 08:55:26 -0800
Message-ID: <CALmYWFvJv_4yLxnv=8Bpx0mE_WLi0yGVxR-ybN8VAatEwmM+iQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] mm/memfd: introduce MFD_NOEXEC_SEAL and MFD_EXEC
To:     Kees Cook <keescook@chromium.org>
Cc:     akpm@linux-foundation.org, jeffxu@chromium.org,
        skhan@linuxfoundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 14, 2022 at 4:08 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Dec 14, 2022 at 03:32:16PM -0800, Jeff Xu wrote:
> > On Wed, Dec 14, 2022 at 10:54 AM Kees Cook <keescook@chromium.org> wrot=
e:
> > >
> > > On Fri, Dec 09, 2022 at 04:04:47PM +0000, jeffxu@chromium.org wrote:
> > > > From: Jeff Xu <jeffxu@google.com>
> > > >
> > > > Since Linux introduced the memfd feature, memfd have always had the=
ir
> > > > execute bit set, and the memfd_create() syscall doesn't allow setti=
ng
> > > > it differently.
> > > >
> > > > However, in a secure by default system, such as ChromeOS, (where al=
l
> > > > executables should come from the rootfs, which is protected by Veri=
fied
> > > > boot), this executable nature of memfd opens a door for NoExec bypa=
ss
> > > > and enables =E2=80=9Cconfused deputy attack=E2=80=9D.  E.g, in VRP =
bug [1]: cros_vm
> > > > process created a memfd to share the content with an external proce=
ss,
> > > > however the memfd is overwritten and used for executing arbitrary c=
ode
> > > > and root escalation. [2] lists more VRP in this kind.
> > > >
> > > > On the other hand, executable memfd has its legit use, runc uses me=
mfd=E2=80=99s
> > > > seal and executable feature to copy the contents of the binary then
> > > > execute them, for such system, we need a solution to differentiate =
runc's
> > > > use of  executable memfds and an attacker's [3].
> > > >
> > > > To address those above, this set of patches add following:
> > > > 1> Let memfd_create() set X bit at creation time.
> > > > 2> Let memfd to be sealed for modifying X bit.
> > > > 3> A new pid namespace sysctl: vm.memfd_noexec to control the behav=
ior of
> > > >    X bit.For example, if a container has vm.memfd_noexec=3D2, then
> > > >    memfd_create() without MFD_NOEXEC_SEAL will be rejected.
> > > > 4> A new security hook in memfd_create(). This make it possible to =
a new
> > > > LSM, which rejects or allows executable memfd based on its security=
 policy.
> > >
> > > I think patch 1-5 look good to land. The LSM hook seems separable, an=
d
> > > could continue on its own. Thoughts?
> > >
> > Agreed.
> >
> > > (Which tree should memfd change go through?)
> > >
> > I'm not sure, is there a recommendation ?
>
> It looks like it's traditionally through akpm's tree. Andrew, will you
> carry patches 1-5?
>
Hi Andrew, if you are taking this, V8 is the latest that contains patch 1-5=
.

Thanks
Jeff

> Thanks!
>
> --
> Kees Cook
