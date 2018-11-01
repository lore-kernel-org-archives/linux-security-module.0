Return-Path: <SRS0=OxMS=NM=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A033DC0044C
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Nov 2018 15:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFE6205F4
	for <linux-security-module@archiver.kernel.org>; Thu,  1 Nov 2018 15:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFE6205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbeKBBAL (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:00:11 -0400
Received: from mail.hallyn.com ([178.63.66.53]:37904 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbeKBBAK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 1 Nov 2018 21:00:10 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 20990B30; Thu,  1 Nov 2018 15:56:36 +0000 (UTC)
Date:   Thu, 1 Nov 2018 15:56:36 +0000
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Micah Morton <mortonm@chromium.org>,
        Kees Cook <keescook@chromium.org>, jmorris@namei.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LSM: add SafeSetID module that gates setid calls
Message-ID: <20181101155636.GA11038@mail.hallyn.com>
References: <20181031152846.234791-1-mortonm@chromium.org>
 <20181031210245.GA3537@mail.hallyn.com>
 <CAGXu5jJN4Z8RiweDjRTpEbhVsb=js0N2-w1Xy12o6nrkZE9gwA@mail.gmail.com>
 <49f92f71-ba6f-9991-af95-03b04a42b6d0@schaufler-ca.com>
 <CAJ-EccPCxi1Fn-TVnGHBADKuoSi3XC0_UAkXRk49+iTjoLoecA@mail.gmail.com>
 <20181101061322.GB7132@mail.hallyn.com>
 <2d8b8ee8-0087-b9c2-f20d-90108e0b18bd@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d8b8ee8-0087-b9c2-f20d-90108e0b18bd@schaufler-ca.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Quoting Casey Schaufler (casey@schaufler-ca.com):
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

Yes, but I don't think an unprivileged user can make that happen.
If you look at the patch, you require cap_sys_admin againt your
user namespace in order to limit the uid range.  So either you
were privileged to begin with, or you create a new user namespace.
If you create a new userns, you can only map uids which are delegated
to you - presumably not tss - into that namespace.

> It would be easy for an inexperienced or malicious admin to
> include cschaufler:tss in the whitelist but miss on adding
> tss:cschaufler.

Well, it's also pretty easy for an admin to add 0 or tss into
serge's delegated mappings in /etc/subuid, I suppose...

Now I hadn't noticed the one-way directional nature of these
whitelist entries.  I'd been asuming there was just a set of
ids it was allowed to transition to it.  Not sure which is
better, I can see pros/cons to both.
