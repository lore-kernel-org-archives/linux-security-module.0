Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ADC3CAA3B
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792262592; cv=none; b=Kyjq+PtGw9t+ArIc/1dMlo363kDd5O9jLVrf9O+SCX0aQyWYNbFHMuZbDN0+vjHfBatxgpIP/cM1HRG5GYz9+VdwNYhPwFmzzSZ5udA7yWbuiZI+sAsvIguxJAe2Iozk60R92KFY6Yk/YhfWwGsN1GFCCPTCIizvsDgkQf8E0UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792262592; c=relaxed/simple;
	bh=kIuAll5gKt/lDnHQ6xaiQb0SoSPUyekjWcrBOztPtd4=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cJhfB3o2sReyacc4ms63VONI6uK8IuLxk564HmZd8bMH49dUmkzsLULcSILauqfTqy0CIgT2RxSFvXMBZtFZL2IdVG7bDWzcKsDyCtHnNtTNzENWb6wHKJNOtP7AVu0SfdqNqv8Xu93Y3qq+ly3z4ouWRvXFDGnzXsfXImHXwXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvi4NiO/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvi4NiO/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563681F000C5
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 18:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792262591;
	bh=kIuAll5gKt/lDnHQ6xaiQb0SoSPUyekjWcrBOztPtd4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=mvi4NiO/gxs5gwYULwGZNocxagyUlcJxLJuVcRv7sB4NJpj9Q080dmTk+YKWbulqC
	 Pw5osA4pRnyIZZzTqYz47MSrcVvicqC1qzZflMB1wXzZ9soXrOZ7yF+mdZ3THFtJ3E
	 i49y1Eb8tevVDsKFvbJlWjHO44LkgRPKOEIITl5tf+mmACvKq+Yko2XE36fupt7Lh6
	 GyORHr9aLCsEHe3OvcqLbEyphiEhIbxlwuUyt9UrplIa+hP+2p3oWfZe0DZU93a+Zv
	 /gV2rT29VMRRRoc/g4lQBcN+sRcU3u2Jm2GySMcnE8biJ364/j9e/0OofHif3EwAGL
	 ZoITfgYELe/5Q==
Message-ID: <sashiko-outbox-175747@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/9] keys/trusted_keys: fix PKWM output buffer
 cleanup
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261017183853.596052-6-ssrish@linux.ibm.com>
References: <20261017183853.596052-1-ssrish@linux.ibm.com>
 <20261017183853.596052-6-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 18:43:11 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The PKWM seal and unseal paths unconditionally free their output buffers,
> but the PLPKS helpers can return without initializing those pointers.
>=20
> Initialize the output buffer pointers to NULL to make cleanup safe on ear=
ly
> failure paths.
>=20
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted sour=
ce")
> Cc: stable@vger.kernel.org # 7.0
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017183853.5960=
52-1-ssrish@linux.ibm.com?part=3D5

