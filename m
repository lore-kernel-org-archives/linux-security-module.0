Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247181741E4
	for <linux-security-module@vger.kernel.org>; Tue, 18 Jun 2024 23:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718752868; cv=none; b=DLrC1TnwyGPu7qI+UKa1vxYEhPFYJR5WuUn3mCZnERyH2VOrN6XK+d/8UOKcaA8F3MQKnPqI9lRpr5UTZjcOEbMbSFG2F7Noj8EigGIDrFZ7FTBtcv32alqdQxlmXKJpwk39tsvMi4ZTbK194Tp7SJk8on2wrtu11YV+LQeDwEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718752868; c=relaxed/simple;
	bh=+wBaHcSHdnhQBl8EAcG7ho1hpPuCnLLSfcZ0pIqfHgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPybAeZzvB3eb7WDqGtQ2rMIz1DP03m64zF++x3LS3zw3fm9zuHJO/TRUJp9zbewJXrK+siDHPpNIss+vLQwqLrNPn0fr1/QxmiSKgWRSaYsk15BqGMG+MSqBoiNaY9IYeov37KivPjmi5wMrrY1gtan3rsrUAtdSBL3D758/EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VHXKe04i; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VHXKe04i"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dff0c685371so5366045276.2
        for <linux-security-module@vger.kernel.org>; Tue, 18 Jun 2024 16:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718752865; x=1719357665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiWmKBBXMD92k+n8gcYpFFSycdOAu2SpOI6WWatC5Kk=;
        b=VHXKe04iraEG7NjRob04gdnjbBXlnFM5zTplppcLsKu1UTT8C8oov8s/ITVDrOmffK
         4PhUZ8F6CzR3GV0dd39sieKEvd9pKWXqQAwL0h0PdfO9Yp/6U4jXm6eDtPfAyCHn5CQs
         6hHEPx//jTvajGqYsj4g4FjDg+LFTx3OGb4p2hn70i2wUz1ukM8XBgYsgFJM0Sdy2Z3n
         zL+ApmJdpfnJFfsRaxT9mC5r8zeMLoTmz3DMgGVctQsqy4FCid2vXVaIqgV1+MfEb9ll
         8hr3UkuA9pfpUuyqHwOFFE9oD9LD1ScTdd6BXXI5cGJOxqCcu30PxIjlGW9WCz4c1UDT
         MsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718752865; x=1719357665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiWmKBBXMD92k+n8gcYpFFSycdOAu2SpOI6WWatC5Kk=;
        b=elUVve/5pCxQkWpMSujrrvUWcMJeNENdt2qHihVTLsMcBhozZOZGHyeoO8Q6BgHPdi
         0Gss8T9V208HoSzAm+VdHigO/B2Lih+W2Ed8INUunEN0NbyGVcTYSaBDStpeV0H/AZMH
         d6wmvAKvk7G+s+JHYIAwDpXLqEBiPIcOhZqQnAEGhR7n6iEqIpaC22W/uKjh/KfSJ3kS
         NWvYy1PUbAZ9MWXYbX801YMnuzuHlBigg1xyfVETUnNMPjCdoYF5BD1oKLZrlaVVSBE1
         ceOV6PlHhKn0ccJ1PK3Av7+cGIzPabBrYkUOWSUV8y/yNs+tNutQd/ozVvY3hHD6ttb7
         PfHw==
X-Forwarded-Encrypted: i=1; AJvYcCVo0dZKdtxmUZ1mWyweBMnv0cNFTDB83paDbmQXJJNSyamHs3+YfTJoZwwW1tTD41BJYHVA4PFuaPPvjQk4suD5VRzjKrjGV7q8WpYVkWftiW+B2LqK
X-Gm-Message-State: AOJu0YwLtpejDkqW2ODGVMkN07KkxopI7nGwaKYzxJEgvHa2KOzBYe0f
	Rgf2pxJBrlLAJ8PG7w42Ov2frFVB45eVBJwrVRwjY3vxqTlpOjRS9COpzntQo4NGCCKh0NCwLNY
	uEOfV/d64sNqsPOHPwBCgK6ja3vGDRUOWWHfH
X-Google-Smtp-Source: AGHT+IHus0+Dwy7C3mYoVy1EnKy9AYfd3/lzpGvqA1GMz///IqTnVQHpm2tTpoqlitUnmFxuHZFCy9rO5c7Ub6gvyco=
X-Received: by 2002:a25:bfc9:0:b0:df7:7096:88f2 with SMTP id
 3f1490d57ef6-e02be226ff7mr1293526276.55.1718752865063; Tue, 18 Jun 2024
 16:21:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240415142436.2545003-1-roberto.sassu@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 18 Jun 2024 19:20:54 -0400
Message-ID: <CAHC9VhTs8p1nTUXXea2JmF0FCEU6w39gwQRMtwACqM=+EBj1jw@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] security: digest_cache LSM
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: corbet@lwn.net, jmorris@namei.org, serge@hallyn.com, 
	akpm@linux-foundation.org, shuah@kernel.org, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, mic@digikod.net, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
	linux-integrity@vger.kernel.org, wufan@linux.microsoft.com, 
	pbrobinson@gmail.com, zbyszek@in.waw.pl, hch@lst.de, mjg59@srcf.ucam.org, 
	pmatilai@redhat.com, jannh@google.com, dhowells@redhat.com, jikos@kernel.org, 
	mkoutny@suse.com, ppavlu@suse.com, petr.vorel@gmail.com, mzerqung@0pointer.de, 
	kgold@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 10:25=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Integrity detection and protection has long been a desirable feature, to
> reach a large user base and mitigate the risk of flaws in the software
> and attacks.
>
> However, while solutions exist, they struggle to reach the large user
> base, due to requiring higher than desired constraints on performance,
> flexibility and configurability, that only security conscious people are
> willing to accept.
>
> This is where the new digest_cache LSM comes into play, it offers
> additional support for new and existing integrity solutions, to make
> them faster and easier to deploy.
>
> The full documentation with the motivation and the solution details can b=
e
> found in patch 14.
>
> The IMA integration patch set will be introduced separately. Also a PoC
> based on the current version of IPE can be provided.

I'm not sure we want to implement a cache as a LSM.  I'm sure it would
work, but historically LSMs have provided some form of access control,
measurement, or other traditional security service.  A digest cache,
while potentially useful for a variety of security related
applications, is not a security service by itself, it is simply a file
digest storage mechanism.

I think it's fine if an individual LSM wants to implement a file
digest cache as part of its own functionality, but a generalized file
digest cache seems like something that should be part of the general
kernel, and not implemented as a LSM.

--=20
paul-moore.com
