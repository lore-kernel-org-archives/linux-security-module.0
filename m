Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2941D9A54
	for <linux-security-module@vger.kernel.org>; Thu, 23 Apr 2026 00:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776903613; cv=pass; b=LXQHQ0ZT9TdJ4lAZHMWPOi7m8wQwBgP8vFcvxAWsiO9AuJyxpCiN/JFhCC/n8GriVjqftzzP6jDei0ZdL2+V+gU0s6RaHO6+1NUT1XT2Bd9UcQdGvfWCPJjdemkP5B7iYIPnYyc0+UVKjU17Gn41eZRVa4XhDw3WGXcQaIlGBLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776903613; c=relaxed/simple;
	bh=2MilzRt8cmnGQ2F/kJxBuopP9nkbS4u7gug4FqwM93k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvLBbX19LbX0x8xURumssYCuO4GC/8cUCxYqywAT2UAvG0fOuKwW8FtKn8k5r+FlyiRlp37aNcnWFu1ETefXfGkHvHox7HBMqJffWUeF9QHF7N6dlMM1Zq2bYuuJpUIQ0iIAAf/EPPqsv7GaXkdIbDtD4HxmPkLf/yUEi5OYZWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d3VEdHR6; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d3VEdHR6"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c7973bbc16dso3940892a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 22 Apr 2026 17:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776903611; cv=none;
        d=google.com; s=arc-20240605;
        b=PUiFOPariOli7MeVkUBNAzDieDa6W+poFu1K2dyDdE6inliSpHGlCFh8ohzGL8msbz
         /70GGtEgc0sLfoL0Pte1WfVVbbnP5Q0mbGP9d3rC2GGRlgCzZNtvE9AHlhNPd11z8qtb
         FVzzWYcdfys/LqllBjI/aFJz2rqSy4qGHw4qrDqzNUZyGQVEUYBhj1Jw9cDABED469wk
         RLFI9Bj8YWvNaEw8XAALl8adGKb0QLsoeI/uF0sAKIWE39ySvk1NRRGnH8F9mVUneT6m
         RakTX80ym5Yx4QqVuSRW2ZhYRc4teqSiB96Xp5fQI+Xreh1CL1K/7FLmKAfuVftM02jz
         XLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WWnOdG2Qc8EhlLJvMnlzyDWOPt+Zq7olkDLmxANGXE8=;
        fh=EJpbgzk281bUx1IMAq67ORcZypKsKD75gUXxIMmx+d0=;
        b=AaU6CDeQb3voDuGcV10I46XMAxLy7cZI3Cu64WJylrnR2RPWa9BWDKAGGEK9waOxkL
         eumJn3PU7plgKKgJpRddZhSwzzNuqEaBiAcN+hzLG1xivNfPg+wU/iAzgEAVxW4wnd8H
         YQPyg+Pn/BWW2nw0exa5Nup4FtlkoZQApYmYF+aQealYwWQfacGNbk5UAowwAOFa3s7R
         OWmrmehwEO+UzozreYTw573znm3lS9COM6X1PGj1pisOF37ILCXBZcFTFn23FOS+kgzQ
         8ngAQG1aZiaK3h1xXGGW6qqiSXofm1rRA8BF6+iDchmf6SmlcxFVvHm8ek8e9mI0zrZi
         EYXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776903611; x=1777508411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWnOdG2Qc8EhlLJvMnlzyDWOPt+Zq7olkDLmxANGXE8=;
        b=d3VEdHR6RyGpsB9+8Jz3IPyIkUzdxKU18XKE91Y4PnVvVO8C9sLg0KJGmVYPI1Z2/s
         0/N3sptOMmr9bziQT0VAVdZ4hcwDylqnzph1SWEgx3j4K3JgxvFe5Ixvss/oC4lpAo0y
         PiUhLDz8gwzIUIYFrRLf7iAFXbofTefZecbmRuz8dIT73SoJvXnZ7RygNwi7u4vy4B4z
         fDIV0bGcErZFTBixpKfx6i1GHMX92noCPyCHgXoXYD96+cKs/5U+h+DZk/qixpBJbB0O
         BHL2UugxELqy3UiPUAQlaftCNErsbAK4dzHa/8a9PYhKOeyQkhUk03l7KxSjxQ2I4LgY
         Yaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776903611; x=1777508411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WWnOdG2Qc8EhlLJvMnlzyDWOPt+Zq7olkDLmxANGXE8=;
        b=inCzTlVvhSAskSdYjZn/TG6jNNBpCzE5WCskT+GV/FrrlcnlMss4GBuyczNcQlcOSt
         gSfe3AFv4Nl3FD7+UMai478UBJWznZkxdKaYSngB+ib45wUnoENz5IpweH4wH2oGW02Z
         YiMq+jObKCZSOZCnyYVcaMFXo4Tgq0W+t9gOB77w4F4aOQgC3NI8fJOWJNny8eYAfgTV
         jlO2hEMSkjgItzrgy13Pj7OLtiOemkAH7EN9dx94g51lfFRZhor85N5IMnBT6U5dZYuK
         g4DJCvywIkaCEpfb/erFmK2lAFyt/8wzCb2PbP4lgZbbveTR8aj2b8Q8On/6nzi+5wAH
         zsHA==
