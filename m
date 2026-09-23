Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F293947A4
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790196981; cv=pass; b=ngn83fy+jynoajyAlPutA+zQCM2quie01ZKWiCZ7FArWgrqQHT0fjSEtOjEDc+wOpcXW+SVI2L2E6AJ69X3Lj3e6b1V2+MZJAE6B9CDFXz8lXDWy9Qv35PH11gCBOEWZRtDe7vF6WID43EY3JHyJE0M7NoLINsoOReDRChvYNOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790196981; c=relaxed/simple;
	bh=AfsNOKliYq6zL1eqw3cqwWjdNoNKiv3VUp2n3SA8M3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EeIst/BFFNoh8VcnXAwU7l/v3vd+gvSLRb2KuYTxRQ+tuMUfx0GXcjLyzDQ5FgKN/d8YDaVYnv6nYpIQtMMk4S5OTQC4hraH+ESbyOfF5AfblsrMBF46Vyzz08isanLLWS46eHNseAcNVsTVaQCAVgRcU2dqU8GABRVNHR4rK/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SCxH7Yqu; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SCxH7Yqu"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2dd77300816so3757935ad.1
        for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 13:56:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790196979; cv=none;
        d=google.com; s=arc-20260327;
        b=G0sAVofbisjy2UtrWvFdZ4GP6SF3Q4tpledgySA1kZ2vd905cIxx+/r1FWA50jkgoY
         zgzKFIsKP9wyE8jjZZiqxBXIjXdcImbxUS/jV737Ug0wiLvCz1dWAVUO2i9P56/piJs6
         yqoovic8ag4SI0/UPgmFy+BH2jyA0zKllXokzcTgrqgB/UY0E9AAOQDrMVcwavyUh9ew
         ieoS+blkMTjxzhOHtogtbvKgwcn7sjdiraJzvsab4o+XBqeH/KZ2bbd6iVx0rasjE7sb
         aQFifPaxpu7hPTwNiiIt4FPWEPYZg9K4goMjnIMWnK5W3HMEsd8ZBDsUMBIdLusRt6ae
         R4Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uKXaOIOrNPS4pMqCdHAkufQqbDvyLs8wmA+yFUKQc+s=;
        fh=mSxYdM2erqBsNTvDt7kbdXiLP62otjLlM1F9W4pCpn0=;
        b=QFo0aer/oQ+39pqbd5BQyQM1d5zkDZk8PCdUxgkQM0xuic4J40MesIfJ670hGmq4dq
         ZgoGR86WuLJS0T41GnFoblFOK4nqdb428pabJlOf7dYxsK4gEETLPzC2IO4jwBp3idkD
         /DO0r+rcsEvbIjYpiO6Hbz+s91exbUQr/nKtNvvUbDb4ukXYF8KdEo4z6eM+McdXA6i+
         CNT7IoKQOgyNb6RxVa23tv3aRix/KiTE+ZATLXiYu6qoZy2hB36YUlsrJ5b7pQ3kIgPt
         ztPGNxokRGOVMwdSK0lyEhuvogwygPCPv7EsWL6wP/6wE3IaB5MZosEG6XY3h4xFCFZJ
         i+dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790196979; x=1790801779; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uKXaOIOrNPS4pMqCdHAkufQqbDvyLs8wmA+yFUKQc+s=;
        b=SCxH7YquEqV+DMQ7X1Pwfgpngy1rqsZTafwV3mLotiecr9XnNUqcX+RS8aIvbk2rZJ
         TrW5VOSZPCGF1FbUz+UxdHCtJnGzIsJhWdArB+Y1x53R1JAF5z9ZiWARgW7zmf0YtjXD
         gWxkaWdSTlG/RoeSErfU1k0wQOiUNPXkOeUC811Gopln/qQ+H5lMNd3jS0TUJ+sJSpWi
         ElVRopfx5aQFpVpg2UhgtFn7Z6D/wnKhPuGlqVbQ8GqBIaPj3WHWvUJvFamrtdGOOutJ
         LbqCKYGocOk5c+lLDP1zE03fhY2K64vAesqPmvutPKZFGCbADlFOM75BbbyNFG/AoMLq
         dTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790196979; x=1790801779;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uKXaOIOrNPS4pMqCdHAkufQqbDvyLs8wmA+yFUKQc+s=;
        b=JABms2+a6qhkxki4BtWII0ySeGXS2DodNfUaxAMB0vofdg0cbo8PKYkIka1P8F6p/B
         NzWkWfgaKzGsLNcSOC6u6qAc4mzRoMC9bM4X7k0jpM3UFkpsbEMlpxSAMMJA+3zaEDOv
         evCRu21JaHabbo00P+zzP1l00HJ6khtdlvOG1YQJkKEnDilZ+Vktj84eawsjoXiqFC44
         gHLMBAEmXqU4gB5z2YyJVpO4Qq+Gqny3fv8XLvE56WWkhk0kw5hoSx/WJ4G6p6RamZCy
         cBLCbuJxf9vDi/ULDWKRv7GofO0idznaNAsH02boe0tF1qoOL390gaWLE6wGXnu21bqG
         +/Zw==
