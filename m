Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A8E3090C5
	for <linux-security-module@vger.kernel.org>; Tue, 19 Aug 2025 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629576; cv=none; b=ZsoJW/ZkjN7R9Jg3CFuaxQcrSGjvRRRulRGDmk+JYpRlL7xfkS7SBfRWO+/UtJRjCKjqWEdIOB1Yue1w93Y1wUB0+V2nsHGtxQXZHUhhfVcS3jObYqRJS1dmvC1/PT/uknL/yBIMot9RimJKCJfQ+LEafneWf3IvTKM/utfs8P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629576; c=relaxed/simple;
	bh=e5MJ4oCvqsCgQpSPaOFyxiPTod0UmEngl1dv7gwvFCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKGBUQ9hRwcd/YQGjwXsG1i6Km1zygzBImpRURcSe7znP+5qjqoWRDU3Ge1jMYsJ+gDun7tANMxG/dzfpRZl0nfiFmJVZf44ZwRUvxbXs+f1ixm2j4k0zyV51aQYZpPwqcVxsBK8qblU+oTn6xSy+cbnsDJllGHC5yx7F8k6yhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aNwSRuuR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aNwSRuuR"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2e614b84so5405607b3a.0
        for <linux-security-module@vger.kernel.org>; Tue, 19 Aug 2025 11:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755629574; x=1756234374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuS/iFgzwKBg3yEC4BuMe5siR/xqlZdxjG0KUcaTc3w=;
        b=aNwSRuuRmeR07G//9UDRY4dX4SAq8K5Kr+xsaB+3+2dznkgMIkUE0KwdVWtc+uAaht
         8fHT+z1wFwUyxQzBwTwElSZYhmSa0QTScIQYl1tkScePVgGQhjyvULomAJpH1+h3aNMG
         /lYPzcukIrTQpatemWKm5pBmY1iicSvJphnWBB/tjOIZuzjTpjL+uP2B6nhi9W87Gufg
         yNpFWRJWgw3ZmPL9lhJ4VzRX4aeB8emUXIukjaEOVDfzGWQf32qweMuZY0oMMFzqyiF3
         Vse7ikb1w4SOQHlgnJcMIfuXnn5B++Zk37wOAW41qSJay46fkBeDW0cToATckAXU9bgQ
         sUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755629574; x=1756234374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuS/iFgzwKBg3yEC4BuMe5siR/xqlZdxjG0KUcaTc3w=;
        b=KYgmu+DGu/HQqGoADadVXyTBtYOQFLe9uYqz5PEU1hDxAlThjFkQ6KCV1fmFajU+3k
         IlDr5ZR51MTsrzNBi0uFTIncaedciLqnCnr/dZ4/+ZcFDaKdB6V+NLfX1iuH1w71nnj/
         Uv5ZH2vsArrv5wRnfStrJMQ9YjBRa9yj9i/OWHuetaf+iYg3cKqGopAg8Xs/4cRwGREi
         QHkz5QoOyabJnsCRPA6Q4ifFQeKY/b4VeUBIf9wPe1EC4vF1c1F3jMOXFO435r5jCd80
         iW8m18lkhrRWNFZlMlAJZvT4pU7engIIzUnjEp/LjywwDUs+K7eImj9rmIzDESATCwyK
         C8lw==
X-Gm-Message-State: AOJu0YyLiQbTghJCi9mvnGwQhcQt/PL5HzqeC3/h5LBWR3gz1oHgrNTP
	SK2Xdp1z0Q1EEtTq3nUVIPLo40xsyuSN9wqdp3kAqZZ6ihbqq1oQOhQWscchyaU+WoHZFKM7Zn/
	g+RwxZLZmvwy9kwJnVDX/eilPNcTDNBkmooHYxRU5
X-Gm-Gg: ASbGnctmDBGiWU98qSHsV1NT1nazwu8m9Q/HkJ/ZPgQ2TDPPup70i6+c0bce5p4g2d5
	3wgWux/gwpHTnXLr+CjcFyFXfXoN5dJt+TQjHpYgn1uAOc4pjLbWOD+vJ2KG/Lw9FB5yh6BPJEG
	iGBeL7DWEq3T8S25nwWyPB2zlz5o2xv3tIq17UUob0ToeiD0MLyI/TMBOaenKr/bmB1SVi3xm2c
	xfY1cgMQTgsnHowSA==
X-Google-Smtp-Source: AGHT+IEjg0JTlsfYLhIaNIWm/+OFgy9gKpVMV7qP4QiaZse6yTqXP9wbfdaXcmVovfwzrMp9gPjq81VlifFJ9lzEhFA=
X-Received: by 2002:a05:6a20:8b23:b0:240:1d4f:720b with SMTP id
 adf61e73a8af0-2431b816016mr451106637.23.1755629573783; Tue, 19 Aug 2025
 11:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com> <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com>
In-Reply-To: <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Aug 2025 14:52:41 -0400
X-Gm-Features: Ac12FXz946zCN8bsQVbzdwKm8mEfRf0FGCuvjfYY-3eGxLuEeUqQpZt-ab1VxgM
Message-ID: <CAHC9VhTnCKyKJNG-W+VNVHZLwNDujTNOR80VRdtmn1zD3N33-w@mail.gmail.com>
Subject: Re: LSM namespacing API
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 2:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Tue, Aug 19, 2025 at 1:47=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > I think we want to be able to unshare a specific security module
> > namespace without unsharing the others, i.e. just SELinux or just
> > AppArmor.
> > Not sure if your suggestion above supports that already but wanted to n=
ote it.
>
> The lsm_set_self_attr(2) approach allows for LSM specific unshare
> operations.  Take the existing LSM_ATTR_EXEC attribute as an example,
> two LSMs have implemented support (AppArmor and SELinux), and
> userspace can independently set the attribute as desired for each LSM.

I should add, for those that didn't follow the lsm_set_self_attr(2)
development, if you want to set the same attribute on multiple LSMs,
you must make multiple calls to lsm_set_self_attr(2) (think of error
handling/conditions).

--=20
paul-moore.com
