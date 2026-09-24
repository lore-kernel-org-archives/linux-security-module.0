Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22C64C14FB
	for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 20:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790282363; cv=none; b=W3fQ8vPAy3kHGwM86+P4M+pD2gxDmMf29bVm7GwIzRH+4FCDiYMteKVtaubLXfGqoNSD2bLLSzb3I4b1AGfPpEa4M/jDDvdvuLppTeMt2jpCFMGTwJKCGVNZAgndD70QbY7tcxjNr7fekI6D7L8mHBRe945COBr1eKT9MBi2VaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790282363; c=relaxed/simple;
	bh=BMdn7ErlCquQEhfnXiOvOzOXNzvnzBx8sGK2Nb0ZE8w=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WQHS1Lu2v7j8fXTI96TOZRNhxFjz46/LJNVZQq1ljKL7VIOgjFfDLB744eRpyLD+/bfpNIQI7UcKnxp4tf6B/HGvGj255QqFKkxbFpTf0FTMxCK5GBXJTpPVCYsHdpdrWaccq4OyUx7VrWYsd8Sn/+g5bJEnpCogxZbl5qQmMUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhreL1wh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhreL1wh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0AA1F000FF
	for <linux-security-module@vger.kernel.org>; Thu, 24 Sep 2026 20:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790282361;
	bh=BMdn7ErlCquQEhfnXiOvOzOXNzvnzBx8sGK2Nb0ZE8w=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YhreL1whh+An/iKUkuzj6YTtF8djdv+FDEv3aBZUMi1Gj7njpB4B4Dw+tup0dqgcc
	 UyX5FHak2U3NM/uaf/so7+tnntffAzK+5LEy4JBUtmgQyAEl2mVaVRuVc8nuzFgz5F
	 sWfHKqWV+S8VaQ6PotmXfMoEiIZGZ1ARxONbSzKD3y5/o46hGLBY75BybRIIkZKcGA
	 zPbnqf5CaXmY2sYj68fPXpOho7sX3DKktjjGm6aL74cYb7Wp2TQSFlYkCOkGCA0Rai
	 r1kT4C+DgBhOP8nJtFC2BtqWRsGFNsroqkgietpjEp6HPKLw7c+PThnIQ7jpOCWWyB
	 SILNVy+9g0G+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] integrity: Replace integrity_audit_message()
 with integrity_audit_msg()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260924-report-hash-error-v4-2-196ca6350619@cloudflare.com>
References: <20260924-report-hash-error-v4-0-196ca6350619@cloudflare.com>
 <20260924-report-hash-error-v4-2-196ca6350619@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 20:39:20 +0000
Message-Id: <20260924203920.EB0AA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Now that integrity_audit_msg() accepts an errno parameter, it is
> equivalent to integrity_audit_message(). Replace the remaining
> integrity_audit_message() call sites with integrity_audit_msg() and remove
> integrity_audit_message().
>=20
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-report-has=
h-error-v4-0-196ca6350619@cloudflare.com?part=3D2

