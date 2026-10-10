Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C49536C0AB
	for <linux-security-module@vger.kernel.org>; Sat, 10 Oct 2026 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791628219; cv=none; b=TotF3PyuzrmdBaJgro7luoHZWgK8dlMfRBdUR5YdBtLco1oY1cNfC2j2tvuyArSkHoy/AlgOu156Hl+HQjpbwiQJTjXHgfA/AjcbVYtif+yS6cXqKYJcpZ9BjxY+55CEwu/0ePuohMWF8+urgmkLeQJ2PisQYWJVXoQ9Bqgc/xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791628219; c=relaxed/simple;
	bh=O+JNNRHyBNvpfOP1mFYK7eQtvsqCPUtzV75/eimUo9k=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=or9DvIrmcsC+xGQas58xBK1OxTbV2GS7Ed+IUYNiKjE1pYBtlMq+nsNWA3LrIsEf256ktV3J4vJxnCRW+soErXXQ/zX11JYu/Ku4B+GHog1ni7/lYzNwropPhoRcoO5r/M6OQ/iVHXDnVe8WYRfXHSxHENNsrFfdbyU/BQWBf3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdn/cwAi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdn/cwAi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08ADA1F000FF
	for <linux-security-module@vger.kernel.org>; Sat, 10 Oct 2026 10:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791628218;
	bh=O+JNNRHyBNvpfOP1mFYK7eQtvsqCPUtzV75/eimUo9k=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=fdn/cwAiGRiJR3yqj3I2d+gE0UrHAfqD9fPBDLfkKpthobsb7VSlf64eb4KmULDm0
	 HeKP6dD0AgMsbaKCM7NoRkmYx3QuXd0VqWIBg389Z4cySXjlCZ1BtirCRhryuoiMGV
	 gI9GeEB1tWbO17YwdKgeLBxFR2QT0eVYNBjJcnScTbG3NBiRNFK+WO6qteFCfMzo42
	 0yMAeJj76wN1c/5tu4RPGixz5au3c6ls8xberDSZ6Cwz8+dswMr0KVYCM1gDC6xASB
	 wvXx90C8u4/r3EktbS2RW6FJuGNC0wnW9a9tQ6YtRmS3gn60ujFeiaVB6ZoaQ1F8Pq
	 gX5/nkuZmdR3A==
Message-ID: <sashiko-outbox-166436@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] fs: Introduce task path helpers
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261010-pidfd-get-paths-v3-2-f245440b2b30@black-desk.cn>
References: <20261010-pidfd-get-paths-v3-0-f245440b2b30@black-desk.cn>
 <20261010-pidfd-get-paths-v3-2-f245440b2b30@black-desk.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 10:30:17 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Chen Linxuan <me@black-desk.cn>
>=20
> Introduce helpers that acquire a referenced struct path for a task's
> executable, root, and working directory. Reuse them for procfs task
> links and AppArmor executable-path handling instead of duplicating file
> and path reference handling at each call site.
>=20
> Assisted-by: LLM
> Signed-off-by: Chen Linxuan <me@black-desk.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010-pidfd-get-=
paths-v3-0-f245440b2b30@black-desk.cn?part=3D2

