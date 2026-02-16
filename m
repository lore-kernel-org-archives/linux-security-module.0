Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE741DF271
	for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771256813; cv=pass; b=EuAPcEfkn2NJVrVCtcOr9JFzFEAFrdLUTurKzir5JBcybnU4LO+7I+g9ZbtJksAsOl3oqVHsFQzsZt5sAqDhyvffxCS3JjqlbynT+Mqg4M6ox4KRH2vD0twvZFXnX+PH1XHZNaGIrV3BhA3iN0+0Qd+Jk5A1bYLMegFMxH592kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771256813; c=relaxed/simple;
	bh=djpwv/o4GoPPJBT2whDzEpO49Xpb/mpKkKS5KADS0aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqXvU/kiR5QbBqwfmXGOuUh2Lmbw1FzyVYxdgDydM/19d36lxnvdnqz2s50ATevJU4+6ZaFpdBMOxs2JCvp03FKvZzrWp5KVALNmaJ1H2wwSEFK/vVY9fz1TBsrkUswy9Bz+hMQUGtXUw8HjZ58J5ngs6BTH5SGQtLXbz7xwFw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ls2hUITJ; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ls2hUITJ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8845cb5862so417556466b.3
        for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 07:46:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771256810; cv=none;
        d=google.com; s=arc-20240605;
        b=N0gH0lRaOJaD29XGWIXU5FeFeIfRRH3MeeoikiO1RDKrIXRU0ybyL4BpiCrpJSkgCh
         yIX/9Q7jxsbyfzUAvuUZ7U3SZ6kLAkrlNLHPXjx/Mmqro9ZVM74fd2cXyTx4wyBWvvJs
         ZqN+CFX888bdz5AlH+cH4LVDFqC7fZ76EvjhCRv7BoM8lvs23fySqRW3e85Ji0PxLTeY
         kJJRO6g8u8a5pbryUEJvN54Zr94z1mjKs598U+2FHs6jMky6+gMLEibpjhqKsnNWUoap
         ld5IIoXSsby0oIAs59yLh0p5setgoh5g11yRCXAflIehjbx3BnxUgGE/9i3mfHVnUj7c
         5IfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EwFQ9XHRm/+AQIEABXNY8BO3EtxJflHDwT4zNmU2dNc=;
        fh=mavcUlkkpRwYTgw46aXA0vZVx0tYzIKeWutWakVXXIs=;
        b=H6NXpjiXXGFv7nCiriJ7IAYDZqCXRtyY8SkTmToEXX0sL1oGuKVG6lMfJxLCti4rLv
         IeqArD+EHiF1fp7DD1zW8n4AWIbiwuY3vfY/nTfFf8LUlwbXYFogd+wtONOpsD+EEZVN
         E2KV4fNdgl3pLmlF7FSFi38+mUaccVpfv2jb3bkKiUQ1tcsD85pIki/fjZ7cnzhm5mRI
         OQ0yEba/qRDU/ka00cIlQUiK7zVueb5rqa8GM8tn3KW7jrdLoM8K7d7vHXCf13rEirgp
         M57ftm1ZKcGZB6BvBEexD6FR2WVsB0uzjnwcmWcPR1VroBEE2KO9E4XOWjIb8jeJ1Xx6
         tpQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771256810; x=1771861610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwFQ9XHRm/+AQIEABXNY8BO3EtxJflHDwT4zNmU2dNc=;
        b=Ls2hUITJPzh2+aWIbjAnvxJ8Q3fFBL8727qpP89XXZGqd1sAOZ99q8QjdTRmIAPaOV
         u1/gLyUXYWeZ1xoU7g/QQOQA9RdQcD87jAzZKzd/vW5fJOt4W2hsjan8lsCrA9lx7uma
         eet9IKx02VqAYcsdPlfB3MXSN6n6bUbT7YiOhN1vjkchrlsHbnI2sLmTCPtR1fYhjr39
         7hwEvZOW32wRq8aTMGUnWPfL7kUlsSyB0uW0lEY/GYpvUkBNcM5X+uG4EHkHzrJgELjC
         rCJlf6+HgnW4yasia/jFwu1YG2BllD7zQL/yE4TYth5SqvE+iQZSGFQJXdIz7cKEDcCP
         hnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771256810; x=1771861610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EwFQ9XHRm/+AQIEABXNY8BO3EtxJflHDwT4zNmU2dNc=;
        b=iBeCHmgeUSX+iyzlyfaIhMjAVxPtmHQjLI2J+Hj0Ii1bWpelTBhp3mh3yF29yiYx4k
         hAwQYriHu8oIajbCCna9r96hlTT8hyrkl//tOScd54GbEZlIiBjl5IfuykDnbYwxfAP1
         dQqZ6ehLtrbEpe+fuZDJa0DUHTgaJ6sN63ZjVT0Z8sX3YWWxTlc3gjMl4yW1THk8g3nV
         cpJIG75kmr+Sm8da6ZDEdZSE2opeZpjxw4a7MywhSpNKx74GRMDEcSrV0UkBU+C++cvx
         CCaLTZvhfU9T0myTDRA7JPVwpQNfPzFUFxoHuvRJtNk+zeChDb7NLkL9YAqZ1Gc+/cRx
         pXCw==
