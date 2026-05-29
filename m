Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612FE3F20EF
	for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080904; cv=pass; b=XE+IjWO+TXodxFlJE//JjA4xYmFXdqpAho2NhlCLWi3wC1aNwG6tArTzcdmGsUMq2CDL0Dzl1dsPWujD/qeOAxh8C0niJmgjUY7kGd+mcDRKnmpcMpW20TojbhXt9oqGhbBOUx/0Y0Cm03XboqOPbsJ9WK3ughV5pQ7Hg8nDGKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080904; c=relaxed/simple;
	bh=cTXlDf9jOALiAn1emZFOKYMHNYXoVW69uOSJhAaBdDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHUFchdIu/4JPq5EdJMctSK5J0Uai1PNvWS8AsNjuv5P1rtxZU/y0QdPMdQTc09scO6G7IJEoxLAJf35raRlSnPNv3jxwAG3ES2vPjkGtFMIJjlaYBqQQcV/Y//wpCAs/5S/aMNfQEQ7vsFaveiVXEGrjBf48nMAFXHa8WerK6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b1/6DCHv; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b1/6DCHv"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36baec934b6so801921a91.0
        for <linux-security-module@vger.kernel.org>; Fri, 29 May 2026 11:55:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780080900; cv=none;
        d=google.com; s=arc-20240605;
        b=NLWqOtkU/4qJBQTqCVjiE0pgSSrx4I7fbiMosmrjsxoURIvUY/wMZC02hJbrSL73XB
         OLswEqHyQMSgHYXn1okki6Oae5usJYL1qbKYGuOLsgZSNG3nDf91TPzcAbuyjlpaN3YZ
         92UmaLf951SvaiBJKLqDZrwgUiiZrX93Bbfq57LJpYsy3rD3lkf4+/uhLztHsQ5C+2qw
         mosEyzNjdqExiGfgjj4yjtaL5DhpqbT+8lRtpVmgARfc1MI6svaQigF+T2LdepjFMYju
         UCmQxwaXJMO5B1phnIQyQvlkIyuiDwe0xPHVbRbU/HLH08DpIOhAbIMNDEVO9CDgvh16
         fwuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cTXlDf9jOALiAn1emZFOKYMHNYXoVW69uOSJhAaBdDM=;
        fh=ROMvVfbZEuNx7Ispo3UU2hlvrHthaxtT3DKCBD8sxGE=;
        b=bIoa5qA+bv/9Frfd4003cq14oGj+H2N/W+GUNi31PAm9AeO9grsHGS4acCU1hdhQE8
         t1OM7XJzMPj6qXSRgjyewrD8ECjCRK7Gg+q42jGyL7zjqUdMPu19eToUcJLQZ3LtszEx
         IrZtesneIUqD1iIMxH02ig27BeaTzbiiYo2zjjbf3vEdDAni/FobbIzvuJ+xYNzFbLDe
         P+x3HMyl7fyVexTvKEXVLDe/JOJs0I6XDKEELwdeCUvF+f+TWF9kskMR/44O+Tds6xVY
         S7pcIpy0J09Nid4puNkVlP1LHHQnHKhJwTZJ0ytl0llovzJkqkJ5J5u4fENAUUxlN7+H
         St5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780080900; x=1780685700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTXlDf9jOALiAn1emZFOKYMHNYXoVW69uOSJhAaBdDM=;
        b=b1/6DCHvcOarhTjWWPLLUIrKu96zL6IRSpUw6d6E0ukGWxkuQvyCk5xGNNtLqsZFFL
         PWObLCf0dmV47iJD/Ai0hBd2JBzQ/Il/MwuZTAkCuMt+/wb4B+OqpyJq6KuPmJyf3ZIO
         FqD2KOdAPDbkKmBwewOb9vW12Lw/v+sHtvsMEOzLATLLP1rBGjm5e3PwyuCErk8i45lj
         +U00S9JV4xgoyrWdzQurOeVuoFvJpodOI+JvPr4gHAOIgnl0uwfFpsf0qo12IZ4diLla
         JfGRYABOug/fJccRjAlHxeIYtKa/tTB85MAIzZo6E5gbQ1q/F3g7Url+odsdP4xv9Z3u
         Rp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780080900; x=1780685700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cTXlDf9jOALiAn1emZFOKYMHNYXoVW69uOSJhAaBdDM=;
        b=bNgejI1GBhFfPZWDhvnc1Oe/5jvyHbMXwouKdVYlWyPmLnm1s4eFBfcXpEmxuQ7xjt
         vv0zuhfOIFtUJVMd8rPPb2zINdpMhhkUXT30MnKgss1Hui7Av3vrrsOHVREw/b8grPGM
         tTWMHkUfzbJLNT/m6Z18SZ+XtT0nb8Q4dLgewHHtMC420w5bfNeUDfW0dwuNh+hwFtSs
         fbgPZpcahCwZ32JIPvm0AZ/TXqKvG3S1pjOHqvnUHxMjLgVaVwUMgvDzmePkLFqVAPB8
         XicQLRJeErRfsT8FED3CnQS3OXqf7n7NQFf8xQH5Wwffzj5Ms8p5FcwRznGtDmBXhOSC
         vTEA==
