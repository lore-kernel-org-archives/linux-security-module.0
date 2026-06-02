Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E8527442
	for <linux-security-module@vger.kernel.org>; Tue,  2 Jun 2026 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365599; cv=pass; b=BvcR5POIHCkNVGpgSKxMzHQsRmKYG/5T8pGy3T9jZ6NqkYcJLA+hpgKlTGRgrx0gKB6HJCFYBegRB/jLQ3Twpo668PSu7ownMtCvEeQSkW5e6Jk26FOW74Vr/3DI/ivICYA0UVXie67MDhnIDlJV0yMfqu4DCXPkl9Ndi/z13Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365599; c=relaxed/simple;
	bh=aKSmv1zJjEzb0yNeulxtjZ3gJVs03YKp9+1MDN8O8ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tFzWGlV2CeNU7BpXs4OjWkv5TfIjb07fYWUTenr42yY+ylJGwhvalWVxaZjEtUtOxtm+yLHsV4LOQCrL3gF9+xHnZh1BKlJ/nK7bb23Wy8usU70owxN6J+8aUmtfJxGFie2vy1WPhyvSJRibA3bchGoqDipbr5xF/trz+xW1B2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aBPBfR+A; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aBPBfR+A"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8584e80bd9so996834a12.3
        for <linux-security-module@vger.kernel.org>; Mon, 01 Jun 2026 18:59:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780365598; cv=none;
        d=google.com; s=arc-20240605;
        b=Zfo8jL6LjyKtBdVrZ0DtxHip6+h0Rpk+WJxdF57TW8O/60c1ealVIIqXTOH8KSJ1O4
         2Gf7L/QAQKdtHtauZhAoItvQgdmFy5YIXo2ywnM9gtyzCBP4zTuETE71SCFwiGdkcB2y
         1kZ+tiHaRGj5+geyKENyxY362XpQfk7+h7OrZE1c+nspfBOluOoibiy/z+1zmpvghx/f
         KcEgecYpw9oJw+qQIoMPhg8dQ9VDlVZr5z4sUToFc3HS/7jfqdMJx09lXYwD1YMh8tyc
         Fxjh7uvXB28Btg6igUjNDlqad41+s7XyQKXyK7yepIP+NG1HWQTcF1W+HFsM/6tG9WBQ
         aatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C1nxm1W1tNWkw2g36V2zj1adnGyyifhC8OviE5jCXp8=;
        fh=b+LL+FRpTAdYXCJr2AXSyFq/lZSxnG3tX10Rledw+7Y=;
        b=ELH/E+UbnICnQ+FB+WibURNIC8f7uem41XdmWmPGqeR2okXOcuPz8R+0K95VXbPFdt
         WErnCjCeOGHGS0OClKFnVEAcJwi7Qc/ta0V/TOJnbRgy1itQkYfyBImiV8D9jhVL02vP
         pfIOCFi+rOeXqD2hYQhS9O9YWuWrFZey6/EmbcTrxr5AR1ydqVeK5OEiZ7jBz0VOnzE9
         vcfh0E1cA5RmhsC+nE8k5fQMixkIYz1KUapIUfK+AbTpacgDeO4wZ3h73y9vZYSovKi2
         gWNMnl4NXHVKY7LGejVxL2QJMWpiw9mgKXh9BOjbksc81gKkpJDXEhuOJ81rF/NM4CWs
         wVSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780365598; x=1780970398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1nxm1W1tNWkw2g36V2zj1adnGyyifhC8OviE5jCXp8=;
        b=aBPBfR+AHNrTPy7ShbyGsCwAyot6xOv79GvNEN7/YGYgC7KyAqIj1knK5gq3BGCNiC
         dC7Ut8JHJE2IYZ6THvGDmrU0eubvoXSVJOkvVz1bsyNcQDbKWaaK+lXAPZtpvxt2t9bu
         grKlmQ4H3VN4bm0pfMR3uZPDEOW5+a+hyj/pN5nBCxMH0KCJoMB9VI4Hwa9Ear+VKnfJ
         ZL/duAW/osLUpwQtJCm+hKvg74OK4ccZDlEx4m2vQ1RDpk2ZX4kfvO6SX+xYnTQjhLp5
         uKkTxLqa6aLXxvEtpAb+8xShgB04dl+j1uYQKLFNjFuV4U9E/N3dlGBgTitzQdNh7KYM
         kW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780365598; x=1780970398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C1nxm1W1tNWkw2g36V2zj1adnGyyifhC8OviE5jCXp8=;
        b=lGOfWWNsyRY7qEDhq8N7euFwUH+74wFXXquF9kz/EwBsnUrd7FZYAeD4qPpU6Mh7gk
         k9Cef4sDVg6fJvGSA8X0XJ67iESsPWelx0A7GsMg8mwXKcZdCxz9qMvJmrdiTcWpPZU4
         vzeHwj6VfpGHSBksE2ixBisCdhakwz32m0gaNV2VYWDKFK60EQ2U9n6leu3LvuAKvJ6K
         2Gzte8x3mRZfPeBmflg7DGg9DZTpNm2TZN3+MuUdZ2xlqnb1GJSFh51NyUprs3DY1zEg
         VHgyVeF2iCvhWp8xxj+AIJpbddRDwhg8qWmsbyYtALpTWo+hcLjAEo2j4eXRI7OtN3eQ
         2qTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8AN4Ld9DAIihRfw3vHVoFIV3fhrUrgqzaDrTmQycnHKnTUJA6kzISwAq2xxFVovSuALszZrK+RmclLat8yYuF3qKl4/YE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDeXMQXzw+hC72wd1dI/aqzhqkBcMbpHGWbTKxOfGBlBj7JGCW
	w6EfSkfrliAXqzNnZcI3wpYVzGqVZP3da9g2wONwBfWEYA8fS81WjMxBvwy5gLBRpCBuz6fFzhq
	axcPFusIqjYNW+ZQXV+bgiC+TdrSSLGgXqp/cZHwt
