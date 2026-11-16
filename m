Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822597;
	b=gKA11XLw7lxOOFCXa4DHx5hJHoQHOwQ2RYGgXChNktE5D2wNE486rgxOY3IKb54WeEze
	 OfFwSt/ZtB4utIiRoC17IKmZ9S6+rJ6td9igS72BUIfHtIjlAyxl85VOdZ5491/OxWmER
	 4vlukcBcs+AlYpoXVMlDLGe2pHPGNtF2+d6zFYh734068acvzUWlB48Ok6up7Mkaz8OHo
	 HPMXil2WzR1u6KTANGKbzMvokFqhYzHsFO0bcLB7ElYm6W8Pb/OB8jo7HW2q1tBnXuuRM
	 lPXLrlpFKpYB0R1IgjaymHuchgqJlaPceaQsQeuzhm/Sf0IkrvQVocghoe1XYJGRIFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822597;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3o0/wRj6rzj8t8LkN2EqI6djcVFri9++1Pq/uIrnKA0=;
	b=u/16R8i33LU8b00+crmsOMg+VkwCdO0i9OxeCJV/rVt2Q11tC1SD1rDa1wfMRA4NrsAx
	 Ld52fSeVFQwQumGbKgghqBbgixa9Z1XXI6irc6814Z6t/t088jbO28VuTsClyzSgy8zJ9
	 ZHzZFCpnRIrq1TsAdopoTerVKvWFxbwyDjwjCAIBgLoT0S1tUSHnqQEktfblEvibva0lS
	 gAJhQ/UjPe/hUZ7p3Vn6huMTd6MOH1skbIfxN1jvBT2UydF3mKsQslI2JyL9aLxpeOCac
	 Vz0VZkJyvLlaC2yjkPix2ujMGuoHbZUi11Z98aQ4cU26uFVmEMPZcP69Kv+8n45PpvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=INSCIX98;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7B9606A31C
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=INSCIX98
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113B11F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794822597;
	bh=3o0/wRj6rzj8t8LkN2EqI6djcVFri9++1Pq/uIrnKA0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=INSCIX98f0X1CgrYHUX32kbeBCamajozE+cwjj5ezCANpzcd8Z5KxhCmaY8D3JyoW
	 AhMYh87M0nGcT5ExzEa9OlmnuYsRBYxkg19WDQs1T7rjr2OhshSjdhUXzVY3acZY9b
	 iQ0dJxiMhDUsSbhuoW8M+zLm6zY9fBxbOv6/C1PJYqJITylsy0KbyLb/qFP055pBvC
	 re2sRVYZ7axFDXC/5w1Nggv6MLpV6yZZ7IW1zONz5TIs78zVmSqpr1lwKOhkrmfZsG
	 pGDkgDbL6vQWK4Lmu6jGcNhozV5SxS34/T1Z8oL8Ry/eNZDHZJ+HAlQ9LAHrRSiy3p
	 b9VeeEUpnfsdg==
Message-ID: <sashiko-outbox-216646@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/13] fs: add d_real_data_inode() and
 d_real_metadata_inode()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261116-work-ovl-d_real-v2-2-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
 <20261116-work-ovl-d_real-v2-2-90564c4ae347@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:49:56 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Currently, d_real() can't fail. When overlayfs fails to look up the data
> of a metacopy file in a data-only layer it hands back the overlayfs
> dentry and callers silently work with the overlayfs inode. That's more
> problematic than current callers realize.
>=20
> For trace_uprobe and bpf's uprobe_multi it means uprobe_register() fails
> with an -EIO that has nothing to do with the actual problem. For IMA it
> means the stacked change detection is skipped and for IPE the file is
> evaluated against an inode that has none of the properties of the real
> file.
>=20
> Teach d_real() to fail and teach all callers to handle errors. This adds
> two helpers for the callers to switch over to:
>=20
> - d_real_data_inode() returns the inode hosting the data or an ERR_PTR()
> [ ... ]
>=20
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-ovl-d=
_real-v2-0-90564c4ae347@kernel.org?part=3D2

