Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D4C1386B4
	for <linux-security-module@vger.kernel.org>; Thu,  3 Jul 2025 02:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508801; cv=none; b=Aj9nvgROsj9BoECz5SrdwzWtrlv/3mK/VNWwq2XZSquzGJNtgEwxRqT/o/MmZy8OSB3Llahv3rAv4lAZ+ohH9g65W7ZCd6jrnI3p1gbd8pwXss0RDWcXVy8lvjupCaXOTrl466+FvUARa3BebU1KKojDQ8YYTCIy+TDDkbQdHMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508801; c=relaxed/simple;
	bh=5ymmmvaYHZkZ63J3xtIxq0o0ASFDyKJPxoguG2Sd+B0=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=QOfEqcQkg5PEETOLs6DYdoJBH5h/FhfL9iFVyQAna+dg2U4aOB0ZCW4Ioazrka8fYy9IfWrZXV3NFm28mxw2rawBF8nP4kHJF6hdi0ANbq5ggJ7iEvC/ecP8TuwBflo+RzpeldO/WNOb2jcVTYkWCth0IRr9/RFIn8Zh3nKKvEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=e8xmKeux; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="e8xmKeux"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a9741b513eso32553061cf.1
        for <linux-security-module@vger.kernel.org>; Wed, 02 Jul 2025 19:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1751508797; x=1752113597; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TzXhie4CIWJW7jzt+VKFb4S+L+Efm25Tu2fG/WJtN10=;
        b=e8xmKeuxN8pjpI9dI7PMfKLhAdn3rhXeTwTPuJGm6mG9lYLViCvAOysvO2DA4uva3e
         LQ3aEQrfZ+HPPm7h4flY5zzSEnL8Ncib/SROeW5ptYSgE8iLE8WUrmYT53DFkvaZeuXU
         GJ2uZa1xQUJVL0lFeVEUpCD3+YvgvqIVQCaXJIYv08dPIfdQdQVllVa3bVwyyQpyUep5
         bBGjwkBqY/d4VSINVzCUXbjhrkY30HGAOc2R2MFl7ADcVuBRky5z3vSJ0Pb+zyNiLN83
         ljIYpLU1QinagELHB2JpPhKWvflRsq1RXfaHvFqOTosaebS9V4Fr6OGwqR20+pZfZGGp
         NSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751508797; x=1752113597;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TzXhie4CIWJW7jzt+VKFb4S+L+Efm25Tu2fG/WJtN10=;
        b=IuJeQSd1a1fkp0UTyvBfwH8cZD2nK++rm0ni+SCSGHupeSQjuhWsPgYd6IlpB4wni+
         VwqsjxsXPxM3pZfZfSdpzfQniDJRBNqfFUdl6H9S71tUu74JOO3izf3tpgC8RW24UWHl
         d/FWljqcZJGk/6wQnNmut6DSJMlMPfwn4sLxN6EaX4S8wvjg/i+suNqNOeoTtt1E+uGC
         2gJIMzyfIGiRb9jJuk0w3fT2N8JR+ph02K/q9kMnaKyQ8LC/wKSFl2SYKOsBCy5oVPMu
         VejYgrMNpUXWNgqFUsen7XNxcjCaulz+jkxqCbg2u3oV0iiP0ylrXv+FRjot14jxGJlj
         RcpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQHw1/JvT1yvvAxPq7DolWl6kK21TlY1oC9cHr13AjtQ+BYnO4s2L4m18dS1fpKC8ZORpi7RpL9QlBsoEd1vG/TwCdtlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRkoRCll3zUIWYTba2ieUKpKdVfVLrUDmrttfGcb1zucGgVPBI
	fwF+pUOonXJqSqWXt7h+U8CWm0F5NnYWKGcsYqqHZ74/OuicP7iQMIwRxwXxaRPy+g==
X-Gm-Gg: ASbGnctS9T3hQrwJyfPlsUjmHCuFJbP6pJcV/exo5ISDH6oLe9fAB0XTbinnKiK7EWh
	AnEXMh68e3r00oz5ad6Q5fQuL7VSbfXcbX2WnKrSNnswrzA9iREpv7fbPZRL9ecLjgtpLQ0OdDe
	//vD9AIIb6yrA9oAaq/1XyPZ1SsxRRbUS3q3W46kJdVUyn8NIX287qLWRtWOybrHkFqrVZGBU9M
	r5GrtVHV21g6FKpEINiL1KpcOtJkxwcK03xdcVq2yjjFxmk8XD/tatJ4S4FnW5YBESIwSYNn0VH
	aJkXQVDWVNW6UkDwBAwqFlPw1iz1RbhIU8PsMD408xfh4el7msL7xmJpY4858n1X/f/HF9nNa4K
	EIV3PKUkHgBGW5JsRehFK9tqX3p39GV0=
