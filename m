Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794823114;
	b=KvewqYUI/QywprtHB2eHoac4nB8SkeL2FPGnX8Qs5QiwrQVXFdg23LX3gMcXuJ1LS3A8
	 an8QNIUoGdZuSdivUgSAquxA7YdYdc/eITIIZm5nDaAQa3gLz4HL7KNOeNidgpKJAV8wY
	 sJak0Er7x83lA/tJRm4ZKKBrSV7+KLSCPU79565JaINxf5ScGsFeeU8C/WCjPKltAm4gr
	 CUUjpHRWTbmEKBNKr6OvgQ7Orpd73fSs29yKRgTSP+MCT6txbcQwfLNMyr4kaDpoOoEaG
	 DcpsT/tioRmXvWL6VZ/ZHk/vPzUVT+Fbwxesv4CnOG1CNWXD9ijdzHhMpIckd2iWMVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794823114;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+u1AQ5fOIRemGvMbyAUbDadhBLoJDcms9hs/ombnvck=;
	b=AbKC7YPbGDxdm8vfupuOd4zCcYaKTRTgxEjAn/v+Qdy5bVInOxbD/qnSLWT0RB3zz/Z3
	 jHLFvG4YmHAPOg8Q50gCdGVLv9YtGkTuY9DnLy4B7FpkNrOwZm4XYDxVskAGgTii0NiDs
	 GA3O/iQAE0sWyn2L3Paldnkr6Q7IOz/Q/AvkOJNdq9y3i7sSLardvyQ0xkpezvkSyhjEA
	 oF4wKZHZY7iPOqE8QoX9LPnbk2DwWhmc5m5g16idNQ+7kLHW+5bbvn1bF4eAtlui/eJJD
	 VmGmoB+dgd+EHtzE2rStC5EGZld9h86UO5D7VeYhfrsng0hwSVGFyGGP1tUT/GbGN0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6ynEg4A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF01606A31C
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6ynEg4A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D991F000C4
	for <linux-security-module@vger.kernel.org>; Mon, 16 Nov 2026 09:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794823114;
	bh=+u1AQ5fOIRemGvMbyAUbDadhBLoJDcms9hs/ombnvck=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=G6ynEg4Axuiwes8cg2j2LaFt2/9gPD4Q+cqzW060Nq43+YU2aPO88hAFgHeevfm7N
	 7tMPYdX7bklZyWIbSXtdZmzUdEdOJrOWKAHkhXU4Iq+waFs0Z4HTozG3ejCfcF3N/w
	 xTq6byMtZMnSdEyLszKR/mIL5+JkmD+bHKGqw1q7oVbd4IKD/YWKaO/ut1smtkJ6pS
	 DoBBNaQ2vSL589iLPlHYweU0UiRjwA78ZHQPOJfOFDL6Q7sLa5rDZ40qqvmYLKYBbl
	 MZ4zjWXix3bKtz6NTKxjzKel9rlsOWQsuyWLNHuvvejwzTR8FNPDBhHn3UZw9WkTco
	 9FtVLKe0DIM/g==
Message-ID: <sashiko-outbox-216682@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/13] ovl: return the error from the lazy lowerdata
 lookup in ovl_d_real()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261116-work-ovl-d_real-v2-10-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
 <20261116-work-ovl-d_real-v2-10-90564c4ae347@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:58:33 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> All callers have been converted to d_real_data_inode() and handle an
> error now. So return the error from ovl_verify_lowerdata() just like
> ovl_open() does. The lowerdata dentry missing after a successful
> ovl_verify_lowerdata() would be an overlayfs bug, so keep warning about
> that but return -EIO like ovl_open() does when it has no real path.
> D_REAL_METADATA never looks anything up and still can't fail.
>=20
> Update the comment in ovl_d_real() and the documentation of d_real() in
> dcache.h and vfs.rst accordingly.
>=20
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-ovl-d=
_real-v2-0-90564c4ae347@kernel.org?part=3D10

