Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EE9156F45
	for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779553557; cv=pass; b=edMQP/gmse5fIJgLpLzPuJ6Cs5AeblLqdQc0zFVLKD3McXNh9+jb1lbbrrn3aHrA9dVJry5xKlx9y4X/3DUTbMH0o+HXyGaNTa+dYcHro0fwJnxfQPhfk3vEwQGch1rWJS1U1P1avNdHn6KXwpXRly42pXyNF6E13F+3gaQPCHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779553557; c=relaxed/simple;
	bh=Ytx1TNVslP5G++K9RvHvRfsfI+CjjNPL/dw4D/mqN9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZxVye9j+E1ajzwZwS+gaJxT2KlXodt9rl7L0Cl8uzy64Y5EOq+8dIJYmkT4bDFSuyPpIjg5ZP/mM4Lj2h/3D5hgFlFqh3xWnjxPeYHkzD8eLOchcZTVREWH3rt3IZ4jb3j11vB8HVCjMKckeeB2xwD0J/UtxGqXljXiRP+fZd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q33XmCJt; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q33XmCJt"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49050bfe053so7068135e9.3
        for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 09:25:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779553555; cv=none;
        d=google.com; s=arc-20240605;
        b=Q/0Mrn/N73aJ0gV+X4wAmy67eyT5YBrYjQtcy2IG0ovjuN7P10Vfccn3MPOxwfZfMF
         2nqDDmMFii3cjxYPDOpkTijhlraVVilIU/AU6jnm6ihoTRRfWnKMpTE9ruUcXD8DR8Kd
         38eJvEAAaG0+OdQCxxiNlGTSe3+bodXwePYm7BLHc8pn0Co/kzoOfaYBRGBgWYWUX29C
         niC+hDllHHl34S0f+5JcED+kHfRGV37CCgcT7Np2VY4DICfRbfacPaD8KC71yCqNwifJ
         vqMnMiajJmZfd4JGKemaHG2CqPucdHox6wbghmZFMEAlVCaC63NuxDbZPqy5ta5ZZcqe
         r+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XqNQFHZHnntOXr5na+MhE8RV+67wpeGV8T7ZomckRps=;
        fh=DsuQlAyXnRpvJpx9VcqDpjtDtCX98ye8ru5WTO3728A=;
        b=eStzCA52FIIFI+f4+Z7h1D3aOdnb3L3VNlt4XYdXax4m6Cnn7stxNddc3EsoEp1XEu
         5Q2zHNmplWIrDtFkFU7YdrYvtgq+b3H40O8heyfBn7FwnS4Q4By1IE7I9c1aLZrGSFL5
         3kXO30JESn3JCl0nVK7Z8vOvH7awYFl/QPXkkB8Ksqe3uCoep/hpb+d9yy487OIlqTJK
         T/ruhatJjmjhDaYEZTfbMdw/ilvJ3kaIUSJtIqqA6ySgatZ1wE0nBvDKEdDBjGK3Yr/6
         GQ7JC3acDnt9FNRtgw8Bp1skXpYRXF5GP86otCQGZ3xxgNwRasSrX0TOd0Ecs2w/yBqK
         TQvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779553555; x=1780158355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqNQFHZHnntOXr5na+MhE8RV+67wpeGV8T7ZomckRps=;
        b=Q33XmCJtqaFjjo1hABj3BRBngSANBI3ext+cDn4p2+FLytrjguHEO/XoKFVvuSycRW
         NNGsJIkBQwbSyOFFymVaht6K6x1D/7iF6IzrCVG7t3sVPMOs/Kolm1QzFZk8phgFFyVO
         bn6ZjFB54cOQAIY37FUHOdGfWIGtR48aQuEAMvNPgvkGXgZcTYvX/ec+4pWTRI39RBuE
         Fm3r/jUPbGpr0N1LWFaZ7YDmyeTBkmXA82OdcK/QTKDlGuG/WVlzL/425XgTuPQokO98
         FOe36rTxQ2VH1bINUL7/5kxs1L1fypkYTpozXwul0cffp1J4i4Q6bauo/wLra55DWhp4
         bGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779553555; x=1780158355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XqNQFHZHnntOXr5na+MhE8RV+67wpeGV8T7ZomckRps=;
        b=fn2Z9NfjprdMJQpf+ZmMTn9uRe8D6A19Df9iehJwCdFdRzgT0FkWzVzrfXqXXo8b5N
         Y3XKWzaSQ4wFCvOfsrWsQcxDjb+mynRxrt1ot6yVm5cNJKwsS0y85Gb7hOHowrh3C65f
         zMmw0lx/3ZEEmaFzuq4/k/jwf9CxP14ttO+9ic6Wmhbo6cOyD//ziiiA4pOzaUrqdQxK
         UOpzsJAmDFwQMgOUYvJUfxVMJYYl23dC35QACcBGdpW1gLNHH8YtxHxkYRDohA47AvTM
         zo4qYxzenxDDCrU0yzSrVEsk7l/CYfClbUlCRTONJmO3DNacByC9psCazmz0DDZ6vHSN
         lusA==
