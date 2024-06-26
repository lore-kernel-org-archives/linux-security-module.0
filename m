Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4FF18F2C6;
	Wed, 26 Jun 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719419524; cv=none; b=WxxA5cYjCtHR2YE20fRARpKHNHLOJ8i/VnzNPjMoCJaMHJA5svKCdZ/iyTiimWquz4Cjv83h6ZC+uys5RDvNlb+hfgbfE/W9Ef4XeBYor9To7LX9L45Uj2OokJBb3c+jZPU+Dc7RM1f1hDKjyi+ks3jT/4OfOrKPppafihDgChc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719419524; c=relaxed/simple;
	bh=e9dSnv3gyT34jzaS7x7FRrYEJhqW/t6Y7NYnXnixKpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PloNBYF+zyteRtHvv3E1OkoVWqqqnpWoKdLswHfuQrpCzOnezckHxUpfMJbIFp3dgkNhh5AZD7QtXDQDtXmSEdEFOjoJjIS+0bacY45pDcpeRBLwRgLc4RtAW8b9hA6VaNIII07Zvozv9F+kO/zbcmEGdrTg0zsiWIcFEiO7su8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHOnDj9k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHOnDj9k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C282C4AF07;
	Wed, 26 Jun 2024 16:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719419523;
	bh=e9dSnv3gyT34jzaS7x7FRrYEJhqW/t6Y7NYnXnixKpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YHOnDj9k+pgnfO2kP4/XKtim/z8o0crNuvjU7e6zj7GX7gF5jFNOfpqwP7SYDSGrC
	 10abPZkrlTFw2qz9KwUcBdBx2/bMwOk4JeidOljZllSG6UMNq257tJ/XB2GBDyHjRr
	 MVyBz4z8vkIw26bJpv6N586B2oBVr9yFIXQ7evsa2X2YCaPqYaRwXPmVEfYWlcpBo9
	 5THqD01Odjl/DGLUNeVYXIjxs3vWcqcI7gzOaon8tfEJnKD+Qc5w9EeiZ9kOSSngfy
	 9hyNIAAXa2H9XSW0gZSx/f9wc57GW2ur4+gO8pQV0+Vlwio1uviqWlvyZsQpaTq2XQ
	 ZyPI4msuZ1SFg==
Date: Wed, 26 Jun 2024 09:32:03 -0700
From: Kees Cook <kees@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 14/15] mm/mmap: Use vms accounted pages in
 mmap_region()
Message-ID: <202406260928.0A22BB0F0@keescook>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
 <20240625191145.3382793-15-Liam.Howlett@oracle.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625191145.3382793-15-Liam.Howlett@oracle.com>

On Tue, Jun 25, 2024 at 03:11:44PM -0400, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> Change from nr_pages variable to vms.nr_accounted for the charged pages
> calculation.  This is necessary for a future patch.
> 
> This also avoids checking security_vm_enough_memory_mm() if the amount
> of memory won't change.

Is there a reason for making this change? (I.e. why not leave off the
"charged" test?)

Looking at the callbacks in the LSM, only capabilities and SELinux are
hooking this, and both are checking whether a process has elevated privs
and are ignoring the "pages" argument entirely, so I'm not sure it's
safe to change the logic for whether to make the call based on an unused
argument (i.e. the LSM may want to _always_ know about this). On the
other hand, it looks like it's purely an accounting issue, and if the
page count didn't change, there's no reason to bother calling into all
this to make no changes to the accounting.

I've added the LSM list to CC...

-Kees

> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Kees Cook <kees@kernel.org>
> ---
>  mm/mmap.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index f3edabf83975..adb0bb5ea344 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2970,6 +2970,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	} else {
>  		/* Minimal setup of vms */
>  		vms.nr_pages = 0;
> +		vms.nr_accounted = 0;
>  		next = vma_next(&vmi);
>  		prev = vma_prev(&vmi);
>  		if (prev)
> @@ -2981,9 +2982,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	 */
>  	if (accountable_mapping(file, vm_flags)) {
>  		charged = pglen;
> -		charged -= nr_accounted;
> -		if (security_vm_enough_memory_mm(mm, charged))
> +		charged -= vms.nr_accounted;
> +		if (charged && security_vm_enough_memory_mm(mm, charged))
>  			goto abort_munmap;
> +
>  		vms.nr_accounted = 0;
>  		vm_flags |= VM_ACCOUNT;
>  	}
> -- 
> 2.43.0
> 

-- 
Kees Cook
