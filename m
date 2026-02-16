Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A66F328B40
	for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255545; cv=pass; b=OR+Qp9aCe9te/RTZpWN/ScEOjFMlJXMUx0mUgyNlxd5j6XIYR6x7YuyL39/RdA19SrJ6WX7BORZGn87sNLsxFzh7ujdQ6DNILbVr/MYGWyIfuJqAY5d6FqXfsJsqpgvZfr4IjbObJDUPUNZ7cyUlJve3z55PoMGMZotnh7/iJJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255545; c=relaxed/simple;
	bh=0WdtWYEHI09V+05DDbCwX5t6QJHUAd3cuf9OggMni3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q665FbFc/U7RJD2Hgp1LlMYAVsQQoPtCnUQk49NKBL8Cia+OnxQdtf2cTINw7RpJ3txr/amrXXBDn/AQ6QXemcJPK5UEwmBrz0OdZ4+l+NTUVHq6RxFB4Q5ViJBlkHrzpM9+KP0XNfrXjv1nuxPPQuXPj9U4jSuWcdy7zvzt+vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsNuEOh5; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsNuEOh5"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65a36583ef9so5582495a12.0
        for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 07:25:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771255543; cv=none;
        d=google.com; s=arc-20240605;
        b=kwJs7fKcqPL04m0d2mriNLkAX9GVmaxNKaHfZEV3qP8egKALO90nbVoKU9k8WD7DF/
         r0EvKzU2YSxwqv/JvtEBuxfManVW0pzH9az2tDSP5GTHvGeNCu7WT9ZsnZ4/T6HcWG9e
         WgxltS3GabpN/CzmvAN3JDBQ1heJWnYvzq5wY4s5SZLzGqnhwOSxiTlT0KXN88u7OLHv
         4VaM7Q+l4yAkO7K6WQa99IQpyUgQCNYJ1+BIQSKBpJbTGX/cXzxhy9Dj78MeQU+NckOb
         d7F0XtehDeeswVEh8ZnJ20Mf7DIu3VcCtCeJ1cvDXvfwDJx2VxOD/mzRxFjg2WLatVZK
         iWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a8y53YFMQ+PYRig6TGH6tdnzevZp9DGRe/1ufZbEm3k=;
        fh=tWUsfz70/o+OKHhn/ph7E7fHIru7OA/C2lYaIgNNhUo=;
        b=VvCo3vIfC5Hu0ClGReQI/TuYyDCP9ZwsTavFu3M72y6Ww/UMtqR3vdiOqiiTBIqdEs
         2Q/6NxEnHp8nDn2dEhF+J1oiQOr4fuRgGwYBxYRGtJeRf6qdZHL0J5iyT8Is68ZpqGEn
         xKOk3NUutlQMYFCAmJ3GXxCTb0f2Z/tQT9Cqp7Gp/8Tx1wVgGleGKIW5/v2tWOb7uEFN
         feh9Yr7wK/qHD2vWdjHUv36Ns+MgJ/06Bsy9BGDi99pYfDAV9rPS7lY6FZqz99jxuIFd
         4BJZaTmqEpYFecs9zKv3H+KmACEcuOZoYTt7DqqU3JtaDUGV5hxoV4sqe2ISNWIklZZ1
         Y/PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771255543; x=1771860343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8y53YFMQ+PYRig6TGH6tdnzevZp9DGRe/1ufZbEm3k=;
        b=CsNuEOh52WRAGxSHidc+/x9Gnktz/c9FVE5FB1EcKq1X9mrZrVMnqgwwh21NcidTTu
         lMVJvD7djqUYMQcasW0KFtKnh3U152DI28pgBxdTM3ooGNF0khPKIzo0XUutevw6XX+J
         5EBgE0bASqwwrydhQcfX8kR9hcRhqXZIAIzz3OfDcSuV1ElT2PMuIOohhVP+h8QKzz6b
         HmZ3n4Rk941Y9SSVKdnENzPcwkqYa/g64gU35Kz4JAOJlzDIIu/HtDyyUTFHGzICPd8u
         cjwt/VbtSgStIRPj0BC7+/bJlAk/tuijL3J8AOH5jeNug1XPnxkQJSs1hRYea9EL38Xn
         GT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771255543; x=1771860343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a8y53YFMQ+PYRig6TGH6tdnzevZp9DGRe/1ufZbEm3k=;
        b=f3kHkcCuApAPRngZwVsNAj0PHJC0GEZAnuRYA7Mc7FlnozCDKWIV/ZtLJ/vLIm3/v8
         KEcw9XnXcl2aGGbxjKlKuR5r99lz00ZnLsQvYAlmpw1r/8ivy8yBzn30/v8YN5ZuGX7M
         fwQLiFcn6TIxZT5NiWHo76DZk5SeJNHyb2V9imtxM+HgaXjlnW78R3j0He158y5Cvx9p
         f3z4Fx+eK7aaUAL7QO3D41ziCg5Zv3xCsa9vXXhlrzBWf9ELQ+UyRX48vGN1zEWe+XSK
         42+Wr8BG8TLJcBA6Mvqac9Nle0mV0tPiRNMZ+uWBJ7R9YqFv2e6I+LTN8vfGmviV3E+s
         +L6g==
