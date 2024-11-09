Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7FF7F460
	for <linux-security-module@vger.kernel.org>; Sat,  9 Nov 2024 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731177033; cv=none; b=TNR2ON8WfGQI+DPcePP4tL5eu0YN0iBxSW0glI+fsiWRDJ1TL41UnvnN9h8eQexa0tADZlwUkxQd9Y4zL9STd1NUN8UZFhKdonKkIw9ya+wZZTyehYbgWylhchp89qQTVreEiKjGoTGXa2vDgctSCO7+s9Rbnyq9R6dON+/b4UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731177033; c=relaxed/simple;
	bh=KCVB8kSdHUut1Z9+Ll7oW9hPbxlbyOhRBNGy8mo2a6k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PMHTGfOCIx8H/NnMKXy772BPG1G+dp15cPA1ALlh89A1DQNg2CUDeCUqS0HkULqLczh0mpEAWBz4JVNA9WyAy5FJW3renfljXF3qkQe9nxnfgv8kTiQ9MbNtG4c3t+WvGz9YW5gpSGMYgbhr46QdmyS6ZjgqrICopitJ90WL+9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FXFfSSzx; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FXFfSSzx"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a99efe7369dso62398766b.0
        for <linux-security-module@vger.kernel.org>; Sat, 09 Nov 2024 10:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731177030; x=1731781830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLufq+X/yG9C9kLGe2tLygXN2l6dm6u4UYRcmXiA5h4=;
        b=FXFfSSzxfHFtAw4bPthrLFaQ9UMwmSEodxglx0kTTyianUfkTLYdV7sKiXx1BupyC9
         uSA7B7ULO23CFNCnrUbOnOdjPo8ZI0KHu5rqBuCZNNvp4/mLfYt0U7HRBxj7fuBRA++V
         V9hOmcf3wPpy/p5ZGWg18YAhIY7HTYCXT6x+pOS1B2JTqvxegIV7TbP76RSKbGBKwGfG
         QAydh53MzA0+g/MvsR6CozQMajxzQiGCNtNNnTeBAnPMx7X5xX3omou2junWQu51R2ig
         LBXLa56f7d5iYVs9EmSGPM4HpRYI+ufIq8ZWh2LU1nard4GrX4WarAE/DDLULs/ly5Ly
         aRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731177030; x=1731781830;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MLufq+X/yG9C9kLGe2tLygXN2l6dm6u4UYRcmXiA5h4=;
        b=LC+sZdNM7GY35QivAv8ojCQ9PUixvw3W6FzHzhAY7SLgBUVjxmASDgNDIJRo02Snxd
         XEixLT/alFVUkcGHKCKnIxKbFmBGxlAvDBLvmjPLv/iCKKraJkRcTiiENEkhbx0Gd6Bt
         Pmr14InYPGqLvFECl77Qb0KpJuMVMhIDje1NkkVMiObJQHfv7pjRJoLt1X7N9qVYEo93
         T4iJY/+vOChQtoy/cwJb1iCOQmEw4Zh2x1+B51JdP1Z6wBITNVqSygnW+v26lRf6SSg6
         TeZ36bne5Uk8wTQyWCyoceMQwbxDtp0yxbF1UUg7FTd1+sYYte2NGz6D1iaNMVb/ozWD
         t0dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeft0UrhxwhVxl4FzTooSQEBgK+pRLigza1keJW5x/wCRwuEcOqioVAMgvJUg+K49Z1qfP/oSsVivtvIlJgIkI2W4eMuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA27EvnYdc48eVmE3Kg6WP1jPAn8k7jR11Y0pA7SyQ4dzlSruf
	BtD32HzI1vGc6JZ70rRaCryRVBKGaGncNqd8e2IyTXhN55kC/poVPo7zktRJxCCrGml0QHjVxJL
	6Og==
