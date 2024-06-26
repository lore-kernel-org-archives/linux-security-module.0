Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D161862B7;
	Wed, 26 Jun 2024 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719427553; cv=none; b=L4MKEJv+Fttd6PjTyL0ms8GrKK5Ag8DeKhXGDxTaQks4UHbN+UQYFigZxzTFpO049d6upKIZHEbbx0HvVSjBwafaG9mOefyNye9FVKrVcDunkX2Knll/eDG01ZKn5VkcB2ASEOWOUrwzx5Zg8HNeThjVJg9Mln5gUcc+Qr6oz/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719427553; c=relaxed/simple;
	bh=HwdKQbr1kQD3+fSN1zZl35Es6O6pU661Vi1nR9Yom9I=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkWbm0gc46VfiEeQ5Ktr0SJp+85V4WQyNyHvZrw7NMOLhGflnFKIXLDVxEt/kzINyHLDggc7IBzx/yPfLRoCpdZ3dT5o5ErOcfG6ssn6CL+D4JueyPf6ZR5DmlWRnK2T/T9UlSChxzSYLHAg3B76YDacnsRjxV31ZYI5pd6KNd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3NS5yXW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3NS5yXW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E6CC116B1;
	Wed, 26 Jun 2024 18:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719427553;
	bh=HwdKQbr1kQD3+fSN1zZl35Es6O6pU661Vi1nR9Yom9I=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=Z3NS5yXWgoOrNLD+AMQ6HPZZzXrZ7MolKgybpGgrPnUM5CJcTSIyqmJTETh1Y61ek
	 lBHzsHAUuCnR2dvFf1gJtOxlD/RK2wyXqMPoWA/tby1TjrUMG0CfQP5x86nJusJJpM
	 E+xYlLbLv57KXzWp984vXACfxRjoTrqcbB0Up+7RKuJiPtrLVUAmLKFlNuvOitbr8m
	 KhJHUghtOSDoZOVbGoFbCsKl1gThh//fVOvy4lvZGiZdjpAND+IQi2MnzWYzAINLO+
	 FD1xHD/SzylIL43qwFTrxapV9jgoCVmu7w1/WOfJTCewuPU7YwwF4rthXaz1ZVxYAk
	 VdcwnSIvNh7Bw==
Date: Wed, 26 Jun 2024 11:45:52 -0700
From: Kees Cook <kees@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 14/15] mm/mmap: Use vms accounted pages in
 mmap_region()
Message-ID: <202406261145.F1D7708@keescook>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
 <20240625191145.3382793-15-Liam.Howlett@oracle.com>
 <202406260928.0A22BB0F0@keescook>
 <yhaz3jyu6cfr637tbgywsr42e24fmjcs5cdjgggkis5acikyd7@6ejqra2w43xu>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yhaz3jyu6cfr637tbgywsr42e24fmjcs5cdjgggkis5acikyd7@6ejqra2w43xu>

On Wed, Jun 26, 2024 at 02:04:53PM -0400, Liam R. Howlett wrote:
> * Kees Cook <kees@kernel.org> [240626 12:32]:
> > On Tue, Jun 25, 2024 at 03:11:44PM -0400, Liam R. Howlett wrote:
> > > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > > 
> > > Change from nr_pages variable to vms.nr_accounted for the charged pages
> > > calculation.  This is necessary for a future patch.
> > > 
> > > This also avoids checking security_vm_enough_memory_mm() if the amount
> > > of memory won't change.
> > 
> > Is there a reason for making this change? (I.e. why not leave off the
> > "charged" test?)
> 
> Before, the munmap() completed prior to mmap()'ing the MAP_FIXED vma.
> If we don't remove the nr_accounted from the charged, we risk hitting
> the maximum limit.
> 
> > 
> > Looking at the callbacks in the LSM, only capabilities and SELinux are
> > hooking this, and both are checking whether a process has elevated privs
> > and are ignoring the "pages" argument entirely, so I'm not sure it's
> > safe to change the logic for whether to make the call based on an unused
> > argument (i.e. the LSM may want to _always_ know about this). On the
> > other hand, it looks like it's purely an accounting issue, and if the
> > page count didn't change, there's no reason to bother calling into all
> > this to make no changes to the accounting.
> 
> I didn't see any reason not to avoid the call, but your statement is
> valid.  I didn't see anything looking at the callbacks that would have
> issue with skipping it - but I'd like to hear what LSM has to say.
> 
> I don't have any objections to removing the extra check, if anyone
> thinks it could be an issue.
> 
> > 
> > I've added the LSM list to CC...
> 
> Thank you, and thanks for looking at this.

Sure! And barring any other feedback, I think this is safe, given the
changes to the accounting logic: no change means nothing to check.

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

> 
> > 
> > -Kees
> > 
> > > 
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > Cc: Kees Cook <kees@kernel.org>
> > > ---
> > >  mm/mmap.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index f3edabf83975..adb0bb5ea344 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -2970,6 +2970,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  	} else {
> > >  		/* Minimal setup of vms */
> > >  		vms.nr_pages = 0;
> > > +		vms.nr_accounted = 0;
> > >  		next = vma_next(&vmi);
> > >  		prev = vma_prev(&vmi);
> > >  		if (prev)
> > > @@ -2981,9 +2982,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  	 */
> > >  	if (accountable_mapping(file, vm_flags)) {
> > >  		charged = pglen;
> > > -		charged -= nr_accounted;
> > > -		if (security_vm_enough_memory_mm(mm, charged))
> > > +		charged -= vms.nr_accounted;
> > > +		if (charged && security_vm_enough_memory_mm(mm, charged))
> > >  			goto abort_munmap;
> > > +
> > >  		vms.nr_accounted = 0;
> > >  		vm_flags |= VM_ACCOUNT;
> > >  	}
> > > -- 
> > > 2.43.0
> > > 
> > 
> > -- 
> > Kees Cook

-- 
Kees Cook
