Return-Path: <SRS0=34bQ=6X=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85637C28CBC
	for <linux-security-module@archiver.kernel.org>; Sat,  9 May 2020 20:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AB2214D8
	for <linux-security-module@archiver.kernel.org>; Sat,  9 May 2020 20:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589054665;
	bh=ZG2dfDm6+lxhvg4jAOBRNUdywRJlzyhvEwgyvWsBEsA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oBOD/aaTwxyNjELANLfsLcwgl41Uu8keMr5emBW99LauBpidhv5ecYC2Po/8/4xIm
	 cKXRcZcuqIEV1aobmpTvRIhVLXyJdPm8VANkMjs74ktcd7122objcfcTBW9QFxwJHK
	 g4o6y0hx6hOwnq9kuLMrmn+9i+p4BDirgz/QuFcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgEIUEY (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Sat, 9 May 2020 16:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728340AbgEIUEY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 9 May 2020 16:04:24 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D1AC05BD09
        for <linux-security-module@vger.kernel.org>; Sat,  9 May 2020 13:04:23 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id r17so1099324lff.9
        for <linux-security-module@vger.kernel.org>; Sat, 09 May 2020 13:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wWejqRu9NOZoWVx2r5ZhYYkg3on/D2ic/z20ZX+wyUE=;
        b=H93dwpRMxxEpejouhAhGa7npVZCP7wAT6FtICQgrremLWQQRtm5D50jO1ZcAf4w+V6
         720SNM4lfLRzTqLb19Nngf3P1lsMgAq0CEBagaPG5WURf/G4uS7fW9uD79CV1SbBTZGB
         aHbSY7BTO76NKGZ5X3tsRZYbXQ5w4H2rT+sFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wWejqRu9NOZoWVx2r5ZhYYkg3on/D2ic/z20ZX+wyUE=;
        b=sUglzuNLwzr/NqMvTn0A+Nr/Fo36y3w8F4I9QraOfn6nBcVHMVlpDf+5iRn8lMFbRm
         DHERq8PV3RomoEPcizFghIQpZX1GsaHMm/Dg2YV1qFmFbPPjXvvVlCtsJ5k1OrOdMhog
         a9LJyyQ/k/i0Z2IWYziRWtVZnmy+ASWyKeUlWK25ykBLnsydrbOIB294izp053xF0keV
         5Lq5HtiLjY0sQ9gFLfa9S9rz4Obs8QutIRXyJjhrqtD1gWdqk8aTcGchtwfdioTdn6kL
         mrlTIoMISald6SZzti0K9wqdRTz1FI1SfINqe+vocFK3/do+21m2AVxuQM/2dtZgZT5T
         EiwQ==
X-Gm-Message-State: AOAM533QDSIjMYqbBxN/ogQX62vYzrMjtrBnP9b6bE0xMsYREjY8TUUu
        c5p17wVjvQ/mWXCYEMq0KUb1dneNTD4=
X-Google-Smtp-Source: ABdhPJyYSditXKjykfFuRLy2xv6NDoTdB/QudLQSSUO31SUCnBBjuEwsKy6MV3gRzRLkHi3UVwBPAA==
X-Received: by 2002:a19:7f17:: with SMTP id a23mr5912029lfd.38.1589054662085;
        Sat, 09 May 2020 13:04:22 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id f5sm4916361lfh.84.2020.05.09.13.04.21
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 13:04:21 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id u6so5263474ljl.6
        for <linux-security-module@vger.kernel.org>; Sat, 09 May 2020 13:04:21 -0700 (PDT)
X-Received: by 2002:a2e:814e:: with SMTP id t14mr5448255ljg.204.1589054661055;
 Sat, 09 May 2020 13:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <87pnbczyka.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87pnbczyka.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 May 2020 13:04:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjfesjgqNmWY5zNxaADcQ04ZNfBq7KMkx20Xq-sDB5A7A@mail.gmail.com>
Message-ID: <CAHk-=wjfesjgqNmWY5zNxaADcQ04ZNfBq7KMkx20Xq-sDB5A7A@mail.gmail.com>
Subject: Re: [PATCH 1/5] exec: Call cap_bprm_set_creds directly from prepare_binprm
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, May 9, 2020 at 12:44 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> The function cap_bprm_set_creds is the only instance of
> security_bprm_set_creds that does something for the primary executable
> file and for every interpreter the rest of the implementations of
> security_bprm_set_creds do something only for the primary executable
> file even if that file is a shell script.

Eric, can you please re-write that sentence as something that can be
parsed and understood?

I'm pretty sure that what you are talking about is the whole
"called_set_creds" flag logic, where the logic is that some security
layers only react to the first one, while the capability checks are
done for every one.

But there is no way to realize that from your description above. In
fact, the description above is actively incorrect and misleading,
since you say that "cap_bprm_set_creds is the only instance [..] that
does something for the primary executable"

I think that you mean to say that it does something for *every*
instance of the executable, not just the primary one.

> The function cap_bprm_set_creds is also special in that it is called
> even when CONFIG_SECURITY is unset.
>
> So calling cap_bprm_set_creds separately to make these two cases explicit,
> and allow future changes to take advantages of these differences
> to simplify the code.

I think you need to rename "security_bprm_set_creds()" too, to show
what it does. Since it clearly no longer does that "bprm_set_creds()"
from the common capabilities.

In fact, I think it would probably be good to change the patch too, so
that it is actually understandable what the heck the logic is.

Instead of

        retval = security_bprm_set_creds(bprm);
        if (retval)
                return retval;
        bprm->called_set_creds = 1;
        retval = cap_bprm_set_creds(bprm);
        if (retval)
                return retval;

which makes no sense at all when you read it, do this:

        /* Every instance of the executable gets called for capabilities */
        retval = cap_bprm_set_creds(bprm);
        if (retval)
                return retval;

        /* Other security layers only want the primary executable */
        if (!bprm->called_set_creds) {
                retval = security_primary_bprm_set_creds(bprm);
                if (retval)
                         return retval;
                bprm->called_set_creds = 1;
        }

which now actually describes what is going on.

Then remove the 'called_set_creds' logic from the security layers, and
rename those 'xyz_bprm_set_creds()' to be
'xyz_primary_bprm_set_creds()'.

After that, and with a proper commit message that actually explains
this _properly_, this looks like a cleanup.

Because right now that patch description makes zero sense at all, and
the patch itself results in this insane situation where
"security_bprm_set_creds()" expressly doesn't call the basic
"cap_bprm_set_creds()" at all, which just makes things very very
confusing and the naming actively misleading.

               Linus
