Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81717B4EC
	for <linux-security-module@vger.kernel.org>; Mon, 25 Nov 2024 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534460; cv=none; b=eolAqvuUNylBGQDfB+MOWQ3pfzMHiqS7lKJrvqedR49yXpPztHPdgeVtcG1IZ2oc25L7zAqK0u0v8eGexnlQWmmCZt/TA4ocjdlfpd4j+UoN7A1C9opRJsM6nOyvy6NO8ti/UG00of7d8PejI29tIegdllqcA4ZyPuir+IStBrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534460; c=relaxed/simple;
	bh=oKiIL23t9JON49nCNZT6Ou8nEPC13GPtL4HwJhWTs4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNy0bbxBSEbAL9zf6e8fq8xFMcPEQNvH+Jf2V19+6CXApaCQocLu39fLeXz2hg3KOacro+E9noIcBzuMKWwgswbnqht48HVtp2oI271B9zXJo/H57voyMJYJTMBsPjJ7BXeYPXibC8TGxZ+93MLAvAnw2yUUzlN4aDHl2oLUbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ReKwAG6x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ReKwAG6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732534456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOFP6FdjF7HR5DJ0NsQmq4Ef0zujb0dhq0/nwgl+fPQ=;
	b=ReKwAG6xggBXaHM0846BJLqrG1U3HtaIF6bfC1jba60opx5dw2+TDs8ph7rrsgYIQBRygm
	G31BUmR0nuumOQGhPzE9dwfIsDvIMDCZVfbAXdYYkGu9P0wK9R5eqJH+etgxbyOAkDF2HF
	5Ok34sL08A9NdYzQTpyrgxyNgY3pLAE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-w_cOx3bqOZChphSvw_TKOg-1; Mon, 25 Nov 2024 06:34:15 -0500
X-MC-Unique: w_cOx3bqOZChphSvw_TKOg-1
X-Mimecast-MFC-AGG-ID: w_cOx3bqOZChphSvw_TKOg
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-211f6b49476so58802405ad.3
        for <linux-security-module@vger.kernel.org>; Mon, 25 Nov 2024 03:34:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732534454; x=1733139254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOFP6FdjF7HR5DJ0NsQmq4Ef0zujb0dhq0/nwgl+fPQ=;
        b=G8dV0f/sOuSqM9Ide7XbarhIzADiDK/o2/xkKTzbW0XwdRIRgA17dfeptHBSGYUZAA
         Bn5DnR0G/FZbYbOvBVtMHrQFy+BXwNQhQOUp1Kcdj5AjkTjia6GPPenZJUd5pM+3nYUP
         M46VlNrZt0/UbwqZwgI87VD0qhNFhTwHVdC/0a/uXXBVWDHT/ZjC9xxYT9Hv/T49Zlf8
         Ij5kmmMWgylzM9iVG2FkWRocBr8CWHzagOmlz4T0a1AGVpD6GwhL8Q1Q4wLxf77cVCCn
         sQmmjgvDdL01aXgRNO5UgABCXVAw+p4Vg55UyAJdtSOa6V3YeH5OA4XSx8AHWGXZsrKZ
         FlDA==
X-Gm-Message-State: AOJu0Yx7FWpQrwqWE1JycnLHATXiqAV7wntbv3cxsGB8LJ3T13y+Trc8
	tKyJ+0Ut/gVSPS1OIQtPs1gOnhtdLbpAp3ts/sGqWQjo51RgVAme0JKaGOjcrtVjlCDcFn5o22Z
	seFuSTZ1QzTQ/jzL1rPsNuOHTFsLadkIODXBjJpoE2fuaJPe4SwqSoTo2/j+6NyJiDPbnNr+vtX
	nwdn9Do4GuRUkdNwBj/iiHsWZA1jOSxtDDgtZ67ajXVDRRtxnC
X-Gm-Gg: ASbGncubHz/TO7K47F2hTNhQwBypSB1x0hqchd6dUfmLqBvM+bQZV/SJM2RPbpnu5Uq
	uirLmf5pZhqof0e6/FylikTyZR1zOKg==
X-Received: by 2002:a17:902:f64c:b0:212:6981:7587 with SMTP id d9443c01a7336-2129fd0fc42mr208252815ad.24.1732534454160;
        Mon, 25 Nov 2024 03:34:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHblig9i49prrqDlUeZETVKtu2gFAI4HQKWoBxXGngksx/l9PRt93GGuLopiLDUeU5NzeAE1cUQ0J/uiU3YMRU=
X-Received: by 2002:a17:902:f64c:b0:212:6981:7587 with SMTP id
 d9443c01a7336-2129fd0fc42mr208252465ad.24.1732534453881; Mon, 25 Nov 2024
 03:34:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125104011.36552-1-cgoettsche@seltendoof.de> <20241125104011.36552-7-cgoettsche@seltendoof.de>
In-Reply-To: <20241125104011.36552-7-cgoettsche@seltendoof.de>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 25 Nov 2024 12:34:02 +0100
Message-ID: <CAHc6FU5t0cB=+9ijwx26NUEck1YS7304ue_5FRwqXRzBq14jjA@mail.gmail.com>
Subject: Re: [PATCH 08/11] gfs2: reorder capability check last
To: cgzones@googlemail.com
Cc: linux-security-module@vger.kernel.org, Serge Hallyn <serge@hallyn.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, cocci@inria.fr
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oGG56Wf-enJASCJxLfuia-7rIuVEtj5fGFGhQugiXBE_1732534454
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 11:46=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit
>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  fs/gfs2/quota.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/quota.h b/fs/gfs2/quota.h
> index f462d9cb3087..988f38dc5b2c 100644
> --- a/fs/gfs2/quota.h
> +++ b/fs/gfs2/quota.h
> @@ -44,8 +44,8 @@ static inline int gfs2_quota_lock_check(struct gfs2_ino=
de *ip,
>         int ret;
>
>         ap->allowed =3D UINT_MAX; /* Assume we are permitted a whole lot =
*/
> -       if (capable(CAP_SYS_RESOURCE) ||
> -           sdp->sd_args.ar_quota =3D=3D GFS2_QUOTA_OFF)
> +       if (sdp->sd_args.ar_quota =3D=3D GFS2_QUOTA_OFF ||
> +           capable(CAP_SYS_RESOURCE))
>                 return 0;
>         ret =3D gfs2_quota_lock(ip, NO_UID_QUOTA_CHANGE, NO_GID_QUOTA_CHA=
NGE);
>         if (ret)
> --
> 2.45.2

Applied, thanks.

Andreas

