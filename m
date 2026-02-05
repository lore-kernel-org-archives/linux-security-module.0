Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1314238B999
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293778; cv=none; b=H0V7AWkVJORkWaOj0uU62yUPQBdS0ZP06yVz7NliPPiuKIXQ8F8prBJ+7r8u8pObTr3ZkB/G23bSiZ8uqf12BZ2hsLPXRDAJR1wfHvl/qUdL/OAZoJCVLj1GWVvbxP2t31lf/8YzDJczKvYX7bozPc3YynIwGS6LoH9BN1HgeNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293778; c=relaxed/simple;
	bh=SCC9gcflVmHPLxH69mVXvB5x+dS9TvC1HJdxJ8s16mI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GUiCxWAOyyjL6qrHzykyOMMg144gT6JhpIso15vmO1iGzY7J25MTSDYVmpZWrlzCUbU+0xb/+zuIMzYCPHbSkTuMN6mZ/x1Ppp4mBHam8dzAreHCgKW1aCfZCI096NnDX01eRMXkE4Q1I3Vg7vy25CLmO8irXgtHrjtg1hX15D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xtGdXVsj; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xtGdXVsj"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-483129eb5ccso11558125e9.2
        for <linux-security-module@vger.kernel.org>; Thu, 05 Feb 2026 04:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770293776; x=1770898576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WdEiyr8bJGKSEjsYG8EiNog6mpVV3VC2+HUaeWq0qZc=;
        b=xtGdXVsjE6yI2ayRYQXB4v956OTVpnBo87y0lUWmiF+QgG9CjTDUDwozvzFLqkSQPs
         r4iMJFsBg6NYzXDnb0r8K893eEbQNbBSIYfl2RraJUAfbETd+nJ+v/0jd/vAiqs3TrW2
         iTPMlRZCF1yWhD5OzJjMHXt/FyLYX71yTEJph98jbcymnSTasyQJjtJH2YOhpktDDt4t
         NcBuuZ8ob/CdxPeb+1yvZSCKvLOYnhBmhjsZfgFG5pIA2ICmm88RUfTqMq5DFzsznCYL
         RcXyPYmLdLE3uGThXlXtUUtoHQyKkq9CYS+vZh/LWliArIXafL4cZ9Q8iLV482+PXbG0
         q6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770293776; x=1770898576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WdEiyr8bJGKSEjsYG8EiNog6mpVV3VC2+HUaeWq0qZc=;
        b=lTFI+XZ+iyJv2dcg+J5WOZPtdsSrALg2tZOcHO7X4h+NQEadQesymHrxhacVrsDq6e
         9yJ9+dXgE0iEOpVgWM+dNIX0WtTTHOb5i5syemSlN3P5nse7/0ZrQhdd7SSnE5rW3OYA
         3osUbuBJhPjLFJ+XUkI4NChb2KyoV8/b/zbzDC5hwwNW+e3ER/h8sL4jHXT06Nt7CSea
         8YKa7GlEXjSzLvZl0QMqS/Zl+9aTlZOTaiXpnoRSKV3N5K4w6ZFMsclKn3wnbvQt1klF
         6/z2CfVvMSnDgIwg0oUcl+LckvxZrINSFbfFWNj0WrSrvaK9Cz6X2ztd/PCtThSsYNTK
         uWaA==
X-Forwarded-Encrypted: i=1; AJvYcCXsxNn0/ewNvkTQ7UUcM6mjW/6xYvRq0Q4TYTaOyaGpHL1gMDP3VtYyjTGUbl6zwga3GmhxISrUnFdZIVD8mi/VXQRqjhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypsgxfo/wLybqygNONxlxQVRtX3sJaIxlkbJyOlgRhih5T05vQ
	To4rwWSCSgJj8H8VXj2QlsfbzzfAj8xQHGirrWygKO8h7hEgpc8Lqz5a4BHO4JDsIfIEAOcOJA8
	9qpeiXTi5S2qCvgT1bQ==
X-Received: from wmrc21.prod.google.com ([2002:a05:600c:ad5:b0:47a:7fdc:6925])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6748:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-4830e99b49fmr79210445e9.28.1770293776335;
 Thu, 05 Feb 2026 04:16:16 -0800 (PST)
Date: Thu, 5 Feb 2026 12:16:15 +0000
In-Reply-To: <e7247f3e-8a88-4b46-91ba-cb73cce1346a@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-3-dfc947c35d35@google.com> <02801464-f4cb-4e38-8269-f8b9cf0a5965@lucifer.local>
 <21d90844-1cb1-46ab-a2bb-62f2478b7dfb@kernel.org> <aYSFyH-1kkW92M2N@google.com>
 <e7247f3e-8a88-4b46-91ba-cb73cce1346a@lucifer.local>
Message-ID: <aYSKD7RQQGuFFkqx@google.com>
Subject: Re: [PATCH 3/5] mm: export zap_page_range_single and list_lru_add/del
From: Alice Ryhl <aliceryhl@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "David Hildenbrand (arm)" <david@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Carlos Llamas <cmllamas@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Dave Chinner <david@fromorbit.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Feb 05, 2026 at 12:10:38PM +0000, Lorenzo Stoakes wrote:
> On Thu, Feb 05, 2026 at 11:58:00AM +0000, Alice Ryhl wrote:
> > On Thu, Feb 05, 2026 at 12:43:03PM +0100, David Hildenbrand (arm) wrote:
> > > On 2/5/26 12:29, Lorenzo Stoakes wrote:
> > > > On Thu, Feb 05, 2026 at 10:51:28AM +0000, Alice Ryhl wrote:
> > > > >   bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
> > > > >   {
> > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > index da360a6eb8a48e29293430d0c577fb4b6ec58099..64083ace239a2caf58e1645dd5d91a41d61492c4 100644
> > > > > --- a/mm/memory.c
> > > > > +++ b/mm/memory.c
> > > > > @@ -2168,6 +2168,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
> > > > >   	zap_page_range_single_batched(&tlb, vma, address, size, details);
> > > > >   	tlb_finish_mmu(&tlb);
> > > > >   }
> > > > > +EXPORT_SYMBOL(zap_page_range_single);
> > > >
> > > > Sorry but I don't want this exported at all.
> > > >
> > > > This is an internal implementation detail which allows fine-grained control of
> > > > behaviour via struct zap_details (which binder doesn't use, of course :)
> > >
> > > I don't expect anybody to set zap_details, but yeah, it could be abused.
> > > It could be abused right now from anywhere else in the kernel
> > > where we don't build as a module :)
> > >
> > > Apparently we export a similar function in rust where we just removed the last parameter.
> >
> > To clarify, said Rust function gets inlined into Rust Binder, so Rust
> > Binder calls the zap_page_range_single() symbol directly.
> 
> Presumably only for things compiled into the kernel right?

No, building Rust Binder with =m triggers this error for me:

ERROR: modpost: "zap_page_range_single" [drivers/android/binder/rust_binder.ko] undefined!

Alice
