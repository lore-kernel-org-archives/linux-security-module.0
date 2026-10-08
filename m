Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345B84AC162
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470334; cv=none; b=G8v8jYZtsct05zGPGbykJVJ2f0XkrtnlUuaMV6JfNMwQEuvKjMO9wB1pAeYYyifGyaseuHBIKNsbLVGY9d9HS8pBmMw3O0dJvDMyiwJ26nCYH+1dv29X9PMawftR2LVu79NH+c1zBxKsvutY8kwUhmBnUqeMtK3GC5UUv5R889g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470334; c=relaxed/simple;
	bh=iDNPLa41O3IDY95jIG0R4h9TdRwwKCRdQTn9ldmX71g=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BAIwGyLaUE0grbg5dz103JZBHO5SPs/oXUPGYkCqqUb+M9C0/kFEnexVkB0R8Ai9FfGFyAx6/7/WLogEczU3+x7GgvXlKzrEYpnM8xqSdmSgaI4ejK1GrwMxDvZ48q4XX1ey3nAj9JGobA6g4vpfDDfizdpTL7UUr5WzCf6p+Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1ZDBQ0F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1ZDBQ0F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65C31F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470333;
	bh=XWmchKLPlZD7vN72AmIGvsttU+FnxdpwGKA0JIoIr8g=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=e1ZDBQ0FNS976IBebSC7MwTqLX00qfA1CKE2UNkdDMlmPGK2i401/sXrH6IpS527/
	 v1Z9jXhSrCEWnjOL1Ib1uf5xqk/7IhMRweWXJ5+7ymEY9Sxzyhsj1ETbEJQWmiMdIx
	 gjxGe8c5Uz1+cTDFS2/5qQSbmUxJrryWD/JKBBtL/sN5g9e8mneMIxt44zXiNXAmQQ
	 y6ys6K/9/bMp0zdSspLra1V7amwEXnkVLBkRaP+XusUdOLhQJYXyN4qR6pyHFDhXnB
	 SVzg+OYe3hNAxNJXe+sBswkNxjAStOmQAZanU0gFeqUxFGIJS6MAKfifW2Rszii2jY
	 i9DMZxnLtFylw==
Message-ID: <sashiko-outbox-164312@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 25/27] selftests/landlock: Assert WIFEXITED() before
 checking the exit status
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-27-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-27-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:38:52 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> WEXITSTATUS() is only meaningful if WIFEXITED() was true (see
> wait(2)).  Check WIFEXITED() with ASSERT, as most tests already do, so
> that a signaled child does not also produce a misleading exit status
> failure.
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D25

