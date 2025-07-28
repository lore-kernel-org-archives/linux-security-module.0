Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ADC2248A5
	for <linux-security-module@vger.kernel.org>; Mon, 28 Jul 2025 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753742055; cv=none; b=hf4K3tY1Bi13ikqKHZW3VwRQGho4CJ9ag4DSuOZXLfWpQj7J02DTBc3nhVkfPus75aMLG+CFzFPx+3NisSgSzgdeZJAKM4xMPSnPlvfd+KrSrIAnuojvtCx9dbYKETpa3Z20uSxuxNvXWEJtFDeKNohcMjBurwyvjGj9fLusZIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753742055; c=relaxed/simple;
	bh=sPZcX5ETkRkiJ/sMnu035foPVHqPhbI57EiOWs7UoFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbM+IKuZJXNY5+03rbtsWpJXtNGnDAQQ3hk/BUPwbbe8/OF2qaP/v758PaL0r7VjjWf+VaftMw+sfVpQ2FPwVQdFmVw75z5Z1BRpPr3DQwkOxgbihVcpYtu9Nv8R/Ty9dgNF2fno53JZJ+2QLhjZg9S6HHuPl+olt5rHjLG+taw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BAQQVvjo; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BAQQVvjo"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e8e22a585bdso573278276.0
        for <linux-security-module@vger.kernel.org>; Mon, 28 Jul 2025 15:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753742052; x=1754346852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxvcUsNhJgTxupj821AHIcY8DElHclblBesN4OnHvqU=;
        b=BAQQVvjo4+r/Rzygo5DaWFjibtyvfNSBEIAvOD2YZAmRfCJgAeN5d92QtGcXCTMZB+
         uROPtj6URai/NAWG0JQSDJDQLGtA/et4nx9Vmn1jy55XccfERZE3BxWO11q4W7KYJnuN
         J+1g2FtiLFdLd16/YPnjLc8qB5rcFiVfcv14s64asdDcqEtQfg/puNFTDHhq4w43Ti4d
         P3f+M61dufnh4xi9zO/owE/+pAfi8HczuCxx1lAm+Mh84WJAGTWHFRvT7X90xCQRSJFi
         e1aPWQ2hOEZfzFcasZtid7+FQM8Hl1RBolkDguYNj2FeKSsQqULgt5oiwkYmQBDinJo0
         ZJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753742052; x=1754346852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxvcUsNhJgTxupj821AHIcY8DElHclblBesN4OnHvqU=;
        b=elLdEYvNC7elmxomPC5UpgijUw4h4ST4ozmz5m84qwNjDmZqbNaU/s6FiEET4yP6qg
         3k3dzhDatNCI9YSZityZ0vmoBdTjlTidvbWKVcEmJ5E2MU2zvjc9SNxCoTCZJrn9zUVC
         7ov+v456a+TCTXGdCpenKdaHhgS84ExRbs+L7TT9nVXUACcaNSImy1/3uj+YGhNiyOwg
         fzi+2Re6qI3sZrAnIRv6YAHE6pzNKdaIp+67RHV6DrzY2pMW93Zcf6A/n4skQD2HpxHz
         iyOYbZ4hYrLgUUS10M3rFyy6QrRq+gXATWPsgDoKWYmw7AEMbKIu6R54XOdo78etsncj
         3jlg==
X-Gm-Message-State: AOJu0YyWc3t4zYy/BYrWFvxiPpdx7rEOHgFG2gxg6q85gdOaJO7DNemx
	DGdphGiT8f8pp5PFCS7/usagxo/DoVv4UuUvEwabVdrmtaS8VS++Y+BBVLuj0Qs8k2VjwCECgpe
	fms2FHq44Hdi9obwGKqCooA6dK45/6EsZQhdrkaqi
X-Gm-Gg: ASbGncuk1Dvwsp5RuCWj6K8gsNcS96l99GB2N4ciqwsA7OSCyOBFMY9VSkzdnSrgdKk
	Tv8nmtjZtQctR4qB+7i2rIwd4UDDCRh6tBKk3qgUjiNJyCSQQcsJh17BdYnttipsjBSP2fYoO2+
	QkzVK0S8cc53MAk8Pn48nuiYwCwsW+MqQpf5cPMdVHNa7rICPuidCP15S0+KsGxR98fPyseCr07
	lfSSu8=
X-Google-Smtp-Source: AGHT+IFL3W4827GDMXMSQDjasWXwEUHowvOtptVCyqMAy54udRGPNZxYAyTwlijvBSOV3qH587CqZUfiWhf0PRqfd18=
X-Received: by 2002:a05:6902:1704:b0:e8e:219f:a662 with SMTP id
 3f1490d57ef6-e8e219faa10mr3054599276.26.1753742051862; Mon, 28 Jul 2025
 15:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721232142.77224-36-paul@paul-moore.com> <20250721232142.77224-62-paul@paul-moore.com>
 <5ff016adea8969e4a97387d4ed88a172bdc4b3de.camel@huaweicloud.com>
In-Reply-To: <5ff016adea8969e4a97387d4ed88a172bdc4b3de.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 28 Jul 2025 18:34:00 -0400
X-Gm-Features: Ac12FXzQAYGZ-9s23WBgAfhFxpylH2DbTwTSk8I658l0CgcFmUXiJS_noueOtGo
Message-ID: <CAHC9VhTh1=Qh2_4YKsXyC8dT6BFyh3nVbhfexLFsAWh7wiUCjg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 26/34] smack: move initcalls to the LSM framework
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 5:46=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Mon, 2025-07-21 at 19:21 -0400, Paul Moore wrote:
> > As the LSM framework only supports one LSM initcall callback for each
> > initcall type, the init_smk_fs() and smack_nf_ip_init() functions were
> > wrapped with a new function, smack_initcall() that is registered with
> > the LSM framework.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/smack/smack.h           | 7 +++++++
> >  security/smack/smack_lsm.c       | 9 +++++++++
> >  security/smack/smack_netfilter.c | 4 +---
> >  security/smack/smackfs.c         | 4 +---
> >  4 files changed, 18 insertions(+), 6 deletions(-)
> >
> > diff --git a/security/smack/smack.h b/security/smack/smack.h
> > index bf6a6ed3946c..885a2f2929fd 100644
> > --- a/security/smack/smack.h
> > +++ b/security/smack/smack.h
> > @@ -275,6 +275,13 @@ struct smk_audit_info {
> >  #endif
> >  };
> >
> > +/*
> > + * Initialization
> > + */
> > +int init_smk_fs(void);
> > +int smack_nf_ip_init(void);
>
> I made the following changes (due to not having
> CONFIG_SECURITY_SMACK_NETFILTER) ...

Nice catch, thanks Roberto!

I made a slight change to use the defined(SMACK_NETFILTER) macro as
done elsewhere in the Smack code, but otherwise it looks good to me.
Casey, are you okay with this?

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 885a2f2929fd..3662d61bb32e 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -278,8 +278,15 @@ struct smk_audit_info {
/*
 * Initialization
 */
-int init_smk_fs(void);
+#if defined(CONFIG_SECURITY_SMACK_NETFILTER)
int smack_nf_ip_init(void);
+#else
+static inline int smack_nf_ip_init(void);
+{
+       return 0;
+}
+#endif
+int init_smk_fs(void);
int smack_initcall(void);

--=20
paul-moore.com
