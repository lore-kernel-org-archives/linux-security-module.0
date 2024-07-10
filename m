Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE62566
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jul 2024 00:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720569675; cv=none; b=AZKasCp6pS4i37oFNq8UiqZquMvy0Gag8SlBftAng19yUks7vcuPHXAOEAcUIeVsitAO81aCYM+Ouv7+9vqiEpGHeG3ZAVLH+kttZuoU3HykdflQoW4z+bkFT0zmejImG4A68IwZRE+3R2EhACR5hNprryNggSmpePQLjghu6WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720569675; c=relaxed/simple;
	bh=yVbWlOISamht45NOAlspmJzEPY6SBp43ZhdlWtSZva4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8OQusjV0Gjm8qvuMo/tsCzStUuLqqpPp2CstogQ1C4yM/d7mVJdRWqjtIDuEQoWFaaLsqevK8cThsghr8o3gL4X8uUo+MoXKa5mcM3ubxbZJA4EPmU37qqpmbgTA+CkeKnQji8UFirZmW4ni60Vn5+HLaa4SKDJRM7FeWF3V2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JdKrobIE; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JdKrobIE"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-643f3130ed1so52289127b3.2
        for <linux-security-module@vger.kernel.org>; Tue, 09 Jul 2024 17:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1720569673; x=1721174473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJmCZiCcTgUvOUH8+g2onjS2U0MTnwtzz/4mcefNOI4=;
        b=JdKrobIEG/Un+b8Jo/zJK/b2q+UB7PSW7r25KpHSf5iOCVZd1Yjbf0UzBoLw8GbWu5
         Co1iSlgnIqDiUvxEFib7XPXNLWe4lG1ZGsb9cupYeQbmaYnibYRcLsoDn01GjWIzMWQP
         TsvR4K2LGUYWflP+28sv6NPmOCpLPCABOL2TbpTQvHKI0kGau2505eveITZhYvE36GTJ
         PhSHXzeMivC5o/v/L1bVf3ZA/D5lCErLd1TKBEUtXVQypKJXkIiekFVwduernsuOiFeS
         qA/q+ysgR9d/09hGTD6h7malUdj1QPNFcRba3tnO5/Jkhe3DQio0CHIaGp0ukGKkdRmR
         TROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720569673; x=1721174473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qJmCZiCcTgUvOUH8+g2onjS2U0MTnwtzz/4mcefNOI4=;
        b=NGWiQ2ST7vQ46oGw0TsPBhX1xpSjcX+oYfYzrEEQm537n+U4e7/s5GlpDxy8lYigpn
         1Pz41AQGfQ3PZ5PmrAewJD6B64mODGSk+ZUpRrL7mw5FrbrdLal1u0WSaMoJfJAf0qd+
         XnMOXmmtkU63iwPlg6zzUBx6viQWMyvMSzOQfD8MVRlM3pMoMOsZBwETzNke0LFH1mxs
         8H/8uuTp+88sbzxlUifqD83lzCNIPyPio8823QMHZUfh2AD2uuee4lZWrkOHaTaEVdc6
         2ibnLhVnUkZ3zgkREYNLI45YsVjfpve27/8EtkxTQ+PRQ6CReLlzGRsR9pYnLSa+oP3u
         tekw==
X-Gm-Message-State: AOJu0YyGdUg8qTi4xnpP66Cb+luUAw69DE8X5CpriQter73ND68OJLoV
	d6UHO4sPw2jbloPODtbZUPrw1K0cDun3mLKQkng1oJOYCtGAf+CRm8BcYYD8c1rg7fyG1uP8Bsy
	oBFD0szw24k4OLUqn6r4ZByuUwtdmoLg44CQS
X-Google-Smtp-Source: AGHT+IHCqWxT/zk1i4Fp0nbMDRAOlb6mE/88wYm5KVImMyrO68Asz8AL001Sl5jgGEyYxPUG7ebuhaIXdNVp87smEec=
X-Received: by 2002:a05:690c:881:b0:652:453a:bb1e with SMTP id
 00721157ae682-658f02f4a50mr57849647b3.41.1720569672924; Tue, 09 Jul 2024
 17:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708213957.20519-4-casey@schaufler-ca.com>
 <a7b378b26bb6b6cafb05d9102da61558@paul-moore.com> <df7a8220-b103-4938-89b7-ef2d028310f1@schaufler-ca.com>
In-Reply-To: <df7a8220-b103-4938-89b7-ef2d028310f1@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 9 Jul 2024 20:01:02 -0400
Message-ID: <CAHC9VhTkuanCTU6==3FVgOx4h=JyuN=_KTZG6Tquq5j05JdJTg@mail.gmail.com>
Subject: Re: [PATCH 3/6] LSM: Add helper for blob allocations
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 7:09=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 7/9/2024 3:08 PM, Paul Moore wrote:
> > On Jul  8, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Create a helper function lsm_blob_alloc() for general use in the hook
> >> specific functions that allocate LSM blobs. Change the hook specific
> >> functions to use this helper. This reduces the code size by a small
> >> amount and will make adding new instances of infrastructure managed
> >> security blobs easier.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  security/security.c | 97 +++++++++++++++-----------------------------=
-
> >>  1 file changed, 33 insertions(+), 64 deletions(-)
> > Looks good to me, but as it is dependent on 2/6 I'm unable to apply
> > it anywhere right now.
>
> I can reorder 2/6 and 3/6 if that would help.

No ordering is fine, it was simply a matter of I didn't merge 2/6 so I
couldn't merge 3/6.

--=20
paul-moore.com
