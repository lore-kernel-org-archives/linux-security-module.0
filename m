Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65731F2BBB
	for <linux-security-module@vger.kernel.org>; Wed, 14 May 2025 21:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747259885; cv=none; b=QspbY4asbvHxZh8FQ+MH7zCzwLpHcqwDGln84m7o+XpUKAlQDM13TtolnN/8ghEfIpbxN/RbSvbCO90/Ip2hDWznsPKWcZAWyPa7XlQ00esOLCAoD3N+ZrhKGF6ppCF8vXdlvtbcqz+TBa1738d1SkKLHlzp5g1++mJzH8vCOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747259885; c=relaxed/simple;
	bh=Y0k6zt80v/NzClDM2+/2DtplJHKsCdpnYYoaTVipjNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrAQ+54RaBNYUhBUUedD7GCBtFrVf5Nyyc7b8wzN8LMYmNqiZQiQYIdnuP1VuR9XwR4vO9ovuAU2E2wQtNGbo1YomHnzgxPTyt1d9JvBzJwQL7xueSpe/3YNhvbMfPwMWXcnIVrMLdOf+6/kzPtapTxjBc9DDSYPXESyo0FIIns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AEKEmHW/; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AEKEmHW/"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e731a56e111so329875276.1
        for <linux-security-module@vger.kernel.org>; Wed, 14 May 2025 14:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747259882; x=1747864682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cd3hwDzjEL8BVjWNpHIodN9KpUcVouQgmKQ6Ucvmu/M=;
        b=AEKEmHW/hvVLg8mQhMbspM92G5vZsiXE2KKqSDJYtAaspXQjrZS5ookhCyd+BNxw0i
         81kB/zOp9jd+l1nyeYTAJWcm7Tdywu7S75Z87Ude0CYOYjBh4++0nr7mMoVzvPDiiuWe
         jlV+3f901xMQqMOwnD7+KYrGNxU7+BL/Ysq0SkaMWArSp2shAYjs5tvinsasfZY57AL6
         ZvM2jtvD4dD5dcEVYYpfzii5xw1ykjuYlyRVmlmsqbimg/UWpwp/0HRTpnvW4qFV8/hi
         xStttFqJZfHfAyM5jonl4PlRRiQ/dGPPDT091ocHdj7j97/WWcokhZgMuTN4USrm2WiJ
         TiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747259882; x=1747864682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cd3hwDzjEL8BVjWNpHIodN9KpUcVouQgmKQ6Ucvmu/M=;
        b=FRorN136CqDWoTngpzEbSE6LCQLkT86/ihZl+GS6Dt27QrWq7kYfkX6iygXbWbT/3j
         338Zfjml8L4GuFcKOEouBjeH1cJt4Mv5urFsVZP7EtAtXOEU0xVRep2olZbi2Grn6rIp
         6I0RiIzreYqlPByL96aaLNv4u1HpfC6R8cvzv7V5XsmpEOmhL9dkauD8ZGgPj/hkzfTW
         x2FobQXcTyPdf4c9Bf3ZvBdnZIRoftA03miMVC46SVryfs/B2GWzOPFDuz5f5QqkLvvx
         Pvh6pmYaFcPSyrogl0Rfk8WYXYPx4in3tjVtZOHOgGCUqQT+jCM98XJB3GCE92je9OEN
         +AcA==
X-Forwarded-Encrypted: i=1; AJvYcCWsZ4bxL4qYGTCr2pvLf+jQ89Qjas3nTQSMXmE9ITCxdIe/7sU+4MtX4GCCEFeywC/WiUAEMNzzA64vJmS2b2wSFFgKeYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoiKZW9MGES8GHT7y70z06E4DjX6SRrmd/K/6UE2yw7ReZbdtm
	QFo3HdkPT1WbclLOfti1iZOF/cKbaKs7W9fuJph3fdof1S8MfXVcMYnKb3gbpQgZnqc8kMxGmAD
	Rx0IZ4xoPWiG+5fPZl/IjPapkN+y0lNEzl85im9DlYtbN5YY=
X-Gm-Gg: ASbGncu7h+oqrZuulSpmjowzyC42BGD7kbzOrCp3EH+4MDNY7e0xlR2x/SRn+9rmBUn
	J7GP0LRxqCs+/03+hV7tJT94de12fR2UZVwuh9aPocAITQT5FjMRpe6q23IRV48UT4sk8wMCL5B
	t6tyZF1HMQATSe2/nxAbec99vve8yKz01yWCLAwWjKU+M=
X-Google-Smtp-Source: AGHT+IHAu8/NGifUGGvqy1muRemXjrNd0svPOPeQFyYnJTSpuDaE7BUNisyhGtBUb1e5c878a+beHwpBV6XXMuiK0sc=
X-Received: by 2002:a05:6902:114e:b0:e76:8058:a065 with SMTP id
 3f1490d57ef6-e7b3d4ba991mr6148542276.6.1747259882613; Wed, 14 May 2025
 14:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428190430.850240-1-ebiggers@kernel.org> <20250514042147.GA2073@sol>
In-Reply-To: <20250514042147.GA2073@sol>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 14 May 2025 17:57:52 -0400
X-Gm-Features: AX0GCFu-8Aa284A3Wv4qgq0Bn3X2NviBEUYoaX5YYoj-p-8WsCK_D4vIgnJJLjo
Message-ID: <CAHC9VhRL=Jsx8B1s-3qmVOXuRuRF2hTOi3uEnRiWra+7oQJvrg@mail.gmail.com>
Subject: Re: [PATCH] apparmor: use SHA-256 library API instead of crypto_shash API
To: Eric Biggers <ebiggers@kernel.org>
Cc: John Johansen <john.johansen@canonical.com>, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 12:22=E2=80=AFAM Eric Biggers <ebiggers@kernel.org>=
 wrote:
> On Mon, Apr 28, 2025 at 12:04:30PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> >
> > This user of SHA-256 does not support any other algorithm, so the
> > crypto_shash abstraction provides no value.  Just use the SHA-256
> > library API instead, which is much simpler and easier to use.
> >
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >
> > This patch is targeting the apparmor tree for 6.16.
> >
> >  security/apparmor/Kconfig  |  3 +-
> >  security/apparmor/crypto.c | 85 ++++++--------------------------------
> >  2 files changed, 13 insertions(+), 75 deletions(-)
>
> Any interest in taking this patch through the apparmor or security trees?

Something like this would need to go through the AppArmor tree.  As a
FYI, the AppArmor devs are fairly busy at the moment so it may take a
bit for them to get around to this.

--=20
paul-moore.com
