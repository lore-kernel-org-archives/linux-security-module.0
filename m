Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AAA43D4F5
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512206; cv=pass; b=PKN+HY+hjfRCtSdMTGihEcDpEhRLyGzAgYGJ3UuPeg1mjYbxs8lnNJU/Primons3RNdAB2ngT3JmHZlurLxcnnTXm5O9k49r/ioSqRyQ51VM3tiwSw3UJo91qV9FSRnbbRz3mci//02WwppycH+I4A+CEXBmK7+vgDaNDLe7LVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512206; c=relaxed/simple;
	bh=kPzEtdgmgmrhfEvclMUzFEFQMW3YYfNU1BZsWa7XSjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aySWPNhq3vqxsIadPhW6u1EVlZDQoGIe48CfDK3z+XQSBYSyH17XvNSnOpirQVYHkqn6FFirDgpiRv2a1DARbQO6LyiU0O3Wa18FcogT09giN7RUbj3aULKLvFRnM80zf1/cLQk3dVDUhTc3aVIzY3DNNymfqTwS7T/yQVFgddk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFc/OdTg; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFc/OdTg"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c08df8513so6398591cf.3
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 08:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785512203; cv=none;
        d=google.com; s=arc-20260327;
        b=sEA9YlZa5OYl8Kkz7bqTarbecX++OzY8jb76JgU+SUTuqdgThERQWNj121OAs1Sxb5
         9PlZyLfpzeHQyWyo7abgXdzkriXcNO1xoNJYW8Y1uVohA1LHGqlXv5ywACI/KqjUQfhe
         i4KpwU1KhqHiz5tiGe7x08O1kEDwBDgJnTrk3ysHDaTC1dRucoGu6cWnf7bS8isPQa9o
         xZeJDrCqXmr8kwsMTDL/1hYjRxoPwD4SkPp29LQAS0zyoGEMZNJQBzQVLhRFuE4hwxcf
         0fKa0W26EB5crleTxFd+Di93sDfNvBJGk50cN8r2xI2hCxjesoB4HFG238t8jAFFGeXg
         7u/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X2Of4jWCRo/X6Jl6mIPChW/S8CvY8JmNULo7wwzgn90=;
        fh=nEOpb7lYSMicQ/6uwBePxqXv6J2/hYso2dWmxJm2WS0=;
        b=LM9w8+Ld1K/9WCHLXu8RYLMBKiNSca4zOBEr2stBbfn0lxhlZTLz1HTvENzJPfdQbz
         CCUxO94Z59Fk3XVaKYLePXvqwHHzu9Y8hQwbmUCu31oojdBxvd+nk/7R1P8MnLEMgnt8
         ELXSjYBar998eAF47jCOUCt+iLs3Idtnip8JRf5dcdKR1Vr/lspjuyEjhcTP+Kex/K4j
         GqXhnc2JRbsr8seJI8YqB9qjcwEDSNtXtSgs6UoBo8+k9360JQxFpsxra0WHt8HguMRf
         dyDttCdhF/uulKJgMJa80Yunsc1bRNk+rDuLmxq9yAJcvoGx13V0EgsKcK/7Qucq7bEV
         oTMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785512203; x=1786117003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X2Of4jWCRo/X6Jl6mIPChW/S8CvY8JmNULo7wwzgn90=;
        b=IFc/OdTggyxdx71WMUkmunfFJv/VBdRsML2egv3SAZWPQsqAefG+GCW5wF/exbuiTa
         QR7uGfe2g2p08Fxi7cbO7yEIIN8XKQYDgkRTTzsgAQkPuO3SGaSSiGhnwIgPexrOySZa
         +pZ+yNZlpxVkvSZoEM6zMPBqP0Vph8OkXnbLafOl4HbYSB/gXqgS0me72Dh31n5iZk+V
         2TfcgprOH90j2Y/h/YyQJmhoWqYtQXHojL9LdYazVTSYgmVIeG3kvXXY655TfaDon/Hm
         OOzMc1jTW2zPFrgbpFNTk0g5clcA9sqMzcETIeySBrsKVqu/NoYYyuQ5t9XCId0uEIcl
         kJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512203; x=1786117003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X2Of4jWCRo/X6Jl6mIPChW/S8CvY8JmNULo7wwzgn90=;
        b=d3a7yA+Zwyf+YSXmpFAo5tw/84w2wGbsg68yIculz932xWl1py2tvSWQ0oDpYE1GaE
         76O3i9UcLC5geiLOx2+HwOVydWDOAZMwGuqnQ1at25OZ/6h996KeVmKci9+Y1y3fvnDC
         Vi5T8eW8ETe/Oa9OExrwgPyVvI+2Uw/woQMb0EYpTlb5NWri5mDIKI7wwU6GZ1N1k3mI
         mZcg7+IrwcsfNv8za3WKxUmVXEvDrPOycrezanzI2pS90Kvue1qrVFBZTxOIQp/zwRJ7
         nBmYCDAvDmaDNerrJdjfjuIglqRS1ik6PasJQ9gGKt9t5W/W651HSEoaVk6odn3QCfp5
         sT0A==
