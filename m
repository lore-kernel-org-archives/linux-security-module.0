Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827144;
	b=b0fP1sMXYoP1vQ62b8K0dBwRNokqb+IOPYiP4XSQMA3shFN3W5PrsSMcKYsxtbWu/p1q
	 sXW94JenXVjXEZCYPugmq0HMBQrMRM0VkhYLe0rTBxM9m86KrBt1n0MXhRUK4rf2TF2+M
	 u4KGMCCQs3hY5JinwdRJXCgSwy3R5t29R17eEeQjKVhEi1GVm8R2ANUJ7q1TAtSu2RUhk
	 r0XPGC/o+boGGDgxcAFP0Jt05MfHD9rmh9m9XTSf/YEavBWcn6z2UH0YEBBg4JjE8F4es
	 u5wCy3XnHlJjt67n1Pjc1m9PJpXJfIU2ngHadGiXUvWN9rb6DxxPoacdaf5wY5Kb5XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827144;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PkDzvILJuLoEu9sy75Ht7HncDEVSZR19CHr10HmssjE=;
	b=sr+ft7s13FSZA8/hXCRGesPxhs1kGsDfP/qv0fMV3HOl5WtRj1gv61M0VuBU/Pl94i2A
	 FNPscbwMGwtkTDwkG3Wmc301eh8hvzxBFI9kGGTRj5QyhJegPPz7VsaFvm/OtkEiKvofS
	 gie4R/c61VNozQ/TH6uN2hnDfH+SFIL5iUkmgQLqMUWOKDhDfqKdQXfltCV9q8RGUNOs1
	 XN4p/t22IoZfWHB47Lyqg1QtL5BSUr4mDAT40jBp4PhuFTVqxROKrGih2b18jV72cw74F
	 a+DB+mtUK62flxbkWjNsTbztz4PXGjn4y9abWe1NqjvuEMRV+M9AzvgElLnbp0f/TNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KzUp3yBt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72659606AB30
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KzUp3yBt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3E81F00A1C
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827144;
	bh=PkDzvILJuLoEu9sy75Ht7HncDEVSZR19CHr10HmssjE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=KzUp3yBtswF3sfwFLU3Kkf2fU8VbxBmE25ejXxD+IpUfF7Cn4JgvLHbGajje3p8gz
	 Q2RzsskLxWMqZa+31ZLQxS5xgvd8CreOCfBSOdp5dqfYBw2jr1jQ2hf8znal6ACOT2
	 vu1tgY7v22lQPxR3T+kxxDaNlrYFB4gSYUoHgplNMwXEMlOFrtZq1xs0hqFlAbC/0V
	 6ZicJDb+ghifechBGr4j3NoTdSOnlRjJWaaXvbIxb/ZOIkobn/2ytLuRpr9rwojLcW
	 gE46aoTHSg6cwNRI/lL6b/cxb9pJ/aR4qHyuy6VbJebUY/1msE/akOhWLdAmEdsor6
	 ZeYZm/CWEjZIA==
Message-ID: <sashiko-outbox-198092@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/27] selftests/landlock: Fix regex_escape() error
 handling in matches_log_fs_extra()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-18-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-18-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:19:03 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Use a more conventional error handling interface in regex_escape():
> Return a ssize_t, which is either the number of bytes in the output,
> or return -1 and set errno.
>=20
> Before this change, the (log_match_cursor < 0) check in the call site
> was never true because log_match_cursor is a pointer.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D18

