Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D0C81ACA
	for <linux-security-module@vger.kernel.org>; Tue, 21 Apr 2026 00:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776731267; cv=none; b=Kci2nbsCjsiVUO7Q1QorPsI/1y39N7+4L2u3DORcs1yA5wzHRXwnKQeHEkwHGAtwgMtgpr2yqez55NZ7fQcT1/ay8FQvDSru21H92mF52WMJj6gPxyKd0UylnKAfZuQb2CRnq7lh5dNzqUS6vtqLT49qbVTJdPw3WEgGuE1dtn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776731267; c=relaxed/simple;
	bh=XRYVcSoqqfH9DQ61xNZQgGEV0cfKqdM4C9/1yqbmydg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ejqeI3g38PDdrx/dClX4kmvUBwSOraISi4xTz/6dp5nUlxSpsRVv3o4lX8zmPyuyFpf8KndmWcYnM/i7Emlv33bbQYFFM5tdb/cPg8+gsx2d4h1zpxb7+xjwPzGDtaiaJCIGAFm5wjevfzF1n/fGbGmXwUgOjpvwArdHWa7qh0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sD1f3tcq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sD1f3tcq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D403C19425
	for <linux-security-module@vger.kernel.org>; Tue, 21 Apr 2026 00:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776731266;
	bh=XRYVcSoqqfH9DQ61xNZQgGEV0cfKqdM4C9/1yqbmydg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sD1f3tcqiZA4jGxJv5GIVTC7qXdVR9I1oiSA+jlV1WLD3S330lZMex5vSd6hGUpa4
	 KR6wiWQnhsft2mh+KYD+CfUfk5IF5MOcmnBgPh5J0udUIDKyD8ybmyoL6WpuLf1eU+
	 Fh9pyKWPC/nDIDAhBBBYXgMGvt6y/61lMvPmEP8c5HadrhaRfSEd+yva3hyTudmZzP
	 hB5qDlfL34z2jcbNdpkgdWr0+qnfzA6ZxSod2iRek2ywWBswoQ0fHZk7eS+LhEUn9a
	 1+Y9r6c5X4PqH2f8pPwVjd7pPh/1BmyoixYSo22AoG8okUyMuGl4HbPqfldiN3sXMZ
	 akg10FHhJ7ymA==
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c637089ccso8747582c88.1
        for <linux-security-module@vger.kernel.org>; Mon, 20 Apr 2026 17:27:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ87iVV22p/vLxZIr6IXMWIeT7AXNsi5NysHXSZflHNauD0UhXm2HK36pytrI3jHv58qsSVxj9D7SuSHi1GlH/EecoBaiUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiN2za30XPdITyA439RG3oTv9fQQp1bKL6oNZlXiO+4l8AFqu/
	YYqoTvTjY+Lo2MOrRW2K9kGjSEGcopErqVFps/vQFRdspMOsIZXLHFkainRIliP+dTwH1Y3AxwB
	DwQpd6NMQrX2iv//NldKnOW4WK+Bsfio=
X-Received: by 2002:a05:7022:129:b0:12a:68cc:3efb with SMTP id
 a92af1059eb24-12c73f9303fmr9341550c88.16.1776731266134; Mon, 20 Apr 2026
 17:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420212653.438685-1-bboscaccy@linux.microsoft.com> <20260420212653.438685-11-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260420212653.438685-11-bboscaccy@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Mon, 20 Apr 2026 17:27:34 -0700
X-Gmail-Original-Message-ID: <CAKtyLkEEjzcjptcN8DU70HfDJ7bw18S2mtgFPUyn9P46QUhsmQ@mail.gmail.com>
X-Gm-Features: AQROBzA82f5m-fKWLXZaGuSgKj9BtyvKQk95_F9gjtfs5CIlyux5ZxRV-aWEB8E
Message-ID: <CAKtyLkEEjzcjptcN8DU70HfDJ7bw18S2mtgFPUyn9P46QUhsmQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/10] ipe: Add BPF program load policy enforcement via
 Hornet integration
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andrew Morton <akpm@linux-foundation.org>, 
	James.Bottomley@hansenpartnership.com, dhowells@redhat.com, 
	Fan Wu <wufan@kernel.org>, Ryan Foster <foster.ryan.r@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 2:27=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> Add support for the bpf_prog_load_post_integrity LSM hook, enabling IPE
> to make policy decisions about BPF program loading based on integrity
> verdicts provided by the Hornet LSM.
>
> New policy operation:
>   op=3DBPF_PROG_LOAD - Matches BPF program load events
>
> New policy properties:
>   bpf_signature=3DNONE      - No Verdict
>   bpf_signature=3DOK        - Program signature and map hashes verified
>   bpf_signature=3DUNSIGNED  - No signature provided
>   bpf_signature=3DPARTIALSIG - Signature OK but no map hash data
>   bpf_signature=3DUNKNOWNKEY - Cert not trusted
>   bpf_signature=3DUNEXPECTED - An unexpected hash value was encountered
>   bpf_signature=3DFAULT      - System error during verification
>   bpf_signature=3DBADSIG    - Signature or map hash verification failed
>   bpf_keyring=3DBUILTIN     - Program was signed using a builtin keyring
>   bpf_keyring=3DSECONDARY   - Program was signed using the secondary keyr=
ing
>   bpf_keyring=3DPLATFORM    - Program was signed using the platform keyri=
ng
>   bpf_kernel=3DTRUE         - Program originated from kernelspace
>   bpf_kernel=3DFALSE        - Program originated from userspace
>
> These properties map directly to the lsm_integrity_verdict enum values
> provided by the Hornet LSM through security_bpf_prog_load_post_integrity.
>
> The feature is gated on CONFIG_IPE_PROP_BPF_SIGNATURE which depends on
> CONFIG_SECURITY_HORNET.
>
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---

