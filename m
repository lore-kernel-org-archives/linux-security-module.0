Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581F733688B
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470111; cv=none; b=rQx9bTMaRax7LAvygHvhgY9NcOhV0k8ut3QOuX+M/c0iH+dvfKKOyb6dQK7C9dxWiTIJsYyvDISFWf8dtpEoudUk+4VSS0J7cPO5cjGrdVq84AhJM2CouZPKCAt6SS9RwnCC/JBUCoEQ3ANieJG8fpYo8X8S26n1rabYEFr3E2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470111; c=relaxed/simple;
	bh=vRV770CyCegz6ViEE8xSsFENZDh1lbasiKNNrNP4Ebk=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SR09cPq1EABhvNHJJl+1mPIh+gHZ1tl8VvTH7jE37EVdpXH2EZpjb1HYzqDywggMGHqI2EFXihfuuwJP1PZ73pHmG2ZMHIqaiu5xjq5057ORg06ToRepB1VoDiAMAnCtBJoBcvPlMyA9gBoQATL8mnrWf1MLWIYbmdU8RSA6j0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWzMhDMn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWzMhDMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB79F1F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470110;
	bh=XL84StlLgB4MiN+W0fLCf/+8mjazYFUk6TAOg+lQBtE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=RWzMhDMnquhuD5mgzSf5BpGd/Sqf/BJ9QSi3Eis0FvIMZOy6MRN8S2VcuWFlDpu+0
	 ssy1NafE4umNfZIFN7ykCAqaEG9E/FbBZoyw4OO4wB7mtwmkN1Uyy1z07NjugTgxfR
	 gsyUTCON6OIN0HWsoI8lgMa4XB2NgsGJIjacDxPkMVpm9jVAhlOYGfEcSez27wTOz9
	 I7UpGGmpp3Zx2iGyMxY9bcSsCeHo7+WOBAq2VnAuOHO05IiXF6lG3ws0Hwsw7MBg/Z
	 /+3J9YNIuSoFrjr/tpK8nz8US8UsRugWzjcuxYNvWkGdhr3kX3bgyxsNclYhBSRgzd
	 ERT1uY1bKr2dg==
Message-ID: <sashiko-outbox-164301@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/27] selftests/landlock: Fix the ruleset_fd check in
 empty_or_same_ruleset
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-9-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-9-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:35:09 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> ASSERT_LE(-1, ruleset_fd) is always true, so the test does not check
> that creating a ruleset with an empty handled_access_fs fails.  Check
> for -1 instead.
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D7

