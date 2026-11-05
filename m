Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890330;
	b=OaEsSonB4GymfYiHfKOvI0VoknBEkssXIHvZ8Xk6OlyLdG+jwu+dcoy4eVnlg0AiCHib
	 sAxnFOKORRgCaB+aorkHUctPNAYVFl+4F8tPeva2fEuRkZZHeQ1DYT6TUC27Kc/cKSHiC
	 TjcSN4fFx/JOuobqWzW35oPZ3dbjPK6S8YbRuqGcLb4sRgVtd8IDyCHMgFobj4Uq3qOYf
	 v452oEGqjE0YqcBcPlnKF3Obh3b1RwhEEuXx5zMowo1KrKL1pXfpwHJGkxKyKFqpHo8sk
	 LZJfW+Oyyv3Q/Z5Die1WRdLXAWK8p6OfGDduw0X62Kp5UVHHpfaI/RKtMa3lG/ZJsIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890330;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4q6EEmPSt/SIDy/0wnPi7c7RVzpeXAoeutRYUF8Fw8A=;
	b=2zwSKQajoGo4JGcgQjCLdBSQjfo/igxRO10Ix5rUQJvMnOWtEJbQlVh82hXREW/rsuno
	 cEokz3/4ozBgVJbipqhEriCgh8sAQQmWmrZ3bviYoSC+yirUch9g0hWAT0iYQU1+If7+5
	 wKoTdiR+wBeywWaRJZv7ENcpyv7NLLj28Q3IWLI2JFNowgEp1qdWNikB0JkfZJO6FB1Bc
	 A+GsD84u+/DWdEmOTo3TzmCHVt9Spb3S6OC/Xm4QMrOvTFSvQaRkXtCnUM47+vJTyuiJe
	 SPAejmzcQYEgEBGGd5Wj5bd32ab7tinTg4BH32DIWifhrT5IhYR6fuj7btmVV8mEWeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H6zY+PfI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098F4606A326
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H6zY+PfI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18C01F000C1
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 14:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890329;
	bh=4q6EEmPSt/SIDy/0wnPi7c7RVzpeXAoeutRYUF8Fw8A=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=H6zY+PfIbI+87XM5IyUav8RkhQ43t3jURqYb9eB9omZcH8BRxzjaLAMe6X6+PoOQk
	 sL6AcKaoFTI2lOAdd2lUPjtY+3gjF09O+OIXC1Chw01dFrwMP/ePnXSm1IQX5RccKE
	 wmnZJT0uq349GT4TqJT1VEEMw7FDrjtmA/w90rjgjcfy2+gTmXItm6b3PYneXMVicy
	 c0x5LOqhCq91xhsT1gkOUp9iUoGKxtmHoIE3lkqDlGsRTBr7xJg4DRZublW+Sie2F5
	 Fh8hFEHE0PGrfON9LSvo8lQgY1BTRwJ1IJAedeUKvXPb0D1+Vfgp3t/ZEop6XqVdJ7
	 +303X7uTG8Eug==
Message-ID: <sashiko-outbox-199269@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/9] pseries/plpks: fix double conversion of write
 and remove flush errors
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261105144320.357260-5-ssrish@linux.ibm.com>
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
 <20261105144320.357260-5-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 14:52:09 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> plpks_confirm_object_flushed() returns zero or a negative Linux errno.
> However, plpks_write_var() and plpks_remove_var() pass this return value
> through pseries_status_to_err(), which treats it as a raw hypervisor stat=
us
> and converts it again.
>=20
> Convert only errors returned by the write and remove HCALLs, and propagate
> errors from plpks_confirm_object_flushed() unchanged.
>=20
> Fixes: 2454a7af0f2a ("powerpc/pseries: define driver for Platform KeyStor=
e")
> Cc: stable@vger.kernel.org # 6.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105144320.3572=
60-1-ssrish@linux.ibm.com?part=3D4

