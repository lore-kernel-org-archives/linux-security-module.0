Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BC63A782F
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289452; cv=none; b=EMvGEqnQsSM0iP3PthBVs7i3Se6YWF/4YqKk0PFfJ0fgl7OtwE/dsQ+KmA3nIrjVbz+QEN833G4BS651mbddr0iPksHvjFr1OZ3EgP4DN1n4XELOcPAfTWEtOFYDaxKdldVjZ7EMtPEKNIyOLoq/vQnTXiq1qkJl5vGp682P9hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289452; c=relaxed/simple;
	bh=IgZWvTB7RDsJ+EoqXU2SxH1H5wVJn5fVr0cKgKEL31g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WJWuyry7onkNlX++Y3BI0GtIuNIDj/DkrxDUVjcEoSTtb2Qul5O4wuz4Jf1y1vp88U969gytY7jkOHdEdgChT3wkv5OJwRfnq7vrPlYqd05CsYkCKB5BHOyPfAIpqJyTeGYp+ZgmLgmJKaMVfJXHGwUMMbchcayGJ+XX+LAf2fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=03S1SqJo; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="03S1SqJo"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4806e7c4220so11261375e9.2
        for <linux-security-module@vger.kernel.org>; Thu, 05 Feb 2026 03:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770289450; x=1770894250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=89hL5xRbrc/VbCzks41N6CYINZBf+zOJ4ZeQZ8mSub0=;
        b=03S1SqJoRO6NpsMwupIDV/bSUuJ7Is91IzNqLFRp9z1m19IP99BZ4wK+bg17PAaMcq
         Vt2LPzz2A2pmbkJFSppLE+pJPkizZm99mQQXzEbScLjRGysKnpIr7lmiQKcGH/GDYQWf
         2cRXv44VRXyoe5dXtpv916ykrbcHw0XebCmr6Ng+XhA7xmOOULd2SoiDJXnYYZKdIalj
         imP6aSjRGRrWd+LF3hi33lNvheRApXUI0c0cxX06fDwXMLHQuUTBkuq0S58/mrpvNax3
         uvVPm0u25AwgZv3QrMeoAKv/qdIMQL3oqGFg96jFsv/vbcld+qrPZKGtO5PtX3HG2wga
         BehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770289450; x=1770894250;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89hL5xRbrc/VbCzks41N6CYINZBf+zOJ4ZeQZ8mSub0=;
        b=Vv/+x0Q5IwpEygQIwYAoyIMkfY6kPIbih7EXnaodYfyvb9lug1QOrj5savM+xo1EYJ
         4fN8QAogxi+KkIitGaUyxM8Gw9U4Jrc/eiSNRkoUzouuHEfv88QsQmQDUViKgLJ9vdI7
         tLZWYvo97W+cMvbbFjlQg/S4o5uNoduIs69Wiwei52INciz8mxJ9GijBxjJt95MBotnI
         up2+J3NUAeh/0uKCPdDeEpZsfIhoSK/JU0oW9v+9ygb1DuM8dUezaO/0PLahtCTG7TwF
         u6ZFp+a+FpEv+X0G0feuqJVQeGYAUb9cPelBRIb2HKYoVS6DJBNj7SDAQdkOn/GuI/gS
         MWcA==
X-Forwarded-Encrypted: i=1; AJvYcCUmcTL1FUSJPDR8l2bONaPTCVvXrtUTEpBpVK7EGBxkqQeq8ZvWAqvMh//CEXMIJKVVABDRSlaIrLnr7+Q31LulU98vhb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0aA1w/sNXXs9HbW+57miubEWWKGEmw+s9ESMlSyOArk6Q/0fp
	+RlkVimAFaUg0uN0h+FvqqtsQXXBY7GN27La6DreyPVaCq/qjDLbCc2Bv0xe5QJwGCgKpq/88mM
	DbFD+q9PultHCxwcdhg==
X-Received: from wmjt15.prod.google.com ([2002:a7b:c3cf:0:b0:479:2d82:5535])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35d5:b0:47e:e8c2:905f with SMTP id 5b1f17b1804b1-4830e926302mr90738135e9.8.1770289449847;
 Thu, 05 Feb 2026 03:04:09 -0800 (PST)
Date: Thu, 5 Feb 2026 11:04:07 +0000
In-Reply-To: <d3dca137-2e4c-4a1a-bdec-63cc2477bfda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-3-dfc947c35d35@google.com> <d3dca137-2e4c-4a1a-bdec-63cc2477bfda@kernel.org>
Message-ID: <aYR5J0ip2MdD3nMP@google.com>
Subject: Re: [PATCH 3/5] mm: export zap_page_range_single and list_lru_add/del
From: Alice Ryhl <aliceryhl@google.com>
To: "David Hildenbrand (arm)" <david@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Feb 05, 2026 at 11:59:47AM +0100, David Hildenbrand (arm) wrote:
> On 2/5/26 11:51, Alice Ryhl wrote:
> > These are the functions needed by Binder's shrinker.
> > 
> > Binder uses zap_page_range_single in the shrinker path to remove an
> > unused page from the mmap'd region. Note that pages are only removed
> > from the mmap'd region lazily when shrinker asks for it.
> > 
> > Binder uses list_lru_add/del to keep track of the shrinker lru list, and
> > it can't use _obj because the list head is not stored inline in the page
> > actually being lru freed, so page_to_nid(virt_to_page(item)) on the list
> > head computes the nid of the wrong page.
> > 
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >   mm/list_lru.c | 2 ++
> >   mm/memory.c   | 1 +
> >   2 files changed, 3 insertions(+)
> > 
> > diff --git a/mm/list_lru.c b/mm/list_lru.c
> > index ec48b5dadf519a5296ac14cda035c067f9e448f8..bf95d73c9815548a19db6345f856cee9baad22e3 100644
> > --- a/mm/list_lru.c
> > +++ b/mm/list_lru.c
> > @@ -179,6 +179,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
> >   	unlock_list_lru(l, false);
> >   	return false;
> >   }
> > +EXPORT_SYMBOL_GPL(list_lru_add);
> >   bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
> >   {
> > @@ -216,6 +217,7 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
> >   	unlock_list_lru(l, false);
> >   	return false;
> >   }
> > +EXPORT_SYMBOL_GPL(list_lru_del);
> >   bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
> >   {
> > diff --git a/mm/memory.c b/mm/memory.c
> > index da360a6eb8a48e29293430d0c577fb4b6ec58099..64083ace239a2caf58e1645dd5d91a41d61492c4 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -2168,6 +2168,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
> >   	zap_page_range_single_batched(&tlb, vma, address, size, details);
> >   	tlb_finish_mmu(&tlb);
> >   }
> > +EXPORT_SYMBOL(zap_page_range_single);
> 
> Why not EXPORT_SYMBOL_GPL?

I just tried to match other symbols in the same file.

Alice
