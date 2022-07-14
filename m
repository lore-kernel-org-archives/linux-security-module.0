Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6230DC43334
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Jul 2022 00:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiGNAan (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 13 Jul 2022 20:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGNAam (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 Jul 2022 20:30:42 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497C05F6D
        for <linux-security-module@vger.kernel.org>; Wed, 13 Jul 2022 17:30:41 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e15so453954edj.2
        for <linux-security-module@vger.kernel.org>; Wed, 13 Jul 2022 17:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lG3/DfoKYyB+1bMvX+d64tmSHkJ/WWOCfRxBHwhRaQM=;
        b=pFG6rdb6Bh8kj4vwdoJ162lsvMFvGosKAIp+/I5muhEaqOFtqknRCOIa0RPfPCrEdZ
         rsnMIkB/f3QhbMDYXqDv73NJ+JU2P6RGpt+C0zVlUG2jz6dVvwtmunqSLLY1nIykPbYQ
         FC4TEMCESMUbs3NjEzBDVV3qv4mnpNExhz2by4I1a5xFFQMW82exoKCh9GeTgHESEa1O
         fl+aCyJyuzEgnZ2uUI9e6D2/DOVTtW6MkYIAwTyraF148DPJnanioEb/8EgMYH4r6xE2
         Ogf1XKqlEU6r47UmOR9Ty1WfYsERQr0NxaUzuVwONK/6s4fRC/aqsG+4iS86zMjPB0lS
         EW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lG3/DfoKYyB+1bMvX+d64tmSHkJ/WWOCfRxBHwhRaQM=;
        b=6rxnhDMKJTf17uuUk/lXW3jGCMGct8LeyR4A1gpl89/OmH4e1JugH5HTsAUoTXn7zn
         uU3+cdp71+kMrqJDP3ty8j2/O9RLXY/O+ljXHWlxwHipRsdfGVnQOVXvf5LDAMRN6Bvj
         OyuxoH0cd1pPIvBzpZSpcbXdXD/WoPx/Dk9iACV6EUmB4KcJ1z3l7eIWP+RpAGexj+a/
         pZvOfTyxNV6Y6d+yuQd1UcVmqkLE4TYQUBMuFgdhncYVdHkCcYh0we0QCOppIZKfWq8x
         9wA6RyDrGhftAKrbS4tVMti6n3fC+vHWCZc7/R9d0lpwNGvzFfTaqg1q5Q3zqrm8RxnE
         w1oA==
X-Gm-Message-State: AJIora/twHSMtlHi0sJr9J5yrYNoUaZZ2nntPcyXU17Ps3edxNVUiOmF
        RrQ5O0LqLY9FPkXr/HTxSfqInOI76/+6wPqeh8i+Gw==
X-Google-Smtp-Source: AGRyM1u/VchFi65j/v+lkYNQseIRYA8zOomib844qMdIlc8nep6xQZl7NOBrGDosUyTB0rIiJUUq/VEfT+2CBlzRMKY=
X-Received: by 2002:a05:6402:2404:b0:437:d11f:b9c7 with SMTP id
 t4-20020a056402240400b00437d11fb9c7mr8940139eda.176.1657758639748; Wed, 13
 Jul 2022 17:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220628222941.2642917-1-jeffxu@google.com> <06847585-8712-5f0c-b7e4-e32745576e16@digikod.net>
 <CALmYWFtn97HpsTK02Sn7riD7yJ3zdbGob+Yz8PHa_Yx0tgfchQ@mail.gmail.com>
 <CALmYWFvcSn_wks0bXo3_DUyYGtVW_MHrrO1dRoYcxY4uiB1KEA@mail.gmail.com>
 <0abdd920-b5cc-2fa9-7494-104c9c67480d@digikod.net> <CALmYWFvfRFfZbk=9P-=RNtjhXoR0ToQKnVVEZwmXB9yxLEHotg@mail.gmail.com>
In-Reply-To: <CALmYWFvfRFfZbk=9P-=RNtjhXoR0ToQKnVVEZwmXB9yxLEHotg@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 13 Jul 2022 17:30:28 -0700
Message-ID: <CABXOdTf=o1zSSDUPNubHxAnF=1dOwOuxKfrViPHAD-tV_4x=Ww@mail.gmail.com>
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

On Wed, Jul 13, 2022 at 4:44 PM Jeff Xu <jeffxu@google.com> wrote:
>
> > > a correction:
> > >
> > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >     case 0 - classic ptrace permissions: a process can PTRACE_ATTACH =
to
> > >     any other
> > >          process running under the same uid, as long as it is dumpabl=
e (i.e.
> > >          did not transition uids, start privileged, or have called
> > >          prctl(PR_SET_DUMPABLE...) already). Similarly, PTRACE_TRACEM=
E is
> > >          unchanged.
> > >
> > >     Test: All passing
> > >
> > > // Base_test: 7/7 pass.
> > > // Fs_test 46/48 pass
> > > //.   not ok 47 layout2_overlay.no_restriction
> > > //.   not ok 48 layout2_overlay.same_content_different_file
> > > //  Ptrace 8/8 pass
>
>
> > Hmm, well, it is not related to Yama then. Could it be linked to other
> > Chromium OS non-upstream patches?
>
>
> fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS is not
> enabled in chromeOS.
> If there is a reliable way of detecting OVERLAYFS (checking mount
> overlayfs is successful ? ), this is a good candidate to add SKIP.
>

IS_ENABLED(CONFIG_OVERLAY_FS) ?

> Overall, all the failure of landlock selftest seen in chromeOS are
> expected, we just need to modify the test.
>
> Thanks
> Best Regards
> Jeff
>
>
>
> On Thu, Jul 7, 2022 at 7:25 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
> >
> >
> > On 07/07/2022 01:35, Jeff Xu wrote:
> > > a correction:
> > >
> > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >     case 0 - classic ptrace permissions: a process can PTRACE_ATTACH =
to
> > >     any other
> > >          process running under the same uid, as long as it is dumpabl=
e (i.e.
> > >          did not transition uids, start privileged, or have called
> > >          prctl(PR_SET_DUMPABLE...) already). Similarly, PTRACE_TRACEM=
E is
> > >          unchanged.
> > >
> > >     Test: All passing
> > >
> > > // Base_test: 7/7 pass.
> > > // Fs_test 46/48 pass
> > > //.   not ok 47 layout2_overlay.no_restriction
> > > //.   not ok 48 layout2_overlay.same_content_different_file
> > > //  Ptrace 8/8 pass
> >
> > Hmm, well, it is not related to Yama then. Could it be linked to other
> > Chromium OS non-upstream patches?
