Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340B824468B
	for <linux-security-module@vger.kernel.org>; Fri, 25 Jul 2025 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753462274; cv=none; b=QibwBZKx9F1OhGEWN6sph6crPpLwUJ4L5HczyMB26NafLDbUpasIm8Zn0ay7+o0h6WOoVCje2wVw9Hw2Hg9a2AAmgadW21B/f17N89RGszEec79gaYLCrnZxMPeI15KCP/9xz1Ifjpvc0Qh/ZZr+Gs1BJpoC3i9PtT9iFsoMbw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753462274; c=relaxed/simple;
	bh=sUq90Sh6cl0YhbPvlnrOqL37+dCf0oAyETbneVq/h1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0VATaF1ybab7nDOX9Tiz2nFMs2GoD8qXDIlBSVOO17BPnvCOkvHAY3X8k/oVN8IvWRhutGRNDnVP/cCC0jXnkVQ3mEmcmX8q93eFg85at7M16MmxyGeKATzyJa4uoClD4H5v3l85kqGgQPZ2pMx7DFpCUPu4LlcTPVggWT1tLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Z2Z6akvx; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Z2Z6akvx"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e8dee33b5d8so779517276.0
        for <linux-security-module@vger.kernel.org>; Fri, 25 Jul 2025 09:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753462272; x=1754067072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+TS3X9vskWtrzO1Cy8NLFMGD99SvsurX0COyWC4lWI=;
        b=Z2Z6akvxCs7zsjjGqlwApNHOOVFDG3Z/Wk/9THwVETAk65VYon/mc8Ymll+1shwiO1
         AgQ9Ik4kt3E90I/31RVw9RybXw1ZzQqH6V3Xvpb960WloAfoE12sc8UERkQ7xN734qyS
         k1fNV6Q/jgS8qb3ZjGTbmzWDZoigdeKUI3C3s+OPsvDd3xCEUqVuGHP2Ywva+pv5vsjf
         DTE5b0fexS5iOSkmL/uCW/mHrlKZuD0fdCI0dF5OPIgvw7Ibjiw/LJSPIwzSUO7lThfk
         NWqtu4nkyc8vChpn+PIkMRb6T12bgyWJNK40Jn3kTv+MAgBvgB/PJHS/9oQpuG/W7sed
         14QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753462272; x=1754067072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+TS3X9vskWtrzO1Cy8NLFMGD99SvsurX0COyWC4lWI=;
        b=N5Z9VWs0rU9lPzm0FaTTO9suPzVmRBoozxJ+j1iEHaTXFRpRWogxgFL9nJmWbk8F2/
         qw+wB5BmUT7CBUS5YWeBHJgQoBOGwcBSSD1SLfuhUOXLSeXDPSMwjNT95peP1gVaRlw+
         SK3ZZkQ2zSPvrvXNinUE0xIArIC1nHybrtqEb2iN51cPQAzN+WzVUmSDehulHDxD2a6k
         qMKUtGbGlfWiDZ0GWHkQ3Cd7lcf7E0nWVsfYGmbUfM6UnfuIBaIeejsFGiDQh9P+VwEJ
         03DvNoybtrdBcUC8ZFIPrBAwTg/iimS/ax5trPQ8hy1q0uQx0eZvVCn/Atq/iQyMET0+
         R6Iw==
X-Gm-Message-State: AOJu0YxD+OVFczZtrsuGVGrDR9wxi1kAwNEqoA/HLduhyqUW+wGQ1iWc
	3qfLgntGeCit7QAGikzQQxtTXiUMEFKNLVJpIP8KR4ayaTB8aVIiVwTYPEz41zpu9tV255ND5nF
	AMxygOUtdcEDSBI/ObQoW7GoqZ/yAhqWi3SQwcmu2
X-Gm-Gg: ASbGnct393UmrjqOrMn4I0ltK8IpA43/aj8IcYcQlrM2SzUmh1Za9C4DgANafEMR46Q
	DYrsu2YVVO4f/mY2ZEPCw1r+E2qY0gJqkLtqIb+RJh/6oWpEtm4YhmlVHNbKgTRQIREfJV9CBWk
	8Vy3biBAjZ+fx0d8WQbNfXnDpGBcWQyz20eR2R451Zqr9k5BPu2Vr7kVi7PTWlkJP5VIywaiVtA
	/BptdE=
X-Google-Smtp-Source: AGHT+IHIMUcpn26HcyO0g3+tumAw+yRrAoF1TB10X+w5SEyTELp5aINmD8gCkp03hjGDmEB3Xc56OmNEC7+ABlOi7z8=
X-Received: by 2002:a05:6902:c0f:b0:e8b:d37b:86fa with SMTP id
 3f1490d57ef6-e8df121068emr2599450276.37.1753462272003; Fri, 25 Jul 2025
 09:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721232142.77224-36-paul@paul-moore.com> <20250721232142.77224-66-paul@paul-moore.com>
 <3101077d-a5e2-d08b-03c2-2ed064a35b54@huaweicloud.com>
In-Reply-To: <3101077d-a5e2-d08b-03c2-2ed064a35b54@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 25 Jul 2025 12:51:00 -0400
X-Gm-Features: Ac12FXyb2UHoFwiiWMxd4QzB2ubVseAs_bHPNy40Qx4LAoNpddjuNEjTQFYhh_o
Message-ID: <CAHC9VhR_24Zv7u0Btz8pSk420Totnx2uRyVdoHU1tXevWKw5mA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 30/34] lockdown: move initcalls to the LSM framework
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 4:12=E2=80=AFAM Xiu Jianfeng
<xiujianfeng@huaweicloud.com> wrote:
> On 2025/7/22 7:21, Paul Moore wrote:
> > Reviewed-by: Kees Cook <kees@kernel.org>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Reviewed-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Thank you for reviewing this patch.  As you are a Lockdown maintainer,
can I change your reviewed-by into an acked-by tag?

> > ---
> >  security/lockdown/lockdown.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.=
c
> > index 4813f168ff93..8d46886d2cca 100644
> > --- a/security/lockdown/lockdown.c
> > +++ b/security/lockdown/lockdown.c
> > @@ -161,8 +161,6 @@ static int __init lockdown_secfs_init(void)
> >       return PTR_ERR_OR_ZERO(dentry);
> >  }
> >
> > -core_initcall(lockdown_secfs_init);
> > -
> >  #ifdef CONFIG_SECURITY_LOCKDOWN_LSM_EARLY
> >  DEFINE_EARLY_LSM(lockdown) =3D {
> >  #else
> > @@ -170,4 +168,5 @@ DEFINE_LSM(lockdown) =3D {
> >  #endif
> >       .id =3D &lockdown_lsmid,
> >       .init =3D lockdown_lsm_init,
> > +     .initcall_core =3D lockdown_secfs_init,
> >  };

--=20
paul-moore.com
