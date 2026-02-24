Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49902FF144
	for <linux-security-module@vger.kernel.org>; Tue, 24 Feb 2026 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960372; cv=pass; b=N6gPPgt8bUn6A5UCfXTiUaUs7SrgU6fqlB5ZRqp0WYexAB3CPyKD8DaGRKUCTkxDIM3mvbbFE8XH7sHTyhnBIawZzhhQ+T0G9N7XV4AFhUfapoGgtpj406kLU3yXrwX3bdauAfsxjRiufp39eE8dtPAndrwrzJd3lRoAXcBIIBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960372; c=relaxed/simple;
	bh=Mx7EWvPLyqSJRzwqUTOqp6F3rZbh1xURjor89wXlRdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AA5c5VTR8e571lVvrTE+CFNVP1QqD9EC7oitZGgbY2y3VKaNRMlPZa7XRFGCHtUIyI3ikGXWIJi9xUyEgLl0paABX4uyZw9GfSxdOVbSHyxzdBu3HSKWKZZIAcQe/+4jQ46gvn3B/HWf2xz8aDoOTLfY+YBtVli9Aq+F/qiuRKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KhhbuuKj; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KhhbuuKj"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso27118945ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 24 Feb 2026 11:12:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771960370; cv=none;
        d=google.com; s=arc-20240605;
        b=RHMMDZvzr6bxIFwIUAzRyN+/sHbim8Bdu8nXR1b80Q3a9HY8QcD3tckMuM6epFA4CA
         n1iRdSzP8btFGlVnDGTkHGdmegH/w7MNAbX4jkHZZkouXVHZhHUON7MM61AzGwYoyxbw
         cn2wwH06JbpS0DY2jxVnEa3Ve228py9sSPo3ovT1uxyTCm1z2JBmyon/jk7BoDdIfGe6
         ypMZhBY/RzzajTKrKzkI9/bkr00qE1zAwYCnCUFB/heJKq5S1mh7ycEDqu6QKLLHS1Ic
         MJh9P2Z0k0jvLpMO+HczB4ee8yQDq6bsZDANAUb5a27Xc+qFtpHH2liD8pRYRHtyorxM
         a55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dyx0e+eGptURv94NFLlxLMfCeHkSe565dVokgpHON3E=;
        fh=Mqw/l8T2gKgQtLQS4hWTdwC5RNkGzFqg+dO+cNJQi3A=;
        b=E7qOAnd++DT+3/9MBWC90NjkBHdNl+jtfQplK8IFIj6lvgXxww2CQLbPn4bkkPZDwr
         kivLuscGH9/p9k7nZ1f6Y4rcuXSAzRgxIPL8nA/QY8DlD0fdpPSe7ibP48ztI0atbZst
         qZU/oLsLazigMZFMDingqRPbvXoxjAJ2NfpPPEO0hPSgB8g0LS0Vtm6flMacihZB+qrQ
         5y0sWlfAuu6MkAABXXYc+A11PVQAipXtmErGtYyZ4WLaEBHOdovdtK3Gr6jU8gZKzh0s
         Kq8aZCLcTxpsiXTgZrSGcPj3u8lrszMWEaG6BCrER2uRF+jPDhF/z/o3pLm/HBx/moPt
         eIkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771960370; x=1772565170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dyx0e+eGptURv94NFLlxLMfCeHkSe565dVokgpHON3E=;
        b=KhhbuuKjR2JZaDvUwlguZ7AuuMNvsmzE4zIPHLqtgm2iz89AuXVcj8Hm/uzUNYTJpc
         4kDewaiBV/FCaeIN++4HzE1v45Gx3PptJ2DCUFJtfGrFGipyl9O9u/msqwZsFDmSbRh+
         Yyi+W8+d/Qgzh1UKgo6+hLF1RrGHLQ8HGiPvsc66YIGxomqKrxgLCXTY9BwWzeH9GlKS
         Oeqh5fBzOB99TnDnZf1EowhWVBj6VUmkQmmprTAbcZHN+gZRle9uH1aKwY+pZBPkssTQ
         V4LgTNhI3mYkzL3NWPU9S5pvZBSE/9gMjl1wL3BM5r6x3Aon9H3s1fl3dZxbCO2ioL/c
         vpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771960370; x=1772565170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dyx0e+eGptURv94NFLlxLMfCeHkSe565dVokgpHON3E=;
        b=Ja3n1DWiEJojTrNtvyP+QXgcTo1+5nfcJ5+qvGllsgzPWGTTgOzHkURNNfp5fMHIYv
         k289tx5Go4PsKNV20mxZCSMRvQryrSwBqFL2nO+Z8bgR74qIcAzyav6daBzFbBG1pQ+F
         2kSE2etWhPStetfkonQbAZMLxaZmKp4oXJbsZWM3Y6TLbwSRW5IIFe4nrv9XDHkPKKYf
         iYJLGecQNz4S9oikX1c6owp94wIfGdfhly3NkzQK71VVgg5KZfqwCwyEGGsab181USuO
         ef5bFEpKod4ZEQ6m4Fw77FX9uircexeHZ1TVwOa2TjFfTU/PkP2LxxhjeZpE1b/lmKQM
         6mbQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0xiKFcz16zXJP9pVfyO0RVUE7u0zF3YAPy1hXUivhVo/0lzOdHuGON8+1yHQE4w8kZnyQeNRoxOkRdzKu8dekw+cnII0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYxxwG2wEUASBzIl2PsQa8lvzK54z2FTROIPVY0Xk7gOHnRdDZ
	AwCqWq4vnaW+MzyjfSVpXlf22WtEt+WZDtpIKn5aIJcS789VKC4u+RbiXNE/16cRNCY/Gi+TGpC
	LYNndyCvDH7W1rR6YwsLYnL1rm1WjrQWwtnVi960V
