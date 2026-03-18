Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2171EB9E3
	for <linux-security-module@vger.kernel.org>; Wed, 18 Mar 2026 01:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773796573; cv=pass; b=aXB5vv2HUhIfLDJ+U5OcUwRCaAqEC7Aud2n51jv8TWjTdJqfwsBHO3OETzHtIaSokIc+ImcnmajB3Sowx/5zPBZOBaGlp6RDse8X1PlBaTdygFDFCHnxdJCpRMPoHFLe7UAIDAe/qB1G7ySKjJww242x6f1RGnJMqO+urVJko3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773796573; c=relaxed/simple;
	bh=3w2OBXZSRP6xgeoDfIzydCPozvN6W2306MSC+T9kb58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tE+58aaWGIlP2b6BURleueyqv+Yz6PHo1noE9JSbxa3SPf2V0pBd/x/KEJxXp1rKUy6GAsSY97ki0kuR2RKIAk/A7GhhW8XafPOBr6uv1U6xNFSRmBus5s7p3OAUe647E3BoGu4gfraV8yTFaFm7oT79KUF/fddYEKNGIweL6Ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gwNbXNsF; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwNbXNsF"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so71360315e9.3
        for <linux-security-module@vger.kernel.org>; Tue, 17 Mar 2026 18:16:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773796570; cv=none;
        d=google.com; s=arc-20240605;
        b=Q7RP29QiUhIEmttzN9Xj2Igsui5e/ibNTncWbXAr+FHY8NKNTT1bXT25hN0Y4OTjaO
         D1GI1WxYyu09QyQUDz+EGVK5EwHA/zx4TyAGZkxBi6XB0c13uaVd3ebe1lNonHNUR28l
         SdZxb70bej3v6IuBvmUnqmBGqN6GOBxudEcXNT3tcr7Q3az6fVIQG56NdpQXGPrLeBJJ
         7P/1NOKKTyWobn1B9x9jya2CcVFGcnxIiPHA8Zt74Ck8rv2QY7qrsoUHr7oUXXFrj+oM
         CBO4IZUmY2Jie63GoCIlu/lZ+RGEbgFGcAP5l3XWn+peyk1F1piM1Ac+4h5eLUGE9r4R
         AqUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3w2OBXZSRP6xgeoDfIzydCPozvN6W2306MSC+T9kb58=;
        fh=CJZPmZID62+31W7rkk43Os7HRqpogRERZ9xm9ldsgmY=;
        b=gqu94pI5tHUFlYypvQzhD4O3TLrmFhppiztpdpNeIiQRaLY1GeRFiBFa8h3rq8n/jH
         Zdp5uh2kDby0Ze5AhEIuAtSc3vv4FBq6J7MKmwfChCTXsCcliYhBYmZuamjU//N8xda4
         IFXfuh+2g7O2Fc1K//IvTaglU/QPkcTlTSoNzp+lqYvAyE28IxpgxLAIYoYvM60NHvC/
         uiYvZULCAcel7i79g7mQYvwSBy4NLFBVfHZyFPbifpecps+XYdiy3wUf5kkhavGvQMUD
         m/+odn4nQeA+HFpx9j/z2kpbDR5H5iw+/F1jABywmRe/RIB9Y6RI3l3VW6BQ6HDYBgzv
         aPyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773796570; x=1774401370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3w2OBXZSRP6xgeoDfIzydCPozvN6W2306MSC+T9kb58=;
        b=gwNbXNsFjJ5I/rKMUtQV0RcE8uzPvaeiGNXV9yRrfF3jsU2WqReVgITC+rdJf4VWId
         2Q3Wqy/4mb4oFtqwNXgTNf7ZTX0ty08lzY2QTNj9GK/iIt66kbgevofTQrx5LqnOnkUF
         xtfRftDGYI3Gg1HBpFa7CDJNx61668vS20asflQgQydFp8SGyRylv6mASjCoxy8RqG4T
         cFRESowjz2A+czTkSOlFp/Z2hFQ5LEQoRrBwq6oP7W8iHZY6AnCybUmUCY4uS3N3mUzQ
         rg7nSjsC+DpBj5jWYS+4EENc7UWuqQPT+Xqxn0jJF8r6mqjyRoLCS1SaWpIAEc49hKCA
         AQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773796570; x=1774401370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3w2OBXZSRP6xgeoDfIzydCPozvN6W2306MSC+T9kb58=;
        b=joMB6NqQ5aXzQ57pMhFtHf+9oOgGemP9GffuEwF3iP56J7mDD6wH7BSUZxfwxxPkk/
         uiB2af61H2ZIlPSQSuIBZCOXQ6dzpti33RpF7tEoi9ygb6IeuhR8NbiwC5Y5lxPz+e2n
         d4hNWlJxsBWq5Mzn8V4oaei5j4IE+8sWo+QhBdmZGPYOo7BllJkyq8eedu59baI3yLOy
         jaqnLg39/LGLDuo1VnhJCp65Ec16iHZ1mFnMIvO7rnk9B1QXgp8te0f/6n/UDMKsmpf8
         kP+VS2BtEjzwGcW7bsKmxmxTvVecWbmzvAnk9y6wugJ/wDWzFWt7hfGbpnDj7mefCqeP
         yH+g==
