Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3683A7F4B
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293222; cv=none; b=GPJJZtviTmKAkaRK8z5JI7eBbxDVcV6hfbwE0JyJelji2zxiIbL4TUNLzLmn7Pbx8eTfJ8ElS+CKD6uPv3XyrzSgE5Tt4rF37HZwm0Jmf2VhzizJ6yZw4hlh2yaeA1Rf0qxtvudAYo5vLoKlMui85QUVPikadyZjo+w4q9jRzZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293222; c=relaxed/simple;
	bh=u+peTVHK2V5GDnlUQ9nOUzZqoANTtWMS/ko4tHyGhtY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SYNRS/2kllo7qi7NRH76Hpy1xbSCHcgZwszo81ISKCz0Ieg61CotK/uiRzndu8jPR2EHJj4W5WYlkms02x1aRP51u4KuPDFFbqqV3wjYeA2y6gzWvuRZeMinUTQGs/RnoG5FWhiXfX+aohCVtXVcQ9tLz21cQlAv2nTMyShZ68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U1HAe1g8; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1HAe1g8"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-483129eb5ccso11466275e9.2
        for <linux-security-module@vger.kernel.org>; Thu, 05 Feb 2026 04:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770293221; x=1770898021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u+peTVHK2V5GDnlUQ9nOUzZqoANTtWMS/ko4tHyGhtY=;
        b=U1HAe1g8u4Hn34NcjAQhfrM9jb0n7yHtW2HTGFaZ/vruZ7iHfQqKOE1RSOLNV/QhI6
         oAmnO/2bFLTBWeJ9sOPYjohICu/jqEJZaNyQuA3cI5//gB9+M4KDHPXLGq5nuy6PmRGW
         D+XycDPDi2Vj+6lAcvxcuYr7l40jZ7nC37lxjKj72G1KzQGpesmVoEWUF+EhmQaAV87w
         6FkNIbTES0vDwWnHg7vW34E4WpFpogHZNeQQkTYS2B6W5a8NeLXERWXR9LoDZv/4Edwz
         e0KwQAnt/HaLf8mB0tXjpwR+JZ+F6u4eXBvhlogfwgfuXHcKmUDinzKIZWqa7xOIzRJf
         wEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770293221; x=1770898021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+peTVHK2V5GDnlUQ9nOUzZqoANTtWMS/ko4tHyGhtY=;
        b=kTfmRs9QuqX++KD5uVRutWWgaEEDLoxYVc2dBuMoycnaqoLrBlT2vCeurY44cFdh3o
         7ZspBLK1x68bU88vsMEkbo0ndW9ejc/DQTvurxW0O8ZSsmhtJrUuEIoIqaFCsYCHoi71
         jpN+iQ6BfhxXiHmhE6UoohWg3tXIikLQTkA4UVah3CG9ra/2DJSncj6ty5O3onI3noF1
         2RlvoA769DXD09DCKdZBBj+lPViX4HGEOkYKXNTbjtlaJgVKgMHEOTW15+yMMzIceMP2
         L83i2YecA2ENmAKwoT0NQX8Dvp+XCNpQZ28ktZNni9th5KHD0hI4g3ztr9/kipPTperT
         lf5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUCewF/RF2jYr5qNAjdE2YjONqW6sL82In/8f+IN8bqiU+0nQY9Ldbm1zPkPY1IDfHS4WJFcDBVXiPDCpWENdgGdrBI4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu8Moe8hPlQKRVvA4am/czDwzkon38bcSNrw1073FCGnn3GhkN
	cY37w4LoV7wN9UAMc8/02Lu+uQgrNY6cUJI3id7AWR+BsLcokZZo4h2CTbCPQpuvA62kfmwF2Cb
	oRO2BjG0AyA599nuRaA==
X-Received: from wmmi24.prod.google.com ([2002:a05:600c:4018:b0:46f:b32b:55f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c04b:10b0:483:a21:774a with SMTP id 5b1f17b1804b1-4830e9926cbmr64195215e9.26.1770293220868;
 Thu, 05 Feb 2026 04:07:00 -0800 (PST)
Date: Thu, 5 Feb 2026 12:07:00 +0000
In-Reply-To: <02801464-f4cb-4e38-8269-f8b9cf0a5965@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-3-dfc947c35d35@google.com> <02801464-f4cb-4e38-8269-f8b9cf0a5965@lucifer.local>
Message-ID: <aYSH5KG36fVQFePL@google.com>
Subject: Re: [PATCH 3/5] mm: export zap_page_range_single and list_lru_add/del
From: Alice Ryhl <aliceryhl@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Feb 05, 2026 at 11:29:04AM +0000, Lorenzo Stoakes wrote:
> We either need a wrapper that eliminates this parameter (but then we're adding a
> wrapper to this behaviour that is literally for one driver that is _temporarily_
> being modularised which is weak justifiction), or use of a function that invokes
> it that is currently exported.

I have not talked with distros about it, but quite a few of them enable
Binder because one or two applications want to use Binder to emulate
Android. I imagine that even if Android itself goes back to built-in,
distros would want it as a module so that you don't have to load it for
every user, rather than for the few users that want to use waydroid or
similar.

A few examples:
https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/blob/5711a17344ec7cfd90443374a30d5cd3e9a9439e/config#L10993
https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/config/arm64/config?ref_type=heads#L106
https://gitlab.com/cki-project/kernel-ark/-/blob/os-build/redhat/configs/fedora/generic/x86/CONFIG_ANDROID_BINDER_IPC?ref_type=heads

Alice
