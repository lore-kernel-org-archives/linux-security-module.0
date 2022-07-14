Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D40CC433EF
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Jul 2022 20:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240530AbiGNUkJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 14 Jul 2022 16:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240536AbiGNUkI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Jul 2022 16:40:08 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2C7459B7
        for <linux-security-module@vger.kernel.org>; Thu, 14 Jul 2022 13:40:07 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y8so3917372eda.3
        for <linux-security-module@vger.kernel.org>; Thu, 14 Jul 2022 13:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oXMTJkj0mgFYfrxnvrq1Nl3bOB7zIE52cHZ1POgb4b8=;
        b=MNa9Jn/nFo5sq7+KAUEoHvFMaq8CmDnUh3itCCsdhuwBnBBpJz2EG/juTpPrjrPoJ9
         cA0LwXtLidwBUzRCl0hZa+5h5fq5Fb84duycV0lxLEaJ/0Nor3YYyj41s/EIBsTLxrYb
         5j4Mm/qlOna1nBZRPviVAUva+1oBNx9dS0cdguq/hbC2CZw5djTGjcxTSQ9F2gGdWXhX
         J92mYD+IRRlGBypvsKsuNDqE/ducJjrYUFQ/YrSt0vbqEj1KjESK9j7QZSNZA57URZdV
         XMyPPjKfnjJWcGQ+gu3k+guoR3qcP1Fc9F6mRHnyhU+dT9PZNn3biG+QwvzaJE8LX9Rk
         PNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oXMTJkj0mgFYfrxnvrq1Nl3bOB7zIE52cHZ1POgb4b8=;
        b=jdMKWW4UznR6c/OPPJuqmcpcyr0FGwgWYyHVPWLHjqF7H8A+UaMJxKpyy2Z7QeWV+4
         Zel+N6eelr4akZalD7E3GuRrdZO4FNrQykB7r0M6v+PITOBzdhwSNmRNEr2FhpR1P46F
         JC+ClN2iPxmmtgTyXKsX9qf+cMn5U0STSHR98+d7WSshSCzAoSO4lTVHtC3p8LdXdeN8
         XdJLEn+6zWjvE6ZB5lNX4uBuRVA3LYybvY83h8N0FPIzPl9jfpk8hAZ6OYGdM/tql25r
         9gttG1EhPxjSqnHsIf3/HgKsJDKUnoZI1jUSeopyDdgqtQY9zjJv8BxoRbEd53zU+D5C
         yBwg==
X-Gm-Message-State: AJIora/ukPtp37VXEWngS9l8viZkQwpAIEqEVOSk7ts4QswPwyxzzYmd
        XT7D4yHj07N3cRMMlfjbK+22Qz0/Nm8DHnVKAUhG0mWvPQQ=
X-Google-Smtp-Source: AGRyM1tx9GiLKAXVVO9IIxREypzj3c80Ewygb2GTpWBr8bOBFy/rNwmpSkvhOdfdeMWlwmGswO3QlX1mlAlDZJ6aGdE=
X-Received: by 2002:a05:6402:4252:b0:43a:9232:dafc with SMTP id
 g18-20020a056402425200b0043a9232dafcmr14447157edb.243.1657831205558; Thu, 14
 Jul 2022 13:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220628222941.2642917-1-jeffxu@google.com> <06847585-8712-5f0c-b7e4-e32745576e16@digikod.net>
 <CALmYWFtn97HpsTK02Sn7riD7yJ3zdbGob+Yz8PHa_Yx0tgfchQ@mail.gmail.com>
 <CALmYWFvcSn_wks0bXo3_DUyYGtVW_MHrrO1dRoYcxY4uiB1KEA@mail.gmail.com>
 <0abdd920-b5cc-2fa9-7494-104c9c67480d@digikod.net> <CALmYWFvfRFfZbk=9P-=RNtjhXoR0ToQKnVVEZwmXB9yxLEHotg@mail.gmail.com>
 <CABXOdTf=o1zSSDUPNubHxAnF=1dOwOuxKfrViPHAD-tV_4x=Ww@mail.gmail.com> <CALmYWFvfDcJCUDCLhrDPdvyY6fH_2diQbbo8ejq3Xvu6E8_2rA@mail.gmail.com>
