Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D338D479874;
	Mon, 21 Sep 2026 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987595; cv=none; b=nu45Q67+dN5yHL6fgY0GCHllkV3uQ32iENWc+S9cvK8JaNLNhwVy+fsU6TTIMgSjmA7A5hG5JBH5m4nigaavA9HaZu+ZyAXPsJll96D9oYio5XAnZ3vS+GvJTSR+w5jYlYb7fRYEwrc4/i76cThZcDw5FOUNdWh+NB3gHs8G+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987595; c=relaxed/simple;
	bh=EHSLxT3gqSYO7ys2Auh+FLkixzIN1MMoDo5oQ5N8Uis=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l/uzMEtue877CmTCyeV4wX3R20Jz9RoohV6GrhfGyM3L9GdlO5LcgpdEEnEggyddLJKLmyWPWmbF9S4owX04RjGFVn4xdQidw48C8j2zDNg3EyLygSskUIr7Kc+Wbi9Z0lqU+ulRLTvRHuQhJOVfISLSyAeTwBx2EOO3bVyY3mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrxtGHeS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrxtGHeS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECECB1F000FF;
	Mon, 21 Sep 2026 10:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789987594;
	bh=EHSLxT3gqSYO7ys2Auh+FLkixzIN1MMoDo5oQ5N8Uis=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QrxtGHeS/b32jCf9CArkIdwKKxb4h20vNOOsjuSWfnC6X+sUw7q6yWFUHfpoFTRsT
	 dtRdIr5ApTpQUkpKDih9rYeiY/inpzjWo47XWDX5/2TiUSjMZAetpi25yS/SFI5FzZ
	 9x5kEOmUNHMth+8UsVwYUW4PORVCosYHh6GVWSRdF/mrSj/SrGBG4V6H8Au68ufO+7
	 FvNtH6sfNpep59CAIrVp8ExPcMfCaa29AoFMW/Sz2aSSX3MqpM4hNyHoSnz/JnNkzQ
	 8XFWulk7m/zCLhi9tPVj0v1rrLCsKhVNBDWwN1+ycd0pigKlPw4gCJdbJicEBbfeVu
	 T0w92YaUk9jfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/15] security/landlock: convert thread iterator to
 for_each_thread_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20260921093334.105291-1-ye.liu@linux.dev>
References: <20260921092101.89285-1-ye.liu@linux.dev>
 <20260921093334.105291-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 10:46:33 +0000
Message-Id: <20260921104633.ECECB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> From: Ye Liu <liuye@kylinos.cn>
>=20
> Replace guard(rcu)() + for_each_thread() with for_each_thread_rculock(),
> which scopes the RCU read lock to the loop body via scoped_guard(rcu).
>=20
> No functional change.
>=20
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921092101.8928=
5-1-ye.liu@linux.dev?part=3D15

