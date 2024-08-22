Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DE61CCEC9
	for <linux-security-module@vger.kernel.org>; Thu, 22 Aug 2024 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344059; cv=none; b=t0G7awTlF6TjvfxUSa+yCxpI+AjHHmNw9Zud8N9sO6D2sAThqjTRiOA8SBWrjrGbOzuT9SX1rmMzVlev6Djwr9fU1xaf3O5KfvmYlyf9fx3J61VMz+Ctm7LWNBTP2bZMiIPfZ5EK9SxNSNmXnKQZz7824ISuCYcfXjuwlga5j5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344059; c=relaxed/simple;
	bh=/r98ROwev/jnRYgKVKK60ItlcEsAtB6Ak/Bqy+2sao8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTON89+TQSGV4dEkXLIIcsMPQyeJvi5r9Jgkt6Lg4UZfOvlfSRwXxg4nEsFUOmWJQSIA03/MigDaRxsxErKld5xn1+gjLiMXpi9D+8NCq29oxNPgMqlypesWX8nGn5mQXO/m1jDdixx6BdNZJH45iBrRw7ZSibGOdn6vdtryc48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BRCM2yBX; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BRCM2yBX"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e16518785c2so874140276.1
        for <linux-security-module@vger.kernel.org>; Thu, 22 Aug 2024 09:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724344055; x=1724948855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z179nEdp6MHIRUAsTk7YI6gwzjTXq2xOdFVOnRR/ORg=;
        b=BRCM2yBXUAqJC76G7+HrqsSIa3tKtWepyfldqt3Sej9qxfq+ZuAFRRR7K9D4zA9pVG
         Djl1tDlKcJ6SBANTc7c5+RCeGS3h7KYnNR6wxpcLjp1cO6vYvcRsShF7/XDj47MGSlM4
         tmCEQKB/nHZzTGW8gy4Y8BzhEQYWxcJ3XwF76quxkangxjS4JzUF7HWK+M41T8IQpcX3
         ZP7nP+YYdqvcCa8d29w7VrMraYVHUsGUKkOpYB6us6TOrLbZ9TYjuuOCiUEYqq/Vf+4/
         esnWapl20LmiMfTscO+WsU7wRa2ZSwCaLSTcBQs2/VXCNDdRC/DXk+D2IHOUbjdW2doP
         B5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724344055; x=1724948855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z179nEdp6MHIRUAsTk7YI6gwzjTXq2xOdFVOnRR/ORg=;
        b=wQ2Ah6rtlVF9swPzytC6YlhopcRV0rPb9qtJ6DFMLDy6zxWeD09IVQRiCMf5Tr7ACj
         pvJcuZGlM9OaDaWrflxATmUfw5gnUiaLm0PqTP1LzbN2PULq+pm5MnJZhNBR3Zuf7bP2
         ACeER5Ej+fdUcdAvdhEZG0/IL6fs7hRNf5SViuc3I6opqq7Hi08IggJX1uccnmi5HGNs
         ks5wSis8zEw+8dSs10p7j9YCcxWMIq9Lc2jV8lz3eC3zTMpFvcaIuUh+7L9NEmSyG3th
         O3cc/bQY0uMJJnIuubpKWSh0e0YRXZbbF8eX2CCu4f/Oh/B3iak62dFk2BezNMR9r9c0
         3PyQ==
X-Gm-Message-State: AOJu0YxzAm7g6D1uxxd9U6wb//YyT/FZsYAJDtgK81nLUSYM/x9F9a0b
	ZvAPnFtbKI4IjiXLD4IaeXsbjTm2NAhxIYvvFpOzA66oRXm66VE+I5LUNFmDVdIL2fM8n1mIMIH
	1xK4H87ZIxjbbaVoqfaSSJ+IQ0sD7Bbaf0CWWghK1kUtMJWk=
X-Google-Smtp-Source: AGHT+IHbuNlT8o2Tf3GmwDyhrC662qWbabqzb4WX4jdb3C79i3cJ+Vn+iCpk4YFIVj2gOREtdj/R4hx4Jmrpr7d6N8g=
X-Received: by 2002:a05:6902:2e0f:b0:e16:5177:7598 with SMTP id
 3f1490d57ef6-e17902d8038mr2700324276.16.1724344055212; Thu, 22 Aug 2024
 09:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816154307.3031838-1-kpsingh@kernel.org> <20240816154307.3031838-4-kpsingh@kernel.org>
In-Reply-To: <20240816154307.3031838-4-kpsingh@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 22 Aug 2024 12:27:24 -0400
Message-ID: <CAHC9VhTjasfP3YMP8xD1jgaY8KFsZuzRCzeVMK73DTxm538x_w@mail.gmail.com>
Subject: Re: [PATCH v15 3/4] lsm: count the LSMs enabled at compile time
To: KP Singh <kpsingh@kernel.org>, wufan@linux.microsoft.com
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org, linux@roeck-us.net, Kui-Feng Lee <sinquersw@gmail.com>, 
	John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:43=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrot=
e:
>
> These macros are a clever trick to determine a count of the number of
> LSMs that are enabled in the config to ascertain the maximum number of
> static calls that need to be configured per LSM hook.
>
> Without this one would need to generate static calls for the total
> number of LSMs in the kernel (even if they are not compiled) times the
> number of LSM hooks which ends up being quite wasteful.
>
> Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> [PM: subj tweaks]
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/args.h      |   6 +-
>  include/linux/lsm_count.h | 128 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 131 insertions(+), 3 deletions(-)
>  create mode 100644 include/linux/lsm_count.h

...

> diff --git a/include/linux/lsm_count.h b/include/linux/lsm_count.h
> new file mode 100644
> index 000000000000..73c7cc81349b
> --- /dev/null
> +++ b/include/linux/lsm_count.h
> @@ -0,0 +1,128 @@

...

> +/*
> + *  There is a trailing comma that we need to be accounted for. This is =
done by
> + *  using a skipped argument in __COUNT_LSMS
> + */
> +#define __COUNT_LSMS(skipped_arg, args...) COUNT_ARGS(args...)
> +#define COUNT_LSMS(args...) __COUNT_LSMS(args)
> +
> +#define MAX_LSM_COUNT                  \
> +       COUNT_LSMS(                     \
> +               CAPABILITIES_ENABLED    \
> +               SELINUX_ENABLED         \
> +               SMACK_ENABLED           \
> +               APPARMOR_ENABLED        \
> +               TOMOYO_ENABLED          \
> +               YAMA_ENABLED            \
> +               LOADPIN_ENABLED         \
> +               LOCKDOWN_ENABLED        \
> +               SAFESETID_ENABLED       \
> +               BPF_LSM_ENABLED         \
> +               LANDLOCK_ENABLED        \
> +               IMA_ENABLED             \
> +               EVM_ENABLED)

The above is missing an entry for IPE; I missed this during the merge,
thanks to Fan for pointing it out.  As the IPE patchset was merged
into the lsm/dev tree only a few hours before this patchset, that
isn't your fault, it's mine :)

Regardless, it should be fixed in lsm/dev now.

--=20
paul-moore.com
