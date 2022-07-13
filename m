Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FD6C43334
	for <linux-security-module@archiver.kernel.org>; Wed, 13 Jul 2022 23:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiGMXok (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Jul 2022 19:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiGMXoh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Jul 2022 19:44:37 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012D352DFC
        for <linux-security-module@vger.kernel.org>; Wed, 13 Jul 2022 16:44:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso597227pjj.5
        for <linux-security-module@vger.kernel.org>; Wed, 13 Jul 2022 16:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DkLczyynfYqNqbmOPaNJ7DNHFGb7fm4PXY7dj6rYjTQ=;
        b=loYuYy3MmNz6Uj1ZIA98jCbcYDXIDl09HIF11IVrvPgGq0dBLFL1FzHZ30rajZVYKj
         Gbj9CsrM6c/2bJRBnoNTG0rJJHuUYeVMbEpdP+0czlCJCXWWIzZa+H531jivzil/sOwY
         GoRaTDyXM0qgBqPnTOs+McDg8ctCpA/hKhyilae34nB3vZ1TSUMyy5UqSxDV9KooXGRK
         3bCyQXnxwLqQToKcbwm2HsaUdmZY+wr1Zkl+Ci1GqZqslYGjveHXFKj3TfM5T7lWOR1j
         DsAeIZ+l9U9uO/e2UG1s+FSyPfWNfZYd93qRDSX1H3UUGKf47KCdIvMwoPDLeiykWvtS
         4W8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DkLczyynfYqNqbmOPaNJ7DNHFGb7fm4PXY7dj6rYjTQ=;
        b=5s5ZNuMciZigdQBfJTwZl6gebkc0XgcEs8zfxwdNMxCWJKiNED8QXjIoPZJAJVzba0
         JSTOzFYks9R9a3z+vC4fhY3pg3Um51dQ8jxk1JFyI+Qn/yHz5YSctXd4NwGbxXUzkJtb
         U2x2EOaw/vJnB5RbnWCTIvMi9faRCyC3ZENMeC+Gp/WevuA+moJoJm4cSJUa1bXwbGrE
         rV/W0YhnJhwcLp/hvIgDv84FnCvG/H+/xMDZpklNprSyww0pHtoa06knfRroQpHuk3QW
         7ryR1QO58VfqAJs9gOPSXw1EUGaC6HpwrdTItDiy0Xs7iRNgu8AjeOOvjszuOhSn7jix
         5W3g==
X-Gm-Message-State: AJIora9X0dYcugMhcDW36fuehywnrSG4j3x/rMwe10ZbLgn1+hxYgd5Y
        7SxVaolylvlnQWuDpcUd/A9up4RKFPtcf4b4GYPkAA==
X-Google-Smtp-Source: AGRyM1sF0CHBSujgRPezFJtGPT9byf+jCqWPrGeecAwg3HFZ3hLEipwDkpuiYZMxog4exJ2JfLXSf/gw55p7jxc3ji4=
X-Received: by 2002:a17:90a:db96:b0:1ef:8c86:eb09 with SMTP id
 h22-20020a17090adb9600b001ef8c86eb09mr12548254pjv.22.1657755876399; Wed, 13
 Jul 2022 16:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220628222941.2642917-1-jeffxu@google.com> <06847585-8712-5f0c-b7e4-e32745576e16@digikod.net>
 <CALmYWFtn97HpsTK02Sn7riD7yJ3zdbGob+Yz8PHa_Yx0tgfchQ@mail.gmail.com>
 <CALmYWFvcSn_wks0bXo3_DUyYGtVW_MHrrO1dRoYcxY4uiB1KEA@mail.gmail.com> <0abdd920-b5cc-2fa9-7494-104c9c67480d@digikod.net>
In-Reply-To: <0abdd920-b5cc-2fa9-7494-104c9c67480d@digikod.net>
From:   Jeff Xu <jeffxu@google.com>
Date:   Wed, 13 Jul 2022 16:44:00 -0700
Message-ID: <CALmYWFvfRFfZbk=9P-=RNtjhXoR0ToQKnVVEZwmXB9yxLEHotg@mail.gmail.com>
Subject: Re: [PATCH] selftests/landlock: skip ptrace_test when YAMA is enabled
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> > a correction:
> >
> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >     case 0 - classic ptrace permissions: a process can PTRACE_ATTACH to
> >     any other
> >          process running under the same uid, as long as it is dumpable =
(i.e.
> >          did not transition uids, start privileged, or have called
> >          prctl(PR_SET_DUMPABLE...) already). Similarly, PTRACE_TRACEME =
is
> >          unchanged.
> >
> >     Test: All passing
> >
> > // Base_test: 7/7 pass.
> > // Fs_test 46/48 pass
> > //.   not ok 47 layout2_overlay.no_restriction
> > //.   not ok 48 layout2_overlay.same_content_different_file
> > //  Ptrace 8/8 pass


> Hmm, well, it is not related to Yama then. Could it be linked to other
> Chromium OS non-upstream patches?


fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS is not
enabled in chromeOS.
If there is a reliable way of detecting OVERLAYFS (checking mount
overlayfs is successful ? ), this is a good candidate to add SKIP.

Overall, all the failure of landlock selftest seen in chromeOS are
expected, we just need to modify the test.

Thanks
Best Regards
Jeff



On Thu, Jul 7, 2022 at 7:25 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> w=
rote:
>
>
> On 07/07/2022 01:35, Jeff Xu wrote:
> > a correction:
> >
> >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >     case 0 - classic ptrace permissions: a process can PTRACE_ATTACH to
> >     any other
> >          process running under the same uid, as long as it is dumpable =
(i.e.
> >          did not transition uids, start privileged, or have called
> >          prctl(PR_SET_DUMPABLE...) already). Similarly, PTRACE_TRACEME =
is
> >          unchanged.
> >
> >     Test: All passing
> >
> > // Base_test: 7/7 pass.
> > // Fs_test 46/48 pass
> > //.   not ok 47 layout2_overlay.no_restriction
> > //.   not ok 48 layout2_overlay.same_content_different_file
> > //  Ptrace 8/8 pass
>
> Hmm, well, it is not related to Yama then. Could it be linked to other
> Chromium OS non-upstream patches?
