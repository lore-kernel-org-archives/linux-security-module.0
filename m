Return-Path: <SRS0=fuo0=NU=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DF2C43441
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Nov 2018 00:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C5A2081D
	for <linux-security-module@archiver.kernel.org>; Fri,  9 Nov 2018 00:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c0RcMsP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C5A2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeKIKIe (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Nov 2018 05:08:34 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38773 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbeKIKIe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Nov 2018 05:08:34 -0500
Received: by mail-yw1-f68.google.com with SMTP id i65-v6so228326ywc.5
        for <linux-security-module@vger.kernel.org>; Thu, 08 Nov 2018 16:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZggtY9IjEfjJF3EsmUTuNuT2KYAtn8kgo5a9cZ2xQI=;
        b=c0RcMsP68ppLzAvf7vMzeQHh+E8Lo4qF7QvAVR2S+4m53vyJ40IrOQALSf/3uc9xVY
         bdLkvbV9Rq7yhCleFqjOhBRp2n7LpoJqY+yRyRLLqmf4whA82o8eihvQbfYRzyh+gnuQ
         kxGoz6ZRrOZvMO5gT7Y/Z5yg+Io3th9Dq4nKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZggtY9IjEfjJF3EsmUTuNuT2KYAtn8kgo5a9cZ2xQI=;
        b=Xp5jhfj294buij5PHzFzkSaF9qxfDffkYs+qRAaYT2WakrrE667sIWISbDKGHGJ7rn
         RAYvfId1T7alq6Lq2twhLDnRSjkjBs4kRWtwPONkkUna1lUVgiqE2qpyr1Dshv9iqoeH
         QdiiL4UzJwnBu4EYoAP6NAEDo8LAgHwrGcZIASSbbp7S/wFTyG70GobQxgkw2DqPuR3j
         O0nfVnq4WWdW/kJ1dwrrkg6ezxbGbjITVxt0ZAvUfilLw2vamVv/v9DyoS+YAGjXnYUf
         hhAFPnFr9vzii7ZXZU1vJyLSSeNkfYudAj/f8qWgDhYdNPCYAgjSP2wqK4R4Ik4G3H2u
         Cp4A==
X-Gm-Message-State: AGRZ1gLPNULjgM5CBGFx9hNBADZPXNi6sDVIuerl4YO5f0hDyg1iVW9D
        PyqJ9KoCZmDO0Yx5L9xNAkU9z+tEc94DYDXt1lBHeQ==
X-Google-Smtp-Source: AJdET5epKoNVeVMA4IFIDfeF+zanF76ResyVMsrZp+92/bcdHyHvuAzl+S/VB+ArsCbxvbR3AHkZntlS7sNnpory68s=
X-Received: by 2002:a81:34d0:: with SMTP id b199-v6mr6390672ywa.322.1541723425056;
 Thu, 08 Nov 2018 16:30:25 -0800 (PST)
MIME-Version: 1.0
References: <20181031210245.GA3537@mail.hallyn.com> <20181101060737.GA7132@mail.hallyn.com>
 <CAJ-EccMaAu+g55Nuh1nZqt3Ld-YEgDiT_ewdQzGtFGmzRgXckw@mail.gmail.com>
 <41daea64-03c0-0970-c405-d1a5ae134181@schaufler-ca.com> <CAJ-EccNO8DeER3VUyyxO-CD_qBmzasMvZuUsbdWgcfiAjRcsFw@mail.gmail.com>
 <3a3231b3-44b3-b330-2cda-d4246bca35be@schaufler-ca.com> <CAJ-EccMU9mtyA1qwXYEqHP9vXZEBiuCfdG3KTrAA-hQ+Y-CANg@mail.gmail.com>
 <5c7e1a80-c534-6adb-be19-58bb0d97084f@schaufler-ca.com> <20181102183056.GA20738@mail.hallyn.com>
 <b1f95526-d0f1-712e-e0a7-9710cae7e1f0@schaufler-ca.com> <20181102192227.GA21498@mail.hallyn.com>
 <CAJ-EccMrP_agdiPNpCjA9V4iDt+LgA2K3uFV3qVJBVVow-cC7w@mail.gmail.com> <d041b6e9-514e-e481-be7b-ab1b52a667fb@schaufler-ca.com>
In-Reply-To: <d041b6e9-514e-e481-be7b-ab1b52a667fb@schaufler-ca.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Thu, 8 Nov 2018 16:30:13 -0800
Message-ID: <CAJ-EccPiKPR-ZB+V=tTyAB3Gru2n_Pt4PFxEQf_3y_4c8g+TLg@mail.gmail.com>
Subject: Re: [PATCH] LSM: add SafeSetID module that gates setid calls
To:     casey@schaufler-ca.com
Cc:     serge@hallyn.com, jmorris@namei.org,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 8, 2018 at 1:34 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 11/8/2018 12:53 PM, Micah Morton wrote:
> > It seems like the CAP_SETUID_RANGE idea proposed by Serge is mainly a
> > way to avoid silently breaking programs that run with CAP_SETUID,
> > which could cause security vulnerabilities.
>
> It wouldn't be "silent". You'd have to fix anything that needs
> the new capability instead of the old.
>
> > Serge, does Casey's
> > suggestion (killing processes that try to perform unapproved
> > transitions) make sense to you as an alternate way to safeguard
> > against this? Sure there could be regressions, but they would only
> > happen to users for which whitelist policies had been configured, and
> > killing processes should be an effective way of identifying any
> > missing whitelist policies on the system for some restricted user.
>
> I'll point out that seccomp uses the "kill what you deny" approach.
> It would be one thing if it was reasonable to assume that programs
> are checking their error returns, but we know they're not.

Totally agree

>
> > One
> > less attractive thing about adding a CAP_SETUID_RANGE capability would
> > be that more of the common kernel code would have to be modified to
> > add a new capability, whereas currently the LSM just uses the LSM
> > hooks.
>
> That's got to be a secondary consideration. If CAP_SETUID_RANGE
> were the right solution the additional work would be worth doing.
>
> > The other unresolved aspect here (discussed by Stephen above) is how
> > to "know" that ns_capable(..., CAP_SETUID) was called by sys_set*uid
> > and not some other kernel code path.
>
> It sounds like you want a new LSM hook (security_uid_change?) to
> put in that/those code path/paths. That would be a lot cleaner than
> trying to infer the syscall.

Providing a new LSM hook would be tricky, because there are places
(besides sys_set*id) that call ns_capable(..., CAP_SETUID) which we
would want to fail if there were whitelist restrictions for the
current uid: https://elixir.bootlin.com/linux/latest/ident/CAP_SETUID.
Even if we changed all non-sys_set*id code paths to call some hook
that will deny them if the current uid is restricted, I'm not sure
there would be any way to ensure that code paths added in the future
would call the hook to restrict themselves in the event that the user
is restricted. I guess our security_capable hook could always deny the
CAP_SETUID check for restricted users but then change the lines in
kernel/sys.c (e.g.
https://elixir.bootlin.com/linux/latest/source/kernel/sys.c#L584) to
do something like 'if (ns_capable(old->user_ns, CAP_SETUID) ||
security_uid_change(old->uid, new->uid))'. But that would be weird
since security_uid_change would have to redo all the checks that
ns_capable did (to basically say _yes_ if the current user has
CAP_SETUID _and_ the transition is allowed in the whitelist).

I might be missing something, but Stephen's idea seems to make more
sense to me. We already pass the
SECURITY_CAP_AUDIT/SECURITY_CAP_NOAUDIT flags to the security_capable
hook to let it know whether to write an audit message for the check.
Seems like it would be easy to extend this to define more bits (e.g.
SECURITY_SETID_TRANSITION) in that flag or have a more general
mechanism where we pass some kind of struct to security_capable that
contains these flags and possibly other args like Stephen was
mentioning. I'll share a patch for that approach, assuming I don't
realize there is some reason that actually wouldn't be a good idea.

>
> > The reason we need to know this
> > is to be able to distinguish id transitions from other privileged
> > actions (e.g. create/modify/enter user namespace). Certain transitions
> > should be allowed for whitelisted users, but the other privileged
> > actions should be denied (or else the security hardening provided by
> > this LSM is significantly weakened). Do people think the current
> > reliance on comparing the return value of syscall_get_nr() to
> > arch-specific syscall constants (e.g. __NR_setuid) is a deal-breaker
> > and we should find an arch-independent solution such as the one
> > proposed by Stephen?
>
> The problem with inferring the syscall is that the mechanism for
> doing so is subject to change and architectural magic.
>
> > Or is checking against arch-specific constants
> > not a big deal and the code can stay as is?
>
> It's bad enough when we have to make LSM code check things
> like what filesystem an inode relates to. I would say that
> you really want a different approach.
>
> > On Fri, Nov 2, 2018 at 12:22 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> >> Quoting Casey Schaufler (casey@schaufler-ca.com):
> >>> On 11/2/2018 11:30 AM, Serge E. Hallyn wrote:
> >>>> Quoting Casey Schaufler (casey@schaufler-ca.com):
> >>>>
> >>>>> Let me suggest a change to the way your LSM works
> >>>>> that would reduce my concerns. Rather than refusing to
> >>>>> make a UID change that isn't on your whitelist, kill a
> >>>>> process that makes a prohibited request. This mitigates
> >>>>> the problem where a process doesn't check for an error
> >>>>> return. Sure, your system will be harder to get running
> >>>>> until your whitelist is complete, but you'll avoid a
> >>>>> whole category of security bugs.
> >>>> Might also consider not restricting CAP_SETUID, but instead adding a
> >>>> new CAP_SETUID_RANGE capability.  That way you can be sure there will be
> >>>> no regressions with any programs which run with CAP_SETUID.
> >>>>
> >>>> Though that violates what Casey was just arguing halfway up the email.
> >>> I know that it's hard to believe 20 years after the fact,
> >>> but the POSIX group worked very hard to ensure that the granularity
> >>> of capabilities was correct for the security policy that the
> >>> interfaces defined in P1003.1. What would CAP_SETUID_RANGE mean?
> >> CAP_SETUID would mean you can switch to any uid.
> >>
> >> CAP_SETUID_RANGE would mean you could make the transitions which have
> >> been defined through <handwave> some mechanism.  Be it prctl, or some
> >> new security.uidrange xattr, or the mechanism Micah proposed, except
> >> it only applies for CAP_SETUID_RANGE not CAP_SETUID.
> >>
> >> -serge
>
