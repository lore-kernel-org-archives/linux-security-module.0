Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8F722127A
	for <linux-security-module@vger.kernel.org>; Thu,  9 Oct 2025 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760035120; cv=none; b=TnJb/meOF8iB0rDyCt9Ew+IgDTAVqtQacLWyyHDimaWwrT6pTWBOcAjAJUfTqv1BgLY1NbhRBnRfuVABJ+YsUabl0Ib7oKDIVQgd914CqMqPFOUrnuFvgi5wIpvkBwtOozu3IiKOyELt/k8bBLMOAdc5BgcLUK4Va1hMkIKZlhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760035120; c=relaxed/simple;
	bh=uc5fJQsGJgb8TKtrt4MNAJYGQ1zQS8XPkUbMORFhV5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fq+1TM3V1UeQ2gHmLLWAUhdoW8r0d3HI3cn5mk17QVm2jOwkosy60zl0nnRMjnk+3HHQLOgPgNHFiX6oHN/g+WuI/eIddJ7NVR1R5VvGYvhcXR5wdIaFlLEBvdgToH72CsvXQF2Qo+dcxR7gyfwNU8ydBgAKK1ZkxZaSqRoGtBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnODS5kw; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnODS5kw"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3352018e051so1597188a91.0
        for <linux-security-module@vger.kernel.org>; Thu, 09 Oct 2025 11:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760035118; x=1760639918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRnmBs3bu/Z5++L4FvOqDgypy6pd49YNgJGmGrhncu4=;
        b=YnODS5kwwLmd4p0NnVe1deAmz4p/3KcLFdgR9V3tS8+yU930EouiESo9BBNxy/ZgJH
         2ElpI/nkNwu1qjbED32ln4Uv7lt4iHIgHblLFeAHPOiibiJLRuR95C4gFoEXMrlycViU
         quMOma6QtbRoCjTU1Q2PEEZJQecIg+c5S772HsxczBV8guMLWJOLSmtwa6JIBR+nFVdy
         D7ZAvmqrQTOs2rWkJ6yQRtlE9a7nKKo4oyZ9nWdt7vTNAXdBxmnfblUCkTD1T0Tn9qFH
         cJziIgYurI31166/gGgserDkuhEqWG//JsN8PZCy8wuEkft37gOWffPHhSZjEYWK0D3x
         uh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760035118; x=1760639918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRnmBs3bu/Z5++L4FvOqDgypy6pd49YNgJGmGrhncu4=;
        b=NTvx7pwpNHbRTk4RjpZj4kB0qijfQCohXallJihVMRECTw5h0nWjfnu1+eT/Bpy02n
         6c2b4FqNLqKKfNCLIijNghHU7EhCEfLfKIbs0D87nCZAs6P37ZZ6n+MeS+Dz4hzui4u6
         3pmLkBL/9NeCechShhqxEArVDJqnQukrlcU2Mb2tkmIVzutaB1iLttdPWHBoDqLZtaAw
         R1GajFnCAW2IGJ44LTgvBke6bQtRPVh8lWD6TdQrK/Je9utrGOels6GccziB1hLgx/+7
         KkRpQzPJ6987oEhnbEpNlkuY2Lyd7NBq7rxHClbyhnlBiE3A5Mq19Jp1sT9Cs/lCIh2n
         uiOw==
X-Forwarded-Encrypted: i=1; AJvYcCX08wdrr2ZIKHAU8cnonFslhX/rOl42RpOA+vvOei/y7uvzizMR3X5ZgpQmhF1nxf4OcLE95KF7ErHC3xC8OppvqYmbG1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdZaCQGikQLepRrhv8HkAx4zC4Gm1S9bH28EOiJO2oGvU+2nH/
	y3fTMQFmxLyfTWSOo0JUKS/8E9JEX8qL9UJVH+gPxrdAGB+cqixNGCm1sC2sppQ07my5liBz/+x
	RgqcbnF+NmpEK0HPnCsvbivm6dxst3Pg=
X-Gm-Gg: ASbGncugiiqlXx6EF1SX3iq2o4wh2pDbLOgMUiAg1jUvq0WHk10/mXeN5sS4ujcB3Nw
	9Fzx9omU2TmOYaMU7hhUeg5KOHnDuD2E0ZrhwQFHZRVYo9N/HPioAKXKDpnOV5v/RyK1FeaXUMa
	JDbMZMdpg2I75QcSkP6KG4Nzpt/Im3d5bTIPbcfzXqZcNQCX3GubjL88LPS7P+c5EuuGi1/bdxl
	D0XLH+B5rz52QRE2dvnUulhcL3qr8o=
X-Google-Smtp-Source: AGHT+IF6+vHoSPAPu/kmoRZVAL5HBvulLN7D3Dg3aJqMJxirCFziVTM6riwQQRESpPcUE/EAAP5IslXI+D/JCY6pRQ0=
X-Received: by 2002:a17:90b:1b42:b0:330:a228:d32 with SMTP id
 98e67ed59e1d1-33b5111891emr11394539a91.10.1760035117884; Thu, 09 Oct 2025
 11:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925171208.5997-1-casey@schaufler-ca.com> <20250925171208.5997-3-casey@schaufler-ca.com>
In-Reply-To: <20250925171208.5997-3-casey@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 9 Oct 2025 14:38:26 -0400
X-Gm-Features: AS18NWAYJ3O7XILrGAYfzTb7IkJ81kAiTqesEPkSBBRxZgeNK-1-SB6vpngGrBI
Message-ID: <CAEjxPJ4D7A4KDF9BfmRa9VvzcAHBkkrdKCvmGazuZUto5=qDuw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] LSM: Infrastructure management of the mnt_opts
 security blob
To: Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: paul@paul-moore.com, eparis@redhat.com, 
	linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 1:12=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Move management of the mnt_opts->security blob out of the individual
> security modules and into the security infrastructure.  The modules
> tell the infrastructure how much space is required, and the space is
> allocated as required in the interfaces that use the blob.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 4bba9d119713..1ccf880e4894 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -656,19 +651,13 @@ static int selinux_set_mnt_opts(struct super_block =
*sb,
>         mutex_lock(&sbsec->lock);
>
>         if (!selinux_initialized()) {
> -               if (!opts) {
> -                       /* Defer initialization until selinux_complete_in=
it,
> -                          after the initial policy is loaded and the sec=
urity
> -                          server is ready to handle calls. */
> -                       if (kern_flags & SECURITY_LSM_NATIVE_LABELS) {
> -                               sbsec->flags |=3D SE_SBNATIVE;
> -                               *set_kern_flags |=3D SECURITY_LSM_NATIVE_=
LABELS;
> -                       }
> -                       goto out;
> +               /* Defer initialization until selinux_complete_init,
> +                  after the initial policy is loaded and the security
> +                  server is ready to handle calls. */
> +               if (kern_flags & SECURITY_LSM_NATIVE_LABELS) {
> +                       sbsec->flags |=3D SE_SBNATIVE;
> +                       *set_kern_flags |=3D SECURITY_LSM_NATIVE_LABELS;

This seemingly would produce a change in behavior for SELinux.
Previously we would only do this if there were no SELinux mount
options specified.

>                 }
> -               rc =3D -EINVAL;
> -               pr_warn("SELinux: Unable to set superblock options "
> -                       "before the security server is initialized\n");

Ditto.

>                 goto out;
>         }
>
>
