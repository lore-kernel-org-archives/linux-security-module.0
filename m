Return-Path: <SRS0=hMH8=MO=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4588BC65BA7
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 23:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF4C20666
	for <linux-security-module@archiver.kernel.org>; Tue,  2 Oct 2018 23:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QccxNMId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF4C20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJCFwO (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:52:14 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39594 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725744AbeJCFwN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Oct 2018 01:52:13 -0400
Received: by mail-yw1-f66.google.com with SMTP id v1-v6so1515696ywv.6
        for <linux-security-module@vger.kernel.org>; Tue, 02 Oct 2018 16:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S0Ciq0S0JGenOhU5WcUgrqpxaUlMx+CT/CSmdLz/MQk=;
        b=QccxNMIdR4mPtjWtaS6DNElAKKah/uGpg+eCuFTE4LqStDJuX44rrhOHWTVEiH/igA
         qI77veKoVN7YVI86l7Nr4KL8h7m3wP1aFcaVAtYHhAXwO3Z7mGjqG12TqHgcdbHfhSQH
         5qioxib6XZNhv2MONOKo1LYRdzpig7P4kHnRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S0Ciq0S0JGenOhU5WcUgrqpxaUlMx+CT/CSmdLz/MQk=;
        b=sTa3ax/fD1K4lM1VHL4yxI3JGATjYD8L7+zzddvGR3HkFMkvA8RArrJURgqrv3QfNA
         BbyFxdmuItx9Tm12gjaTwYUCJLWjdj2OqqV/08uyqbuKRG3Qpmc0jB6/qnjzd1DI4EqF
         fu6EWWczq7FbRfx86XFrUH6feKIAmtpdGcmulu2AY2MbKwTjv39T1OkDA5q8uMNzchNh
         3H1tAio1sR8pFbLdI7472f3TSGCqA+GGIhSquY8YFU53ZE/WehftJSrpnA3MmRuOvkX7
         B2UuF2WwiOGEG1xR6jFjaWtHPSwbmABiwri0CVh/EPw3tQyvVt3/O0A1h0gxHEv2FGBs
         KRJw==
X-Gm-Message-State: ABuFfojgh6b8c0MJLql3+DSTVVeaf9SDQ0kgWOgB7t8Kzz6+ZtJCmk7n
        b9COaiIcV+x/nskJHuQFliZjNrgBNOk=
X-Google-Smtp-Source: ACcGV634tJ5v0pIGJQ4dyEyb9vFyiw19kOYNoldoNIfX0C5phJ5Xz0WLM0obCwPuhFFvQkIBA51jug==
X-Received: by 2002:a0d:eb4c:: with SMTP id u73-v6mr9569959ywe.125.1538521588552;
        Tue, 02 Oct 2018 16:06:28 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id x64-v6sm5359636ywx.103.2018.10.02.16.06.26
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 16:06:27 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id p74-v6so1561329ybc.9
        for <linux-security-module@vger.kernel.org>; Tue, 02 Oct 2018 16:06:26 -0700 (PDT)
X-Received: by 2002:a25:3617:: with SMTP id d23-v6mr10188175yba.141.1538521586370;
 Tue, 02 Oct 2018 16:06:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Tue, 2 Oct 2018 16:06:25 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.21.1810030758460.23596@namei.org>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov> <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Oct 2018 16:06:25 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
Message-ID: <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
To:     James Morris <jmorris@namei.org>
Cc:     John Johansen <john.johansen@canonical.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 2, 2018 at 3:06 PM, James Morris <jmorris@namei.org> wrote:
> On Tue, 2 Oct 2018, Kees Cook wrote:
>
>> On Tue, Oct 2, 2018 at 11:57 AM, John Johansen
>> <john.johansen@canonical.com> wrote:
>> > Under the current scheme
>> >
>> > lsm.enabled=selinux
>> >
>> > could actually mean selinux,yama,loadpin,something_else are
>> > enabled. If we extend this behavior to when full stacking lands
>> >
>> > lsm.enabled=selinux,yama
>> >
>> > might mean selinux,yama,apparmor,loadpin,something_else
>> >
>> > and what that list is will vary from kernel to kernel, which I think
>> > is harder for the user than the lsm.enabled list being what is
>> > actually enabled at boot
>>
>> Ah, I think I missed this in your earlier emails. What you don't like
>> here is that "lsm.enable=" is additive. You want it to be explicit.
>>
>
> This is a path to madness.
>
> How about enable flags set ONLY per LSM:
>
> lsm.selinux.enable=x
> lsm.apparmor.enable=x
>
> With no lsm.enable, and removing selinux=x and apparmor=x.
>
> Yes this will break existing docs, but they can be updated for newer
> kernel versions to say "replace selinux=0 with lsm.selinux.enable=0" from
> kernel X onwards.
>
> Surely distro packages and bootloaders are able to cope with changes to
> kernel parameters?
>
> We can either take a one-time hit now, or build new usability debt, which
> will confuse people forever.

I'd like to avoid this for a few reasons:

- this requires per-LSM plumbing instead of centralized plumbing
  - each LSM needs to have its own CONFIG flag
  - each LSM needs to have its own bootparam flag
- SELinux has explicited stated they do not want to lose selinux=
- this doesn't meet John's goal of having a "single explicit enable list"

I think the current proposal (in the other thread) is likely the
sanest approach:

- Drop CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE
- Drop CONFIG_SECURITY_APPARMOR_BOOTPARAM_VALUE
- All enabled LSMs are listed at build-time in CONFIG_LSM_ENABLE
- Boot time enabling for selinux= and apparmor= remain
- lsm.enable= is explicit: overrides above and omissions are disabled
- maybe include lsm.disable= to disable anything

-Kees

-- 
Kees Cook
Pixel Security
