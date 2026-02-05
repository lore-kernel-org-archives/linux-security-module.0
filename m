Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2153D34AE
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294263; cv=pass; b=CpSgXKQyF+BUkJSOhnayKRX9YVlVsEy3ehhdfqfJ/Tk1/LWOIrjJTt/tYcaQtpBVixJHG4uEbchzKjysoWTW1i1azI6uZZbW9/coGDs1R6jeQZvgxFg+oj3toavsRKnT5croqgZlIy9Zz1KdepC2/x+KOg6MX51w/b4sE6j11Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294263; c=relaxed/simple;
	bh=ZYfglyr8WBVX6WQ6sjuoZun+RCx3dM35uvyj1qgWTPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0ZnAT0WA4TvDDTn7P3mIXFmAXuGJvu6nr2gvelS0YBJKZm5VpG2pzXBRifjZe7U7YftxKOsDoJxEGRonMsvTXYlQsv94FMUgLbMkJuT5HATbZEPSGEpTMHdXcAn8GOCnOHoGwqLwTYlWBQNQRf2vJVsp9KuEx6qR9fXp+m6HNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnU8kDqr; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnU8kDqr"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b6a868ad45so84980eec.0
        for <linux-security-module@vger.kernel.org>; Thu, 05 Feb 2026 04:24:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770294262; cv=none;
        d=google.com; s=arc-20240605;
        b=i3KzACcN2/c02gVgyn/OMpy072vZluEIPQtyaUbpKHR9rjnictazEDGlznc1/Iu4EI
         HNWvj9+al22NOafyeiqJ6PkkgC27vJ5DOPGR3LaVM9qnF4H6cbZIGzbh3qbwQP2xNLE2
         gI2phICbRm560P6FSgOHRSpJcRDrk99b4LyXkaandPfTguL54BuKLiLe0oVeDj+CDRiU
         tom4Nydvmdcihl9Y7UA1C8UeLZexWY6mMtF5ooWIbSOQx6WqFkFf/jRrPNZR6knurwOy
         L2m0jvK6dzkQNIg8wFd3DgntFdT/5EQhqfn3/ODtGqN9mvbJYGnKUdN+pgYZItLXyAT5
         zClg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZYfglyr8WBVX6WQ6sjuoZun+RCx3dM35uvyj1qgWTPs=;
        fh=YtvtNUnJHFiBL8/M2AjrgGtOqSBIBMj35H0R5ZD6GsQ=;
        b=ZgovFpoDylIlgl6RrrVjMIpJ1v4Ve120NRPj1MBsBmj7dMJl4HFV/ATEfPXN5Of1T8
         52QB6hbExlm1Lsev08AUi7f/4usBCY1EOdwRSXAH9TTTR/L9TELDGUa6FGQ+RIma52QT
         k3qoaIG5GfVASB6PxiqLgjCAaT5jx33cVCqoh/Gw1vj3rK4FRO18jzA9mYkR0TeHMGW/
         XSYi36AElpe45KY4cbk0HVD1LFSa6PSKDO4Uf031cJQrM7XqbHC5/sNz7/+sFnEcvOEz
         hDhmotRZg92XkvUNDWUMcikNzTpjM72G3PR0gEcX07c+aD961wIiGHPW4l56C2VV7kdk
         Je5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770294262; x=1770899062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYfglyr8WBVX6WQ6sjuoZun+RCx3dM35uvyj1qgWTPs=;
        b=XnU8kDqrS2YhYpPsk5DKy0ZhYzpXsTa4XvtAPQJXk2jWUaD6NACbVjw3wt+4PKy59s
         G3RY7K+FnXaDMtPalbxDHtxFeB6IMJ13tBy/OFHe1OZNf+KfI7SgRC6aK6ErLuE+sXSJ
         l6bASrhO91s+p4BE7QlHRt23d5YFeov4A9mDmL2LgV8QkOUvdEmgmZM5gcyJwsV+ncXf
         ll28toMSo9yvX7hDub0AVwMh/V3uPzZ4wcvQnUNiYakKgT9Gzgt5lo2S31Us5gzaUj42
         lRsYqnaY3pC1RNC+I0oU8wnMtBxglbgg9d0BsIjO4v1/MmEaEIrN7w9jOyVg2x058E9S
         hD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770294262; x=1770899062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZYfglyr8WBVX6WQ6sjuoZun+RCx3dM35uvyj1qgWTPs=;
        b=qhB1Kznwz4wCJV0prtbPi6+UiqdUJ0Y+I1zG0Npr1mFNx2yqmeI6gdPcKZrn4M/PEq
         78OzAbOlumsxgF5StgqVH+Fx3L9QGcNaDYVdVuC96N68D+yMvWta3nxj2wnKSLopYfCC
         d5sPhUNO61dKtmhWA4fOg3PSiaUEWyLtR6EbG78JpJQZ0G1QwTb9uSKHUU3HDc6L1QRE
         mLOY9JB2o2cvqvU4vfbeisbMTvua3Sje2rXrlwhCeFdu0UIXnohwqmvgxXpJQX0fARrU
         6Y7wRv7didHfANEHbDYHuyfcUvf9ut60MjcSa5Jw/yGBNWBNqe0UK9jevjMP2iG2X8T9
         go3A==
