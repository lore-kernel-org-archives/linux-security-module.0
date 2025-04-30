Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D18224B08;
	Wed, 30 Apr 2025 23:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746055797; cv=none; b=PlLVZ2jaPZ6YuEX2FZe7Bz4zjy5Sl4EhUygzDq6rNw7RMTZlDl7lvloX1ZE/M0hhUyY/0+Tsk+FzF6ucr1IA7oym8Kbe5cNDy092EDOrQtn9kDYEgdTE06tVemasYtl8Dy2/uolKoiy9IfrJIEittOtxrxvpxUAKXUIvl9O7qoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746055797; c=relaxed/simple;
	bh=YfszCblJFyfY03DL8XXrgkd5xX++4FamuTO+wfAZTdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJ64cQSF/XfTU3qRxjNm310VnGkx4egMy6ZWjHD9YD7N7JR8hBZj9uh37spNfdn6/XVpibcjtuimMsVUo92SOFsSkoJKUvhd5svo+0vX/64eJRgoeUZ/sodKBjEX9iENinBYDAbxiIkX+hh3pMpd+ZDE3P2RD47vgMHk7xF0ufU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBSRN+Cd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBSRN+Cd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C991C4CEE7;
	Wed, 30 Apr 2025 23:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746055796;
	bh=YfszCblJFyfY03DL8XXrgkd5xX++4FamuTO+wfAZTdU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CBSRN+CdA8OVjt7ep85XM1fA0jHkm9myj0UJO2EsDz2aMo5y7137sioKwV2jOLXTx
	 /IMuiO5y32c0jDW4fAJDai2Gp//p6y/DtvyrLKpViDyhNDVbSxo9cpA3nZP/cjk09N
	 5NIDQYq/4GsbZ7kiBPKj7ugOiCzMr+oQjEuwhSSlZIkNs4Yks9XCrlD7PpWUj8UDVp
	 o1/08fj4aDkyRj9uExjwOLnT2YRKM9VRbFXLmf7chlLO3ek/bUmK7DEoKPRM8OJJJf
	 WkREvLWaYIpKahcKbYN6DGm8ZXG3s3myvIcVk8YL+/+/rxh+9VEHUk6p4mz/VegeRa
	 bZswfG7sOR+Jg==
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso382804276.2;
        Wed, 30 Apr 2025 16:29:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2gY4SgaCAJDt8g2+S42eNk27BrN8KDyC07E0tNfWvgBanpXjcQOSQ8TwZrRlgHO2MKam9wJSNk771WwM=@vger.kernel.org, AJvYcCVMJZ2GuoubnDJntPLC+w57WuliHftgyeeAnZVUhoipq6V5CPQvb2WqVfJAm3ZE7ZrcYh4pd8CS31ETnY0r1Ot+APHKFgI6@vger.kernel.org
X-Gm-Message-State: AOJu0YyYpTOCZmoOTyIOz9YmisBPfK1kjk1J3aEaYv1iLzSm/ZBs8l0q
	t8/WqCeZpbi+vFUNiPV+8duQ+OxiD6fIaIYSXtV2tqn0sK6z9dBzoqgUsBuGGPRO4Itf0zTsFon
	Ih7Ta9PJ42VtiZ85NW9Vax+dFclc=
X-Google-Smtp-Source: AGHT+IFEJ2qTrUej3AfwsK8YWr+xOQqZR4yKyK5COAxs42YmE7rXz5xDr8LVkJjJwzXz9HBJ1hhvGKLB9aczj7bsZkk=
X-Received: by 2002:a05:6902:2b11:b0:e73:1ff1:ca38 with SMTP id
 3f1490d57ef6-e75318276ecmr316609276.20.1746055795779; Wed, 30 Apr 2025
 16:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1745961770-7188-1-git-send-email-jasjivsingh@linux.microsoft.com> <1745961770-7188-2-git-send-email-jasjivsingh@linux.microsoft.com>
