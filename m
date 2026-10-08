Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DA42E6CA6;
	Thu,  8 Oct 2026 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493537; cv=none; b=q+0jqbpkhwZa2B7vaygewo+6St7nGSsi5u3kfOBgPS8d8oDNMlFWwIqE56vGtqjCyHItAHXROTEtHGQqgrQBkvUpZ/cqJLNAekMc0UMBz26+XnI2DS9YC0cNEfUZueiT3tzzQ7qzcLejHHxxZWMA9R36jDxAYAjT8fWkTqJvi3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493537; c=relaxed/simple;
	bh=GQoEsBDsmE3V3BXy73tHwYpQ5sJHrkWmYAL44amH3rY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cixTZItf0mTlJTsvRCl2KevHOMYvy+tlTyYrcfcKpH6MMwEceP4pbuP0jpIW6hpvniHwbNwU7tYNAKad3D1NZHJ8D840l5NWXwGAG3ZmsscwR/DQdajnfbjrXtPwQpR+h5++xqO5KyFLSdZTAp4MNp7Y0lcL6RxnzOrhGHlSM5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgLRL6/D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgLRL6/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC07B1F000FF;
	Thu,  8 Oct 2026 21:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791493536;
	bh=GQoEsBDsmE3V3BXy73tHwYpQ5sJHrkWmYAL44amH3rY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TgLRL6/DO2p///a5a4Rrrn6oYfY/m2HRP8LUcbT3J6jPJqLbUg+tzQVncR17SN9W0
	 AzX6cLk5ItCDvPgVkOUaOqnHsKkna+nVxQfN+TAdTb4EY2iHjAsNfuS8ohM3M9FSvK
	 s25RN7qqG/sF8kXYWey7IzNsGo4uTSi97QvOfofD++YcSJ2kw1ARtCffXd3u5hdVKZ
	 RULHMCPMfDRDeZ4Ylg2a+dGm7ZwWJ5Kn8WF3HAwazgw3am4mMS/LxTBuYMGzpzZ68Z
	 BkZJLSGlWJl7+rcbR/DkvEFZb4HHoxg5A2l9wvNrUNjTexakbZkjQ3v/L2QJqkmdAs
	 HF6Kqq5DuYZ3A==
Message-ID: <sashiko-outbox-164594@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/3] keys: add KEY_SPEC_FS_VERITY_KEYRING
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrew Halaney" <andrew@amutable.com>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, fsverity@lists.linux.dev
In-Reply-To: <20261008-ajhalaney-dmverity-key-identifier-v2-2-008456d189cb@amutable.com>
References: <20261008-ajhalaney-dmverity-key-identifier-v2-0-008456d189cb@amutable.com>
 <20261008-ajhalaney-dmverity-key-identifier-v2-2-008456d189cb@amutable.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 21:05:35 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Same problem as the dm-verity keyring: .fs-verity is allocated unlinked,
> so the only way for userspace to name it is to scrape /proc/keys.
>=20
> Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-ajhalaney-=
dmverity-key-identifier-v2-0-008456d189cb@amutable.com?part=3D2

