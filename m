Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B2DC43334
	for <linux-security-module@archiver.kernel.org>; Fri, 15 Jul 2022 00:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiGOAgV (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 14 Jul 2022 20:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGOAgV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Jul 2022 20:36:21 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA6D2C666
        for <linux-security-module@vger.kernel.org>; Thu, 14 Jul 2022 17:36:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bu42so5512552lfb.0
        for <linux-security-module@vger.kernel.org>; Thu, 14 Jul 2022 17:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Oa/ph1y1NCSm+ZhjuY07JP+CyN/tDsFemx5N9OyKgDQ=;
        b=rSOeaA9GTeVXjRCyg9vvonQCiBsFz2+Eyv8tBlUQVyMNyGvun3rTxoJaC68U61Gw2z
         ENSjbkFfzVVPjRBf502lWcoPoJiiiLP34hdT7Br8DjB1XfcPNPX2tpi84Lvd77XN3Sb5
         yCXZHE0Hc3lLpNah2rFzwAvyDPqkfUo9GX7Qxvr5n4+0TnuRK+f0VL3t0uDYQIFGCK4V
         ImbqZne/gYgk0IKgNLvgNMl2ND78FTrfQOhalEGWDr++s/+IijXu3N2q9DLJWYyMyL9R
         /XFmZcTmAZ0JaW7DNGWraPWidLCkmfvoiQhlEwIkS4wpXfh80bHK3qq0U89KHfSL6Ws5
         jZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Oa/ph1y1NCSm+ZhjuY07JP+CyN/tDsFemx5N9OyKgDQ=;
        b=LfQY2RmqPStMF3fUcvHalgewcbPCg5Snam0LU3jhh1t9aYBro57fvLSPAO0IDQoTj4
         vYZm+hpmQ5mTyF/i/YYTZVrsyMAPH3Xn+hkxZz7tK0CoLNPIc0qMa38mwjvLNn9I4NQc
         +mA0WQ0LhqW/R6lUi4vgr73ahcE55dthfAF7OVXbNYX4wv2gI641U+BH0HYAKaIgMGHK
         JOO/CYLj6kq2IRxdtTgRu5KBos2XxIGYTNWm3YCZvHgIoWT96epZcYkZADayTsFFP8XP
         e1STI7U2CfSZj/LT6XIv82oRDI8ZAhN5Bw2Sf1eO77guC9mrMQ9uTp5Vpx1tTUZXPgZo
         f0wg==
X-Gm-Message-State: AJIora/ljKBxI4i03IjmBPjGOcISpeDaWonp7of88FST8cVuyFJjGAxa
        liaJazDPvuAein8c4zkHaJuisJkfNiqTsWkCxWAj7A==
X-Google-Smtp-Source: AGRyM1tkvkqmdtrPwwHerNjnGxSrjGpyTwUum0/22hF5b6xl+QQu8vAxei5U5kcUj+duZF85GMcY7FtfIQFxtHIfNv4=
X-Received: by 2002:a05:6512:3b29:b0:489:f0ad:1d18 with SMTP id
 f41-20020a0565123b2900b00489f0ad1d18mr6722722lfv.3.1657845377496; Thu, 14 Jul
 2022 17:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220628222941.2642917-1-jeffxu@google.com> <06847585-8712-5f0c-b7e4-e32745576e16@digikod.net>
 <CALmYWFtn97HpsTK02Sn7riD7yJ3zdbGob+Yz8PHa_Yx0tgfchQ@mail.gmail.com>
 <CALmYWFvcSn_wks0bXo3_DUyYGtVW_MHrrO1dRoYcxY4uiB1KEA@mail.gmail.com>
 <0abdd920-b5cc-2fa9-7494-104c9c67480d@digikod.net> <CALmYWFvfRFfZbk=9P-=RNtjhXoR0ToQKnVVEZwmXB9yxLEHotg@mail.gmail.com>
 <CABXOdTf=o1zSSDUPNubHxAnF=1dOwOuxKfrViPHAD-tV_4x=Ww@mail.gmail.com>
 <CALmYWFvfDcJCUDCLhrDPdvyY6fH_2diQbbo8ejq3Xvu6E8_2rA@mail.gmail.com> <CABXOdTcQOrat3vGCm3nw_ufYKcrQ1gqVdvbUSEUehfhZ7gAW4g@mail.gmail.com>
In-Reply-To: <CABXOdTcQOrat3vGCm3nw_ufYKcrQ1gqVdvbUSEUehfhZ7gAW4g@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Thu, 14 Jul 2022 17:35:41 -0700
Message-ID: <CALmYWFu-c7HvfqB=JpX-iN8QUfEwwZpQRpwncebJ8R8urvvCUQ@mail.gmail.com>
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

> On Thu, Jul 14, 2022 at 11:37 AM Jeff Xu <jeffxu@google.com> wrote:
> >
> > > > > Hmm, well, it is not related to Yama then. Could it be linked to =
other
> > > > > Chromium OS non-upstream patches?
> > > >
> > > >
> > > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS is no=
t
> > > > enabled in chromeOS.
> > > > If there is a reliable way of detecting OVERLAYFS (checking mount
> > > > overlayfs is successful ? ), this is a good candidate to add SKIP.
> > > >
> >
> > > IS_ENABLED(CONFIG_OVERLAY_FS) ?
> >
> > Could be. Landlock selftest currently is a user space program though,
> > IS_ENABLED will depend on the kernel header during compile time.
> >


> Ah, sorry, I thought it was an in-kernel test. Userspace should be
> able to determine if overlayfs is supported by checking /sys/fs/ or
> possibly /proc/fs/.

Thanks for clarifying.

lsmod might be the one, such as:
lsmod | grep overlayfs


Thanks
Jeff



On Thu, Jul 14, 2022 at 1:40 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Thu, Jul 14, 2022 at 11:37 AM Jeff Xu <jeffxu@google.com> wrote:
> >
> > > > > Hmm, well, it is not related to Yama then. Could it be linked to =
other
> > > > > Chromium OS non-upstream patches?
> > > >
> > > >
> > > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS is no=
t
> > > > enabled in chromeOS.
> > > > If there is a reliable way of detecting OVERLAYFS (checking mount
> > > > overlayfs is successful ? ), this is a good candidate to add SKIP.
> > > >
> >
> > > IS_ENABLED(CONFIG_OVERLAY_FS) ?
> >
> > Could be. Landlock selftest currently is a user space program though,
> > IS_ENABLED will depend on the kernel header during compile time.
> >
>
> Ah, sorry, I thought it was an in-kernel test. Userspace should be
> able to determine if overlayfs is supported by checking /sys/fs/ or
> possibly /proc/fs/.
>
> Guenter
>
> >
> > On Wed, Jul 13, 2022 at 5:30 PM Guenter Roeck <groeck@google.com> wrote=
:
> > >
> > > On Wed, Jul 13, 2022 at 4:44 PM Jeff Xu <jeffxu@google.com> wrote:
> > > >
> > > > > > a correction:
> > > > > >
> > > > > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > >     case 0 - classic ptrace permissions: a process can PTRACE_A=
TTACH to
> > > > > >     any other
> > > > > >          process running under the same uid, as long as it is d=
umpable (i.e.
> > > > > >          did not transition uids, start privileged, or have cal=
led
> > > > > >          prctl(PR_SET_DUMPABLE...) already). Similarly, PTRACE_=
TRACEME is
> > > > > >          unchanged.
> > > > > >
> > > > > >     Test: All passing
> > > > > >
> > > > > > // Base_test: 7/7 pass.
> > > > > > // Fs_test 46/48 pass
> > > > > > //.   not ok 47 layout2_overlay.no_restriction
> > > > > > //.   not ok 48 layout2_overlay.same_content_different_file
> > > > > > //  Ptrace 8/8 pass
> > > >
> > > >
> > > > > Hmm, well, it is not related to Yama then. Could it be linked to =
other
> > > > > Chromium OS non-upstream patches?
> > > >
> > > >
> > > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS is no=
t
> > > > enabled in chromeOS.
> > > > If there is a reliable way of detecting OVERLAYFS (checking mount
> > > > overlayfs is successful ? ), this is a good candidate to add SKIP.
> > > >
> > >
> > > IS_ENABLED(CONFIG_OVERLAY_FS) ?
> > >
> > > > Overall, all the failure of landlock selftest seen in chromeOS are
> > > > expected, we just need to modify the test.
> > > >
> > > > Thanks
> > > > Best Regards
> > > > Jeff
> > > >
> > > >
> > > >
> > > > On Thu, Jul 7, 2022 at 7:25 AM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> > > > >
> > > > >
> > > > > On 07/07/2022 01:35, Jeff Xu wrote:
> > > > > > a correction:
> > > > > >
> > > > > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > >     case 0 - classic ptrace permissions: a process can PTRACE_A=
TTACH to
> > > > > >     any other
> > > > > >          process running under the same uid, as long as it is d=
umpable (i.e.
> > > > > >          did not transition uids, start privileged, or have cal=
led
> > > > > >          prctl(PR_SET_DUMPABLE...) already). Similarly, PTRACE_=
TRACEME is
> > > > > >          unchanged.
> > > > > >
> > > > > >     Test: All passing
> > > > > >
> > > > > > // Base_test: 7/7 pass.
> > > > > > // Fs_test 46/48 pass
> > > > > > //.   not ok 47 layout2_overlay.no_restriction
> > > > > > //.   not ok 48 layout2_overlay.same_content_different_file
> > > > > > //  Ptrace 8/8 pass
> > > > >
> > > > > Hmm, well, it is not related to Yama then. Could it be linked to =
other
> > > > > Chromium OS non-upstream patches?
