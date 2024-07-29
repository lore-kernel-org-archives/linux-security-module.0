Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D11187350
	for <linux-security-module@vger.kernel.org>; Mon, 29 Jul 2024 21:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287976; cv=none; b=p8+kxe1hJhZ9e3ybuVXmuTS5TQdXI8n9GLx1TapF3DCy2+ieiV2woKPXUIbC8mrbaHiZYOOKars9XOvJkC/rOMme3IRjhjKDGOEovqCa4QkoDppmf0F/0po2TzEVVY70HlkxXRh70iTQkGjhTrKFiRf2WmnN+BSujhPvjEXSC5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287976; c=relaxed/simple;
	bh=4l+Bvtu4kvAUQXF6bJmvFTVCWVJV5gtAA53iOAelmP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGOiSbuKEig5AOUzA4kijVKkYCi4TJymB/Xxs05I8ffnCxBoG0qDNzGtDPrgXOPpJ5OwNYiYvmp/VTg/CCDIzJ8XexfWWEfYTOIR4hOTucUIEmaWJJM7g1vqX1ZEtBqa/sP2LMAXRK34Goy8C+uBb3csyPwJZ+XrJyhbaGAo0ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HDy+iDNw; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HDy+iDNw"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e087c7ef68bso2135231276.3
        for <linux-security-module@vger.kernel.org>; Mon, 29 Jul 2024 14:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722287972; x=1722892772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57KneJBJmxhIzkyiS8eBkpjOJsC+T980EDeLPEhnb1M=;
        b=HDy+iDNwXnKWRnm2oi89ppaqq1WBU/W8NHRB3MecEBB++3S8XLWeCVRRBXJu6ZymFc
         kraHJU858TtSyMNSZhdFmG+v8zEVSnehbeLdg1yjYmXYMMZk6ZeM3+zdZ60Gmp0TBgTA
         lPEzeqidGX1tX55itKEd1UK0o+FmDCXzEBsmBJLFqcvd7FxhMVi+OHc/TVp/L1Uq9GgJ
         qj1pGjQB4QshvPH2JIvxyh+a1ksMB6z39bgQcfPicqD+xseYkrUICxvpQNX95+nefWFm
         HOT/KaLG6FaC87gHxwlgOedQdxhcedGAte4BRO5/ljldPH6+QisohmVmErWS8vY6dmzT
         e05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722287972; x=1722892772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57KneJBJmxhIzkyiS8eBkpjOJsC+T980EDeLPEhnb1M=;
        b=n2QnVh8WEt9iQwz1HP3+wt+3IZdECrQR2SEAS0/Vu8AM/MftI569McD6rC81xoJw/U
         n16ov3pvrUG495VV5vFK4cJI/zA4favopqsybYxHynIK3Ti4DpkieQlL9cqniP7rnOqJ
         HsdKC4TiHKQG2paU52wiuEPl4AZohbZiMOIdSaKI5nf9/dSKf88+6HPtlcVXgRgcA3vt
         2KTtFkPdgsoXHF657cD8hedq13B6aaXfUXeTSndoVcu6tBD3y6l6avpM+p1oUJUBCU04
         w25WXYw5BdDRtpPUrZf1Q3bIPJMFoVG8eAZFBdpm5Ya+3YCLrY/ndHiSRoE8GOyyIC9L
         e1Eg==
X-Forwarded-Encrypted: i=1; AJvYcCU3T2ZKpAKO/OIBmiu4txfEQggvPG3P6OJw8f4G4TWuthuQrXwj3qnemsZd8Jv4/KMStXK//PalIKgIxHV6jO+LFOW0Cu9H1vKF7+bhEweTfFHeuhpn
X-Gm-Message-State: AOJu0Yx1rVPZipFf/FYlpGcssJf8dXm2h765/6OetmHyEbE9U+eeewfB
	AQ5IDsgfYbsYOJi4QZmWaNzJJoCt8wsCOVVlPyBppjFMceu11o965MS6BgT04KwaDGS2gYDlkaT
	t032olGYlfLz8E5QGbMyu8oTn5pon7eGt6dvR
X-Google-Smtp-Source: AGHT+IEMYEefrecGsvRSsfMyzdAwa3txRnjT2iryrdAee4DsCtHHJC+M0YAgZrPzcXwWtUyTuUJITsqdBLLjWYrTI3Y=
X-Received: by 2002:a05:6902:1b05:b0:e03:4607:10ff with SMTP id
 3f1490d57ef6-e0b5459dd6cmr8373357276.42.1722287972381; Mon, 29 Jul 2024
 14:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724020659.120353-1-xukuohai@huaweicloud.com>
 <26bb0c7b-e241-4239-8933-349115f3afdb@schaufler-ca.com> <CAHC9VhTfqhWe9g5Tfzqn2e2S8U3JrCJ2zjjgKKJF0La+ehwAaQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTfqhWe9g5Tfzqn2e2S8U3JrCJ2zjjgKKJF0La+ehwAaQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 29 Jul 2024 17:19:21 -0400
Message-ID: <CAHC9VhSF97=CaZw1YHMgP+Vqu_C21KgqSu=zXRnX-3kkvEFJzA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Refactor return value of two lsm hooks
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-integrity@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, James Morris <jmorris@namei.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Wed, Jul 24, 2024 at 4:36=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> > On 7/23/2024 7:06 PM, Xu Kuohai wrote:
> > > From: Xu Kuohai <xukuohai@huawei.com>
> > >
> > > The BPF LSM program may cause a kernel panic if it returns an
> > > unexpected value, such as a positive value on the hook
> > > file_alloc_security.
> > >
> > > To fix it, series [1] refactored the LSM hook return values and
> > > added BPF return value checks.
> > >
> > > [1] used two methods to refactor hook return values:
> > >
> > > - converting positive return value to negative error code
> > >
> > > - adding additional output parameter to store odd return values
> > >
> > > Based on discussion in [1], only two hooks refactored with the
> > > second method may be acceptable. Since the second method requires
> > > extra work on BPF side to ensure that the output parameter is
> > > set properly, the extra work does not seem worthwhile for just
> > > two hooks. So this series includes only the two patches refactored
> > > with the first method.
> > >
> > > Changes to [1]:
> > > - Drop unnecessary patches
> > > - Rebase
> > > - Remove redundant comments in the inode_copy_up_xattr patch
> > >
> > > [1] https://lore.kernel.org/bpf/20240711111908.3817636-1-xukuohai@hua=
weicloud.com
> > >     https://lore.kernel.org/bpf/20240711113828.3818398-1-xukuohai@hua=
weicloud.com
> > >
> > > Xu Kuohai (2):
> > >   lsm: Refactor return value of LSM hook vm_enough_memory
> > >   lsm: Refactor return value of LSM hook inode_copy_up_xattr
> >
> > For the series:
> > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
>
> Looks good to me too.  I'm going to merge this into lsm/dev-staging
> for testing with the expectation that I'll move them over to lsm/dev
> once the merge window closes.

These patches are now lsm/dev, thanks again for your help on this patchset.

--=20
paul-moore.com