X-Forwarded-Encrypted: i=1; AJvYcCU95tszW5DTtXHWx0uWIl9f9ygWJdtLUEf8iON5JI7rbuYBjOcnKaWpKOWwuIzjs/MEzqqDOjMOIul1ufTRBdg0eQuNtWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTrH0Uj1UGYMfgUStRdaMpmlcoKWbaxZQasn7ufmrOP4lah543
	E4aiOaS670qLvUKxK5dKpGZ+ky2kr0mn4a+V030YlkxUJkbR8xKJKxpLqYYd4oDNk6wv6F87lAs
	sqJZCDaT2Baih1Zqzlq6GYvRA3L1C+ko=
X-Gm-Gg: AZuq6aJ6jMe7Zpw6W+joyAmn0gkLmx9PuAl/MV5HLntUNACVcPoyyE9/E+2GtfHbn2Q
	b6WFGyn4ZpT6Qs+iQD9D4NpgAEf6y8IWE0VPGywfj2yGi75sCIspsVagZbkz0H0v9bGKzCbR1Tl
	ZhOD3JtfnUNKolj435SPI9LNC8L0snWLhr+yrlEmBsp3n5Y1Nkdn6Xs1l33X3kouMe1qUWsXy8e
	6/0CgDTMqBeOMq1vUqYru0VNAt6ueF8QuKYybUIasrDlPz5O2Sb8ff2XXqChyqF/vlDwxRRnRDN
	DsKYmsxU
X-Received: by 2002:a17:907:2684:b0:b88:1e2:ed49 with SMTP id
 a640c23a62f3a-b8fc053d4a8mr461131666b.8.1771255542306; Mon, 16 Feb 2026
 07:25:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216150625.793013-1-omosnace@redhat.com> <20260216150625.793013-2-omosnace@redhat.com>
In-Reply-To: <20260216150625.793013-2-omosnace@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Feb 2026 16:25:31 +0100
X-Gm-Features: AaiRm509zvV_5nztV_clDc8zDOEZuzPTyg08_yWfQUzaOuSbDQzEo3YOHZWR_N4
Message-ID: <CAOQ4uxiggWbj6p4giuXgKkjdV1aOB5SO-4grEW_H7FCE6iw1=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] fanotify: avoid/silence premature LSM capability checks
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 5:06=E2=80=AFPM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> Make sure calling capable()/ns_capable() actually leads to access denied
> when false is returned, because these functions emit an audit record
> when a Linux Security Module denies the capability, which makes it
> difficult to avoid allowing/silencing unnecessary permissions in
> security policies (namely with SELinux).
>
> Where the return value just used to set a flag, use the non-auditing
> ns_capable_noaudit() instead.
>
> Fixes: 7cea2a3c505e ("fanotify: support limited functionality for unprivi=
leged users")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index d0b9b984002fe..9c9fca2976d2b 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1615,17 +1615,18 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flag=
s, unsigned int, event_f_flags)
>         pr_debug("%s: flags=3D%x event_f_flags=3D%x\n",
>                  __func__, flags, event_f_flags);
>
> -       if (!capable(CAP_SYS_ADMIN)) {
> -               /*
> -                * An unprivileged user can setup an fanotify group with
> -                * limited functionality - an unprivileged group is limit=
ed to
> -                * notification events with file handles or mount ids and=
 it
> -                * cannot use unlimited queue/marks.
> -                */
> -               if ((flags & FANOTIFY_ADMIN_INIT_FLAGS) ||
> -                   !(flags & (FANOTIFY_FID_BITS | FAN_REPORT_MNT)))
> -                       return -EPERM;
> +       /*
> +        * An unprivileged user can setup an fanotify group with
> +        * limited functionality - an unprivileged group is limited to
> +        * notification events with file handles or mount ids and it
> +        * cannot use unlimited queue/marks.

Please extend line breaks to 80 chars

> +        */
> +       if (((flags & FANOTIFY_ADMIN_INIT_FLAGS) ||
> +            !(flags & (FANOTIFY_FID_BITS | FAN_REPORT_MNT))) &&
> +           !capable(CAP_SYS_ADMIN))
> +               return -EPERM;
>
> +       if (!ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {

Not super pretty, but I don't have a better idea, so with line breaks fix
feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

>                 /*
>                  * Setting the internal flag FANOTIFY_UNPRIV on the group
>                  * prevents setting mount/filesystem marks on this group =
and
> @@ -1990,8 +1991,8 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>          * A user is allowed to setup sb/mount/mntns marks only if it is
>          * capable in the user ns where the group was created.
>          */
> -       if (!ns_capable(group->user_ns, CAP_SYS_ADMIN) &&
> -           mark_type !=3D FAN_MARK_INODE)
> +       if (mark_type !=3D FAN_MARK_INODE &&
> +           !ns_capable(group->user_ns, CAP_SYS_ADMIN))
>                 return -EPERM;
>
>         /*
> --
> 2.53.0
>
