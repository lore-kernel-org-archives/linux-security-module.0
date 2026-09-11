Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0863AB262
	for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150318; cv=pass; b=V9IjD+VCR9TCxc1OA6hLLoAkdD4FeuzEGwbd9oBGeNe6KKJ+YnN7ImRThe4d/uDVkjJFDRTxwk9UAkLAy2sQZBo2ExdbrinC8fwJGB9ZyC8c+LB2kB68QTTd7I6Kpnm++0XWamwB3SF5YBDfvWbx7YbDERFr9y4ygTPQNG51D78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150318; c=relaxed/simple;
	bh=yndXVIPPZUhTwpg5+kIO5TF5aq571rxXnLn21AJXcnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=od0wzeEbyazNOU7ml9QXKT7TV4dLAPvuTshmSp9522q6UBk9X5si0YkaKBWjQimnlqE3qMhjUGrU4vDkj1dcVI/1Z5B8ERY4j4eqh6n8DAdsm7ZUaOARa82UYD7xK3FKPrEStQv1dUTkkQflGqKKirvc1LPTZcoKCvDlRWZxU48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TwMI0pCI; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TwMI0pCI"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caced6038eso13390555ad.0
        for <linux-security-module@vger.kernel.org>; Fri, 11 Sep 2026 11:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789150312; cv=none;
        d=google.com; s=arc-20260327;
        b=gfeAPxxUPT5hyjVz+Lq/iang8bD6usvyJc5UFQ3aaqjjhMuUop6zRUtRWS/piKQIXi
         jfTzE7S3weqfp0p5I1uuxAn038ZMAcaxKTjjVZjpX99gKxpFw8c1HSS2nKrChexs3g7l
         C0LNEI+qbqfnE9JXOh5JQpAv8V5VCXzVQJW/Khr+29wCUbONZut4qGsXNVo2Rf26lHOE
         G2/v/20GfwBY9b4KjwX0Yw1VzuTeiauEjKzHgsTQqLwYrPSF/u8HpFXB0eRRWWUqboVN
         Nvf3V8uvB89MYwmwY15xWf2BQk1yn4Dc99jfijqsKgouJ7EfRwfwYJbYKFmaCmm2o+Zm
         psmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yndXVIPPZUhTwpg5+kIO5TF5aq571rxXnLn21AJXcnM=;
        fh=e8g9VYQP4kAaO61bAI/1v5X4WLRSBxkbxNfZtuWcUK8=;
        b=nPQl8oi5U9uqmkBixKurSnwXuT2X6r6FNxMpewtDv6xrQ71gb6KKua69Tk6JCFpn1A
         Pk9fMyCXuN573f3aUxyoCn80zrvyzWAwTW1z1P4rLX++TK8r1NlLLRABIaZkxzRiMdiR
         hiUvNBMy7OkruiZCPlLWsoFXoaWooaH0ojC+41PdWoIAQQGz+dVKqJzdzXbrjnbzXU1c
         kw/5dtNmTvJr3UIfsbLAoXhLsU9xNrzUjxA+eCTSciVrgOiNnod1kAVbHpuBTXGSapL6
         oGlcoBUHuBMdPio6nL/XcLsT2yLKe27WtqR3YyB86MbhCSho0TK2cYCfL9uDOYaEMp63
         EaxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789150312; x=1789755112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yndXVIPPZUhTwpg5+kIO5TF5aq571rxXnLn21AJXcnM=;
        b=TwMI0pCIqmAHyh8l6si1gWdvZtSsDrvLh9KjqPdRsQ6VYijnBeje4y4YCUp2R4s5fm
         SQ/whomkDjD8E06XZJNCUFaKr8G6Haa4rgUc68wqww72w9B2Kz4vnRx3tQKEnAvxrGYI
         QiBIkw2mg0V2qBuLgddJuyaAm/jPjhWnOgU89wcxf4mXuXQzE0XIpZaTwx8lL/i9KogS
         kgZFk2tyA1FCI22L1uCXyCqM0xHNFQcCuiZ15cEKwSeN5Vy0b/sqiQiTCmDk2JwLy3v3
         0++KOZUvh5l9y9G/AvCvpg3yj5pT45oaPpNpxsgb5oeNfCtQ0sQLbQBh+ao2QIRx0jbz
         /Z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789150312; x=1789755112;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yndXVIPPZUhTwpg5+kIO5TF5aq571rxXnLn21AJXcnM=;
        b=g5IengZL+7tn2qJDZKjkr/h4OOXmyifDXFNwYh6t9wjA/DBFxThxhRfVLH3daXvCjE
         1UkT0L9nCsx7d+5oUzq2R8dgB0ij2EFBoz4kWwbM2Acr+xwpLTv+3ENfmADSzMtiDQXa
         WaXmwRv9kMB/y678GnXdkI4D0g8bYI+H1DQ7sLqtQ1BB6l1HhowCB1HzcOAQLZY/D6Cs
         rqr9DGmsXuQXAGRykHn+84QCK1jr43XtkFByiLbbBYjRKv1MgGJtDYLIckpe70Aja5W5
         Oh8zuLf5E+bvU2+8OOiZlvQOAOJ2JoX0zDo6L5QmjhoBy7yLmXJ2amfE2CrsILwZB+gl
         8yig==