In-Reply-To: <CALmYWFvfDcJCUDCLhrDPdvyY6fH_2diQbbo8ejq3Xvu6E8_2rA@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 14 Jul 2022 13:39:54 -0700
Message-ID: <CABXOdTcQOrat3vGCm3nw_ufYKcrQ1gqVdvbUSEUehfhZ7gAW4g@mail.gmail.com>
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

On Thu, Jul 14, 2022 at 11:37 AM Jeff Xu <jeffxu@google.com> wrote:
>
> > > > Hmm, well, it is not related to Yama then. Could it be linked to ot=
her
> > > > Chromium OS non-upstream patches?
> > >
> > >
> > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS is not
> > > enabled in chromeOS.
> > > If there is a reliable way of detecting OVERLAYFS (checking mount
> > > overlayfs is successful ? ), this is a good candidate to add SKIP.
> > >
>
> > IS_ENABLED(CONFIG_OVERLAY_FS) ?
>
> Could be. Landlock selftest currently is a user space program though,
> IS_ENABLED will depend on the kernel header during compile time.
>

Ah, sorry, I thought it was an in-kernel test. Userspace should be
able to determine if overlayfs is supported by checking /sys/fs/ or
possibly /proc/fs/.

Guenter

>
> On Wed, Jul 13, 2022 at 5:30 PM Guenter Roeck <groeck@google.com> wrote:
> >
> > On Wed, Jul 13, 2022 at 4:44 PM Jeff Xu <jeffxu@google.com> wrote:
> > >
> > > > > a correction:
> > > > >
> > > > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >     case 0 - classic ptrace permissions: a process can PTRACE_ATT=
ACH to
> > > > >     any other
> > > > >          process running under the same uid, as long as it is dum=
pable (i.e.
> > > > >          did not transition uids, start privileged, or have calle=
d
> > > > >          prctl(PR_SET_DUMPABLE...) already). Similarly, PTRACE_TR=
ACEME is
> > > > >          unchanged.
> > > > >
> > > > >     Test: All passing
> > > > >
> > > > > // Base_test: 7/7 pass.
> > > > > // Fs_test 46/48 pass
> > > > > //.   not ok 47 layout2_overlay.no_restriction
> > > > > //.   not ok 48 layout2_overlay.same_content_different_file
> > > > > //  Ptrace 8/8 pass
> > >
> > >
> > > > Hmm, well, it is not related to Yama then. Could it be linked to ot=
her
> > > > Chromium OS non-upstream patches?
> > >
> > >
> > > fs_test.c 47 and 48 are failing in chromeOS because OVERLAYFS is not
> > > enabled in chromeOS.
> > > If there is a reliable way of detecting OVERLAYFS (checking mount
> > > overlayfs is successful ? ), this is a good candidate to add SKIP.
> > >
> >
> > IS_ENABLED(CONFIG_OVERLAY_FS) ?
> >
> > > Overall, all the failure of landlock selftest seen in chromeOS are
> > > expected, we just need to modify the test.
> > >
> > > Thanks
> > > Best Regards
> > > Jeff
> > >
> > >
> > >
> > > On Thu, Jul 7, 2022 at 7:25 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.=
net> wrote:
> > > >
> > > >
> > > > On 07/07/2022 01:35, Jeff Xu wrote:
> > > > > a correction:
> > > > >
> > > > >     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >     case 0 - classic ptrace permissions: a process can PTRACE_ATT=
ACH to
> > > > >     any other
> > > > >          process running under the same uid, as long as it is dum=
pable (i.e.
> > > > >          did not transition uids, start privileged, or have calle=
d
> > > > >          prctl(PR_SET_DUMPABLE...) already). Similarly, PTRACE_TR=
ACEME is
> > > > >          unchanged.
> > > > >
> > > > >     Test: All passing
> > > > >
> > > > > // Base_test: 7/7 pass.
> > > > > // Fs_test 46/48 pass
> > > > > //.   not ok 47 layout2_overlay.no_restriction
> > > > > //.   not ok 48 layout2_overlay.same_content_different_file
> > > > > //  Ptrace 8/8 pass
> > > >
> > > > Hmm, well, it is not related to Yama then. Could it be linked to ot=
her
> > > > Chromium OS non-upstream patches?
