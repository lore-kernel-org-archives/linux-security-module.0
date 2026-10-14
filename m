Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADCB2264DB
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 20:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011361; cv=none; b=NLfiE695EDArbIegcfIEPpgm2TcL/w3D2cdXVVLNuGbk0kJxobOIpdO9ozZlLrkak536Ijq2VSTI2DkE+kGYyDEgTu6ObXUaXqYzFuQ+h16U7bPbImZSwGo1BUQU2ecSxhj58VZc/HR/1Bj345HS0jzMBiqw0nbODZgn4s6//ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011361; c=relaxed/simple;
	bh=Z5BxiRhB3CR9pKPZB+P0VLQDb2WJRbQNPbrSy4zTuUo=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=WL0h+NzrPhQKxGBS7GAlvvpLKbxEt/CXRybAQiJs9fOtdSLgTQGJ2UGF8U5mMe2hDMLZivuif7FdMF983y8Q68cyt71a8XtwP2eqyEWrQ8GrpLP5mPNSiOl6p/2FP3ExbZkyEIdWNQhegIcQyBKytjwFIbcxAjtdxQAX4KG5wDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNFzROxm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNFzROxm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A9A1F000C4
	for <linux-security-module@vger.kernel.org>; Wed, 14 Oct 2026 20:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792011359;
	bh=S9oATA3mqrRXOhI22tRXiU5Lxo+QNx3kflgIyjbXTG0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=SNFzROxmpBjQ4NQVfyFnNz/fgvOfyqAcj28x3I8At1oHUpic+KeCSJpaaUsWT6ifd
	 joqQakgqgXzFy0HH/8qlU3+MHJ715VqsDmTmfJop+IfuWUK7BTb0yuyVkogFkvsAS/
	 b/f/p3GzRqCOWGqyyCO5epo/758VGQLxw1KDPgNTkJogE6KrMU8Q6qZ3r5rKx2Uxlp
	 Pnjb+kYVBz/nkhNog1ruNxGqAe9BVrCpNnlei+8oSo9YHeuNEKipOqESTahzO7SJZj
	 j87UQOV9YOqVCP+CydEEXyWF01QUDepYEx04du+7jVQOcrAt6D/wE8OSmcgNuPFGpx
	 3Z9lsXqR6Tqmw==
Message-ID: <sashiko-outbox-171913@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] capabilities: don't let ptrace borrow
 CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261014-b4-setfcap-userns-v2-5-fac4d19281d7@toxicpanda.com>
References: <20261014-b4-setfcap-userns-v2-0-fac4d19281d7@toxicpanda.com>
 <20261014-b4-setfcap-userns-v2-5-fac4d19281d7@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 20:55:59 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Tasks in a user namespace created by a task with CAP_SETFCAP may map uid
> 0 of the parent and write file capabilities that are honoured there.
> That is the one privilege they keep outside of their namespace.  setns()
> no longer lets anybody in who doesn't have it, but the ptrace checks
> don't know about it: for a target in another user namespace
> cap_ptrace_access_check() is satisfied with CAP_SYS_PTRACE over the
> target's namespace, which the owner rule hands to any task with the
> right euid.
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP
>   unshare(CLONE_NEWUSER)
>                                     ptrace(PTRACE_ATTACH, A)
>                                       uids match, euid =3D=3D ns->owner
>                                     make A write "0 0 1" to its uid_map,
>                                     or set file capabilities
> [ ... ]
> PTRACE_MODE_READ is unchanged.
>=20
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-b4-setfcap=
-userns-v2-0-fac4d19281d7@toxicpanda.com?part=3D5

