Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B793054C7
	for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 04:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789790699; cv=none; b=DAeupiq0n5vkYnhcLnBgYRcZjjvmbj1I5uFQkddtcq5by1v122eNQwGxAsI7kjcQrdbVmC13Uvm5jaC0+SivtvYHMSZz4vpuXmnVIP9k3aGOr941JpTsMj6Mie88CnB1KVYiHgDQbL8MKL6TmFphQudG0mniqgigNUSndPtjCe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789790699; c=relaxed/simple;
	bh=s2WoJXV15W/1Cl0in6m+eC+EHBFGjD4X3BnrcFs5iBk=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mQ2P4rCxxFu4lVoL5V6tTSIwRXmY8Lcz9tbvgIrv+MILZiezUcqFjbimdRY+qTQhvkeOsHZeTamr6p+Js/mNMvhy4TwFsWO40frea70LT1xnhSU2E3qguksVND5rmxO4ueZ+i2EJElPdudWSpeUj0EZyEzp0qRSpULwYMQlfpEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqUbaMYV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqUbaMYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3629D1F000FF
	for <linux-security-module@vger.kernel.org>; Sat, 19 Sep 2026 04:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789790698;
	bh=xhxyd8mZV4PR8mS3SPowDgV8OXOVqeBo74Oci9qAZmA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=gqUbaMYVtFElYKGWSsH0ol2mbaV0hYZ9hqFqpLV4xxCptJNuwJBA2yk2WRfNaGCEa
	 f2Xtzv9DbdQWeh8AfAenyDZPCfiASDGV7ivcOfIqGEbk7TBfrNjepoz3nOgl6GLo5M
	 0XcK15+fAGxisjHmcBoH9+8Fvo4xVjVeIVxWHvEFrw9rf1DkGOxsPZIqSxB78SePzP
	 /O88SB0GyoijyqwnYgmapb6cmNFScYZdY+36zUAkJ0f0ew9gFJ3UCblPEUq8t2S0M0
	 CwMesAcxxF2FwzE1/yYRYMk3mnK7Ok7xYxALRgHnxaNWhmzFHrM4jkeaVInH857hxk
	 A88sYQs5/wTVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] smack: reject relabel-self writes from io_uring workers
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260919035351.88453-1-ngocthang2710.1999@gmail.com>
References: <20260919035351.88453-1-ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 04:04:57 +0000
Message-Id: <20260919040458.3629D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> smk_write_relabel_self() calls commit_creds() on current. When the write
> is issued through io_uring it runs on an io-wq worker, and io_uring
> override_creds()es the submitter's creds when they differ from the
> worker's. commit_creds() then trips BUG_ON(task->cred !=3D task->real_cre=
d):
>=20
>   kernel BUG at kernel/cred.c:376!
>   commit_creds
>   smk_write_relabel_self
>   loop_rw_iter
>   io_write
>   io_wq_submit_work
>   io_worker_handle_work
>   io_wq_worker
>=20
> Even without the override, committing creds on a worker would relabel
> the worker rather than the submitting task. Refuse the write from
> PF_IO_WORKER context.
>=20
> Fixes: 38416e53936e ("Smack: limited capability for changing process labe=
l")
> Reported-by: syzbot+fa63184795283ac3f842@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dfa63184795283ac3f842
> Cc: stable@vger.kernel.org
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919035351.8845=
3-1-ngocthang2710.1999@gmail.com?part=3D1

