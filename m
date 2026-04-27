Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525233B0AE7
	for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284702; cv=none; b=mrj4KgGVRgZMlQ8PuPg8cWPps1OfakPkCxzGCnf6YJGliIujpBRpt9e8XZ7RvUM/NH5wtMeArCtsn44tSKASqL+2yaoRfvjtu+QelNRXsViHXpSudSq3gGcjcM+tdyXeKRqKUAC6gmbY3VQjbzTxw0pst/1XGaHbZR/FSM8W9sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284702; c=relaxed/simple;
	bh=l7wjxc6XeC3LgGjYOTbi5TCTxWunY85fk0CHUoBMGb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgUSkr2PPCo5n8r83qW21Bwyo5CKlTCRt9Wj5Nff7KMY0v083m1yUf2PdJ/0Fbs/6ZnY5bS8a9r/RN2jd5MhCi2NMzVZMDlbPv0h9V/zi9a2HagUr2VH/TEG6vHKByuYSCb75Sun5SMY/1Aljyypz8ykOOGbgW3wrTqhYfSMGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IOrscSFu; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IOrscSFu"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ba7a1cc0380so1628454166b.2
        for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 03:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777284700; x=1777889500; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iqSLwhUABgmQL6fkPWkL9djFgyx7Rg8+7Mz/4y9Bugk=;
        b=IOrscSFuNGBCGfG0FTYOw4m+ZdZJrkapROZOpPTqr/wlm6IfC0kYqCG5Eyx9BzhU7R
         iwf4Ob6A79cIYCQGr+ZdJ/lggSagwEsuuoLAA3UgFPocXgBG7/YwE+rP+oOHfORIByJL
         YbaJyOC5CmN8JzEGvpy0lsmJ61kIzY3qGL5Oium7LfMJ3FfP0HvJt+gbWaGm5hC6G5HA
         By/MT+s1P7vTuQ8zfonV101MRyFhJARdJKuC0z1m4ls9MieRtrpkBSxvKY/RYkiyRC0m
         FMDaBnQ3r2nQmUYmdwV4e5oSis+fWipg6OnltMclsgI0pXi8anCFcDCTHQv9qHs893UF
         YZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777284700; x=1777889500;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iqSLwhUABgmQL6fkPWkL9djFgyx7Rg8+7Mz/4y9Bugk=;
        b=hsdknF7vMkG7Bt5z+pNrFCRKe3oV1PvvrHsfiFINKMtKFf2HUUWf/1sVJiMFhqcKG2
         FPBprqptkTaneVBiXuMl4iVMRr2GX7FpXYfPYTkk6vMuzHweVNTf4JtAOR1KejaGHKcK
         dog9MrQ4xTKzoXsIAyRqh8zLzqQ/kUyeR3MuSe3W8IrL6boskFTLO/CEiiAvNAdxcMnD
         TqZ/l73h7QfO/jTMPOFPxg3rlXQ/Fy6MaQQgGNChNF1aCXCA/BAC83rT0tY1earpyOES
         YpDR4bDQ7UpuOyAewyN2ESpyRbB4nL/HFXBhJCxrf6/3sh/sbn07NEr8IEqlxY4t1z2s
         Zi/A==
X-Forwarded-Encrypted: i=1; AFNElJ83jWleVCct1CGB5p/alBoiOC7U5twWt4c8vhPswcB9GTAQJezk1Y5h3RazUr25B1G34EDDaZ0MuyUKNWN0UN5WZ8f8xsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8QY5LU1a9ySMkK1cza9048FMJ1hTxIJf+cmPCCRd8RTOfWpUY
	6dms2cWz1wDinv15b7bRWFhoQFi5B4PjHA24zYFktmF7TeQIzw8TmrAybvCz5puJzw==
