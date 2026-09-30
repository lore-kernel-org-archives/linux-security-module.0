Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D543B5DED
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790748490; cv=none; b=tRlObKbY1c5MLMFpikR2k0Zn/JrVMeWkLMiblZdAtFyRtoYhIsDe8faeN1YBqqFNBT/VoygKfFk1B9JLjfHtf9QAWAbogbSHM8tme7t9e/DWfzO9wkVO0X0rXVsE6tZN8oPhYV6XBQ1Pkaf4kETY8UXK68XWmvLxPA4HCfdnOxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790748490; c=relaxed/simple;
	bh=q3k+BQ+RBK3U9g8bDeGE0phpcLyF5PUVPi9wEqjMc50=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L4kZLv9iPSRoE2v3zYrzoX9V5eJVr43hpfrrAF2LeDJ9Q4PwZYB/JeT0gGFxea9DqKjIipcyTLOaYvD5QLpbxawJdv6yRI7neRtBOhLEx81qZHQjkuLFaXjJFQT0HU32pJ/BVUiD5ViQcLDLY31usxe4PDl5OrU/LwYwVjtEBJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot5zOM6o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot5zOM6o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BBE1F000FF
	for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2026 06:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790748489;
	bh=q3k+BQ+RBK3U9g8bDeGE0phpcLyF5PUVPi9wEqjMc50=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ot5zOM6ofvT5nh1O2/JvYevHMB6nk0InapIRPW1+A2l6TV2ODC98XL0SlMXk21Gav
	 /YvkL0nDIwJXmzhXkz16CsxVvNZc87HnxAmslS9VTteHgKUSPGK/vITlSNNNuB+eGm
	 MOVf7HGp067PQccjCv7+xnbXJFQXU3rokzW60jlJmGrQS64QB3XoD7ajkIdv9c2zVK
	 Ad0pW+xbr+BxjbsQixu9Ex/Fvjzw6FazeYjLcDz79eHZekxBa4J0HvmqF22om3qbid
	 yjcX8IWoOYvzujzO1BfQ/+TZBtKAr6dw9TNiw+I4l7dee75okYzNVOx8JZEC06NWiq
	 fAHd3JkiIO12w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] keys/trusted_keys: reuse TPM version in option handling
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260930060217.112471-1-ssrish@linux.ibm.com>
References: <20260930060217.112471-1-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 06:08:08 +0000
Message-Id: <20260930060809.21BBE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Determine the TPM version once in the seal and unseal paths and reuse it
> when allocating and parsing trusted key options. This avoids redundant TPM
> version checks.
>=20
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930060217.1124=
71-1-ssrish@linux.ibm.com?part=3D1

