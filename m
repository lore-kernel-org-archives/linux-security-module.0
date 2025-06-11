Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852E220458A
	for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660368; cv=none; b=rvN6Qr7iSbItDBi9V2C9DFB+xPvvOkNg49HsXjKvEiTB/8zX/3zh1rzwaT20CRJ8OcigiOQGymDw2Pq3ATqmGCNmCooF+ZVhmpYPXTpwKWnBRfTnHbNHnTmvFWH3KS/82Z17h7jj1SGN2bnORR3BkNo5tZEISh/UgkkXjeqIKQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660368; c=relaxed/simple;
	bh=pkKDuG9F/PO5bN+P64pH0veJmNFk2QULxXE5Xm59Gdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ogt2bkzJx4TLA/as3LAhi0TGTZB7eXrPkssqMJ/8pwMAt94oTtG1SUrc56lV8b7RnpsR/BM2zKtFaL+tNH/u1cCxllEouKF1I4/Oyx1UlXeryh8/sM3xjToqc+V6//HlOpczZicB/7ynBTYx2S+khgxFeM7p44uavEHJbMfo6/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZxFMm41y; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZxFMm41y"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70f147b5a52so43388547b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 11 Jun 2025 09:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749660363; x=1750265163; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdrGmLlMp+++NJB2hEUw9p0lUJTgbbNuI91dUhP6v5A=;
        b=ZxFMm41yZo/q3JiTGh0wjF2QTMlXd2B6W/g4BwoJaz7qwlfR38Pk8K153z+dBQsawi
         4pOFBfVrnnrtRLT+Y/UKVsT5J4hx6p1OQ7HT2h2eqd2p/75OYkn3s+4dIVrqzxXOfxih
         BxU2zVAhkGQO9ZD+UYGjgfhbf8YBKvMJFBwexsC9LbjBVuMDc+xxn6UIloTIjZdcfpWc
         gddCzvs1830xWRpi1WYywEVOe7fgsEgHBXgo8LEtpeHQGV3WY9qCSlrQHZzRt21aDsWf
         OzZDpHM1+iP8iXgTXyaIOt2IXokyhRipSiJfG+vgwJ2MnokH0/HymFNUO/j8H/VODkZe
         iElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749660363; x=1750265163;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdrGmLlMp+++NJB2hEUw9p0lUJTgbbNuI91dUhP6v5A=;
        b=PGbWq+B8rJzk7tIC0gZx+EQ/1qTzJn63lhpBlFqDWIT20bub8sjKk1f2TrDEJnboRf
         rfnN2d+n78CIl1qFipKAlyCk+MTleyeaXppJzduoaxD2gadE1FRuVvUg2t6yJ6cYoQdY
         mcIAJc5b1EX2alxp95ZdNfsXwrq8NI5sRrQPeHvdGkOzEiyB1hqBvPH1OHfLge67dSql
         TrMQYiE2MobjX3z/uqAwTeB/eZ1eptjOg2lPFqkL0QFP9+SxqczVM7bMzUoP0IzoctOM
         csCX07Eo09bi6sACKFXT5vJHDEPlL4q2gNKovjhM2X/6a059vVa4wj8PXkWKXFJJ6WM2
         ZX8g==
X-Gm-Message-State: AOJu0YyYa35jnNQdw7hBNJ67JX0ES+ZrFaL1M5Yn1Dpfa15GnWbMyrNm
	DCCUZSUEjTfY5bJ7iNQ6e5xF2QE3N3xN6qG2GJSkduXBNqA0YwXbRmZXXqwF+elipdqUkX0klOt
	S7kJUZ7jAdkJZPPvEN7cxnT8vpsJG9L2VaZt1Ep7R8f7HrD5IPDeZAQ==
X-Gm-Gg: ASbGncs/KjYXO6ylnH9K8fQmKmJ48DYwnmaYOzSy2qz2csK3NWFTqZHoRRCTsF9FCTi
	4y1pfCLyPVQpOineAeJNmVaBrFP3Br9ybprRiuN2CmK+ypJn3ZwlfN4y5r5Y80cNlZmb4OSeQYD
	PG8+tNn+kB025/X2D6qDirPuV3cs/y9zRPgMHLYMTy8iM=
X-Google-Smtp-Source: AGHT+IGws3htnGlVgU/+WackH+riDIx4X4Dxb0tU4FsO2xWxOUo6VoUcfsGOrhSHZQpu9DbYXPbHdLoCiR2XufjouQw=
X-Received: by 2002:a05:690c:d07:b0:702:52af:7168 with SMTP id
 00721157ae682-7114ec4e044mr7273347b3.2.1749660363121; Wed, 11 Jun 2025
 09:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhS9P-fgWac_sJ_dq6_AQf76RGiqLAmOFnR_4NZ83KQogw@mail.gmail.com>
In-Reply-To: <CAHC9VhS9P-fgWac_sJ_dq6_AQf76RGiqLAmOFnR_4NZ83KQogw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 11 Jun 2025 12:45:52 -0400
X-Gm-Features: AX0GCFto4vJQW4gjqUVGKEc-i0EmSC5qmILck03v-0mF7PLhHzpPBHr4oZKoFWo
Message-ID: <CAHC9VhSae4Vhypwr+hkAvddQ5_DQ90-jaS+pWPqJwPjk_dzMZg@mail.gmail.com>
Subject: Re: ANN: LSM and SELinux trees to rebase to v6.16-rc2 next week
To: linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 12:45=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Hi all,
>
> In order to pickup an xattr fix, link below, in the LSM and SELinux
> trees, I'll be rebasing the lsm/dev and selinux/dev trees next week
> once v6.16-rc2 is released.  Currently each tree only has one trivial
> patch in their respective dev branches so the rebase is expected to be
> trivial.

... here is the link I forgot to include:

https://lore.kernel.org/selinux/20250605164852.2016-1-stephen.smalley.work@=
gmail.com/

--=20
paul-moore.com
