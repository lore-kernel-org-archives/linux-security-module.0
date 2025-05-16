Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80021BFE00;
	Fri, 16 May 2025 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747431982; cv=none; b=IF+TQ9P7A+IVUdcS7XWHXkjma1i616fJ2YEFFI65TavNlEB/40t9j6aNM5msCsFQZtgIHd0KpL+3ur/3l+aGY6gM7B8BMwmk68zyyTZBBHem7xOD4iWdUXdUxZLyq5WlezeKsK48vESGy5jukQ9shYTD3AcbPqmWq48nwrvo6KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747431982; c=relaxed/simple;
	bh=QSr9dvEqEvZ5KXDHAKZfRnA6aJDAdewYDdN0qbQGlHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrBywfYJ5a5NwCAQqqs1QSTkSIi2bz96ufrZlomfbo81B3wYhiWzfGTQNUwP/4pc1ykawZk/FvvrryFJCT0b3u8HiZWUOhRAQCIjFF4zJ13lgdupwxpfb6sBqDeTevgQLhBgt82Z+K45GnavGO1eQZJSGHTxLNva9PyWKTj8u+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmHNsO9F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmHNsO9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E36C4CEE4;
	Fri, 16 May 2025 21:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747431982;
	bh=QSr9dvEqEvZ5KXDHAKZfRnA6aJDAdewYDdN0qbQGlHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DmHNsO9FWBfhhc+ZVNNW0YZl/zSpmowCehdKKr0ihvRm1mMddlN7VPSvSxX33I6XS
	 nGA1QZ+BchgVyxsdzP9rQYQKtoVZi3KBDnSRMWpK5n5gmMmgwhJMYZet/rkhd1LIGs
	 fqu4DUHIuI4fZh7JOT2qSUzb6LKqBcJJQbxZNtq4v7M3LQTdacXhJVBEFsp62K/uE8
	 AkemTPjj99HhxLVmINSYQYh0r2GfdwEHj3Cra4se3LSzo4sEsWb49mPQ5sXqjJ9Kg3
	 O5S5l558yCckqrKz9PSg8Hsp3dtsrFHFP1s3VEuptsbWRfbBBz0xiHbi6Ge9lNEEfH
	 wQyjo6pzULzFw==
Date: Fri, 16 May 2025 21:46:16 +0000
From: sergeh@kernel.org
To: Jann Horn <jannh@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Max Kellermann <max.kellermann@ionos.com>,
	"Serge E. Hallyn" <serge@hallyn.com>, paul@paul-moore.com,
	jmorris@namei.org, Andy Lutomirski <luto@kernel.org>,
	morgan@kernel.org, Christian Brauner <christian@brauner.io>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Correct the permission check for unsafe exec
Message-ID: <aCeyKHNDbPLWQP0i@lei>
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <878qmxsuy8.fsf@email.froward.int.ebiederm.org>
 <202505151451.638C22B@keescook>
 <87ecwopofp.fsf@email.froward.int.ebiederm.org>
 <CAG48ez1VpuTR9_cvLrJEMmjOxTCYpYFswXVPmN6fE3NcSmPPVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1VpuTR9_cvLrJEMmjOxTCYpYFswXVPmN6fE3NcSmPPVA@mail.gmail.com>

On Fri, May 16, 2025 at 08:06:15PM +0200, Jann Horn wrote:
> On Fri, May 16, 2025 at 5:26 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> > Kees Cook <kees@kernel.org> writes:
> >
> > > On Thu, May 15, 2025 at 11:24:47AM -0500, Eric W. Biederman wrote:
> > >> I have condensed the logic from Linux-2.4.0-test12 to just:
> > >>      id_changed = !uid_eq(new->euid, old->euid) || !in_group_p(new->egid);
> > >>
> > >> This change is userspace visible, but I don't expect anyone to care.
> > >> [...]
> > >> -static inline bool __is_setuid(struct cred *new, const struct cred *old)
> > >> -{ return !uid_eq(new->euid, old->uid); }
> > >> -
> > >> -static inline bool __is_setgid(struct cred *new, const struct cred *old)
> > >> -{ return !gid_eq(new->egid, old->gid); }
> > >> -
> > >> [...]
> > >> -    is_setid = __is_setuid(new, old) || __is_setgid(new, old);
> > >> +    id_changed = !uid_eq(new->euid, old->euid) || !in_group_p(new->egid);
> > >
> > > The core change here is testing for differing euid rather than
> > > mismatched uid/euid. (And checking for egid in the set of all groups.)
> >
> > Yes.
> >
> > For what the code is trying to do I can't fathom what was trying to
> > be accomplished by the "mismatched" uid/euid check.
> 
> I remember that when I was looking at this code years ago, one case I
> was interested in was what happens when a setuid process (running with
> something like euid=1000,ruid=0) execve()'s a normal binary. Clearly
> the LSM_UNSAFE_* stuff is not so interesting there, because we're
> already coming from a privileged context; but the behavior of
> bprm->secureexec could be important.
> 
> Like, I think currently a setuid binary like this is probably (?) not
> exploitable:
> 
> int main(void) {
>   execl("/bin/echo", "echo", "hello world");
> }
> 
> but after your proposed change, I think it might (?) become
> exploitable because "echo" would not have AT_SECURE set (I think?) and
> would therefore load libraries based on environment variables?
> 
> To be clear, I think this would be a stupid thing for userspace to do
> - a setuid binary just should not be running other binaries with the
> caller-provided environment while having elevated privileges. But if
> userspace was doing something like that, this change might make it
> more exploitable, and I imagine that the check for mismatched uid/euid
> was intended to catch cases like this?

If the original process became privileged by executing a setuid-root
file (and uses glibc), then LD_PRELOAD will already have been cleared,
right?  So it would either have to add the unsafe entries back to
LD_PRELOAD again, or it has to have been root all along, not a
setuid-root program.  I think at that point we have to say this is what
it intended, and possibly with good reason.

-serge
