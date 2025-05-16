Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5E318E025;
	Fri, 16 May 2025 21:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747432144; cv=none; b=BBPMsxxYIzTZYJA+UAwpWy+4WJ+5tTT/JkvjjEX5dwHV0Rk7BGe17t2lq1QxE95sY7HBup37/EvZ7x0k9273YNWgOoxNV/mZWugNi/bvLGy8ZIP+pC2VT2LLGHp3PhvuMxXWypydCRdDiE8fsca+E8/WR4gGRp8j1+1r3pxSRf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747432144; c=relaxed/simple;
	bh=z6fGIjQ6IgrPUf6YfeOC/r3O6+HuBRNCpavuG9dU/1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=op+FnDc8DA6D+4c1GYw0Jkix+VG32Pm1RFhkUY0ynCvMMQQqozilqKi3vpjt7GfynRkSP5kvfvZu698ke/uER95z6IQLBqA4DAuZTPeJhTN9SulMwzxX8gsxdTs36uEBunVeR0Vn4B2MNqXyIAMq/SDNJcYsj0oD+dxQLvYY6F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXYo23lP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXYo23lP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C69BC4CEE4;
	Fri, 16 May 2025 21:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747432143;
	bh=z6fGIjQ6IgrPUf6YfeOC/r3O6+HuBRNCpavuG9dU/1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QXYo23lPbg73jUyv4l0tn1Mkov/eNnr0WCxhJinlPRCv+2fFpvr4tWt5qIcUzsMbW
	 BzwMv0WmcNS3WC9mkFR5bqOBM4A2iWtq4pyQiWsPxB9w+x2SJ7NrCZD/CAOWV5mYWD
	 qJvIDKWglOl4pIJwAKYSFRS9/wm/rIz8xtCjRcl0HLfKg1Qs3hJNcXH/pXZ4pebJIy
	 bQLR7j2hAhp7ARfslXHDlYrknvxVFlH80sKSBRgRKtevQt06k4Fd2+l2pzNR0LnkSq
	 e/HJ4VroKmoB7/z07vAat2hduRFcFZMypuotyJfo25I+CdTeIju8tXjPBUnkqvMQYN
	 Do5l08+ZA/V4Q==
Date: Fri, 16 May 2025 21:48:58 +0000
From: sergeh@kernel.org
To: Kees Cook <kees@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	"Serge E. Hallyn" <serge@hallyn.com>, paul@paul-moore.com,
	jmorris@namei.org, Andy Lutomirski <luto@kernel.org>,
	morgan@kernel.org, Christian Brauner <christian@brauner.io>,
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Correct the permission check for unsafe exec
Message-ID: <aCeyyly3NFSvsZYN@lei>
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <878qmxsuy8.fsf@email.froward.int.ebiederm.org>
 <202505151451.638C22B@keescook>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505151451.638C22B@keescook>

On Thu, May 15, 2025 at 03:09:48PM -0700, Kees Cook wrote:
> On Thu, May 15, 2025 at 11:24:47AM -0500, Eric W. Biederman wrote:
> > I have condensed the logic from Linux-2.4.0-test12 to just:
> > 	id_changed = !uid_eq(new->euid, old->euid) || !in_group_p(new->egid);
> > 
> > This change is userspace visible, but I don't expect anyone to care.
> > [...]
> > -static inline bool __is_setuid(struct cred *new, const struct cred *old)
> > -{ return !uid_eq(new->euid, old->uid); }
> > -
> > -static inline bool __is_setgid(struct cred *new, const struct cred *old)
> > -{ return !gid_eq(new->egid, old->gid); }
> > -
> > [...]
> > -	is_setid = __is_setuid(new, old) || __is_setgid(new, old);
> > +	id_changed = !uid_eq(new->euid, old->euid) || !in_group_p(new->egid);
> 
> The core change here is testing for differing euid rather than
> mismatched uid/euid. (And checking for egid in the set of all groups.)
> 
> Imagined situations:
> 
> - setuid process is sharing fs. We already believe this is a non-issue,
>   as Jann pointed out about Chrome's order of operations, so so changes
>   here are likely fine.
> 
> - somehow ptracing a process with uid!=euid, and it tries to exec a
>   different setuid==euid ELF. Is switching ELF images a security
>   boundary? Probably not realistically.
> 
> - setuid process sets NNP and execs a setuid==euid ELF, expecting to
>   have euid stripped. That doesn't happen any more. This is the most

Yeah, that had been my first concern: that nnp users will have learned
about and therefore started depending upon this behavior.  But right
now while euid gets stripped, capabilities do not, so the current
situation is actually far more unsafe.

>   worrisome case, but a program like that should _really_ have dropped
>   euid first if it is depending on that behavior. Hmmm. Probably some
>   code searching is needed...

I had started looking through the debian code search, but didn't finish.
Mostly saw util-linux and systemd...

> -Kees
> 
> -- 
> Kees Cook
