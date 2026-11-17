Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794946387;
	b=z3sPO2UYMWp2jelr6t6/4E7jbOC+RQarAUeMKIesFXxY/2kGPuNmk3XNTFy6cko4Mfh5
	 gxgxaRCRycHjvdDEXVzPqJjx/nBaqu6SFXLy8Z0cJiM529/eD6e7RsPI0kDMolTtLxKBD
	 l7MryyNFVYZMFOhBtgNWtIJ0WkaeT9/C6ptn/JWuqgPw+ID6Cxia3gzGLhLHIuVine3GF
	 HbNd11a+RGr551318Zx7dGLcoqTqZe0WiwGgcvEXFhO9vm6+mXLzxF1BS1fl7qYys485I
	 nX4XCYFrhjRSjdYRJcSt0TtnUi8Oqo8UAyYsGn9FVCwnBuEjfYLJALMxvDXsgvPhqng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794946387;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3zy69YfXxNZbYneZq3uOSoSBp90VScg6lpheFQ6zW/o=;
	b=L7AKJrEmJYZGnmWe4WBk+s2uuYwbv0dMv0OUlv4sOAf86hTw9QzV1/oUHl9nra16nI+m
	 UaTla/xYOoX+S+Kr6k0LLCx6BHPSg9rp88P7KyuMnhb5gjeK2VTz22F/XsW/PJzNWaTK6
	 K7nCea6n9pd/XCwYmJ4rOJxT4cI0wJzFSuSNrNdKMEZI0PNVFIL2HXD8BI1OXNpCwpURJ
	 kz4lh7+MPxmDTrLKJuXCfZVn2M/1qSvMll8sntdq+5ZDmuBPZdgchPcQa1SDWai3/4bp0
	 YROeaqjkFz8HZuJxuH2IcAAJ7cEZ/XnY7PzYIbU4LQnIX90McX+pn+ILYjgat0bZZyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VeCfAgyD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AEC606A331
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VeCfAgyD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17241F000C7
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 20:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794946386;
	bh=3zy69YfXxNZbYneZq3uOSoSBp90VScg6lpheFQ6zW/o=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=VeCfAgyDzLoBgY9wXZO3yah+woutpvVvpasHdy6Pp6JQG9/h20/chSFH4I2hVLXVt
	 mP1/NDD2rUML1QfNXs/W5p5ZkMeuWlhLtE1N8AA2YFMN9rKS5QQ8/HMdREjEZ1PBdU
	 QA4Wc8csTftfT0q+Kg2rHktg4VBk0yrUffpdeZBVgu0gGFavREcb4VEKOHKMa0VEFg
	 PuucTdUN2EmdhHNMTTF9iirfvFy81AsjMVRFV9nia7Gvsq0AzsqwORQtxhstNdAPuS
	 nXNiXtObJckdxDovlY+ionNtIYAve1vm54CMP1Gk19Wgk9F5mFvnarZwDkxagqOHRK
	 cDqRkkit2e3EQ==
Message-ID: <sashiko-outbox-219577@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/3] capabilities: don't let ptrace borrow
 CAP_SETFCAP
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261117-b4-setfcap-userns-v11-2-2be11a2c32f4@toxicpanda.com>
References: <20261117-b4-setfcap-userns-v11-0-2be11a2c32f4@toxicpanda.com>
 <20261117-b4-setfcap-userns-v11-2-2be11a2c32f4@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 20:13:06 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> A uid 0 task that gave up CAP_SETFCAP and CAP_SYS_PTRACE can still
> attach to a task in a user namespace that another root task created,
> and have it write file capabilities for its root user.  For a target in
> a child namespace cap_ptrace_access_check() asks for CAP_SYS_PTRACE over
> that namespace, and cap_capable() grants every capability there to a
> task whose euid owns it, whatever it gave up:
>=20
>   task A: uid 0, full caps          task B: uid 0, no CAP_SETFCAP,
>   unshare(CLONE_NEWUSER)              no CAP_SYS_PTRACE
>                                     ptrace(PTRACE_ATTACH, A)
>                                       euid =3D=3D ns->owner -> allowed
>                                     make A write "0 0 1" to its uid_map,
>                                     or set file capabilities
>=20
> The same goes for /proc/<pid>/mem, process_vm_writev() and
> [ ... ]
>=20
> Suggested-by: Serge Hallyn <serge@hallyn.com>
> Link: https://lore.kernel.org/all/fd159e68-c613-4c7d-bfba-8af0a3f3a96e@ha=
llyn.com/
> Fixes: db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-b4-setfcap=
-userns-v11-0-2be11a2c32f4@toxicpanda.com?part=3D2

