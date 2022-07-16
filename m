Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7F2C433EF
	for <linux-security-module@archiver.kernel.org>; Sat, 16 Jul 2022 21:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiGPVqH (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 16 Jul 2022 17:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGPVqG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 16 Jul 2022 17:46:06 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ECA11807
        for <linux-security-module@vger.kernel.org>; Sat, 16 Jul 2022 14:46:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r6so10573496edd.7
        for <linux-security-module@vger.kernel.org>; Sat, 16 Jul 2022 14:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8PGo7+bii2YO5Uv7v6GtJpQABgxWDsiDvy1IpTKATDo=;
        b=gtf6RINio+LFN17qX2HTIP1cQFYmZIjpJazMdXgUzWigrdU2BGNFASEgKWLJ78EGuk
         TqZkVihso1Wnv502abHGapD48JTPUkZGpGTdHCqsG0KphB+IFs3V6d6oX3Z6HRsoxX/H
         ET/LLtbk/WSpvydRX64aK1YxSzpe0a96kbqmgO/wVtqAJyk92paN2cZJVS7qUhiaG7Vq
         1V0ABmuw+1BfdWOX2SJ+U6m6o/SfBtgIRu6KxBeRxnj3+Mm2HXYi2sad8a+fgBvWfm/m
         OqVyxnh8ZVILhjhitKegjM0QkKYv68BbwuimeQvQt/irQQZND580diCo5RpQ6Ycm65pe
         3BFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8PGo7+bii2YO5Uv7v6GtJpQABgxWDsiDvy1IpTKATDo=;
        b=xpehI+oTnQ7FlgJb7slZXaot50IsXb35RsjBPQJBZDVLNo1PPK//VtrrwTM47Nn27R
         4IlQGU14XgP8tsnbvn2a1EsaOXfxQdtiJBjlsy8k2j1TryBgPdMv7zFR/oPHoyCNyOJ2
         uebQ0Y3Z8Ho0pXyjSYNIbalcqfQFaDD+y8QFQNpYVe0Gkmg+HcO+gELdJuGreiUy4eTh
         ruOn2XRpHX1GogF0pY/TK/C1+Wvm2u9NhFCFyHCrUQRrWrPbRS1WYzuwcacAeYA+smr8
         HnG7W6xcj5J+j6a81p3zEXnVuav1E3aVC3Bh2KmcAcCp/9caeV8mprN36M6SO6DKLKYE
         iAuA==
X-Gm-Message-State: AJIora/QddYZ3M3E8M6J+hP1Eq/0nbktF3CLZ5wxZ7RsqDbkPx0iHcrd
        QJpQ0TgYNd/QjtypdWqwSyAfJztk3l2EfI5+AJUFqg==
X-Google-Smtp-Source: AGRyM1uHB4Lr/OtZh7uMWwCKxhmlD1d8SRYUzeWDQc03vba1bzgiN5l4zlrBzu+gCevlejVXmkifQqgERDsGOs2TboM=
X-Received: by 2002:a05:6402:4252:b0:43a:9232:dafc with SMTP id
 g18-20020a056402425200b0043a9232dafcmr27521194edb.243.1658007961510; Sat, 16
 Jul 2022 14:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220628222941.2642917-1-jeffxu@google.com> <06847585-8712-5f0c-b7e4-e32745576e16@digikod.net>
 <CALmYWFtn97HpsTK02Sn7riD7yJ3zdbGob+Yz8PHa_Yx0tgfchQ@mail.gmail.com>
 <CALmYWFvcSn_wks0bXo3_DUyYGtVW_MHrrO1dRoYcxY4uiB1KEA@mail.gmail.com>
 <0abdd920-b5cc-2fa9-7494-104c9c67480d@digikod.net> <CALmYWFvfRFfZbk=9P-=RNtjhXoR0ToQKnVVEZwmXB9yxLEHotg@mail.gmail.com>
 <CABXOdTf=o1zSSDUPNubHxAnF=1dOwOuxKfrViPHAD-tV_4x=Ww@mail.gmail.com>
 <CALmYWFvfDcJCUDCLhrDPdvyY6fH_2diQbbo8ejq3Xvu6E8_2rA@mail.gmail.com>
 <CABXOdTcQOrat3vGCm3nw_ufYKcrQ1gqVdvbUSEUehfhZ7gAW4g@mail.gmail.com>
 <CALmYWFu-c7HvfqB=JpX-iN8QUfEwwZpQRpwncebJ8R8urvvCUQ@mail.gmail.com>
 <CALmYWFtrMdTY9HTWzG=MctUcsKQZVExHWu7+3C58hncazH5+5w@mail.gmail.com>
 <CABXOdTcZM-RomzrCZQkzexCSS7RTFf_Mz+kCghqEK_icd9W3LQ@mail.gmail.com> <CALmYWFtstvRVZOYCJBwrhayGJDc-=c8avuD0wWm6LURu8EKG2g@mail.gmail.com>
In-Reply-To: <CALmYWFtstvRVZOYCJBwrhayGJDc-=c8avuD0wWm6LURu8EKG2g@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Sat, 16 Jul 2022 14:45:50 -0700
Message-ID: <CABXOdTdzHu6CkNvOLvFoxH13MBo=r+TCr56xJsK3oXCbuOp4NA@mail.gmail.com>
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

On Fri, Jul 15, 2022 at 5:17 PM Jeff Xu <jeffxu@google.com> wrote:
>
> > Maybe the error code returned from mount gives a hint.
>
> It returns -1
>
Sorry, I meant errno, not the return value.

> >
> > Also, how about
> > /proc/filesystems ?
>
> Yes. it has what I want:
> nodev overlay
>
Excellent.

Guenter

> Thanks for your help! I can use this at runtime check.
>
> Jeff
>
>
> On Fri, Jul 15, 2022 at 3:42 PM Guenter Roeck <groeck@google.com> wrote:
> >
> > On Fri, Jul 15, 2022 at 2:42 PM Jeff Xu <jeffxu@google.com> wrote:
> > >
> > > Jeff Xu <jeffxu@google.com>
> > >
> > > > Jul 14, 2022, 5:35 PM (20 hours ago)
> > > > to Guenter, Micka=C3=ABl, linux-security-module, Jorge, Guenter, Ke=
es
> > > > > On Thu, Jul 14, 2022 at 11:37 AM Jeff Xu <jeffxu@google.com> wrot=
e:
> > > > > >
> > > > > > > > > Hmm, well, it is not related to Yama then. Could it be li=
nked to other
> > > > > > > > > Chromium OS non-upstream patches?
> > > > > > > >
> > > > > > > >
> > > > > > > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAY=
FS is not
> > > > > > > > enabled in chromeOS.
> > > > > > > > If there is a reliable way of detecting OVERLAYFS (checking=
 mount
> > > > > > > > overlayfs is successful ? ), this is a good candidate to ad=
d SKIP.
> > > > > > > >
> > > > > >
> > > > > > > IS_ENABLED(CONFIG_OVERLAY_FS) ?
> > > > > >
> > > > > > Could be. Landlock selftest currently is a user space program t=
hough,
> > > > > > IS_ENABLED will depend on the kernel header during compile time=
.
> > > > > >
> > >
> > >
> > >
> > > > > Ah, sorry, I thought it was an in-kernel test. Userspace should b=
e
> > > > > able to determine if overlayfs is supported by checking /sys/fs/ =
or
> > > > > possibly /proc/fs/.
> > >
> > >
> > > > Thanks for clarifying.
> > >
> > >
> > > > lsmod might be the one, such as:
> > > > lsmod | grep overlayfs
> > >
> > >
> > > I built a kernel with overlayfs on chromeos, and lsmod didn't give me
> > > what I wanted.
> > > /sys/fs and /proc/fs also doesn't show anything about overlayfs
> > >
> > > @Micka=C3=ABl Sala=C3=BCn
> > > Are you OK with SKIP the overlay test when mount("overlay",...) fails
> > > in FIXTURE_SETUP() ? Mount failure can be used as an indication.
> > >
> >
> > Maybe the error code returned from mount gives a hint. Also, how about
> > /proc/filesystems ?
> >
> > Guenter
> >
> > > Jeff
> > >
> > >
> > >
> > >
> > >
> > > On Thu, Jul 14, 2022 at 5:35 PM Jeff Xu <jeffxu@google.com> wrote:
> > > >
> > > > > On Thu, Jul 14, 2022 at 11:37 AM Jeff Xu <jeffxu@google.com> wrot=
e:
> > > > > >
> > > > > > > > > Hmm, well, it is not related to Yama then. Could it be li=
nked to other
> > > > > > > > > Chromium OS non-upstream patches?
> > > > > > > >
> > > > > > > >
> > > > > > > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAY=
FS is not
> > > > > > > > enabled in chromeOS.
> > > > > > > > If there is a reliable way of detecting OVERLAYFS (checking=
 mount
> > > > > > > > overlayfs is successful ? ), this is a good candidate to ad=
d SKIP.
> > > > > > > >
> > > > > >
> > > > > > > IS_ENABLED(CONFIG_OVERLAY_FS) ?
> > > > > >
> > > > > > Could be. Landlock selftest currently is a user space program t=
hough,
> > > > > > IS_ENABLED will depend on the kernel header during compile time=
.
> > > > > >
> > > >
> > > >
> > > > > Ah, sorry, I thought it was an in-kernel test. Userspace should b=
e
> > > > > able to determine if overlayfs is supported by checking /sys/fs/ =
or
> > > > > possibly /proc/fs/.
> > > >
> > > > Thanks for clarifying.
> > > >
> > > > lsmod might be the one, such as:
> > > > lsmod | grep overlayfs
> > > >
> > > >
> > > > Thanks
> > > > Jeff
> > > >
> > > >
> > > >
> > > > On Thu, Jul 14, 2022 at 1:40 PM Guenter Roeck <groeck@google.com> w=
rote:
> > > > >
> > > > > On Thu, Jul 14, 2022 at 11:37 AM Jeff Xu <jeffxu@google.com> wrot=
e:
> > > > > >
> > > > > > > > > Hmm, well, it is not related to Yama then. Could it be li=
nked to other
> > > > > > > > > Chromium OS non-upstream patches?
> > > > > > > >
> > > > > > > >
> > > > > > > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAY=
FS is not
> > > > > > > > enabled in chromeOS.
> > > > > > > > If there is a reliable way of detecting OVERLAYFS (checking=
 mount
> > > > > > > > overlayfs is successful ? ), this is a good candidate to ad=
d SKIP.
> > > > > > > >
> > > > > >
> > > > > > > IS_ENABLED(CONFIG_OVERLAY_FS) ?
> > > > > >
> > > > > > Could be. Landlock selftest currently is a user space program t=
hough,
> > > > > > IS_ENABLED will depend on the kernel header during compile time=
.
> > > > > >
> > > > >
> > > > > Ah, sorry, I thought it was an in-kernel test. Userspace should b=
e
> > > > > able to determine if overlayfs is supported by checking /sys/fs/ =
or
> > > > > possibly /proc/fs/.
> > > > >
> > > > > Guenter
> > > > >
> > > > > >
> > > > > > On Wed, Jul 13, 2022 at 5:30 PM Guenter Roeck <groeck@google.co=
m> wrote:
> > > > > > >
> > > > > > > On Wed, Jul 13, 2022 at 4:44 PM Jeff Xu <jeffxu@google.com> w=
rote:
> > > > > > > >
> > > > > > > > > > a correction:
> > > > > > > > > >
> > > > > > > > > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > >     case 0 - classic ptrace permissions: a process can =
PTRACE_ATTACH to
> > > > > > > > > >     any other
> > > > > > > > > >          process running under the same uid, as long as=
 it is dumpable (i.e.
> > > > > > > > > >          did not transition uids, start privileged, or =
have called
> > > > > > > > > >          prctl(PR_SET_DUMPABLE...) already). Similarly,=
 PTRACE_TRACEME is
> > > > > > > > > >          unchanged.
> > > > > > > > > >
> > > > > > > > > >     Test: All passing
> > > > > > > > > >
> > > > > > > > > > // Base_test: 7/7 pass.
> > > > > > > > > > // Fs_test 46/48 pass
> > > > > > > > > > //.   not ok 47 layout2_overlay.no_restriction
> > > > > > > > > > //.   not ok 48 layout2_overlay.same_content_different_=
file
> > > > > > > > > > //  Ptrace 8/8 pass
> > > > > > > >
> > > > > > > >
> > > > > > > > > Hmm, well, it is not related to Yama then. Could it be li=
nked to other
> > > > > > > > > Chromium OS non-upstream patches?
> > > > > > > >
> > > > > > > >
> > > > > > > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAY=
FS is not
> > > > > > > > enabled in chromeOS.
> > > > > > > > If there is a reliable way of detecting OVERLAYFS (checking=
 mount
> > > > > > > > overlayfs is successful ? ), this is a good candidate to ad=
d SKIP.
> > > > > > > >
> > > > > > >
> > > > > > > IS_ENABLED(CONFIG_OVERLAY_FS) ?
> > > > > > >
> > > > > > > > Overall, all the failure of landlock selftest seen in chrom=
eOS are
> > > > > > > > expected, we just need to modify the test.
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > > Best Regards
> > > > > > > > Jeff
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > On Thu, Jul 7, 2022 at 7:25 AM Micka=C3=ABl Sala=C3=BCn <mi=
c@digikod.net> wrote:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > On 07/07/2022 01:35, Jeff Xu wrote:
> > > > > > > > > > a correction:
> > > > > > > > > >
> > > > > > > > > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > >     case 0 - classic ptrace permissions: a process can =
PTRACE_ATTACH to
> > > > > > > > > >     any other
> > > > > > > > > >          process running under the same uid, as long as=
 it is dumpable (i.e.
> > > > > > > > > >          did not transition uids, start privileged, or =
have called
> > > > > > > > > >          prctl(PR_SET_DUMPABLE...) already). Similarly,=
 PTRACE_TRACEME is
> > > > > > > > > >          unchanged.
> > > > > > > > > >
> > > > > > > > > >     Test: All passing
> > > > > > > > > >
> > > > > > > > > > // Base_test: 7/7 pass.
> > > > > > > > > > // Fs_test 46/48 pass
> > > > > > > > > > //.   not ok 47 layout2_overlay.no_restriction
> > > > > > > > > > //.   not ok 48 layout2_overlay.same_content_different_=
file
> > > > > > > > > > //  Ptrace 8/8 pass
> > > > > > > > >
> > > > > > > > > Hmm, well, it is not related to Yama then. Could it be li=
nked to other
> > > > > > > > > Chromium OS non-upstream patches?
