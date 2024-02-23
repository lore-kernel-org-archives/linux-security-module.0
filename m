Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3930C146E7B
	for <linux-security-module@vger.kernel.org>; Fri, 23 Feb 2024 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722451; cv=none; b=lVw4pxFcoBrQNi3ELcyMHxbnyuUGV8BLL3OMV8pOevXUqAK/NFY+HIBNiB8Ec4eJcJ46r+1YQTNsZdFwRieLW5B5QiiYGv+xXHN8U3DPjDyT/omuwlQkeybUDrfOOv7eM/lYgIN+35nEmzkF70TDHpu9wOehSbuI7Z/QWNybsYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722451; c=relaxed/simple;
	bh=6VgQr8fJjg6fEs6AHFjmsFnIQHc5a5uEmdWg5mQPymA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUeXshgEz2gH/Y+hYwK961dCFLE8rnSlGre8QG9kFEz/dyq9paM1onvXf+mDQ+ehHxgn05HLwt2MwM5PnKJ8Xt86mi7WltmCWesOZvN0yuH8N5qcAS0zSMh043MzjPekOATz7IydI17s4fcygn/4EhDalsm7uN2vlSMcKo7ifdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CpbZ+1ON; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CpbZ+1ON"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6087396e405so6931777b3.0
        for <linux-security-module@vger.kernel.org>; Fri, 23 Feb 2024 13:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708722449; x=1709327249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTVIr1+DQqd7VndTuddH8HDUIEhAoCQ0AKItibRMycI=;
        b=CpbZ+1ONoL4hAF2MgBVMj9+mDIUgqyyn2Rm0f6MXSEW7qL6SCnfVpPtW/MwXPpa3NG
         kZWWX7CumzKC5qLo4sP3uyGIa7FtcWmhi7C0HxIaKTCwUAM5DeFmd5hgrOWCefMeeCHU
         gC60pChbSpNcR42yqtujInW2HBd8I2l9aTLH5jDZxYaU9hIpZhsb1se8Du8BoKhZfeuN
         djJuvHVC7vEc7XuVFqFbUKmMPtEWcoGWkkNg519RijfyNs8orSCX8XnAoaRBCBNHHzDq
         bfvuirSyKlz3isF1tLaVmflxPZa4PfKELAvanWuHsnD3HJoIRe4GKWCJ3tWFCjARswO8
         Tfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722449; x=1709327249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTVIr1+DQqd7VndTuddH8HDUIEhAoCQ0AKItibRMycI=;
        b=dBYkKBKdsPT4DwQ6xCRcgFmRecotff57IZBe3d+uTTc6ATPpsA0KsYxWhMbFhXyTen
         /NcJrX+DkcZV5bAW9ehF5LKxUV8QUZ5A6qj12hhEj7zU6oWzMVBIPXSGLfQdi7Bn6c0c
         R5S5tismSfzi74RmahMjg+ZEmuG8n1MtH/qKHktg31N6yjQ2XHXw7385U04mOZs4UTD8
         WUP5LAJGRbdlCJFyHFknzIh28X3r2gTai8mij6q68xHtX0tE1oKr2m2oAlze7PUz1pdD
         3y8Z3WzGYIqapUvCAoc5DbelmzcoJrXmYmDfnAVv+CUxua+dEUc62V71gODNlXoWPcBC
         YwQA==
X-Forwarded-Encrypted: i=1; AJvYcCWGAU3hSYf5hdKJ42ZcYb0AvtbpSJqRNVppMUW4aEzIFO1Ark/Cs/G+k/NzzB10w3AYs3TRy0Rhh29x4QzbDAsVwDwXduAIR/dw8M+Wh5hYVa8youUG
X-Gm-Message-State: AOJu0YxYJlDDUUwG6blcFHxCv3/DwO+yu5BOzd1Kl/9g8tLevcl6Auap
	esx9uPA9NpcDbDii8aAC+HtY7NoOk65c6R4ivSx7oPvQ5cjfyQnT019d17cOv1B/cGmYXVqgaqi
	X7/33lqRvMcIqQ54+pUbydulm9AiCNXCwFZi5
X-Google-Smtp-Source: AGHT+IFzOTG2gqhjwIuQqFrSF9kYO7XKdQQqylj7QZT68fEwlWe6kyHm8630oV+XgrXsN2qoMyNAn4/rC/VdW5ppCKY=
X-Received: by 2002:a25:b215:0:b0:dcc:97c:5754 with SMTP id
 i21-20020a25b215000000b00dcc097c5754mr892475ybj.5.1708722449224; Fri, 23 Feb
 2024 13:07:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223190546.3329966-2-mic@digikod.net>
In-Reply-To: <20240223190546.3329966-2-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 23 Feb 2024 16:07:18 -0500
Message-ID: <CAHC9VhQGLmeL4Buh3ZzS3LuZ9Grut9s7KEq2q04DYUMCftrVkg@mail.gmail.com>
Subject: Re: [PATCH 2/2] AppArmor: Fix lsm_get_self_attr()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 2:06=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> aa_getprocattr() may not initialize the value's pointer in some case.
> As for proc_pid_attr_read(), initialize this pointer to NULL in
> apparmor_getselfattr() to avoid an UAF in the kfree() call.
>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: stable@vger.kernel.org
> Fixes: 223981db9baf ("AppArmor: Add selfattr hooks")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  security/apparmor/lsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

If you like John, I can send this up to Linus with the related SELinux
fix, I would just need an ACK from you.

> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 98e1150bee9d..9a3dcaafb5b1 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -784,7 +784,7 @@ static int apparmor_getselfattr(unsigned int attr, st=
ruct lsm_ctx __user *lx,
>         int error =3D -ENOENT;
>         struct aa_task_ctx *ctx =3D task_ctx(current);
>         struct aa_label *label =3D NULL;
> -       char *value;
> +       char *value =3D NULL;
>
>         switch (attr) {
>         case LSM_ATTR_CURRENT:
> --
> 2.43.0

--=20
paul-moore.com
