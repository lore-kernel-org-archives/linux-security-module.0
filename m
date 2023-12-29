Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAFF63A
	for <linux-security-module@vger.kernel.org>; Fri, 29 Dec 2023 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Yfi1kRUR"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dbdbfaab70eso4298081276.3
        for <linux-security-module@vger.kernel.org>; Thu, 28 Dec 2023 16:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703809158; x=1704413958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cEo2Ugvy631qhTrMS3RccK1Y17x2v86Km3ZLje/SNw=;
        b=Yfi1kRURXi8ETveb77Eusm4amY8G/5PM0cWvryS80m9ym8IeTfqxT20nzo3NS+jvhB
         0Va484Fs6Yx0XeY+cxAFVWBcT0wxAQ6yk4At6rveggdzNPvr5PlC9oTS+onpXjd/hdnT
         rtlmkCFmgRJXWOfqUFVb/Qe5wtulXwYCdESGCk+uLAmLQi9YdcoV8RCqxIzoWnXVBmxe
         MsTxS7N4eX7e5oTNo+/Ukv3PtjOu/19bcEN1cvLLCUNrTtjzM/3PNn5Ln+zHZDdMig7C
         w+7/IVEvtw/73oVTMXGtbv5jYIbsWJBXimKaVHN4gsVu/m8gLmnhis0zRR/WqZ0btfhM
         ApXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703809158; x=1704413958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cEo2Ugvy631qhTrMS3RccK1Y17x2v86Km3ZLje/SNw=;
        b=hzb5kuNHkiygllNf6e753PapmYsDJgrHWCqkss1GHbVxYuBbErm4dQ7KRsG3CPUFQH
         okzBWy7b2DyWmLDlYi28F3vHE9agr7VtqucXYdW16WbvlHM6IKx1vO8BUTUhGRhELHtE
         MnN+LWUm2QKLrnT+8S8vxmXL+ucsyp0BGHdLz8/82IqzhYSovWZfPW5oQ7FpUXuBF7bt
         dUFls2ez+aJxdvtgOI5JGW2trwSTHe/0yCJzoHo0CnZqxtFt4Fk35PFHW9iAJ/wBT15S
         cXJfPiSb7k+kNmCJmErA4FP4oLE00hDI7NVnW9vxvIq2KZ5KajrwLwVzrdkcFyuLqKIy
         Ujeg==
X-Gm-Message-State: AOJu0YyCliY9JqciphfmaYuVNjSI69XwTYNDt8g9m/1oVLBCB9wmz3xo
	6Zps45y+KAeZgfHnkDnUW0JoieX/ZXR2rddtG8XNWrgO8gvc
X-Google-Smtp-Source: AGHT+IEp/1iCFuxTXErlQvBv5mX2X2yrx3CHtCqbu/F/FozWARWZG3sopFSp6JAiHGlzpZbIaWtLRfQYnp3EODGrMz0=
X-Received: by 2002:a25:2d0a:0:b0:dbd:45b5:7037 with SMTP id
 t10-20020a252d0a000000b00dbd45b57037mr5269538ybt.105.1703809158617; Thu, 28
 Dec 2023 16:19:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228113917.62089-1-mic@digikod.net>
In-Reply-To: <20231228113917.62089-1-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 28 Dec 2023 19:19:07 -0500
Message-ID: <CAHC9VhQMbHLYkhs-k9YEjeAFH7_JOk3RUKAa7jD7HP0NW1cBdA@mail.gmail.com>
Subject: Re: [PATCH] selinux: Fix error priority for bind with AF_UNSPEC on
 AF_INET6 socket
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Eric Paris <eparis@parisplace.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Alexey Kodanev <alexey.kodanev@oracle.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 6:39=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> The IPv6 network stack first checks the sockaddr length (-EINVAL error)
> before checking the family (-EAFNOSUPPORT error).
>
> This was discovered thanks to commit a549d055a22e ("selftests/landlock:
> Add network tests").
>
> Cc: Alexey Kodanev <alexey.kodanev@oracle.com>
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Closes: https://lore.kernel.org/r/0584f91c-537c-4188-9e4f-04f192565667@co=
llabora.com
> Fixes: 0f8db8cc73df ("selinux: add AF_UNSPEC and INADDR_ANY checks to sel=
inux_socket_bind()")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  security/selinux/hooks.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index feda711c6b7b..9fc55973d765 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4667,6 +4667,10 @@ static int selinux_socket_bind(struct socket *sock=
, struct sockaddr *address, in
>                                 return -EINVAL;
>                         addr4 =3D (struct sockaddr_in *)address;
>                         if (family_sa =3D=3D AF_UNSPEC) {
> +                               if (sock->sk->__sk_common.skc_family =3D=
=3D
> +                                           AF_INET6 &&
> +                                   addrlen < SIN6_LEN_RFC2133)
> +                                       return -EINVAL;

Please use sock->sk_family to simplify the conditional above, or
better yet, use the local variable @family as it is set to the sock's
address family near the top of selinux_socket_bind() ... although, as
I'm looking at the existing code, is this patch necessary?

At the top of the AF_UNSPEC/AF_INET case there is an address length check:

  if (addrlen < sizeof(struct sockaddr_in))
    return -EINVAL;

... which I believe should be performing the required sockaddr length
check (and it is checking for IPv4 address lengths not IPv6 as in the
patch).  I see that we have a similar check for AF_INET6, so we should
be covered there as well.

I'm probably still in a bit of a holiday fog, can you help me see what
I'm missing here?

>                                 /* see __inet_bind(), we only want to all=
ow
>                                  * AF_UNSPEC if the address is INADDR_ANY
>                                  */
> --
> 2.43.0

--=20
paul-moore.com
