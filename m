Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C15224AFB;
	Thu,  8 May 2025 22:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746742362; cv=none; b=gmA9aIOXSjTPTt8J341CXSqtSIqGKtzz49F/0oapfgRhJK2sEtUKPMSbmV8c1IjIMF9UiDTakuoAC5/CFH+TvjOjqlTfkBV2UUydhMypa66lWXzF6dKvAIDZkfNBueVWbxoAdiGyqbGd6TtwVrarWJB/FDWIiIVAj6ECgJMdQXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746742362; c=relaxed/simple;
	bh=VvvPjYDsHNVZTBtifZ5ix10ghsIB7IUwd4OQzaJUnI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STtYwJFf7k/WPiiYDTcteJe5DUqKle7muTJhS/ZUx3vxaD0g7M0a5KBVQnXQ15o1NCaL9MXs5xoQfkJ7UoYIkCnPZjUyrzseTyTFP4BcRVb4z4FW9g7bf223cBUPLuS/RM4a/GJTKuqMGxXa2WOmSBC20lCqcPGZQu+mbc9BZ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWVldwk+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWVldwk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084B0C4CEE7;
	Thu,  8 May 2025 22:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746742362;
	bh=VvvPjYDsHNVZTBtifZ5ix10ghsIB7IUwd4OQzaJUnI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kWVldwk+ydSU3WliLtNyNsMKotSrkTEOuJXNZe5XxUhOvpt9VNxmHXULxBk57OsVD
	 EUGOMkPCaigeThUCud1DIFTMPnD1V3jUOWxIU1SeuQaw+JSemX/oI9Qzy/soOPcw2g
	 1on3ZcC4wwpK/c5gY3RXMSKtcSid3F4XKK9m9QhtyYKwvKNHhcR+FxL5YN6r9J34PZ
	 aXnZYbavuvjt08EnOOEA+y246jhhr3V9vGhsYWF1KDTLZooeyX0ZGsetdSc0l8/+Fn
	 z/oYBs22mpogUCeQxMDGow1Mc4tyJrLNh0X0ZalrO0DoQmYEw8GTo0NLUcbWGR9t8X
	 BpJYg+KOgXfBg==
Date: Thu, 8 May 2025 22:12:37 +0000
From: sergeh@kernel.org
To: Max Kellermann <max.kellermann@ionos.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>,
	paul@paul-moore.com, jmorris@namei.org, kees@kernel.org,
	morgan@kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] security/commoncap: don't assume "setid" if all ids are
 identical
Message-ID: <aB0sVcjFZaCVEirH@lei>
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <20250309151907.GA178120@mail.hallyn.com>
 <CAKPOu+_vTuZqsBLfRH+kyphiWAtRfWq=nKAcAYu=Wn2JBAkkYg@mail.gmail.com>
 <20250506132158.GA682102@mail.hallyn.com>
 <CAKPOu+9JCLVpJ-g_0WwLm5oy=9sq=c9rmoAJD6kNatpMZbbw9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+9JCLVpJ-g_0WwLm5oy=9sq=c9rmoAJD6kNatpMZbbw9w@mail.gmail.com>

On Tue, May 06, 2025 at 04:51:39PM +0200, Max Kellermann wrote:
> On Tue, May 6, 2025 at 3:22 PM Serge E. Hallyn <serge@hallyn.com> wrote:
> > Just to quibble here: I don't use NO_NEW_PRIVS, but it seems to me quite
> > likely that your claim is wrong here.  The whole SECBIT_KEEP_CAPS etc
> > dance is based on the idea that you understand that once you exec, you
> > lose some of your existing privilege.  Similarly, it seems quite
> > likely to me that people using NO_NEW_PRIVS understand, expect, and
> > count on the fact that their effective ids will be cleared on exec.
> 
> One could define NO_NEW_PRIVS that way, but that's not how it is documented.
> Of course, we can't rule out that somewhere, somebody exists who
> relies on the current behavior, and that we must preserve it for ABI
> stability (I think this was your point). If you desire ABI stability,
> then this behavior should really be documented.

ABI stability is about the most important thing to Linus, so yes, if
documentation and code disagree, then we should fix the documentation,
except in the case where the current behavior just really is wrong
or insecure.