X-Forwarded-Encrypted: i=1; AKwUvByOQoTn+wgncorK/zlTb1twy2dfwTjaZr8AEC8uEgBjHyVR2kjB9H5XGw11+I4Emfz3EOUfn07xPvWUhr5Ihz6lTbQDIyc=@vger.kernel.org
X-Gm-Message-State: AFuF++kQCkHpPc6wW1cKxy1W8eNvN4oZt/6GoOTgshExvdPs3luGiMC0
	QY387gkH53N6AuWjbEWyY5UWWPm+Q7mOGWoR/4V6HjfzBNZshi7jLHahpqMDfZjxbfXWCTPAnGh
	WK3AgUxsy3oz/3o81s2dxASws+Ued17nmJVcDFuOv
X-Gm-Gg: AYBFou3LwptSK0c/b1S7C/mQRaGOj1pbbA5oI57BgqV3xZSF+9Hp0D1YMl/tKHj2r53
	jIPw37yJi5C4c8d31gwyAk1Rnln1FTrIeLeGT3cTIVfF8dsL02bgDfzamgSdTRAbgUwELxYS0o3
	K+sy2eRoiru5EhjRTJa8oyLmMXq2JZcVypSwdtAxf+8Pza9qTttvP1k+tR+EZyjzuAa9DH8Hm+W
	Dlt5lHPYuqbJDrP/f0ggJFHpQ9GasWM2GJ3fnBk5+GSJpC8jGjA13hsnMsBtKmvDPY9XXLE8nNN
	HTEHi2UFXhAAQ3IG96svJFrvPsKWmRxgVd0zGuoSpcVnNGdxZxL2oMOLenVMsW2XjeHBqQuUn5/
	FgyGeMYZYQ00=
X-Received: by 2002:a17:90b:5783:b0:395:8124:ac53 with SMTP id
 98e67ed59e1d1-3a09860ee65mr161639a91.6.1790196978912; Wed, 23 Sep 2026
 13:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915150739.284189-1-daniel@iogearbox.net> <20260915150739.284189-5-daniel@iogearbox.net>
 <CAHC9VhR2Zp9LzDRwDOZoesOC7o8hretfgRH-PRqQRXA0EES2vA@mail.gmail.com> <CAEXv5_g1XQAwsydnbu9SUvxNBdYQf+xXjPaZMeC8hxgfThP+pw@mail.gmail.com>
In-Reply-To: <CAEXv5_g1XQAwsydnbu9SUvxNBdYQf+xXjPaZMeC8hxgfThP+pw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 23 Sep 2026 16:56:07 -0400
X-Gm-Features: AclHuK90iLZutEt8vQpJHROuzrBD7oVO2vZ8qgmd-e8wc1UQ4r8BY_tG8pTzJSY
Message-ID: <CAHC9VhQCcbu9v5aNPBxd6sqwjn2bWZYKJcPMMd=kBQJUuSPPAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] bpf, lsm: Let BPF LSM provide xattrs at
 inode creation
To: David Windsor <dwindsor@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, alexei.starovoitov@gmail.com, brauner@kernel.org, 
	john.fastabend@gmail.com, memxor@gmail.com, kpsingh@kernel.org, 
	matt@bobrowski.net, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 3:14=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
> On Wed, Sep 23, 2026 at 12:57=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > @David, simply for my own understanding, did you ask Daniel to do
> > this, or was Daniel operating on his own with this patchset?
> >
>
> Daniel and I work together and both have things written on top of this
> kfunc. He reached out to collaborate, I agreed. We're also going to
> send bpf_set_file_xattr shortly.
>
> This implementation was chosen due to its immediate mergeability (it
> only touches security/bpf), but was actually suggested by Kumar in v1
> or so of my original series.
>
> That said, sorry for any confusion about this appearing as a new
> series rather than as v7 of my previous one.

Thanks for your perspective.

To be perfectly honest with you, seeing this patchset land in
linux-next without it being posted to the LSM list, or at least CC'ing
me, after all the discussions on the previous iterations seemed a bit
suspect, especially considering the rather rocky relations between the
BPF and LSM communities at the moment.  Regardless, hopefully we can
get this sorted out.

--=20
paul-moore.com
