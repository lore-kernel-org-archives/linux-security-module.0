Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07680126F3B
	for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768400; cv=none; b=aWkQRBsCgIfbkBpcQQkwK6NoKIP84OQwXwlEsQ+S1vSLombA+lUmEMRXbSVU4YDbRt7wl6sPMLahLRQ9ArhJG25mhifRqx0um9lBpjNnpZ7+iYObYh0q4lBXDEgs0Kiqc/iBMbs+ewn1rkzzBR+zbrkzuhYFa7V7a1opa3QXO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768400; c=relaxed/simple;
	bh=Dklrp+gYtsvtPdTaCXh5d5Tr+54/pCi9wlgN+FDIg80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tlzL+wMD7B9brDsvPhDMWFjnN/0FWysaiGgwAtzbVhSyGNx8J2HW6H/0Uf5+Wfr9eHE6LmLFooRHvLXlo+pO6nN9PeL+MmC3mZu7R+aTBeff9LJZZ0aRWkCp2fbjRH0H6OWWTaRTI8wZey1UWrRlH8IpnpclLK7DhfsY6bPOneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iiri4MeJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iiri4MeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FCDC2BCB3
	for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 14:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778768396;
	bh=Dklrp+gYtsvtPdTaCXh5d5Tr+54/pCi9wlgN+FDIg80=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Iiri4MeJkdMUrG2i+Js4sWXhn42Djmy4Y1nUlG9WdraNfnmftVmh7KDvVrKQKmWE2
	 dk7hxSdEdLlo5Y+gUZYVJFGpS6P8JDR3HttuG17Jhp7D2RQULFfW3i+iT0p6TIdjeB
	 3HvdGU9I+rZHrFhmAXTOtxbkL64gneXfAP5kzLM89tErRMDkw+2rFkyy0Xn1mKeX+l
	 xynUNctv5ZlqqXEg39RyHuJ2dbghkxUdyPQCaJQ1RTnhR2I+EOSxJK6zdhwV+RhqLq
	 zEC48a73rv25Ki0LA7yNtVZHQnbP7HuYV3PcKo2sYDODn/Vks6ecQ4abZ/C/d660Oh
	 beM6ydQdCDUgA==
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1335cb20406so18315c88.0
        for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 07:19:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YyUK5kaT64BPGo0i3sGTMoQKE17xqrwHV2H/T/5cEj9X6F4ceRj
	GBM2crstNiAp5iPzjwyuwsX9cpa1mtdHUjLNzSHJ63TnRa4pvNgTuGUz73pp2NqLdZmV10PglFn
	25UUHwAbyalt2cD5vzGvX5AAdVpUYIf0=
X-Received: by 2002:a05:7022:2523:b0:130:ab68:2b6f with SMTP id
 a92af1059eb24-1342ee4217emr4964702c88.9.1778768395709; Thu, 14 May 2026
 07:19:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514023640.574020-2-paul@paul-moore.com>
In-Reply-To: <20260514023640.574020-2-paul@paul-moore.com>
From: Fan Wu <wufan@kernel.org>
Date: Thu, 14 May 2026 07:19:42 -0700
X-Gmail-Original-Message-ID: <CAKtyLkF87QGh2PKjkhnD7XgsM_sDoDOrFq9v4tk7n7tTbggsng@mail.gmail.com>
X-Gm-Features: AVHnY4KUl3_oG8puwFYeSSxTv6tjFaA7egdAk5btrbCfnH3AQlgn9175i7Rf7Ew
Message-ID: <CAKtyLkF87QGh2PKjkhnD7XgsM_sDoDOrFq9v4tk7n7tTbggsng@mail.gmail.com>
Subject: Re: [PATCH] ipe: restore the kdoc comments for evaluate_property()
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, Fan Wu <wufan@kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 7:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> The Hornet integration patch mistakenly munged the kdoc comment block
> for the evaluate_property() function, this patch restores that
> comment.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605141037.VVorBhvP-lkp@i=
ntel.com/
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/ipe/eval.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/security/ipe/eval.c b/security/ipe/eval.c
> index 705c4ecfda69..23ae1edf896b 100644
> --- a/security/ipe/eval.c
> +++ b/security/ipe/eval.c
> @@ -331,7 +331,9 @@ static bool evaluate_bpf_kernel(const struct ipe_eval=
_ctx *const ctx)
>         return false;
>  }
>  #endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
> +
>  /**
> + * evaluate_property() - Analyze @ctx against a rule property.
>   * @ctx: Supplies a pointer to the context to be evaluated.
>   * @p: Supplies a pointer to the property to be evaluated.
>   *
> --
> 2.54.0
>

Acked-by: Fan Wu <wufan@kernel.org>