> To me, the current implementation looks weird and buggy (but that's
> just my opinion). The code figures that that it's a set-id exec when
> effective!=real, which is indeed how set-id execution looks like, but
> still that check is slightly off:

Here's my current reading:

The bprm->cred is initially set from current's, with suid and fsuid set
to euid.  So new->euid will be same as old->euid.  Then
bprm_creds_from_file() will call bprm_fill_uid() right before
security_bprm_creds_from_file().  bprm_fill_uid() will set new->euid to
the file's i_uid - only if the setuid bit is set AND only if not
task_no_new_privs(current).  Meaning that for NNP tasks it never sets
new->euid to the file's i_uid.

I think the summary is that I don't object to your patch per se (except
the ambient creds part, which I'll reply to later - oh and possibly the
potential for capability dropping, also for later), but your
terminology.  setuid and setgid mean something very specific: a file
which, when any user executes it, causes execution to happen under the
file's owner credentials.  And the behavior you are changing has nothing
to do with that.  What you are changing is that a NNP process with
different ruid and euid will continue to run, after exec, with those
previous ruid and euid, whether or not the file is setXid.

> 1. it's really only set-id when new!=old; checking real!=effective is
> conceptually the wrong angle
> 2. there may be other reasons why real!=effective
> 
> My patch is an attempt to fix this in an unintrusive way, by not
> rewriting it but adding another check to rule out some special case.
> If I were to rewrite this from scratch, I'd do it differently (only
> compare new!=old), but I don't want to mess too much with security
> code that I'm not very familiar with. I believe the guy who initially
> wrote it made wrong assumptions, but maybe I'm just wrong, I'm not the
> expert here.
> 
> > Note also that so far I'm only asking about the intent of the patch.
> 
> In a shared webhosting environment, we want to run an Apache (or
> nginx) in each website's container. If the website owner does "chmod
> 600", the Apache should not be able to read the file; but PHP
> processes spawned by the Apache should have full access. Therefore, we
> run Apache with a different fsuid; when Apache executes PHP, the fsuid
> is reverted.
> 
> But how to spawn Apache with a different fsuid? Not possible directly
> (fsuid is always reverted on exec), but by giving it a different euid
> (and ruid = website uid), granting it access to that secondary uid.
> After exec, Apache swaps uids, sets effective=real=apache_uid, and
> fsuid=website_uid.
> That works fine, until we enable NO_NEW_PRIVS - which is surprising,
> because we indeed don't want any new privs - just keep the existing
> ones.
> The documentation doesn't explain this behavior, and we don't want to
> omit NO_NEW_PRIVS as a workaround.
> 
> > Apart from that, I do think the implementation is wrong, because you
> > are impacting non-NO_NEW_PRIVS behavior as well, such as calculation
> > of cap_permitted and the clearing of ambient capabilities.
> 
> You are right, it affects all three code blocks that are checking
> "is_setid", but why do you believe it's wrong?
> I can move the new check to the bottom, covering only the
> "secureexec=1" line, if that worries you.
> 
> What sure is flawed is that my patch description fails to mention the
> other two changes. Sorry for that, I'll amend the description (if/when
> we agree that my patch is ok).
> 
> Though I do believe that all 3 changes are correct. Why would you want
> to clear ambient capabilities just because real!=effective? The
> manpage says: "Executing a program that changes UID or GID due to the
> set-user-ID or set-group-ID bits or executing a program that has  any
> file  capabilities set will clear the ambient set."
> 
> Documentation and code disagree! Currently, the kernel does not check
> for "changes UID/GID", but whether effective!=real. These two are
> orthogonal, the kernel is buggy, and my patch makes it a little bit
> more correct (but does not remove the wrong real!=effective check, see
> above).
> 
> > And, I'm not sure the has_identical_uids_gids() is quite right, as I'm
> > not sure what the bprm->cred->fsuid and suid make sense, though the
> > process's fsuid and suid of course need to be checked.
> 
> Sorry, I don't get that. What do you mean?

I meant I hadn't yet delved back into the location of bprm_fill_uid()
etc, and I know that code has moved around a bit in the last few years.
