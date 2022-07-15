Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A084C43334
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Jul 2022 21:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiGOVmi (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 15 Jul 2022 17:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiGOVma (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Jul 2022 17:42:30 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770F888F0A
        for <linux-security-module@vger.kernel.org>; Fri, 15 Jul 2022 14:42:29 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 89-20020a17090a09e200b001ef7638e536so12698635pjo.3
        for <linux-security-module@vger.kernel.org>; Fri, 15 Jul 2022 14:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z23I1tEqpoBxTtT+3tem3+bkmbXjJvb4uTG3YM/Kotc=;
        b=fAB+baZIFd4NZ6pQ7nt/xu/1oUJp4awRXAVvA0Hmz6FbDjokpKiMl85NWHia859+L3
         llchqwE2GDEDPPj11AmPkhCFl7QYxq4o0qP+uTa8sko0hjUvB/6c4SA8XnQcLybM8pUB
         +F3pJhaJPt3fyFANVFUGuCAtreLdyt0kRXT6q6DfdW27kp2Y4oBPqPRjk9q1v/P/WX7C
         GD997gtgcP6XqRlDOfj5pFRkl9+2X5jhIrV8MQmP7yhI+YCeUW2TxvuTHmRpsOHgHUzl
         qXw1mx4nggnm1T8Bcoss1mbafUK94EGXH/YihW+a3u4FN8cD00F0Fz5ztrCxD2H2wjIb
         RhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z23I1tEqpoBxTtT+3tem3+bkmbXjJvb4uTG3YM/Kotc=;
        b=KnzanouUkddbdZQjbW96DE/zkVuDD0/ve8g5alr++SodHA1n+sgL9FbntOojK21z7d
         h7fkMVEXgwkf9UPbZVnaBHB3bYMZV8XPAfV1FAM/a59lTykoi4ny3LMCKEWLn39No9FE
         R90hS6qBAmC1ox48y+/75G0CMQ+ypCOIqyJUKPMe7rgfNtB8UVhVPi5tc1NMJvU/Mtj+
         Nulu+MH1bdHw3Hbb5oMMaMVNdXMBuM6nFHfCp0L1cMRmUv8DEz25CU11OFKOHqyfLuhE
         yYxZI1Auc30Vx4I37qt2nQ/Ye/Ft96IbbDiKQJQ9DpJ0Ef6vg8Yu7sh4MDBb3eV+EUhy
         3z/Q==
X-Gm-Message-State: AJIora9vb5XyX2iQGjtiP5HHCuwUUxvXVMwsZTSX2PLUNxf3ZZPlLjtK
        BLzaBFvxFFaTklAAqIRQfdWsBsjF7gg+lKdMD5zFpA==
X-Google-Smtp-Source: AGRyM1sEGOGpq9IwmHDK9YGlFG4nBjBNjPMfH4mrAG7rM77CKRThYrP+mdXb8Vz56HcJZYqi3OMJxLSAmpLfUzHPzbk=
X-Received: by 2002:a17:903:2284:b0:16c:500f:b791 with SMTP id
 b4-20020a170903228400b0016c500fb791mr15269423plh.78.1657921348666; Fri, 15
 Jul 2022 14:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220628222941.2642917-1-jeffxu@google.com> <06847585-8712-5f0c-b7e4-e32745576e16@digikod.net>
 <CALmYWFtn97HpsTK02Sn7riD7yJ3zdbGob+Yz8PHa_Yx0tgfchQ@mail.gmail.com>
 <CALmYWFvcSn_wks0bXo3_DUyYGtVW_MHrrO1dRoYcxY4uiB1KEA@mail.gmail.com>
 <0abdd920-b5cc-2fa9-7494-104c9c67480d@digikod.net> <CALmYWFvfRFfZbk=9P-=RNtjhXoR0ToQKnVVEZwmXB9yxLEHotg@mail.gmail.com>
 <CABXOdTf=o1zSSDUPNubHxAnF=1dOwOuxKfrViPHAD-tV_4x=Ww@mail.gmail.com>
 <CALmYWFvfDcJCUDCLhrDPdvyY6fH_2diQbbo8ejq3Xvu6E8_2rA@mail.gmail.com>
 <CABXOdTcQOrat3vGCm3nw_ufYKcrQ1gqVdvbUSEUehfhZ7gAW4g@mail.gmail.com> <CALmYWFu-c7HvfqB=JpX-iN8QUfEwwZpQRpwncebJ8R8urvvCUQ@mail.gmail.com>
In-Reply-To: <CALmYWFu-c7HvfqB=JpX-iN8QUfEwwZpQRpwncebJ8R8urvvCUQ@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Fri, 15 Jul 2022 14:41:52 -0700
Message-ID: <CALmYWFtrMdTY9HTWzG=MctUcsKQZVExHWu7+3C58hncazH5+5w@mail.gmail.com>
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

Jeff Xu <jeffxu@google.com>

> Jul 14, 2022, 5:35 PM (20 hours ago)
> to Guenter, Micka=C3=ABl, linux-security-module, Jorge, Guenter, Kees
> > On Thu, Jul 14, 2022 at 11:37 AM Jeff Xu <jeffxu@google.com> wrote:
> > >
> > > > > > Hmm, well, it is not related to Yama then. Could it be linked t=
o other
> > > > > > Chromium OS non-upstream patches?
> > > > >
> > > > >
> > > > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS is =
not
> > > > > enabled in chromeOS.
> > > > > If there is a reliable way of detecting OVERLAYFS (checking mount
> > > > > overlayfs is successful ? ), this is a good candidate to add SKIP=
.
> > > > >
> > >
> > > > IS_ENABLED(CONFIG_OVERLAY_FS) ?
> > >
> > > Could be. Landlock selftest currently is a user space program though,
> > > IS_ENABLED will depend on the kernel header during compile time.
> > >



> > Ah, sorry, I thought it was an in-kernel test. Userspace should be
> > able to determine if overlayfs is supported by checking /sys/fs/ or
> > possibly /proc/fs/.


> Thanks for clarifying.


> lsmod might be the one, such as:
> lsmod | grep overlayfs


I built a kernel with overlayfs on chromeos, and lsmod didn't give me
what I wanted.
/sys/fs and /proc/fs also doesn't show anything about overlayfs

@Micka=C3=ABl Sala=C3=BCn
Are you OK with SKIP the overlay test when mount("overlay",...) fails
in FIXTURE_SETUP() ? Mount failure can be used as an indication.

Jeff





On Thu, Jul 14, 2022 at 5:35 PM Jeff Xu <jeffxu@google.com> wrote:
>
> > On Thu, Jul 14, 2022 at 11:37 AM Jeff Xu <jeffxu@google.com> wrote:
> > >
> > > > > > Hmm, well, it is not related to Yama then. Could it be linked t=
o other
> > > > > > Chromium OS non-upstream patches?
> > > > >
> > > > >
> > > > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS is =
not
> > > > > enabled in chromeOS.
> > > > > If there is a reliable way of detecting OVERLAYFS (checking mount
> > > > > overlayfs is successful ? ), this is a good candidate to add SKIP=
.
> > > > >
> > >
> > > > IS_ENABLED(CONFIG_OVERLAY_FS) ?
> > >
> > > Could be. Landlock selftest currently is a user space program though,
> > > IS_ENABLED will depend on the kernel header during compile time.
> > >
>
>
> > Ah, sorry, I thought it was an in-kernel test. Userspace should be
> > able to determine if overlayfs is supported by checking /sys/fs/ or
> > possibly /proc/fs/.
>
> Thanks for clarifying.
>
> lsmod might be the one, such as:
> lsmod | grep overlayfs
>
>
> Thanks
> Jeff
>
>
>
> On Thu, Jul 14, 2022 at 1:40 PM Guenter Roeck <groeck@google.com> wrote:
> >
> > On Thu, Jul 14, 2022 at 11:37 AM Jeff Xu <jeffxu@google.com> wrote:
> > >
> > > > > > Hmm, well, it is not related to Yama then. Could it be linked t=
o other
> > > > > > Chromium OS non-upstream patches?
> > > > >
> > > > >
> > > > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS is =
not
> > > > > enabled in chromeOS.
> > > > > If there is a reliable way of detecting OVERLAYFS (checking mount
> > > > > overlayfs is successful ? ), this is a good candidate to add SKIP=
.
> > > > >
> > >
> > > > IS_ENABLED(CONFIG_OVERLAY_FS) ?
> > >
> > > Could be. Landlock selftest currently is a user space program though,
> > > IS_ENABLED will depend on the kernel header during compile time.
> > >
> >
> > Ah, sorry, I thought it was an in-kernel test. Userspace should be
> > able to determine if overlayfs is supported by checking /sys/fs/ or
> > possibly /proc/fs/.
> >
> > Guenter
> >
> > >
> > > On Wed, Jul 13, 2022 at 5:30 PM Guenter Roeck <groeck@google.com> wro=
te:
> > > >
> > > > On Wed, Jul 13, 2022 at 4:44 PM Jeff Xu <jeffxu@google.com> wrote:
> > > > >
> > > > > > > a correction:
> > > > > > >
> > > > > > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > >     case 0 - classic ptrace permissions: a process can PTRACE=
_ATTACH to
> > > > > > >     any other
> > > > > > >          process running under the same uid, as long as it is=
 dumpable (i.e.
> > > > > > >          did not transition uids, start privileged, or have c=
alled
> > > > > > >          prctl(PR_SET_DUMPABLE...) already). Similarly, PTRAC=
E_TRACEME is
> > > > > > >          unchanged.
> > > > > > >
> > > > > > >     Test: All passing
> > > > > > >
> > > > > > > // Base_test: 7/7 pass.
> > > > > > > // Fs_test 46/48 pass
> > > > > > > //.   not ok 47 layout2_overlay.no_restriction
> > > > > > > //.   not ok 48 layout2_overlay.same_content_different_file
> > > > > > > //  Ptrace 8/8 pass
> > > > >
> > > > >
> > > > > > Hmm, well, it is not related to Yama then. Could it be linked t=
o other
> > > > > > Chromium OS non-upstream patches?
> > > > >
> > > > >
> > > > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS is =
not
> > > > > enabled in chromeOS.
> > > > > If there is a reliable way of detecting OVERLAYFS (checking mount
> > > > > overlayfs is successful ? ), this is a good candidate to add SKIP=
.
> > > > >
> > > >
> > > > IS_ENABLED(CONFIG_OVERLAY_FS) ?
> > > >
> > > > > Overall, all the failure of landlock selftest seen in chromeOS ar=
e
> > > > > expected, we just need to modify the test.
> > > > >
> > > > > Thanks
> > > > > Best Regards
> > > > > Jeff
> > > > >
> > > > >
> > > > >
> > > > > On Thu, Jul 7, 2022 at 7:25 AM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> > > > > >
> > > > > >
> > > > > > On 07/07/2022 01:35, Jeff Xu wrote:
> > > > > > > a correction:
> > > > > > >
> > > > > > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > >     case 0 - classic ptrace permissions: a process can PTRACE=
_ATTACH to
> > > > > > >     any other
> > > > > > >          process running under the same uid, as long as it is=
 dumpable (i.e.
> > > > > > >          did not transition uids, start privileged, or have c=
alled
> > > > > > >          prctl(PR_SET_DUMPABLE...) already). Similarly, PTRAC=
E_TRACEME is
> > > > > > >          unchanged.
> > > > > > >
> > > > > > >     Test: All passing
> > > > > > >
> > > > > > > // Base_test: 7/7 pass.
> > > > > > > // Fs_test 46/48 pass
> > > > > > > //.   not ok 47 layout2_overlay.no_restriction
> > > > > > > //.   not ok 48 layout2_overlay.same_content_different_file
> > > > > > > //  Ptrace 8/8 pass
> > > > > >
> > > > > > Hmm, well, it is not related to Yama then. Could it be linked t=
o other
> > > > > > Chromium OS non-upstream patches?
