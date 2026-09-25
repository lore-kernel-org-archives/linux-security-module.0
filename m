Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5596C4A3D3E
	for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343634; cv=none; b=czX2BHCiaynB8q3dOKynHfzIMZEsDk5Wn5MzOxROQINZphFVkGSURy03FiL8tO3mTAtd7oXGtpBK6/VYOxMkVdDrMiGwf5yn0Sadx0ZIDsNdbhcMFXIVuo5XfLQuoY/8/QOUBBH45PmzTuQgpFmlZth/X2WXUg8nK9/+Fq3YpqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343634; c=relaxed/simple;
	bh=fRObL9ny3GixUTpEjVNTN0X8esBnq7YYN0rMKOHcW64=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tMEPsiQGmCv7F/RjQ5Ma5MPYscWxg1eOtb/dy8+2CrrafLKqDE7uUJ/1He7++a7Zoh0jqebQFb62pcuX8inX7rCI+9djhAY2xNcGxrFr1UV5v/fpZ5lyw3te2g46V6XSvLFTS2yx/yExRP++xVmj5f8j7y43eg9ZvngUvq7AejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRjTrAQ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRjTrAQ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCAF91F000FF
	for <linux-security-module@vger.kernel.org>; Fri, 25 Sep 2026 13:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790343631;
	bh=fRObL9ny3GixUTpEjVNTN0X8esBnq7YYN0rMKOHcW64=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=jRjTrAQ93VVuY50GPqNkAyjFdpNYDMx6CKmehF0rYAvqUpl9Ibq9VI7+EZv2RHv9H
	 qXBMIhfWhGAMxs0O8fcAZ+5/UNAwVuvdnObuq5xUZDfAq4OLmhxZXxEdnpYavlp/sL
	 P+PVoi9hb7oK+FFJaedyUa+9e2EJhdEo4DI2H+JkB/2GzcfvmtfJ+jix8QF2wGtpDe
	 9fT8SChbn6IIrxv6El2qPyzxFdOBz9s33+Ki7a+HRM0JwtWs+q9ew73w0ub+vQSuA5
	 /GNTl90qrZSE83PTVJBwvRnYB50LMe/o/fM5LYffxfwukiylXSb9t1LRMC8li9UWm4
	 9p/cGquXHan4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests: binderfs: skip the stress test without
 binderfs
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260925133435.3635453-1-eva.kurchatova@virtuozzo.com>
References: <20260925133435.3635453-1-eva.kurchatova@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 13:40:31 +0000
Message-Id: <20260925134031.CCAF91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> binderfs_stress mounts binderfs and asserts on the first mount, so on
> a kernel without CONFIG_ANDROID_BINDERFS the case fails rather than
> reporting that the filesystem is not there.
>=20
> Ask /proc/filesystems whether the kernel has it, the way
> supports_filesystem() in the landlock tests and check_resctrlfs_support()
> in the resctrl ones already do, and skip when it does not.
>=20
> Probing with a mount instead would not work here: the test is meant to
> run unprivileged, and path_mount() rejects an unprivileged caller in
> may_mount() before do_new_mount() ever looks the filesystem type up, so
> the probe would see EPERM whether binderfs is there or not. The child
> would then still reach the real mount inside its userns and fail.
>=20
> Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925133435.3635=
453-1-eva.kurchatova@virtuozzo.com?part=3D1