X-Google-Smtp-Source: AGHT+IE7LbqfVTOkNsjoWw7EyG5NChQgRbBMHJ5PTDRwT9sRYpmCvNRUgx5yJbwxA97XgSr4PBu/2Cd0OVg=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:b818:b0:a9a:940:5432 with SMTP id
 a640c23a62f3a-a9eefff12fdmr208266b.6.1731177030058; Sat, 09 Nov 2024 10:30:30
 -0800 (PST)
Date: Sat, 9 Nov 2024 19:30:28 +0100
In-Reply-To: <20241109110856.222842-4-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109110856.222842-1-mic@digikod.net> <20241109110856.222842-4-mic@digikod.net>
Message-ID: <Zy-qROSRm1rb_pww@google.com>
Subject: Re: [PATCH v4 3/3] landlock: Optimize scope enforcement
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Paul Moore <paul@paul-moore.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 09, 2024 at 12:08:56PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> Do not walk through the domain hierarchy when the required scope is not
> supported by this domain.  This is the same approach as for filesystem
> and network restrictions.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
> Cc: Tahera Fahimi <fahimitahera@gmail.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20241109110856.222842-4-mic@digikod.net
> ---
>=20
> Changes since v2:
> * Make the unix_scope variable global to the file and remove
>   previous get_current_unix_scope_domain().
> ---
>  security/landlock/task.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/security/landlock/task.c b/security/landlock/task.c
> index 4acbd7c40eee..dc7dab78392e 100644
> --- a/security/landlock/task.c
> +++ b/security/landlock/task.c
> @@ -204,12 +204,17 @@ static bool is_abstract_socket(struct sock *const s=
ock)
>  	return false;
>  }
> =20
> +static const struct access_masks unix_scope =3D {
> +	.scope =3D LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET,
> +};

Optional nit: You could probably inline these two struct access_masks value=
s
into the respective functions where they are used.  (But it's just a minor =
code
style matter IMHO; both ways are fine.)

> +
>  static int hook_unix_stream_connect(struct sock *const sock,
>  				    struct sock *const other,
>  				    struct sock *const newsk)
>  {
>  	const struct landlock_ruleset *const dom =3D
> -		landlock_get_current_domain();
> +		landlock_get_applicable_domain(landlock_get_current_domain(),
> +					       unix_scope);
> =20
>  	/* Quick return for non-landlocked tasks. */
>  	if (!dom)
> @@ -225,7 +230,8 @@ static int hook_unix_may_send(struct socket *const so=
ck,
>  			      struct socket *const other)
>  {
>  	const struct landlock_ruleset *const dom =3D
> -		landlock_get_current_domain();
> +		landlock_get_applicable_domain(landlock_get_current_domain(),
> +					       unix_scope);
> =20
>  	if (!dom)
>  		return 0;
> @@ -243,6 +249,10 @@ static int hook_unix_may_send(struct socket *const s=
ock,
>  	return 0;
>  }
> =20
> +static const struct access_masks signal_scope =3D {
> +	.scope =3D LANDLOCK_SCOPE_SIGNAL,
> +};
> +
>  static int hook_task_kill(struct task_struct *const p,
>  			  struct kernel_siginfo *const info, const int sig,
>  			  const struct cred *const cred)
> @@ -256,6 +266,7 @@ static int hook_task_kill(struct task_struct *const p=
,
>  	} else {
>  		dom =3D landlock_get_current_domain();
>  	}
> +	dom =3D landlock_get_applicable_domain(dom, signal_scope);
> =20
>  	/* Quick return for non-landlocked tasks. */
>  	if (!dom)
> @@ -279,7 +290,8 @@ static int hook_file_send_sigiotask(struct task_struc=
t *tsk,
> =20
>  	/* Lock already held by send_sigio() and send_sigurg(). */
>  	lockdep_assert_held(&fown->lock);
> -	dom =3D landlock_file(fown->file)->fown_domain;
> +	dom =3D landlock_get_applicable_domain(
> +		landlock_file(fown->file)->fown_domain, signal_scope);
> =20
>  	/* Quick return for unowned socket. */
>  	if (!dom)
> --=20
> 2.47.0
>=20

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>

Looks good!

=E2=80=94G=C3=BCnther