X-Gm-Gg: Acq92OGB8pxLFtz+kk53Ctee03hKC+Cqilu1PyabjgBblnLnEdwNDfJgrHFiu4eVEYQ
	p6eVfCwfiVf2dVXosYNFpjs+k0FmnkY/urDyOXbDabzS4SafDi3NgVrtMEUh8qs5hluntQ+ma28
	vkn+ToAR5v9FyZxC7ucQyTttKW+jUgYZhbRdme27cso/qkYgs0Iu9UKtTY3T1p1MFfw8+ZJMefL
	OveyP/sAtQ9l9D67KrFoc8IsfmeudGs8Tcp1Cj4M0EcYjydk3iakALYnfnBaJbdH7aX/KJVaIrQ
	dUy4Ey9I2LFqutNNdA==
X-Received: by 2002:a05:6a20:d709:b0:398:9662:10ff with SMTP id
 adf61e73a8af0-3b427e7bcc0mr14933199637.4.1780365597844; Mon, 01 Jun 2026
 18:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526153542.105483-1-ethan.ferguson@zetier.com> <20260526153542.105483-2-ethan.ferguson@zetier.com>
In-Reply-To: <20260526153542.105483-2-ethan.ferguson@zetier.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 1 Jun 2026 21:59:45 -0400
X-Gm-Features: AVHnY4LYLppJyI0GtT2L1ntX5d_bjbORH0XJS4JbcbvJff3aZf6CLkC7y5OdIYY
Message-ID: <CAHC9VhR+x7nKM5khLtLArUseCQ+sw3C+bNO9DB16BC9mtq1NRg@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/1] yama: clean-up ptrace relations upon
 activating YAMA_SCOPE_NO_ATTACH
To: Ethan Ferguson <ethan.ferguson@zetier.com>, kees@kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 11:35=E2=80=AFAM Ethan Ferguson
<ethan.ferguson@zetier.com> wrote:
>
> Clean up ptracer_relations upon YAMA_SCOPE_NO_ATTACH, and prevent
> further modification by processes.
>
> Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
>
> ---
>  security/yama/yama_lsm.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)

Kees, I've got no comment on the patch itself, just wanted to make
sure you saw the resend.

> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index cef3776cf3b2..3b7c5384e6bc 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -26,6 +26,7 @@
>  #define YAMA_SCOPE_NO_ATTACH   3
>
>  static int ptrace_scope =3D YAMA_SCOPE_RELATIONAL;
> +static int max_scope =3D YAMA_SCOPE_NO_ATTACH;
>
>  /* describe a ptrace relationship for potential exception */
>  struct ptrace_relation {
> @@ -119,7 +120,7 @@ static void yama_relation_cleanup(struct work_struct =
*work)
>         spin_lock(&ptracer_relations_lock);
>         rcu_read_lock();
>         list_for_each_entry_rcu(relation, &ptracer_relations, node) {
> -               if (relation->invalid) {
> +               if (relation->invalid || ptrace_scope =3D=3D max_scope) {
>                         list_del_rcu(&relation->node);
>                         kfree_rcu(relation, rcu);
>                 }
> @@ -204,7 +205,8 @@ static void yama_ptracer_del(struct task_struct *trac=
er,
>   */
>  static void yama_task_free(struct task_struct *task)
>  {
> -       yama_ptracer_del(task, task);
> +       if (ptrace_scope <=3D max_scope)
> +               yama_ptracer_del(task, task);
>  }
>
>  /**
> @@ -224,6 +226,9 @@ static int yama_task_prctl(int option, unsigned long =
arg2, unsigned long arg3,
>         int rc =3D -ENOSYS;
>         struct task_struct *myself;
>
> +       if (ptrace_scope =3D=3D max_scope)
> +               return -EPERM;
> +
>         switch (option) {
>         case PR_SET_PTRACER:
>                 /* Since a thread can call prctl(), find the group leader
> @@ -432,6 +437,7 @@ static struct security_hook_list yama_hooks[] __ro_af=
ter_init =3D {
>  static int yama_dointvec_minmax(const struct ctl_table *table, int write=
,
>                                 void *buffer, size_t *lenp, loff_t *ppos)
>  {
> +       int ret;
>         struct ctl_table table_copy;
>
>         if (write && !capable(CAP_SYS_PTRACE))
> @@ -442,10 +448,17 @@ static int yama_dointvec_minmax(const struct ctl_ta=
ble *table, int write,
>         if (*(int *)table_copy.data =3D=3D *(int *)table_copy.extra2)
>                 table_copy.extra1 =3D table_copy.extra2;
>
> -       return proc_dointvec_minmax(&table_copy, write, buffer, lenp, ppo=
s);
> -}
> +       ret =3D proc_dointvec_minmax(&table_copy, write, buffer, lenp, pp=
os);
> +       if (ret < 0)
> +               return ret;
>
> -static int max_scope =3D YAMA_SCOPE_NO_ATTACH;
> +       /* If max_scope was just activated in this call */
> +       if (*(int *)table_copy.data =3D=3D *(int *)table_copy.extra2 &&
> +           table_copy.extra1 !=3D table_copy.extra2)
> +               schedule_work(&yama_relation_work);
> +
> +       return 0;
> +}
>
>  static const struct ctl_table yama_sysctl_table[] =3D {
>         {
> --
> 2.43.0

--=20
paul-moore.com
