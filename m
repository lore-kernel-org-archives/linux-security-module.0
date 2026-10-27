Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113078;
	b=CgQzPIHTFvDZzaYzFQFZmFjJLPyenVdVCkoO0IjkUr9aHOoVfUFezFKf8TQ5MIw9aJ2T
	 NWQZ4mtqZzVg63/oNjgGgTb/lbbNm4+930POZW/RHdHXl50NKspTEwVkCD/zOY4ZxborI
	 wnmmjaoCtgOa6ADGKXcpLaCHU5sM7PJ5JZqPmGjTq6U6bevr4Ua6BRl1xKyRnfhislv25
	 Ww/Hd+zZBMXjkez75JXqd5L+68ryOBT3OhqrGScIXPlE9ij9t5rmdonB4xlEO7LlGzzKQ
	 nKQw9jmurzbglhP1b0ZzRSnCjqQ5If1WVRvVjArvjfUO3TcIZHOBw1oUTT6skAi9Kbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113078;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fOIiJ8JXePL2+4wv46vzGrkknmQD8qYWdV6yhTVlKzo=;
	b=FOqVw/CiRO9MTG9CeNotI53IithmgqTOp5457yJAVXcig8ISp7Q+2ZFYPExAHOVyMA7+
	 AIgK1TkTM8iAkXoO09PFGexeoT4RAtJ0l0tEuqU3ekLAzhgTa86nGs1sGirVlY2O/AwVF
	 is1GMHHt4iFI8UwcEvFZj47Geq2r5NWL4gTmQxGjqjmJilOqP8DmxJB0aIeXM2g8RDsem
	 BvXF4CrL6sRWjCGzz3+mhKA1u3RLSLhXeQ+JkRhzujVRgd0jedbK2yBuz6mkkPAFYUpDt
	 Exr6xHlFfG4mnC4/UrCOXz7I8Ng1FqSf4G8MpHxAq1LsV6Ts6/1UoNYJQUJfwc2V/hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZ9H78KO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A106606A335;
	Tue, 27 Oct 2026 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZ9H78KO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2201F031E3;
	Tue, 27 Oct 2026 14:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793113078;
	bh=fOIiJ8JXePL2+4wv46vzGrkknmQD8qYWdV6yhTVlKzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QZ9H78KOsUn8YOcMuud+QSkEbmgph/VCrT9Y7/Cimob1ZE6aLammd9fcdbmDg8brj
	 2tz7i996m40glew/smJOea3vYSaNhKUgsdAOM8H8XFfBJlOaXXrDeOl3uQ06CTUMVY
	 D0R6JboK4Q2hlkmkRgitdKH0D1Y7cHAZeOo1xAwykWRLbCGsrbXLCNWkUwCCBf7XU+
	 UUsnU4Y3QhbgjWXLY1Z1lQPeukFDnnm3y8Mz5/pSgzJAR25XJt7V3fsoyHE18JjGqx
	 ZTf5f0jQ+BX0BQWjpKGMAl4WH42bQ8HOw3hIaZKu9lRcNW8ydVYtGc9ePIHvTmdp+o
	 8Pcnd9DZwx3iw==
Date: Tue, 27 Oct 2026 14:57:49 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	Andrey Vagin <avagin@gmail.com>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 2/3] mseal sysmap: Allow with CHECKPOINT_RESTORE, default
 off
Message-ID: <auC7SFhV_qj-agQp@gremlin>
References: <cover.1793094611.git.chris@chrisdown.name>
 <7ff59c2ab6c234ca4d799f862eb7c3f22d671f99.1793094611.git.chris@chrisdown.name>
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
In-Reply-To: <7ff59c2ab6c234ca4d799f862eb7c3f22d671f99.1793094611.git.chris@chrisdown.name>

On Tue, Oct 27, 2026 at 07:43:17PM +0800, Chris Down wrote:
> MSEAL_SYSTEM_MAPPINGS depends on !CHECKPOINT_RESTORE because CRIU moves
> system mappings when restoring a process. Now that sealing can be chosen
> at boot we should instead use this to determine defaults.
>
> Let's add MSEAL_SYSTEM_MAPPINGS_DEFAULT_ON and move the dependency
> there. Existing configurations retain their behaviour. Kernels built
> with CHECKPOINT_RESTORE can build sealing in, but will only seal
> mappings when explicitly requested with mseal_system_mappings=1.
>
> Hosts can also share a kernel built with MSEAL_SYSTEM_MAPPINGS=y and
> MSEAL_SYSTEM_MAPPINGS_DEFAULT_ON=n, enabling sealing only where needed.
> This lets hosts which need sealing share the kernel image with hosts
> which need their system mappings to remain movable, which simplifies
> deployment.
>
> Signed-off-by: Chris Down <chris@chrisdown.name>

Sorry, NAK to this patch. It's adding far too much complexity.

The honest version of this is removing the CRIU dependency, and since it's well
documented that many things break if you use it, and the config option is
default-no, then it's kinda your own fault if you insist on doing the broken
thing.

So I don't think I'd mind that, and it'd make the change simpler, as you could
fold it into patch 1 also ;)

--
Cheers, Lorenzo
