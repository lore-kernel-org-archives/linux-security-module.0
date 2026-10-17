Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FB63B19BA
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792262576; cv=none; b=HhOiYawwU9wpuv9WKfKN8tANTZjhAA6PdPH7Cys21lx3F6+il2jRy2ZzALxfyqpgtijGQgtagmxW0QW3xxULMYa9EjzFUI9gAUkGWbHnbXpv3zDW2EtaOFvNdhfaPBt63eJ0N5ih8fYoXgBK1rHweR8ovuC5KqcW2Mjd0lz8Sic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792262576; c=relaxed/simple;
	bh=2m98XVROkfl4ZeTFKGzPO6hTFyaWWSPx+UrDMjmKsT0=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=YpCVbeHS4t/GeChz4YyXit/P2N/Xj8gQd9lru/syneZ0gwxjG/QXCu3cjZryU6+2gA0zyz23WbreEUQna9dviNnOkERPd4jsI5J0HhfR61eu+vD2ZpAL88stn42aNJ4AEXAlmG4fpE9NFi7FR1UxyoQ9K+zE3Q/MLxAMiaVTHaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeRpGHSG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeRpGHSG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BB31F000C6
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 18:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792262575;
	bh=2m98XVROkfl4ZeTFKGzPO6hTFyaWWSPx+UrDMjmKsT0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=XeRpGHSGL4wsBEEvnTg3kN/yqH/UAFOmSSysUvBBGssLmEgRJ0IwR2yf+MXErN2/h
	 /axETbYVnPRBX6WK4PIlYmiwDB29wA9N5b+rF6Npjh74cJc0H6atOwfHMMDhOJVwEr
	 FDUwWNwL0uQq8ZdAZWxBTrqQ5OhiEwemZMyinfpxcDNU+vYHVLcspyF5XVbVbU1v95
	 NyLNaNbj5I4wb2gdVYyd4ai9sYF6N5MdgiDDPujzZ6uXyTXzZS1Ck6GcdgfYyZt0Bo
	 S/GriorbQ/WFJsZ294QZFDraNdP9hfbvfPzvL96cmZA3o307GCp6V+IXAG5WbwNfga
	 2DChr1n1JpyKQ==
Message-ID: <sashiko-outbox-175745@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/9] keys/trusted_keys: clear sensitive PKWM buffers
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261017183853.596052-7-ssrish@linux.ibm.com>
References: <20261017183853.596052-1-ssrish@linux.ibm.com>
 <20261017183853.596052-7-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 18:42:54 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The input buffer to PKWM seal and the output buffer from PKWM unseal
> contain plaintext trusted-key payload data. Freeing these buffers with
> kfree(), without wiping the contents, can leave sensitive key material
> in memory.
>=20
> Use kfree_sensitive() to wipe the sensitive key material when freeing
> these buffers.
>=20
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted sour=
ce")
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017183853.5960=
52-1-ssrish@linux.ibm.com?part=3D6