X-Forwarded-Encrypted: i=1; AKwUvBz/0KGxW7xqPEQlrvSqbAoLiFXvVvxtoMyLv9Hz4MHTctaUzlE9N9tLNuzLaRzSHKiEPFXQE7gAD6Ukv54XVTiuGYGY6Ks=@vger.kernel.org
X-Gm-Message-State: AFuF++n9PeYU46rPxLREh1iWljRlB2WnADyQ+EvtH+hAP+O/bnrhUGrq
	BW5kXmgpbOij96LE1vZlBtvUsz8gr25VTr4O5twFbjjSNDd5oVRSe41RY3+V4+o43MVsoTnBwkQ
	Iw5QVg18PMlfuNjz6ZIvAb6QsBk3gBcDYz0X5MW8nYJq5xpGQ6WVwWQ==
X-Gm-Gg: AYBFou3Ano9DucCUY5y3oYem5j+xcEKw+eXhyza2aN1peHMk+I58KKwjqaHCzXnLyAl
	20p3/TJr1rKiR5r73SbPKixvEMjDmXOYxQ1XJQY7vnAGSNXJy8uxRCGOyCm/50wH/7StjljGPxb
	+0ckPS5sP68KdhXi/jma+zVAnPUZkzB+FHdEcn4D1wAtXA8NZNhEV/fUWXerQYcW/a1jah/OwNU
	JuwKPfInqpWe/NvU48NH9W2jMnHnswgOzjukXGyz0tE1Dx5rQJUIYyqSHJjsU4loVK8qfPUSY5R
	QSCrF3UjUZHM1UHSJdIdtPtGJZuFqXbcGin0X7pad+2jbPO5pKqqerMavuuho9ez6LMzGBhgtcp
	2CfmuGQym44M=
X-Received: by 2002:a17:903:2c0e:b0:2d8:d4d2:d139 with SMTP id
 d9443c01a7336-2dd0eebbae5mr122269175ad.21.1789150312031; Fri, 11 Sep 2026
 11:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com>
 <20260904-lsm-mount-idmaps-v3-2-920a1963675d@amutable.com> <aqN0EGbbHk8XMqI6@lima-development>
In-Reply-To: <aqN0EGbbHk8XMqI6@lima-development>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Sep 2026 14:11:38 -0400
X-Gm-Features: AcwNN1XCr_fenCgMMDZJbz8HR994qWOko4FbMjHRvNv-mIjsWVDFAeKB1IvJ2OQ
Message-ID: <CAHC9VhQ-Ee0KftEFdSWiGDvT9EYFnUvfieNg8+uEQagDncy8Fg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] selftests/bpf: verify mount idmaps reach inode hooks
To: Matt Bobrowski <matt@bobrowski.net>
Cc: daan@amutable.com, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:25=E2=80=AFPM Matt Bobrowski <matt@bobrowski.net=
> wrote:
> On Fri, Sep 04, 2026 at 04:48:56PM +0200, Daan De Meyer via B4 Relay wrot=
e:
> > From: Daan De Meyer <daan@amutable.com>
> >
> > Extend the BPF LSM selftest to exercise create, link, symlink, mkdir,
> > mknod, and permission through both the VFS identity idmap and a real
> > idmapped tmpfs mount.
> >
> > Record the idmap observed by each hook and verify that every updated ho=
ok
> > receives the mapping used by the VFS operation. This provides regressio=
n
> > coverage for passing mount idmaps through inode security hooks.
> >
> > Signed-off-by: Daan De Meyer <daan@amutable.com>
>
> This all looks fine to me. Feel free to add:
>
> Reviewed-by: Matt Bobrowski <matt@bobrowski.net>

Thanks Matt.

--=20
paul-moore.com
