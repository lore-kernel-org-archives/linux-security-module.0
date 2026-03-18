Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D19D36CDE3
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867015; cv=pass; b=sc3FjPMAz3/f3fULBVcHNyE8xPmIr9kygNaBdcAUn4lhyZ2FZ6CRSiAjAo+nx4W76kFS988dgGnb0KSZ8CMNrsb6KiZKf/L+Ez6XzozYqYF9t310sx663wyU/UFPbERijY1+gYFkazMuX+KPa0SdL/e47x01K6fEc33EKQ0xeIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867015; c=relaxed/simple;
	bh=yIVbULRr0EyFZ4OSvNq9Etrmqe5QvMpNlx/vqNprP+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KF5mBN5ZNlV6DwkI6QOAylerG3XV7YH0cyk8ST07qgMYgnlygnGzRe/a3PS4bZwvNRDec0ClNlmwUFnmUAj4jkiYyLMSAC+uuYF5RKrDEBER+hYrGG0g1w+V4xTg9VhaiQkrcRJH1C0qGYuS15/tBop457VeLJWhrIsWrISIjTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lKAvDzWw; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lKAvDzWw"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5fff18d44fbso161548137.1
        for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 13:50:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773867012; cv=none;
        d=google.com; s=arc-20240605;
        b=CS8cpT81pc7l8AwViCzuCeN9u9VPzg6xsBbJR13jdKhcK2yQHCkmI/vBE1Zmdi1AEx
         O06pvYjIsMtELHrodibHW106+FqIRMMs7ptctI8pRXXxS/0kcGaJr3xt4njTF4IGxp8J
         3LtcwhrCl+Hv2lQ02GDoXZ2HEUwWych2LbGaovK5gmOfev2RFAYdxOh9q7GZacQkrp4b
         3stgMSmrJOs1cvx7ylaB5TJR/QtBB+RmtBRkbgn2hTPpajyVd6MaC07NCcBNAlSg0Ai9
         YtOvZpV/bgNzWjRdHToU+c0QeksA4mGImt2+bfZjJU6y52UxnjrE0o8JykEVsvIpuRSy
         GurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uxxlGXnY5xObrRihI7QeDBw8vg0/smHEQabsz9SwyBw=;
        fh=Sdpa4Lu8vA13m54lSxS5LTeKo1gic0s/VBtCa9Y1FnU=;
        b=faNvLZONAOyfunXjAhCjg2VWxPgcpACX+fw5IKQbXHUqaXHPpg1J8Qye3yZUET8dT3
         8nd+0nPn8T/z0BjayLfEUylRGqV0CdT2+8rb3FsLlA5YQCwKhtm39tl1ehQTuq178ZGU
         DoXNnVFaACWGy8xFo1JTQ4tAq6xH5GEZ0zE1fUykuid8zPqrJDE/V6zVURrFQp90/iVM
         TpETvawGJ0T/DjYURXy1vhrnh4qHhJTgGDyraUFEvB9DwjW1Ue4XCVcIHD0OUhf46Qyw
         MHdKqT5qI/+Tglpdmn4oo7yE8B9fU8EA3P21n/ofEpM/Xhu8rqT2OJRem6Fp+F/1Zucd
         Rn4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773867012; x=1774471812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxxlGXnY5xObrRihI7QeDBw8vg0/smHEQabsz9SwyBw=;
        b=lKAvDzWw5AEjssbagOtpv2xp0ANkO+f/rUFJ/3kSeUiBuzmzXdyvl3Gm0eUYuKAq1q
         J7iJcfXQu7nmKqBo1o7GVfc/pQKA4BWu8PunWTluZqg/zWeI3oZ+mK8AvTSyq1kQkyLi
         Tk4wcjXQjkKkLy7vTugH42Tmg1aJkMiUwrd/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773867012; x=1774471812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uxxlGXnY5xObrRihI7QeDBw8vg0/smHEQabsz9SwyBw=;
        b=XEKijmaemTCDLYzH4kICI3xeMsQqUV/V+QXFzjlaT4OQL4Lusg4IJhpcevIP3rlilR
         eQejVWnrAy7jLXiu8RuiFmUbY2fV4h+401lK960byUJLnhuusshs9NeJkQiegttS6Pxo
         dP6tFcgvX2RKKfZTvROsCj18/bRlsRNJcma5oOnod3wLtfXuZI2hfWeUJkCBXlwD/HeK
         r1Tc1ZDrH/4jOKZ8jMBtUtOZ03cHOkfM+W/nEZv8u2t3NcgMCrH0OfxyPsUUQNzHv/Ob
         meJboaL6ATWfQF7gP9Nltm1/xA0CwH12/6TPEMWFQmMSL8rTiiG1O6ttSF6XZfxKSXpT
         wZYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXRV6WcaHOx2DFYAh9A6qPYZ1Vka1yy/dmwrWhHxW+2f9vl574TuAVPs08ry5Md1RpnNEN/dlxfcMjhoUqUIA/TVWzSG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5G5qsMvrsVhVhUSzxUmhpCgla1+ND2L1bPUQ596GkcU08QMip
	8qzDXLekVH36MgsxhKeH7Rqpsnst5wDYJc/OV4G46899DjnlX+jecI/amGMnunLEzj6RIwlh7xZ
	3Ht1uNjnOfPyBLqCJ8WH9UuC7dlTDP1Dh6hs2Gn/6nMHoimOjNtDPQg==
