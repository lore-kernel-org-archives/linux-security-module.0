Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753C117B519
	for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2024 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718996872; cv=none; b=Kw9QZyAsbImKOM1ncH4jTKGUhvLmD2uYPxgWTn5MZqn04F+lsXvW+xKvsRVsxQl0KTpS4goGJQF3DiOT6/d+OCqIq0oBJfDgZ9gUN9uFFVo7JXXJ0SLjXb20YgHuTr/5FJBxuc34Z7r2F7HGpk7e5fIfTR4ZtjnJYvRL0s0zwmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718996872; c=relaxed/simple;
	bh=OgtW0PolzKlu3DuP/Ly4GM6uBH1C2TOKBTPByEm36p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r07bKfy3H2PmxzaQerLvbYzTmn2vJZg82c7d5kfPGHiVsXIaqKmoqcTTheRh2lxTe3fdaZ8lDuApl28u9mpAIRA+x41mG+K1M/hsoPj1Wb4r6aTFwodUME/PTUaVxE01uan6z+3td3darephBMFRza43g68RHd7kxNEq6lIVB04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IKug9iK5; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IKug9iK5"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-375d22e537cso5547725ab.2
        for <linux-security-module@vger.kernel.org>; Fri, 21 Jun 2024 12:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718996868; x=1719601668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21pJkt4i6sPEOOyDWDB0SKaulleOUnMEb/pI3tpTORw=;
        b=IKug9iK5zEYB4TMpDFoC2nZPraFUjG3eei5u2FsLnVN/Bwt/g04M39Lx8pRtz/aw5b
         G0tao6o0K3fKxpe/sVq4+98BDh4lcL/Ln7xRXwztN5e1+TkGRPE4e9kM9fBZC4LpXrsH
         XyUVZOKtTnX5+ESuob9RTCeiO/GSKBnX0VgN71Gxhiw6fJbjyMZzUKgU3vpd6pdF2sRr
         jFX43FeIkIyel0jIVaBBGgpx/OcZxLIiiHHHlTJEzcWBqUYM9SVhsciPcKONHL4bMCEh
         jZfKZksnCx/7NNvmLnrHVcupqhAbL6Zhwf8exdvtxKoIgmcaMe0Khd6NOCp8+jNEPpnM
         o63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718996868; x=1719601668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21pJkt4i6sPEOOyDWDB0SKaulleOUnMEb/pI3tpTORw=;
        b=V3YLKQD9b3rgb28BTiF/olomVGMzmsjdyA7w6i2fOZUb61+1TBBKgUviSI0+0d1S+j
         KEF5qieMf+EcJOgHU9+eVJq9rIHpHiDrrrTTKBYX9ilfdITyKxbGhC2vkETJzPGEq+5q
         wC3yCpVv2FCeF6urkeAePdEV1HVEEK9LKYceY8Ou/DOnThKWXdwIqH45PN3Nan0YNoHa
         0Iwe04jIqphQI8AkuzTTEn+gn0Zfunvj1xvimpnpiQVC/CH+hVwqftHqQH8hf81rwmQx
         +C1rwGkXpNPjPko0ebbJgZJWLhw06IjOgJLbQGsgF8fXquhmlG9qy7f3ciKxbJz+cCOI
         9W7A==
X-Gm-Message-State: AOJu0Yz8Y3tqVciY5U0Pr53l/KOzHfL2TxyYWQQ+Ea5zITeQ40g+jBDE
	JzfJZEL+hm/j1Ci2109Om5+IcyLwt2saf9gvYsQF722Iu8cpMsnNIvrs0NIRBxURiHsXwp1yL11
	yvPMXkwlEuimL1uba8zFRX7l4eqTj8VxoIz4E
X-Google-Smtp-Source: AGHT+IHu0ya8kYBZAqCEABDgEQTyExWEH17wQ5DC8D6SIaYS7YHc8/ymQQjHd+AAXHlU3ZzLVbbW3uMpjIxi5WchcDM=
X-Received: by 2002:a05:6e02:1aa2:b0:375:86c9:9ec9 with SMTP id
 e9e14a558f8ab-3761d6a1223mr104294625ab.11.1718996868495; Fri, 21 Jun 2024
 12:07:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215221636.105680-1-casey@schaufler-ca.com>
 <20231215221636.105680-2-casey@schaufler-ca.com> <CAHC9VhT+QUuwH9Dv2PA9vUrx4ovA_HZsJ4ijTMEk9BVE4tLy8g@mail.gmail.com>
In-Reply-To: <CAHC9VhT+QUuwH9Dv2PA9vUrx4ovA_HZsJ4ijTMEk9BVE4tLy8g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Jun 2024 15:07:37 -0400
Message-ID: <CAHC9VhSY2NyqTD35H7yb8qJtJF5+1=Z4MHy_ZpP_b7YDT-Mmtw@mail.gmail.com>
Subject: Re: [PATCH v39 01/42] integrity: disassociate ima_filter_rule from security_audit_rule
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, mic@digikod.net, 
	linux-integrity@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 12:50=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> On Fri, Dec 15, 2023 at 5:16=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> >
