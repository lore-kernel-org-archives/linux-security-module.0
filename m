Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B8EC43334
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Jul 2022 22:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiGOWmU (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 Jul 2022 18:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiGOWmU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Jul 2022 18:42:20 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0360B32D86
        for <linux-security-module@vger.kernel.org>; Fri, 15 Jul 2022 15:42:19 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sz17so11303767ejc.9
        for <linux-security-module@vger.kernel.org>; Fri, 15 Jul 2022 15:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hLYE+mHdshtxuCnO3bu3jOFg+QiGnKvq4aBMtxTnQro=;
        b=Z9E/0/0fQzEMe9C4vzySJG2r6oJjkHDSLdGJ0ON+AYCn0VowZ4KuXWqLHozb+K/OZg
         KglnzGMUPEUeNvWJA/lcvTOnW5V9kieIWU6+d+7agrUnJmR117zMjyPxIivk3w3U1nQR
         Nje3HMwJGsxS7F6dBJTtSiDLLinKqMLlTCG090yGBJzOuflcfwA0W+pfMltAXx64Z5x2
         UdLPX1W+1mUDLuhzydhJLnfnr4EE91/oLEOjZZhIRx9c2wkozFgqm/t9IEiZqS6ygDhq
         HsEQsuhlRckxgMv4LzBruUKKfYDSZFXJmTzU79AMtU2pv1o1c60AXuFRzKWa9sSLwAeq
         d55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hLYE+mHdshtxuCnO3bu3jOFg+QiGnKvq4aBMtxTnQro=;
        b=zclMz310zPJ+fDXCLIxU610msVukRpNWYYJN5QTguOxNzFbvqvyx+NXe3OWCptqNha
         /a/3S+Y6OfDs9IKzS3Ln2D3aNWZ118+sxBBKunZSh5nt6nEdvAMiNW6AfH6btVVyGoAU
         GvAKidFfcY+XXwGeLpEhjqnbSNcqfn2EyartY78bkC3ltI1+hYjzVccIy46oq8rwLXEs
         Vs7SiGXauQf5OmJhSM/McCQNYpBDd8nGdxReQpbUTizL5ADAF5vZpqx1iKoiDwmSoJMC
         wGSJjgijq3Zxmwutf2o34l7MEzZKz5VBAk1FabXiN8e1Kp/muoBZcCH97iO/qV62NGwB
         fczA==
X-Gm-Message-State: AJIora9V+WL8DSnKydXiQLgBu6rb42Hbk9l8L8Ls358gp68h+RVs3wi7
        /PQvIX3x7iB5/mlUf89wUteYG4w8pkvsVfzYP/KeoQ==
X-Google-Smtp-Source: AGRyM1vwJV71AfBEBQmLxRB4I0EnKqi1TgRdy7TZ3T+dyKTPO7Dl0qbwF7XKCiBY34a8FMYolK3imJRt6HUFTx5ymp0=
X-Received: by 2002:a17:907:6d12:b0:72b:6e70:8c7d with SMTP id
 sa18-20020a1709076d1200b0072b6e708c7dmr16470656ejc.23.1657924937385; Fri, 15
 Jul 2022 15:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220628222941.2642917-1-jeffxu@google.com> <06847585-8712-5f0c-b7e4-e32745576e16@digikod.net>
 <CALmYWFtn97HpsTK02Sn7riD7yJ3zdbGob+Yz8PHa_Yx0tgfchQ@mail.gmail.com>
 <CALmYWFvcSn_wks0bXo3_DUyYGtVW_MHrrO1dRoYcxY4uiB1KEA@mail.gmail.com>
 <0abdd920-b5cc-2fa9-7494-104c9c67480d@digikod.net> <CALmYWFvfRFfZbk=9P-=RNtjhXoR0ToQKnVVEZwmXB9yxLEHotg@mail.gmail.com>
 <CABXOdTf=o1zSSDUPNubHxAnF=1dOwOuxKfrViPHAD-tV_4x=Ww@mail.gmail.com>
 <CALmYWFvfDcJCUDCLhrDPdvyY6fH_2diQbbo8ejq3Xvu6E8_2rA@mail.gmail.com>
 <CABXOdTcQOrat3vGCm3nw_ufYKcrQ1gqVdvbUSEUehfhZ7gAW4g@mail.gmail.com>
 <CALmYWFu-c7HvfqB=JpX-iN8QUfEwwZpQRpwncebJ8R8urvvCUQ@mail.gmail.com> <CALmYWFtrMdTY9HTWzG=MctUcsKQZVExHWu7+3C58hncazH5+5w@mail.gmail.com>
In-Reply-To: <CALmYWFtrMdTY9HTWzG=MctUcsKQZVExHWu7+3C58hncazH5+5w@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 15 Jul 2022 15:42:06 -0700
Message-ID: <CABXOdTcZM-RomzrCZQkzexCSS7RTFf_Mz+kCghqEK_icd9W3LQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/landlock: skip ptrace_test when YAMA is enabled
To:     Jeff Xu <jeffxu@google.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        linux-security-module@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Jul 15, 2022 at 2:42 PM Jeff Xu <jeffxu@google.com> wrote:
>
> Jeff Xu <jeffxu@google.com>
>
> > Jul 14, 2022, 5:35 PM (20 hours ago)
> > to Guenter, Micka=C3=ABl, linux-security-module, Jorge, Guenter, Kees
> > > On Thu, Jul 14, 2022 at 11:37 AM Jeff Xu <jeffxu@google.com> wrote:
> > > >
> > > > > > > Hmm, well, it is not related to Yama then. Could it be linked=
 to other
> > > > > > > Chromium OS non-upstream patches?
> > > > > >
> > > > > >
> > > > > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS i=
s not
> > > > > > enabled in chromeOS.
> > > > > > If there is a reliable way of detecting OVERLAYFS (checking mou=
nt
> > > > > > overlayfs is successful ? ), this is a good candidate to add SK=
IP.
> > > > > >
> > > >
> > > > > IS_ENABLED(CONFIG_OVERLAY_FS) ?
> > > >
> > > > Could be. Landlock selftest currently is a user space program thoug=
h,
> > > > IS_ENABLED will depend on the kernel header during compile time.
> > > >
>
>
>
> > > Ah, sorry, I thought it was an in-kernel test. Userspace should be
> > > able to determine if overlayfs is supported by checking /sys/fs/ or
> > > possibly /proc/fs/.
>
>
> > Thanks for clarifying.
>
>
> > lsmod might be the one, such as:
> > lsmod | grep overlayfs
>
>
> I built a kernel with overlayfs on chromeos, and lsmod didn't give me
> what I wanted.
> /sys/fs and /proc/fs also doesn't show anything about overlayfs
>
> @Micka=C3=ABl Sala=C3=BCn
> Are you OK with SKIP the overlay test when mount("overlay",...) fails
> in FIXTURE_SETUP() ? Mount failure can be used as an indication.
>

Maybe the error code returned from mount gives a hint. Also, how about
/proc/filesystems ?

Guenter

> Jeff
>
>
>
>
>
> On Thu, Jul 14, 2022 at 5:35 PM Jeff Xu <jeffxu@google.com> wrote:
> >
> > > On Thu, Jul 14, 2022 at 11:37 AM Jeff Xu <jeffxu@google.com> wrote:
> > > >
> > > > > > > Hmm, well, it is not related to Yama then. Could it be linked=
 to other
> > > > > > > Chromium OS non-upstream patches?
> > > > > >
> > > > > >
> > > > > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS i=
s not
> > > > > > enabled in chromeOS.
> > > > > > If there is a reliable way of detecting OVERLAYFS (checking mou=
nt
> > > > > > overlayfs is successful ? ), this is a good candidate to add SK=
IP.
> > > > > >
> > > >
> > > > > IS_ENABLED(CONFIG_OVERLAY_FS) ?
> > > >
> > > > Could be. Landlock selftest currently is a user space program thoug=
h,
> > > > IS_ENABLED will depend on the kernel header during compile time.
> > > >
> >
> >
> > > Ah, sorry, I thought it was an in-kernel test. Userspace should be
> > > able to determine if overlayfs is supported by checking /sys/fs/ or
> > > possibly /proc/fs/.
> >
> > Thanks for clarifying.
> >
> > lsmod might be the one, such as:
> > lsmod | grep overlayfs
> >
> >
> > Thanks
> > Jeff
> >
> >
> >
> > On Thu, Jul 14, 2022 at 1:40 PM Guenter Roeck <groeck@google.com> wrote=
:
> > >
> > > On Thu, Jul 14, 2022 at 11:37 AM Jeff Xu <jeffxu@google.com> wrote:
> > > >
> > > > > > > Hmm, well, it is not related to Yama then. Could it be linked=
 to other
> > > > > > > Chromium OS non-upstream patches?
> > > > > >
> > > > > >
> > > > > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS i=
s not
> > > > > > enabled in chromeOS.
> > > > > > If there is a reliable way of detecting OVERLAYFS (checking mou=
nt
> > > > > > overlayfs is successful ? ), this is a good candidate to add SK=
IP.
> > > > > >
> > > >
> > > > > IS_ENABLED(CONFIG_OVERLAY_FS) ?
> > > >
> > > > Could be. Landlock selftest currently is a user space program thoug=
h,
> > > > IS_ENABLED will depend on the kernel header during compile time.
> > > >
> > >
> > > Ah, sorry, I thought it was an in-kernel test. Userspace should be
> > > able to determine if overlayfs is supported by checking /sys/fs/ or
> > > possibly /proc/fs/.
> > >
> > > Guenter
> > >
> > > >
> > > > On Wed, Jul 13, 2022 at 5:30 PM Guenter Roeck <groeck@google.com> w=
rote:
> > > > >
> > > > > On Wed, Jul 13, 2022 at 4:44 PM Jeff Xu <jeffxu@google.com> wrote=
:
> > > > > >
> > > > > > > > a correction:
> > > > > > > >
> > > > > > > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > >     case 0 - classic ptrace permissions: a process can PTRA=
CE_ATTACH to
> > > > > > > >     any other
> > > > > > > >          process running under the same uid, as long as it =
is dumpable (i.e.
> > > > > > > >          did not transition uids, start privileged, or have=
 called
> > > > > > > >          prctl(PR_SET_DUMPABLE...) already). Similarly, PTR=
ACE_TRACEME is
> > > > > > > >          unchanged.
> > > > > > > >
> > > > > > > >     Test: All passing
> > > > > > > >
> > > > > > > > // Base_test: 7/7 pass.
> > > > > > > > // Fs_test 46/48 pass
> > > > > > > > //.   not ok 47 layout2_overlay.no_restriction
> > > > > > > > //.   not ok 48 layout2_overlay.same_content_different_file
> > > > > > > > //  Ptrace 8/8 pass
> > > > > >
> > > > > >
> > > > > > > Hmm, well, it is not related to Yama then. Could it be linked=
 to other
> > > > > > > Chromium OS non-upstream patches?
> > > > > >
> > > > > >
> > > > > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS i=
s not
> > > > > > enabled in chromeOS.
> > > > > > If there is a reliable way of detecting OVERLAYFS (checking mou=
nt
> > > > > > overlayfs is successful ? ), this is a good candidate to add SK=
IP.
> > > > > >
> > > > >
> > > > > IS_ENABLED(CONFIG_OVERLAY_FS) ?
> > > > >
> > > > > > Overall, all the failure of landlock selftest seen in chromeOS =
are
> > > > > > expected, we just need to modify the test.
> > > > > >
> > > > > > Thanks
> > > > > > Best Regards
> > > > > > Jeff
> > > > > >
> > > > > >
> > > > > >
> > > > > > On Thu, Jul 7, 2022 at 7:25 AM Micka=C3=ABl Sala=C3=BCn <mic@di=
gikod.net> wrote:
> > > > > > >
> > > > > > >
> > > > > > > On 07/07/2022 01:35, Jeff Xu wrote:
> > > > > > > > a correction:
> > > > > > > >
> > > > > > > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > >     case 0 - classic ptrace permissions: a process can PTRA=
CE_ATTACH to
> > > > > > > >     any other
> > > > > > > >          process running under the same uid, as long as it =
is dumpable (i.e.
> > > > > > > >          did not transition uids, start privileged, or have=
 called
> > > > > > > >          prctl(PR_SET_DUMPABLE...) already). Similarly, PTR=
ACE_TRACEME is
> > > > > > > >          unchanged.
> > > > > > > >
> > > > > > > >     Test: All passing
> > > > > > > >
> > > > > > > > // Base_test: 7/7 pass.
> > > > > > > > // Fs_test 46/48 pass
> > > > > > > > //.   not ok 47 layout2_overlay.no_restriction
> > > > > > > > //.   not ok 48 layout2_overlay.same_content_different_file
> > > > > > > > //  Ptrace 8/8 pass
> > > > > > >
> > > > > > > Hmm, well, it is not related to Yama then. Could it be linked=
 to other
> > > > > > > Chromium OS non-upstream patches?
