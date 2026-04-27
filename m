Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDD63770B
	for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 17:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310267; cv=none; b=kRxzzGwLfGbq1JNsTVPs2c13IuG1Mp+rQFfU7JTHhpZ9Xz1A38TWbxLREix0PcfU3mXMM+9SZ8agU7U7mW5BuBdOaFr6A8Gd0ZtRbvrJkDtQvgacW+U5qix/xr2gmY6tGD95pSwKH4HnLK7xZSLJusvKQta0Kv+hG+TsWkb0U0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310267; c=relaxed/simple;
	bh=bHsD2rNRGO9Bs4Khd6qr4KqkCHgNylm5PmC7wIUXk4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1tAHl7CJ7CEy6uXCMFCeoWUdf+T9X4wrfcL7G4rywMFSU5EvspZekqRzm5T5LuXerTBG2j/iE1vDWn7/A/lnGd3THdhA9itzS7P/Q2wxrSrx1BDIO4tfpxGpJTXOqalJCAJuU15Bw6CQ3U4jRitVJCU9+hQ6iLQmeiAY7niEZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWAZWncf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWAZWncf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4BAC2BCB4
	for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 17:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777310267;
	bh=bHsD2rNRGO9Bs4Khd6qr4KqkCHgNylm5PmC7wIUXk4k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rWAZWncfIYQTYxiG0OWjcF09zc/g1KYsQQDqroa2iJKxM0CmyEslyIkB/Q2DgoIJ3
	 o18QwV/7ofP591x7MU+VGFRUvo5Gja/tN1kkrTblN265nBStlGa1H39W9ABL9eCoRo
	 qQGUqODS3WxN5F1jT1nH9/zQIAvnmZrbNbrRKk2aj4x9V/mSrPXZL3s2FF1jTx1OVV
	 hv7rFNqxQMVFEBoolchHsyA7qU2xLdHw1PeyW1vFCQfVX3+hSwN0FFYUwnuF1OWvIy
	 5OYezI7sm/bPlDwT1D5590YD718EsNf28Dyg0iLR3ulPNW10lFvWKz5mkRf8HH+BdD
	 DlAU25ffybFQA==
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8a08fa355a1so153728146d6.0
        for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 10:17:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9M1yuFbYPO/oVN7czuh0FthkftNRfBh/3b8l+PcifnBmzmKYwaLNC7R8BGDrU96JifLOXM+EEY3PzeFsmtgf6zCgAxiKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza57h2J7nock4kI0VaS1RSCEEGflWMm7DoR/lg8tUBikAv+vd1
	nY8hb9lLg4t78cnaR5t6PJw6BsF3cnsNVmxCT/gIvEfRwAYGeAWQJbL16eyEMCH7otZJybx6T0+
	fR69RiWQtoPVMcgDZQ9Wb0vjiOORcQoM=
X-Received: by 2002:ad4:5c87:0:b0:89c:6ba4:e306 with SMTP id
 6a1803df08f44-8b3e298cfebmr208836d6.43.1777310266594; Mon, 27 Apr 2026
 10:17:46 -0700 (PDT)
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
In-Reply-To: <CAP01T75SBw6NNvBKyPW11JSYY2oh449yoBsWi_GOBR5Kq1ykmw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 27 Apr 2026 10:17:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6Zew3xYT4fOY-QR22d7KVvnCRdyVJ=9yn9qB2FGtBq7w@mail.gmail.com>
X-Gm-Features: AVHnY4Ifi2VKe7rSzu2TuozyWS-bV3yNEzpVKKs38v4tOrQHYw6ZxAzmrBHxWfQ
Message-ID: <CAPhsuW6Zew3xYT4fOY-QR22d7KVvnCRdyVJ=9yn9qB2FGtBq7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>, David Windsor <dwindsor@gmail.com>, 
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
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 3:33=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon, 27 Apr 2026 at 16:21, Song Liu <song@kernel.org> wrote:
[...]
> > > Hm, perhaps this fixup approach might be the simplest in order to
> > > assure the needed safety?
> >
> > +1. I think this is the best approach I can think of.
>
> We're not going to add more and more special cases to the verifier.
> The whole approach is unscalable.

Agreed this is not scalable. One potential solution to this scalability
issue is to move the fixup logic to struct btf_kfunc_id_set, so that this
fixup logic is distributed.

> If the concern is that int xattr_count passed for xattrs can be
> unrelated int pointer obtained from elsewhere, can we pack the xattrs
> and xattr_count into a struct and pass it as an argument to the LSM?
> Then the pair struct can be passed in directly, ensuring both
> originate from the arguments passed to the LSM. That should eliminate
> concerns about either being out of sync if obtained from different
> sources.

I think a trusted pointer of the pair struct will also work. But this means
we need to refactor the LSM hook and other LSMs. The refactoring is
not difficult though.

> Even if we wanted to ensure argument provenance was stuff loaded from
> context, the right solution would be some kfunc flag that constraints
> the argument to be derived by following the ctx pointer, not whatever
> is done in this patch.

We need these two arguments to be the specific fields in the ctx. I am
not sure how to do this with kfunc flags.

Thanks,
Song
