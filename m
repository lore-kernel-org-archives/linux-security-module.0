Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682475;
	b=1vpERmPvoNt7RMEwE7gRH1tVkx3E+gnWAzz//GmWubX/NiAu1MX2IB+hNWuMlBhUjCA5
	 itMXokh+BYv1+f4TgsjpGQfXHn5H7g7D7lQLWdntA+o6krzJ6u4GYdO4/IbfOHb5HRYfu
	 7rbkBCzzflTpl5XT2A37d2oLpGIRMttL2lhKgLO1Zf5SHU0OKmdAgOgrjczeRavN46IEH
	 2BCTO+ZS6Z6WvlsbGJlSmuU/mM8eQ3I0VWP8s/xFDeUfUV0w59wqCc/LeLPmA+uy5U+zw
	 +FeYk0aBPyTbtbe2uZTdnHJ7WIsPWFVvSrvAlijNLlho3RWC5nJcH+G56VfiQC3rxLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682475;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QdJ73k0AhMXLQIIEgBRL9OzVnlflz17TLwa1t1F5PFo=;
	b=j8uvmDuVAVdqzx3G4V/8ausSDIH+Uo92gwz9sgxK9Ijq450uxzu0hXiroliv2d/XS2EU
	 k/17IGARQAdKrdPGu/UGxXXbmz+FUXh3ENqMhGjo51mrL1Uln3FqgE4YefYA5Zawx7w9r
	 Svftowgm7CMwqTEk8GjQ9T4pN3aDQPraSWOapBzF4juJmTWQ5MdALqexmiwkSX4seeF5l
	 5GnNod7uTV5zZU4HH7fa8zxBNPmNpLF9SWqasg00sU9jtJVz5Sd4ObE+r2k4ITVS0/Bep
	 41ReWCQYoqlwALOfUsnevBs4j2WJgXgUsqtM7o8Y9RqNbas5G9pDbPcGPCSlBCUHJ+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R79Ilk+i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F0C606ACCF
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R79Ilk+i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F851F01825;
	Thu, 22 Oct 2026 15:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682474;
	bh=QdJ73k0AhMXLQIIEgBRL9OzVnlflz17TLwa1t1F5PFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R79Ilk+iiD5Gmp1hGyRpnYIxVUgSC7PlQESxLcZWtksFNENgNjO4MtMyYJ4TB7cvx
	 w4dRZWYV2g/BAia+TanbTrVEAQWeAT2pxhghR6R3JHuUjmlOUDiYbXShFgdI1G9MMA
	 ny07pinW3zz7AavfGwORPavsclzUPguwmN3fE6TuLtX9mlRz8mXpJIP2ecpyc640z2
	 fJIj8mM62PXJqASZ8XZI1+XaMsC1SRaovNbeikK8A79gbmiWSNBnim3L1y5zuMKKY1
	 MADhICYaGlZmOlY0LthPHzqLv95jrbMMS2pDDPMHSlzfSqBHKTP3+lVJoKpqaNO5Ek
	 lwp+uVWyJ1+RQ==
Date: Thu, 22 Oct 2026 10:21:12 -0500
From: "Serge Hallyn (AMD)" <sergeh@kernel.org>
To: Adriano Cordova <adrianox@gmail.com>
Cc: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] security: commoncap: clarify CAP_FS_SET comment in
 cap_task_fix_setuid()
Message-ID: <atop6FRjWXw9Jc7W@shallyn-amd>
References: <20260921025209.1023530-1-adrianox@gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921025209.1023530-1-adrianox@gmail.com>

On Sun, Sep 20, 2026 at 11:52:08PM -0300, Adriano Cordova wrote:
> CAP_FS_SET is exactly the set of capabilities that an fsuid of 0
> historically granted (see CAP_FS_MASK in include/linux/capability.h),
> so cap_task_fix_setuid() drops that set from the effective set when
> fsuid leaves 0.  Replace the stale FIXME with this explanation.
> 
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>

Hi,

so I had this in the caps-next branch, and was getting ready to send
a PR...  and was not feeling could about the new text.  It's stating
the obvious.  Do you mind sending a new version that just drops the
FIXME an ddoesn't add the new text?

> ---
> v2: reword the comment to something more concise.
> 
>  security/commoncap.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 3399535808fe..1ba2ea2651fc 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -1169,11 +1169,13 @@ int cap_task_fix_setuid(struct cred *new, const struct cred *old, int flags)
>  		break;
>  
>  	case LSM_SETID_FS:
> -		/* juggle the capabilities to follow FSUID changes, unless
> -		 * otherwise suppressed
> +		/* Juggle the capabilities to follow FSUID changes, unless
> +		 * otherwise suppressed.
>  		 *
> -		 * FIXME - is fsuser used for all CAP_FS_MASK capabilities?
> -		 *          if not, we might be a bit too harsh here.
> +		 * CAP_FS_SET is exactly the set of capabilities that an
> +		 * fsuid of 0 historically granted (see CAP_FS_MASK in
> +		 * <linux/capability.h>), so we drop that set when fsuid
> +		 * leaves 0.
>  		 */
>  		if (!issecure(SECURE_NO_SETUID_FIXUP)) {
>  			kuid_t root_uid = make_kuid(old->user_ns, 0);
> -- 
> 2.51.0
> 
