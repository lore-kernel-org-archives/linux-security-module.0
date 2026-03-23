Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72FC3D891A
	for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 19:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294315; cv=pass; b=iZMCwRYiUrIMVdg7P4yhHgw2OGNTi324b7qftrvxKwT/lsVlBsTrfofrmFz/NVHFo3x7pefCNSpBe0+Ljsg9FY2stWkefZO9pj0yv4vuOXTmaO7o2dDve3VTb984AhD8YUGouiCJOO1NypcPS2gFRDc+aUfjy6Oc/znRZQG21pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294315; c=relaxed/simple;
	bh=qEmaMrG6tQEKHABcH5kGpa1dSTH50exe6PGoRyajv9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhjhRN9jBmKR6cV8p1OwmOLSzLf+UhQCpevzAcznAvqcmKGXLuCKJj6yYFRFLjaB5pGLFurTEYggrc/LLs7nj7YGmCKSDGce/A/dKXHkQEtlNj6rKJL8qa0rmsoGPSNACuEQmWmkFw2L/PZFZNleUOZmSfNrWPzH5l66sUgSV/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dau72Gt3; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dau72Gt3"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NHGtVr467099
	for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 12:31:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=qEmaMrG6tQEKHABcH5kGpa1dSTH50exe6PGoRyajv9c=; b=dau72Gt3dvQN
	Jbl5OSdTRlLie7gsjtUOOGmFwPdNDx2OdKuFIEHt8cZz0kC//nK7765yvsXTEi5l
	tpAHkjjgzsZKqXlOzQVJRY6FG+Qw2rdPOXZ+dZcwhQlI68qFAS3dmH1GKyLm0I4j
	TrfOtFZgU4WHizGxN+QnfN60+hdV58LEK7ei3jrXaADUY+5MxzwOupKP52n3IBzy
	dnWRPzWGgUCw8OWMRHWFHvqb1R2HIL6IrXdaBfkvvASEXPxUTHQPbY5vKkvlrpWB
	vQHjyWNNttoIT+uPLz71hulmTcfnNhKnW/7afG5Dk8LCfa1w4UdrwIfYWQRyMv0J
	t3A9GTFdrg==
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d38rjumpd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 12:31:51 -0700 (PDT)
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-38abf1618easo13270531fa.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 12:31:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774294310; cv=none;
        d=google.com; s=arc-20240605;
        b=kTK2ZLObR7W3AZncbDsh2pma1Qb4eGOJHdZjb1BEiyYie1iZ18jbhakQtkfY2d1xxp
         DK9U1oU05i31V5vkBrv8+s/NhZZcci9MsgikXCSJedsSHqG8U+WtTOmiDue/NI2j18vw
         JlGOuOvel/88DNEXsM8AB4ECfZ4VIt9hAEayWZIwPELeFkLqh7Xt3UIeXeI0uMQsUdHd
         BSk0qA1vmNuGsDSCgMlvXfU/siIJC8lXhEbRSGLVLU5Dn3HZfNzmDZoEAyXHF0huPPdJ
         UD3KSFEHI3C3bL5a9RXYLp2qC+VL8y2TdH3QYUKzSmSP75t+uwrVlu2A2UVxAnbO1tZG
         +bSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=qEmaMrG6tQEKHABcH5kGpa1dSTH50exe6PGoRyajv9c=;
        fh=I5auneEM3Go+qX/mP481d2BBmKmVr8lgHjhhumqEPZ4=;
        b=a47dI/jT0LQjQiCn+8FgSEilcjVgi7CDikGvHN321cMJo9Nw3ZjpY923+oDQRiRNBZ
         bYAIfTGU4cl6E71OE0/uMKemnXo/WxgN0Og1bPkhQKqkZKI6/mvvzfJzQMSp9+1If+Js
         XQJLPZvya4OfXZlueCiyX0qlN+O8hAJwas7i4rMHtq/q203XxDOfw9moGtJ1s5afXALx
         MjCzGy1ClLHPANa9zKOq5mECL1p1so7M7aiEgSQqva+WC9ffrNkBj/9WyLWlrkaU4KAo
         YXUeVDyz+OAYpO8jUMZYfEYrd78ReHaCF+5BpWbQp42ut1kyTmlQODaC8Olt7yAcZ7MN
         DEXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774294310; x=1774899110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qEmaMrG6tQEKHABcH5kGpa1dSTH50exe6PGoRyajv9c=;
        b=ByhUFkLQbb1Qa6Ez4QVlLF9ZUc7A9wu0JCLQmEGBSn6yjNSCr4COUOg1SkQ29sQYTu
         l+VgmZuO6G3wG5/IA85xtuDVmK+hB4gqUbAUSx28ubMFYHC422uInhqMM8XnyHde5k/C
         aw5qj07ULlYiqDKL4MrJuUzbPOR+9kb4BK5oJbRoxnZYlNYTHvtlZcXZHgz5F1348K8l
         TmJ0qmAObEfiJHhAkMCjm2KwQ8eGvLygBkHxmi12nn13UWYqPE/3gVBL6wmebipc3BjO
         oHHFKH6HS50WvrNaJEpkOEuPTuWjyIBQwlL+xCcczcOzxbvPcYfbNq7SL6YPQFEyyntZ
         A8ig==
