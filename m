Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012E11AA1D5;
	Tue,  6 Oct 2026 00:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791246338; cv=none; b=GfwgS8Biwi8Qtd+81YxX1c/S0JO7UTUTr7DcWAu1R2jp/7B8M/VkhF+DQNDgPok67Lm6KJeSJjzm89eb9vB0/b4Pii847bNBKxYn6Dx7EPweMSCF0VRyoVYdPwV3i5ENV00L97+MT01+TznTWpIhTRKrJWjL+c6AwYU+dAkY4UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791246338; c=relaxed/simple;
	bh=bVvgMyZXhg6yQXXmCw946jom6ZtUeDTi1NN5YO+E9+U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V/gMro2cUa5w8ThGlsMRzz6SvTK36vxri52M6TDuIfIjVES46o3JZ3Npck+1ifEpliqcuDclgJusyM+62FMtU9dDSL+Bz6AALEIiWEnGO2j0iTA4talhNPBlMhMQ/UeRusMTMjLSmBUr2FrJhBsblmrUy6/uCCFt/DqoHwsJ9nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy7mOYGM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy7mOYGM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E3E1F000FF;
	Tue,  6 Oct 2026 00:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791246336;
	bh=bVvgMyZXhg6yQXXmCw946jom6ZtUeDTi1NN5YO+E9+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iy7mOYGMWHtNVnLjgUvskeEijsWQSkqfbIAsiYUr0fKxBSAFHKFRUYPr17n1/21Zq
	 wrbMnuaD0bjkfS/UcVgmEDOvqdRIB3xqoQvvoV2fnoXx7CPGfJiE4aRaxlM8HPRM+J
	 6lTXnWtnA6ZANBHDImFJOjv3d+3UnMpEYS9ADGjJ5bb6ZIPoaWiFnzCfvFxsgE6yB+
	 N8VtWejW2NjrwpMW06vLLbv9YGMzH+ZHch3VXWmh55kJ+QQxZYuEOeIgTd6DsG9Mq1
	 DfYAOeQyUk0PtM0O1Mw6rabSXjv58i2BqLTwNLgPoNeZzXNiOrF9CK3L8RJ4MvwU84
	 TZsPJZEsu+EZA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next 12/12] selftests/bpf: exercise the lockless
 path ancestor iterator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Justin Suess" <utilityemal77@gmail.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261006002020.2890858-13-utilityemal77@gmail.com>
References: <20261006002020.2890858-1-utilityemal77@gmail.com>
 <20261006002020.2890858-13-utilityemal77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 00:25:35 +0000
Message-Id: <20261006002536.60E3E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Walk the same ancestry four ways and require the position counts to
> agree: lockless from a non-sleepable program, where the RCU critical
> section is implicit; lockless under an explicit bpf_rcu_read_lock();
> referenced; and the hybrid that walks lockless to the second position,
> hands it over to a referenced iteration, and resumes there - the
> escalated position therefore being walked twice, once per mode.
>=20
> The sleepable work the escalation exists for (d_path, an xattr read
> through the position's dentry) runs on the resumed iteration's first
> position, after bpf_rcu_read_unlock(), which is the only place a
> sleepable kfunc can run at all.
>=20
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006002020.2890=
858-1-utilityemal77@gmail.com?part=3D12

