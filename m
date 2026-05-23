Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E32233939
	for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779556789; cv=pass; b=a3TJMoweida7t+2hOonFx20GGkYHy6dsJbWkD1jzz+8RriwYb4fF/BS9iGYzv1wJ8UjntCGI8l/wFeVGGChTGVPPeyn9v5iRVHtnSK0gYcLQI9zZNls9QLHEDXEezPOQB5eIqAdz8Vj8+2dzL58m/e29NVUQAniD7fIGkFQ4xhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779556789; c=relaxed/simple;
	bh=K1T3+eD9aA+OMvgd6PqU3zP6/5UBn+pjCxI+BISD4p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkNTon4RMSAhGw5qNk9xg0dmqDIBpw0/h/CJHKTsaRB7+p6xBtopn146TCaDH50chdzbF+1YZLs9JCxTwleLjHI3xZOQVzIkh/GaW6hVDajqSGNd06rRftkDNvhRRkNGPuAEBXL1ktXHwrPnT6LaohcDINbjb1mHJwCVkDnlBdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmapnEgW; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmapnEgW"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so15401765e9.0
        for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 10:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779556786; cv=none;
        d=google.com; s=arc-20240605;
        b=HfDx60VfZcZmFctODZwiPvMj+FHG4uUFfqjWaHqsd3CyEKmmxhOcAlv4wfeXorRfVs
         hBTMMr9WNEhljO2aq67lcK5rI2UDlqKRexkVr1b3npqSkIekO0IjJASeUP8m0HAVPBqn
         6acGAxDmr2EbPHLUQehe2jBDBaQgRqqmEvX8yALn5mRkbAJeLNFQlBlxPBlhQsmw8c0h
         B4MzQNxYIeCqPfJf0no5a8FXZhkBErMNRTAFRfOIeT7t3JYOq3GwV9zhwuKuyu12bBau
         Fq5kjjkpNOaBQ1h+2kwpOGwISyTOfIxbSxdZXYPa81qt0O2RkLbOyx9OpyKINTLjRwWH
         zbFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=40aScu3o7jyER+7kTPK+D6ptkCZ+Wk4tkciyEzTWbok=;
        fh=jMibxxRU84WuAczv0QnAOYVv4kmvCXQ+PrC5Runqgbg=;
        b=XE+HXLUtEx6LVVpuBND2PzckYT8bhAGg581fEfzfeiM0OfCQDGnCn5afbwz9GIW+dv
         5dDaWx+wpoIsBfO9T2sDL3FJQH/s8ZcY1661YmYHjrtgGJatZLXxRGnyfYSL4/okJR3c
         H3k2oh/W5IIq/LFxqqYmIxmzxK4bsAXx0X+EfRCSzViDrKNx33Rnx9JpnDfCtmZ++Ut8
         idy2DubkjV0EoU1VcQh2NRofGfOGOprlspHw0scj5NXDQtJqa7pIWuuYNXnf5ngaKS5+
         VFTBAT9Kbxo2bDEtHXYvk5Ix/0yNp5/KCoL4tk5munj8Rl9jW8pKsgwG7OqOJg/oFQjL
         jIww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779556786; x=1780161586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40aScu3o7jyER+7kTPK+D6ptkCZ+Wk4tkciyEzTWbok=;
        b=FmapnEgW+t/qXrYFlRR6CiNQho+6JdY6zHiIJrj3z7Cju0g8xBj5aNzg5+2vEf5wam
         1qJE8GTahqWyTU/ceWXDMvVwFhVkWCWY8oPZSWncDZyVEB6ksJEe1ib5Ve+6opinoF7R
         SzAXJQpK6I65dRJSDwSu0OWwu8Ig+XNFMrdJede940h0EMJAKffgDmFImIK6Uj1eerGE
         0grBvsEwdrJBIi3F6LYNp38n0D3AeGdlw/oLx57p0xsmH7qC9zKZaGYzffmacqgkmhhw
         wcDvbvvAMZ0hzAchzGrpHtj3q/nH6a1Dv+W4BaUi+9JOgpmkgwLFPatgxAFvHj+29swH
         Dv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779556786; x=1780161586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=40aScu3o7jyER+7kTPK+D6ptkCZ+Wk4tkciyEzTWbok=;
        b=SERU3RAYohJw0IDuY0EK4CAOIpJwUMtGMMI/avs9TuH3B7aeaseDz1bIkKTsz/hEX3
         xSZ+DufKjK1RzShbehL6LOs88NerUGC6/MsAbkoq47IiHdjwNdK+v9cRrAfy8Ji4IuI3
         Oyp7ZUeev+RMDIr+gLsjugNdwtA8a0cNYGzAbF4QrqtyTsaWvPf0Vf7lH54/UxSYhXn+
         xkDp9oWd8VMftbYfjfmvxRN2X1Gpfrj+oACpS4HHixDXwBDJ41i0L5WWVsr0sWOeTpCN
         BmkWLUM38gY0K/dBZIpM/pgwpY0HhwY85jgkJejP3PKWey4K8T8W5diLNvTWGZX0GF0m
         /T2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/URceEXf+TUJ5SfcUPp+uDwKcLGWG1b6qmAAiGB6pCy1T21ynQCR8A5VK0KK4plmZ5wCXr/z6iAQV1V2r4zKR1yrMg+mY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkxqkio3qmHA7pOPJKu6VY+J67c/py0QQJzGLqMNmp8MbA9suG
	9hRdKrDrINxfGQfxRZaAy3eLbeGr3y9OyLqyknEBotIYkWAD0P9ukQen9iSQFTm1LgPDgCmMCll
	3MiJhR2dkrq8TqkxefuNt/jwZizQliOHZpeRjPpw=
