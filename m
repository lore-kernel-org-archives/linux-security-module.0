Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1E02857EE;
	Thu, 15 May 2025 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747346992; cv=none; b=Vz4PV7zZEnScQIyRXQlZ0JfGWMw+bSrIKAh9cu7lroUFw7cH2MnTJ6BlGKpahOg9BemFBCMY3ci2vQl5u4fxMe/Z/QT26d5FsGpdcM52wd8RCdY4AoYRcKVIQKjZstW7rhhHMqI67xDBVtFE9fB684e4SNVtuj56P81ouZjA+40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747346992; c=relaxed/simple;
	bh=lJ9GhyZ7d/pQPuf/ZRHN6c50tK5ky1MMTFbT8ohhnaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+2cQUdLCU6ut1lVA90VKo1em03dab4mbeGjWeozJcKTU9Po/OYOZY/WETvbq27NDo9PDlNtEN0+2+2LP7C0cZBBCpYKONPp6HuZGLSoFQggzQZob1pWyqtXcMLVK+mpKAMlYC9rjvI9Jl7eYgWN/FpFd9xeLb/6bJ6y+Eh4GU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYRSGEtd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYRSGEtd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3930C4CEE7;
	Thu, 15 May 2025 22:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747346991;
	bh=lJ9GhyZ7d/pQPuf/ZRHN6c50tK5ky1MMTFbT8ohhnaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYRSGEtdEo8wKf0rDhDXvhxrifW3PxHPKUca7LB07N97BmyUcnlWjMxhlDBDARIEk
	 H2iD7ChYQCSV0fB8VZDNiQ+YnS5K3h1Fx19rF2F0RFQR58Q3vlXq/38/ZnomzXljPT
	 c/F5k8j1CHJSsra7FcIW3hCZ/+VQOOUXXDxBG5f2ZA1w000/pXHoN0ilztCZO1XEn1
	 ZUq2OqYZVCD2NDMOObm+ZdNgL0ulxtVE/V0H5K64XtofmBWKrZ7xz6T7pFpGMuXJYE
	 xQm2VoOOdP0iyIOgC3RyT3roIwpc8bMztydZebyTSSdiR80KPf2Xs3H8cmXua6rX2X
	 Th25dOEMpa6TQ==
Date: Thu, 15 May 2025 15:09:48 -0700
From: Kees Cook <kees@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Max Kellermann <max.kellermann@ionos.com>,
	"Serge E. Hallyn" <serge@hallyn.com>, paul@paul-moore.com,
	jmorris@namei.org, Andy Lutomirski <luto@kernel.org>,
	morgan@kernel.org, Christian Brauner <christian@brauner.io>,
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Correct the permission check for unsafe exec
Message-ID: <202505151451.638C22B@keescook>
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <878qmxsuy8.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qmxsuy8.fsf@email.froward.int.ebiederm.org>

On Thu, May 15, 2025 at 11:24:47AM -0500, Eric W. Biederman wrote:
> I have condensed the logic from Linux-2.4.0-test12 to just:
> 	id_changed = !uid_eq(new->euid, old->euid) || !in_group_p(new->egid);
> 
> This change is userspace visible, but I don't expect anyone to care.
> [...]
> -static inline bool __is_setuid(struct cred *new, const struct cred *old)
> -{ return !uid_eq(new->euid, old->uid); }
> -
> -static inline bool __is_setgid(struct cred *new, const struct cred *old)
> -{ return !gid_eq(new->egid, old->gid); }
> -
> [...]
> -	is_setid = __is_setuid(new, old) || __is_setgid(new, old);
> +	id_changed = !uid_eq(new->euid, old->euid) || !in_group_p(new->egid);

The core change here is testing for differing euid rather than
mismatched uid/euid. (And checking for egid in the set of all groups.)

Imagined situations:

- setuid process is sharing fs. We already believe this is a non-issue,
  as Jann pointed out about Chrome's order of operations, so so changes
  here are likely fine.

- somehow ptracing a process with uid!=euid, and it tries to exec a
  different setuid==euid ELF. Is switching ELF images a security
  boundary? Probably not realistically.

- setuid process sets NNP and execs a setuid==euid ELF, expecting to
  have euid stripped. That doesn't happen any more. This is the most
  worrisome case, but a program like that should _really_ have dropped
  euid first if it is depending on that behavior. Hmmm. Probably some
  code searching is needed...

-Kees

-- 
Kees Cook
