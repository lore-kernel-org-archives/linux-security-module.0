Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E644AD4AA
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470037; cv=none; b=OPX/vKSTUEfy5uB/0as8plWd4aQH7/zKmzRUcmMLs1mzjhFsCRXgRGlAyeyEBOSMOyEWkMde/ZQgb3HBqFgxhkYd0OA5RGqhfeWzaIpMM5gALddNrq/zFK5T5oG+sTOS68t+4/YjdbSoWD3nK+EPAPfJEwl4Hnda5jmvR0lkHwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470037; c=relaxed/simple;
	bh=WmAveUA64rGri1qSICvxi7aIMoJjjQLgfo8JqrA6CTo=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pD77egwTXonEPzRSG8ACz4Wjq7o92hGe6WtiHWcOT9eZBG2LLDpP1R8IX64F1H0XKNzPTVAntAW15IKwD4wMGaaPYhZbq0Geq7b5Ln0vHpCBKce1egfvh/3JWAi3z4v4V9+1fJbqr3q+RmucosD2xY3Z8ke5h/cXkOiULbGgsSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BI4Zu0K5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI4Zu0K5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509BA1F00893
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470032;
	bh=MecIZNzCSIiFDHtre7+ne/FXcjI3FzfZrccDUU7uvo4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=BI4Zu0K5RrqJFpZbngiqfnOehn+JlwRDCsDL2oWU+YKWWzGVK/DT9lePzfUp8g22g
	 l/yz1Aw849NvxOaCJyj2xrVVwdlawbrppsP6udvKDU/sMTHIIltHubuGfztgxU4XYP
	 K4XqMnVJa/FgdJ7jN9BtQ9+hJ09J/c2pAeGJy+AyO4CzNJA6scV51Ev4TxxHN9F4kj
	 qE8phUl8/MxaestQxgaRAvTb/ufwwaj0ZcEh7aIJZkJIMCqHG8LfPluBYfg2zDSWXr
	 BfhXEi1ULFuXJUB5TJsli+1VuM1IP30h7ewOdzkfANBGd2htvwwy/seQ58e+hUXrV9
	 +YdBeAtN5i+XQ==
Message-ID: <sashiko-outbox-164298@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/27] selftests/landlock: Propagate grandchild failures
 in unix_scoping
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-3-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-3-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:33:51 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> scoped_vs_unscoped.unix_scoping starts a child process and a
> grandchild process.  Add the missing check for the grandchild's exit
> status and propagate it upwards.
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D1

