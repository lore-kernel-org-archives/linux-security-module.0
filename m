Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B73217D6
	for <linux-security-module@vger.kernel.org>; Tue, 11 Nov 2025 00:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819947; cv=none; b=PIa9ldO8OT89/1pIi2gp3jptXOrA1SM9TQqhkuSftyFnnVnEC53vE5t10QXTap/AHNy3oYcJ+mpLZqDf90DgTiABTbyRFohez0tQXYe3P/MORuenp9rRkDUE+S5s9laREArS62DuIyP9P8Kn8aCmAHMFOy3xAhy7o88SPLaxL2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819947; c=relaxed/simple;
	bh=40COxiieaHqw7+ui24NSWgLnvMT1wpUASlkNw1A/gos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3WKPufhu40RwW2KAjgVE05U/5WODSIVJbw6YpkmfoncDrNX6S+biP/OUwW9bPOjv/2gFWneKsRuzWgmPxB8kr3OAANDflE5TiyUoUzXh58s0G4puaFGbqdjsag98OjWa/U03KScrgt622y2btl7/vC4ne9olRWmKsDtjQ11mxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=B6DDQaN0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="B6DDQaN0"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3436d6bdce8so3130550a91.3
        for <linux-security-module@vger.kernel.org>; Mon, 10 Nov 2025 16:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762819946; x=1763424746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuW6q1y8DG7tuVTrZRJrDQaASYmc2YGPYqwUbsMWjj0=;
        b=B6DDQaN0HLMlNds9B8k5HAbOixH1tfBoHsho0CUKe6JSQTw1ZCp0Dg+c7DtSBecQI/
         A29R93oya5G28sUCAJCv0xYBjc7JGltpj+T8PkTNcPPXc5LF/6rqvo5BQFe2aIRBGNez
         c69HaD3sP+za5FpD7jDiz7/DHt1uFkWv/V6v39giK+dCDLGwdsU1aFGeFBznHCxPNKr7
         5sdeMx398HQ8hnyX+TLYR3MnsPUKBqfps2ftzIcGnS3JPVe7PZaB6eEJ+rSnTsmfSagd
         XbptjrhKAONy1GdnOGO3fbqZjd62vPkjXWvslsJ7HqjZHyoRsxYi2pSzH3dNy/dty7pu
         zsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762819946; x=1763424746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xuW6q1y8DG7tuVTrZRJrDQaASYmc2YGPYqwUbsMWjj0=;
        b=I8NI3EUovEDSMcd4wCCFr0K0uKXNb9gu5znElhdPMmaTZnuklY4SuEx2U9rvJ5ic6S
         UAICG1KYqT1y5ndPAiPTrI9dY/qB/ilPc1Gpwht8o8bpMAsBBSR22oNpWLmAWFsTMhJ7
         E90FZt0yCUg4L7XABqDAPIi6f3e4x+2Ok93Sh+UuyGDnj48RdKJG6aaeK6j2XK8wDrro
         yx0YT70jH8Dmj7vMgWvPhmz2n+5VtHBADlc52rU0cUgXXv3qjv6da/tmWY1OFTIdr/r4
         fEyu5FL3RExEXYYrfLEU3HN+XGVz1QBEs8b8TAkgdz3XZ/9Z9Y+qhUbCU0/tA+vlhLwZ
         g5Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVW9F4x0z64iYK7Qbw9EJKENuQu4zddCc8vhA2DSIa1W9bwfJNqe/GKUEq62bBsjx6RcwSxFEGr3HPIPH8+TN5UVPAk9vY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpxDJMQ40GVS1J7capWzWnf38lqHm9wsLNq2CkOimo2fPmQ6jo
	6/uFegJ98pBmSbF3FcxepkEIg1KS8wzL5l81yklmZWkaNXZVPGNDwy6qX2ztst0oPDofRZ7wJ/+
	dxJZVpSmy0Nm1T7mY3rNqqhH4BrwZnXuL8O4oWSF9
X-Gm-Gg: ASbGncvZhVapoFySx4xUEhW483wYkzUc5rEKv6k/9YO0SDaqwNmXi32GUEGZymYzeOh
	tWwy5lyZgB2FoFbhnwq3BheD4d/vz2vdV/n2EtTraMz7NZ+liYO4ff+jK4qEP1gRif4WGrzmjHF
	bSR8PFmB+0mbwODrQCcmow5FiVt1cnhZXMU2y2aMx9wgjlTDWfh1PAqEwCA0JOkCS2yx3MmOGd+
	+1g21sT7/ZuyXvY1U2zEBeGw5KRsRdFa8k1U2N3uEvBqMRPhVXRbk3aIsvY5/W0Jxgvsow=
X-Google-Smtp-Source: AGHT+IFuEHxUGZemG3Lw6GJyJiLKC7kdvwsDE7oXb+eCceHLIabTEdGFPXVSAMyPTApNPiB9m/aWUBtr2KPwWIdbru0=
X-Received: by 2002:a17:90b:2d8b:b0:341:88c9:6eb2 with SMTP id
 98e67ed59e1d1-3436cb7be69mr12345464a91.1.1762819945887; Mon, 10 Nov 2025
 16:12:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHtS328bOsw=7u0sN8P0F7Mj2xo6HCQLVkZXMBwp3rqTrAY-eQ@mail.gmail.com>
 <CAHC9VhQw2yXuwhVSZERXiOREXzuO7aU=LTUiL1go6v5m5sx3Mg@mail.gmail.com>
In-Reply-To: <CAHC9VhQw2yXuwhVSZERXiOREXzuO7aU=LTUiL1go6v5m5sx3Mg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 10 Nov 2025 19:12:13 -0500
X-Gm-Features: AWmQ_bmyscMBSBBrJRMsIWWyFRwgwIczbA-GW_VHcdp0Jr7CgCsNi7kMSHpcKbQ
Message-ID: <CAHC9VhSEopz-LppHfNrvKk0KjuoQy-E8Q2_tAteBKrxhJ3Vd_w@mail.gmail.com>
Subject: Re: [PATCH] security: Add KUnit tests for rootid_owns_currentns()
To: ryan foster <foster.ryan.r@gmail.com>
Cc: kunit-dev@googlegroups.com, serge@hallyn.com, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This time with the proper LSM list address.

On Mon, Nov 10, 2025 at 6:17=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sun, Nov 9, 2025 at 8:13=E2=80=AFPM ryan foster <foster.ryan.r@gmail.c=
om> wrote:
> >
> >    Please review this patch that adds KUnit tests for
> >    rootid_owns_currentns() function in security/commoncap.c
>
> Hi Ryan,
>
> In case you haven't already seen this, it would be a good idea to read
> the doc below on how to submit patches to the upstream Linux kernel
> lists.  For example, sending patches as attachment is frowned upon as
> it is difficult to properly review patches that way.
>
> * https://docs.kernel.org/process/submitting-patches.html
>
> If you are having difficulty configuring git to send email, you may
> want to look at the "b4" tool, doc link below.  One of its primary
> goals is to make it easier for people to post kernel patches for
> review.
>
> https://b4.docs.kernel.org/en/latest
>
> Good luck!

--=20
paul-moore.com
