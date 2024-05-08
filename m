Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499FC3E485
	for <linux-security-module@vger.kernel.org>; Wed,  8 May 2024 07:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154504; cv=none; b=SLovabnfrf4PCDsjhltaxAnIHa7tvic/a454uXFcp6PsD9tpZT0ZfZ9m6tCG9NnRxYrvbf0NDAjBbX4jJvDsOb7uCBPb9nQW0PnAXsdZqpPqQ8QDoX4Igee8hgzX4UlEpQOet5IM2fKNHZ8F6SX/S9wnn0uaF77q3xU/h1S5rKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154504; c=relaxed/simple;
	bh=TasSARTFdXIxUWjPKu3kpQ4aMQkQD44UgXk5WeGg/+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTJPGTKeuRMGpZmWhqWseYf/1/zOdpsbaQx10ftjX/+54do70jBi6eqmN4j6r5Pb7EKF8lXEsIEon8fFMpm/tVwC9C9EcG9GSsHDNvn6W9+lY4aJyAyjh1qEuAzWVnqGI4VeaQKlITsxO+U+2r3TO//E2InqMVRTf5s66sFH5Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j3skPPsS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j3skPPsS"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ecd3867556so30348975ad.0
        for <linux-security-module@vger.kernel.org>; Wed, 08 May 2024 00:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154501; x=1715759301; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M5pHOmjks1nfFEoIt8pbmL3QjdwH+0idfpB8T7F0fDQ=;
        b=j3skPPsSFbSHJTW0O9ayFuYTfjy1A4clRZ3JTaXIl8wiwx5fulCDL6QNC/59beX4P7
         tQdx7lNFAexBVtmYKhCrVkOYk5bFStBsI7Iz2R42RwSdJwMzry3ypSY7UGkTHkMUPOAS
         9VsZ38R4WO751o9z8dyR96fkNJQtpnm497Xpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154501; x=1715759301;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5pHOmjks1nfFEoIt8pbmL3QjdwH+0idfpB8T7F0fDQ=;
        b=UHwdo2RG3xv40y4rblvtFQQylWKxY6hm1wc6RAuo4nZZNLPUMZl5Z+/52ebjep8ABd
         VUIRYCM1b7oBD0NsnWlUCfy8eui+yyejWWIxh/TxuhEW76W48x8JXMANqlzKxI96HN1G
         Ex5Lt9hCdx5QmQ6SOKXeVZvk5JMflYv6uJuaX0tVPUvurPYk7cAuZzUp0VNK3DSQZTsq
         hE8S3ccItQfm+fCos1YDuM0e3Wy0yX/ks4Pk12fZI+uZddsWOuZPOy/Y0vO8sWqPAeXN
         QbMQR3M1oLmf49jQWfdqMuRJ0ofilR6CoTB+edoadRoRaQqh+XMJ+vki42jMf4szcc4L
         l6Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUXmlPYkXoSy+GFYKa6NOmGiHN/4SSZFTVl1bHLUVYZsrqRat1rgfsCaLfJphq+1qu8+VDOp5akt33updyCkX0CjROf4ieI4A0XfSim1qV2nO8pte3r
X-Gm-Message-State: AOJu0YymdiTMCEujgbsKcx94dw407S9bGx6Q0+khID1bz2rM0Ei034FN
	o5io6LgAxU7sfOMxUSReK2fuwuqtvjxtvjA5qE/5Ic9Oh+7Z3HebjQkH1WuzJA==
X-Google-Smtp-Source: AGHT+IG4ah6/Js07oQcVDizigw0pMGjNWVoBVRv7YEqpwTeEYnbIOrMnpPlN/hxArf5H4b01hmjAhQ==
X-Received: by 2002:a17:902:ff02:b0:1eb:7172:673b with SMTP id d9443c01a7336-1eeb01a3cd5mr16915995ad.16.1715154501566;
        Wed, 08 May 2024 00:48:21 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090341c300b001e245c5afbfsm11186041ple.155.2024.05.08.00.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:48:21 -0700 (PDT)
Date: Wed, 8 May 2024 00:48:20 -0700
From: Kees Cook <keescook@chromium.org>
To: KP Singh <kpsingh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, jackmanb@google.com,
	renauld@google.com, casey@schaufler-ca.com, song@kernel.org,
	revest@chromium.org
Subject: Re: [PATCH bpf-next v10 5/5] bpf: Only enable BPF LSM hooks when an
 LSM program is attached
Message-ID: <202405080045.6D38296@keescook>
References: <20240507221045.551537-1-kpsingh@kernel.org>
 <20240507221045.551537-6-kpsingh@kernel.org>
 <202405071653.2C761D80@keescook>
 <CAHC9VhTWB+zL-cqNGFOfW_LsPHp3=ddoHkjUTq+NoSj7BdRvmw@mail.gmail.com>
 <0E524496-74E4-4419-8FE5-7675BD1834C0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0E524496-74E4-4419-8FE5-7675BD1834C0@kernel.org>

