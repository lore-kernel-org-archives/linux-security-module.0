Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFB0412BF8
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406289; cv=none; b=aX9Cinp87R9ByVAQpAxkw0ig/RH/XT2QmJjxTzwzS57D37NHAHE/Cd4VP+f8E/gwnhqGJldMbT2lG9mvu4B/FgKke0WlV/rvVkCtDmraqX7aRGq9gJI8VE5tNbPWoOME1hX8/BeW0m/t0stjELvRlAcNe29kmQ2VXK/Iqn9SDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406289; c=relaxed/simple;
	bh=mIgE7fAHgQeTdSvbC99wbWdIP5IPfykKJc1ISSnch+A=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QM7Cio/ghF3zPEPOa7oBTxIl4CGP4oDL92syW30/RQdwWx52D2B4kcKXWzfwH6bn0XD5oj7JjG8b6Znyj9DXFiTEI6s0rbusSSd3N8Ej9f68geAGAjYUrToxOiQLmOQoe/qtu1281koFq6hv39cBm7J3rXO6Beu5FaGz4bZtEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWZJFYPA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWZJFYPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F981F0089B
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 20:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406288;
	bh=mIgE7fAHgQeTdSvbC99wbWdIP5IPfykKJc1ISSnch+A=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=AWZJFYPAQU6iu7yLkiQHy12+gS+XGAq2PeA749r4G//aKU2MBiXLc1XfO5oiIn/ZW
	 gbKjONPSJxkDDtii7yxEs2IYOLb5v/i3VNsQBa7HRK75ZeOpoM8/zUQxHTMa1KFKW/
	 BYdZsiTNPE9ageXzR2Wqt4HsYC8V80dS9c6GEABsJ3Ihjn5qBSrSXkFbXl41CHwRtA
	 bArBCRVT1VTD8k1VTNOAoGe/TDDxXzNamVxSW+yFmyu3xjWiAygygbRF+Kg9lMeKSQ
	 o8mYfepJIDTDJppQl4mwQxN00v7LlajVK5EzakfNczxnQArqervSP4JmpqKTtV/MJH
	 RDcKmF45v7TnA==
Message-ID: <sashiko-outbox-163357@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y 1/2] AppArmor: Allow apparmor to handle unaligned
 dfa tables
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261007204226.47033-2-artem@trailofbits.com>
References: <20261007204226.47033-1-artem@trailofbits.com>
 <20261007204226.47033-2-artem@trailofbits.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 20:51:28 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Helge Deller <deller@kernel.org>
>=20
> [ Upstream commit 64802f731214a51dfe3c6c27636b3ddafd003eb0 ]
>=20
> The dfa tables can originate from kernel or userspace and 8-byte alignment
> isn't always guaranteed and as such may trigger unaligned memory accesses
> on various architectures. Resulting in the following
>=20
> [=C2=A0=C2=A0 73.901376] WARNING: CPU: 0 PID: 341 at security/apparmor/ma=
tch.c:316 aa_dfa_unpack+0x6cc/0x720
> [=C2=A0=C2=A0 74.015867] Modules linked in: binfmt_misc evdev flash sg dr=
m drm_panel_orientation_quirks backlight i2c_core configfs nfnetlink autofs=
4 ext4 crc16 mbcache jbd2 hid_generic usbhid sr_mod hid cdrom
> sd_mod ata_generic ohci_pci ehci_pci ehci_hcd ohci_hcd pata_ali libata sy=
m53c8xx scsi_transport_spi tg3 scsi_mod usbcore libphy scsi_common mdio_bus=
 usb_common
> [=C2=A0=C2=A0 74.428977] CPU: 0 UID: 0 PID: 341 Comm: apparmor_parser Not=
 tainted 6.18.0-rc6+ #9 NONE
> [=C2=A0=C2=A0 74.536543] Call Trace:
> [=C2=A0=C2=A0 74.568561] [<0000000000434c24>] dump_stack+0x8/0x18
> [=C2=A0=C2=A0 74.633757] [<0000000000476438>] __warn+0xd8/0x100
> [ ... ]
> Closes: https://github.com/sparclinux/issues/issues/30
> Signed-off-by: Helge Deller <deller@gmx.de>
> Signed-off-by: John Johansen <john.johansen@canonical.com>
> Assisted-by: LLM
> Signed-off-by: Artem Dinaburg <artem@trailofbits.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007204226.4703=
3-1-artem@trailofbits.com?part=3D1

