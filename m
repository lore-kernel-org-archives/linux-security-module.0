Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E52225D6
	for <linux-security-module@vger.kernel.org>; Tue,  9 Sep 2025 21:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453556; cv=none; b=V7ajUVD9Sems9m/P5FwlFcdscueviD/sxdJTaCu4AUhTUNIonAziwnUq0/NL5/bn70aK1LLJ/KtGOH5+xowu01G0YYyqWNprbNJGPwh7SNFSkzGVYM2SCovIwHBtIAv8Qqt/PJ2QdwYRbOKDzelNYVsNoIwiy0dtS57AmWWs2DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453556; c=relaxed/simple;
	bh=asYCnis4mSt6CdqmJGzu+Uw5kUXiEII09UvJhb2qu+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLcjXsye1u8B/eWUTKz6IE9xpJPy9Rk2vGsynQZHXWo+UMWgKQQaLa5pdhDo2s/nQRtz+hyMWWv4SiBSfSKSDR+tlYAu/zwjAnDwrZpkDIh3/H34cZ43Rj89W7PdCloosUvhNgEazvR5pg1pD13cS6WasifRxS2CQkx2p5mj0Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MmZD3hM7; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MmZD3hM7"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4cf40cd0d1so5308772a12.0
        for <linux-security-module@vger.kernel.org>; Tue, 09 Sep 2025 14:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757453554; x=1758058354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asYCnis4mSt6CdqmJGzu+Uw5kUXiEII09UvJhb2qu+8=;
        b=MmZD3hM7QvY841CrjUftBYyB9mXbysv2R531wqu8iH24LaP4HsvpCdpwNeUKZ55Dd6
         WFys/ST4OSFUEQ0DR4vWNsnMU8CZXnv826qNVf/7WgNH9IGIDsdQ+5ul/MwBGRootB9A
         injXW0rv6Mj4jEPEWt6rV6sJbrsuiBffZK5ztdFX9f3bMBwcwimTgo9Fhxl5vnHU+mxr
         9jgtUCaxOFKaKMTJ+5hK3NHNGM0/2neGHzCnzMLKk66ShgpGg1RbXrkBjcSLBjXSyB1k
         2uZiV1b1SAKyw76NJubiiPrPDezSVNs4S1NpPWcKL5wc3VfmRVXCbvbGbdBAGJffXubd
         NMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757453554; x=1758058354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asYCnis4mSt6CdqmJGzu+Uw5kUXiEII09UvJhb2qu+8=;
        b=dUC289k6hoqiVLi9wtEJk7uZXiOBNcB1JljXkQCUAcZibB0P37Dwm7fbDVBB38Np9v
         tqAID97BpKxYRdgI6BCEMIIhcNUoPKdHLToJ1w6WN+Dt4cNCGHjn5io3B5Tk/Wk0zpNS
         aBpw/jQ48tEbl0xNMaQwfWvMsjoYa1B2uIoJvTVq55h7A1WUP0sxlBlS/CoJ5DHWxaTq
         AovsNZiV4wZBIoJq2xU3JoyG4+hqCC6rGCQ9ynS0jWDJ+14HKFUAtZtXvcCmyozlz+5i
         VlSDA1xpw/HnEsg8dPog53q9WjhNWpwel6A6pfNeqMTRp8ZwDqXcdm7HmE/DR3nY/vq1
         xChw==
X-Forwarded-Encrypted: i=1; AJvYcCUjHwzAnMRYMyYm8Az88Zm8/CnNdfeEXtuopq3Wix7DvYx+p1NZ5zeUqepuuwuIQEk4sK9vApFCZVuu5BimrrCC3WahPUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfZtaAeetjT2gULGJ/VNnSDKh51JkiB6FmdURdmQAcdGiCJqW5
	O/FkrfkcpBZu+lFFaztEm7A0gV7N0EckfQa+9u1v42vQAptMfkMvDtJ91OmN+QBuAk1DMmlUlY2
	Oq/3JZ5+26BftCOlnDf0SNMyEbJYYUuIGUd5UMYqV
X-Gm-Gg: ASbGnctlBlrD5o7Vz0fld7zfyQWZZXanF6W41BToMCSOIYgaAUnUPB3OMtXywYus+A8
	XAW6fRSu6UU2R8KeEoIdYIVtLgDCrOozhG9Xj6MywJPoZatVKjtBXOUSmu3j6H/d486J/P4w/dk
	mrmua53+Er0IcfeYkBMRtEtjZdmX7fcty/nv7Qp0npjpCHzgoP3zkArTZD3C7DJNgMVDhcBFtNZ
	Ck17j3wP3X8D8hV5w==
X-Google-Smtp-Source: AGHT+IFpFxNo6dxCBm0dGcRZj8ObBT0pFbtG/sSiVCHxphai4thKxc4JU3AVtrF10UeYjdGdH9PqFYTQ3Uv4NlDmlp8=
X-Received: by 2002:a17:90b:1d0b:b0:32b:df0e:9284 with SMTP id
 98e67ed59e1d1-32d43f45856mr17772256a91.10.1757453554206; Tue, 09 Sep 2025
 14:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908013419.4186627-1-tweek@google.com> <CAEjxPJ5q0eriGjo1tdfN+pzBBN5OeyfMaYp_sNQcOg-rDaXVCA@mail.gmail.com>
 <CAHC9VhR1pEFYzSFaqqWsU8C6vDaH_E8uZZ5g=KyK6TJvA7a8MQ@mail.gmail.com>
In-Reply-To: <CAHC9VhR1pEFYzSFaqqWsU8C6vDaH_E8uZZ5g=KyK6TJvA7a8MQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Sep 2025 17:32:22 -0400
X-Gm-Features: Ac12FXyL7eL3X_jCKFwoxMjKs2tue0NW6-1wqyMzPYDoAVXjw8OY2Gb7ih30uV4
Message-ID: <CAHC9VhQLZ+mWS77OG6cDddXYfJy+eTqkKSZ28PJNEjLigsNGhg@mail.gmail.com>
Subject: Re: [PATCH v2] memfd,selinux: call security_inode_init_security_anon
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	James Morris <jmorris@namei.org>, Hugh Dickins <hughd@google.com>, 
	Jeff Vander Stoep <jeffv@google.com>, Nick Kralevich <nnk@google.com>, Jeff Xu <jeffxu@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Isaac Manjarres <isaacmanjarres@google.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 5:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> Considering that we are at -rc5 right now, we only have a few more
> days left in the current dev cycle, I'm going to merge this now (with
> a subject line tweak and some unnecessary vertical whitespace
> removed), and I'll put together a quick little patch to do the
> WARN_ON()/EACCES conversion which you'll see on list shortly ...

The patch can be found at the link below.

https://lore.kernel.org/selinux/20250909213020.343501-2-paul@paul-moore.com=
/

--=20
paul-moore.com