X-Forwarded-Encrypted: i=1; AFNElJ+v5opF+BxtDCbgwfJsG6H95bOQSFc37/O4Mxu0Z5r2nS2XsJWbskGoirSTRoF5tcCiOWlu94QLdvxEE/cAeINH+BrQGXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLZQjt2B+fTGjZxYEFqQF4HzyZmagjtCrMc2/UaDdTkGKqz4Yu
	f4T2MkJYtXYqoL5Ra9LFXsCAkz8j1HjIgJTq6mvDryFR4/jLy5hMwgNpyepVpLzSGa4iOP1fubn
	Ct7RESe3QhRKwp7SfQjLdCDwIAZB73Ow=
X-Gm-Gg: Acq92OG/HUySieoryqbg2p10cO9tAx6XCADxGQ2Tlau0JDtCzsbR2cxXegebLtGvcIK
	awEhm8jCpLTE9Kpw4cnBMI/E5SI+x05t65xav8QHahKwWrxgLA8a0lH+Vj+CiHx5CcKPStxaj6f
	Ls3GlKQcrILTqJ9M+iUhH3jP9+U+lB2pvDhwrIYwwGjBF5DIyf2uDa1V+BitQR2AC1XYX2NUhr5
	oG5wLVqFzp0aY2BpPt04qb4eLe7HlPCJ1uGDUFE9QKbsgL1ex2B4MAE0ixedQnjeduZ2LC02BzH
	/BDKYyNY/8LZMD2zucdLpONyPyHyLGqg5X7q9M7LmcSPadcvBhWziXq6Q6v3/+68x/p+nFzfni8
	8nJA=
X-Received: by 2002:a05:600c:8b23:b0:48f:d5b2:7c1a with SMTP id
 5b1f17b1804b1-490425aa7a4mr127133315e9.13.1779553554536; Sat, 23 May 2026
 09:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523160025.16363-2-paul@paul-moore.com> <CAHC9VhR6RSq1TUgAyvHmaF01h87Cazy=BNJhk654BP8yfeSwng@mail.gmail.com>
In-Reply-To: <CAHC9VhR6RSq1TUgAyvHmaF01h87Cazy=BNJhk654BP8yfeSwng@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 May 2026 18:25:43 +0200
X-Gm-Features: AVHnY4JK-uiOQRjTQpy3Cq0F5W7oehGBntUzRHm0OSVAMLxwRID9xE1SJoyyQqM
Message-ID: <CAADnVQ+WTfgO636GqgxzJ6r=jENpG704kmNAsy-X8=WyjMOV+g@mail.gmail.com>
Subject: Re: [PATCH] lsm,bpf: fix security_bpf_prog_load() error handling
To: Paul Moore <paul@paul-moore.com>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sat, May 23, 2026 at 12:00=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > If security_bpf_prog_load() fails there is no need to call into
> > security_bpf_prog_free() as the LSM will handle the cleanup of any part=
ial
> > LSM state before returning to the caller with an error.  Thankfully thi=
s
> > isn't an issue with any of the existing code as the LSMs which currentl=
y
> > provide BPF hook callback implementations don't allocate any internal
> > state, but this is something we want to fix for potential future users.
> >
> > Cc: bpf@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  kernel/bpf/syscall.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
>
> Alexei, I'm assuming you would prefer to take this via the BPF tree?

Paul, I see that you're intentionally trying to piss me off.
It's not going to work :)
