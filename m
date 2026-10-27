Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793120359;
	b=ubJWnJce9ilnPp7rtewC2rf5REBvwrkGEGELjr3zE2YJEGtWjPJyktlgLbicOz1KMLtt
	 blrT4kiyKTVqrTuDZt+vWpZXTi85inpeoOJ17Sm8slVFvGmLMqJAYMYpQIvFsLAyRDfZT
	 02VLG+SFuHPEa72c+yJBuMAfyLDu+4gvH7C7ARgDp+MkGKDYLK1lB9RD+LcdOsWNZzM/9
	 f+3/Xf2xTD3Ew2ZVNM4HJkXChafqf+6t/RVogYCa5sb00qOYb0L3VeNcXJLIsW74UNWCK
	 QYEWodPSfaTovEoS7wZXvYQC+RjcCsN6p2wm8mdczE632Kcy0wfZGFoZVB4/cyurRsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120359;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3mRKG8JUg3W3apzQzP5V2MJURHdFBSMtjSahcXC2r10=;
	b=oNPpIQ6q2z6DbHqw2S5Hksk7pAIFnlByDYODySlfyJ7xua4vkw8hhl57jnQgbfx7ro6y
	 mhFndaUeIe5S1L5xn45MOtDcPHKc31Sjy7XT9uEyKBk+MSKOj3BGSLefuM3uiezxHj9DY
	 oQWnQz3Ncr+OMowNlFLVJxuFA7kLwKllwRx5opkrZHedIDFbMHljUpLVfhdedolCuXTh9
	 WC+ffBGc5jyGJ/QZjGGgXe4VokKN2C8GmK8vXkm83zX9IZslZKuUykS4lItG0CZkuwTt+
	 aVn04S8vwLXbJhgAz2+5qX8mKlbM2EocujHxUhrldrG1UIYv8fCHuaEE+dAm6i94TOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5ujUUUX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9C1606A31B;
	Tue, 27 Oct 2026 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m5ujUUUX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43981F01825;
	Tue, 27 Oct 2026 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793120358;
	bh=3mRKG8JUg3W3apzQzP5V2MJURHdFBSMtjSahcXC2r10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m5ujUUUXAwTOongi7tFEnIIdgeIt9AuFKpymAcGPUMvr2q8LfPolwmbBptOAtCb/H
	 Z0p44KyhyTdVUmld6mDFP8w0vV8d91Kuix/C4wExtPryNc9XPcCzxK8ka5Q/ucT+dM
	 YM7z0rEdHtCI1aPqyPKALFsZ6QgFDMT2lkdQG2/E5E3t/g4jcd58KSJMN6c+sVei6k
	 IhP4lwLE/sfL/tl5frtbhmtVS9FOyg+4sooIl4hIWYejOEx22O/HcDQo3FPSdJ4VGm
	 mggZ6gWZPusZgh3pbLa7dKEPww2V++2MABWvlxDlFFRduBoQuuO7LU+PnPlz/zHP0K
	 o+lyO5Jwt+2mA==
Date: Tue, 27 Oct 2026 16:59:10 +0000
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
Message-ID: <auDYWiSVzd681e4U@gremlin>
References: <cover.1793094611.git.chris@chrisdown.name>
 <7ff59c2ab6c234ca4d799f862eb7c3f22d671f99.1793094611.git.chris@chrisdown.name>
 <auC7SFhV_qj-agQp@gremlin>
 <auDTVShTfZ2et9m4@chrisdown.name>
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
In-Reply-To: <auDTVShTfZ2et9m4@chrisdown.name>

On Wed, Oct 28, 2026 at 12:37:41AM +0800, Chris Down wrote:
> Ok, sounds good. I'll drop MSEAL_SYSTEM_MAPPINGS_DEFAULT_ON, and fold
> dropping the !CHECKPOINT_RESTORE dependency into the boot parameter patch.
> Thanks!

Thanks!

--
Cheers, Lorenzo