X-Forwarded-Encrypted: i=1; AJvYcCUMZ13gPy1uyhvw/pnOPeyI7DQhkt04JfZ/OvQfSVy+npmw07ImjF5FPnd2Y0+wh5JZC5sEoFRKAyMl5d6rb8kklHDxhPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyOcanuBNCm3Y0EjvHscn0r6x/NNKge/fogHvTaLHKQxRFENQC
	G4d/KjEnL99st29tZaweN0Dd94vLx5EYpopvIlbF6FNZqcfLP3scTlNICG/4Rge2w3fHuCnG9co
	fXMweQFpkPMMiAbVwEwusbl4QWyHhlJU4QNjaX2YWSPk1fuccr+Vy5+kPeCDGsHp4pbj6ORlDIS
	4yCcDlgNBd62IC4FtfNDDIwsPQyB+tQp8szm5bQOJ815mMsgq3uek=
X-Gm-Gg: ATEYQzxvfqIIty9V0Dl0yBqiQCLzxwE8++iAeHqr60EwD9JgVwIYFbBhg1u1qge7fYr
	Ck1KXSAHl4ZhnzJkwLptJvCVPO/e4Ls7aGApoKEtoztkBlCSiRiWzj4dO/sMUMNrL9WSyz8k+a3
	fjNpuxclGQ8etDgFoXd97qDqyM3mlM4YTN2y/WRaXH8JiCQKvOAfZ0ouxQ2P93HEZovIEM4S+UG
	G+G6/WIDOYLpGq0GkhKRw==
X-Received: by 2002:a05:651c:418e:b0:387:1ba5:99bd with SMTP id 38308e7fff4ca-38bf972b0e5mr41075441fa.27.1774294309948;
        Mon, 23 Mar 2026 12:31:49 -0700 (PDT)
X-Received: by 2002:a05:651c:418e:b0:387:1ba5:99bd with SMTP id
 38308e7fff4ca-38bf972b0e5mr41075301fa.27.1774294309455; Mon, 23 Mar 2026
 12:31:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318184400.3502908-1-song@kernel.org> <20260318184400.3502908-7-song@kernel.org>
 <b720f521-e930-4f35-9505-1bfdf9e2818c@I-love.SAKURA.ne.jp>
 <4DF5C4A8-7C92-4F76-9B34-2262089E7289@meta.com> <33abcf34-13e2-4a37-83f3-78bb27ecbc11@I-love.SAKURA.ne.jp>
 <F0A0D13E-8208-49A4-9AC6-89AC4BF3F4FB@meta.com> <20260323-klappen-atemschutz-7a0af8c6b087@brauner>
 <714a614b-cfb4-4b20-af8c-df3cc56dfb92@I-love.SAKURA.ne.jp>
