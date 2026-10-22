Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792673688;
	b=Et98Viw9730Xz5ElswirLyxiIT9GfgMOlj5fyo/ppJXlD5tKH2RXP8EJ+rE8R8eD92wo
	 GuTq7KULZKA5uzWnUPcRvBsE12a/yEGh7pKdFHtU+Y+TsQbBhKVCLzIWqAlDJGTgviCTC
	 GosXFBADORI8Jc5Y4XHwpQaO2RzXTNVdMLMCY16rtXvCYBnsOXsWAOLoLgnhurbBx2Uj+
	 RBFQKPU++mFrgZ7jH5g+AK6GUyKdiw8M4gt/Ucqo5rufa34+Ask9lX+BStbFDl41vIv4H
	 bGE6gU8TvUdJf5kZ1oRzTT7GFHnwTRlkzGQigKtkuCcBPTsojq/qYamrpZKGC2FVpvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792673688;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7vbaGJGRpVXxD5uBZ+OOkQH5p8m6/MUVG3i7Ss0JkXU=;
	b=07iggxpFPgug37vQ+cIlDcMJ8ebn9tSItl74a4QOFHJRgq3sRpmNTCwzfhNETHz2a2h8
	 ZbxDmEuU3N1gs36hOkZAxpSgS90/u8/u/meN5e4DmI4iPHwcZeHCLSHq/YrBrVFooJSev
	 6VMpe5IGgroMykH9JGu1tpvrchbOcVKvSB2UWggsx88G+GAGT3/U/IzSHSAAm7pj9mY+F
	 puZ+HE1YrE6wnniSpkYIRCkHICvtsC4uLm67rDrIteVZMN9cxcRVGXqcMGYzH46+D+3l+
	 vsZebR5cCV5jSAU3AXAEw0JsBi3G6F9TAWogCZfXbJp1y2YwloXwGDrorhD+OQoCTKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VY1seCPu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F706606A31B;
	Thu, 22 Oct 2026 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VY1seCPu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894B41F000C2;
	Thu, 22 Oct 2026 12:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792673688;
	bh=7vbaGJGRpVXxD5uBZ+OOkQH5p8m6/MUVG3i7Ss0JkXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VY1seCPuEQ5XkAi0umxFdkOvmEt7Kx2hGbI2IZVN3ThnDpyRwnUvwdYymNd+9E9tU
	 Y6uCs+/eEMfFMtzLPtzR3t5w07oRipYVh3q3zHYjva7jKxxY2rtUmmMFb6lyjrhBZ4
	 aBl+7QF3AUzaASmQYEsJWwrNqpc1mgOxEXmvkl5Ahlfk4qHjYl3XswMaGyC4XRtpjn
	 HV845py1NW7lLKQ67BrDentVIXq9kkXgukewOIE1c7415RZNVE/mV54mMVAQjal4u9
	 onEZ5Uk0xiv5XtOMdJUhZMaVvYdc1zTJ2tCgCC5pRU3r6A/j4VozkL7EwWmAzs+Sxp
	 +sL1axvciYHAQ==
Date: Thu, 22 Oct 2026 13:54:46 +0100
From: Harry Yoo <harry@kernel.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Muchun Song <muchun.song@linux.dev>, Hao Ge <hao.ge@linux.dev>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH slab/for-next 11/14] smack: specify SLAB_MAY_ACCOUNT for
 smack_rule cache
Message-ID: <atoHebWJxfsra6t7@thinkstation>
References: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
 <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-11-096800aa3330@kernel.org>
 <0aeea80c-e3ac-4b6f-b1c9-ef18ea2964b3@schaufler-ca.com>
 <atkEXgQNK05PGTMG@thinkstation>
 <fccc9441-1909-4988-802d-5c9d7829eacc@schaufler-ca.com>
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
In-Reply-To: <fccc9441-1909-4988-802d-5c9d7829eacc@schaufler-ca.com>

On Wed, Oct 21, 2026 at 12:14:39PM -0700, Casey Schaufler wrote:
> On 10/21/2026 11:48 AM, Harry Yoo wrote:
> > On Wed, Oct 21, 2026 at 09:59:15AM -0700, Casey Schaufler wrote:
> >> On 10/21/2026 4:46 AM, Harry Yoo (Meta) wrote:
> >>> smk_copy_rules() allocates rules with the gfp passed from
> >>> security_prepare_creds(), which is GFP_KERNEL_ACCOUNT. Specify
> >>> SLAB_MAY_ACCOUNT when the object may be charged to a memcg.
> >>> __GFP_ACCOUNT without SLAB_MAY_ACCOUNT will not be allowed.
> >>>
> >>> Path: fork() -> copy_creds() -> prepare_creds()
> >>>   -> security_prepare_creds(GFP_KERNEL_ACCOUNT) -> smack_cred_prepare()
> >>>   -> smk_copy_rules() -> kmem_cache_zalloc(smack_rule_cache)
> >>>
> >>> Assisted-by: LLM
> >>> Cc: Casey Schaufler <casey@schaufler-ca.com>
> >>> Cc: Paul Moore <paul@paul-moore.com>
> >>> Cc: James Morris <jmorris@namei.org>
> >>> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> >>> Cc: linux-security-module@vger.kernel.org
> >>> Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
> >> How was this change tested?
> 
> Brilliant response. Thank you. Add my
> 
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

No problem :)
Thank you, have a nice day!

-- 
Cheers,
Harry / Hyeonggon
