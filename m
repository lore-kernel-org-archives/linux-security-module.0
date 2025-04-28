Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F475263F4E
	for <linux-security-module@vger.kernel.org>; Mon, 28 Apr 2025 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745840638; cv=none; b=BMYwBxuCahQLCt8179SOW4n+/D5/nUzD8FZLt8/U4ek8kT6YLK+i40yo3Q23vF9MF0FR0Ln6Rof6YHt3lo9p0m6cXIOrORP/PNl7x6XU//nRufCk7LoNh5Z47TULN3T1u6Tpf8qbDgZML4pQ6h99lnnWpwQ+oDjBgsuaF2bqdfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745840638; c=relaxed/simple;
	bh=ZyDowSCFBjbol/z7R9f+73E7pUMl3a1ZYbWk5IkH/xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dS8/FIE1dqmIO69UsRipZmS/R79pKgxjyb9s1UDiOc0yA7V/Slb8YKx47GA87U78u6gHKrbS+P06HmFi8E72ugeJto1UoyTicDm9h+L3pF0Lybn0CjSO6qSAvfYg7I+b0ix1Ed7ji8V5G5Nsj3czniICjm7YGNN/kv+QbOah3C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=FqjpakDH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="FqjpakDH"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-acb39c45b4eso738346666b.1
        for <linux-security-module@vger.kernel.org>; Mon, 28 Apr 2025 04:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1745840634; x=1746445434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27k8fTgb68nwgdu8HS5yYjoAdsGv+rXKJIohoNl+Pgo=;
        b=FqjpakDHi8d64/ewaDwjWyAn4ldF+gA+5uAVofqkxNVHF4WfqeJhaRP7sopTqgeH4t
         EAfw1qUwnJzkoq2HkZBKM7ybfO4X3J5t08hiVIyTpFsERVJWeTmU5XpWj5QrTUnlL2Ri
         QSQtVA2wRq1dFgyz0oU/gBo4gW9rEIQU2fwdq6siq3VInxZ0cSAQidLqXXASPcU71f/O
         w0asdYS8wb/Q8njcPm6Ip4MzieSI0AXezKXyuxtn8iLt0pQbCr/eSlvMbelVbcXhr6D5
         Pw80HMmj9d4Vn1O+PhAL4K4BBDDaaQMrvVikYslgnTc+2vkMEL0hOsnAmyj+dtsZULtz
         Wjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745840634; x=1746445434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27k8fTgb68nwgdu8HS5yYjoAdsGv+rXKJIohoNl+Pgo=;
        b=chLqPgtVFw9TAFHQ3T4oi9qk9E2qxPfGEwQSRcgQ/8xtmLPwb9Pj9ENHo9x57WGaaB
         tTqqMN+0hDl859tjGiXVaVZO+fgEozipKGGboMRLMGyBg786Qyvo285k2VBk2OyBCZdJ
         5lDrxs+7wlNUrH94SHa3mD090LnJYxwjIURHGAA5Bqe4UScpDUVx3bseZbBQszcIdrbp
         J7TJVqMTFCwg7WpQsb3GkWElHtuJCE82BsQbY21nvEU6fF4LyecpZUIiVN4zvCCRMqaE
         VXjIzx6hANc2e7xPbefx+htcC8lxXUOH8Ikeq2ozrTX69ZDuNJCfbziQ9D1eWURfW8lh
         TIPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXejOD43XTNxrEvqh1GseGvYqTsRcuyRh5ikOwrOit2vvNA5of0MF6bpcsO7ab7fB9AwsakcVAzo3QndvUuA7neSDrDsYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoiMM/IXH98Sl4e2GeamNPGewpRce7uMzONcfQvBezs1VbBuMk
	MUh1I6/nG82Um13aGAYFnQZP2deek0L6O3lwaiHP6P7z5g+QzpS6BYAU6V6FaKzH67TXG84URZK
	FgB5lAj3168oUUYwK/6b+sWgTNtio5ZjATiU3UQ==
X-Gm-Gg: ASbGnctMcuHxg/qWg65j5MHOCfU9q/n3mkOO4QWvM+YrNiWA4iYlm3KyuRTVz7xr7Kw
	Mt26hW9nEpdktCHCUPFP0z1I08dxR7V3eXmA2JpmogamXtRkQbI18klhEQ9LD9dpJGEJwtP1sUY
	xb+fbGQXFyHA/30u17mOdf3+ls/RvR+GwuTEiXQ9x5OByKyXNebEI=
X-Google-Smtp-Source: AGHT+IEIxlQcqpaK22146mKPVF/W1IYohDS+XoqVdHfym0fkA015MpP1p5Wq8//LhK97ToEvNFs7AzHAd/74oFt6S6E=
X-Received: by 2002:a17:907:84a:b0:ace:55d8:227d with SMTP id
 a640c23a62f3a-ace73b469fbmr1238358666b.54.1745840634524; Mon, 28 Apr 2025
 04:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306082615.174777-1-max.kellermann@ionos.com> <20250309151907.GA178120@mail.hallyn.com>
In-Reply-To: <20250309151907.GA178120@mail.hallyn.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 28 Apr 2025 13:43:43 +0200
X-Gm-Features: ATxdqUEGitAegQk4E0Nyyno9BkuluE7h25YbBUSdFY1Sk1RfF3-WDjBztgA7tpc
Message-ID: <CAKPOu+_vTuZqsBLfRH+kyphiWAtRfWq=nKAcAYu=Wn2JBAkkYg@mail.gmail.com>
Subject: Re: [PATCH] security/commoncap: don't assume "setid" if all ids are identical
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Andy Lutomirski <luto@kernel.org>, paul@paul-moore.com, jmorris@namei.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 4:19=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> w=
rote:
>
> On Thu, Mar 06, 2025 at 09:26:15AM +0100, Max Kellermann wrote:
> > If a program enables `NO_NEW_PRIVS` and sets up
> > differing real/effective/saved/fs ids, the effective ids are
> > downgraded during exec because the kernel believes it should "get no
> > more than they had, and maybe less".
> >
> > I believe it is safe to keep differing ids even if `NO_NEW_PRIVS` is
> > set.  The newly executed program doesn't get any more, but there's no
> > reason to give it less.
> >
> > This is different from "set[ug]id/setpcap" execution where privileges
> > may be raised; here, the assumption that it's "set[ug]id" if
> > effective!=3Dreal is too broad.
> >
> > If we verify that all user/group ids remain as they were, we can
> > safely allow the new program to keep them.
>
> Thanks, it's an interesting point.  Seems to mainly depend on what users
> of the feature have come to expect.
>
> Andy, what do you think?

Serge & Andy, what's your opinion on my patch?
