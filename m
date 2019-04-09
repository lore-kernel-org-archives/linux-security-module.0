Return-Path: <SRS0=Re8g=SL=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D10C10F0E
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Apr 2019 15:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925F82084F
	for <linux-security-module@archiver.kernel.org>; Tue,  9 Apr 2019 15:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XT4TipiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfDIPQv (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:16:51 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44526 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfDIPQu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Apr 2019 11:16:50 -0400
Received: by mail-vs1-f66.google.com with SMTP id j184so10003387vsd.11
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2019 08:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=es5FMlhoG3Dzj0CCqBc3VbIdj5L3WT9j6lpixo2Q050=;
        b=XT4TipiSkvX3yxUIAohXEKu2mIRwF9mXKeBW2ZSWRCIijWuhy5YEy8NQ3TGAQDSulW
         IqSYyCSwnALXTfvxqQGmwQwYmnJixyunytWiIt4gvjdZqiSxNYmHOf+8QzbmN15z9qtv
         sOELSSSMepN26NxQWqy0nP92XODunALGR2zQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=es5FMlhoG3Dzj0CCqBc3VbIdj5L3WT9j6lpixo2Q050=;
        b=Vx1V38hpDPpdB2ukU6gVq6mhWZCdvU/z2hStOeRC5+g0gm8lsEtJZTGaIw198+Ysdf
         ye6+K6uHrsqJhkkHQhyq/sYg1CLhmbKHPbY+6kwRrUjQWvt8zIE1mvf5363qCkU+DPfH
         cSX4GiAgSjVSNtKLOykwF0eVRtrKLn7M0m+6dw+MwENDdpEg8K3DOAH/K8P7l6K71sy5
         FJJpqEmB0RMXEjrX8fB8fufvUFfUmsu3nBRQ0xLa0HcnoNv19zBkKzPVCf4PgXY7iqE7
         D4+hf8RXyhaHUFF0Wj8N6fIcDCVGeheQCFhLiV91B0WBLaMdO9720WHGm60XcEdV1reY
         FAgA==
X-Gm-Message-State: APjAAAUpMpODTzAD7ZR0cqKx/5xNtO7s4Az7G+/w/9wiCfWWgVK63j3y
        wrUfn/SDZ2SA2QdGAJFKEP3XSFWY6qc=
X-Google-Smtp-Source: APXvYqzaZSb69UpfzPbdh/Dn/MEJwLkJpqgolpP/W/suzNh5DklZUfLZcx2zEF3p3Qg85+e133JPQA==
X-Received: by 2002:a67:f416:: with SMTP id p22mr21027637vsn.175.1554823009590;
        Tue, 09 Apr 2019 08:16:49 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id m23sm48338568vsl.24.2019.04.09.08.16.47
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 08:16:48 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id o10so7430510vsp.12
        for <linux-security-module@vger.kernel.org>; Tue, 09 Apr 2019 08:16:47 -0700 (PDT)
X-Received: by 2002:a67:7816:: with SMTP id t22mr19790120vsc.115.1554823007449;
 Tue, 09 Apr 2019 08:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190408160706.GA18786@beast> <CADyDSO4NkEY-SPT-abnyRXT9kGWhF8LbU3XQGNp-5k_15debDg@mail.gmail.com>
In-Reply-To: <CADyDSO4NkEY-SPT-abnyRXT9kGWhF8LbU3XQGNp-5k_15debDg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 9 Apr 2019 08:16:35 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+g8tPrDAYVKv26ci6zvGuvC1TMXto7weVP2QBymMRjhw@mail.gmail.com>
Message-ID: <CAGXu5j+g8tPrDAYVKv26ci6zvGuvC1TMXto7weVP2QBymMRjhw@mail.gmail.com>
Subject: Re: [PATCH] apparmor: Restore Y/N in /sys for apparmor's "enabled"
To:     David Rheinsberg <david.rheinsberg@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 8, 2019 at 11:21 PM David Rheinsberg
<david.rheinsberg@gmail.com> wrote:
>
> Hi
>
> On Mon, Apr 8, 2019 at 6:07 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Before commit c5459b829b71 ("LSM: Plumb visibility into optional "enabled"
> > state"), /sys/module/apparmor/parameters/enabled would show "Y" or "N"
> > since it was using the "bool" handler. After being changed to "int",
> > this switched to "1" or "0", breaking the userspace AppArmor detection
> > of dbus-broker. This restores the Y/N output while keeping the LSM
> > infrastructure happy.
> >
> > Before:
> >         $ cat /sys/module/apparmor/parameters/enabled
> >         1
> >
> > After:
> >         $ cat /sys/module/apparmor/parameters/enabled
> >         Y
> >
> > Reported-by: David Rheinsberg <david.rheinsberg@gmail.com>
> > Link: https://lkml.kernel.org/r/CADyDSO6k8vYb1eryT4g6+EHrLCvb68GAbHVWuULkYjcZcYNhhw@mail.gmail.com
> > Fixes: c5459b829b71 ("LSM: Plumb visibility into optional "enabled" state")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > This fix, if John is okay with it, is needed in v5.1 to correct the
> > userspace regression reported by David.
> > ---
> >  security/apparmor/lsm.c | 49 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 48 insertions(+), 1 deletion(-)
>
> This looks good to me. Thanks a lot! If this makes v5.1, I will leave
> the apparmor-detection in dbus-broker as it is, unless someone asks me
> to parse 0/1 as well?
>
> I cannot judge whether the apparmor_initialized check is correct, but
> for the parameter parsing:
>
> Reviewed-by: David Rheinsberg <david.rheinsberg@gmail.com>

Thanks!

James, are you able to take this for v5.1 fixes?

-- 
Kees Cook
