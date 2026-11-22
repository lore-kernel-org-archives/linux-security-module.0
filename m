Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795306262;
	b=e+QdWcCPmyAixKSj7JZVj+PineZfDWLYT4OfCYvxu0D1j9oms0+YAM6Tn2Xlibc8facx
	 rOsSi0figS6uMpwTuYtNKyJQ5LgOV2Y5W9RjRbN/2rzNGKfdCPLhRulG4M9a+W0ni2nhI
	 NSAM9WBErVCLKKb7qC14Ydyd2FUJSk+JlMslD63sTb2Ch/Bh3PiQhNlJ+f7pSnf4TgWIs
	 VA3Cbdrg+5eNqavgEDI2oaFDFBSbMIYLfyUqDGV2+QYWVL+vVz1n6hA8/Qln1GzFjRP+b
	 LgSoXwtEzft8h0jOe3UyR9QZWAkHNCYKsiCeTYwFFMMkQpiWMmBXpAyYBQcH46QXJcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795306262;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c6jSPovGVfErAI2cg1uJoM9igKPWiAN7zuJvwb+jGVI=;
	b=c7gfTHuWKK11YXgXuMj3ML10a+ASpDca+Q5OTsnK8JKmFtBVSj6Mpu9SVGOjruXh6285
	 Is6mIdCrWnQdE4nb0nf89fX7BkWVEeF3vG0i9WOa4O0JV7SwXS7/inchJ65pDpCebh21v
	 nyuh81jeoHLjMd+W0qtyb2ksvhYCtXeuGA9lOtV8Iya7excEmjr3pIfyOGCQ7wYrPJ/Fw
	 4/vHVzN/lAosFQ5tRtDdR7+ui+3V1BQhohpAswRPGiBPB2nF4ahcuIHB1/VsW0IGPV3kh
	 6s80958TeutGyNCHbLdzsKIcXYiwZ3cgBhspx9unCz6GG3JCl0HZG6rmaU1Ktw+m/QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHPDVsW7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1DF606A332
	for <linux-security-module@vger.kernel.org>; Sun, 22 Nov 2026 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHPDVsW7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBAD1F000C0
	for <linux-security-module@vger.kernel.org>; Sun, 22 Nov 2026 00:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795306261;
	bh=c6jSPovGVfErAI2cg1uJoM9igKPWiAN7zuJvwb+jGVI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=RHPDVsW7sOFe+auj86PjpKEEThv1I2c9EhI/S4pDcVyhg1GgmXcaWxUbXE3w9Vvl2
	 LMpSckg/p4cm/e0MwK0f+Tq8xDqe9TAZZwJPDB6qU57HaD13gpxUxVabIaF+1+KfF5
	 7z/xib3ImZoeSM2Hl+trxdQifTld0rGJLpK8V+HRyVdHGVMWOMXNNrpPpQR6eIf9FP
	 vVFoZ1O8jCvgw6OkbX2fz34nusZ+tFZyxZfbOp7T6ZLTZ3EDISiQ1KV0NMu1KEIgTE
	 Rwdf+TrWNlj0ILM42VViACdSgYjzlFTKANuaaqQXJmuXWnB7XyxKCxjK8C0Pb3u2ai
	 SqpSVVLkaVRhw==
Message-ID: <sashiko-outbox-227560@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v5 00/25] rootns: fd-bound process closures
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261121000844.1863324-1-jarkko@kernel.org>
References: <20261121000844.1863324-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 00:11:01 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 25-patch series:

- Patches 1, 4, 5, 8-15, 18-21, 23, and 24: no issues found.
- Patch 2 ("userns: Add userns_set_idmap() system call"): 3 potential
  issues (1 High, 2 Medium)
- Patch 3 ("arch: Wire up userns_set_idmap() system call"): 1 potential
  issue (1 High)
- Patch 6 ("mount: Support MOVE_MOUNT_T_MNTNS in move_mount()"): 1
  potential issue (1 High)
- Patch 7 ("mount: Support MOVE_MOUNT_CLONE with MOVE_MOUNT_T_MNTNS"): 1
  potential issue (1 Medium)
- Patch 16 ("fork: Support CLONE_INTO_ROOTNS in clone3()"): 1 potential
  issue (1 Medium)
- Patch 17 ("fs: Support FSCONFIG_SET_ROOTNS in fsconfig()"): 2
  potential issues (1 High, 1 Medium)
- Patch 22 ("arch: Wire up rootns() system call"): 2 potential issues (2
  High)
- Patch 25: skipped (not reviewed).

Detailed reviews have been sent as separate replies to patches 2, 3, 6,
7, 16, 17, and 22.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121000844.1863=
324-1-jarkko@kernel.org
