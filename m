Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA481F3BB0
	for <linux-security-module@vger.kernel.org>; Mon, 23 Jun 2025 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675500; cv=none; b=V9HWaWb6LRd359xE0LylnS0NxdwJYcGdTgTW0yg3nEx+bmJP9vb7KKiYZFb/VaP37M1UrMLaUGwOqSOgJYBohUsgGfvDjCCgqF3QayEpaX6ZFmRPPAPEoHi99tUlkvjwp7eiujS3ifCaDHYIn1HyoBEtGvAlS95Aw7TXKwMGwqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675500; c=relaxed/simple;
	bh=/xiGi9AKtGjBnq0MzGb9exxbcql03fu+5GgF1Qpg6zI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X0FUxn9WsgEQrXQ7+9I7pz95Z5VRqyoPRAxA3CaiZqN7YwOdUKeHFPndZixfc5EtkK5rpUSUaG5/4LBaqeiB8SkyKgH26d9BPdDcyanzoVeoxA8/GlvdgaeX4zV1IAEJAQIUKU7G3v66I3Kb0gsFvr1RUzWgegAiVyaMZnTdrBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sf1rQfJM; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sf1rQfJM"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so23336475e9.2
        for <linux-security-module@vger.kernel.org>; Mon, 23 Jun 2025 03:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750675497; x=1751280297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppbg3SAN71AnYkQgqZky1I2Bcu/4MKLspU05dRI5Tuo=;
        b=Sf1rQfJMG1y2bCVvvkKui7gzfWfiSEOF1ftkr+0kWGeY43mAnyHCVFMmjRy8Oqwb55
         DBv/WcTP2prUdKygk+X8mESV2p5rNv3UGh2Bvn2Ow5R2PZk9YQxv3xn6/md55o0mlY8E
         5h+dSv6rqhdACoG6KW7vmd7/F0t7V8GrwEVn4z1slnAFE/U8IUAL8bmOb+t6bgn7Z3F7
         COMI6mEpn0pPftmd/QjnsHwwNRAYBczNnXfq/56zMMGrRoo8NZcGRBPVh2hogRNnFS5A
         lGbAUz21OVo8LYV0ANvtKt2pugYKmKrjMxZWvrvT1XCE8OhUqyR5kaKbrbuPmrZWh3a0
         7xfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750675497; x=1751280297;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ppbg3SAN71AnYkQgqZky1I2Bcu/4MKLspU05dRI5Tuo=;
        b=n99FwPts2hM9CGQbMFt5FgUFOS80rThS1LEr68WN0lGstirEA9c8f7aAgA94MFYt5S
         jEc2xn4870nHpD/B7u/N6pAQ/sfon8qCEhRhy8rug7AV8dW+Cd+eDCTtR3OAYkt5cTLw
         qaf1+WMmRXYikpZmfDHyDFETONEfmASx+a1G3qNiHq/l64qmPVhT3stxbxj7Ed90yjhi
         xKaaLMpx3d9xg7ElitU2SiftHc+BaV/LFKpcTxfI1f5koFRUM4zbmOkI0lyUP5CxvNeM
         LhwYg7LzlhaR5OS5OPslLvyvuyP/hndllsqUZZO/sgVBPm23MYnjHhr0PzGziZGkPQo0
         OIEw==
X-Gm-Message-State: AOJu0Yw9yKs/HjETVbc/L9BDMdpF6u2P9OToAqZdiKXAMaS5U73oUiqM
	Jq/06efmfUwA8uu+41SsZjz0xwkxju7LWa+Bqh+NB4icGbw9fWk+enapARNTT731EJUGCxb1pow
	ZrSq7iw==
X-Google-Smtp-Source: AGHT+IFoK7Y/CL3pORwCvVFiQqj2E1mzYymEsWgLN9+EqXf5MmBSpKR30SgQggtvI8KNMNQKCpKI6QNFZ8E=
X-Received: from wmcq17.prod.google.com ([2002:a05:600c:c111:b0:453:6c86:95d2])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:6305:b0:43c:f513:958a
 with SMTP id 5b1f17b1804b1-453654cc279mr102977235e9.13.1750675496872; Mon, 23
 Jun 2025 03:44:56 -0700 (PDT)
Date: Mon, 23 Jun 2025 12:44:54 +0200
In-Reply-To: <20250618134734.1673254-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250618134734.1673254-1-mic@digikod.net>
Message-ID: <aFkwFudOCoD0vsjt@google.com>
Subject: Re: [PATCH v1] landlock: Remove warning in collect_domain_accesses()
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 03:47:31PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> As in is_access_to_paths_allowed(), it is also possible to reach
> disconnected root directories in collect_domain_accesses().
>=20
> Remove a wrong WARN_ON_ONCE() canary in collect_domain_accesses() and
> fix comment.  Using an unlikely() annotation doesn't seem appropriate
> here.  A following patch from Tingmao tests this case [1].
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Reported-by: Tingmao Wang <m@maowtm.org>
> Link: https://lore.kernel.org/r/09b24128f86973a6022e6aa8338945fcfb9a33e4.=
1749925391.git.m@maowtm.org [1]
> Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LAN=
DLOCK_ACCESS_FS_REFER")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  security/landlock/fs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index 6fee7c20f64d..1d6c4e728f92 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -1061,8 +1061,8 @@ static bool collect_domain_accesses(
>  			break;
>  		}
> =20
> -		/* We should not reach a root other than @mnt_root. */
> -		if (dir =3D=3D mnt_root || WARN_ON_ONCE(IS_ROOT(dir)))
> +		/* Stops at the mount point or disconnected root directories. */
> +		if (dir =3D=3D mnt_root || IS_ROOT(dir))
>  			break;
> =20
>  		parent_dentry =3D dget_parent(dir);
> --=20
> 2.49.0
>=20

Reviewed-by: G=C3=BCnther Noack <gnoack@google.com>