X-Gm-Gg: Acq92OEYv/guYIz5Tws3EXCv0ZaKBiKuAxp/RiSadqlW72a2Gwt7LtaIsCqTD+IqeSX
	rZ2IpF3VumyEw30EJFI27zwGLw90vnkn3iZSuAmz/1jP87kliczzw9e2/OoyrfP60zzFkr2dl0T
	0A9ipAHeUvy+9NqenSHpI1ptfzjZpKpEQbPsL1MES/gz3V+H5SaSlCSTB44467nOV3FYn17ksMn
	lTAayTVcpbQlO3TadHMa2UppZzGOzOiXt4EMVNNyHcm2aWsEN6yw2Z1DZOVwOJIsbEbImYwhcxY
	o/fAID4NbqFN+Vww/RVfwEIk0+yS+F+CXorN5T9R/B0Q6Qpa74OLjFqKCw+sUbZSFLzE9Kq911q
	NgZY=
X-Received: by 2002:a05:600c:6287:b0:48f:eb8b:997a with SMTP id
 5b1f17b1804b1-49042ae285bmr129991135e9.31.1779556786114; Sat, 23 May 2026
 10:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523160025.16363-2-paul@paul-moore.com> <CAHC9VhR6RSq1TUgAyvHmaF01h87Cazy=BNJhk654BP8yfeSwng@mail.gmail.com>
 <CAADnVQ+WTfgO636GqgxzJ6r=jENpG704kmNAsy-X8=WyjMOV+g@mail.gmail.com> <19e55c1c1f0.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <19e55c1c1f0.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 May 2026 19:19:35 +0200
X-Gm-Features: AVHnY4K_2LOQGo6EDOyrLqN2RlxJguE4BGreszcdQyAdCmg4grCbohDxA-2rs98
Message-ID: <CAADnVQ+JDtc_GdxCv6tWAT03k85PTc0+zdcpCQ6NU-T8yJcu0A@mail.gmail.com>
Subject: Re: [PATCH] lsm,bpf: fix security_bpf_prog_load() error handling
To: Paul Moore <paul@paul-moore.com>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 6:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On May 23, 2026 11:25:55 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Sat, May 23, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >> On Sat, May 23, 2026 at 12:00=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> >>>
> >>> If security_bpf_prog_load() fails there is no need to call into
> >>> security_bpf_prog_free() as the LSM will handle the cleanup of any pa=
rtial
> >>> LSM state before returning to the caller with an error.  Thankfully t=
his
> >>> isn't an issue with any of the existing code as the LSMs which curren=
tly
> >>> provide BPF hook callback implementations don't allocate any internal
> >>> state, but this is something we want to fix for potential future user=
s.
> >>>
> >>> Cc: bpf@vger.kernel.org
> >>> Cc: linux-security-module@vger.kernel.org
> >>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >>> ---
> >>> kernel/bpf/syscall.c | 4 +---
> >>> 1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> Alexei, I'm assuming you would prefer to take this via the BPF tree?
> >
> > Paul, I see that you're intentionally trying to piss me off.
> > It's not going to work :)
>
> I promise you that is not the case. I was looking at the sashiko results =
of
> the latest Hornet patch and it identified this potential issue in the err=
or
> handling code that is an issue independent of Hornet. I posted the quick
> little patch above to fix the issue, and since the diffstat is solely in
> kernel/bpf/syscall.c I figured you would want to merge it via the BPF tre=
e;
> if that is not the case let me know.

It's in a queue. You can monitor it here:
https://patchwork.kernel.org/project/netdevbpf/list/?series=3D&submitter=3D=
&state=3D&q=3D&archive=3D&delegate=3D121173

But please be advised that when submitters ignore issues
found by bots and maintainers agree with bot findings
we mark patches as changes requested.
