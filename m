Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C551E456;
	Fri, 18 Sep 2026 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789757840; cv=none; b=cRc7oaO3/r4FWi2L6WvvVch3p0t4B0c7UC4IH+o/NvXGaqlXgoxmGEY5urn15mtlvJaXEhPwIw1havyQ7Hi7Y/avyJTKsGOeRQC0fPzgSnXRFDf4sHKB7sbbqdl6fiMzcFOVYRvbotsRuegoHcJmxXCOWgzvQFfDqk7YMwsQ4Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789757840; c=relaxed/simple;
	bh=ybECGG0Tgm3UQ2S+2izJP+WsNp8xONS3tKIwK5mvQQ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JuJcsTad456+heoOnJh16ic8j6J3HD2BfKbA4icQnfZ6jkDUE+HCRTRtDEt4DQCUXvOergSKMJppUFHZH2lgA4euCyDP9SHkNjitC5JHec+vewR483VhQ3ysjwwjXayF9LG9XigeTJ81JM3MBETrAMNCNUnWBXlXGcaQwYkgefo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzpwxhO7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzpwxhO7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF7B1F000FF;
	Fri, 18 Sep 2026 18:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789757827;
	bh=ybECGG0Tgm3UQ2S+2izJP+WsNp8xONS3tKIwK5mvQQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VzpwxhO771Tg9MibOrswbASKlUvJrLrPH163Kczv4Z5xmoqt0VQT4u3URH140+uZu
	 jK8RbmkWZHwPjfN5NPej4I7eVcbQwIfr+5hbfTa0wsiTcWnuCLllX4+cOKKQ88S/YR
	 dHtmWjy0nQqW5Gw5FaKSSecan+nOX3et7mPvDymtCeJmxRNqeULSsRbUmIUzZ4vFlh
	 4vdzcZC9/mCfh2oWBeWzJiXTaTPDxhPTPnM7Kmn51z1zi929ymMkLAb5GOYEo7a7Bj
	 vgOf2SXBVOUfTADewpCOraRfi9bWAKV46r3mVM2n8+kI8y+drZGRxSuwxbe+NzLy+e
	 KHPIoV31N3XKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/9] landlock: Fix filesystem denial blocker
 reporting
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20260918185036.608651-3-mic@digikod.net>
References: <20260918185036.608651-1-mic@digikod.net>
 <20260918185036.608651-3-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 18:57:06 +0000
Message-Id: <20260918185706.EBF7B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Filesystem topology denials are rendered with an empty blockers value
> because their blocker is identified by the request type instead of an
> access mask.
>=20
> Introduce the private struct landlock_blockers to carry the request type
> and final missing access mask to filesystem and network denial
> tracepoints. Copy both members into named trace-record fields, then use
> the type to print change_topology for topology denials while preserving
> symbolic access masks for ordinary denials.
>=20
> The request type lets typed BPF consumers distinguish topology denials
> from access denials. Keeping the native access mask in a pointer-reached
> field also lets CO-RE adjust existing programs' load width if
> access_mask_t grows.
>=20
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Fixes: 01ce260f5ccf ("landlock: Add landlock_deny_access_fs and landlock_=
deny_access_net")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918185036.6086=
51-1-mic@digikod.net?part=3D2