In-Reply-To: <1745961770-7188-2-git-send-email-jasjivsingh@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Wed, 30 Apr 2025 16:29:44 -0700
X-Gmail-Original-Message-ID: <CAKtyLkG03zaOgC57-y4mNBXc+Nt0eZtKvyuhbs53SEUGwYUb5g@mail.gmail.com>
X-Gm-Features: ATxdqUGvxqon-yThcz6VNe8SeUVTzobNsltqinBw3cTCikAeKb3yBcLsIcP487M
Message-ID: <CAKtyLkG03zaOgC57-y4mNBXc+Nt0eZtKvyuhbs53SEUGwYUb5g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] ipe: add script enforcement with BPRM check
To: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
Cc: wufan@kernel.org, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	mic@digikod.net, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 2:23=E2=80=AFPM Jasjiv Singh
<jasjivsingh@linux.microsoft.com> wrote:
>
> From: jasjivsingh_microsoft <jasjivsingh@linux.microsoft.com>
>
> Like direct file execution (e.g. ./script.sh), indirect file execution
> (e.g. sh script.sh) needs to be enforce by IPE based on the rules.
> Added a new security_bprm_creds_for_exec() hook to verify the indirect
> file's integrity.
>
> Signed-off-by: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
> ---
>  security/ipe/hooks.c | 23 +++++++++++++++++++++++
>  security/ipe/hooks.h |  2 ++
>  security/ipe/ipe.c   |  1 +
>  3 files changed, 26 insertions(+)
>
> diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
> index d0323b81cd8f..12713a0495cf 100644
> --- a/security/ipe/hooks.c
> +++ b/security/ipe/hooks.c
> @@ -35,6 +35,29 @@ int ipe_bprm_check_security(struct linux_binprm *bprm)
>         return ipe_evaluate_event(&ctx);
>  }
>
> +/**
> + * ipe_bprm_creds_for_exec() - ipe security hook function for bprm creds=
 check.
> + * @bprm: Supplies a pointer to a linux_binprm structure to source the f=
ile
> + *       being evaluated.
> + *
> + * This LSM hook is called when a script is checked for execution throug=
h the
> + * execveat syscall with the AT_EXECVE_CHECK flag.

I remember the script is only one case, user space can add this flag
for other cases.

> + *
> + * Return:
> + * * %0                - Success
> + * * %-EACCES  - Did not pass IPE policy
> + */
> +int ipe_bprm_creds_for_exec(struct linux_binprm *bprm)
> +{
> +       struct ipe_eval_ctx ctx =3D IPE_EVAL_CTX_INIT;
> +
> +       if (!bprm->is_check)
> +               return 0;
> +
> +       ipe_build_eval_ctx(&ctx, bprm->file, IPE_OP_EXEC, IPE_HOOK_BPRM_C=
HECK);

A new enum needs to be added to audit this new hook in the audit
event. Please create something like IPE_HOOK_BPRM_CREDS_FOR_EXEC.

-Fan

> +       return ipe_evaluate_event(&ctx);
> +}
> +
>  /**
>   * ipe_mmap_file() - ipe security hook function for mmap check.
>   * @f: File being mmap'd. Can be NULL in the case of anonymous memory.
> diff --git a/security/ipe/hooks.h b/security/ipe/hooks.h
> index 38d4a387d039..1c16a25d806e 100644
> --- a/security/ipe/hooks.h
> +++ b/security/ipe/hooks.h
> @@ -24,6 +24,8 @@ enum ipe_hook_type {
>
>  int ipe_bprm_check_security(struct linux_binprm *bprm);
>
> +int ipe_bprm_creds_for_exec(struct linux_binprm *bprm);
> +
>  int ipe_mmap_file(struct file *f, unsigned long reqprot, unsigned long p=
rot,
>                   unsigned long flags);
>
> diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
> index 4317134cb0da..845e3fd7a345 100644
> --- a/security/ipe/ipe.c
> +++ b/security/ipe/ipe.c
> @@ -47,6 +47,7 @@ struct ipe_inode *ipe_inode(const struct inode *inode)
>
>  static struct security_hook_list ipe_hooks[] __ro_after_init =3D {
>         LSM_HOOK_INIT(bprm_check_security, ipe_bprm_check_security),
> +       LSM_HOOK_INIT(bprm_creds_for_exec, ipe_bprm_creds_for_exec),
>         LSM_HOOK_INIT(mmap_file, ipe_mmap_file),
>         LSM_HOOK_INIT(file_mprotect, ipe_file_mprotect),
>         LSM_HOOK_INIT(kernel_read_file, ipe_kernel_read_file),
> --
> 2.34.1
>