X-Forwarded-Encrypted: i=1; AJvYcCUChfVA6BeYbnK8gvouqzdACnMJiHapfIvXpXDrySeqJ9na2RKtYyYsBKjLSA/f6YqGD839kuTshq1sn2bu3GBjUQxwJY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygNaQrqWm9Zb/UZ6+Auy1NDnJ04eerUaZ/YLjJKIK4DXeK5YsN
	c1YsHt+nguHEzT+grQ1ByzwAxp9pUr1PtK4WgX2Gb+z9CxtZg/GZHMkOz/cWLdCpfFC5bJUltxL
	r1WmtUvE0sEr0+WX1mmiwM7xB1zbdMUs=
X-Gm-Gg: AZuq6aKnajMvaZ6GeZ0Y5ZIFfVNZYZKcIKvrow547LVBsx78LDz5JY8Kjw4PwCd6Qga
	EaN7KSzXN+cpS0/vhZ4qSuHJEPj8D04o1dadavxQ5Lm/1Et0N0sg2gKQqdekvZXtlfDXpIVWmok
	g+mOXF+QY3bRvuiJ1oCKaVy65Pbu6zrZdHqC2I1dw0v6+b2Y20XpaClC7T+ZJFioWS+OR51mcCe
	0vv++9KjdWHROI3tqTpSjvWpYi/yiZx/d33ZoWqPmWxNusBCucX81cwOCyzEyHzArDnaCNcpRLz
	9+VBAJ/UHfwdVwuZwhow+Y/ER8Dm9Z9ed6NbqkOxY5QFoTGtyJbf02fQTEiI/2lJnxy3v6cDRPW
	Dxi+nMEjnOugx
X-Received: by 2002:a05:7300:c29:b0:2b7:b88d:b75d with SMTP id
 5a478bee46e88-2b832743f4dmr1457533eec.0.1770294262402; Thu, 05 Feb 2026
 04:24:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-3-dfc947c35d35@google.com> <02801464-f4cb-4e38-8269-f8b9cf0a5965@lucifer.local>
 <21d90844-1cb1-46ab-a2bb-62f2478b7dfb@kernel.org> <ab63390c-9e75-4a45-9bf4-4ceb112ef07f@lucifer.local>
In-Reply-To: <ab63390c-9e75-4a45-9bf4-4ceb112ef07f@lucifer.local>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 5 Feb 2026 13:24:09 +0100
X-Gm-Features: AZwV_QjQOk6KBIhhGsJHJbikCfRdoq7wVHVjUzF565W0EbHofNdnPpSD4f5sZ4A
Message-ID: <CANiq72=ybFtqsh18zkC3e1iyR-RoffcL_ZDr-fU7SjzJiFERHw@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm: export zap_page_range_single and list_lru_add/del
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "David Hildenbrand (arm)" <david@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 12:58=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> What??
>
> Alice - can you confirm rust isn't exporting stuff that isn't explicitly =
marked
> EXPORT_SYMBOL*() for use by other rust modules?
>
> It's important we keep this in sync, otherwise rust is overriding kernel =
policy.

Currently, Rust GPL-exports every mangled symbol from the `kernel`
crate. To call something you would need to be a Rust caller (not C --
that is not supported at all, even if technically you could hack
something up) and the Rust API would then need to give you access to
it (i.e. you need to be able to pass the Rust language rules, e.g.
being public etc.).

In this case if we are talking about the `VmaRef` type, someone that
can get a reference to a value of that type could then call the
`zap_page_range_single` method. That in turns would try to call the C
one, but that one is not exported, right? So it should be fine.

In the future, for Rust, we may specify whether a particular crate
exports or not (and perhaps even allow to export non-GPL, but
originally it was decided to only export GPL stuff to be on the safe
side; and perhaps in certain namespaces etc.).

Cheers,
Miguel
