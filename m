Return-Path: <SRS0=NGWT=2C=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA655C43603
	for <linux-security-module@archiver.kernel.org>; Thu, 12 Dec 2019 11:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8823920663
	for <linux-security-module@archiver.kernel.org>; Thu, 12 Dec 2019 11:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OUNbqy9M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfLLLsh (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:48:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36278 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728722AbfLLLsg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 12 Dec 2019 06:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576151316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aAOGkdsf3Gg+78LEY1O8C5jATMhZrtGdg1ld8cIhzh0=;
        b=OUNbqy9MLIWAbhKjnSe/lfnN51/A5YUW+1M11A4khrKsGG+WhyaRHKV3xKCdIMur3g+bXz
        0foPGTur5kf1wzxDZBkh4N73Hy+0LpSHNAjWoVzKTpcgaTjJLnEmInzkeyTZ3xESpqjQbu
        Jt4dYIfxorBUHJ3u6Yam60Cy2hoWIHk=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-s3NM9n1zO0i1fdo35HcudQ-1; Thu, 12 Dec 2019 06:48:32 -0500
Received: by mail-ot1-f72.google.com with SMTP id e9so497649otr.5
        for <linux-security-module@vger.kernel.org>; Thu, 12 Dec 2019 03:48:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DEKf06qzV7w/c1Lssi+ihS+pe3n54hW/9SP5KebYMMc=;
        b=RTsd0dzTiqsK6wSUb4MEfAIBELJc9Rbf7QXStigWW+U35uINinY/A1uNH37qbu3FQ0
         x022CFkIWxku53GCH2wKhAbyHV5xtobnj5DAa/mEZ8sxQI4Ijb7mVJ+9FBd2gnucdloy
         Ob4+yKpSWjcOZPz28mnsle48Ow7IDDofeAl/wh4lrb4lpHcZdkd62MLfstX5rr/TiX69
         +Wtb2Yu4c/SNe0OtQxM98tdxoJMTbDf8A1FzVsSCCo7BBErdEM2CYrNm6iKidPom62aI
         Pju2EltSI3CGIGfm75vL7t+ERMumxbf3hs2yWjxASN63vxren8JOswsJXStP6rCeoRbj
         1WKA==
X-Gm-Message-State: APjAAAXVsO5J2dI46HVo0rCcCB0URKtZmFpdWkI3eRiorSU7Tt/CUS9+
        wuRF+YSgzVuCbQS+0THkRqvvBFbTaJitGrHQP1kBnQodzUPWSEFYHvHelsJ5claTAavUtCKHEs1
        grL02zR6iBE2BAdzfTRWfrX7oKeteDYARZdJ7eeK0mZqv8ec9NlHv
X-Received: by 2002:a05:6830:2154:: with SMTP id r20mr7754442otd.66.1576151312098;
        Thu, 12 Dec 2019 03:48:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZJqci9D7L7Q7rUwlHrdOa6tMvoEXb57bhibA2ri8cO+1qTkfA8q2tSbaV8Ktepe/b8ks5aKfUXcyi2ymuYlA=
X-Received: by 2002:a05:6830:2154:: with SMTP id r20mr7754410otd.66.1576151311830;
 Thu, 12 Dec 2019 03:48:31 -0800 (PST)
MIME-Version: 1.0
References: <20191211140833.939845-1-omosnace@redhat.com> <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov>
In-Reply-To: <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 12 Dec 2019 12:48:20 +0100
Message-ID: <CAFqZXNtViuNTGtDwPF0Wra=ykaNN=n2ZO_GuSTOXQo__HhUawg@mail.gmail.com>
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-MC-Unique: s3NM9n1zO0i1fdo35HcudQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Dec 11, 2019 at 3:29 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 12/11/19 9:08 AM, Ondrej Mosnacek wrote:
> > Instead of deleting the hooks from each list one-by-one (which creates
> > some bad race conditions), allow an LSM to provide a reference to its
> > "enabled" variable and check this variable before calling the hook.
> >
> > As a nice side effect, this allows marking the hooks (and other stuff)
> > __ro_after_init unconditionally. Since SECURITY_WRITABLE_HOOKS no longe=
r
> > makes sense, remove it and instead use SECURITY_SELINUX_DISABLE directl=
y
> > for turning on the runtime disable functionality, to emphasize that thi=
s
> > is only used by SELinux and is meant to be removed in the future.
>
> Is this fundamentally different/better than adding if (!selinux_enabled)
> return 0; to the beginning of every SELinux hook function?

It saves us from maintaining the invariant that each hook has to begin
with said condition and it avoids one extra indirect jump. Whether
that's a compelling advantage, I don't know...

> And as I
> noted to Casey in the earlier thread, that provides an additional easy
> target to kernel exploit writers for neutering SELinux with a single
> kernel write vulnerability. OTOH, they already have
> selinux_state.enforcing and friends, and this new one would only be if
> SECURITY_SELINUX_DISABLE=3Dy.

I don't think that makes the situation too much worse, but others may
disagree...

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

