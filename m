Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795765085;
	b=1t5iuC2H0q6Ua974ElxWTldS3PCvlaGJKhFbJTFjZCGGpEt6wZ7KDfhCR62zAtMQGEYV
	 uMsmnPbzlDrxa6S9k6dtWE08WIJMT9nBVbJbQXpKlVmEGURW9qbaBiT7zO1CHcuH+WZlV
	 zYN/ifeKgEazyQz0ekMQ3I4nUt9VwuSl16/8vUqOHHORcBSm0+zu1Rgj2fujw0HxtNIUY
	 6SPEU5SC+Sfn5vBxxRzIxEjBUQ7Vl1QtklHlAq2e3ttE/a+QxFCO7A13AnZMFr/57rHJj
	 LO1v/FiADn73534VQuRQ30Bcgy2pZDDMVQNRinHpRbi4RBBVLFRrlUKEGtNCS7QmMYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795765085;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9o8GvW9ZECiYwHtht9FuX5PNsaiVZKxJSs9jpjR0vU8=;
	b=TjEGOBLWP0tbYVRt3eoqdFHTlNo11ipgdClbfppya2Lx7r6yB45Uj5RKsv47fBpHaBEZ
	 hNH/hmry8WOXsHMtv7r2zPblNa7dDovXeaL3e4Y1Vgxe/qJz5/GJucOvV7bLgX/ZLCHrZ
	 7kMrkKPZDl0VvWBN6aKjA++Yz5YIHWtN0xoTcOuAFG8Avrz6Y29n6u9ejPUDrtFMJ+Y3z
	 +yeKa2AsPfmh/SaKkALtwHk7+Ad2nch5IMLbzzyT/ySwXaQbKAj/eM3IBTNxPGygl1Hzs
	 ADjd+Lyq8cldcIAZQBAvlI22HbTgxWTq2u1IYv3Gu3wMpjT9gUb/tB9bHZaUisDmCfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+OodMLN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E130606A31C
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+OodMLN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBF51F00893
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 07:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795765084;
	bh=9o8GvW9ZECiYwHtht9FuX5PNsaiVZKxJSs9jpjR0vU8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=F+OodMLNul8EcDrKiKLV9PT33DBCl1JJWx2i+YXUO0HDXr1e64MzOvtLCeWcYcEL9
	 YXvK99BBqsa/0tla8CpVKoWrO8GN22i4w51wpqv5Sngwm0OC7iweUmLZFKt9qTd7qr
	 Qoy3LCplBV72eLdCTtwUCsWbNiDE3+BshKtLISnE0QAgQsOPAGdA8EsU5Grd5AMME1
	 1zwq6SKv8EGWh/xepZODvLZrbUAXI2F4h3NIOuDPl2eQK2vXXJiHk866LScclMVw3Z
	 CNt3Id61yuDrJ7tdS/zJ1jtQRowrwtZtEq1JPwyLDzyXkHUSfmPV+TKvmC73pQYbmo
	 /2hRCldvWwTHw==
Message-ID: <sashiko-outbox-236814@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ima: free the restored template entry on error in
 ima_restore_measurement_list()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261127073233.181925-1-congnt264@gmail.com>
References: <20261127073233.181925-1-congnt264@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 07:38:04 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> ima_restore_template_data() allocates a template entry that the caller
> owns once it returns success. ima_restore_measurement_list() breaks out
> of its loop without freeing it when ima_calc_field_array_hash() fails
> or when ima_restore_measurement_entry() fails, so the entry, its digests
> and its field data are leaked.
>=20
> Free the entry with ima_free_template_entry() on both paths.
>=20
> Fixes: 1ea973df6e21 ("ima: Calculate and extend PCR with digests in ima_t=
emplate_entry")
> Fixes: 94c3aac567a9 ("ima: on soft reboot, restore the measurement list")
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127073233.1819=
25-1-congnt264@gmail.com?part=3D1
