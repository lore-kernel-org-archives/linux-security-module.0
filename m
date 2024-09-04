Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EDD1E00B9
	for <linux-security-module@vger.kernel.org>; Wed,  4 Sep 2024 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468663; cv=none; b=nMWS/wOZ+UD8TE1AAHmr+I1U29UMwD0ex68VckezdQ5h6cEmTorWtG2bELTutvEtoT5wmALxxd1uCDX8aFBhIyMYYZgLfKvvQelwhUJMXgGOUg9WMlnPyro3n4pbMa+QnI5oUx3a8x6E3yeZCfqHMETTHwPIG2Dksv8r5/naPjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468663; c=relaxed/simple;
	bh=WwVr4F4mSwbuuwBtGzRHAzok6+2DiB0wAP1mGFWeJ0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/2BgJ2tcdns9MBC8KjdUTwrA+1wdgSp2HEQ1oB/61FNQ/mxXQx/qvdEjsvJfQ5DQCRReFi6vc6Az5gDi0yl1ugPd4YTsyqAFM1CuCkR1DGZX9lZWWxHEMvlmWOkEpo2seT1ZBwJRqyHsNOYfKH/OQiqyyu+viBLQt7nYnKTaL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gXfvhCAj; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gXfvhCAj"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86859e2fc0so783896766b.3
        for <linux-security-module@vger.kernel.org>; Wed, 04 Sep 2024 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725468660; x=1726073460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7rWeV+NWCdRf81fBZfPtxM1G+LxfG7gp5nBcYV4V5A=;
        b=gXfvhCAjOyqQ0FZRYVWS4+qUu77o8Mkc0zsELc/C/piYH0JETtKGQYiknR6Vlp+ic8
         W6+xnSvTWTCKGd9G8z42Gj+taeSkR4xalftE48UTaT/2Sp/B2LE1oLMGCjzYkUIvSNKj
         3GnerN2W69yhvaQ4r8VpXLZJx+n8gJegb0SGlYxIdyUYLRDDrMX+j96mD64VXfErIR1C
         7olRGNF9vUrdEOvWyASHqYlPcAT6ac0a5DUCAFCJ024SAuLwuLXpU81My7UK5k7m820i
         xKsZUvIWgBEuHgiwULzGEG9uO5zuK9GOar3VGfwZ0NZiQzVLurXQWgkn8pI1S7E4lk+c
         pAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725468660; x=1726073460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7rWeV+NWCdRf81fBZfPtxM1G+LxfG7gp5nBcYV4V5A=;
        b=M4oFgdF+QPwtMo2hwb0mtmrKc3izcEm6aY2t2ZmkCEMfX1EX3gfVBRS4omqBBIshJ3
         u177IMw4dlfB4hR7Y6mqkGm9rOUIPun9Fk+81U8wlmufElAnVIGuQa/hXuWfQLRM6fm5
         50mPuPf4/hJS9NYItD3ZsWihMq6Gtct18/bPZhJCtQ2jwLdseICydy/hkkUrsDaqcppA
         0/1AjHQ6hbEnV1rkLT7fvZXfktmNG4MqV4nRhD0i/w9nZmS9aAJhT856a4wbCQ2sjwH9
         EL+iod06ey5RvEIg4BCZzqxmhZk2uTQAqEyhbLNIQTWlK68osvsGfVM/gNKM3spjpfRl
         rvvw==
X-Forwarded-Encrypted: i=1; AJvYcCUIA5A9ReC3pZmdTIgTjCGB+IB2JGdy8NqwthPawFguR2WBo0Rh6lAIA7bQsyZsKN/N883XwDjh/v933jJzhzpsi6oqyEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8pFu+5sn8zK0Z2ipUA3z4AeZd671gshDKrkCg+bMy5RW7XVC4
	ZDMTTVbAAZPqCDAudBMNZCAOowbVYX0XNgGhZ+gOEwsnaQa1JhicOuTOS9a469Y=
