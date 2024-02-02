Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CACA145B38
	for <linux-security-module@vger.kernel.org>; Fri,  2 Feb 2024 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887910; cv=none; b=G/bHCj5yM/Gbx+WqKeBnXpKB3mgxFZt8ufLxZg3m6boCtgEv1SCt8EacJv+MulcOUO9bYDpY+G/KJUjVBVDvJiiqh7CFsiZdADPJZZnyzADpAFto8QjyEKmONyKNTSsUPQBaTwk+Cx98qfyRsRtRAYAPpnEIXuEWt4RMsN+AA84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887910; c=relaxed/simple;
	bh=X7CHp42Qev89FZqIAikgLbDlNbexH9c5Zo5LqW50PQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7m4E72z2LKvd8jeBISbRPloPnZm17U7licMsd+0DxLea3RKhk8rDluWdebQHcuGgXdPpk0SC8zSa9/WT7DjXnzmf7HpXcqij9v1mXy2TeE0atsZGmbEBvp6ri+86Y0jIV5x1S1smz0Jco6+cLVp7x+bu2m9s6clooFht/X7GuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eErp11Hu; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eErp11Hu"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6d5206f18so2184633276.1
        for <linux-security-module@vger.kernel.org>; Fri, 02 Feb 2024 07:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706887908; x=1707492708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uyvOAzMFIzsSlq2kiKta6LgOvAhbSJpfLskxvPgpInU=;
        b=eErp11HujsPY4cWoXSjHHOZ7vPmZED3O/U8ftVzZuTZ9g8qtb1trzvxG56JUjAaxMe
         RYQwlFbhMdnu52+jdMDjo+xHKRRUCrDwB98PFLqVAyWEsuG9nYI/1bWr1/WZOM6GR7PM
         mDqgxLlkDkuKH2n5zT7fADQz6mAC+zklOOkx+B8YzO7FhSG76XI6cXN+GrD0tZyXOpWL
         /i2EbwUNkBn8XW1MaKndDq0v+JxbYX7Qh91kOTTym5JUIT3CA2kn+df1ZilHYqBBUqgs
         mZuCQUU7pJXm9KOFOp8RiJajcoHhpoxEVR3UUobSDWfHKC7DEv+J1y+X95C6sSgQmRFi
         DEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706887908; x=1707492708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uyvOAzMFIzsSlq2kiKta6LgOvAhbSJpfLskxvPgpInU=;
        b=TC4zYdcZ3Sw6e14onE0mIh3aZZ+RZL8B97yMgHgieHS8tbsjqa/7L0o92heJve77Yn
         0k4QShzpwJbdRW1HKsxLkFg8XVza1zCvGZ/Bgg5ui+p5pt4o706BlMO+uk6+6nNq7lCG
         RmbfI0TpNbG0HcdaoE3p4JmRZCfZHkaC5+ncpfvV23xr0ywLLUg2CXvGBNmKQxnmxV1v
         5dTEgtEGDf55JR4TxVQ5oj+3OGF/Pg0se0zLclmqxcsIAJ5HD0RgNWbm01xK/HmYDgaO
         HykOhXcJ1pswtrD5sO8HU5RVUL29PwxFrzJwuJOJZsklhgHmEiAosD2+buC+qSwaLwrg
         iE9w==
X-Gm-Message-State: AOJu0YxB4wKcFnwgkXKcyP5nCQLalP1AJOkGuArF8Lkb7usnv6fpBqRf
	QE+X4jvVcCzRf5GDkShmJueg8mZRLj0g0wwjrGqA7pZD15+HGMGMZwlLYVe3ZLJ+ArfPjgjG9NQ
	cbN4NWAL4lrRVTJR+zwGe6svDdgxK9Ll9XPCLD0awmhC2NSc=
X-Google-Smtp-Source: AGHT+IF23FJH1CrfkAGumfzPLOg3qie8GMPsuoo1BWOC2z8criLcQmZEuP8ymTXXNdxx7AdItEawlzLieCj8emW2AW4=
X-Received: by 2002:a25:df91:0:b0:dbc:c56f:465e with SMTP id
 w139-20020a25df91000000b00dbcc56f465emr8987242ybg.3.1706887907968; Fri, 02
 Feb 2024 07:31:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202034448.717589-1-dongtai.guo@linux.dev>
In-Reply-To: <20240202034448.717589-1-dongtai.guo@linux.dev>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 2 Feb 2024 10:31:37 -0500
Message-ID: <CAHC9VhS2F8LkjRNQv7=x1DyRqDjatpuHJL5QNjqz7ru8-0Y1_A@mail.gmail.com>
Subject: Re: [PATCH 1/1] Modify macro NETLBL_CATMAP_MAPTYPE to define a type
 using typedef
To: George Guo <dongtai.guo@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, George Guo <guodongtai@kylinos.cn>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 10:45=E2=80=AFPM George Guo <dongtai.guo@linux.dev> =
wrote:
>
> From: George Guo <guodongtai@kylinos.cn>
>
> Modify NETLBL_CATMAP_MAPTYPE to netlbl_catmap_map_t, which is more
> readable.
>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  include/net/netlabel.h       | 8 ++++----
>  net/netlabel/netlabel_kapi.c | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)

I'm generally not in favor of minor rename patches like this unless
they are part of a larger effort (code churn with little benefit).
I'm not going to block it if the netdev folks want to merge this, but
I can't say I really support it either.

--
paul-moore.com
