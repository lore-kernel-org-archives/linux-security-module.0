Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B691531EF;
	Fri, 24 Jan 2025 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734865; cv=none; b=Ps7twQXZ9KVJlGaKtcuoJHW3EVt5/PXjNQIvq+zYjbCwtGBO9/k4v0x6ZhG2nnL9nIaYsR9jZOfszojtvm4o1q5W7pMCRmPgTvbaVMt8Uffo7Sxuj9+Ml77woJ54OeJJ7TPvWnbF32pDxrCvLjGJ0OaPGnVUuWgzFlBio6hLaMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734865; c=relaxed/simple;
	bh=g4NGRp2JK1a9Y8MIqE+tA/pn0jpkIlGpSoKuhH2+DOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9y+5D/ucYnRh1PFVlhTrtPieuSSzTzjDPncMy55DgSaqs4GTWAbAAwScPq6+tRPCjVs1SviULvh/yz0LC2dWU46eFPd59afZcId9lFw+ICBH+ch92Wo1HTc2brrMwNX2cGiWEslTN95zOkd8PyVAI9quFILpOwmQ/eWTCtlozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MM0kInj/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MM0kInj/"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21649a7bcdcso40273485ad.1;
        Fri, 24 Jan 2025 08:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737734863; x=1738339663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WpretIUbe+N1ajHsDsF0qfHmm4BZye7plmY0f0kbz0=;
        b=MM0kInj/zqAClj6a+xpTEtXdc2q7E3B1hnhc/adZNwLN88YO/aRy+kL2yuCPipygfk
         pLTMsFuid8EsoOCdHGtaT3hV93heoDmV0yqjdiCmySeD/z9P7lsmXcFTOTyukyS2+F9W
         r7Xk2IbcxcZ96DnI1sXrKOPfluTgB2ZqPiu1LAqPBm5hSUt2urXkPz3uiBMbdWHdf1yy
         Cn89CVb4Jel7eJiLi2Ent/UfBiw/8QYmbFfKJ90+rICQqRjIEZnLu9NBIELov/U+nWYU
         2Ej791U1DUvorghlxyJjSqC5TRlI4mgr9Svt7MPNxpwx9BFKqZgafgp8Su87bUffTHJK
         NG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737734863; x=1738339663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WpretIUbe+N1ajHsDsF0qfHmm4BZye7plmY0f0kbz0=;
        b=XtsOS8EHQkzn9IDN/9Em9Wat0doax+0p12xaNd7B7HbBg6AjUVP+noGPiGl7eEPiTu
         KMN2tg9gWFsk+pAN0bpMNOx4wXxuMeJeJWouCtRVwbJJR7B1j+Ve7irk6E52j9OJ8X9b
         jIexf7q99ljZJ0uV6otJG8+OUtGTO9lnRXcNAnZflCV6TXrDhEccqCToxvn1oHE7zjoI
         brvcMh88WTOqobJhdScZwy3UyX/qAK1A4XNYty1PtDKAbajO5M76nbHwxHC9bqk2LWCz
         0xIjb+3zBrrAfVNA+CepfTOMafUS+PIXvD3YDO3yCZhALIbnDVUUv6cG1Hpq+vQa1R37
         efqA==
X-Forwarded-Encrypted: i=1; AJvYcCWgTfuz8HjboEIPky3TbAj9QBuRtczTPLhiToCRe4nLx0FY+Wq2Hnz+SCkhq+hySmb0cDBb+VM0cPbEVbc=@vger.kernel.org, AJvYcCXSoqYL8SEdCM7lPKiYcbWjNfLbI5CE0P0d6/+eY0mTQGoeRN3KXuCvqgJKUUcfbZFNeCzB5yhTmnVuYbCh6noOXYQGHjPB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7FbWhxvGzbB7xGddtGEjFJ4Mx/19H0mejpss2pRduyd2q8nN/
	E9SBvgBYn4Aqu0oJmZ2ep2g7XuSNqekI8irnu9c+uqIEuVjeIdMNivsIey1qbU8kdh5gpEw+wBe
	jR0ySk4Q7v/Vv2CyTSYiwFkkAiKg=
X-Gm-Gg: ASbGncv871CvrIBVu7GGxFef1qRyMjr7ug8AGnPu0dQSQoXauiaqgMWaKRT3+SuYk6i
	Hy8xY1/OghgYwvMj6zaSjF6Dahuv7T6NQ+5YZNnVrOxvSuJQ4gVwCWBVuOl4DnR0O2dW6jIPr6/
	Avg5JW1/HT9sqco0uXIs/z
X-Google-Smtp-Source: AGHT+IHRuyYi0fyuZvfzBJc/qeWNZE0WgiCT96iizYvpIxqdAsEv05LWV4HDJBTUNgdUJmyqbOP9kTIDBwpx1s+xLe8=
X-Received: by 2002:a17:902:f645:b0:215:6426:30a5 with SMTP id
 d9443c01a7336-21c355cdd75mr526928105ad.40.1737734863024; Fri, 24 Jan 2025
 08:07:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123194455.2710-1-tanyaagarwal25699@gmail.com> <6ff03d09-104f-4148-822d-b488eca98b86@schaufler-ca.com>