X-Gm-Gg: ATEYQzybirmzBJF49RDK78BCO+X4Gfz7hN9r/A7hCEf+qIzg0v7je0xTF1shsbfg7a2
	cCcpEPBBKs0O/qfuTSM2amrEzoTuI4rYSEzx85+zDSTjG0mhYeUcWPRBhDXafI1azBqIN1AWc+j
	nPvdkvza05htf10+AdiWu8egd3qA/cn5JNQu1ydpFcTc1K/Ox4tdkcg3ooY0rL8FhcGAbcerVrV
	AMSX6TterLZdOYIgt2ck5XKpwx5VbHqlsmx+LTlz1EKqHa3hQxYJrnz6jLnEOmf1c7DX9qRjEn8
	88vNJCNq9hzHxKYWNWM=
X-Received: by 2002:a05:6102:c94:b0:601:f74d:a671 with SMTP id
 ada2fe7eead31-6027d3b4d7cmr2849825137.30.1773867012199; Wed, 18 Mar 2026
 13:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303024025.37916-1-gaoyanwei.tx@gmail.com>
In-Reply-To: <20260303024025.37916-1-gaoyanwei.tx@gmail.com>
From: Micah Morton <mortonm@chromium.org>
Date: Wed, 18 Mar 2026 13:49:59 -0700
X-Gm-Features: AaiRm50e8eh3esWaXmAkwGv3Lq9Xy8OwAS3GAoTIjO_rWQ43LCMSWba0-M7H3_g
Message-ID: <CAJ-EccNLTuj74vKsNQFnOSXgjdyRpUrFVARsuqn6VNatQu33WA@mail.gmail.com>
Subject: Re: [PATCH v1] security/safesetid: fix comment and error handling
To: "yanwei.gao" <gaoyanwei.tx@gmail.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 6:40=E2=80=AFPM yanwei.gao <gaoyanwei.tx@gmail.com> =
wrote:
>
> - Fix comment in lsm.c: use CAP_SETGID instead of CAP_SETUID in the
>   GID capability check comment to match the actual logic.
> - In handle_policy_update(), set err =3D -EINVAL and goto out_free_buf
>   when policy type is neither UID nor GID, so the error is returned
>   to the caller instead of only logging.
> - In safesetid_init_securityfs(), return ret directly when
>   policy_dir creation fails instead of goto error (no cleanup needed
>   at that point).
>
> Signed-off-by: yanwei.gao <gaoyanwei.tx@gmail.com>
> ---
>  security/safesetid/lsm.c        | 2 +-
>  security/safesetid/securityfs.c | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index d5fb949050dd..a7b68e65996c 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -128,7 +128,7 @@ static int safesetid_security_capable(const struct cr=
ed *cred,
>                 if (setid_policy_lookup((kid_t){.gid =3D cred->gid}, INVA=
LID_ID, GID) =3D=3D SIDPOL_DEFAULT)
>                         return 0;
>                 /*
> -                * Reject use of CAP_SETUID for functionality other than =
calling
> +                * Reject use of CAP_SETGID for functionality other than =
calling
Looks good.
>                  * set*gid() (e.g. setting up userns gid mappings).
>                  */
>                 pr_warn("Operation requires CAP_SETGID, which is not avai=
lable to GID %u for operations besides approved set*gid transitions\n",
> diff --git a/security/safesetid/securityfs.c b/security/safesetid/securit=
yfs.c
> index a71e548065a9..50682abd342b 100644
> --- a/security/safesetid/securityfs.c
> +++ b/security/safesetid/securityfs.c
> @@ -224,6 +224,8 @@ static ssize_t handle_policy_update(struct file *file=
,
>         } else {
>                 /* Error, policy type is neither UID or GID */
>                 pr_warn("error: bad policy type");
> +               err =3D -EINVAL;
> +               goto out_free_buf;

This makes sense to me and matches how things are done in the
functions above in verify_ruleset() and parse_policy_line().

Is this code actually reachable? I guess if verify_ruleset returns
-EINVAL due to a bad policy type value the code still hits this spot?

>         }
>         err =3D len;
>
> @@ -321,7 +323,7 @@ int __init safesetid_init_securityfs(void)
>         policy_dir =3D securityfs_create_dir("safesetid", NULL);
>         if (IS_ERR(policy_dir)) {
>                 ret =3D PTR_ERR(policy_dir);
> -               goto error;
> +               return ret;

We still need the `securityfs_remove(policy_dir)` call to clean up the
dir created with `policy_dir =3D securityfs_create_dir("safesetid",
NULL)` don't we?

>         }
>
>         uid_policy_file =3D securityfs_create_file("uid_allowlist_policy"=
, 0600,
> --
> 2.43.5
>