In-Reply-To: <714a614b-cfb4-4b20-af8c-df3cc56dfb92@I-love.SAKURA.ne.jp>
From: Song Liu <songliubraving@meta.com>
Date: Mon, 23 Mar 2026 12:31:38 -0700
X-Gm-Features: AQROBzBKFBxWkFKdSZb6aDqln1iqdiuNWYNqj8Bk3Aj5pcgV1TsyMg6HDo5_J7A
Message-ID: <CAAeYb7k+TWArOKyOomkLZ8fwqUPjha9iORpJaj4nMyN=o4ZRQg@mail.gmail.com>
Subject: Re: [PATCH 6/7] tomoyo: Convert from sb_mount to granular mount hooks
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Christian Brauner <brauner@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Song Liu <song@kernel.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>, "jack@suse.cz" <jack@suse.cz>,
        "john.johansen@canonical.com" <john.johansen@canonical.com>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "omosnace@redhat.com" <omosnace@redhat.com>,
        "mic@digikod.net" <mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>,
        "takedakn@nttdata.co.jp" <takedakn@nttdata.co.jp>,
        "herton@canonical.com" <herton@canonical.com>,
        Kernel Team <kernel-team@meta.com>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "apparmor@lists.ubuntu.com" <apparmor@lists.ubuntu.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0NCBTYWx0ZWRfX6T8hJ970WWlj
 Y7enkPmoFEif16XT9D6JWpbLb2tfc/K+IYflQqd5MHZONraJcaD9TCGOL2qz86KuEmzOXyPIlf+
 2MguHEpBc0OLCQBCfA6m2jKyZkgP75BIkwA+lKSGF8I+AUnvSTt6K6s81cBr52oTqI5KH9GK2wO
 8uDspOzsPdITxFkAmN+KbpEAgNC0F1RGg2XeyrXbayh9i5/Pg03IWzbHFl12DTKUXgJVtNmQjUk
 mWw8Iq0N4aIhk5skKAYtfCBM6TNn7AdimIZYoYb20S79ROTydCP598LI0BK6/oUU/O/KlsPUAlb
 0Zv4wkxkNlKjlCUdA7+EraSJO5YBDTWJ5U5bV1XAz3XfR3EdMiFQLjojyvE2rYkopESokA1NKJH
 SMpU7xoZ2xZChYhXPNwvNHcfIjcWyr86sjSdEwz6sjj8//glv25B/PDpE2IT/pQme5ecnc41Fg/
 kbYLHwb61lu8p2Gs+wA==
X-Proofpoint-ORIG-GUID: yifwFloH5nrPV4r_iicUqMnFKq2imD8h
X-Authority-Analysis: v=2.4 cv=KeffcAYD c=1 sm=1 tr=0 ts=69c19527 cx=c_pps
 a=/zUzjrEyDQOchHorqPmRvg==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22
 a=BqB2_f_Oa2Tj43kevx4A:9 a=QEXdDO2ut3YA:10 a=zJl3WwEMzhwkf_fFxYei:22
X-Proofpoint-GUID: yifwFloH5nrPV4r_iicUqMnFKq2imD8h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01

On Mon, Mar 23, 2026 at 3:33=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2026/03/23 19:16, Christian Brauner wrote:
> >>> Since not all filesystems need to resolve dev_name argument, conversi=
on from dev_name
> >>> to "struct path" is up to individual filesystem. If we can use a flag=
 like FS_REQUIRES_DEV
> >>> that tells whether that filesystem will resolve dev_name argument, I =
think we can resolve
> >>> the dev_name argument before security_mount_new() is called (and can =
avoid TOCTOU).
> >>
>
> I was expecting that "struct file_system_type"->fs_flags containing FS_RE=
QUIRES_DEV
> is a sign that the dev_name argument is a pathname. But it seems that suc=
h assumption
> no longer holds true. For example, cramfs started treating dev_name like =
"mtd$num"
> as if /dev/mtdblock$num since 4.15. So, current TOMOYO logic causes mount=
 request of
> cramfs with dev_name like "mtd0" to fail.
>
> >> I guess we can add dev_path to fs_context?
> >
> > No, when and how the path is resolved is entirely up to the individual
> > filesystem and we're not hoisting the block-based specific path lookup
> > up into the VFS while leaving the other stuff per-filesystem. And it's
> > not as trivial as you want it to be either.
>
> Then, how can LSM modules know that how the requested filesystem resolves
> the dev_name argument, without embedding filesystem specific resolution
> logic into individual LSM module?

IIUC, if an LSM cares about the dev_name of a new mount, it will have to lo=
ok
into each individual filesystem. We can add a LSM hook for the filesystems =
to
call. But this will require changes to individual filesystem code. OTOH,
dev_name can probably bridge the gap as we change filesystems.

Would this work?

Thanks,
Song
