Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1B82178FC
	for <linux-security-module@vger.kernel.org>; Thu,  7 Nov 2024 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731020655; cv=none; b=Ezdrf0PBRqlVoIR6DOdDDpU70lNQMs9iHA0UOpmylDGW/KcWLM1beDcZ5WV0mpwgemTs5hDzVz1/khccci8CiqVSw+T3XRUTSj135af5rnWL+JAOpOm6eZ29mcstbDHGLIR4/zcEk+brSv2FMutNqTedQtY42IrJ2Vq8Z0yZ72Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731020655; c=relaxed/simple;
	bh=BhxcMHtLLtHwPPWGtXd9fvcEeapSiu/a60i7ogxcNi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qX0p3Aj7hAd0GubzPtzSPz+rhWbnJWPnjKNHqzr7ZJGR7A/rD6s32evz0h96ob1dIWCRjU5796+ZxSwrsjMvauV6R7g9jL+bdUS1WAVAGSRw6dMBFtkIBFD7UXsToCZKizCfJ3xAUo6w/ZdMIJYk9HbRyPGEldkG/hhulloMFXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dUdxFw1J; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dUdxFw1J"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ea051d04caso12854687b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 07 Nov 2024 15:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1731020653; x=1731625453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlntkSFiHNeZkBFtAn8m126DlC2mYBr54/x5PoDfpxA=;
        b=dUdxFw1JDMG/3R2o1Pf1cCjtVoF8bUHifzwKWzNb/EcEa53q+dhrFlgp05wBedUweN
         WG4qf47Csa2xa1GWvvdnSPQGmAVxqCJ97lzsnerijupoZ1A6ETj1wRoVjPYRetishazn
         9YZjOqv/HCnMIhRGzgl01vNGVggdp/qJJ2WzqSAUZyYD3Ke22Pn44Uf7Z62801inPvYs
         9WpYgkoT9ZGJSkLDPmM3G0r1bNsa41zc4uQUQUaAmwCmyueTaCRCegt2pRz/IUM7ebaY
         ixaRKzvIQ6M7qvntf+Z6wfTnxagMNOklQlzjcNuQpE2il8d92BELvq6baEU3x6z+4hWl
         OCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731020653; x=1731625453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QlntkSFiHNeZkBFtAn8m126DlC2mYBr54/x5PoDfpxA=;
        b=RhNlI6t6x3xEqrhlzkPQwE9SHJ0oGfue0otN8oTvoMbAng+JTvid1tKOxYI68nTOkz
         uU1TSy94Afeagbuwy5pe74d+QzTbmvXtNoq13Fa7mxbgoLBzTAkMNy86gQ+4P90OagSd
         cKWxPeXkqKdsGfMD3tOM3KA1W67ZFdPhyVxWrQAKw4U3q/1GimWvCE7RM834GdKipdAh
         VjfL7qnp0jUPQTVkKMfVQyBuFvWLj+whYkkV2+DCyssZJcirejBjBO8Chw7JqKbCsllq
         Uwo1wfhbOjg1vo3RENNDqri9L33kd1MpdFK7EMMwsCUyoCPJaxBrAC6bnJ1YPPiPLhxB
         oQjg==
X-Forwarded-Encrypted: i=1; AJvYcCXfn5wm2LXkfzc3ooMOwGVyBeWpcusyuMMKXURZ5d8Qg5FxJHDPUdqzms2OnGYgrzKjuUTrvhU9uqLydqKuwgFnJptSlUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGZxr3quDGxwyXM39ybuyshK00/nv2PKR3sVBJrC+kldHwN4kw
	yq2xDG82xYQCQKgMkaog/3GEvFqBYauVAPO3cIZzSc7dURoxuGbPrmV9vcUKVPlzPuXUvDjqiyT
	NBTefKkWDcdh9WYLiWyYhz1bwW7h8CiArelr/
X-Google-Smtp-Source: AGHT+IEb2Xaj5GrD2ejkS6S27Jg/4eqckXGxaD2HDeWP/WC9GDRcrkcjw/qpYzRH6bRDS4ZblgpGPOdYoz9Xo5Wte98=
X-Received: by 2002:a05:690c:4d89:b0:6ea:4d3f:df9d with SMTP id
 00721157ae682-6eaddd71c30mr9760277b3.4.1731020653185; Thu, 07 Nov 2024
 15:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106155509.1706965-1-omosnace@redhat.com> <CANn89iKag19EPvnQRthsG98pfjriRwtS+YND0359xFijGAoEYg@mail.gmail.com>
 <CAFqZXNumyhpRvrZ6mAK9OVxbte=_3MG195i_+Z1j79PsE=6k_g@mail.gmail.com>
In-Reply-To: <CAFqZXNumyhpRvrZ6mAK9OVxbte=_3MG195i_+Z1j79PsE=6k_g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 7 Nov 2024 18:04:02 -0500
Message-ID: <CAHC9VhSdC_EnMMu05UbcFAGa8y8OyufTra6kC5zhxDP_S6QucQ@mail.gmail.com>
Subject: Re: [PATCH] selinux,xfrm: fix dangling refcount on deferred skb free
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 11:54=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> ... That made me look deeper into history
> which commit actually added the decrement on free and it turns out it
> was done intentionally as a bugfix - see commit e4e8536f65b5
> ("selinux: fix the labeled xfrm/IPsec reference count handling").
> Before that commit the logic was similar to what my patch is doing, so
> I could be re-introducing another bug here :-/ The commit message is
> not very helpful there - Paul, do you happen to remember what the
> issue was that prompted it?

With that commit being over 10 years old, I can't say I recall much
about it.  I did try to sift through the SELinux archives, but I
didn't see much from 2013.  It's possible there is an old RH bugzilla
issue for this, but my RHBZ-fu isn't good enough to search that out -
sorry.

--=20
paul-moore.com
