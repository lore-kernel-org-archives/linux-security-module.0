Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D676A3308E
	for <linux-security-module@vger.kernel.org>; Mon,  4 Dec 2023 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fxL8hfcj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B65C433C7;
	Mon,  4 Dec 2023 19:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701719675;
	bh=79u88kj0IH2fqDMmfbowSP2A7IK26YpGFzlDmV3B8uM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fxL8hfcjUVcVn0G4ahmmdQzvaG07Sb2V1KX/iHtWLP1y6q1szy36MbB5RuQBvcd1O
	 ugR93TLbO2IoBvc5fMOELAqjhIngHdAWfnuTsD6LRN2BJYkvPWAZK7nP995lnW34bg
	 m9Xhko5H87BBe8CuynWGLMmgeh3Sw3ROQgCm7ndk=
Date: Mon, 4 Dec 2023 11:54:34 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: York Jasper Niebuhr <yjnworkstation@gmail.com>
Cc: linux-kernel@vger.kernel.org, rppt@kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH] mm: init_mlocked_on_free
Message-Id: <20231204115434.65f04d1de5041038ab5e2b8d@linux-foundation.org>
In-Reply-To: <20231202134218.151074-1-yjnworkstation@gmail.com>
References: <20231202134218.151074-1-yjnworkstation@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  2 Dec 2023 14:42:18 +0100 York Jasper Niebuhr <yjnworkstation@gmail.com> wrote:

> Adds the "PG_ofinit" page flag to specify if a page should be zeroed on
> free.

That's a problem - unused page flags are few, and are a treasured
resource.  Matthew Wilcox is a suitable reviewer, but you didn't cc the
linux-mm mailing list.

Please address this concern in future changelogs.

> Implements the "init_mlocked_on_free" boot option. When this boot option
> is set, any mlock'ed pages are zeroed on munmap, exit or exec. If the
> pages are munlock'ed beforehand, no initialization will take place. This
> boot option is meant to combat the performance hit of "init_on_free" as
> reported in commit 6471384af2a6 ("mm: security: introduce
> init_on_alloc=1 and init_on_free=1 boot options"). With
> "init_mlocked_on_free", only relevant data will be freed while
> everything else is left untouched by the kernel.

It would be helpful to provide a full description of the performance
benefits right here in the changelog, please.  Including example
quantitative testing results.  See if you can persuade us to consume
another page flag.  

Also, can we avoid using a page flag?   Can this be done on a per-vma
basis rather than per-page?

> Optimally, userspace programs will clear any key material or other
> confidential memory before exit and munlock the according memory
> regions. If a program crashes, however, userspace key managers will not
> be able to zero this data. If this happens, the memory will not be
> explicitly munlock'ed before exit either, so the kernel will zero the
> data and prevent data leaks. If the program finishes properly, no pages
> will be initialized again, as they were already munlock'ed.
> 
> In general, leaving memory mlock'ed until unmap, exit or exec can be used
> to specify exactly what memory should be initialized on free.
> 
> CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON can be set to enable
> "init_mlocked_on_free" by default.
> 

Please address the above and send us a v2?
