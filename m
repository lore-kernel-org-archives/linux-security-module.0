Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179631F91E3
	for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2026 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701592; cv=none; b=HDB4Hle96dccxp3bknNis1OBYjvfiLGa3Q6SZJQUGilEOwewA+x+W+8qYRRryvVfnONWNRsVOjdU/1035xGabRzONsNyDiynE/hWzVH1EJiNoQ40W/Jj1bLh9JImwfWcamNv0wLBSK8Z3O5PGzHseSlGyOaVmgY7UY+KQN9UMs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701592; c=relaxed/simple;
	bh=fQA3SZcb+tlnWKQWCDvyhHCoMZ57g4heUx3qYEQSOJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAF9og0cQ/JC36Zh2p2SSaAn/aw1tkq9f/t83MrcWznaseKL7DjhelEDGjTRCI9LJFgy3d7NEXei43mdunT/QXPq6QWpxZoAVyPcXC4xvxgwUCw1UVES33QRLmdUO5h6vN2FM4Xyk2x0AeM2gwTtavecwaZzQlNa0zceTn/vi+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhkdNTfE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhkdNTfE"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso51361515ad.0
        for <linux-security-module@vger.kernel.org>; Wed, 17 Jun 2026 06:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781701590; x=1782306390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4kNqZDm5RU/19gyqz05jvC/W8nKC6gtuqov40cnaXYA=;
        b=BhkdNTfEC1GowtpGBdBcH2ZJE+EEvrSztaMxamZu0dHHqdWkjIIeY+5Zw+J4aeiLzQ
         6h5YpkWbS1NMV2hhj+7l//yl3jFBsQIH6tmwy0yPIqK8uDl45PfJT6TfMILl8xx68d1U
         V47qLijVtXJV50VMickOrjB1auxsh6zXO7UsYSvW9V6hyNGrUnRWgw5OD2yHAnl0YqFG
         wQ6nx0LoAxeh4H+HjbK5TAdCXbhW4tlYGXCYIZdRNp3jb7NjZvhGY4mJEEghGnhye8nw
         bzEAB/sCN/0/lyHr6r5DK+kbek5ILI5qavGigroQPTCoJxREQbT5ydOeUQD1Y2RzgpCB
         wA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781701590; x=1782306390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kNqZDm5RU/19gyqz05jvC/W8nKC6gtuqov40cnaXYA=;
        b=AbAo/e5z+C/3QUpwMEbm+kMIA8qsrUyjOl1tcbxbr+F8LVJ1FkaUBqIsZUEhI/xNky
         p3H/MYnr64PHz6i9WYpogKo69d1w+RcKnR4Hw28kjUKhxoDQHwyo9SkjdurBMVMO37Xw
         rfVC8e2H/SGVzkRqDf8aX2A0o/ZF2ik5Jb4y3VkYTnuPqTiNxWDmgwp0F/qG/XVECMIY
         fXVTDb+NeW1RE48eDx71txXwqUNT1cVF7xvEctkJlnxhko9JAbuaJtOtEDimOf3CNdIf
         JXgsqba6uD0wYvZ5mDU2EY3SjbceRRhlydfnn4zeDeTKs7T9Qy8+ixrdUO97s4khk4xT
         GNpw==
X-Forwarded-Encrypted: i=1; AFNElJ/Qx/ot0A4U8HqQAyfRUenC8VBb/KT2GI7yR6KN+7w8u98QrOWjdzj7Cnlf99EMdGjhSFZx2+Uh8O0cktVfXzCuU/qpnZY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw23aYslYOZKhFKAvQ7EGxsld+UBzFDm+wGcZJuU/OTdY4IgLt/
	FCFgG7/55RepY67IKM/E1sTXu5vJu54oYsNHv82u8T60Yu6uqV5Ed2JeKfmbbw==
