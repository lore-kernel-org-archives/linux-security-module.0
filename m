Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2701F25B08D
	for <linux-security-module@vger.kernel.org>; Sat, 10 Oct 2026 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791628251; cv=none; b=JrXu9U5ijLWoVfPOE4G6bfQIm8NmeoSfR//jH2xVjAzNpjaQUIEOg8tYiao4a09/b7YF9s1uNu04PF0zgn6r81jxPkRb7CwaM+REpSVlWJkoh9Vf9PWUPQC+8LhAvGH/2pIT1f+B7sSabSbkx5cajPNnf6ImRVCtRgu1f++BtKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791628251; c=relaxed/simple;
	bh=5tArg1oCWkWt7RO77sUzlcCtzD7cjaOF6CsBBF/9I/M=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fJbOUpqvt/jQM7HQfOgOvGsf2nVyA9BxQgjioz1Z4gO/N7dQ8fYDQTEQFbtsG7xVsmaRA/O7LzihG6vewPfTpROkdHcRLxaPGYlsrxpBI6S82S7vToTniUhS0u2FgiJQxw2nxG5dAXfoZAioGwEqY9qiLIyZWE/kPxiEQBdQ5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXnxhvvD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXnxhvvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3DD1F000FF
	for <linux-security-module@vger.kernel.org>; Sat, 10 Oct 2026 10:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791628249;
	bh=5tArg1oCWkWt7RO77sUzlcCtzD7cjaOF6CsBBF/9I/M=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=YXnxhvvDomvTo8wKD8f1wwf4BuwC1k2Ct3cq0dBqpHkyzBsPpEBHmMptFo/Wb7i3N
	 zcG5doYUUAyXHPh4HCXu9LqLo7VwBXDABphvD15YeaKJQo74f4DYeNUF92cDFtK+K8
	 WsnUQdyA7sqLEmoK+uGJJDuKXvzAT8H/Eiz9Fawm/LBw+tS3YybI+paqTWgWrGUNEA
	 Srrzd4Sa+3WF3kNlBgHx1QZrWPtE9C+ThhEJZAXnIELIN+9NYoNO1a4pJZaBV2o4ib
	 WnXIK1NxoiyNyx1uWQ8iDdSBM/HDjqayzYPYnnJNzjNHOrJSHihJ0lRhudz2E5os+n
	 w2LMf2nR2qw3w==
Message-ID: <sashiko-outbox-166437@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] pidfd: Use scoped cleanup for task access
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261010-pidfd-get-paths-v3-3-f245440b2b30@black-desk.cn>
References: <20261010-pidfd-get-paths-v3-0-f245440b2b30@black-desk.cn>
 <20261010-pidfd-get-paths-v3-3-f245440b2b30@black-desk.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 10:30:49 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Chen Linxuan <me@black-desk.cn>
>=20
> Split namespace acquisition from namespace fd creation and represent a
> privileged target task as a scoped class that owns both the task
> reference and exec_update_lock. Use the class for namespace lookups so
> ptrace access checks and task state reads remain tied to the same exec
> critical section, while open_namespace() stays outside the lock.
>=20
> Carry the pid namespace visibility check into the helper so that all
> users of the class enforce it.
>=20
> Assisted-by: LLM
> Signed-off-by: Chen Linxuan <me@black-desk.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010-pidfd-get-=
paths-v3-0-f245440b2b30@black-desk.cn?part=3D3