X-Forwarded-Encrypted: i=1; AJvYcCXSzPCQycsMtIn/Ffa3BaD/iRT1Ata7NTLfMKpl3tS21Qys9nRVq6KkXxGBPDspldPzfucuknE07uAaYsgOOLvoLz0LNgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSAW4bNKu5DSmFku7Opr9DecBBH2ZqvDzzHiz7B9QG6PUWc1lZ
	BDFSbJXSZ8KzLnuPvq8uZmaAtPnSRU9ifA1C9rVFe5X1hpIfgGGtpgoTI6clS5k4oOcoi3FU0Cf
	/YJe4GZj7l8xsv0l2YKewD/97NVjUZ+M=
X-Gm-Gg: AZuq6aJ5o/Vp6IGgbTltjQIRxE4i+VPsA6rhDC5HSXrhG36aDEoiq3X5SZUEjP/Z0V8
	tPHDsQLfYGOB4THkaBYlyuMCRmbjirpgQR8L4IpPd7H2zmmMgEbIFqdZc9xcI8uUZd4rx8jUom1
	Ul3ga6hdIDquEL+qkn/iwKR8QuNwddQyO0UqjpyrieusmshnxSAIyo3+W1H/LUtnMw84GsM1pD5
	iTwABa5VY7Bfg0Vp4erYkbdI2wWCGuUyaO2d3Swq7XHKuBenzaulxXRAuoDJmLCVnXB7cTvV28d
	1vwUkudt
X-Received: by 2002:a17:907:e849:b0:b8e:dc98:ad20 with SMTP id
 a640c23a62f3a-b8fb4149e36mr557161866b.4.1771256809530; Mon, 16 Feb 2026
 07:46:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216150625.793013-1-omosnace@redhat.com> <20260216150625.793013-3-omosnace@redhat.com>
In-Reply-To: <20260216150625.793013-3-omosnace@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Feb 2026 16:46:38 +0100
X-Gm-Features: AaiRm50W-dqNFKibz1fwwn2MM3hFVT2cCQwgYkQhpvQg3H1petMEkBdqAAcwRxQ
Message-ID: <CAOQ4uxhDwhd5Rn00qhd0j-OySph6v6ZCi8YM0MUP0C6Y3NQUzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fanotify: call fanotify_events_supported() before
 path_permission() and security_path_notify()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 5:06=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> The latter trigger LSM (e.g. SELinux) checks, which will log a denial
> when permission is denied, so it's better to do them after validity
> checks to avoid logging a denial when the operation would fail anyway.
>
> Fixes: 0b3b094ac9a7 ("fanotify: Disallow permission events for proc files=
ystem")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---

Fine by me,
Feel free to add
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

>  fs/notify/fanotify/fanotify_user.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 9c9fca2976d2b..bfc4d09e6964a 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1210,6 +1210,7 @@ static int fanotify_find_path(int dfd, const char _=
_user *filename,
>
>                 *path =3D fd_file(f)->f_path;
>                 path_get(path);
> +               ret =3D 0;
>         } else {
>                 unsigned int lookup_flags =3D 0;
>
> @@ -1219,22 +1220,7 @@ static int fanotify_find_path(int dfd, const char =
__user *filename,
>                         lookup_flags |=3D LOOKUP_DIRECTORY;
>
>                 ret =3D user_path_at(dfd, filename, lookup_flags, path);
> -               if (ret)
> -                       goto out;
>         }
> -
> -       /* you can only watch an inode if you have read permissions on it=
 */
> -       ret =3D path_permission(path, MAY_READ);
> -       if (ret) {
> -               path_put(path);
> -               goto out;
> -       }
> -
> -       ret =3D security_path_notify(path, mask, obj_type);
> -       if (ret)
> -               path_put(path);
> -
> -out:
>         return ret;
>  }
>
> @@ -2058,6 +2044,15 @@ static int do_fanotify_mark(int fanotify_fd, unsig=
ned int flags, __u64 mask,
>                         goto path_put_and_out;
>         }
>
> +       /* you can only watch an inode if you have read permissions on it=
 */
> +       ret =3D path_permission(&path, MAY_READ);
> +       if (ret)
> +               goto path_put_and_out;
> +
> +       ret =3D security_path_notify(&path, mask, obj_type);
> +       if (ret)
> +               goto path_put_and_out;
> +
>         if (fid_mode) {
>                 ret =3D fanotify_test_fsid(path.dentry, flags, &__fsid);
>                 if (ret)
> --
> 2.53.0
>
