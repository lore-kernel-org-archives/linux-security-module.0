Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2164B51B178;
	Fri, 18 Sep 2026 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757869; cv=none; b=vGiW79FLjTxgn7WWbw3QON3nYaLBtIaeC28sVKqfn4IJUCN8Z5cE2PUmNRB/dt6ElmVTFPu3AhCA1MHhU4us7oeon5yxVLVwtLaaTDklMqHQvNCp5KTA0aDkSh9Y42t36xMci6dOA6DtrhuLPoZ6aeAnNvkUpD2q1+jS8cxqJM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757869; c=relaxed/simple;
	bh=k9YRDBGbH3GNZS4Jgm0KoBGOSaX5IYXKokVVVvQLbsw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lUHI1iUNZNcBDEBYx5lZJJgINQgw4PvOAVh0qYbw8rIb0f2+/g4d3aoFdQO5NmaEuGdeFTrTlkCTDS/zDliLuYZvple6Zb7RL6ZwuyW9LeWSXqYRFbJpiX1WMcU7wHSURppdkwTii+u/NddrRb+O4GUiKrPrJYYBLogboXydVyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PojI/agp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PojI/agp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A290C1F000FF;
	Fri, 18 Sep 2026 18:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789757852;
	bh=30rYvN23fSbbY+namDlPuAuHSXK3/suz9un0bB0OTxQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PojI/agp1xXyyp10osngQEYxfcmTmXZPEvQ5kYV1llnDhjHVRGeGlVXwh4sUQLqpZ
	 5nxUtk2xZvjm0qMUR3PqmZLWy3QrSQRR/KzoOEa+54QdoBcJWxLfzDKUGJKiP0JwyW
	 PPPKq/hZczbGyXjZwkAB6LgNtEX1Xwush0U+0qEXnD7QFhP9vyNTekjUzH4gKDAJjz
	 xaV8uJcjQUxJY4ncbgyaQUpM13Qf5BxUCyaNoNHmET1fry9NBmIK1oScTD2qLnkzcm
	 BsDYjWvc8v/D6Q/nv9YuI4GVDFGia5S73BvTWu8gTgKfPjnnFSRjyrB88IpjN1ZCTb
	 9LbHuWf9q+4zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 7/9] selftests/landlock: Test filesystem denial
 blockers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20260918185036.608651-8-mic@digikod.net>
References: <20260918185036.608651-1-mic@digikod.net>
 <20260918185036.608651-8-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 18:57:32 +0000
Message-Id: <20260918185732.A290C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Filesystem denial traces identify the policy change needed to allow a
> request, so require exact blocker values rather than merely nonempty
> output. Pin a READ_DIR denial to exactly one event with
> blockers=3Dread_dir. Pin a REFER-only mount denial to EPERM and exactly
> one event with blockers=3Dchange_topology.
>=20
> The mount child retains CAP_SYS_ADMIN so Landlock is the only expected
> source of EPERM.  This prevents a later capability failure from masking
> a Landlock regression; the trace-collecting parent remains unsandboxed.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918185036.6086=
51-1-mic@digikod.net?part=3D7