...

> diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
> index 0ae54a880405a..03541e5bb7f60 100644
> --- a/security/ipe/hooks.c
> +++ b/security/ipe/hooks.c
> @@ -340,3 +340,40 @@ int ipe_inode_setintegrity(const struct inode *inode=
,
>         return -EINVAL;
>  }
>  #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
> +
> +#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
> +/**
> + * ipe_bpf_prog_load_post_integrity() - ipe security hook for BPF progra=
m load.
> + * @prog: Supplies the BPF program being loaded.
> + * @attr: Supplies the bpf syscall attributes.
> + * @token: Supplies the BPF token, if any.
> + * @kernel: Whether the call originated from the kernel.
> + * @lsmid: Supplies the LSM ID of the integrity provider.
> + * @verdict: Supplies the integrity verdict from the provider (e.g. Horn=
et).
> + *
> + * This LSM hook is called after an integrity verification LSM (such as =
Hornet)
> + * has evaluated a BPF program's cryptographic signature. IPE uses the v=
erdict
> + * to make a policy-based allow/deny decision.
> + *
> + * Return:
> + * * %0                - Success
> + * * %-EACCES  - Did not pass IPE policy
> + */
> +int ipe_bpf_prog_load_post_integrity(struct bpf_prog *prog,
> +                                    union bpf_attr *attr,
> +                                    struct bpf_token *token,
> +                                    bool kernel,
> +                                    const struct lsm_id *lsmid,
> +                                    enum lsm_integrity_verdict verdict)
> +{
> +       struct ipe_eval_ctx ctx =3D IPE_EVAL_CTX_INIT;
> +
> +       ctx.op =3D IPE_OP_BPF_PROG_LOAD;
> +       ctx.hook =3D IPE_HOOK_BPF_PROG_LOAD;
> +       ctx.bpf_verdict =3D verdict;
> +       ctx.bpf_keyring_id =3D attr->keyring_id;
> +       ctx.bpf_kernel =3D kernel;
> +
> +       return ipe_evaluate_event(&ctx);
> +}
> +#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
> diff --git a/security/ipe/hooks.h b/security/ipe/hooks.h
> index 07db373327402..95b74f7899750 100644
> --- a/security/ipe/hooks.h
> +++ b/security/ipe/hooks.h
> @@ -10,6 +10,7 @@
>  #include <linux/security.h>
>  #include <linux/blk_types.h>
>  #include <linux/fsverity.h>
> +#include <linux/bpf.h>
>
>  enum ipe_hook_type {
>         IPE_HOOK_BPRM_CHECK =3D 0,
> @@ -18,6 +19,7 @@ enum ipe_hook_type {
>         IPE_HOOK_MPROTECT,
>         IPE_HOOK_KERNEL_READ,
>         IPE_HOOK_KERNEL_LOAD,
> +       IPE_HOOK_BPF_PROG_LOAD,
>         __IPE_HOOK_MAX
>  };
>
> @@ -52,4 +54,13 @@ int ipe_inode_setintegrity(const struct inode *inode, =
enum lsm_integrity_type ty
>                            const void *value, size_t size);
>  #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
>
> +#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
> +int ipe_bpf_prog_load_post_integrity(struct bpf_prog *prog,
> +                                    union bpf_attr *attr,
> +                                    struct bpf_token *token,
> +                                    bool kernel,
> +                                    const struct lsm_id *lsmid,
> +                                    enum lsm_integrity_verdict verdict);
> +#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
> +
>  #endif /* _IPE_HOOKS_H */
> diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
> index 495bb765de1b8..6502d4ddc641c 100644
> --- a/security/ipe/ipe.c
> +++ b/security/ipe/ipe.c
> @@ -60,6 +60,9 @@ static struct security_hook_list ipe_hooks[] __ro_after=
_init =3D {
>  #ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
>         LSM_HOOK_INIT(inode_setintegrity, ipe_inode_setintegrity),
>  #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
> +#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
> +       LSM_HOOK_INIT(bpf_prog_load_post_integrity, ipe_bpf_prog_load_pos=
t_integrity),
> +#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
>  };
>

IPE only registers bpf_prog_load_post_integrity(), which fires only
when Hornet calls security_bpf_prog_load_post_integrity. If Hornet
isn't enabled via lsm=3D, this hook never triggers, and an IPE policy
like "DEFAULT op=3DBPF_PROG_LOAD action=3DDENY" silently allows every
load.

I think IPE should register bpf_prog_load() as well, post_integrity()
should only store the verdict to a per-prog blob, and bpf_prog_load
reads it and evaluates policy.

-Fan
