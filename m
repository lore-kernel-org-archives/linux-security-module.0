Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4671E3D47D9;
	Thu, 30 Jul 2026 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785408283; cv=none; b=DJ5jEJijsw8onfu9k7L6g3yaDyxOkMINWJNYA+hQkySYaysAsyUWQ19ruF1CPiUicB5x+9yJujjrwssKupqqq7gWOAVM1s/9rMNDu7jofFOPFdd0YXasN6vLdc2pJPcvZBPlbjaH4g89shWbDqNcbXNOjfQati9KsCLo9g37dYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785408283; c=relaxed/simple;
	bh=/zoYaM/Ol1p1ApOYlAdd/13LCjynOCKbrL9P0lRvcHA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ch8Ldy4c8XsIrBgBDjNiAyWImVYtI/mDgrPop2Z0LuzvNzFHi4HjJptmDxyo9e9LF7zqU/6Guj8aDtHR1tUjEIq92LxLU2XAHmVaygjsbeAALERRmoK4/qMDCPvpSSxYELnSJYvn+/86XtWLVkJImkZ4wXfaju2GjKEIguYb1zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a08f1G6i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a08f1G6i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8455A1F00A3A;
	Thu, 30 Jul 2026 10:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785408281;
	bh=ZQ7+wfujzlBzS8eMApboqkooKGTBBB6iMz2TbbizK1E=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=a08f1G6ihVT49EA7bhAWLi5sAEtRMpiwnk0XsON8Qa/IlWYIC/FDl3srVYtJBZiX6
	 I/ChmqsMWAeW6rVAOLRXMDRI3fy8D2vq16DTG07NquwSpBNDMyVbqhvj0chh5GNY8W
	 bI7PJksbLM/XxLbncZXgptpW1xb14LVsB3Gzjpw/mMP2CjWewzqDfmntyGj44WNaJo
	 OFG2o+uVtGPGBjfWnPItf6dcEvhlRFCFgXRFQ0vBK3v4/Xx4V2TKQIdAWHlsvGIUy3
	 5lf7eATC92F2G31WHNruDuL55Myz0Dxv4v+xb/nrndZdf/SV7iZC0X8EhlzJG6d/UW
	 ly4plhXcNFe7A==
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 01/12] ns: Free anonymous mount namespaces via
 ns_common_free()
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Paul Moore <paul@paul-moore.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
 Daniel Durning <danieldurning.work@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Justin Suess <utilityemal77@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, 
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
 Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, 
 kernel-team@cloudflare.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20260726161400.3010511-2-mic@digikod.net>
References: <20260726161400.3010511-1-mic@digikod.net>
 <20260726161400.3010511-2-mic@digikod.net>
Date: Thu, 30 Jul 2026 12:44:35 +0200
Message-Id: <20260730-miterleben-minuten-komma-91fdfa5aaec7@brauner>
X-Mailer: b4 0.16-dev-3e0c3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/zoYaM/Ol1p1ApOYlAdd/13LCjynOCKbrL9P0lRvcHA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRla4ul+L3V+C+y3vT3rzOaGZEznzw9pfXggpRgQWVWO
 3fEE6fVHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5v4nhf5Sm2lM+sSl5a6PW
 f3RgZQ7wmxm7KNdVSEDa1m6h1f1LPgx/JaMrVt7S9ueOSQ/iFI/rkqitEwgVOyEyd/216Txvjy3
 nAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hi Mickaël,

> free_mnt_ns() skipped ns_common_free() for anonymous mount namespaces
> (the "if (!is_anon_ns(ns))" guard) because they carry the reserved inum
> MNT_NS_ANON_INO, which proc_free_inum() must never release.
> 
> A following change needs ns_common_free() to run for every namespace, to
> release per-namespace state attached during __ns_common_init().  Move
> the reserved-inum decision into __ns_common_free() and let free_mnt_ns()
> call ns_common_free() unconditionally.
> 
> __ns_common_free() is shared by all namespace types, so it gates
> proc_free_inum() on ns->inum > MNT_NS_INO_SPECIAL_MAX (a new alias for
> MNT_NS_ANON_INO) rather than the mount-specific is_anon_ns().  The
> reserved inums (MNT_NS_ANON_INO and the *_NS_INIT_INO values just above
> it) belong to namespaces that are never freed, except the anonymous
> mount namespace; dynamically allocated inums are >= PROC_DYNAMIC_FIRST.
> So the comparison frees every dynamic inum and skips exactly the
> anonymous mount namespace, matching the previous guard.
> 
> Cc: Günther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Co-developed-by: Mickaël Salaün <mic@digikod.net>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Seems good,
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>

-- 