> > Create real functions for the ima_filter_rule interfaces.
> > These replace #defines that obscure the reuse of audit
> > interfaces. The new functions are put in security.c because
> > they use security module registered hooks that we don't
> > want exported.
> >
> > Acked-by: Paul Moore <paul@paul-moore.com>
> > Reviewed-by: John Johansen <john.johansen@canonical.com>
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > To: Mimi Zohar <zohar@linux.ibm.com>
> > Cc: linux-integrity@vger.kernel.org
> > ---
> >  include/linux/security.h     | 24 ++++++++++++++++++++++++
> >  security/integrity/ima/ima.h | 26 --------------------------
> >  security/security.c          | 21 +++++++++++++++++++++
> >  3 files changed, 45 insertions(+), 26 deletions(-)
>
> Mimi, Roberto, are you both okay if I merge this into the lsm/dev
> branch?  The #define approach taken with the ima_filter_rule_XXX
> macros likely contributed to the recent problem where the build
> problem caused by the new gfp_t parameter was missed during review;
> I'd like to get this into an upstream tree independent of the larger
> stacking effort as I believe it has standalone value.

... and I just realized neither Mimi or Roberto were directly CC'd on
that last email, oops.  Fixed.

> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 750130a7b9dd..4790508818ee 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -2009,6 +2009,30 @@ static inline void security_audit_rule_free(void=
 *lsmrule)
> >  #endif /* CONFIG_SECURITY */
> >  #endif /* CONFIG_AUDIT */
> >
> > +#if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
> > +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmr=
ule);
> > +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)=
;
> > +void ima_filter_rule_free(void *lsmrule);
> > +
> > +#else
> > +
> > +static inline int ima_filter_rule_init(u32 field, u32 op, char *rulest=
r,
> > +                                          void **lsmrule)
> > +{
> > +       return 0;
> > +}
> > +
> > +static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
> > +                                           void *lsmrule)
> > +{
> > +       return 0;
> > +}
> > +
> > +static inline void ima_filter_rule_free(void *lsmrule)
> > +{ }
> > +
> > +#endif /* defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY) */
> > +
> >  #ifdef CONFIG_SECURITYFS
> >
> >  extern struct dentry *securityfs_create_file(const char *name, umode_t=
 mode,
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.=
h
> > index c29db699c996..560d6104de72 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -420,32 +420,6 @@ static inline void ima_free_modsig(struct modsig *=
modsig)
> >  }
> >  #endif /* CONFIG_IMA_APPRAISE_MODSIG */
> >
> > -/* LSM based policy rules require audit */
> > -#ifdef CONFIG_IMA_LSM_RULES
> > -
> > -#define ima_filter_rule_init security_audit_rule_init
> > -#define ima_filter_rule_free security_audit_rule_free
> > -#define ima_filter_rule_match security_audit_rule_match
> > -
> > -#else
> > -
> > -static inline int ima_filter_rule_init(u32 field, u32 op, char *rulest=
r,
> > -                                      void **lsmrule)
> > -{
> > -       return -EINVAL;
> > -}
> > -
> > -static inline void ima_filter_rule_free(void *lsmrule)
> > -{
> > -}
> > -
> > -static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
> > -                                       void *lsmrule)
> > -{
> > -       return -EINVAL;
> > -}
> > -#endif /* CONFIG_IMA_LSM_RULES */
> > -
> >  #ifdef CONFIG_IMA_READ_POLICY
> >  #define        POLICY_FILE_FLAGS       (S_IWUSR | S_IRUSR)
> >  #else
> > diff --git a/security/security.c b/security/security.c
> > index d7b15ea67c3f..8e5379a76369 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -5350,6 +5350,27 @@ int security_audit_rule_match(u32 secid, u32 fie=
ld, u32 op, void *lsmrule)
> >  }
> >  #endif /* CONFIG_AUDIT */
> >
> > +#ifdef CONFIG_IMA_LSM_RULES
> > +/*
> > + * The integrity subsystem uses the same hooks as
> > + * the audit subsystem.
> > + */
> > +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmr=
ule)
> > +{
> > +       return call_int_hook(audit_rule_init, 0, field, op, rulestr, ls=
mrule);
> > +}
> > +
> > +void ima_filter_rule_free(void *lsmrule)
> > +{
> > +       call_void_hook(audit_rule_free, lsmrule);
> > +}
> > +
> > +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
> > +{
> > +       return call_int_hook(audit_rule_match, 0, secid, field, op, lsm=
rule);
> > +}
> > +#endif /* CONFIG_IMA_LSM_RULES */
> > +
> >  #ifdef CONFIG_BPF_SYSCALL
> >  /**
> >   * security_bpf() - Check if the bpf syscall operation is allowed
> > --
> > 2.41.0

--=20
paul-moore.com
