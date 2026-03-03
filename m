Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B5A3E1225
	for <linux-security-module@vger.kernel.org>; Tue,  3 Mar 2026 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556427; cv=pass; b=RKMeCqTHU0Ju8ohw5k77vQuU1n5XM+LmpGFQOE1OMBKOrT2mZlSl+7w7YTcmMYuiGScf+xoPdY17mrBG7K4Q6OOMNnQR5JaJ2+XMQ89xOr9pJuqIXIz1yTGnFyZ+Gf7lTSA6un7puJgCwtyF23PnwGyit4Of76zlFvFCs1ahFLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556427; c=relaxed/simple;
	bh=SM44xZTfCkfDv2e/gG3FPefonBOZyBwlh9V8PSHZAos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgGXO1QXYCVLWju8nYVXZPeqNjRB/ZY2bCS0DDmqzoZLN/hMOwVbJ8ttf9NKsbPbFSB0jET0/EVwR2cw6wtvyC3Ill8l+jlrePUC6LvQ+YwJqQf5rc4Q1xfYx3yu/x+SNLeudZO/wKz65m2cM36h7RAQWEjP5XfD2pvTaLfuJz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NGoK2Zqh; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NGoK2Zqh"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3591cc98871so2565040a91.3
        for <linux-security-module@vger.kernel.org>; Tue, 03 Mar 2026 08:47:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772556425; cv=none;
        d=google.com; s=arc-20240605;
        b=BLFpmD424rc94X5K1t8nUv3OHpNomP65RXxjgKzzxx9NnE9vD2oUiC+ik93v7RGclR
         unCnTHsgX9dcuStaOu1cLhQw96CY7gdJjijHQYyCeLeAQeGuidsPm0lqK00JgQZpVQvg
         t+jBDGwLDejIL0Yd3nzTdTXpQbljYkHcalKQ5xCbBtQU1wpHtflB0EM+GfleGPhmvy6O
         YYwSnDdBPTRNMyK0caZR24AiquaSYcB+XpflgOw2TziGEKfiFU/NsbqI2auSciTJ54zG
         46/rkNKtCv1y71BvODQz6D7vKeoCl1wKTd8od+e9js7IbDf1W0etlUg50DWBVHbvR/Ml
         eEsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=znrF8xKITR+luWgbXLWnwiyzuzV2rFTt6rBzVhsxgC0=;
        fh=0nRVFLBMhSbgGeGjffTfynsR2dkco4T+nl6s26/jQjk=;
        b=GaU2xS4P1rF2/Z/3E7Qh92+Kc2BqYLM1ll+5asNKk/peUJRAm5SI8H4OoWd8/OGxOL
         wS+ZIG6setcxIVuFihcg5PbhJRuh/wrVR3X6ZK/zu3LDo6PY+BSV4xcOgAuPftAKkO5K
         76XYNvIAlmAt+LNpvOGhIqQ7zxrBAkOw2aHT6byQVGD3BbwSDNty2MWjmXp9gRwL2eFd
         BiT+X1Pu1o7wSZetrob2Mc0o/GWs0DIEYPd+7K/54MHJxx7I1TECQBfBZzMBFpJsonB9
         QeUWiMizKDOgLvdVfZkivWalurdOGBiVfGvLF1uNxGj/MTIH4NuS1ELPWJd22j4lutJ6
         NyLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1772556425; x=1773161225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znrF8xKITR+luWgbXLWnwiyzuzV2rFTt6rBzVhsxgC0=;
        b=NGoK2ZqhakjVdy7zgREbZ/2vQHCbwjZ5uY/Swkr/8iKYrRgvsQ45RaXEsRkidqiUB3
         8JHbXmQORNA0/wMF8lqpNwvE61VxcjUbdcoJvHqssAM5DS99CE5oZrE9KIt4f6SzlVO/
         J4tuv2jRrzjtRh29IE+j06w/fPZ982bzJdbga1Kz15mnsPdyKZm0btJzXO6kOlTl25nu
         rhyJF5PVvo0+q53OMa16iCe2xxeAlEIVhyfkjEilhJJfuMcPL54zIjLrTiMNZwtIP3s1
         sncFMdymKUHX0FvfKNyBZ02ND6MB53OyV/3ZkpuvQaS5/2gMVwrk32zjNr98rc6TKSJX
         g4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772556425; x=1773161225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=znrF8xKITR+luWgbXLWnwiyzuzV2rFTt6rBzVhsxgC0=;
        b=HdMjfq0WF+zRyUJ9LRCW9VX4vVGqTp/t4UhB1JkgZBZOVtv7TI7ea8kP1VRKPnRYSH
         3ZdYfXSSy5fHri9z65UXgyySKPssSwPMr2kzgta038JRuWLCDK+xSAmdBJbx38W/iNHO
         UXgVgyKhUspMDpsSlvtCJf6NeNDW3dZevmeI/XYRWIm35edvkrd5tbTsV4YZOGygN9uR
         cRuiKCUpl5mLhp6DFCQJJzyUBuw0aKRGd9Fq3CgHUm0px+b4DLpf0kv8sB9BmORCp/+0
         OCfrPTvnqaVtghuwO05KKfaH5lFv/y6pGlq+SNYL9ITFoq27Mq24HICPQ3IrsiYQR3yK
         Y2Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWw7htMkZ3kXv6XlbNuSorNh+lcoBPvOkdicQ3iXZze1nedDU2v+4RcUrGDsr77f/ANOo9tC/PMGUZNBB8QCReqCR0klCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8zMG2Irfqbju/q535gF19YSjeeqSlXOQkpAsp71g7sc2Tx/GB
	bVPWgaciM05KJ+g05mvwRypWT4bJtx9scJI6io1tvyb1znO5t7+75AmUqyAls142fnsDDetBEnH
	CH2d4ggheNKsDatsOZ6LlMGFzzEX9oENTwZARKFpw
