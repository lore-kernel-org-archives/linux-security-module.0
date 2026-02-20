Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A38F32E138
	for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771545618; cv=pass; b=D+WZd/O+MwtuOeGfg4CpBjffyu1eN21vCNWpcWvcXzfo7GFEjx8zq23grru1U8P63tXuUA1YYQaYOUGQ3dQfZutxuyZY1RmZ64g3R0Uop32kTZEb7qtd7MstOja0hvJUb9kpxI1GVL9szhHqjk/g7/aY1v7jQQe6RE9clZBl+T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771545618; c=relaxed/simple;
	bh=d21yEhqfzh8zMrqUE1edOExxeM5FU/XoUziSunkEo6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uymFEm95fecQEjyiafntF+R9fRQe04eqy/wRX0fI53rObjsvfDd/OeGK1pU7B9d61m6yMhhXvbPwXh8fmXDtVgtobztnB3kSWrs1A8FrxoAycbeKzOs63t2XhRn8sEPh/znHWYNoC7Q2EAq6xWa3sQBbTjY++h5FXrayEKx/wz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=R88Y0q8z; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="R88Y0q8z"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so772941a91.0
        for <linux-security-module@vger.kernel.org>; Thu, 19 Feb 2026 16:00:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771545616; cv=none;
        d=google.com; s=arc-20240605;
        b=i3ldBJmEjdhtHZTapJuH+ubtM66om0GjD0OztGB8sjgej5tZj2CP0Km92+LdYXD1Yq
         J4KrFauiyYmVAr8pbsOF++Ma/uZo2orfqgCwv+Hi0rgFpZV2a8UMCsSBL1R677W59BcR
         jRJV31eSmR1qmb0ajkaG7g0DzRXtq7sqOcTZ2Ml95WFg5L2cFSwuimDL1qmrWOiQpDwZ
         OoS+YdhmONBLBqbZAusf5eQqbBCqP8iVYnRSu1fvUzJITir8yBazW9X7wHWclbJ5tGQK
         85hxcUgL04SvtzhSl4A176cWRn31QbnKzht0sByKuQ0FYaWRAZzIQPzxOAJ9HQPJFhtT
         C7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o36/diJ36lG8KI3DZxLKNWURpWjbyhgAwYq0XhyOvXQ=;
        fh=+Zr9s0P4CC/tBFwnTlXWYsna82JC0zqpx/NDhy7a1Fg=;
        b=FyVCONZExU/wiYZZfkQP5vKPy5JOYi64IeebyvsTT9TGwe0htsw61FrnwQySKOQ9TW
         g3NVUsp9AEvFTz1qlA9QZd5+wQ3plXl0Fe44WdA2mkRUnZnBDE3lISe7KBpxcqCjoNsZ
         KQfOWJMDgsyLmrezSWd02be3KTq4f5cwfmUuFO9eUoDmoHUCSF0G4urrPxw1He9wpp+K
         ORJogfKX3QZZe0FQzeEh14EFGSJhIK5xbpoJLDkufxwtGZktLVrO+fC1ArHz3cb7QhyH
         xKU0m4inL5wj7ji/gxFf7OFp8kBjoZyu8h27roLXE6dfwh14rlmfElIBJbsR6duObN8o
         K+IQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771545616; x=1772150416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o36/diJ36lG8KI3DZxLKNWURpWjbyhgAwYq0XhyOvXQ=;
        b=R88Y0q8z0dHcUQAjhtFOXxB0v/Ng+vorKWHgapGefvZBQgIj80kHHJYEmz/Hu8cj5g
         1FkoZxpF3jwLYVz+/VSa1BVR9U5lSfdUF/yFHRAKfo7AkW/L7KE44y7q6dM01iq7WuXx
         x03Fa8zC8rsZLVBFG0l1WDwScTLw4vEVAcfZAIi1HvWuXiKXCGNZb4gMqwuOJrbi0BGY
         UuE/iV553N4Ph3As94swqTEcdGTKLNmwnD6S0//kuBCoWkjRSnZETJKEgc2/hDFVnpRF
         3XMjdq013lH7ZuTpXRbuiXHRj3pyOSrgmLLJT0x9pPSK0f/Fgb7qrppNT7++zXnWboeP
         896A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771545616; x=1772150416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o36/diJ36lG8KI3DZxLKNWURpWjbyhgAwYq0XhyOvXQ=;
        b=ANwvsZev6q9eVB8YR39OHQMloTisNZm/0zQEN9DyPyLkLb8TfIwQ8KWeJHoHRzP9Ub
         5dTeDjQaQRV2TALbfeutTQ+QS5bOzU3W9cf4g+ZxQRzqppp+dLejLni5LxfsIhb05zFO
         YZYSNPM4iE452ld0NZ46gx33kTL35Mhv1VGz59KiCfUctl5LAFNzBQvOwy4iTAsq16K2
         XBgp68iBoDiANCQv79TQJ9L2Z0weyBD4a8JvHF1QFwXGoaG/2cd2WpMw3z/gsqhYZkQx
         hdpZhexRJFe/S+3i/Bxq7qPyypT5nJCYVTSHZXXsrBep2om8b1vPDb6+96xiQWUdHsAO
         WQ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxQpS9nVGoY5rURPv9PT/Oj0CYZzBiqAPqKd0lMNOXA9hRDhqrTaevOqTt/MmpZvA4ZU7ytx8KqyQ+WmM4n7kSQLM0geA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhOiMBsssxKPqX3JUPrtFSAOQ0eM/YuY2ph07K4761+dNgD3T2
	ReQ2d1twYsNCrmdBG8e1HjQWadFpNcRE0ykRXen+AZcT5evjVdG3Iye729PhKCqmg+KQfBfKOp0
	NK172uWWV7HiMkEE585VQii78o6KI3P1ouMXgcbv/
X-Gm-Gg: AZuq6aLCEhUhg0ZbDwmOw0NvcVuE7YAwGQ92Z7SVuCxI5ygdsDk4PiACjbUoSq0SehU
	wP9DykIqpeSCqxslZeRLTFi3nBEZtTzVFc/Jy6Wa7OPT5CL7KsDLyi4XNHFrkSr3w5vcVlObIQV
	lSm36Jz6ToTXmREubVyGuVxJVzPW9o+OJcMWRM+Ih3c4eC5cbWLZWKSjYo9ZsrpmPRKMP8r4bk0
	DybafKZp8YMWCXm4H2jCgbegvAcmY8rINGVHCUeJZrSsoT6G52rz1Gx1QAXDN5jxCUFvjLSBOw5
	3I103uk=
X-Received: by 2002:a17:90a:d890:b0:340:be44:dd11 with SMTP id
 98e67ed59e1d1-3588916c4d3mr5800139a91.27.1771545616313; Thu, 19 Feb 2026
 16:00:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com> <20260205-binder-tristate-v1-2-dfc947c35d35@google.com>
In-Reply-To: <20260205-binder-tristate-v1-2-dfc947c35d35@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Feb 2026 19:00:05 -0500
X-Gm-Features: AaiRm506Y2kfbsAw5yuSy39Cc7BbQ8GnxyExl_UwkT36VTmOrXmenuVrilx1Qck
Message-ID: <CAHC9VhQP3jz-RbdZczp=FVHphu55ddojEmjkh+U5m02AdPiDJw@mail.gmail.com>
Subject: Re: [PATCH 2/5] security: export binder symbols
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Dave Chinner <david@fromorbit.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 5:51=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> To enable building Binder as a module, export these symbols.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  security/security.c | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
