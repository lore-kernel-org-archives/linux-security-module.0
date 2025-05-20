Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2DE1D8DE1;
	Tue, 20 May 2025 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747772432; cv=none; b=RcfVwmIyWkeleS/uo+RIKAAuUHbcN08EHA08qs/jVG7FA5DCfQSPalw/mtsIHvu5hJXN0AzxG65Ig+i6nFyzbntaavH7bQTnguP1fXi1ulOdYCAgcyKDduvhXsww/j70fTqmmgcKaQHjEAXaHxdvgwlwenlxj2ZvnM7WHkH8vLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747772432; c=relaxed/simple;
	bh=TB7KUPAA/+hO+X3P8oeWLd2+l/tAXTTsTaO4pzWAyYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmGnzIcCCJSTabcQ2OXf8mgSxAJ6F4D4Y4PSqt7wIWigoYLEtIsK5Pe9/NVKVQiPjIV9+K9oY4+gifV6Ot+B+a0Z+0t4BBq5dT5wCDQXJbdA4PNq+Vf6y7eZVa3K4CiJLQ+60bOzt/j/5U0Yupb8WPUxGBuBcfDyXCkhIv3Watk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1s/Xc7/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1s/Xc7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8D2C4CEE9;
	Tue, 20 May 2025 20:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747772431;
	bh=TB7KUPAA/+hO+X3P8oeWLd2+l/tAXTTsTaO4pzWAyYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1s/Xc7/9ulM1jdL58nP47MVZZcNNoY1dt9L6rLBL6GtQWruSlSfmCWGsgZWJQNcx
	 dSh8FdV53DIFTLZPsZ1MZvRGr1YKl1gP/e53f6LB9BvTU/K+HeI4kD/ruIUaiz3vne
	 3qdih0e6to7Tls9aXCC6NWms3U+moB3j2Tv0S1wQ41av5VF+gwbwTznD/myqREisKQ
	 zhVq17wHiXXawg1i8GVsA6PwIu7oQf8ZlfqfznPqVdc/cUCQHsEOXP162L1JUK2+49
	 IEpxi290jZu9ZP1g6gN6b/QLortNeDTiNVB9JOwp6Ti6B/iTU5QX314Q3MGHBJ7SqS
	 cVCgNezR+i3Pw==
Date: Tue, 20 May 2025 13:20:28 -0700
From: Kees Cook <kees@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jann Horn <jannh@google.com>, Max Kellermann <max.kellermann@ionos.com>,
	"Serge E. Hallyn" <serge@hallyn.com>, paul@paul-moore.com,
	jmorris@namei.org, Andy Lutomirski <luto@kernel.org>,
	morgan@kernel.org, Christian Brauner <christian@brauner.io>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Correct the permission check for unsafe exec
Message-ID: <202505201319.D57FDCB2A@keescook>
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <878qmxsuy8.fsf@email.froward.int.ebiederm.org>
 <202505151451.638C22B@keescook>
 <87ecwopofp.fsf@email.froward.int.ebiederm.org>
 <CAG48ez1VpuTR9_cvLrJEMmjOxTCYpYFswXVPmN6fE3NcSmPPVA@mail.gmail.com>
 <87wmagnnhq.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wmagnnhq.fsf@email.froward.int.ebiederm.org>

On Fri, May 16, 2025 at 06:29:21PM -0500, Eric W. Biederman wrote:
> Jann Horn <jannh@google.com> writes:
> 
> > On Fri, May 16, 2025 at 5:26 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> Kees Cook <kees@kernel.org> writes:
> >>
> >> > On Thu, May 15, 2025 at 11:24:47AM -0500, Eric W. Biederman wrote:
> >> >> I have condensed the logic from Linux-2.4.0-test12 to just:
> >> >>      id_changed = !uid_eq(new->euid, old->euid) || !in_group_p(new->egid);
> >> >>
> >> >> This change is userspace visible, but I don't expect anyone to care.
> >> >> [...]
> >> >> -static inline bool __is_setuid(struct cred *new, const struct cred *old)
> >> >> -{ return !uid_eq(new->euid, old->uid); }
> >> >> -
> >> >> -static inline bool __is_setgid(struct cred *new, const struct cred *old)
> >> >> -{ return !gid_eq(new->egid, old->gid); }
> >> >> -
> >> >> [...]
> >> >> -    is_setid = __is_setuid(new, old) || __is_setgid(new, old);
> >> >> +    id_changed = !uid_eq(new->euid, old->euid) || !in_group_p(new->egid);
> >> >
> >> > The core change here is testing for differing euid rather than
> >> > mismatched uid/euid. (And checking for egid in the set of all groups.)
> >>
> >> Yes.
> >>
> >> For what the code is trying to do I can't fathom what was trying to
> >> be accomplished by the "mismatched" uid/euid check.
> >
> > I remember that when I was looking at this code years ago, one case I
> > was interested in was what happens when a setuid process (running with
> > something like euid=1000,ruid=0) execve()'s a normal binary. Clearly
> > the LSM_UNSAFE_* stuff is not so interesting there, because we're
> > already coming from a privileged context; but the behavior of
> > bprm->secureexec could be important.
> >
> > Like, I think currently a setuid binary like this is probably (?) not
> > exploitable:
> >
> > int main(void) {
> >   execl("/bin/echo", "echo", "hello world");
> > }
> >
> > but after your proposed change, I think it might (?) become
> > exploitable because "echo" would not have AT_SECURE set (I think?) and
> > would therefore load libraries based on environment variables?
> 
> Yes.  bprm->secureexec controls AT_SECURE.
> 
> I am fine if we want to set secureexec and AT_SECURE in this situation.
> It is a bit odd, but I don't see a problem with that.

So the idea would be that uid/euid mismatch would still induce AT_SECURE?

That seems reasonable.

I was already waiting for the after the coming merge window to put this
into -next, so if you cant update it for the AT_SECURE logic, we can
give that a try and see what we get.

Thanks!

-Kees

-- 
Kees Cook
