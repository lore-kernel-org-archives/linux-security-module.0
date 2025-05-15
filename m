Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B521348
	for <linux-security-module@vger.kernel.org>; Thu, 15 May 2025 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747315375; cv=none; b=f4L1XjnItkMRfkKXI+1L6Y4bTrWLqIyDYoUffb0iGY0v0NaRApNu2Eb5FKkVwAvPM/tt1av7FBL7u3RpbTSw5RjDbvMr1/EaafnRF4nckt3Q0WW/DnzpQe8ayuT6cfRDLRPJ7xmWRrdZxIAcr+dd+Lou967B2qLJtWAXW4cn+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747315375; c=relaxed/simple;
	bh=EgyG0ArL+HtCA+Jm/wHgbZXmmR3n8RySP1ZgRGQZxWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0HBXfgjdN1sEbt5pOd5vb2SGqXQJY9DXK3xhakkZuBfEfbHGZouARavCGwFO8Ehgd+HHCzQ6NQy80iDOsWwKUieQZYtKJJNXw76PITdqyMeSMr8Tuf6yNFNrHJUCzknqztay6xkJhCO0u2t51EwgWKGf7UDIOi0nfntRg3Qk24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=UbHWgPgJ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="UbHWgPgJ"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54b10594812so1014120e87.1
        for <linux-security-module@vger.kernel.org>; Thu, 15 May 2025 06:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1747315372; x=1747920172; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xpwhDrJcmdUxr+aMMW8YmzS8jkn0TpvM55yuHoJ1Wh0=;
        b=UbHWgPgJlT4zTzCgy6zO4SjqWDOSZqkfB9SCmeVPKfQ0rlrNfu0HZLugjQIUYDrDNO
         oc1Py+EGVpmlqffPhblY7k7P7Mc7HoxI4VNO6GDySG2D0t6rV/oeLAG8g6wUoN6zU8dz
         hKTpqqzaEV+VxyFVFbtDYgLCu/eLQpSvwtiSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747315372; x=1747920172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpwhDrJcmdUxr+aMMW8YmzS8jkn0TpvM55yuHoJ1Wh0=;
        b=NHyAH3Ltjf9iu9GuAUaESTCq4PWgykNwsRJ5Cn9oUrjDcC+AcmLVcd+RlbakimPb7X
         t/s9GMTV+p1FFrw/G8QaiEiEJfl75U8bX2nOtia20BK2IZjzJFjMEh+ThY1G5tzbEOQF
         w4a8otPDEbh3QqBkRnTbm1mISqmJOlJ/13VqaG4g7r6feK9mUWhrxRwDVXp9IYotd+R0
         wH0Z+M54wqKONq4Y9wESPoDHeej13hcv8Pl82XRv+vttB+LXJN4FYY9PQu0HcZa8ddjO
         6wLwIDLv99HG8QPcLQrwe7ZhNkWmd5WXWa8rEjxQXJtujgyj4N2bSd7qH6kfnkN8Lprz
         JfPA==
X-Forwarded-Encrypted: i=1; AJvYcCVSI3cF87KZIbjdIbZWWQfp1VDboFPk+T5FSKYHE173//Oq5pJNWzrS1IQLgzgvmr1Tb6/jAvTR5Nv6wvEnsD6OqRel930=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAF5hvd4tFKyNjOC0K+hzTpjOXaJ0WSVprV36xPmyGrzsWpxZ5
	/OzwmNHzG6M1T+1tysaXEdMbyHEsNzcXeFG9LTakZz2wafzNdrPvlx6rNwwtcMkKU3C46OPQuqJ
	UuwzfJWOguQ/w+hvTZOLxAeuF47nHl/IvnRt5MQ==
X-Gm-Gg: ASbGncvKiiE+zdwkGX6iO9aEwqHlpdJATZcMggI+8tbfA2TA+CuBrsEsh6G+B/MLnmq
	o990F2Q2UPrtnorNdHZu6+3o6c5Rw1uFpeHgtAWALbYixA4Dv/gRbtkkElDk9alJJZX/66TGp6o
	6riqM/FQ+x72GXUW3/k+TgbHeUI7jmKNhLGg==
X-Google-Smtp-Source: AGHT+IEhwlbgn+32pxYI1ofa/s6/2TQuFwALvt46bLIhQPT10vzlVoBp8hOxpg+dlGoYiEgJcm1faLY456zUlXZ1SjY=
X-Received: by 2002:a05:6512:b03:b0:54f:ca5e:13ac with SMTP id
 2adb3069b0e04-550d5fb8f3amr3444086e87.31.1747315371956; Thu, 15 May 2025
 06:22:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-3-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-3-0a1329496c31@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 15 May 2025 15:22:40 +0200
X-Gm-Features: AX0GCFuJsLCvWcVGqgJhD9YjQcGy9FnFS3GMK4AhS0yialHNeCeiDfFFREAeYEU
Message-ID: <CAJqdLroB-JGEQTdDzQXZSHCETmY=gvgSr9sKGEza0LaYiuOvqw@mail.gmail.com>
Subject: Re: [PATCH v7 3/9] coredump: reflow dump helpers a little
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Do., 15. Mai 2025 um 00:04 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> They look rather messy right now.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/coredump.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 0e97c21b35e3..a70929c3585b 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -867,10 +867,9 @@ static int __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
>         struct file *file = cprm->file;
>         loff_t pos = file->f_pos;
>         ssize_t n;
> +
>         if (cprm->written + nr > cprm->limit)
>                 return 0;
> -
> -
>         if (dump_interrupted())
>                 return 0;
>         n = __kernel_write(file, addr, nr, &pos);
> @@ -887,20 +886,21 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
>  {
>         static char zeroes[PAGE_SIZE];
>         struct file *file = cprm->file;
> +
>         if (file->f_mode & FMODE_LSEEK) {
> -               if (dump_interrupted() ||
> -                   vfs_llseek(file, nr, SEEK_CUR) < 0)
> +               if (dump_interrupted() || vfs_llseek(file, nr, SEEK_CUR) < 0)
>                         return 0;
>                 cprm->pos += nr;
>                 return 1;
> -       } else {
> -               while (nr > PAGE_SIZE) {
> -                       if (!__dump_emit(cprm, zeroes, PAGE_SIZE))
> -                               return 0;
> -                       nr -= PAGE_SIZE;
> -               }
> -               return __dump_emit(cprm, zeroes, nr);
>         }
> +
> +       while (nr > PAGE_SIZE) {
> +               if (!__dump_emit(cprm, zeroes, PAGE_SIZE))
> +                       return 0;
> +               nr -= PAGE_SIZE;
> +       }
> +
> +       return __dump_emit(cprm, zeroes, nr);
>  }
>
>  int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
>
> --
> 2.47.2
>
