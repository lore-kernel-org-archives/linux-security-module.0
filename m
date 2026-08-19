Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6BA476CED
	for <linux-security-module@vger.kernel.org>; Wed, 19 Aug 2026 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151255; cv=pass; b=sDKNbxvmzC4mSv/5P0UJ+ODVWU6dyrBs5xH2teq73zZVkUNwRibud/LFfu8HsDaeMEGuTwgHpx7rXHQicIy5I4sVH0oE5XPINYaJ+ll/KXyPYwdHmjQibBrApUNy9qjLqIjbFBlNi86T4AT3aSMa0dTjCQgKJbkrhr/QXIxhXvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151255; c=relaxed/simple;
	bh=clj9gVhyrc3C/LsH68MWAJPwJ+bILDAgRbfld8wd5YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cx+99VBfOUcl6HKTnEYpXGV1An4PUwhdg1zCztuZ9iP3DZJCFmXd3QyKapXO5WSQnKoMgoMTeVxt5Mq+0vPzucFevLVUTd1h79hQFGDH4XWqgQU35K52xZEC9BADfaQI34ClzpovF/g3PVGeqHimEO39FGL+0wjPv4yazZy9aF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEJnXZ+p; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEJnXZ+p"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-455ca262ccbso792410fac.1
        for <linux-security-module@vger.kernel.org>; Wed, 19 Aug 2026 07:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787151253; cv=none;
        d=google.com; s=arc-20260327;
        b=f61Xwv9OO44S7co59BlH2H9eYdC+reIPaulL3kTmqljjYl9H8OhrEXtf1FdyYO9waY
         uAwVN784xV54tzoPnJb/AtEs49/VMSypUKC+om2OUaK1CQPe/VEt3esVzvsWJg5bHI0Y
         BHfPF1TV/tez+HTkgVBbyni8GVQ3SOdd1vBCqoctbPX74uqB4LQbW2MU4t65aNsYO/+l
         yOulDiuISbTEUBHe7fDX2/G94SDLoyWQgThcMxb0JpLkiHpifjm0mwYY5KURBbyBoJlm
         puxI8isN8QlM3XGuEFF+CAqd2ffAQu00onlL/aKuUgI130HkvZKp+T1ZQu9D5uIyFQY6
         goRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mhvw/FgE5+XsocfZbB7wjswP5NddcYAmLYZePhCxoG4=;
        fh=3ccrg4gHqENIxv1f2V6z92s5Rt4awfIABCefsPzh3rY=;
        b=BxXIGMRF3IELENGpcFOLwR2ZpvLkjteUu2Wzj0wQPKz9IPC4v6fq2qNTotIZyDa/KR
         bNQE5qeDENppvgV0+ixEK5/1tFwUOxqqVjBNkMapeohHAdJjW25C7yKg+4JIsHwNRgjz
         w8fJRVlkwUHGWOKh+oOIRdosX40MFXK+gU9jWu1Bhi9o/Tu2KNig6vcW7PhpYxlUNUgS
         dcj4aazVk+e1RA/XozFLkZGQJMY2eIWVOUvK/U3JuxpZR6NKQETOqqgITcsVFkKz3/yp
         wk5c8OVBljhb3xgrFR0eVCGdWG4X1zHgiFWHNajUqyiFd3RNewOFUky6ziWTjg/UuJJC
         5yrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787151253; x=1787756053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mhvw/FgE5+XsocfZbB7wjswP5NddcYAmLYZePhCxoG4=;
        b=kEJnXZ+p3aEgGtxvkXqv241S8crYaqUSvDgZ2N/hyIR1C3FR45l9KF7LYgaHvla85S
         eRTQ3bMK1JZubAirYheCrnIrQz5suHLxyMhenkXL+NBeXVjxLgHBrZyWgVjgOQZJ3mI8
         /9G+7Vt3bXl8JpFELV8SDHAg2gXHhFyJTkJAZv0v1pojM7q2NEUQmgT+P0/wLDUx+MNr
         h4mfdWI5Ren3y3bMnCNzqZUIBIzRrviC9bFe0axEgesJ5umEa9F/+aFZpJg6hpEE02Ju
         1Jy9Jk1wewUStOCxGyep7fKyeNh93rrFR7/7bS/V9OYNiqyH6hyo0jx/NVUSJymB0i8G
         3jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787151253; x=1787756053;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mhvw/FgE5+XsocfZbB7wjswP5NddcYAmLYZePhCxoG4=;
        b=ABPGIAusAOk+UsxgxJZ0Xy965tEuaB6f+oYYxR2Ge5ofXCUUHQU/xbfhOyokAai3vl
         +HWZvk+fogdcGC5uyM3KGnNvMpFPgsW9cM//XwS3hWNxgv8XRT4U4i4JoYXAb+wdgn4p
         wRZNNldchRhRSCNi2G1K4EN2ts5QMLkzfKOagP0YQ7M4WkFKMq5h8fvpieWwGbTMz5RN
         JKdJIZSyV3SIM0+7sHi8jgRQzbIxnMQO+an0uQx9UKtzVxPIARnlc4FrGPt1VOR9h3TW
         vX/N/lh4stv0fAIaoONdJctv90Za9V22EyqRHT2gVQ6Iy0M5BSpBKTWyR7+XOE3lhb1c
         XsmA==