X-Gm-Gg: AfdE7cnqd1t1oA26SsHcdk+lBR9QbhVdTM19k1hUm75CuDctecCvE+FdpJXcoyXh3yc
	+he7feSRLN3ezgEG6TNdh9u2jljF+IdY4crYxoRAgbZjnSnvEZClBDN+Ip+RY3V9EwwR1M5DgcQ
	jPX64l5PDHeADhP1H5Xw+CzmYraYys8q3AWw7Fch7MOrYMgEWmzDOzJDJlzGgaCE9S8pxoYgUtd
	RHYdSca9oFhIjJLTOa7uWEjzjjVxDwY6PfJIeyShyhNo3uu/+xKBzb7XJc+TUh+/Axa+/JyvlAF
	2BsbiNdO3AQeF7q+RuO4f4Zu1E9bP0ALznB+2bE5lCXE9oysfcvXWrWUnpv02aAY7HV+aE7Dxf3
	8Gj8+uDgI/Ib3q+ffZ6dKq5LJGwnYKoaIyrQuRNTn0k9Ia9CDdvtjqKgmUPgLfWexIpGwGxL5WP
	HHTwPy4m7aQum8
X-Received: by 2002:a17:903:19ed:b0:2c6:937a:249 with SMTP id d9443c01a7336-2c6bc22aa18mr37133905ad.29.1781701590198;
        Wed, 17 Jun 2026 06:06:30 -0700 (PDT)
Received: from google.com ([118.150.148.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327acca5sm149137845ad.51.2026.06.17.06.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 06:06:29 -0700 (PDT)
Date: Wed, 17 Jun 2026 21:06:26 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, jserv@ccns.ncku.edu.tw,
	marscheng@google.com
Subject: Re: [GIT PULL] selinux/selinux-pr-20260615
Message-ID: <ajKb0oiem8TUEJM8@google.com>
References: <577e6fb29cf0b9c335748aa5fa026275@paul-moore.com>
 <CAHk-=wjBF1ZXNRRqnA+KDFzqxZaXPgmDc8=Ly3+RdxUXWuve9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjBF1ZXNRRqnA+KDFzqxZaXPgmDc8=Ly3+RdxUXWuve9Q@mail.gmail.com>

Hi Linus,

On Wed, Jun 17, 2026 at 12:54:44PM +0100, Linus Torvalds wrote:
> On Tue, 16 Jun 2026 at 03:55, Paul Moore <paul@paul-moore.com> wrote:
> >
> > - Avoid nontransitive comparisons comparisons in our sorting code
> >
> > Done to prevent unexpected sorting results due to overflow.  Qualys
> > documented a similar issue with glibc:
> > https://www.qualys.com/2024/01/30/qsort.txt
> 
> So this is clearly worth fixing in the selinux code regardless, but
> did anybody check whether our sorting routines in lib/sort.c actually
> have any overflow issues with non-transitive comparison functions?
> 
> Strange sort order may be confusing but tends to be largely harmless
> (the confusion might then obviously cause other issues)
> 
>  The whole "confuses the sort function enough to result in bad
> accesses" might be worth fixing in lib/sort.c if somebody looked into
> it...
> 
Since I made most of the recent changes to lib/sort.c, I can
hopefully shed some light on this.

With the current Linux lib/sort.c implementation, passing a compare
function that lacks transitivity will absolutely **not** lead to any
out-of-bounds memory accesses. Unlike glibc which defaults to merge
sort and falls back to heapsort if malloc fails, the kernel uses a
strict in-place heapsort. Because of this, the compare and swap
operations will always operate safely within the boundaries of the
provided array.

However, it still inevitably leads to unexpected sorting results. This
has caused actual user-visible issues in the past (the previous acpi
breakage being an example [1][2]). It turns out it is easy for people
to accidentally write comparators that violate transitivity, which is
why I submitted a patch previously to emphasize the properties a
comparator must satisfy. [3]

I have actually thought about whether we could detect transitivity
violations at runtime. But if we map this to graph theory: treating
each element as a node and the comparison results as directed edges,
detecting a violation is equivalent to finding a cycle in the graph.
Doing this would require an O(n^2) time complexity, which is obviously
unacceptable at runtime.

[1]: https://lore.kernel.org/lkml/70674dc7-5586-4183-8953-8095567e73df@gmail.com/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=233323f9b9f828cd7cd5145ad811c1990b692542
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4e0a15f8b4bd47548032acccdbeb5b9083b3675e

Regards,
Kuan-Wei
