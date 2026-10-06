Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BEC54706D;
	Tue,  6 Oct 2026 00:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246503; cv=none; b=dtB0oeGsVSP37Z/BAX6yZydg8KDHT4RfWTKA9PzCT2S+8V0BVFhSc/eTniQtL2UdaevLyKeJFRNHWraPuizO52kYs1+8mr7NaaJN+WdX8CxuRSDvbuz5jOJ877S5Prth3wJCBDoCQOSodgNIeJsHPg1Gg7jwMSOERMejlvlz6j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246503; c=relaxed/simple;
	bh=sivKN4D6nhjyCs39em/PZWpLOtIwwzYtUjpIl+zt424=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D+DAR6Sh5eSfEpNFoic0RJl6sf1p8cOilYgVH7wDf3emvKgYbEyVIQIgHHDaS2aeAKfIA1oMlww7H6cKOoE5DoH4/R0uspswec6VI/zcVrhXsRpq/Lvy1oh4ZHKA0EmUdL1JZ6Kfe2MmRSuwyYnN/64ZWqmjiYw81rvfnqEV0LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBegqTAd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBegqTAd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0439D1F000FF;
	Tue,  6 Oct 2026 00:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791246501;
	bh=latk2GmA9EDs/TkVWzjSbj4lmqTeKLcWabWzBEYqo5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MBegqTAd2/72R+KAJZt5W8QENoD9wVjY+FbV1kYwjmqGZMNhNsKuAEVR2SFLGqWls
	 Y6lNRFDZ3pMsNXtxIvi7fN4vF10Xa49KpqyocCeV7BbgUoYdHKxmHoHHgSitOUwWVU
	 Q5i/zvW73V/8Ot8Y+vAU906bQX1J3OyEuNwa2lenSMxPC//11VrqZ/VsnKWnR5RbsF
	 tCDlG34NPKAfsKqrIsvsZBEiwBWNsB28uV/b2Vh93yPOJaKYN9CL3TGHkgnmG/1vjV
	 aQfqaf3XanqKCtZ3bYP55ykSCZDSUEifFqSetweL83gieDZXac/yUJueaal5uflVdH
	 haysZkEYpdK/A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 08/12] fs: add mnt_undo_legitimize()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261006002020.2890858-9-utilityemal77@gmail.com>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
 <20261006002020.2890858-9-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 00:28:20 +0000
Message-Id: <20261006002821.0439D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> A failed __legitimize_mnt() can oblige its caller to mntput() the
> mount, which may be the final put and so may sleep: legitimize_mnt()
> leaves the RCU read-side critical section it ran under to do it.  A
> caller that cannot leave its critical section - a BPF program driving
> a lockless walk, which only the verifier ends - needs that put to be
> callable from inside it.
>=20
> Add mnt_undo_legitimize(), which drops the count and, when the count
> turns out to be the mount's last, keeps it and hands the mount to
> delayed_mntput() for the sleepable final put.  delayed_mntput() then
> tells the two queue populations apart by MNT_DOOMED rather than by an
> unlocked mnt_get_count() read, which a concurrent failed
> __legitimize_mnt() could transiently inflate.  legitimize_mnt()
> switches to it as well, retiring its
> rcu_read_unlock/mntput/rcu_read_lock dance.
>=20
> Unlike mntput(), mnt_expiry_mark is left alone: a walker that failed
> to legitimize a mount never used it.
>=20
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006002020.2890=
858-1-utilityemal77@gmail.com?part=3D8

