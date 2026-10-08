Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F216D33939F
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470139; cv=none; b=CRAVhBuG3wfmCAc9087v94QwsjWZSd2j9qgPkVFQ7Tyohps5NLRfXkwPtZ/N1ViPPC302Fs5SmlmDDH22X+CpUjaWP08yfjVIjES119JDwtFz0p8q61+NCVvc2RLtnLu7+jYlbEUYYvu8RTvBKw833GTwerh73hnbPSFqzyf3BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470139; c=relaxed/simple;
	bh=b+UxBz61LnLPS2KJcRJtXV/W/r1LAiXd1a7dVK5a7ek=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QAvf7vQgprdrGx+8Y09z3TlIGOtjA8foTQ9pt3cdRnwRFHgrV3yIikkpc81dINjeBFmlfdloNaM0YFaycYo9+irYGlA3oTycv8jSUJjxrAZuQKb7i+XrAtxBMPG2qh76dWPikIUw/sW5GRkCwKC58gQgvfSDJsobTgV9llDUNus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ex2cxq4q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ex2cxq4q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86A91F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470138;
	bh=b+UxBz61LnLPS2KJcRJtXV/W/r1LAiXd1a7dVK5a7ek=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Ex2cxq4qYzKjf/xevrO2RKPS64roDWRygaB1Rwbg3SrR5jq18mfP2UHSQguJsbi55
	 3CjkvCf5E8c+DQ19g6ousGgPPrwTLMQrKe/ZKO2aBBmR25MGNwFoqpgPNpGqaC44Nl
	 Dz6CoK48RGblZbx0t7M3Ot5G/19ZkWSJk8SnYQTM2WrgwqKotiWuaOqmR3cVDdtmi8
	 fcnJgtmqMpT7xGaUVMgjzuAaQILDh3EbVgmOM3KFdFnCTX89RvmhNiFZEe+qY2s0Ti
	 IIifPBf968b4bosbqJ73P/e/1/zfjZCEYWHFYfg0hPNtk7k7/PiWEk9wYbjF/HaBJZ
	 b9Zz/Ivq13+Ww==
Message-ID: <sashiko-outbox-164305@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/27] selftests/landlock: Fix memory leak in
 audit_init_filter_exe()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-15-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-15-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:35:38 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> audit_init_filter_exe() does not free the buffer returned by realpath(3)
> when the path is too long.
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D13