X-Forwarded-Encrypted: i=1; AFNElJ+NbgOnGnKMluH3sz9X9M6WHj66+b3QB9atqNUNHNRJGXM3aTlf1+QY/Z6/sg7MfeCU9i2DunLFqvYrNyrFA8a6n1uLRns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKvwDD5dRjpgdNIhgBEde0msmxAF9kF+V+AmfkYQa6ZuHSrxXb
	sLgJgcwjLu8/1IkM37tnL2Vds6+5ck5KtJLHjSK1CBTrDMMUtSO8tACoRkxCrxphcB1xIh9I498
	ewqrQ45AypJRhLts5tGqEYEuR/HTrAn/N3pE3uhws
X-Gm-Gg: Acq92OG/8fxR2vLxnayZSvV8nsA05ODQwturDMcMxGGG9pPvjuzp3emOzDuJDOGjX8H
	AnqpN/qRxfeRcO5KwtrUBmX7bf7xUWdRa84y76KBgeNMTiYI/XqdoUAzkF0Ro1LNA/eRqk4Wk31
	O3bw/v/IEIlDFP6Y0jW/9vpEp6XcrJbsA/lXsLo9iKAUbeO548LypvZ5am0gXbJaohhXO9j0YIX
	CFnSFKT3IhF8TaZ4Y7crwI2KoGYvpIBF1Z7W1+b09j0ZhelTM/HyAADPFZXJzAiYA21ur0vaOYw
	wUTbJSNhdFRSfWgDqA==
X-Received: by 2002:a17:90b:2cc6:b0:369:e9a2:6b with SMTP id
 98e67ed59e1d1-36beb5d69d4mr501933a91.13.1780080900476; Fri, 29 May 2026
 11:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com>
 <20260528030915.2654994-6-bboscaccy@linux.microsoft.com> <CAHC9VhR6G5qmd3kXPas_L_SiJx=6J=wUw80xxL9Eu4=tSjMAoQ@mail.gmail.com>
 <87tsrqxfdc.fsf@microsoft.com>
In-Reply-To: <87tsrqxfdc.fsf@microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 29 May 2026 14:54:47 -0400
X-Gm-Features: AVHnY4KV6D6YvRHanQxEbvDpCbql19hyTKeLutgK-EPgQAJGsY29ejnHS07L2Is
Message-ID: <CAHC9VhRmf6=ffJ8tgWTP_mamTYXbp-__w92r4i-FMcchGzkGdA@mail.gmail.com>
Subject: Re: [PATCH 05/11] hornet: gen_sig: fix off-by-one check for used maps
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Biggers <ebiggers@kernel.org>, 
	Fan Wu <wufan@kernel.org>, James.Bottomley@hansenpartnership.com, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 2:03=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
>
> > On Wed, May 27, 2026 at 11:09=E2=80=AFPM Blaise Boscaccy
> > <bboscaccy@linux.microsoft.com> wrote:
> >>
> >> A logic bug limited the maximum number of used maps to
> >> MAX_USED_MAPS-1.
> >
> > Should this be MAX_HASHES-1 and not MAX_USED_MAPS-1?
>
> Good eye. Yes that should be MAX_HASHES-1 in the commit message.

Okay, I'll fix that up when merging.

--=20
paul-moore.com