X-Forwarded-Encrypted: i=1; AHgh+RpHhoMp0U+n9vuwIjAP76BA4xOeXUvk3nkYic0Zb1NkKCRTZ8llxCJjzVwkAKcy+o1vE8lrufYxLKxU69CqZ/80vHXWcUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+2RpE4z+AooDT2LXMXSGqZdg/N7hiQ96nKWfNPL9aI6Slm6b9
	RbnQQHXkTVcida219rSyOYxMmVjP1bOMdIVllhisrmeyWz4DpF4UTYvxjwq3ZNt+Jt1/pQq3Fjq
	V5SDLmy+m1kQoe/czzVPxP0KfxY8nRxE=
X-Gm-Gg: AR+sD13e61xuHc4pSMNCoccKziPD4NqXVTk0RpyAzDN5FJ1OUYjQiZme90RYlpeyznE
	bE86l6zGN/hToE8yd+M7Y2e3ZZSIzA+D0V/p6Wi2+i9XpOsntjcaeF1OFc/eTJQbOZQQ3dgC6SE
	A+S8bDZXAKrORhzURpcqRZlG/EGRsjrc4DdoIF8L1pRk4dzVRyg/QVKENC847rhy7xRcDSC2TRw
	JlvbIMqpXloGdpVxba8HTAKUzCSYblolydg/cDhkQ2R1IxToLCRLG+mZv7SGKIuDmA0OojT82U3
	0ok8IaccxMshnNMFeuYvdxWA9uuzk50Bie+IoiV4aokGakJ6KNpMRaXS6eL56YF3c1dw9zICca0
	=
X-Received: by 2002:a05:622a:1e0e:b0:528:3c2c:5c72 with SMTP id
 d75a77b69052e-52b5679527amr12582491cf.32.1785512202948; Fri, 31 Jul 2026
 08:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com> <CAHC9VhQXtV_dGt_b5oD_LFNOygfx=37u6P_S32xo3A5aHvnj-g@mail.gmail.com>
In-Reply-To: <CAHC9VhQXtV_dGt_b5oD_LFNOygfx=37u6P_S32xo3A5aHvnj-g@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Fri, 31 Jul 2026 11:36:31 -0400
X-Gm-Features: AUfX_myF-Fa2Dx12J7XG4FMqMoM3YLOYocj4Wcd15kosvCgWFWfK34tns1g5ePo
Message-ID: <CAEXv5_i+OOJqr7xb02=5JMR2O8soLJARckG2CK7yvcv2Ycj+eg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 11:33=E2=80=AFAM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Nope.  That patchset has its own issues, one of which is the location
> of the kfuncs outside of security/; I simply haven't had the time to
> review that in full and reply.
>

Makes sense, thanks, just wanted to avoid churn if possible.

> --
> paul-moore.com
