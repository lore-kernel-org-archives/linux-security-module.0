Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D51C433EF
	for <linux-security-module@archiver.kernel.org>; Sat, 16 Jul 2022 00:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiGPARP (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 Jul 2022 20:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiGPARO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Jul 2022 20:17:14 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C8B8AEF9
        for <linux-security-module@vger.kernel.org>; Fri, 15 Jul 2022 17:17:13 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y9so5904242pff.12
        for <linux-security-module@vger.kernel.org>; Fri, 15 Jul 2022 17:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=33aLPVfV/p8z6kSz9uJOGMRkk7ogvLEZ28WOlKkS5vA=;
        b=c8WD17cRV/deM+xMwUGamEY/ZaJLMrcLy0mU/oKDiRD5JMm+YYbOHzy4jEORMhMkgI
         /vq6n774VVd2TeAeOOkyquTv1rsrvsLLRi9L5wHYeOrgaG8IW6d1vo9vDxgJ029zL1UI
         r4dYaNFqJTMKzLT4SMSmiAvbeQbX/1my7hBD3485Fasmp86tuVfqzO2mRMbQWEJ2/thX
         n7NAYmhXIgr9Gq2XRB+XmGJeXP1SgZUDZ6vWgDS1k4Xd6Ac7fksV8hpOYH1/FZAxJvxj
         oWIPe/ZH9DlcOJPNWLPd3WKq6x/P/Ii/F594+yLBysAcE7nvaV74Z26gX9fITSyLVVk4
         z0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=33aLPVfV/p8z6kSz9uJOGMRkk7ogvLEZ28WOlKkS5vA=;
        b=GScroJqS8cwPXzWBS8xSrpOv1Oh7aPAOgS+5KsJ9mvxPpj2GC4W07oYK6qsdaWixHO
         waTdhwdzeFlw5a5u1bS6otuDicxruBi3yCVmhP7MRbFSZWufNUO/6CEsYmBVECIjUn+D
         PZiLC8Bu54n8Sen6zfme+yg2LZgBUFKWmdmvba0pFuMGa4NRIAzJWdvJNcLeJ7bWt/aA
         dGvQ7/wocB0AvenmPetFHLRfVr9Wmzm38k4TggpAUjXr6CPQI3aGax/06T087hmv5Ggd
         8QfdmGwKepRXlYGT9MpzchrRCTBGCvaAzxb5TAHRf47mQEehvL+PcdtVjR3vFVZejUTn
         BAzw==
X-Gm-Message-State: AJIora+W7bVQbfY0JUnuTsd2cTGYZSqZ0WbiKfGL9+jWWp05r1gZntVA
        2nHCj4ySlRZRV1UMO3iKqeYHreQz5SXIcMZJ/0DL5g==
X-Google-Smtp-Source: AGRyM1s4hJOfWDmnafP1ll7ToDcTXNM2KPL6AFPIXcyPZ+MQMIo07HSgDduKSje28wCu3uOBrwcrCWZnMD1aF7v4MTA=
X-Received: by 2002:a05:6a00:815:b0:52a:dea8:269b with SMTP id
 m21-20020a056a00081500b0052adea8269bmr16628360pfk.66.1657930632829; Fri, 15
 Jul 2022 17:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220628222941.2642917-1-jeffxu@google.com> <06847585-8712-5f0c-b7e4-e32745576e16@digikod.net>
 <CALmYWFtn97HpsTK02Sn7riD7yJ3zdbGob+Yz8PHa_Yx0tgfchQ@mail.gmail.com>
 <CALmYWFvcSn_wks0bXo3_DUyYGtVW_MHrrO1dRoYcxY4uiB1KEA@mail.gmail.com>
 <0abdd920-b5cc-2fa9-7494-104c9c67480d@digikod.net> <CALmYWFvfRFfZbk=9P-=RNtjhXoR0ToQKnVVEZwmXB9yxLEHotg@mail.gmail.com>
 <CABXOdTf=o1zSSDUPNubHxAnF=1dOwOuxKfrViPHAD-tV_4x=Ww@mail.gmail.com>
 <CALmYWFvfDcJCUDCLhrDPdvyY6fH_2diQbbo8ejq3Xvu6E8_2rA@mail.gmail.com>
 <CABXOdTcQOrat3vGCm3nw_ufYKcrQ1gqVdvbUSEUehfhZ7gAW4g@mail.gmail.com>
 <CALmYWFu-c7HvfqB=JpX-iN8QUfEwwZpQRpwncebJ8R8urvvCUQ@mail.gmail.com>
 <CALmYWFtrMdTY9HTWzG=MctUcsKQZVExHWu7+3C58hncazH5+5w@mail.gmail.com> <CABXOdTcZM-RomzrCZQkzexCSS7RTFf_Mz+kCghqEK_icd9W3LQ@mail.gmail.com>
In-Reply-To: <CABXOdTcZM-RomzrCZQkzexCSS7RTFf_Mz+kCghqEK_icd9W3LQ@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Fri, 15 Jul 2022 17:16:36 -0700
Message-ID: <CALmYWFtstvRVZOYCJBwrhayGJDc-=c8avuD0wWm6LURu8EKG2g@mail.gmail.com>
Subject: Re: [PATCH] selftests/landlock: skip ptrace_test when YAMA is enabled
To:     Guenter Roeck <groeck@google.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        linux-security-module@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> Maybe the error code returned from mount gives a hint.

It returns -1

>
> Also, how about
> /proc/filesystems ?

Yes. it has what I want:
nodev overlay

Thanks for your help! I can use this at runtime check.

Jeff


On Fri, Jul 15, 2022 at 3:42 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Fri, Jul 15, 2022 at 2:42 PM Jeff Xu <jeffxu@google.com> wrote:
> >
> > Jeff Xu <jeffxu@google.com>
> >
> > > Jul 14, 2022, 5:35 PM (20 hours ago)
> > > to Guenter, Micka=C3=ABl, linux-security-module, Jorge, Guenter, Kees
> > > > On Thu, Jul 14, 2022 at 11:37 AM Jeff Xu <jeffxu@google.com> wrote:
> > > > >
> > > > > > > > Hmm, well, it is not related to Yama then. Could it be link=
ed to other
> > > > > > > > Chromium OS non-upstream patches?
> > > > > > >
> > > > > > >
> > > > > > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS=
 is not
> > > > > > > enabled in chromeOS.
> > > > > > > If there is a reliable way of detecting OVERLAYFS (checking m=
ount
> > > > > > > overlayfs is successful ? ), this is a good candidate to add =
SKIP.
> > > > > > >
> > > > >
> > > > > > IS_ENABLED(CONFIG_OVERLAY_FS) ?
> > > > >
> > > > > Could be. Landlock selftest currently is a user space program tho=
ugh,
> > > > > IS_ENABLED will depend on the kernel header during compile time.
> > > > >
> >
> >
> >
> > > > Ah, sorry, I thought it was an in-kernel test. Userspace should be
> > > > able to determine if overlayfs is supported by checking /sys/fs/ or
> > > > possibly /proc/fs/.
> >
> >
> > > Thanks for clarifying.
> >
> >
> > > lsmod might be the one, such as:
> > > lsmod | grep overlayfs
> >
> >
> > I built a kernel with overlayfs on chromeos, and lsmod didn't give me
> > what I wanted.
> > /sys/fs and /proc/fs also doesn't show anything about overlayfs
> >
> > @Micka=C3=ABl Sala=C3=BCn
> > Are you OK with SKIP the overlay test when mount("overlay",...) fails
> > in FIXTURE_SETUP() ? Mount failure can be used as an indication.
> >
>
> Maybe the error code returned from mount gives a hint. Also, how about
> /proc/filesystems ?
>
> Guenter
>
> > Jeff
> >
> >
> >
> >
> >
> > On Thu, Jul 14, 2022 at 5:35 PM Jeff Xu <jeffxu@google.com> wrote:
> > >
> > > > On Thu, Jul 14, 2022 at 11:37 AM Jeff Xu <jeffxu@google.com> wrote:
> > > > >
> > > > > > > > Hmm, well, it is not related to Yama then. Could it be link=
ed to other
> > > > > > > > Chromium OS non-upstream patches?
> > > > > > >
> > > > > > >
> > > > > > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS=
 is not
> > > > > > > enabled in chromeOS.
> > > > > > > If there is a reliable way of detecting OVERLAYFS (checking m=
ount
> > > > > > > overlayfs is successful ? ), this is a good candidate to add =
SKIP.
> > > > > > >
> > > > >
> > > > > > IS_ENABLED(CONFIG_OVERLAY_FS) ?
> > > > >
> > > > > Could be. Landlock selftest currently is a user space program tho=
ugh,
> > > > > IS_ENABLED will depend on the kernel header during compile time.
> > > > >
> > >
> > >
> > > > Ah, sorry, I thought it was an in-kernel test. Userspace should be
> > > > able to determine if overlayfs is supported by checking /sys/fs/ or
> > > > possibly /proc/fs/.
> > >
> > > Thanks for clarifying.
> > >
> > > lsmod might be the one, such as:
> > > lsmod | grep overlayfs
> > >
> > >
> > > Thanks
> > > Jeff
> > >
> > >
> > >
> > > On Thu, Jul 14, 2022 at 1:40 PM Guenter Roeck <groeck@google.com> wro=
te:
> > > >
> > > > On Thu, Jul 14, 2022 at 11:37 AM Jeff Xu <jeffxu@google.com> wrote:
> > > > >
> > > > > > > > Hmm, well, it is not related to Yama then. Could it be link=
ed to other
> > > > > > > > Chromium OS non-upstream patches?
> > > > > > >
> > > > > > >
> > > > > > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS=
 is not
> > > > > > > enabled in chromeOS.
> > > > > > > If there is a reliable way of detecting OVERLAYFS (checking m=
ount
> > > > > > > overlayfs is successful ? ), this is a good candidate to add =
SKIP.
> > > > > > >
> > > > >
> > > > > > IS_ENABLED(CONFIG_OVERLAY_FS) ?
> > > > >
> > > > > Could be. Landlock selftest currently is a user space program tho=
ugh,
> > > > > IS_ENABLED will depend on the kernel header during compile time.
> > > > >
> > > >
> > > > Ah, sorry, I thought it was an in-kernel test. Userspace should be
> > > > able to determine if overlayfs is supported by checking /sys/fs/ or
> > > > possibly /proc/fs/.
> > > >
> > > > Guenter
> > > >
> > > > >
> > > > > On Wed, Jul 13, 2022 at 5:30 PM Guenter Roeck <groeck@google.com>=
 wrote:
> > > > > >
> > > > > > On Wed, Jul 13, 2022 at 4:44 PM Jeff Xu <jeffxu@google.com> wro=
te:
> > > > > > >
> > > > > > > > > a correction:
> > > > > > > > >
> > > > > > > > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > >     case 0 - classic ptrace permissions: a process can PT=
RACE_ATTACH to
> > > > > > > > >     any other
> > > > > > > > >          process running under the same uid, as long as i=
t is dumpable (i.e.
> > > > > > > > >          did not transition uids, start privileged, or ha=
ve called
> > > > > > > > >          prctl(PR_SET_DUMPABLE...) already). Similarly, P=
TRACE_TRACEME is
> > > > > > > > >          unchanged.
> > > > > > > > >
> > > > > > > > >     Test: All passing
> > > > > > > > >
> > > > > > > > > // Base_test: 7/7 pass.
> > > > > > > > > // Fs_test 46/48 pass
> > > > > > > > > //.   not ok 47 layout2_overlay.no_restriction
> > > > > > > > > //.   not ok 48 layout2_overlay.same_content_different_fi=
le
> > > > > > > > > //  Ptrace 8/8 pass
> > > > > > >
> > > > > > >
> > > > > > > > Hmm, well, it is not related to Yama then. Could it be link=
ed to other
> > > > > > > > Chromium OS non-upstream patches?
> > > > > > >
> > > > > > >
> > > > > > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS=
 is not
> > > > > > > enabled in chromeOS.
> > > > > > > If there is a reliable way of detecting OVERLAYFS (checking m=
ount
> > > > > > > overlayfs is successful ? ), this is a good candidate to add =
SKIP.
> > > > > > >
> > > > > >
> > > > > > IS_ENABLED(CONFIG_OVERLAY_FS) ?
> > > > > >
> > > > > > > Overall, all the failure of landlock selftest seen in chromeO=
S are
> > > > > > > expected, we just need to modify the test.
> > > > > > >
> > > > > > > Thanks
> > > > > > > Best Regards
> > > > > > > Jeff
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > On Thu, Jul 7, 2022 at 7:25 AM Micka=C3=ABl Sala=C3=BCn <mic@=
digikod.net> wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > On 07/07/2022 01:35, Jeff Xu wrote:
> > > > > > > > > a correction:
> > > > > > > > >
> > > > > > > > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > >     case 0 - classic ptrace permissions: a process can PT=
RACE_ATTACH to
> > > > > > > > >     any other
> > > > > > > > >          process running under the same uid, as long as i=
t is dumpable (i.e.
> > > > > > > > >          did not transition uids, start privileged, or ha=
ve called
> > > > > > > > >          prctl(PR_SET_DUMPABLE...) already). Similarly, P=
TRACE_TRACEME is
> > > > > > > > >          unchanged.
> > > > > > > > >
> > > > > > > > >     Test: All passing
> > > > > > > > >
> > > > > > > > > // Base_test: 7/7 pass.
> > > > > > > > > // Fs_test 46/48 pass
> > > > > > > > > //.   not ok 47 layout2_overlay.no_restriction
> > > > > > > > > //.   not ok 48 layout2_overlay.same_content_different_fi=
le
> > > > > > > > > //  Ptrace 8/8 pass
> > > > > > > >
> > > > > > > > Hmm, well, it is not related to Yama then. Could it be link=
ed to other
> > > > > > > > Chromium OS non-upstream patches?