In-Reply-To: <6ff03d09-104f-4148-822d-b488eca98b86@schaufler-ca.com>
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Date: Fri, 24 Jan 2025 21:37:28 +0530
X-Gm-Features: AWEUYZnzBQEtqbHyVMCDQtd1KyryD30JQ389RefYgyDaonHrC69YU6tkbm7YDbY
Message-ID: <CAPdGtUy_GDoGQ-qJyc8G9vdA2qYeEOm415mOC83gPp3HH7KS3w@mail.gmail.com>
Subject: Re: [PATCH] security: smack: fix typos and spelling errors
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: zohar@linux.ibm.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	anupnewsmail@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 3:06=E2=80=AFAM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 1/23/2025 11:44 AM, Tanya Agarwal wrote:
> > From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> >
> > Fix typos and spelling errors in security/smack module comments that we=
re
> > identified using the codespell tool.
> > No functional changes - documentation only.
> >
> > Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>
>
> Thank you. I will take this in through the Smack tree.

Thanks, Casey.

Regards,
Tanya

>
> > ---
> > Original discussion:
> > https://lore.kernel.org/all/20250112072925.1774-1-tanyaagarwal25699@gma=
il.com
> >
> > This patch set is split into individual patches for each LSM
> > to facilitate easier review by respective maintainers.
> >
> >  security/smack/smack.h        | 2 +-
> >  security/smack/smack_access.c | 4 ++--
> >  security/smack/smack_lsm.c    | 6 +++---
> >  security/smack/smackfs.c      | 2 +-
> >  4 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/security/smack/smack.h b/security/smack/smack.h
> > index dbf8d7226eb5..ca38e145f364 100644
> > --- a/security/smack/smack.h
> > +++ b/security/smack/smack.h
> > @@ -42,7 +42,7 @@
> >
> >  /*
> >   * This is the repository for labels seen so that it is
> > - * not necessary to keep allocating tiny chuncks of memory
> > + * not necessary to keep allocating tiny chunks of memory
> >   * and so that they can be shared.
> >   *
> >   * Labels are never modified in place. Anytime a label
> > diff --git a/security/smack/smack_access.c b/security/smack/smack_acces=
s.c
> > index 585e5e35710b..5c17aee5dd78 100644
> > --- a/security/smack/smack_access.c
> > +++ b/security/smack/smack_access.c
> > @@ -242,7 +242,7 @@ int smk_tskacc(struct task_smack *tsp, struct smack=
_known *obj_known,
> >       }
> >
> >       /*
> > -      * Allow for priviliged to override policy.
> > +      * Allow for privileged to override policy.
> >        */
> >       if (rc !=3D 0 && smack_privileged(CAP_MAC_OVERRIDE))
> >               rc =3D 0;
> > @@ -277,7 +277,7 @@ int smk_curacc(struct smack_known *obj_known,
> >
> >  #ifdef CONFIG_AUDIT
> >  /**
> > - * smack_str_from_perm : helper to transalate an int to a
> > + * smack_str_from_perm : helper to translate an int to a
> >   * readable string
> >   * @string : the string to fill
> >   * @access : the int
> > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > index 0c476282e279..85ec288eefe7 100644
> > --- a/security/smack/smack_lsm.c
> > +++ b/security/smack/smack_lsm.c
> > @@ -1950,7 +1950,7 @@ static int smack_file_send_sigiotask(struct task_=
struct *tsk,
> >        */
> >       file =3D fown->file;
> >
> > -     /* we don't log here as rc can be overriden */
> > +     /* we don't log here as rc can be overridden */
> >       blob =3D smack_file(file);
> >       skp =3D *blob;
> >       rc =3D smk_access(skp, tkp, MAY_DELIVER, NULL);
> > @@ -4211,7 +4211,7 @@ static int smack_socket_sock_rcv_skb(struct sock =
*sk, struct sk_buff *skb)
> >               /*
> >                * Receiving a packet requires that the other end
> >                * be able to write here. Read access is not required.
> > -              * This is the simplist possible security model
> > +              * This is the simplest possible security model
> >                * for networking.
> >                */
> >               rc =3D smk_access(skp, ssp->smk_in, MAY_WRITE, &ad);
> > @@ -4717,7 +4717,7 @@ static int smack_post_notification(const struct c=
red *w_cred,
> >   * @gfp: type of the memory for the allocation
> >   *
> >   * Prepare to audit cases where (@field @op @rulestr) is true.
> > - * The label to be audited is created if necessay.
> > + * The label to be audited is created if necessary.
> >   */
> >  static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, voi=
d **vrule,
> >                                gfp_t gfp)
> > diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> > index 1401412fd794..432e2d094e35 100644
> > --- a/security/smack/smackfs.c
> > +++ b/security/smack/smackfs.c
> > @@ -165,7 +165,7 @@ static int smk_cipso_doi_value =3D SMACK_CIPSO_DOI_=
DEFAULT;
> >  #define SMK_LOADLEN  (SMK_LABELLEN + SMK_LABELLEN + SMK_ACCESSLEN)
> >
> >  /*
> > - * Stricly for CIPSO level manipulation.
> > + * Strictly for CIPSO level manipulation.
> >   * Set the category bit number in a smack label sized buffer.
> >   */
> >  static inline void smack_catset_bit(unsigned int cat, char *catsetp)
