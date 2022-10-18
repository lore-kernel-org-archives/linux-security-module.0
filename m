Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E35AC4332F
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Oct 2022 01:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJRBpf (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 17 Oct 2022 21:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJRBpe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 17 Oct 2022 21:45:34 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71916BCE5
        for <linux-security-module@vger.kernel.org>; Mon, 17 Oct 2022 18:45:33 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id y205so15309505yby.13
        for <linux-security-module@vger.kernel.org>; Mon, 17 Oct 2022 18:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uc3iSsnst/L6NfYcFirJxNRFbBLqldZchqVKRw0L9/A=;
        b=H/plYs2MWaQCz1Qqw9VMwAz1iRItNX7SVB3TGcCPvBYrMnjlmtkSONdjaiHGm/pPbd
         jlzvDiU01I5WFPQXBUXd96ZRTu3w5UaLAFv65FzhMl507pp0bC6HGJDGNEb51u5cCIaz
         WW6jHLk7lcRrz29dOzsKhNPOqELmECXOALgjP+nhp5VsRvYZhh+8XKNzJaLNVU2LmZmg
         QtGVo8YH16hqSFb8QcCSo/BzlePQ91nM+tb/LcpU7MqKxUmkf8tPCg8X6g5b5gDeYE2H
         0ipUAhKtIwxjTR1CgoBKc7FSr4jNIyL6y6lieu4h8O6ApZTRZr8qg7W5NADitjXsv9eJ
         6lYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uc3iSsnst/L6NfYcFirJxNRFbBLqldZchqVKRw0L9/A=;
        b=wMNFqp38iYHF5VS8+R1kkudA8YWdvU40WQz/nBexXTpxSEW1CaNzmIWp+b50kZi48d
         sklBS9/jyLI7QYeIWA44HzoryVAnpjc/kOYe9z2DNCTYDHXM+HPsGRq+S7Z2ZW6ucdY6
         YrGbC6UOIsN0ZYpHSL19CwCn3fnEAm5wUPSpI4IqUgd13zuU+05o/R9eiewjLOnJAKgO
         8e3w3+b0gYRAr7dDergDx4S9PkFHQ9ZmWbCrQsYSjvE5gc4qRD2w4ZWyE+I2Dqj1jNWr
         Dm8bGRWBWK2FzfeencPZstsCkuXPNpwkwM1UAXSDL/vEm/ZUluf4axamPGHej31XQnfH
         3qxg==
X-Gm-Message-State: ACrzQf0m+Z/Vu+KjZllHkBzmPCpTlZO0v5kq9xEO8BErZLDNQf/r3Bal
        Qh659+g0FYjY3XRpDiLVoyABGwz7EvLzOpC6ruT1QDeUMQ==
X-Google-Smtp-Source: AMsMyM5On7bmlgMjHo9aS9yblYhNGik82fUAxWDT98YVn+JNWN7U7X/bxVWBK9j42c5h+Puvi3EkuJP8nBCbwctcGEg=
X-Received: by 2002:a05:6902:124f:b0:6c0:770:1890 with SMTP id
 t15-20020a056902124f00b006c007701890mr491854ybu.186.1666057532860; Mon, 17
 Oct 2022 18:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210222150608.808146-1-mic@digikod.net> <20210222150608.808146-2-mic@digikod.net>
 <51725b44-bc40-0205-8583-285d3b35b5ca@schaufler-ca.com> <ee461f8d-a02d-0782-8f31-691853a57f00@digikod.net>
 <7b67163a-9de1-313f-5b5a-8c720cef9b73@schaufler-ca.com> <CAJfZ7=n5FOxHXMLRrDQ3F-kDqbYngNoYKcz6_PWi1rPa0_8WpA@mail.gmail.com>
 <3b97e25b-303c-d732-3e5d-f1b1a446e090@schaufler-ca.com> <202210171111.21E3983165@keescook>
In-Reply-To: <202210171111.21E3983165@keescook>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Oct 2022 21:45:21 -0400
Message-ID: <CAHC9VhTTKpesvjnc_233x+wG1BvXyup9nM4Dv2h1953zXAvU3A@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] security: Add CONFIG_LSM_AUTO to handle default
 LSM stack ordering
To:     Kees Cook <keescook@chromium.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Nicolas Iooss <nicolas.iooss@m4x.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 17, 2022 at 3:29 PM Kees Cook <keescook@chromium.org> wrote:
>
> [*double thread necromancy*]

Yikes!  This is some pretty serious mail thread crime ...

> On Mon, Feb 22, 2021 at 02:46:24PM -0800, Casey Schaufler wrote:
> > It wouldn't. But compiling the new LSM mynewlsm doesn't add it to
> > the list, either. Today no one should expect a LSM to be active if
> > it hasn't been added to the CONFIG_LSM list. The proposed addition
> > of CONFIG_LSM_AUTO would change that. "make oldconfig" would add
> > security modules that are built to the list. This is unnecessary
> > since whoever changed CONFIG_SECURITY_MYNEWLSM to "y" could easily
> > have added it to CONFIG_LSM. In the right place.
>
> Having CONFIG_LSM/lsm= is to support the migration away from having a
> "default major LSM", but still provide a way to separate "built" vs
> "enabled". As such, it needs to provide ordering. (So we have three
> concepts here: "built" at all, "enabled" by default, and in a specific
> "order".) And not being listed in CONFIG_LSM/lsm= means an LSM is
> disabled.
>
> I don't disagree about "anyone who enables a new LSM config can add it to
> CONFIG_LSM", but really I think the question is why require an _ordering_
> choice. Most distros and builders don't care beyond having the current
> "default major LSM" come first, which leaves only the "enabled by
> default" choice.

The code sorta cares about ordering, at least to the extent that the
LSMs will behave differently depending on the ordering, e.g. a LSM
lower in the priority order might never "see" an operation if a higher
priority LSM rejects the operation.  Yes, it's an implementation
quirk, but I'm not sure I want to start messing with the
fail-on-first-error logic right now.  Maybe once we've got the LSM
layer fully stackable and we've gotten past the initial support
nightmare of that we can revisit this idea.

> I personally think it's reasonable that a "built" LSM be "enabled" by
> default, however, this is not universally held to be true. :)

I personally would like to preserve the existing concept where "built"
does *not* equate to "enabled" by default.

> I *still* think there should be a way to leave ordering alone and have
> separate enable/disable control.

My current opinion is that enabling a LSM and specifying its place in
an ordered list are one in the same.  The way LSM stacking is
currently done almost requires the ability to specify an order if an
admin is trying to meet an security relevant operation visibility
goal.

We can have defaults, like we do know, but I'm in no hurry to remove
the ability to allow admins to change the ordering at boot time.

-- 
paul-moore.com