X-Forwarded-Encrypted: i=1; AFNElJ+lg63rvBnKNRg54odTkA7qYAI+mMDJX9YmDCBNggLum5ktMRgAtWMbkoldOUhKlVAO07E2puVfu1nYPTll4AikzbmjsjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2EznLIS2mtk9HLScuHStavN0XH6oaUpiZSFgPMmlL2/x7Ca23
	mekYEbOmd+9xWJsZvtecjlul4HvU1NCsOCZqTzAy1w6n+f5fxX9pFkl7yc97YIV13pkCGar9Gsh
	dYsjhDHwmEFP7V9FN1qoqaLzqCSDik9dN8+vEjlGT
X-Gm-Gg: AeBDiet6cA2AVX9O2lempgpXBvxvReJWCyIwCMXXXeRFIpA9ReYDDU4bHQioUV/7Mci
	lXKzLs/DoGNcGre6ndhS4hUEbgJ/ARaliR/sSMuMig/GljKUR/LJNAd0tw8unf1ptRmL9OissYF
	MXWxPcBvg615Ms50uSjdccWDzQddLHFeLxSS6nUrAS4QZuP8DWr9e6QUa54PDcjzK0KJXLZZ0iw
	i1Ru9gcFSKHVxBVBonRF8n7rm1IF8uEAYqfERJq7N9ix9QASz6EwnVpsbse936pHhK3DPLoawnL
	uTAyE6vbkk/SsUYugA==
X-Received: by 2002:a05:6a21:6da1:b0:3a2:c685:f9b0 with SMTP id
 adf61e73a8af0-3a2c6860b22mr18691201637.49.1776903611025; Wed, 22 Apr 2026
 17:20:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312100444.2609563-1-mic@digikod.net> <20260312100444.2609563-2-mic@digikod.net>
