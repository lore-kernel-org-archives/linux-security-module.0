Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA4E2248A0
	for <linux-security-module@vger.kernel.org>; Tue, 30 Sep 2025 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759248381; cv=none; b=ndm2CAZ8Nz4EVV+DcecN8Lj5PObJafSKz70dw+bfGh3kIlTPj5yUKX9BdCOWN55/l2Jlj4ZkE/EVXyeaEqXlZjS4/0SJLZgZUO8Rm93U0cXVtSbLBJRoxCLr6OG7f710Drn81bVeCgbaUYYHKypRg3IeuSdbHVa/IPRvdKuw2Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759248381; c=relaxed/simple;
	bh=4LAHa88vbeIl+weKeoEbPujoWmcut3UqDI9OFd97U78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3W9z2UzSSr23fwj/R/GgIsB3Mmf7oEdoQMfRhV+Zli7n0yzvAt0k5gcmKXLlAgqPoOn/4L5QeYeafCRHzcC0VffDADusN2DAc8KxImfhnyHbEQ0z+dev+yamq0U/1kp2Sn7HGhAMvVNi1yDK5pmmT8q9O0FgQJ6zmA0LFGKXng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CQcPhKGs; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CQcPhKGs"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b5506b28c98so4253335a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 30 Sep 2025 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1759248379; x=1759853179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z89BUY9Cra+O574AfOg+Bp9As4JebZmqapfAjzv0GpY=;
        b=CQcPhKGs3yqIZYOwyN5bBbxS7x0cHR8kopBSo4NDrrqNSwRdWgPlMUxMCIPdDy1HtU
         Al/TEtCbNk+7bS+c78ZXu0wCeCf4cSFtMqOV2xEWMBQUoAlGVosG0kBsbmPIUER7k7+0
         OmlG/6A9Mc4ln4DyLZt7hWiQ54URhcLoWRkIZS/uUPiQKqzllQIEGYnwpYWmVsHRvmUc
         DjdcFVku3yD/kOFCr0brIMde7BPpTmi1XHUdh9vs5wEq9uNKkA7UJQdtl3dkAKl8h+br
         SuXoyuPA4SLHQYfxZrf7XQ7ViRk7MkTcPS359zkI+rkkn3aNFHThpfsErKfEuqaD4hr9
         fQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759248379; x=1759853179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z89BUY9Cra+O574AfOg+Bp9As4JebZmqapfAjzv0GpY=;
        b=RppX2xHqVQvXDpdUWKORy1Q7zRMJBRnw9leDmuWJ494QDx9Ae/0cjAVf2LNz5aSJ/8
         qA+kS/7R6jdAyWaAUCBr8MT2tjEk5fhDcOVIn3/H7N4UdZVlytMxaLaL+88rCgoRqc26
         /UyKHx9i46b4QCjj8fg0+liLSMwO5+vsKeWIN0NnrhZca5LneuAEKqyIHDHTpB7XNW88
         M3V6H1SUVLVRND463tb2kx5p4aPrLif88AHfvF+148r1IuZkA4U4+iQW0zpFy8sQysKS
         onkr0N6iSoyax+2iH5mmRBVIzX8pBt9yOjtrK4ciYRlqUMzRi5s+gndUpe6xQJzCw/Jz
         dw/A==
X-Forwarded-Encrypted: i=1; AJvYcCWzOsyV3VZcXhBOtbV8qdwppl2EcXRfaEXs75h7XrwdTen198mLdA6QCqr1A0f1v2OnXedZ/sWoI6NYNNtWzh16Jhgw9y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YynoD6hTnlVtD4hn7K7JwdmM6tDkYGUhsqswijX3STMk/JOLivX
	hk0yatk3DEZBtp078tbZkC1tfcSHwHwTSYu10l1QXOou1GVvUIb9uqhiubLFSvoozbpFcCh3Ryn
	NhSiuQh1bTu6j7pcjBsse77sD8wqwcMIDG767lpYAgQ6zi23VXdg=
X-Gm-Gg: ASbGncurV9NO8jRiSa/R6R2CwdFAQXll7MSxnUaC2NphV62ZvD8Qb4P0IlBnXdYK01p
	wy/3N7d/Jz5PIpiajKjNQKhfP6Mv9WkYKXt+ZoVYTW5XaosCmMp9Ii1hDT5rBSw2/qrYMGOVKGE
	8ylka6YShH8/VugFoIEPeXC7VWKE8TCRlmmO9Rs+KDEtCLkV+K3SOnddapYG/1kWUlKZVWTOydt
	V9XJyFIY+0XirBnX0ygP3kIUwCHdGaXHsTXsy/AEzyqJGk/AXh5
X-Google-Smtp-Source: AGHT+IG5bEbGXJ6F6vdgIp01CQ71EXOMa2CN+mQzxedOYwqI7wBaBnxC2jpv5Qft087m15qZlxUga0hUcV6VDsx1WdM=
X-Received: by 2002:a17:90b:3846:b0:330:6c04:a72b with SMTP id
 98e67ed59e1d1-339a6e74b75mr25022a91.3.1759248378597; Tue, 30 Sep 2025
 09:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6edbd0e6dc79902981bf9a34e8d41128@paul-moore.com> <CAHk-=wgfeAjTNomdTU3gx308O+k5+3STqwBMSqrM7=D8CyEydQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgfeAjTNomdTU3gx308O+k5+3STqwBMSqrM7=D8CyEydQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Sep 2025 12:06:05 -0400
X-Gm-Features: AS18NWDvPZRY5aHYyMNXTEgmKK4Bp7eFYTd5-sLb1Ui-V1G92wxYg7rFi8-OHUg
Message-ID: <CAHC9VhTS-vnHrDaR+Fed1wuKxxfqYJFz8SP9SQjmfrh+K0V3AA@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250926
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 11:48=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, 26 Sept 2025 at 20:07, Paul Moore <paul@paul-moore.com> wrote:
> >
> > - Remove our use of get_zeroed_page() in sel_read_bool()
> >
> >   Update sel_read_bool() to use a four byte stack buffer instead of a
> >   memory page fetched via get_zeroed_page(), and fix a memory in the
> >   process.
> >
> >   Needless to say we should have done this a long time ago, but it was
> >   in a very old chunk of code that "just worked" and I don't think
> >   anyone had taken a real look at it in many years.
>
> Lol.
>
> ... and when I looked at this, I went "scnprintf for a 4-byte buffer?"
>
> It uses
>
>         len =3D scnprintf(buffer, sizeof(buffer), "%d %d", ..
>
> and I went "printing two numbers and just four bytes" before I noticed
> that they are just booleans and so 'len' always is just 3.
>
> It literally could have done
>
>         char buffer[] =3D { '0' + !a, ' ', '0' + !!b, 0 };
>
> instead, and I guess a compiler could do that transformation in a perfect=
 world.
>
> But this isn't exactly performance-crticial, so nobody cares.

Yeah, exactly.  IMO that scnprintf() is easier to look at than the
build-a-buffer alternative, and if that scnprintf() call ends up in
anyone's performance measurements I'm going to have a lot of questions
about what they are doing with their system.

--=20
paul-moore.com