X-Forwarded-Encrypted: i=1; AJvYcCXyhre2DHnyUiQkQf+rKgNeO7KKFpUzMw2nW0kHpN1ACf5fGAnR/xrbEatPOpDB+L7fVfVtRTPV5+TpFlnD9JdkEXIkM4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaxHpR4I/0+HttSZkWsyepdxPJKLd5fYNbgWSAIzgyjWvd+jU+
	B2nk46TfWYcrueGUFAyg9qx0G7G5X4SbdGeWGcZfIaNWbSCyzPKRd7RS0dM8J9jQ96R/Er2jWAj
	ID1SB1HNaDvmWLbylNCb9Rn/gFZlLHnM=
X-Gm-Gg: ATEYQzxXoX3co7zzPGIIP1HMP6zOV714c3Z5MzAr87GF8KQ8gk07mn3UmvkuBJ1qZVC
	KhaMDqNI4WpIszOKJE6iGg49SX5twueZ43BB/AKKq+zidC6/6oLPqzdaEb0XnL3SO6upUGSY0RG
	5qGGIjnO7LeBz/E+ppX+n6f6al3QHhzZ0BOS3JPU7RXbrGvNmTywSnAM9egLY/DRzmYRMKNkvgf
	WzjMw61xV871ioARz5GLg3+0rSdwhkEsNd3G3SynkoOFvwEJrPHmfsLaQ7pnq0ShqqZcDAmXddF
	5iP59ogup/fgqDuhdWZcZs2e6kWo+LomN6lCQJL8iKVvEAoHWUK/mlw4Hcvtr9HN/d2iZ7gctwf
	nC8balVp0nIUlkg4hFgVkS1nYzQ==
X-Received: by 2002:a05:600c:8683:b0:485:f1d1:8f3d with SMTP id
 5b1f17b1804b1-486f442e6e5mr18435595e9.6.1773796570321; Tue, 17 Mar 2026
 18:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-bpf-auditd-send-message-v1-0-10a62db5c92f@cloudflare.com>
 <CAP01T77VyW=5SHDvM3HXPNHaxRdzs8H__MOh2zx1dQ6STeAUtg@mail.gmail.com>
In-Reply-To: <CAP01T77VyW=5SHDvM3HXPNHaxRdzs8H__MOh2zx1dQ6STeAUtg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Mar 2026 18:15:59 -0700
X-Gm-Features: AaiRm52ZhrulSIFyNHNiIzRvMopWhhEYRIriCdPJwA716TKmoKnUrKQyqpBcyns
Message-ID: <CAADnVQJCJaLjGCwjCX9VtT615c4kn7v5bxviUmGFVj=uTtUHMg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] audit: Expose audit subsystem to BPF LSM
 programs via BPF kfuncs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Frederick Lawler <fred@cloudflare.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Paris <eparis@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, audit@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 7:44=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, 11 Mar 2026 at 22:31, Frederick Lawler <fred@cloudflare.com> wrot=
e:
> >
> > The motivation behind the change is to give BPF LSM developers the
> > ability to report accesses via the audit subsystem much like how LSMs
> > operate today.

Sure, but bpf lsm-s don't need to follow such conventions.
audit is nothing but a message passing from kernel to user space
and done in a very inefficient way by wrapping strings into skb/netlink.
bpf progs can do this message passing already via various ways:
perfbuf, ringbuf, streams.
Teach your user space to consume one of them.
