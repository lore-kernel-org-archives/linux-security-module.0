Return-Path: <SRS0=rvaM=NT=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A10ECDE4B
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Nov 2018 20:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965E820825
	for <linux-security-module@archiver.kernel.org>; Thu,  8 Nov 2018 20:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NFkgWafF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965E820825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeKIGbR (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:31:17 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46958 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeKIGbR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Nov 2018 01:31:17 -0500
Received: by mail-yb1-f196.google.com with SMTP id i17-v6so2609398ybp.13
        for <linux-security-module@vger.kernel.org>; Thu, 08 Nov 2018 12:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TUVfpg9ZejJTWV79oCgJTVCECAsa0mJwNTSCrG3WRto=;
        b=NFkgWafFiomjyveYoWDIk+2toi58INS1PxTSlZu6oxOyZln5lOZhKrumm0RNjZazpQ
         OGGHcImT7PpRzdzaWKJvOVckrloJ2Md+5Vw7qMj7jj02wckRK2Nsn05FQIDoFC2lKEde
         b5d9aKbe3VoIcKmKc05FTsOhXFdXkspLOlz/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TUVfpg9ZejJTWV79oCgJTVCECAsa0mJwNTSCrG3WRto=;
        b=t8nxfTXSrcUjYucQkwoDOM1de59oNEvAyJeN9bUc01XT2QcsD4lO8cLKoRR1XUbAHx
         L/XiqsrWbNbk9zqGlaKGMHXIckx0C+0CGKNspfOuOPGMU7CzMCdaKNzsqoIfS5tSuYuo
         19RsJ9Sd2i/E2UVgywXiCZ2dMPtQjLJwffPun1ipnRTXphPWbDRZAzSB7HaS7MJ3O4fK
         ipsJf8QqBrokPpxkxLg6J5romiXQpdDWgeKBqL0Ti66712GZITCn5v0jwVbhh6/gP3rW
         keJhsYrM3ZrcWR4QFxpNrZ4ykSDqxfiwKWteb+Ed82cfJOYRWD2966ued69aGqj0FwgW
         Rn0Q==
X-Gm-Message-State: AGRZ1gKFpbxgGUTsU5dn6i+5sy0Kv07sj6RfmD5lnalTY3f157M6ZIlz
        xFrSd3GejsqSL/SATCcu3l97n+uemSHV7Mn3TJOjHQ==
X-Google-Smtp-Source: AJdET5dqgybclbA227NvyURL0T4sluju1Qzeqeh8jpXCC9/zCVnXEfp6a90iuk+IFtgxjeUbvJPfTAgws8KYQJSfh70=
X-Received: by 2002:a25:4a88:: with SMTP id x130-v6mr6069753yba.97.1541710442648;
 Thu, 08 Nov 2018 12:54:02 -0800 (PST)
MIME-Version: 1.0
References: <20181031210245.GA3537@mail.hallyn.com> <20181101060737.GA7132@mail.hallyn.com>
 <CAJ-EccMaAu+g55Nuh1nZqt3Ld-YEgDiT_ewdQzGtFGmzRgXckw@mail.gmail.com>
 <41daea64-03c0-0970-c405-d1a5ae134181@schaufler-ca.com> <CAJ-EccNO8DeER3VUyyxO-CD_qBmzasMvZuUsbdWgcfiAjRcsFw@mail.gmail.com>
 <3a3231b3-44b3-b330-2cda-d4246bca35be@schaufler-ca.com> <CAJ-EccMU9mtyA1qwXYEqHP9vXZEBiuCfdG3KTrAA-hQ+Y-CANg@mail.gmail.com>
 <5c7e1a80-c534-6adb-be19-58bb0d97084f@schaufler-ca.com> <20181102183056.GA20738@mail.hallyn.com>
 <b1f95526-d0f1-712e-e0a7-9710cae7e1f0@schaufler-ca.com> <20181102192227.GA21498@mail.hallyn.com>
In-Reply-To: <20181102192227.GA21498@mail.hallyn.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Thu, 8 Nov 2018 12:53:51 -0800
Message-ID: <CAJ-EccMrP_agdiPNpCjA9V4iDt+LgA2K3uFV3qVJBVVow-cC7w@mail.gmail.com>
Subject: Re: [PATCH] LSM: add SafeSetID module that gates setid calls
To:     serge@hallyn.com
Cc:     casey@schaufler-ca.com, jmorris@namei.org,
        Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

It seems like the CAP_SETUID_RANGE idea proposed by Serge is mainly a
way to avoid silently breaking programs that run with CAP_SETUID,
which could cause security vulnerabilities. Serge, does Casey's
suggestion (killing processes that try to perform unapproved
transitions) make sense to you as an alternate way to safeguard
against this? Sure there could be regressions, but they would only
happen to users for which whitelist policies had been configured, and
killing processes should be an effective way of identifying any
missing whitelist policies on the system for some restricted user. One
less attractive thing about adding a CAP_SETUID_RANGE capability would
be that more of the common kernel code would have to be modified to
add a new capability, whereas currently the LSM just uses the LSM
hooks.

The other unresolved aspect here (discussed by Stephen above) is how
to "know" that ns_capable(..., CAP_SETUID) was called by sys_set*uid
and not some other kernel code path. The reason we need to know this
is to be able to distinguish id transitions from other privileged
actions (e.g. create/modify/enter user namespace). Certain transitions
should be allowed for whitelisted users, but the other privileged
actions should be denied (or else the security hardening provided by
this LSM is significantly weakened). Do people think the current
reliance on comparing the return value of syscall_get_nr() to
arch-specific syscall constants (e.g. __NR_setuid) is a deal-breaker
and we should find an arch-independent solution such as the one
proposed by Stephen? Or is checking against arch-specific constants
not a big deal and the code can stay as is?
On Fri, Nov 2, 2018 at 12:22 PM Serge E. Hallyn <serge@hallyn.com> wrote:
>
> Quoting Casey Schaufler (casey@schaufler-ca.com):
> > On 11/2/2018 11:30 AM, Serge E. Hallyn wrote:
> > > Quoting Casey Schaufler (casey@schaufler-ca.com):
> > >
> > >> Let me suggest a change to the way your LSM works
> > >> that would reduce my concerns. Rather than refusing to
> > >> make a UID change that isn't on your whitelist, kill a
> > >> process that makes a prohibited request. This mitigates
> > >> the problem where a process doesn't check for an error
> > >> return. Sure, your system will be harder to get running
> > >> until your whitelist is complete, but you'll avoid a
> > >> whole category of security bugs.
> > > Might also consider not restricting CAP_SETUID, but instead adding a
> > > new CAP_SETUID_RANGE capability.  That way you can be sure there will be
> > > no regressions with any programs which run with CAP_SETUID.
> > >
> > > Though that violates what Casey was just arguing halfway up the email.
> >
> > I know that it's hard to believe 20 years after the fact,
> > but the POSIX group worked very hard to ensure that the granularity
> > of capabilities was correct for the security policy that the
> > interfaces defined in P1003.1. What would CAP_SETUID_RANGE mean?
>
> CAP_SETUID would mean you can switch to any uid.
>
> CAP_SETUID_RANGE would mean you could make the transitions which have
> been defined through <handwave> some mechanism.  Be it prctl, or some
> new security.uidrange xattr, or the mechanism Micah proposed, except
> it only applies for CAP_SETUID_RANGE not CAP_SETUID.
>
> -serge
