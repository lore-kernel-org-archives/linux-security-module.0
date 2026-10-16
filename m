Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D1E35A3B1
	for <linux-security-module@vger.kernel.org>; Fri, 16 Oct 2026 04:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123633; cv=none; b=DIXCMr0TGaod0Bx2XXbs7uRmf+5kDkt+c5ZPBfVitYk5/tjgygk6kGrbxYIwDwjj6aFWd84Y6U/UzDiNrtA4e5v7JOz3bEF/YtMdF+lY/YdfoZxb/T9OR1YPsjW1vGpl1NsAP/Y1Yn2s6H/X5bOZUYr7AtGsBVUoKTI4Os3GxCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123633; c=relaxed/simple;
	bh=jSxE7p9JWMr64IKjKozJgJlIkpNiz0/rxinP4m5q9aE=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZMXnrBBYMLGm4DVc8UWfdJ0sUVvlvJuNfyfG+HK9rtm3CpC0fBJsAUDLzR3cJ50J6pKxf8ZJXHqTzHZ3JpGCMXUSFKEK3Cqf8y7Xb8W7tAAkQ8THF/2Al/1J8MLRJXcHe7lfyZ3N0LMibIQzo7KLVPrWjgUCvUd7oLWCFoMdoVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ft7Z1InX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ft7Z1InX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08901F000C4
	for <linux-security-module@vger.kernel.org>; Fri, 16 Oct 2026 04:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792123631;
	bh=ET++4vkTKowqdG2//iYeOfEycYFyWl9ozbJlO1tToPg=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Ft7Z1InXxYvZidWrgUJjnfb8V5uike/lW0p81eBMLMV7bwNIQHlUoYIxjB8ChT8lu
	 IMwXFh/ckMikU0lfjKjlMhMX6nCmhEojljrJ6DfETRxN7m5YNf03U8CV62V5HPWjWZ
	 Xwd0EKDXmSsXMyAVX9huYa2GC6iOihYZ8slAFMqakKl2kdiFqya8VRynvpmrQsUE/0
	 seNv6cJvKcs24DjWecOWnIErcGL6AqveahWD/sH6gJoYaWwH7KOybREU1K/QpqWLPu
	 BbJScch2r5vh4F/uxyoix7aCD9x09F0a8AsZjrBITJSOIMPWVlfeim//4Iok0nhpBU
	 snFcP3cDQv3vg==
Message-ID: <sashiko-outbox-173727@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] keys: big_key: Reserve the final quota before
 destroying the payload
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261016040004.324286-1-4ncienth@gmail.com>
References: <20261016040004.324286-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 04:07:11 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> A big_key is charged a fixed 16 bytes of key quota, regardless of the
> actual payload size.  big_key_update() currently reserves the actual new
> payload length before destroying the old payload, while the subsequent
> generic_key_instantiate() reserves the fixed quota length.
>=20
> For an update to a payload shorter than 16 bytes, the first reservation
> temporarily returns quota.  Another key operation by the same user can
> consume that quota before generic_key_instantiate() tries to reserve it
> again.  If that second reservation fails, the key remains instantiated but
> its old big_key payload has already been destroyed.  Reading a
> buffer-backed key or revoking a shmem-backed key then dereferences a NULL
> payload pointer.
>=20
> On a KASAN build, reading a buffer-backed key reports:
>=20
> [ ... ]
>=20
> Fixes: b6f61c314649 ("keys: Implement update for the big_key type")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016040004.3242=
86-1-4ncienth@gmail.com?part=3D1