X-Forwarded-Encrypted: i=1; AHgh+RolvenTOC5ZN+NhVGPvEV5p8ZypnTj7DLDX818jsfJciZUZQnclavLSRUOYQsSo5w9vDYbTRRKawA3qz0d5Fy8LtYANcoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQZANiSfXYzdXYs2MR+fLasaGkhu/Gn8YWyE80oBGnbcZGgy2l
	cAuqzoNgWllVyXO0ryeoflijavCTJqtjMt9OjLiqrLhMSI7gRccPL25B6bFKfezzoRg90bOjbCL
	oE71Xz8uGjRC8YlXp+Dp0/3cwEwoQ34AEjA==
X-Gm-Gg: AR+sD10njmhBH0wmxR2UD+BS0sHutFqNY0l8oRQBVKyjyFOV1CBSrYFqBhVezduKpU/
	T8YJfmFPpD2pxvMBbMNdp8tsFtOhaOLpO63Jhi2KyrdoRLVQYqNLOfzcXJMoapzLp/02n3pfmmC
	ZIUsF2sd8hdRi/Lg7YTOj0kiucEkjLvucdrovEvVbheIsOSSvOpQmjcoLjnWzRo1IqBTg5HF0U+
	GROpy4i3PvevxF6pcgbKGH7zItsBecm2anBY/3xtDJmWpNjAitKbcY1XlRTwI0JWteoiOjKVlKF
	Xt/V6sdtbuFMUiGsE9ZMvFJVjjWCr3XTBZVvZga8/VBh
X-Received: by 2002:a05:6871:287:b0:447:a201:4a5a with SMTP id
 586e51a60fabf-462f64be287mr5194131fac.8.1787151252623; Wed, 19 Aug 2026
 07:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com> <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com>
In-Reply-To: <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Wed, 19 Aug 2026 10:54:01 -0400
X-Gm-Features: AcwNN1Vv0YORuTgO6puZkVyho68XY6ndF-y47mMS-AkDlVErDtFxI6gIHPST0Qw
Message-ID: <CAEjxPJ714iCMiQRVAN6MQoOyNx998MS5Xfhbhmugcwz+gWYAuQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: require EXECMEM or PTRACE for FOLL_FORCE introspection
To: Jann Horn <jannh@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 3:51=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process c=
an
> only create anonymous executable memory via /proc/self/mem if it has one
> of:
>
>  - EXECMEM (like for other methods of creating anonymous executable pages=
)
>  - PTRACE (like when using /proc/$pid/mem of another process)

Allowing it if _either_ permission is allowed is unusual in SELinux
and seems prone to errors.
Is there a reason to not just require PTRACE always?

>
> This closes a hole in EXECMEM enforcement that Project Zero has used in a
> remote Android exploit chain:
> It was possible to use a memory corruption bug in a service without EXECM=
EM
> permission to overwrite executable code via /proc/self/mem, which made it
> possible to load and run shellcode with a kernel exploit.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  security/selinux/hooks.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 18dd28b2bb13..905137c47321 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2157,6 +2157,32 @@ static int selinux_ptrace_traceme(struct task_stru=
ct *parent)
>                             SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
>  }
>
> +/*
> + * Decide whether it should be possible to read non-readable VMAs and wr=
ite
> + * non-writable VMAs via /proc/self/mem.
> + * This only applies to systems configured with PROC_MEM_FORCE_ALWAYS, a=
nd only
> + * triggers on accesses that are not visible to selinux_ptrace_access_ch=
eck().
> + *
> + * This allows a process to overwrite read-only code in its own address =
space.
> + *
> + * Creating an audit record on denial doesn't make sense here, since we =
can't
> + * tell whether FOLL_FORCE matters for the accessed VMAs.
> + */
> +static int selinux_introspect_mem_foll_force(const struct cred *subject)
> +{
> +       struct av_decision avd;
> +       int rc;
> +       u32 sid =3D cred_sid(subject);
> +
> +       /* Allow if the process is generally allowed to have executable a=
nonymous memory. */
> +       rc =3D avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, PROCESS__=
EXECMEM, 0, &avd);
> +
> +       /* Also allow if selinux_ptrace_access_check() would allow it. */
> +       if (rc)
> +               rc =3D avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, P=
ROCESS__PTRACE, 0, &avd);
> +       return rc;
> +}
> +
>  static int selinux_capget(const struct task_struct *target, kernel_cap_t=
 *effective,
>                           kernel_cap_t *inheritable, kernel_cap_t *permit=
ted)
>  {
> @@ -7558,6 +7584,7 @@ static struct security_hook_list selinux_hooks[] __=
ro_after_init =3D {
>
>         LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
>         LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
> +       LSM_HOOK_INIT(introspect_mem_foll_force, selinux_introspect_mem_f=
oll_force),
>         LSM_HOOK_INIT(capget, selinux_capget),
>         LSM_HOOK_INIT(capset, selinux_capset),
>         LSM_HOOK_INIT(capable, selinux_capable),
>
> --
> 2.55.0.737.g08866a6d13-goog
>
