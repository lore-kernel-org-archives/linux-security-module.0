Return-Path: <SRS0=OxMS=NM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B0CC6786F
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Nov 2018 16:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C52A2081B
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Nov 2018 16:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RGggy1wY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C52A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbeKBBWX (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:22:23 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34874 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbeKBBWW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Nov 2018 21:22:22 -0400
Received: by mail-yw1-f67.google.com with SMTP id w135-v6so5900109ywd.2
        for <linux-security-module@vger.kernel.org>; Thu, 01 Nov 2018 09:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ddIJPyxJS5d6Wl9Umni0oeBo7eY+pVx4J05JnotYFS4=;
        b=RGggy1wYwvk7v2U6ZSRSYDDKgEP/IOs4QxKnE85sGgJkSbIdRbN890uvTXbl4d9Xdp
         KRP7OnJspzpaIvhGPD+Dx3ZrdUa7vrHI7CoG3XLVfNqDzw/sOlyGhrQrurLnOYQwZO0C
         TMquLD1gsD7LlGh0G8CGbH3/MwRAK07TETBj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ddIJPyxJS5d6Wl9Umni0oeBo7eY+pVx4J05JnotYFS4=;
        b=IYzYrVq9g0eM6VRvE+SGyVANqtXZkChHL8emjJ0u4sXtnq2CP7hL+ecl4k5DxZ/q3i
         Ey6zMg6qp+bUOkPBV9n44JQsLDzcZfSrLD/GpTxRxDtkr4UBOqH/XOu/mLYEnVyQKxtg
         OzXxI8l9W1MEWY8SRrJUYyYm2u37WnSqIx7NFpk7/FIKgDafgGjKLD8HBTxlqoitpyCs
         T450qlgC5dD4hV79eqfG8mySjCfnJ/BCeZ8S/IDsH7ejWSGmJ0ToiUBk3y9qgl26etLz
         C8BGigkmqaBo4ccY0bF6pVlToshH34J6MiiU8WHnmcFvln1jG9lguBfQgpLteggn5+RC
         i+Aw==
X-Gm-Message-State: AGRZ1gK2U+jisHwkTBu4bt4ZVcyXSCIvMYxJbGg2tH+dnfclx3tr5d5m
        kd5lrEG1uibO+Xk3MP7BuLdlPhvQ6TpeFB4mK8hXhg==
X-Google-Smtp-Source: AJdET5fGg4S63w9Jh5w1PeIVVVMUiBo7yrMY0wCS+8QGkgPTVdq9zmTaZpiT8R9GK0XeyaFwtzE5pWuSnXfLQa0A7oU=
X-Received: by 2002:a81:834e:: with SMTP id t75-v6mr7741380ywf.428.1541089124185;
 Thu, 01 Nov 2018 09:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181031152846.234791-1-mortonm@chromium.org> <20181031210245.GA3537@mail.hallyn.com>
 <CAGXu5jJN4Z8RiweDjRTpEbhVsb=js0N2-w1Xy12o6nrkZE9gwA@mail.gmail.com>
 <49f92f71-ba6f-9991-af95-03b04a42b6d0@schaufler-ca.com> <CAJ-EccPCxi1Fn-TVnGHBADKuoSi3XC0_UAkXRk49+iTjoLoecA@mail.gmail.com>
 <20181101061322.GB7132@mail.hallyn.com> <2d8b8ee8-0087-b9c2-f20d-90108e0b18bd@schaufler-ca.com>
In-Reply-To: <2d8b8ee8-0087-b9c2-f20d-90108e0b18bd@schaufler-ca.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Thu, 1 Nov 2018 09:18:32 -0700
Message-ID: <CAJ-EccORvzih7D+9+0JfRTjR=057Uie0HKut1+WAPnVZhT4NLw@mail.gmail.com>
Subject: Re: [PATCH] LSM: add SafeSetID module that gates setid calls
To:     casey@schaufler-ca.com
Cc:     serge@hallyn.com, Kees Cook <keescook@chromium.org>,
        jmorris@namei.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 1, 2018 at 8:39 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 10/31/2018 11:13 PM, Serge E. Hallyn wrote:
> > On Wed, Oct 31, 2018 at 06:12:46PM -0700, Micah Morton wrote:
> >> On Wed, Oct 31, 2018 at 3:37 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>> On 10/31/2018 2:57 PM, Kees Cook wrote:
> >>>> On Wed, Oct 31, 2018 at 2:02 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> >>>>> Just to be sure - your end-goal is to have a set of tasks which have
> >>>>> some privileges, including CAP_SETUID, but which cannot transition to
> >>>>> certain uids, perhaps including root?
> >> Correct, only whitelisted uids can be switched to. This only pertains
> >> to CAP_SETUID, other capabilities are not affected.
> >>
> >>>> AIUI, the issue is that CAP_SETUID is TOO permissive. Instead, run
> >>>> _without_ CAP_SETUID and still allow whitelisted uid transitions.
> >> Kees is right that this LSM only pertains to a single capability:
> >> CAP_SETUID (future work could tackle CAP_SETGID in the same fashion)
> >> -- although the idea here is to put in per-user limitations on what a
> >> process running as that user can do even when it _has_ CAP_SETUID. So
> >> it doesn't grant any extra privileges to processes that don't have
> >> CAP_SETUID, only restricts processes that _do_ have CAP_SETUID if the
> >> user they are running under is restricted.
> >>
> >>> I don't like that thought at all at all. You need CAP_SETUID for
> >>> some transitions but not all. I can call setreuid() and restore
> >>> the saved UID to the effective UID. If this LSM works correctly
> >>> (I haven't examined it carefully yet) it should prevent restoring
> >>> the effective UID if there isn't an appropriate whitelist entry.
> >> Yep, thats how it works. The idea here is that you still need
> >> CAP_SETUID for all transitions, regardless of whether whitelist
> >> policies exist or not.
> >>
> >>> It also violates the "additional restriction" model of LSMs.
> > Does it, or does the fact that CAP_SETUID is still required in order
> > to change uids address that?
>
> Yes, it does. Reading Kees' response had me a little concerned.
>
> >>> That has the potential to introduce a failure when a process tries
> >>> to give up privilege. If 0:1000 isn't on the whitelist but 1000:0
> >> As above, if a process drops CAP_SETUID it wouldn't be able to do any
> >> transitions (if this is what you mean by give up privilege). The
> >> whitelist is a one-way policy so if one wanted to restrict user 123
> >> but let it switch to 456 and back, 2 policies would need to be added:
> >> 123 -> 456 and 456 -> 123.
> >>
> >>> is Bad Things can happen. A SUID root program would be unable to
> >>> give up its privilege by going back to the real UID in this case.
> > Yes, this was the root cause of the "sendmail capabilities bug"
>
> I'm very familiar with that particular bug, as Bob Mende's
> work to convert sendmail to using capabilities was done for
> a project I owned. The blowback against all things security
> was pretty intense.
>
> >  - a
> > privileged daemon which could be made to run with slightly less
> > privilege in such a way that it failed to drop privilege, then continued
> > ot run with some privilege.
> >
> > But the key trigger there was that an unprivileged task could prevent
> > the more privileged task from dropping its privilege.
> >
> > Is that the case here?
>
> I think it is reasonably safe to assume that there
> are many instances of programs that don't handle errors
> from setreuid() in the reset case. Without privilege
> setreuid() can be used to swap effective and real UIDs.

This LSM won't interfere with any of the one-off transitions allowed
by the set*uid family of syscalls that don't require CAP_SETUID. See
safesetid_task_fix_setuid in lsm.c.

>
> >   It might be...  If one of the uid-restricted
> > tasks running with CAP_SETUID runs a filter over some malicious data
> > which forces it to run a program which intends to change its uid and
> > fails to detect that that failed.  It's not quite as cut-and-dried
> > though, and if we simply do not allow uid 0 to be in the set of uids,
> > that may prevent any such cases.
>
> Alas, UID 0 is not the only case we have to worry about.
> If I run a program owned by tss (Trousers) with the setuid
> bit set it will change the effective UID to tss. If this
> program expects to switch effective UID back to me and
> the SafeSetID whitelist prevents it, Bad Things may happen
> even though no capabilities or root privilege where ever
> involved.
>
> It would be easy for an inexperienced or malicious admin to
> include cschaufler:tss in the whitelist but miss on adding
> tss:cschaufler.
>

Same as above, this LSM will only affect transitions that would need
CAP_SETUID. AFAICT switching the effective UID back after that
setuid-bit scenario is not something that requires CAP_SETUID, and
thus would continue to work as it always has in Linux.