X-Gm-Gg: ATEYQzwwEj9+e/pbcnAEBCWITUw3As6eJkv7/pQcmp54LkCNZzbF4Kk8aWGrsHAwACz
	uyo9+Axz7nxu1oGK4H8ToLj5xcF62sbRM/p7V/pOoU+udk8Op52D0LQ0f8Bj2A0Boq+w9NiCkrX
	K17s8n4ePf/GXMRAXYwvwtDy8ZMIZDWUeaeMekKZuR5lcf63JQYrCfF+Q/y4OFaP5rXn2DIz5oq
	p1NybO4JP7hddrjXQsgWA6e+kgIBEW/meO7toBdCZ0rayhPh1uxxa0xc34UAOm503t9tS7lJamQ
	DQZy+Js=
X-Received: by 2002:a17:90a:f950:b0:354:c6f3:d365 with SMTP id
 98e67ed59e1d1-35965cad890mr16289046a91.17.1772556425425; Tue, 03 Mar 2026
 08:47:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAHC9VhTeVs7kS9hzukukZRfGu6CC6=Dq4KP69tpEtiFpBJ+jOQ@mail.gmail.com> <CAEjxPJ4urh7mUbDJEi-DbdiAifMM_uDH3m35tLeTdx6z+qhPyg@mail.gmail.com>
In-Reply-To: <CAEjxPJ4urh7mUbDJEi-DbdiAifMM_uDH3m35tLeTdx6z+qhPyg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Mar 2026 11:46:53 -0500
X-Gm-Features: AaiRm51pCzabUF6iI4koJfoZ_mMjPn16GxhDeRowfLtuCabpuC97a0lUOhwaMOU
Message-ID: <CAHC9VhTGruOPJ+NWZT8vw1bjXzkB4DSPFmWd1pC=J2jTYHP5BA@mail.gmail.com>
Subject: Re: LSM namespacing API
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 8:30=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Feb 25, 2026 at 7:05=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > I spent a few hours this afternoon re-reading this thread and tweaking
> > the original proposal to address everything discussed.  The revised
> > proposal is below, with a bit more detail than before, please take a
> > look and let us all know what you think ...

[Yet another reminder to please consider trimming your replies.]

> I think my only caveat here is that your proposal is quite a bit more
> complex than what I implemented here:
> [1] https://lore.kernel.org/selinux/20251003190959.3288-2-stephen.smalley=
.work@gmail.com/
> [2] https://lore.kernel.org/selinux/20251003191328.3605-1-stephen.smalley=
.work@gmail.com/
> and I'm not sure the extra complexity is worth it.
>
> In particular:
> 1. Immediately unsharing the namespace upon lsm_set_self_attr() allows
> the caller to immediately and unambiguously know if the operation is
> supported and allowed ...

Performing the unshare operation immediately looks much less like a
LSM attribute and more like its own syscall.  That isn't a problem in
my eyes, it just means if this is the direction we want to go we
should implement a lsm_unshare(2) API, or something similar.

> 3. We don't need to introduce a new CLONE_* flag at all or introduce
> new or changed LSM hooks to clone/unshare,

While I think we could get away with a new lsm_unshare(2) syscall, I
have zero interest in an lsm_clone(2) syscall.  If we do away with the
namespace related LSM attributes and rely entirely on a lsm_unshare(2)
syscall, would everyone be okay with that?

(I think we would still want/need the procfs API)

> All that said, I'm willing to wire up the SELinux namespaces
> implementation to the proposed interface if someone implements the
> necessary plumbing, but I'm not sure it's better.

I'd really like to hear from some of the other LSMs before we start
diving into the code.  It may sound funny, but from my perspective
doing the work to get the API definition "right" is far more important
than implementing it.

--=20
paul-moore.com