X-Gm-Gg: ATEYQzxYmryNDgeu3UtOUO689kAORwYKYqKgWAhMG9dCcq+tTh9Ua6DivsIQJ2C9jeT
	YXq9U2XZgCwUT1UsvD3mmBoZ27rnCnPKn67/FKSsZqdRnU8NwTggzYInP7PnvUrZs/3+45CWQYs
	BMR+gAKKKXQ6RT+beePTEK1MLeUMnE59GAXIkup8jxEX61k7oKcvBxLgeB4Ec88Y7SYmgn+BTNF
	HQ1yciR4VK/VgbyIgHml9a6vvhjjIPWK98zFWRUKaatsnGEaotamwSd11SyyPjic73TxOfQkOrh
	BIROJUs=
X-Received: by 2002:a17:903:3850:b0:2ad:3e57:91b7 with SMTP id
 d9443c01a7336-2ad74447156mr109545555ad.16.1771960370108; Tue, 24 Feb 2026
 11:12:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220195405.30612-1-danieldurning.work@gmail.com>
 <9229d70d-aa7a-459f-b005-695e99888783@schaufler-ca.com> <CAHC9VhSp+X8YNocS7sDz+UyhdJh2yY8CRoi6dwV1eOGdCu9f9w@mail.gmail.com>
 <CAEjxPJ79V7hM=VnbB1dVA96jjr1yeN9qsLjXb4ALv1VmcRfJ-A@mail.gmail.com>
In-Reply-To: <CAEjxPJ79V7hM=VnbB1dVA96jjr1yeN9qsLjXb4ALv1VmcRfJ-A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Feb 2026 14:12:38 -0500
X-Gm-Features: AaiRm503rW9ZOS4V4zxiebdUBzdo3Pfwr2D3jQYLmSqJvm2WIFtI559N_YW2Cig
Message-ID: <CAHC9VhRmAH+mymmoEivKKNgGScUHyD-2t8t-ed+=r_mNzT5wzQ@mail.gmail.com>
Subject: Re: [PATCH] lsm: move inode IS_PRIVATE checks to individual LSMs
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, danieldurning.work@gmail.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-integrity@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	john.johansen@canonical.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, mic@digikod.net, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 9:44=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Feb 23, 2026 at 5:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > I'm not going to argue with that, and perhaps that is a good next
> > step: send a quick RFC patch to the VFS folks, with the LSM list CC'd,
> > that drops setting the S_PRIVATE flag to see if they complain too
> > loudly.  Based on other threads, Christian is aware that we are
> > starting to look at better/proper handling of pidfds/pidfs so he may
> > be open to dropping S_PRIVATE since it doesn't really have much impact
> > outside of the LSM, but who knows; the VFS folks have been growing a
> > bit more anti-LSM as of late.
>
> Adding S_PRIVATE to pidfs inodes was originally motivated by this bug rep=
ort:
> https://lore.kernel.org/linux-fsdevel/20240222190334.GA412503@dev-arch.th=
elio-3990X/
> when pidfs was first introduced as its own distinct filesystem type.
> Otherwise, Fedora (and likely any other system enforcing SELinux)
> stopped working.
> So we can't unconditionally remove S_PRIVATE from pidfs inodes without br=
eaking
> existing userspace/policy. If we want to introduce controls over pidfs
> inodes and do so in a
> backward-compatible manner, we have to either move the S_PRIVATE
> handling into the
> individual LSMs ...

... just like was originally proposed.  Just do that and be done with
it; back-n-forth like this just wastes time and energy.

--=20
paul-moore.com
