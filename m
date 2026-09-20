Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00143486624
	for <linux-security-module@vger.kernel.org>; Sun, 20 Sep 2026 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789943690; cv=none; b=H1fZuH+ZKc3r9UGmkaDAvVFUWn16tT/WmPvc5JYGlpPoaHrv6Gtf9H4DUISisW/b742t7VLq51/aTWYgE56r97LWHJIWcECdPKaeyI04KoymV3d0QlEBnLkoas7CKjR0S9E7uRyV02ST79g3kGjprcqT0f7YIdUR4HAfV3HcoLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789943690; c=relaxed/simple;
	bh=+c3Qs5cjG28t2QTBqCT9M5zlYEjA6smSkxKAo376xAE=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O1wdxratO3nz2aBb+w65FesLR0j2ReIjpOK5q31UXyALzsX/HikBKc9NErRstwHR8QQcUZ9SsHj0X0bgzCs8O3E4jMSFcbUjARFORRBpGFclNv/MHo1pGjn+Yb9AHxvol15BEJYZO0BHRITWBCDPpitJybEI9U+0LPANT94jVGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WU85+DwS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WU85+DwS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F02D1F000FF
	for <linux-security-module@vger.kernel.org>; Sun, 20 Sep 2026 22:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789943688;
	bh=9Hmi3EYAgFMUs/wfmyl4BeQF6ZBFxmGi2zJpnbm2MP0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=WU85+DwSDqmUB2Z6OD0yf5b6cscu6ZWItblYy92i26s0fZ67o2IOiQ32tD7HeDnja
	 +g69JyxFJjCQtetEqjJNbyu4Evq+3ImhlHjO/uaVvQySq7GhiANpVm2r2PHxDIWxJi
	 Pop+VdZUuHvJhbO/dVKljxxgCXmY26zIEyQbk1hkMcvk5EIX3/rGF1zo6wTbP1Wx32
	 PBWlkzLcTCgLEogfiyNzJ0aFdV/0a1beWvcwmhWZ83cWbbzzsJtL6lza2qePAwArRu
	 3MlFav+Sg/ooKvBxxaFkCpUvJqivMRXYoqKkSo8iZZeFLNM3ST7lqKiSH27mdy4s8w
	 j0RK286/ZHxVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] netlabel: calipso, x509: clean up ADDRSELECT on DOI
 removal and check AKID len
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260919223438.3883567-1-benquike@gmail.com>
References: <20260919223438.3883567-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 22:34:48 +0000
Message-Id: <20260920223448.7F02D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Fix two issues in netlabel CALIPSO and X.509 key parsing:
>=20
> 1. In netlbl_calipso_remove_cb() (net/netlabel/netlabel_calipso.c), also
>    inspect NETLBL_NLTYPE_ADDRSELECT entries so IPv6 address-selected
>    mappings referencing a removed CALIPSO DOI are removed.
> 2. In crypto/asymmetric_keys/x509_public_key.c, guard against zero-
>    length signature/AKID fields before key matching.
>=20
> Fixes: cb72d38211ea ("netlabel: Initial support for the CALIPSO netlink p=
rotocol.")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919223438.3883=
567-1-benquike@gmail.com?part=3D1

