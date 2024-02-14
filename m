Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9F313472B
	for <linux-security-module@vger.kernel.org>; Wed, 14 Feb 2024 23:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707953085; cv=none; b=W8E+b7xFjpNprZZW0dBU1xwDL9gU4U4HG6bnBeYbXNrvmn2QSYrXqoZR/mRoY5IW+lPsxghkXppPanz4dkCXV0OLcePjxP2F7uCIwd1fh7fwZuGyog7KX7blNukV2eSzDnGEaawmWFOgPf+l/q82MNZ3nf8h3QXjDY07aDOyGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707953085; c=relaxed/simple;
	bh=z3FV6SculjJxKoq8cb1i2S4q1XbiP+WG8CbFW/oAXq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvyjqglAVENE+14kNtR9ak+Mgz5E2TXyAYV9LvE9qA4ByijUOTTTopA/JHv/P17TCNCmpa1PTlljGFgbk1lownUGgKlSjxIrYfzksEdA6wVh5v/0AeRp+8S/4Q2U1ZzIRADKjtb7vydOd5pQVPc4+q/1JYb0rhhKTFjjXjdnMzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bci9uY+N; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bci9uY+N"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e11a779334so203875b3a.0
        for <linux-security-module@vger.kernel.org>; Wed, 14 Feb 2024 15:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707953083; x=1708557883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOQlVf5qnnKk5eJkb2R3QyzFtOwnY+yrwTa/skPqH2g=;
        b=Bci9uY+NRjdfbwxOM8ynNOWIcM3AwfJmNJwABSWS+BQTXyW7r1f0UYcgdrPXS/k2lz
         qGeL3eTnQc5pQq3pFRrZXXUd47Jmx6J6K96TNxCAqJ5HDy4z69D7czKsK4zrnrgVg84E
         /7D5ea1F1YRDqjf2WjIN1pic+bKmV4t+o717w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707953083; x=1708557883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOQlVf5qnnKk5eJkb2R3QyzFtOwnY+yrwTa/skPqH2g=;
        b=gVf53GTKutqKH9pKTuj9EqrReIDyl7cYnUDnm8cLhKkjun3LDg9T/4URfFfE/I6lqA
         5wK29i6Fv1Lfgh/aUemEkWZiGTNV2rTAoJPpFtG/+u2xGfYCMbf2BpOUvs9Xqux0zGng
         9mZWpfqU2KzNatmc/0IptlBZNZNzyhLUJyIppa5x3jxnMx/sr6ssPsMslbFuQ+OVeGZN
         huYVt/zc+FyNjmbpv6tAXMdNxj6AxPsPJIUQ7ltV+r8HHeNBtuG09i+gA3ApJbbAIfhH
         +m+Xic/uZomVjaLtGbgZ27zGH9iVjo++rX2g4MFEvHSwu9UCBcV1rixOU0tD2Yi4UZlc
         2iqg==
X-Forwarded-Encrypted: i=1; AJvYcCXxnnmbTuTad5lYbDQDM8gEXWv5BAmIK7R4zlUuj8rW2gGw4EBuA1ONXcFdOn7ltXIR4mf79iIOZZDxvFbrcm7AuUkZLKrP0B5oe9uxX2Gbg7aaVcn+
X-Gm-Message-State: AOJu0YwhIRBU+zKTOqGvz+8dDAEl4SADW7doBbL68jLSAQTqdJbqEQT2
	DLgCZyymPRbBTBBba3Vtj9MKxrw352waGZ1pCZXwN7FgoBbcudhKm7EYdXIg9Q==
X-Google-Smtp-Source: AGHT+IHH81j493fbEm73R9N7GsBSIcalWlZobL21hSz9Qms+VNW8HqoLZNKIQJjFHeRShvyprQ418g==
X-Received: by 2002:a05:6a00:1803:b0:6e1:eb1:cc8f with SMTP id y3-20020a056a00180300b006e10eb1cc8fmr4109107pfa.4.1707953083534;
        Wed, 14 Feb 2024 15:24:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUj0vkPjui6LzJeZojNrXuDHzO6EZj4cwuyR4iuh6X2ksCiiEw0V4Y06/EH9T6pIPIttLPSnuvYtpm6Ee237lpSnQBrwdCUiPDLoWs9nFXwkp/pOl4nJ0C+q60EYAZWs5z8/W0H4lXTEXHxXoYn7kLkoC4/BikYH5JP465O8YciGPyA+Nq32SqR5H6o/9WioHN7Ay6ZjEKsr9KAcKjEMDXX9zyQUsZlivfx4DKlf1U6MwP8OU8ws0qA33DcaLU3iJIPKkp5N3b7kOSmi0vO
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y18-20020a637d12000000b005dc36761ad1sm4882021pgc.33.2024.02.14.15.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 15:24:43 -0800 (PST)
Date: Wed, 14 Feb 2024 15:24:42 -0800
From: Kees Cook <keescook@chromium.org>
To: Jann Horn <jannh@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: fix integer overflow in lsm_set_self_attr()
 syscall
Message-ID: <202402141453.FEC8EF722@keescook>
References: <20240214160538.1086089-1-jannh@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214160538.1086089-1-jannh@google.com>

On Wed, Feb 14, 2024 at 05:05:38PM +0100, Jann Horn wrote:
> security_setselfattr() has an integer overflow bug that leads to
> out-of-bounds access when userspace provides bogus input:
> `lctx->ctx_len + sizeof(*lctx)` is checked against `lctx->len` (and,
> redundantly, also against `size`), but there are no checks on
> `lctx->ctx_len`.
> Therefore, userspace can provide an `lsm_ctx` with `->ctx_len` set to a
> value between `-sizeof(struct lsm_ctx)` and -1, and this bogus `->ctx_len`
> will then be passed to an LSM module as a buffer length, causing LSM
> modules to perform out-of-bounds accesses.

Ugh. Thanks for catching this. I continue to want to get the unsigned
integer overflow sanitizer rolled out, which would have caught this.

> 
> The following reproducer will demonstrate this under ASAN (if AppArmor is
> loaded as an LSM):
> ```
> #define _GNU_SOURCE
> #include <unistd.h>
> #include <stdint.h>
> #include <stdlib.h>
> #include <sys/syscall.h>
> 
> struct lsm_ctx {
>   uint64_t id;
>   uint64_t flags;
>   uint64_t len;
>   uint64_t ctx_len;
>   char ctx[];
> };
> 
> int main(void) {
>   size_t size = sizeof(struct lsm_ctx);
>   struct lsm_ctx *ctx = malloc(size);
>   ctx->id = 104/*LSM_ID_APPARMOR*/;
>   ctx->flags = 0;
>   ctx->len = size;
>   ctx->ctx_len = -sizeof(struct lsm_ctx);
>   syscall(
>     460/*__NR_lsm_set_self_attr*/,
>     /*attr=*/  100/*LSM_ATTR_CURRENT*/,
>     /*ctx=*/   ctx,
>     /*size=*/  size,
>     /*flags=*/ 0
>   );
> }
> ```
> 
> (I'm including an ASAN splat in the patch notes sent to the list.)
> 
> Fixes: a04a1198088a ("LSM: syscalls for current process attributes")
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
> ASAN splat from the reproducer:
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in do_setattr (security/apparmor/lsm.c:860) 
> Read of size 1 at addr ffff888006163abf by task setselfattr/548

I'd rather prefer that this splat (or some portion of it) stay in the
actual commit log. It makes it easier to scan for sanitizer-related
fixes, etc.

-Kees

-- 
Kees Cook