X-Google-Smtp-Source: AGHT+IELjxIty3QvxZPgn1IkijyUpwDEpAbFyjSsKr5nQr+vunzikG5BR25gm20fjjhw/qG4dKVsnw==
X-Received: by 2002:a05:622a:4e:b0:476:add4:d2cf with SMTP id d75a77b69052e-4a9879c3c8fmr28867621cf.16.1751508797160;
        Wed, 02 Jul 2025 19:13:17 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d44316a54fsm1034468285a.34.2025.07.02.19.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 19:13:16 -0700 (PDT)
Date: Wed, 02 Jul 2025 22:13:16 -0400
Message-ID: <a888364d0562815ca7e848b4d4f5b629@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250702_2201/pstg-lib:20250702_2201/pstg-pwork:20250702_2201
From: Paul Moore <paul@paul-moore.com>
To: Shivank Garg <shivankg@amd.com>, <david@redhat.com>, <akpm@linux-foundation.org>, <brauner@kernel.org>, <rppt@kernel.org>, <viro@zeniv.linux.org.uk>
Cc: <seanjc@google.com>, <vbabka@suse.cz>, <willy@infradead.org>, <pbonzini@redhat.com>, <tabba@google.com>, <afranji@google.com>, <ackerleytng@google.com>, <shivankg@amd.com>, <jack@suse.cz>, <hch@infradead.org>, <cgzones@googlemail.com>, <ira.weiny@intel.com>, <roypat@amazon.co.uk>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3] fs: generalize anon_inode_make_secure_inode() and fix  secretmem LSM bypass
References: <20250626191425.9645-5-shivankg@amd.com>
In-Reply-To: <20250626191425.9645-5-shivankg@amd.com>

On Jun 26, 2025 Shivank Garg <shivankg@amd.com> wrote:
> 
> Extend anon_inode_make_secure_inode() to take superblock parameter and
> make it available via fs.h. This allows other subsystems to create
> anonymous inodes with proper security context.
> 
> Use this function in secretmem to fix a security regression, where
> S_PRIVATE flag wasn't cleared after alloc_anon_inode(), causing
> LSM/SELinux checks to be skipped.
> 
> Using anon_inode_make_secure_inode() ensures proper security context
> initialization through security_inode_init_security_anon().
> 
> Fixes: 2bfe15c52612 ("mm: create security context for memfd_secret inodes")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> Acked-by: Pankaj Gupta <pankaj.gupta@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> ---
> The handling of the S_PRIVATE flag for these inodes was discussed
> extensively ([1], [2], [3]).
> 
> As per discussion [3] with Mike and Paul, KVM guest_memfd and secretmem
> result in user-visible file descriptors, so they should be subject to
> LSM/SELinux security policies rather than bypassing them with S_PRIVATE.
> 
> [1] https://lore.kernel.org/all/b9e5fa41-62fd-4b3d-bb2d-24ae9d3c33da@redhat.com
> [2] https://lore.kernel.org/all/cover.1748890962.git.ackerleytng@google.com
> [3] https://lore.kernel.org/all/aFOh8N_rRdSi_Fbc@kernel.org
> 
> V3:
> - Drop EXPORT to be added later in separate patch for KVM guest_memfd and
>   keep this patch focused on fix.
> 
> V2: https://lore.kernel.org/all/20250620070328.803704-3-shivankg@amd.com
> - Use EXPORT_SYMBOL_GPL_FOR_MODULES() since KVM is the only user.
> 
> V1: https://lore.kernel.org/all/20250619073136.506022-2-shivankg@amd.com
> 
>  fs/anon_inodes.c   | 22 +++++++++++++++++-----
>  include/linux/fs.h |  2 ++
>  mm/secretmem.c     |  9 +--------
>  3 files changed, 20 insertions(+), 13 deletions(-)

Thanks again for your continued work on this!  I think the patch looks
pretty reasonable, but it would be good to hear a bit about how you've
tested this before ACK'ing the patch.  For example, have you tested this
against any of the LSMs which provide anonymous inode support?

At the very least, the selinux-testsuite has a basic secretmem test, it
would be good to know if the test passes with this patch or if any
additional work is needed to ensure compatibility.

https://github.com/SELinuxProject/selinux-testsuite

--
paul-moore.com