On Wed, May 08, 2024 at 09:00:42AM +0200, KP Singh wrote:
> 
> 
> > On 8 May 2024, at 03:45, Paul Moore <paul@paul-moore.com> wrote:
> > 
> > On Tue, May 7, 2024 at 8:01 PM Kees Cook <keescook@chromium.org> wrote:
> >> 
> >> On Wed, May 08, 2024 at 12:10:45AM +0200, KP Singh wrote:
> >>> [...]
> >>> +/**
> >>> + * security_toggle_hook - Toggle the state of the LSM hook.
> >>> + * @hook_addr: The address of the hook to be toggled.
> >>> + * @state: Whether to enable for disable the hook.
> >>> + *
> >>> + * Returns 0 on success, -EINVAL if the address is not found.
> >>> + */
> >>> +int security_toggle_hook(void *hook_addr, bool state)
> >>> +{
> >>> +     struct lsm_static_call *scalls = ((void *)&static_calls_table);
> >>> +     unsigned long num_entries =
> >>> +             (sizeof(static_calls_table) / sizeof(struct lsm_static_call));
> >>> +     int i;
> >>> +
> >>> +     for (i = 0; i < num_entries; i++) {
> >>> +             if (!scalls[i].hl)
> >>> +                     continue;
> >>> +
> >>> +             if (scalls[i].hl->hook.lsm_func_addr != hook_addr)
> >>> +                     continue;
> >>> +
> >>> +             if (state)
> >>> +                     static_branch_enable(scalls[i].active);
> >>> +             else
> >>> +                     static_branch_disable(scalls[i].active);
> >>> +             return 0;
> >>> +     }
> >>> +     return -EINVAL;
> >>> +}
> >> 
> >> First of all: patches 1-4 are great. They have a measurable performance
> >> benefit; let's get those in.
> >> 
> >> But here I come to patch 5 where I will suggest the exact opposite of
> >> what Paul said in v9 for patch 5. :P
> > 
> > For those looking up v9 of the patchset, you'll be looking for patch
> > *4*, not patch 5, as there were only four patches in the v9 series.
> > Patch 4/5 in the v10 series is a new addition to the stack.
> > 
> > Beyond that, I'm guessing you are referring to my comment regarding
> > bpf_lsm_toggle_hook() Kees?  The one that starts with "More ugh.  If
> > we are going to solve things this way ..."?
> > 
> >> I don't want to have a global function that can be used to disable LSMs.
> >> We got an entire distro (RedHat) to change their SELinux configurations
> >> to get rid of CONFIG_SECURITY_SELINUX_DISABLE (and therefore
> >> CONFIG_SECURITY_WRITABLE_HOOKS), via commit f22f9aaf6c3d ("selinux:
> >> remove the runtime disable functionality"). We cannot reintroduce that,
> >> and I'm hoping Paul will agree, given this reminder of LSM history. :)
> >> 
> >> Run-time hook changing should be BPF_LSM specific, if it exists at all.
> 
> 
> One idea here is that only LSM hooks with default_state = false can be toggled. 
> 
> This would also any ROPs that try to abuse this function. Maybe we can call "default_disabled" .toggleable (or dynamic)
> 
> and change the corresponding LSM_INIT_TOGGLEABLE. Kees, Paul, this may be a fair middle ground?
> 
> Something like:
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 4bd1d47bb9dc..5c0918ed6b80 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -117,7 +117,7 @@ struct security_hook_list {
>         struct lsm_static_call  *scalls;
>         union security_list_options     hook;
>         const struct lsm_id             *lsmid;
> -       bool                            default_enabled;
> +       bool                            toggleable;
>  } __randomize_layout;
> 
>  /*
> @@ -168,14 +168,18 @@ static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
>         {                                               \
>                 .scalls = static_calls_table.NAME,      \
>                 .hook = { .NAME = HOOK },               \
> -               .default_enabled = true                 \
> +               .toggleable = false                     \
>         }
> 
> -#define LSM_HOOK_INIT_DISABLED(NAME, HOOK)             \
> +/*
> + * Toggleable LSM hooks are enabled at runtime with
> + * security_toggle_hook and are initialized as inactive.
> + */
> +#define LSM_HOOK_INIT_TOGGLEABLE(NAME, HOOK)           \
>         {                                               \
>                 .scalls = static_calls_table.NAME,      \
>                 .hook = { .NAME = HOOK },               \
> -               .default_enabled = false                \
> +               .toggleable = true                      \
>         }
> 
>  extern char *lsm_names;
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index ed864f7430a3..ba1c3a19fb12 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -9,7 +9,7 @@
> 
>  static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
>         #define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> -       LSM_HOOK_INIT_DISABLED(NAME, bpf_lsm_##NAME),
> +       LSM_HOOK_INIT_TOGGLEABLE(NAME, bpf_lsm_##NAME),
>         #include <linux/lsm_hook_defs.h>
>         #undef LSM_HOOK
>         LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
> diff --git a/security/security.c b/security/security.c
> index b3a92a67f325..a89eb8fe302b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -407,7 +407,8 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
>                         __static_call_update(scall->key, scall->trampoline,
>                                              hl->hook.lsm_func_addr);
>                         scall->hl = hl;
> -                       if (hl->default_enabled)
> +                       /* Toggleable hooks are inactive by default */
> +                       if (!hl->toggleable)
>                                 static_branch_enable(scall->active);
>                         return;
>                 }
> @@ -901,6 +902,9 @@ int security_toggle_hook(void *hook_addr, bool state)
>         int i;
> 
>         for (i = 0; i < num_entries; i++) {
> +               if (!scalls[i].hl->toggleable)
> +                       continue;
> +
>                 if (!scalls[i].hl)
>                         continue;

Yeah, I like this! It's a routine that is walking read-only data to make
the choice, and it's specific to a pre-defined characteristic that an
LSM would need to opt into. My concerns are addressed! Thanks! :)

-- 
Kees Cook
