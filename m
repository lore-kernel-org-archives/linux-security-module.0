Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D28E3CE4A2
	for <linux-security-module@vger.kernel.org>; Fri,  1 May 2026 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777649856; cv=pass; b=coqlVcRzLwNoGUSa19iGMEmtMXoOUZ8QiH609P0Jmtnmg42p2edhc5h+h2MvtOZU5tZuwp+WtrzDBUtC5cg+HPJ9oM4jy5+Hy3wFbPEo/SudYhqFxABd1I/WQiului7JBYYzVp4Tzb5OlJmL9zU7n3gpnHGq9f5+x0ZJEx8fySY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777649856; c=relaxed/simple;
	bh=TmZOkd4LjdDYloHzxeaTkn/dgtYW8v+Yk+8UEv1tCuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+2Bb2BJzGIE03cHq1zrDs5oJIwtEKuo9Gvwnfbm8FIf7AO6gdVXUN8ED01ud9VFEuj+hdAf9fqkVxaXms7WRSErhU+jbyao2puCzTcZYF9JzYDdgcwEorKnCg+i2EgIw8vtjM4/rnfDJJDpRLyR7YyJzJfNuW+mUW8/wGdA3Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXEE6EtR; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXEE6EtR"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5102582e23eso14995441cf.1
        for <linux-security-module@vger.kernel.org>; Fri, 01 May 2026 08:37:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777649854; cv=none;
        d=google.com; s=arc-20240605;
        b=DU/B13lpAFBuKf/mt89sRWm05D+zm0F1556N5RWPotgWqjFBaBtAlsrX7FkS3zpDf6
         uFMfrG6C00l9rZh2mDUfbHC99ByXGQAvobX4NQJadig9eiAYTBJxk3kkkbj7jt5b3NYB
         1SLLGXl18suSOqj++31+UFcttK3I06s5eZbZ2xYltrGKqIY4nG5/1Uwx7h4kSgtMy5gl
         ju23uySBTi/e+76Pxrjlx6iB+pG7rRvLLzzfvX+bxfT4cZmULCADDMtaUAQFbyISHLSS
         oNfOnKE7gJCNO3KGklJminnyRMbK9ROzHcC7pgXPLBPAgH+/hGWTKt2QFbOTO5mUwjA1
         4Yng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TmZOkd4LjdDYloHzxeaTkn/dgtYW8v+Yk+8UEv1tCuM=;
        fh=VuLN/ava3v5W6vW2k5abJuV33nz2lrd6blzbHs/DM84=;
        b=f0XRQ6nw57e2vz9nACLjzUyXB2EhrE9fetoEap8TcgffdwkuwNIXfIo0v7IBIhjuOY
         9B9v3HrqBSb1+hyLnbRewsQzBy2pfB1xFex6gP18JfhzzO13TdtDSBTA7r0v6kxlbiks
         YIos+3bVtts6NnR8CSmbKRCQejJZfKA6xJhfxQy9KPzfXmzo66VTmH45KixX/Fu+DXdx
         74z7zQU6KiazpxNyzaNnokIm6aubRG542Bwyqv27T8WQn2j+YW0g3gI1k917xPWJt0+F
         YWvFTTdhDEciEIt7dOcmVISBg551yRdmreNHu7kBO0vgiq6+dPo/3aLWa6KgQW7bVJ2M
         KHcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777649854; x=1778254654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TmZOkd4LjdDYloHzxeaTkn/dgtYW8v+Yk+8UEv1tCuM=;
        b=FXEE6EtREwYj4KAs1LNIJ1N/UwhJG0PZ7wgEEEvZ7H/ieYXQqZE9B91k20MCTkHwVb
         nrq4yqaZCSvDix9tSJwSVgyjiadaEIGkN91qw3HS/EyVzEKX1gdqbRETmnLar8ldIJ4W
         js244wvNIEnkSWXNcCtdTou86m3rrW74e2r5WC3aikTzH+ObvLrnwStoce5evLSlgRrk
         aR/I/3s2Onm0sFaIQao7dUpCW03Vgjg/FJQLV/RYlt6ZtXvsVj/uKHi3As/5O/eoD+Xy
         aQFqsCfAN1hqAzkp6xDsKuvfOnu9699HEjlQu6Q8PdL7RVTrP1tMLfRDPLUgfjunJ0Ah
         GiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777649854; x=1778254654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmZOkd4LjdDYloHzxeaTkn/dgtYW8v+Yk+8UEv1tCuM=;
        b=tMT/NZyVlNtoGThN6J99tytY+7P/lV6zNuBXN9/MgCdXcvTFog3790CyUV0Nv0PpOp
         IoPwVMScj8gC1Zz0XqrF50brdybg0Qg5afuFGQxj9BwPgkNXuTH9/qf/v1Ebm6nwJk2t
         Vef3DqABdGzh43vnWZSmP1tKZR5MAq18p+Eo/rxZTGQ9pFHvPNqet0J4ZnIRJgX64yUk
         h8MzN1MC1Wbr9cHUYm5s2FwLT1UFRaaRpwnwAKPGquMSSDLoJjDR5CD91BKLa5A0y0vo
         QEtvBtPTbeP8Ql4J9FvWCUoSBKKuCAtk3k+7lP97TVyvLpwH70Mc5hMyjssCEyaU1aGe
         hvNw==
