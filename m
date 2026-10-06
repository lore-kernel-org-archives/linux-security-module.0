Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77152798EA;
	Tue,  6 Oct 2026 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246680; cv=none; b=ul17N0Vhe7ADURPUn2DuwQVcukEsbeqCxx3Dfo1NIZC6MYg9fRk1/7AkP+cWw7Xcp98oXKND9HK7HVt+sy/uE+IOqmvF4kAz9HRhMWj7NYk0SRaWnw1qHRMsmhwCYXLP/kwxXJQ21cGos5uusexcUVJJBdrA7sjQ81VKYuOIUm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246680; c=relaxed/simple;
	bh=woA4UZ+cMEzodH6eSKkJdjdJJysA2Ow45xXvvs+g8+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bbtgirih6OZAc1nUS5/3Md296L4H5Ta7WtuSHvV8Z+RQHVM9qpgmwbRTkZeJ4VXhBh5v1Cs2Gn13+IuEG9MF5jpZVaPe0yhROLrMv+L39RDEjEGF8o97b0VzG+s6HthbKQ/IK8dsqrXGBgB9h8oUyGScsZgcdN4VcuRqJXLmwuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTr2J/Qs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTr2J/Qs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715B41F000FF;
	Tue,  6 Oct 2026 00:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791246679;
	bh=f8jkYVsthUlU/9GIFu2XBsHbBqdIMtjVPtFy36KdSfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NTr2J/QsiQNmnjOni3LTkDTahunQNKv2SINb+J2v2XZNjtA527auk+H8yMKKNOhK4
	 6QIeNFZlyZambdLL1ktt54uqqHKooFEZjvgsN9/WUlIPr6ktPmD6M4yXqptll6J3F+
	 XrnSYvVQFqX4LZ8KF/3plF0YDYDuyaloOYl+NIgynAbiDMuHVYvscHFIOnQesCXVtv
	 90bFS3rvD/gbiE51iKzW3i8st7fgbMRG1noUiySAD/2W/FWxO7WJGvoQVix8oRGZ6F
	 A5kNEx/X72xH2+vHyocGv48v0PBhlM1un6mwA1wo/UaOPo0azX4JSHc2hmgQvTm/xq
	 wT15VmPi0XEUA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 11/12] bpf: add a lockless path ancestor
 iterator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261006002020.2890858-12-utilityemal77@gmail.com>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
 <20261006002020.2890858-12-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 00:31:19 +0000
Message-Id: <20261006003119.715B41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Add a second variant of the ancestor iterator that drives the walk's
> rcu mode: bpf_iter_path_ancestors_rcu is KF_RCU_PROTECTED, so the whole
> iteration sits in one RCU read-side critical section - implicit in
> non-sleepable programs, bpf_rcu_read_lock() in sleepable ones - within
> which the verifier already rejects everything sleepable.  This is what
> makes a path-based policy expressible from the non-sleepable LSM hooks,
> and it drops the per-position reference traffic for the sleepable ones.
>=20
> Positions come borrowed rather than acquired here: a lockless iteration
> holds no reference to pass on, so bpf_iter_path_ancestors_rcu_next()
> hands out the walk's own position, valid until the next step.  That is
> what RCU protection buys and all it buys: the dentry cannot be freed
> under the iteration, but nothing read out of the position may be passed
> to a kfunc demanding a trusted argument.
>=20
> [ ... ]
> else is needed: the source argument's ordinary "__iter" classification
> already rejects a handover from an iterator whose RCU read-side
> critical section has ended.
>=20
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006002020.2890=
858-1-utilityemal77@gmail.com?part=3D11

