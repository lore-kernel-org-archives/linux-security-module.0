Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7361839EF0F
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791391005; cv=none; b=Hep4wEgSdLkSwojqzpJaGTGugm39W9Evd6z/MHqdeT9YERi/Yva5aPXYssfEtNe9IVFRP/4r0sOCKV08jMTHtjaYgT7u6ZiFkJ5LzWz0oIN8lUmz5jItW8r8sQ5vN+IsUrQK48IvZfd6lff0penN2dLcruNlleSN1cTbtiKRDQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791391005; c=relaxed/simple;
	bh=2jjReFwLMXqo3pVUhlYuAtrOm5cmNEPrCowq4S+XhNc=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bSTMbn38yX1S2En3wBlXGX4/GA3HDosPDLZld3g3QtMcoMt4W4KVDwfClk9SQO6KdQIDxudgdd9S/FqmIBAkk9S/17KEmUVJKl52cWmSY9ZhLgB0MkzTk/PSxzvrulAmeSeApv2zPKXeZiVQRIDeiwNcWmdrJiXdJu75uBXQh44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvIr04L7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvIr04L7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C9B1F00893
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 16:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791391004;
	bh=7fR+5q/b9OgX4rN+MVc9CBdgJJhh4pU8Mk/wu/QUvhs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=AvIr04L7C6FEBh0TwCkb4cgMgQloqJxGMq8T5HfKfW1TquHY/k01/YRtKA0Kf7Loa
	 y7TtQ6QzyNi5ZPTCZfJmcVmjfRRvHnCo127ipa/TQt7u79jp6lDr7xeysLNL5GRuB+
	 OgJ8Z881qiuRKE3QpRB1zwosl7RolSjMGyAaF0SKffBO1PDGmv5Bk7BpZA9w69jVO0
	 Q2KguBcW3v6NSBE3e5/GW2lgYt2J2l5NEfh4HgieyYNKCzEQbuyQjJtO/EFzfma21+
	 Yb2MyZCEecr7JN5cZFPQ5e1vpls1qijZiV+rsAkDzQ3my3ca2/Ss2m8NmxbNeT6YVA
	 89dJPp+ekd+fg==
Message-ID: <sashiko-outbox-163199@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] landlock: Move the domain layer counter out of the
 anonymous union
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261007-b4-landlock-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com>
References: <20261007-b4-landlock-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 16:36:43 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> With Clang 20 and CONFIG_FORTIFY_SOURCE, stacking Landlock domains can
> trigger a fortify panic in the handled_masks copy in inherit_ruleset():
>=20
>   __fortify_panic
>   landlock_merge_ruleset
>   __arm64_sys_landlock_restrict_self
>=20
> Clang miscalculates the location of the __counted_by counter in the
> anonymous structure nested inside the domain's union.  In an arm64 build,
> __builtin_dynamic_object_size(domain->handled_masks, 1) reads offset 40
> (the first handled_masks entry) instead of offset 36 (num_layers).
> Because the destination domain is zero-initialized and its masks have not
> yet been populated, FORTIFY sees a zero-sized destination and rejects the
> copy of the parent's layers.
>=20
> Move num_layers and handled_masks to the top level of landlock_domain so
> that Clang uses the correct counter.
>=20
> Assisted-by: LLM
> Fixes: bd3a19800dd1 ("landlock: Add counted_by in landlock_domain")
> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Co-developed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-b4-landloc=
k-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com?part=3D1