X-Forwarded-Encrypted: i=1; AFNElJ9whlVtylnXy9UdsJSPmPNV0vdGXv+mRdomsJo+MGTRjSXw9dmbRUVs6Yfx4s6DNGvu4sEVCGkP8AYdhdp2IC6jqXJRmAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZKBhJyGs+rzUSx6TexE4YSzndjJDb5vkZ9nCtG7VgN7kU4tfP
	a2KENX7tOQcMjVf/GCRRIy1XgM/0psVC+2a4m9WI6VUyDrT99SIu0AeY7xJ+vOJ+1xmnzIanbJb
	bMxX7+SJZgUspPHxwauYupjEqnBEEpqk=
X-Gm-Gg: AeBDiesSOKjBvxQ+KGVDi355YrrpyL9ZnuQKFzj8VqhifK8OdVxzDVwyYNaC2x6eQDJ
	pdH0TjhZq1twKrPJ33Cfe8a4TA/kLGCGe1spcuozAuYZrYF8RvQC8tZPt161wk9J4MOrkyBXFCn
	9g1Qr1LaN5Wp9r9TW6eC52tTA7tfTyYrAGw/h3uOKT4Ya4iqqFq2JLelYx06HvDP0XyimaqD4RH
	lv8m5Zq68oez94usssd3wFMTUn/MHhq5bems2uGAbdySzVfIXW8qsLTO9sUSYhK4QMSf/Gz55Zp
	6uwGZiKagDp0brGaDUWPBFzzHznx4QDXx2nHpiNOEcQ4d2N1oilW/2H1yG20rQ==
X-Received: by 2002:a05:622a:1390:b0:50d:86d9:4c24 with SMTP id
 d75a77b69052e-5103e801278mr51004741cf.12.1777649853785; Fri, 01 May 2026
 08:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-1-dwindsor@gmail.com> <20260427001602.38353-2-dwindsor@gmail.com>
 <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
 <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com>
 <CAP01T74WBjcMXbWYeaWB-oTk-bUzoxi_EEALDpT1hFUEOovnpw@mail.gmail.com>
 <ae82Vv0RWzcXqSaz@google.com> <CAPhsuW60SRXZbFYRDm-QaTiB8tTtJD_N4jk1=680x5UsZmpj9w@mail.gmail.com>
 <CAP01T75SBw6NNvBKyPW11JSYY2oh449yoBsWi_GOBR5Kq1ykmw@mail.gmail.com>
 <afCUADdbNrpbEPMa@google.com> <CAP01T76ipTgY3EM8uMSXymdO4co3AWZeXqwV3amqDnHiFXhrTw@mail.gmail.com>
In-Reply-To: <CAP01T76ipTgY3EM8uMSXymdO4co3AWZeXqwV3amqDnHiFXhrTw@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Fri, 1 May 2026 11:37:22 -0400
X-Gm-Features: AVHnY4LLx68NFbw4R6d2DByeiT2ksgjJ8FlMA2rRsoOrBqjrTHhEtUSBsgoGVxM
Message-ID: <CAEXv5_jkPwf1EGCd3OkCzsnL_dF8fF=x-RNKSuvNZn24Ns5erg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>, Song Liu <song@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

> >
> > > Even if we wanted to ensure argument provenance was stuff loaded from
> > > context, the right solution would be some kfunc flag that constraints
> > > the argument to be derived by following the ctx pointer, not whatever
> > > is done in this patch.
> >
> > OK, so it is provenance-like tracking which you were initially kinda
> > alluding to here. Currently, I don't believe that PTR_TO_CTX is
> > preserved upon any subsequent R1 (ctx) dereferences, so we'd need to
> > think about how this type could be preserved such that we can enforce
> > this kinda constraint (__ctx) at the time which the new BPF kfunc is
> > called. Do you have any ideas on how to do this?
>
> I think we'll have to track in the register whether the PTR_TO_BTF_ID
> came from a PTR_TO_CTX load. That said, I still prefer changing the
> prototype to pack the array and its output size parameter together. It
> is even clearer to have a well named type than int *xattr_count in the
> prototype.

Thanks for your feedback, sorry I've been busy this week. I will send
v2 with this change, as well as Matt's suggested change for guarding
the bpf xattr namespace.
