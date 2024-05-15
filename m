Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BC038F98
	for <linux-security-module@vger.kernel.org>; Wed, 15 May 2024 20:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715805148; cv=none; b=Or0FAa4biRL4MI3vBzW9IkFsuxh7xjEhYComSU62lk9ad5vxb8FnFVRYDKqmhxwRMxeJhDgAEnWeLscytCAVTO7eVN1+fPNx57IBV8Eh1Q3R7Y6cbvILehNPHwNLl/bncF/mFpRuQZW88965PGtsrNBcJi/fR/xFFPSFefx79is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715805148; c=relaxed/simple;
	bh=iyv87Dbnyu7gm4af/LI0TOX4gLeF6QvKnfsIZOOyrfc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KNYu0F9VxnD3LxalppotB0aSQ2UUZxtHhH7Fmj5HnDlegv3vUSUGHD8+1+0Dyc9hyNgMqxNnZoB9TX7uWsy3yur5pJ4i85dWBqVxxWDYb1iPHRc/miqILZCtsb2DWxo79nl18tMeXIvbQHBQRX4EbtFKO9x8TGh0EPj9oVpu6Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IoC4VFaV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IoC4VFaV"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f474d5a8dfso5600970b3a.2
        for <linux-security-module@vger.kernel.org>; Wed, 15 May 2024 13:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715805146; x=1716409946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyv87Dbnyu7gm4af/LI0TOX4gLeF6QvKnfsIZOOyrfc=;
        b=IoC4VFaVrOG9IwUtxlTf5JQhRfjVAINdoFMaz2K6UvhWAZaGiWDmBx7t5fZQyuYCnw
         cwFP1+Sfgf9abXcU4uYL0yISHzKKG/IdIJe4U0dvVGzIX4MD9fmH0Dg5bxuDS9DHvNlL
         KlT5Iaz1KjBHhHpiOfQrZzn3eAv7mPADawJZeV2tMMYA1UEHuZiJdVwbSvBkiAinsbrG
         6fD8RqoYI7ZP+1p5/rcLleSTBA6EqC0nV2aWhqYQ1owIpvlkHcBMTHfrpI8YlR4N1Zia
         DPmP8ZAUkw+CKu9y+agPDM+5zMurYcsKCkOmQJz1pLhZt24Vh4vRXJM1DrZHnPmPMzdq
         Wmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715805146; x=1716409946;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iyv87Dbnyu7gm4af/LI0TOX4gLeF6QvKnfsIZOOyrfc=;
        b=KLrYIQn6f0oT4Cap1MpQBSpfyKD8R+SfJOk79jnZLZlVfn9S9KNEeF/wj884XqdDbh
         bHpwVwVkDAmHpZXOd586I5qkP2I/SRrEDaeJE/NXD1JvPQTVG5DTKnj1QVRH/GvSLB/o
         6eBwpbneFvnEKPgapdZAIY5B+Mudw7vusVFSV1kXVx0NyMB+z8XDCn7WC9h9UDI+ICcY
         myPcHF3NLQrcCyXQruzz/X5sPsipCQ2094d8kBij0hFvcSLiA4/2yBh/e0nwlS5BxjvN
         qd/XAn4pSsBNJHkQPwwpKSVJcmyb8nDh6t6Vt4fWWoCNOw1G1vqtB/TOTmtYILJ5xCdB
         s39Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUk01hqP2lAjmq9w1VjIGAP2noXCW8LmOdQJat0j7luBP/TUxDbgQzmRXFd6G17m/SnNl71vkc70VMG+OV/ph6Xu679wVoLtWI0Coj6kP6+y4MEPVz
X-Gm-Message-State: AOJu0YykGw5LpHeHG3teVqPVgDoJ5Z/KHQjHq3FWs3IOAiA8CYlH1Z45
	Uh53inQXFbyhp+1Am4wRjKakNTFR7dFUTz0ILQwKUK2XVxvqoZne9fLXLW1bvSYvosZH54K7TBk
	5KA==
X-Google-Smtp-Source: AGHT+IECDBDOitjYW0H0HtQ+B5fogjE5oB/VbBha173B4uff3BsqArnMeFZozd93oJEEJOGvPRJpNAKBnf4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1d26:b0:6ea:baf6:57a3 with SMTP id
 d2e1a72fcca58-6f4e0431a08mr1169393b3a.6.1715805145969; Wed, 15 May 2024
 13:32:25 -0700 (PDT)
Date: Wed, 15 May 2024 13:32:24 -0700
In-Reply-To: <20240514.mai3Ahdoo2qu@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503131910.307630-1-mic@digikod.net> <20240503131910.307630-4-mic@digikod.net>
 <ZjTuqV-AxQQRWwUW@google.com> <20240506.ohwe7eewu0oB@digikod.net>
 <ZjmFPZd5q_hEBdBz@google.com> <20240507.ieghomae0UoC@digikod.net>
 <ZjpTxt-Bxia3bRwB@google.com> <D15VQ97L5M8J.1TDNQE6KLW6JO@amazon.com> <20240514.mai3Ahdoo2qu@digikod.net>
Message-ID: <ZkUb2IWj4Z9FziCb@google.com>
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Alexander Graf <graf@amazon.com>, 
	Angelina Vu <angelinavu@linux.microsoft.com>, 
	Anna Trikalinou <atrikalinou@microsoft.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Forrest Yuan Yu <yuanyu@google.com>, James Gowans <jgowans@amazon.com>, 
	James Morris <jamorris@linux.microsoft.com>, John Andersen <john.s.andersen@intel.com>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marian Rotariu <marian.c.rotariu@gmail.com>, 
	"Mihai =?utf-8?B?RG9uyJt1?=" <mdontu@bitdefender.com>, 
	"=?utf-8?B?TmljdciZb3IgQ8OuyJt1?=" <nicu.citu@icloud.com>, Thara Gopinath <tgopinath@microsoft.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, Wei Liu <wei.liu@kernel.org>, 
	Will Deacon <will@kernel.org>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	"=?utf-8?Q?=C8=98tefan_=C8=98icleru?=" <ssicleru@bitdefender.com>, dev@lists.cloudhypervisor.org, 
	kvm@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, qemu-devel@nongnu.org, 
	virtualization@lists.linux-foundation.org, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, May 10, 2024 at 10:07:00AM +0000, Nicolas Saenz Julienne wrote:
> > Development happens
> > https://github.com/vianpl/{linux,qemu,kvm-unit-tests} and the vsm-next
> > branch, but I'd advice against looking into it until we add some order
> > to the rework. Regardless, feel free to get in touch.
>=20
> Thanks for the update.
>=20
> Could we schedule a PUCK meeting to synchronize and help each other?
> What about June 12?

June 12th works on my end.
