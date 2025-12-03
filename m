Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37C82D978A
	for <linux-security-module@vger.kernel.org>; Wed,  3 Dec 2025 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764800761; cv=none; b=lgUfP2FriQZKltE5ipqYy98urMbMFKJ4hfifEHHXitMhN95O5jPKD4TTSDwNe+ycbZzYJ+l66JSRic1mbw7nw7xH42SL/eAP3JOyfhb3KZUkd14OsKzTCZDRvZbypiqq+QJ8wkhxhjMwjIhh9MOKPMabKq57R4aztTerez+GwU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764800761; c=relaxed/simple;
	bh=yJbqaL8ojewm43m1DdLKBdQ+/LqTyZfIggCH0mGf32Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbNQoExp8rgrbBi1KGUW7cXk1Dyw8YYi+VgfVHQCQTYXVwqw/sRdEyM4Q8+VGNHpo+74kD/i5cHJ2r0wzmBJYHEufmkd0hkmsFCHQWphiTPyQQ/t8RT3Tfm76w8ciR3NImfa6UKVhWPjaiutkaKLN2xNd8sRvdM7HhlIw6MwlyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avRPtCVg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avRPtCVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD0BC19422
	for <linux-security-module@vger.kernel.org>; Wed,  3 Dec 2025 22:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764800761;
	bh=yJbqaL8ojewm43m1DdLKBdQ+/LqTyZfIggCH0mGf32Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=avRPtCVgRJO2CLWgn0Ye1menS6FCKQwkl6XgmD+79nPaqnbul9FuHZli2+Mh1Pb4g
	 vFHl01KAgqCoCGVamn1Ru5v+Xh/8Vj55Z+Z8Wh8imfsHV596ATtKiHmIhYsmm0rV+b
	 Z1gY60vMVT2pp8qvzyRYtk100KFaXM9ZVnf/856bKxNQ9Xs1ib2sPyV//9v0pF7L4n
	 /Gofvp3nWVbqBKzsPk5Q6SZbgWyUmj+QIlLV5Mfg0zqrtkQv5iNskgUIzL6bxKLt+P
	 zvYENB7ryN4oMGlqE9YS6LsiCLU6joopt9CvgFVodkxNjIZH42L1xbH5HF2irhdE5m
	 Z0Ji1ZNJiBWkw==
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-298145fe27eso4472125ad.1
        for <linux-security-module@vger.kernel.org>; Wed, 03 Dec 2025 14:26:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXX7qfAYI9NS2Y2ncgBIVsgRa/CBEPCcqoKQCKm6UBea11Nhajjrqg2h3obyv+9IdseUxT79wAWguXOAuOtE1kTj8p1b1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFwPm+SYi7Q7MbtL4DLd6RYlBnJSxcV2+EJO5DoBJw2KtUXMMS
	blWzrUP8j6sRiu0gbc8CdqQKThSebXpkT7H0CGEZcPBCC6vBjhI6u7f2DEhvXwLrUScURx+KTZ0
	LI222Z2MbCsCc2dwXz2/7mj0b21lSeXM=
X-Google-Smtp-Source: AGHT+IFuDgo14jIz4/9Znlgpe9ZVuRHeKGR1Ustj24didkwfgIkcUC0dUaZbZvVGR14j3L5Qvwb7ExhFG+26n3KD7as=
X-Received: by 2002:a05:7300:c89:b0:2ab:9d51:3b64 with SMTP id
 5a478bee46e88-2aba45015d8mr566927eec.29.1764800760963; Wed, 03 Dec 2025
 14:26:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203193718.504344-1-yiconghui@gmail.com>
In-Reply-To: <20251203193718.504344-1-yiconghui@gmail.com>
From: Fan Wu <wufan@kernel.org>
Date: Wed, 3 Dec 2025 14:25:49 -0800
X-Gmail-Original-Message-ID: <CAKtyLkEyD9UVxqbmODVOAymE32aE7X4Xdbqj6H3BMGyhn_PQqw@mail.gmail.com>
X-Gm-Features: AWmQ_bkq7DrK_zFQ0Ycaka3dZVAisMR-j3dPfXgL8aEjqJbHAnPDW_BV4ZcOagI
Message-ID: <CAKtyLkEyD9UVxqbmODVOAymE32aE7X4Xdbqj6H3BMGyhn_PQqw@mail.gmail.com>
Subject: Re: [PATCH] ipe: remove headers that are included but not used
To: Yicong Hui <yiconghui@gmail.com>
Cc: wufan@kernel.org, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 11:37=E2=80=AFAM Yicong Hui <yiconghui@gmail.com> wr=
ote:
>
> Remove headers that are included but not used in audit.c, audit.c,
> policy.c within the IPE module
>
> Change have been tested through kunit, kernel compiles and passes kunit
> tests
>
> Signed-off-by: Yicong Hui <yiconghui@gmail.com>
> ---
>  security/ipe/audit.c     | 1 -
>  security/ipe/policy.c    | 1 -
>  security/ipe/policy_fs.c | 1 -
>  3 files changed, 3 deletions(-)

...

Hi Yicong,

Thanks for the patch. This kind of cleanup is appreciated.

Commit message typo: "audit. c, audit.c, policy. c" - audit. c is listed
twice.

I was trying to verify whether ipe.h is really not needed and found
that these files are missing explicit dependencies. policy.c and
policy_fs.c use rcu, mutex, and slab functions but rely on transitive
includes.  After removing ipe.h, they still compile because eval.h
also happens to provide these dependencies indirectly.

I'm happy to merge a patch removing unused headers like ipe.h, but
would like to see the implicit dependencies resolved as well. Would
you mind tracing the complete dependencies and adding the explicit
includes in v2?

-Fan