X-Google-Smtp-Source: AGHT+IFALtAoVHEjAWS0GLsxnXTvv0LRQZ1z3Mh6tmtAzZy/u4Bi8AQyayThPfA0wkbnRHgLuqmbGA==
X-Received: by 2002:a17:907:2da1:b0:a72:69e8:f039 with SMTP id a640c23a62f3a-a8a32df36f9mr369433266b.12.1725468659495;
        Wed, 04 Sep 2024 09:50:59 -0700 (PDT)
Received: from localhost (109-81-94-33.rct.o2.cz. [109.81.94.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236d089sm13263566b.123.2024.09.04.09.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:50:59 -0700 (PDT)
Date: Wed, 4 Sep 2024 18:50:58 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Vlastimil Babka <vbabka@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-ID: <ZtiP8h4U7X_XV-yI@tiehlicka>
References: <20240902095203.1559361-1-mhocko@kernel.org>
 <ggrt5bn2lvxnnebqtzivmge3yjh3dnepqopznmjmkrcllb3b35@4vnnapwr36ur>
 <20240902145252.1d2590dbed417d223b896a00@linux-foundation.org>
 <yewfyeumr2vj3o6dqcrv6b2giuno66ki7vzib3syitrstjkksk@e2k5rx3xbt67>
 <Zta1aZA4u8PCHQae@tiehlicka>
 <zdrwzpzbe5oqawyklyb4gmdf6evhvmw3on5w2ewjyqfmdv2ndy@w7kdgpakbqv3>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zdrwzpzbe5oqawyklyb4gmdf6evhvmw3on5w2ewjyqfmdv2ndy@w7kdgpakbqv3>

On Wed 04-09-24 12:15:15, Kent Overstreet wrote:
> On Tue, Sep 03, 2024 at 09:06:17AM GMT, Michal Hocko wrote:
> > On Mon 02-09-24 18:32:33, Kent Overstreet wrote:
[...]
> > > For bcachefs: I try really hard to minimize tail latency and make
> > > performance robust in extreme scenarios - thrashing. A large part of
> > > that is that btree locks must be held for no longer than necessary.
> > > 
> > > We definitely don't want to recurse into other parts of the kernel,
> > > taking other locks (i.e. in memory reclaim) while holding btree locks;
> > > that's a great way to stack up (and potentially multiply) latencies.
> > 
> > OK, these two patches do not fail to do that. The only existing user is
> > turned into GFP_NOWAIT so the final code works the same way. Right?
> 
> https://lore.kernel.org/linux-mm/20240828140638.3204253-1-kent.overstreet@linux.dev/

https://lore.kernel.org/linux-mm/Zs9xC3OJPbkMy25C@casper.infradead.org/

> > > But gfp flags don't work with vmalloc allocations (and that's unlikely
> > > to change), and we require vmalloc fallbacks for e.g. btree node
> > > allocation. That's the big reason we want MEMALLOC_PF_NORECLAIM.
> > 
> > Have you even tried to reach out to vmalloc maintainers and asked for
> > GFP_NOWAIT support for vmalloc? Because I do not remember that. Sure
> > kernel page tables are have hardcoded GFP_KERNEL context which slightly
> > complicates that but that doesn't really mean the only potential
> > solution is to use a per task flag to override that. Just from top of my
> > head we can consider pre-allocating virtual address space for
> > non-sleeping allocations. Maybe there are other options that only people
> > deeply familiar with the vmalloc internals can see.
> 
> That sounds really overly complicated.

Let vmalloc people discuss viable ways to deal with that. You as vmalloc
consumer want to get NOWAIT support. Ask them and see what kind of
solution they can offer to you as a user. This is how we develop kernel
in a collaborative way. We do not enforce solutions we work with domain
experts to work out a maintainable solution.

-- 
Michal Hocko
SUSE Labs
