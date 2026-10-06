Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057FB1E9B3D
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301907; cv=none; b=XsqgnnqFZfjJGhsQ3vuLQHsl+8bKVgE6dIEXeooaGqAVbwTO3e0tFL3jxfqoebUu+WI9S92Cb24IyOuNV9ez8lqFuvz8s08U1fenGBFcYjdOGG7vhMt9Er6jwSzqswV32BYVDiCSa+bKLBSk+3WrBfMi91L2LtT53ICU/P0xIQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301907; c=relaxed/simple;
	bh=5ws57WiwJM0ICZS0QKxZIeP8x5A0om9HAcurebQLtJI=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LlWWXyuW3OraFZTiis/Iuxpwrm6lSozQjEoIeF6L02nMR5klvDICAS0G/PjJ2v9HwgBXfFw9K4aY4CdD5nLnbqhgxsygU4ryLZMq2+gXJWwtU2s9BgMLXPgs9YwOKznpmII5DAlzm22lltfGS4oXVebLqcnfLtP3PhtG/UkBLm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9Seevzw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9Seevzw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942601F0089B
	for <linux-security-module@vger.kernel.org>; Tue,  6 Oct 2026 15:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791301905;
	bh=IAmPkhzt0iRFQ17+dlBsJR1Fl/yrlSdjYQ53nWiwoc8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=e9SeevzwdAD/4Mb29ShJ7P4OgBWR7ptqp5SZLCJZ9mvBRFuCf5Gj+SOtLBOT50qru
	 p+0aLjZGDz35c5IEyOkx9RbXcqA5CDN4a2DYyD/5SS3NzGigB1tbCmWpd1ia+T+2BA
	 iVaKzv0m+V56aTU5ZgVsXTPpqFwN6oBog3BAerXvW02igezGImc10vOPzw9wIOK+bH
	 kPWO/SmjUhWSguR43D3ORe/Hk+7YIzwO4wvungF3HhtOccyG5wuI6lN7MTfh+kvwL7
	 e3ry/pq4Tk6y5qsmhOkOdPh5nt+qkV8gpKZSwbxT+vGcHqxrSzZ5BXiQgsD6fFsb6C
	 DfeucDS80xKag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] capabilities: don't let ptrace borrow CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261006-b4-setfcap-userns-v1-5-f47e7ed66072@toxicpanda.com>
References: <20261006-b4-setfcap-userns-v1-0-f47e7ed66072@toxicpanda.com>
 <20261006-b4-setfcap-userns-v1-5-f47e7ed66072@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 15:51:45 +0000
Message-Id: <20261006155145.942601F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> A task that entered a user namespace while it held CAP_SETFCAP outside may
> map uid 0 of the parent and write file capabilities that are honoured
> there.  That is the one privilege it keeps outside of its namespace, and
> the ptrace checks don't know about it: for a target in another user
> namespace cap_ptrace_access_check() is satisfied with CAP_SYS_PTRACE over
> the target's namespace, which the owner rule hands to any task with the
> right euid, and inside the namespace everybody has a full set.
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>   unshare(CLONE_NEWUSER)
>                                     ptrace(PTRACE_ATTACH, A)
>                                       uids match, euid =3D=3D ns->owner
>                                     make A write "0 0 1" to its uid_map,
>                                     or set file capabilities
>                                       A is entitled -> allowed
> [ ... ]
> tracer's.  PTRACE_MODE_READ is unchanged.
>=20
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-b4-setfcap=
-userns-v1-0-f47e7ed66072@toxicpanda.com?part=3D5