X-Gm-Gg: AeBDies148NMoXdWsfwWiglFeCSST0xUfdqxqQ2MyjogVOERPp7To/EAT86upPj3AVG
	yaJPgz+SyLkqqqChHMouAsvHq9lOwrD3bKLeZO7CS3zWjABNLkbevzxjwsaf/S/gII38XaKwYZz
	i/W+EjtQW262W/IbvglpyezYOcH9CaiShgXOw1jGvpPMxwieYeR0+6CP2UYzDw2OK6oMnOjW6zp
	l6vcKTnY3JNmb/91XVsa9ZCKWqvIN84ge47qd1eJE+xoBCncSraMp2PIPLIma04EEohIIriKWSl
	97e9gxsRIaVG9g/0pOcIIQB/aecojE5z3d1vXYynAAxSO0A6JghptdxYEATHsRyqhQLsNZOfOoK
	+4tQppA8DEmQDqK479a8PpDCtRg0c8k9HEGJ5RCCUG/GzzE+JDL2qQuZI78FFhNNgiVyO5NFob4
	QAIlmuIbSwclK0icDWQb78snCyTDGtL/L5JKGB0n/q1UjckU7Qn+TRxT+u75M+YjivMj/MUbtA+
	7dd5zIg1Za/
X-Received: by 2002:a17:907:a688:b0:b94:a1d4:ceff with SMTP id a640c23a62f3a-ba41adf8eb9mr2111430066b.35.1777284699048;
        Mon, 27 Apr 2026 03:11:39 -0700 (PDT)
Received: from google.com (57.35.34.34.bc.googleusercontent.com. [34.34.35.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-673032b9e83sm6723974a12.4.2026.04.27.03.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:11:38 -0700 (PDT)
Date: Mon, 27 Apr 2026 10:11:34 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: David Windsor <dwindsor@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, KP Singh <kpsingh@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Song Liu <song@kernel.org>,
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
Message-ID: <ae82Vv0RWzcXqSaz@google.com>
References: <20260427001602.38353-1-dwindsor@gmail.com>
 <20260427001602.38353-2-dwindsor@gmail.com>
 <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
 <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com>
 <CAP01T74WBjcMXbWYeaWB-oTk-bUzoxi_EEALDpT1hFUEOovnpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP01T74WBjcMXbWYeaWB-oTk-bUzoxi_EEALDpT1hFUEOovnpw@mail.gmail.com>

On Mon, Apr 27, 2026 at 05:32:47AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Mon, 27 Apr 2026 at 05:24, David Windsor <dwindsor@gmail.com> wrote:
> >
> > On Sun, Apr 26, 2026 at 10:57 PM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Mon, 27 Apr 2026 at 02:16, David Windsor <dwindsor@gmail.com> wrote:
> > > >
> > > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
> > > > xattrs via inode_init_security hook using lsm_get_xattr_slot().
> > > >
> > > > lsm_get_xattr_slot() claims a slot by writing to xattr_count, which BPF
> > > > programs cannot do: hook arguments are not directly writable from BPF.
> > > > To hide this, the BPF-facing API is just bpf_init_inode_xattr(name,
> > > > value), and the verifier transparently rewrites each call into
> > > > bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value). xattrs and
> > > > xattr_count are extracted from the hook context, which the verifier
> > > > spills to the stack at program entry since R1 is clobbered during normal
> > > > execution.
> > > >
> > > > A previous attempt [1] required a kmalloc string output protocol for
> > > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
> > > > provide xattrs for inode_init_security hook") [2], the xattr name is no
> > > > longer allocated; it is a static constant. We take advantage of this by
> > > > passing the name directly. Because we rely on the hook-specific ctx
> > > > layout, the kfunc is restricted to lsm/inode_init_security.
> > > >
> > > > Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-October/034878.html [1]
> > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6bcdfd2cac55 [2]
> > > > Suggested-by: Song Liu <song@kernel.org>
> > > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > > ---
> > >
> > > The explanation and code make no sense to me. Why not pass xattrs and
> > > xattr_count directly as arguments, even if you choose to restrict the
> > > kfunc to a specific hook? Why does the verifier core need the hack to
> > > spill the context and extract the two arguments?
> > >
> >
> > xattr_count is an output parameter; we cannot currently write to it in
> > bpf as there is no verifier support for writing to int *.  xattrs and
> > xattr_count can be fixed up by the verifier, so we only require the
> > user to pass the name and value.
> 
> Sure, but the kfunc can. Did you try passing them in directly?
> If that doesn't work for some reason, we should fix it instead.

Hm, perhaps this fixup approach might be the simplest in order to
assure the needed safety? Allowing this new BPF kfunc to take xattr
and xattr_count arguments directly from the BPF LSM program could
possibly result in lsm_get_xattr_slot() to go off the rails, no?
Unless, what you're proposing here is to also add some provenance-like
tracking such that the BPF verifier assures that only the BPF LSM
program context arguments end up being supplied to it (if this is
something that doesn't already exist)?.

