Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18772609EA;
	Tue, 20 May 2025 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780506; cv=none; b=kwWH9c1ejp2w44YDoKbB5MgWlq6sguI0t4EHhJmfDgaqIBxzhTEb8g+BVIi+df7Lzn7SV+/OVNIxdnUE70mQ40KNbKIQ2+2guz5bhC01k4BJgFA8hrRneN5q3XhiTVx3zEiKRxgMWb/13f/ul+EFpK2oWNG2RJl5nVyeCFkfyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780506; c=relaxed/simple;
	bh=gfPtTY/ItZaFC0wOOdziAN7xc/fLHHIRpcYngjq7pe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgLcy1rzTEYYA9ev+1aszvxPaGd4tT0LxqUckFdKwU4cI/0qPLXXVFXhQz6RC8ze10RzeRrEqCXNc5Y2ICcYyrVsJbeWsxXnmI7w6/k8PC66inzyKIwRSRzRWdMJoOKjI9fgWBKIUUTUjyks7LS8EmHPqWqlC8ezNDnBnkstKv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNG+rbpD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNG+rbpD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87631C4CEF1;
	Tue, 20 May 2025 22:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747780506;
	bh=gfPtTY/ItZaFC0wOOdziAN7xc/fLHHIRpcYngjq7pe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNG+rbpDfHDn/JSS1ZhfkvJzZV5Y/XxdYhenc2NTqT9/m+vUnL0kV/piPE6nHOe9F
	 Q1aBwx7blJH4ZISoWR9gK38bgb5dQFR8JQ2mgdYsb5LixecN49h4tHCVbLOjWWAHjw
	 WCqS0fmPtfx71FqVqASlpg56Nd4kIANSqAy1Yw9aCGRB6JpPO6vMbM7t9s+VlaGi1f
	 /x4909wrMDdio4Bwpxw6hS1D8b0bnaYPvlqfKDkXKGLO4CjsL4p9yrqySHOTv48sr6
	 uvjoA7gnYIpErGt+fFPuZNGb3x50HgJNun3l646pufUJeLbB3XfKUUuBJ2fmJsX6Tf
	 zYL3BCSPcYgQQ==
Date: Tue, 20 May 2025 15:35:03 -0700
From: Kees Cook <kees@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jann Horn <jannh@google.com>, Max Kellermann <max.kellermann@ionos.com>,
	"Serge E. Hallyn" <serge@hallyn.com>, paul@paul-moore.com,
	jmorris@namei.org, Andy Lutomirski <luto@kernel.org>,
	morgan@kernel.org, Christian Brauner <christian@brauner.io>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] exec: Correct the permission check for unsafe exec
Message-ID: <202505201533.CEB79A19FF@keescook>
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <878qmxsuy8.fsf@email.froward.int.ebiederm.org>
 <202505151451.638C22B@keescook>
 <87ecwopofp.fsf@email.froward.int.ebiederm.org>
 <CAG48ez1VpuTR9_cvLrJEMmjOxTCYpYFswXVPmN6fE3NcSmPPVA@mail.gmail.com>
 <87wmagnnhq.fsf@email.froward.int.ebiederm.org>
 <202505201319.D57FDCB2A@keescook>
 <87frgznd74.fsf_-_@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frgznd74.fsf_-_@email.froward.int.ebiederm.org>

On Tue, May 20, 2025 at 05:13:03PM -0500, Eric W. Biederman wrote:
> Max Kellerman recently experienced a problem[1] when calling exec with
> differing uid and euid's and he triggered the logic that is supposed
> to only handle setuid executables.

Max, can you verify this patch solves your use case?

> [...]
> To minimize behavioural changes the code continues to set secureexec
> when euid != uid or when egid != gid.
> [...]
> @@ -993,7 +987,9 @@ int cap_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file)
>  		return -EPERM;
>  
>  	/* Check for privilege-elevated exec. */
> -	if (is_setid ||
> +	if (id_changed ||
> +	    !uid_eq(new->euid, old->uid) ||
> +	    !gid_eq(new->egid, old->gid) ||
>  	    (!__is_real(root_uid, new) &&
>  	     (effective ||
>  	      __cap_grew(permitted, ambient, new))))

Great! Thanks for the secureexec tweak here. Jann, does this look
reasonable to you?

-Kees

-- 
Kees Cook