In-Reply-To: <20260312100444.2609563-2-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 22 Apr 2026 20:19:59 -0400
X-Gm-Features: AQROBzA-RiP1h7rMGgAyQ5vVHw1O5KoNpY2Zr4y9YGn7VDWJmeZCA985VQDaF6Y
Message-ID: <CAHC9VhT4Cd-FMYhaKgt6Gv-Suu7YJm7YbKZ-vdMwQV7EiWDryA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 01/11] security: add LSM blob and hooks for namespaces
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Justin Suess <utilityemal77@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 6:05=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> From: Christian Brauner <brauner@kernel.org>
>
> All namespace types now share the same ns_common infrastructure. Extend
> this to include a security blob so LSMs can start managing namespaces
> uniformly without having to add one-off hooks or security fields to
> every individual namespace type.
>
> Add a ns_security pointer to ns_common and the corresponding lbs_ns
> blob size to lsm_blob_sizes. Allocation and freeing hooks are called
> from the common __ns_common_init() and __ns_common_free() paths so
> every namespace type gets covered in one go. All information about the
> namespace type and the appropriate casting helpers to get at the
> containing namespace are available via ns_common making it
> straightforward for LSMs to differentiate when they need to.
>
> A namespace_install hook is called from validate_ns() during setns(2)
> giving LSMs a chance to enforce policy on namespace transitions.
>
> Individual namespace types can still have their own specialized security
> hooks when needed. This is just the common baseline that makes it easy
> to track and manage namespaces from the security side without requiring
> every namespace type to reinvent the wheel.
>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Link: https://lore.kernel.org/r/20260216-work-security-namespace-v1-1-075=
c28758e1f@kernel.org
> ---
>  include/linux/lsm_hook_defs.h      |  3 ++
>  include/linux/lsm_hooks.h          |  1 +
>  include/linux/ns/ns_common_types.h |  3 ++
>  include/linux/security.h           | 20 ++++++++
>  kernel/nscommon.c                  | 12 +++++
>  kernel/nsproxy.c                   |  8 +++-
>  security/lsm_init.c                |  2 +
>  security/security.c                | 76 ++++++++++++++++++++++++++++++
>  8 files changed, 124 insertions(+), 1 deletion(-)

...

> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index bdc3c86231d3..de774e374f9d 100644
> --- a/kernel/nscommon.c
> +++ b/kernel/nscommon.c
> @@ -77,6 +81,13 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type=
, const struct proc_ns_ope
>                 ret =3D proc_alloc_inum(&ns->inum);
>         if (ret)
>                 return ret;
> +
> +       ret =3D security_namespace_alloc(ns);
> +       if (ret) {
> +               proc_free_inum(ns->inum);
> +               return ret;
> +       }

Since this is an RFC, I'll make the nitpicky comment that it would be
better if the LSM hook is called security_namespace_init() instead of
security_namespace_alloc().  This fits better with the convention of
aligning with the caller's name, as well as to helps to indicate that
the LSMs will be initializing the LSM state associated with the
ns_common instance.

> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> index 259c4b4f1eeb..f0b30d1907e7 100644
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -379,7 +379,13 @@ static int prepare_nsset(unsigned flags, struct nsse=
t *nsset)
>
>  static inline int validate_ns(struct nsset *nsset, struct ns_common *ns)
>  {
> -       return ns->ops->install(nsset, ns);
> +       int ret;
> +
> +       ret =3D ns->ops->install(nsset, ns);
> +       if (ret)
> +               return ret;
> +
> +       return security_namespace_install(nsset, ns);
>  }

Do we also want a security_namespace_switch() called from within
switch_task_namespaces()?  Of course LSMs would not be able to fail or
return an error at that point, but it seems reasonable that LSMs might
want to update LSM state associated with the current task once the
namespaces have been changed.  This is similar to all the "_post_" LSM
hooks we have for various operations in the VFS and network layers.

I think we would want to pass both the task_struct and whichever
nsproxy instance is not stored in the task_struct to the hook.  I
prefer placing the hook after the task_struct has been updated, but if
anyone feels strongly that it should be the other way that's okay with
me.

> diff --git a/security/security.c b/security/security.c
> index 67af9228c4e9..dcf073cac848 100644
> --- a/security/security.c
> +++ b/security/security.c
> +/**
> + * security_namespace_free() - Release LSM security data from a namespac=
e
> + * @ns: the namespace being freed
> + *
> + * Release security data attached to the namespace. Called before the
> + * namespace structure is freed.
> + *
> + * Note: The namespace may be freed via kfree_rcu(). LSMs must use
> + * RCU-safe freeing for any data that might be accessed by concurrent
> + * RCU readers.
> + */
> +void security_namespace_free(struct ns_common *ns)
> +{
> +       if (!ns->ns_security)
> +               return;
> +
> +       call_void_hook(namespace_free, ns);
> +
> +       kfree(ns->ns_security);
> +       ns->ns_security =3D NULL;
> +}

The "namespace may be freed via kfree_rcu()" comment in conjunction
with the standard kfree() in the function above raises a red flag.  Do
we need to take an approach similar to
security_inode_free()/inode_free_by_rcu() here?

--=20
paul-moore.com
