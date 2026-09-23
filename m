Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C780C309EE2
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 03:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790133577; cv=none; b=b/u45tw7rDryu3/tnRj8t94dAot/wE1m1f9hy055Pkor6TY+WdwDovDgNU3EjY1rBwWxgj7DHzlRd0aOZPPtMpCBYwDI/N8i325zdEFV7fmkeJlhDujBnaBzPkURdJFqlXPswp8VOCmTKMktqhDG2iqWrCP7CexSnx2amAPUOLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790133577; c=relaxed/simple;
	bh=oyphbRnUy8oYjzoYtG59AB8Z/YpDiD19NeewhW3Dov4=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AGXLUBvd7PfYDAM1w49KWdUf3lDIhfxakwkZR/yjEeLuTY+bHpqfibdlfFKq7Q4AxPabnGYyxKVWi5bmM89hRnRKdmn4XTwXNEFSRPMqk4V8JShmAa+GYRFYemfphvMwXKKneEXvmeAwRt34Dx0Sx8Hmb2oO0vF31fLQjPNh3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxfCsCXQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxfCsCXQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D4A1F000FF
	for <linux-security-module@vger.kernel.org>; Wed, 23 Sep 2026 03:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790133576;
	bh=oyphbRnUy8oYjzoYtG59AB8Z/YpDiD19NeewhW3Dov4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=nxfCsCXQy7uVjxY8R2tGUYOjV2DVUw5MfY+SI4aaC38PQ1YU3lEmWerBvIG/fW+t3
	 z+EpNu7Jg3rTerAA47pBxJ6dJPH+MSKpsXFmEto2rUVYp0Xsv1ToeTAm/r4bjmBW/c
	 WQDDw7/+svzZVIwgY27x24mOwUK8QqEFwlDyqmROA4bFHMSf57A7xAm4LwGdXgQXvE
	 rpHhX0DS4ICuB2J6E4roNwyEkDGWaBRRqdXFUmtUHOY3qcL3/5doTQNkeKC+IpK/9H
	 P0A2LTowT+i68xreKxMr337hXiQGPYWmwqMdZuc2mbAdATJrQqoH+F0ilx2cViN64e
	 8mrLH2/h0rgdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] ipe: fix use-after-free when auditing a newly
 loaded policy
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260923031349.1216431-2-wufan@kernel.org>
References: <20260923031349.1216431-1-wufan@kernel.org>
 <20260923031349.1216431-2-wufan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 03:19:35 +0000
Message-Id: <20260923031936.45D4A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> new_policy() audits the policy after ipe_new_policyfs_node() publishes it
> and drops the new directory's inode lock. A concurrent delete can free
> the policy while ipe_audit_policy_load() is still using it.
>=20
> Audit the successful load under that lock.
>=20
> Fixes: f44554b5067b ("audit,ipe: add IPE auditing support")
> Cc: stable@vger.kernel.org
> Assisted-by: claude-opus-5.5
> Signed-off-by: Fan Wu <wufan@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923031349.1216=
431-1-wufan@kernel.org?part=3D1

