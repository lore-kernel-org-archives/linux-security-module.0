Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B452CC433EF
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Jul 2022 18:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239881AbiGNShR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbiGNShR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Jul 2022 14:37:17 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C071D32E
        for <linux-security-module@vger.kernel.org>; Thu, 14 Jul 2022 11:37:16 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s206so2357832pgs.3
        for <linux-security-module@vger.kernel.org>; Thu, 14 Jul 2022 11:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mv6Ais6a1OwoEfLCL/NPmNpCc0j2/ke9MOGDspErNCI=;
        b=OFkf9Icl6x60f3aTVTmcwyk4b9m9Gf6l1dBRXuZEhzAKqsrw+GoLzyQAhTndpSiB8b
         YhFyLDTWIDQ6t8KkWorN7GMw7fL38KtNITGThiKpOfV9nXWfqGLWa9OaHDYggBKMmEgE
         3OBS6er/dynj36kZ2Z9frXBBvLrkKgEk8iRXfg+1Skg3Rv1nd0eJO4iJT3LUi01YaB+f
         AVlikHVxRAXM+VHI+nSOTu2kihiBJUrA33qhXH4O1GmbS5B1Ms+jr1ETXu/FBuG81rUE
         CvnU1HKjgTvNg007LZPN35TdqPLJelx9tSvjZC+SF67DPeKCnIYzO4tp+OG7dIvUNbna
         FROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mv6Ais6a1OwoEfLCL/NPmNpCc0j2/ke9MOGDspErNCI=;
        b=z9t2vJ3c54Bmt8eTKJLi14EanGs+oVQh7M8eF3W2YSnpXh0zs1uUVoSlzBmDC8hEY2
         h++QuUBcwGZGAe6DgOV9vMKyZrd08dXCuYJJcjnhiS8jU2zvh38hbbFXyJ34h5AmobSc
         01dT5WOyBzLKx7jjXQ/VZcSxiCUqJCnnlTXCC00NhRaAJAL5mPz7SPMEvw7Psc9T0b9g
         TVIOxkgFvNb9UrvcGAjrRFuQXkce5iJichvlgqNaI4/JJqXGdvFS+trhWJgC03oJdSWm
         gWgU25Z8WM5LMqhKZWjZq5PbwtIH9Z/Hf4M0Ik0Vcdf9gE7jlZpUlC2Unf0I0YGPyMtQ
         5ERw==
X-Gm-Message-State: AJIora8fxGRDuFzHSM/d/7jlRERcuuLbVpiO8ah21Czuh15jtOh7Vvif
        A/K5ogZVUDaHoaWM10pXtW+yQDSrSDhgiGPZ8ObViQ==
X-Google-Smtp-Source: AGRyM1uaAZJzRD+seDhPKu9/4dc1eUNC/vupvXJwL8/TzSC8urZcCpDlVwigMNLFnihf2hUEvtDppnSwtM+xpW93Akc=
X-Received: by 2002:a05:6a02:313:b0:416:73c:507c with SMTP id
 bn19-20020a056a02031300b00416073c507cmr8663579pgb.366.1657823835941; Thu, 14
 Jul 2022 11:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220628222941.2642917-1-jeffxu@google.com> <06847585-8712-5f0c-b7e4-e32745576e16@digikod.net>
 <CALmYWFtn97HpsTK02Sn7riD7yJ3zdbGob+Yz8PHa_Yx0tgfchQ@mail.gmail.com>
 <CALmYWFvcSn_wks0bXo3_DUyYGtVW_MHrrO1dRoYcxY4uiB1KEA@mail.gmail.com>
 <0abdd920-b5cc-2fa9-7494-104c9c67480d@digikod.net> <CALmYWFvfRFfZbk=9P-=RNtjhXoR0ToQKnVVEZwmXB9yxLEHotg@mail.gmail.com>
 <CABXOdTf=o1zSSDUPNubHxAnF=1dOwOuxKfrViPHAD-tV_4x=Ww@mail.gmail.com>
In-Reply-To: <CABXOdTf=o1zSSDUPNubHxAnF=1dOwOuxKfrViPHAD-tV_4x=Ww@mail.gmail.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Thu, 14 Jul 2022 11:36:40 -0700
Message-ID: <CALmYWFvfDcJCUDCLhrDPdvyY6fH_2diQbbo8ejq3Xvu6E8_2rA@mail.gmail.com>
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

> > > Hmm, well, it is not related to Yama then. Could it be linked to othe=
r
> > > Chromium OS non-upstream patches?
> >
> >
> > fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS is not
> > enabled in chromeOS.
> > If there is a reliable way of detecting OVERLAYFS (checking mount
> > overlayfs is successful ? ), this is a good candidate to add SKIP.
> >

> IS_ENABLED(CONFIG_OVERLAY_FS) ?

Could be. Landlock selftest currently is a user space program though,
IS_ENABLED will depend on the kernel header during compile time.


On Wed, Jul 13, 2022 at 5:30 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Wed, Jul 13, 2022 at 4:44 PM Jeff Xu <jeffxu@google.com> wrote:
> >
> > > > a correction:
> > > >
> > > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >     case 0 - classic ptrace permissions: a process can PTRACE_ATTAC=
H to
> > > >     any other
> > > >          process running under the same uid, as long as it is dumpa=
ble (i.e.
> > > >          did not transition uids, start privileged, or have called
> > > >          prctl(PR_SET_DUMPABLE...) already). Similarly, PTRACE_TRAC=
EME is
> > > >          unchanged.
> > > >
> > > >     Test: All passing
> > > >
> > > > // Base_test: 7/7 pass.
> > > > // Fs_test 46/48 pass
> > > > //.   not ok 47 layout2_overlay.no_restriction
> > > > //.   not ok 48 layout2_overlay.same_content_different_file
> > > > //  Ptrace 8/8 pass
> >
> >
> > > Hmm, well, it is not related to Yama then. Could it be linked to othe=
r
> > > Chromium OS non-upstream patches?
> >
> >
> > fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS is not
> > enabled in chromeOS.
> > If there is a reliable way of detecting OVERLAYFS (checking mount
> > overlayfs is successful ? ), this is a good candidate to add SKIP.
> >
>
> IS_ENABLED(CONFIG_OVERLAY_FS) ?
>
> > Overall, all the failure of landlock selftest seen in chromeOS are
> > expected, we just need to modify the test.
> >
> > Thanks
> > Best Regards
> > Jeff
> >
> >
> >
> > On Thu, Jul 7, 2022 at 7:25 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.ne=
t> wrote:
> > >
> > >
> > > On 07/07/2022 01:35, Jeff Xu wrote:
> > > > a correction:
> > > >
> > > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >     case 0 - classic ptrace permissions: a process can PTRACE_ATTAC=
H to
> > > >     any other
> > > >          process running under the same uid, as long as it is dumpa=
ble (i.e.
> > > >          did not transition uids, start privileged, or have called
> > > >          prctl(PR_SET_DUMPABLE...) already). Similarly, PTRACE_TRAC=
EME is
> > > >          unchanged.
> > > >
> > > >     Test: All passing
> > > >
> > > > // Base_test: 7/7 pass.
> > > > // Fs_test 46/48 pass
> > > > //.   not ok 47 layout2_overlay.no_restriction
> > > > //.   not ok 48 layout2_overlay.same_content_different_file
> > > > //  Ptrace 8/8 pass
> > >
> > > Hmm, well, it is not related to Yama then. Could it be linked to othe=
r
> > > Chromium OS non-upstream patches?
