Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9843BE178
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792262592; cv=none; b=X4tw0MHU36uKlYXSVuVBMtK/UzaOuwTF1QdlGDzou0HTAL4UZRLEowOqH+Wue/t5RWZinExF7uiCzDPd2ZxzrJWeEz3vyqD8xOCTmWFIpkoJ5fzGkME7W4mHRA4/dDaFzBjUdJMuJvC1Or/grpbQhQNYA4Wh26DM6aJ4QVvRL9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792262592; c=relaxed/simple;
	bh=KASieXjHpGmj3TKbWX++WNyj/rkC7UNUmJJ+z6GOFY0=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=JSPsdIWUKvozbo6v6DPn8h8SHNUqWWfkuIXV7LdRKLx2Ju0060zuJhnAG1ROPSjgk9iloY4VAnxRGRfAJEHnZqOiyJ1n1BDvQxhiVGwoy1ePlKBCvI7eWMKmS4Y55IW7P+Td7g0HNHzyfObexZqYVi9t66CMzgivc+q6oiRrZvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhCwOP14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhCwOP14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C327D1F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 18:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792262590;
	bh=KASieXjHpGmj3TKbWX++WNyj/rkC7UNUmJJ+z6GOFY0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=RhCwOP14nobdbyXwBVYROSLQxpQp6CX4aHwQ2y3iRdMUr8to6C9NehGy+EOZsa3yZ
	 sSBHh4KzZRD6ufCzbl/sYOTW78QHJS4V9xZyl02/fJm5th5jGoOSdKowXNNzDz2uGx
	 mrgUN+iBw6Sq2wHANIYqYc1ci2XLePdVmdyOCnBBmfi2lmg7PzXaXnN9/QtjcD0xu7
	 IxDtEooDnBZChDYqnqlFZLYJmlwZiz4ulgWRKSqLZr1KbhFsOP/QCA4YuEkHrZCRBL
	 QlM2h1dX0V4bzbCxCWOOx0G8l+TCIuhkzm5LaJcokd8xkxW9PMvxEZx3z5QsmSemgo
	 1dtNOnYTSusTg==
Message-ID: <sashiko-outbox-175746@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/9] keys/trusted_keys: propagate wrapping key
 generation errors
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261017183853.596052-5-ssrish@linux.ibm.com>
References: <20261017183853.596052-1-ssrish@linux.ibm.com>
 <20261017183853.596052-5-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 18:43:10 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> plpks_gen_wrapping_key() returns a negative errno when default wrapping k=
ey
> generation fails. However, trusted_pkwm_init() returns -EINVAL for all su=
ch
> failures, discarding the original error.
>=20
> Propagate the error returned by plpks_gen_wrapping_key() unchanged.
>=20
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted sour=
ce")
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017183853.5960=
52-1-ssrish@linux.ibm.com?part=3D4

