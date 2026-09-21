Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF573A8388;
	Mon, 21 Sep 2026 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986220; cv=none; b=m0OCHmBElr4cy1fiXglaW2QjCqBsjE30yB9W5fNDhF34hnajrGziPCsnpuXYks0RMjUdrFSeuriVow5zZdL4COKuHycexSwa2V/USPuc7GLN29wgk5upFgBc6MjlUbsht8qv0jT6UevwQBERkX4mlwPHe46vPgZ0AzDzeJPpBlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986220; c=relaxed/simple;
	bh=XyPlFzfXDz148GYOl8E0QXUH7Yo9tOUPOSI7M2XIXmo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=arg5mPfsiT4KKlczpbPe/baGSQhiJzbNVXaCXBN6m1iMRrOA7KVYHD3CWXowWvD+vVl1CenmH/oBpAWrdJq8TmyicuJaqnfntTPONj2GZfJDf9OacPW6VOJOv6Q+xaNgy+MpSMfeDfEYlgzW3gmpgfP59ElZXGIYl90hiRIr97M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MP3K2s7N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP3K2s7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815921F000FF;
	Mon, 21 Sep 2026 10:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789986217;
	bh=XyPlFzfXDz148GYOl8E0QXUH7Yo9tOUPOSI7M2XIXmo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MP3K2s7N78Jx/8LzRAB4bxlG9q3UfSKnp+Fgd2iVj6bycLxKclU0PP/2Oii5RrSon
	 SIPii0FeoSg8DdNA/ZyaEsIOQ4lTXuhD9iAKzr1N3UszLxI7p3z6RLbnTeGMyQupR4
	 3FyWXnJ0cMDPv+weQSS1gngYO64Rv6oWHf62iFHdJosIV6A94obBih/or/Mj7zifQn
	 XRYRSmpfG4WmybUZgC6TdesrX0SDzL7b75uNXXUMFwYgpbfZknQD3mEcLcvsPMuE/w
	 vPBJ3VJinPm9Q+hWyDf4a61GMPPUAbGKGDSyBBfDQl7bNW1fD16lgYE19HMkQs3FX0
	 Sa/4cKwZRC0KA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/15] sched: convert process/thread iterators to
 for_each_*_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260921092101.89285-11-ye.liu@linux.dev>
References: <20260921092101.89285-1-ye.liu@linux.dev>
 <20260921092101.89285-11-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 10:23:37 +0000
Message-Id: <20260921102337.815921F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Ye Liu <liuye@kylinos.cn>
>=20
> Replace the manual rcu_read_lock()/rcu_read_unlock() and guard(rcu)
> pairs combined with for_each_process_thread() loops in kernel/sched/
> with for_each_process_thread_rculock(), which scopes the RCU read
> lock to the loop body via scoped_guard(rcu).
>=20
> No functional change.
>=20
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921092101.8928=
5-1-ye.liu@linux.dev?part=3D10

