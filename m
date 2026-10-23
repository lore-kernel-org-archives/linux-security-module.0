Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792774072;
	b=WPQm2qZTDA4Ljp3cwmY0BBbPrNOVHgHx5sTJb/15X1wYjTt/QRpIb3DXBuHGvUaPi1pV
	 2z4NqXe2RxVc5LByO5YhKOkZBi52myhCrWlIw/APgAYv7j7OE8l2NeyCNDwvmepXth54G
	 MjVr4pXTphEV3N/OWVJNLxPoC0YzIgrs0C9xg9brZUV6fG1MvayYGfmQcuAjeD33Yj8bg
	 +PFVyUm4tlDdU6cD8VYW3ckbrhd5Bpps6frMR8ootllczd61PJXeUbVCj9GcnmUBDyt3o
	 ID/lpfcsTadUP9+U095rRfyj56AK/Ybd0UveeDvHUq7GorKuas9KVszl/I2AVjSxznQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792774072;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qKbykKx/nC1kH1anTjOqfIioSPJ+1RrEEZ3gGanCWJ4=;
	b=SSXi+GuT5Uk7+JM8DmmfML2J4W6P+DinH8R7RmB2kKPpXBEgZa6ZrucZHipi3LBUczj9
	 uFnqispJM5lXf0Jt1Rn/DuA2jTGIIe66dcg2FM9n8yO0hTNfrgZA9SdKzlUDntDO1CSoA
	 C0Y0w3nzGV1bpGJVMB2qYS4QDm4BFvY6W73WuPEn/qJL/o4booY+pDoBVIKMbJevf8HbL
	 NEPqTb+neyLMxNOcV+QZkdvdzUk1TQ/aMDSTA5nj4ikJUoc0WyN08hgHDO9HTleDoTsy2
	 x3V0OfoWP0FF+K5qcls6HIh7Zvth1ErpQUWtsJHC1B0/wJna44WYcmeR3rmlRoZpF6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjL406Fv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DD1606A31B
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjL406Fv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFDE1F01828
	for <linux-security-module@vger.kernel.org>; Fri, 23 Oct 2026 16:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792774072;
	bh=qKbykKx/nC1kH1anTjOqfIioSPJ+1RrEEZ3gGanCWJ4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=SjL406FvwtOukvWJ/Y6zrJWVLWVo6ep4iSyQYrtU7LfNUszvrzYbExp2A3E2wdcBm
	 LSHGYzIxA3PRdprgZnyCMR1QhaLy+Dq7vJq8gMu2p9uqyCUMPlhd6FL+rD1qKQP8KD
	 IGCzctj9IaFb3xzf+qSZceyaZ+xUSTT0JFgdC0CG0Fz2ceDx2XxKaIG11dnabeHbLR
	 hmRqHYfUv1pug2pPmLyqWOR6ZBnh2V3Mo78Io7z2lKxKOm02NA55NuEkPHo2HhyrZU
	 G1p+aqPSWtYwekx+r6EIRAhx9TWXb90g7f5rJqDX0esYOmtliUevpw1gzJOjdyuWRU
	 OGm5UJK5jMvlw==
Message-ID: <sashiko-outbox-182970@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/5] capabilities: don't let ptrace borrow
 CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261023-b4-setfcap-userns-v5-5-0620223be951@toxicpanda.com>
References: <20261023-b4-setfcap-userns-v5-0-0620223be951@toxicpanda.com>
 <20261023-b4-setfcap-userns-v5-5-0620223be951@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:47:51 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

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
> tracer can't setns() into either.  PTRACE_MODE_READ is unchanged.
>=20
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-b4-setfcap=
-userns-v5-0-0620223be951@toxicpanda.com?part=3D5

