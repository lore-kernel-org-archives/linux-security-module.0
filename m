Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794881941;
	b=a4ZZxHBrLwBkLaJaIlV3brLteTaFO43i8Co5gU+CL8ZNxP6huhCahNCGAjQMDDC5zxfO
	 2iYDecEmU7eEcbTATwwaDRxcWwTY+oibVkPUKmnGQUzWi5K++XSpzyKljBhuajOay4OKE
	 gyspIS1pNhZUdZEMNiW1it0tAiAuXjFB4x7Owo46ylOsOX0FWjMldL3jpoesBjkvuI8TZ
	 UuaRgPxB+STqSCy+ovofQM1U8wpJBwgR3MmZekt/sOQRuaJ72J31M5Tzh0gaBENfJo6zh
	 XlNnWIdjPIJxt02mI8C5B+xgAmycX/BnreVjTJTr+wbUskGQaZwGhsNHCbgC4J3DNUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794881941;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0a3DNGwgTykWoU3WNPqT8LCHxp3Blv1eML71Q2XflSQ=;
	b=e61oMhWOGEO7rpi9N68DRyABtPW6RUqoGEdXweAM4WFoDV4vB4+6CzyzFyCdh2I4dPxG
	 Cyq+QC4Ng6Oq5VWJXXqMzL/3HEQk8uMx4zKp/rhpWgP4Tq1kOzULhALjDcCZxk+gJef+T
	 Prtt+hnDWjMfukf6L7WW1SttZEt445fHhOWNR2gcOH/0TgSLDKqQZid64I5PbeYZnI3BK
	 JhrK+fUWV8/ddPm4oAypvlLfZCfPQZQV9rBVrMUq7m6qP69iw19haVg4EyvLaQ87gqzHM
	 leL7+vrb7dv/Ye4V3zLNLCNcZZkXdJ/vYKuTl5PDyrp7ZaM4TEdLDDoAUXeoSwDSJcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nlWJHuPi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B007606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nlWJHuPi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C648D1F000C5
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 02:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794881940;
	bh=0a3DNGwgTykWoU3WNPqT8LCHxp3Blv1eML71Q2XflSQ=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=nlWJHuPiLZHxrJkqlMVW+492ySZepmAgmHmdNyULlFYhQTuZe4EUeEyEVm/iY+ZLz
	 rFV9VDHgb7o9FRWZ8qHg00ugTHEk5hx0nOd/YAieVKI1cZtNH6nsoPW9+n1oG3oUBv
	 QokUg0Rx2+xY4cnUhMOnieljb9OAzhLoI5YijQ5hr5Y8VuiYFy0V4bXX125Rh77KIM
	 gmy3P9kuHO6jHD2ALNANLxttiTRJQbZ2U9ydUWuGSh4G93y7GpXyF2Kp4upnteM8YK
	 my+hVQgfrTN1T+0twT/sQssaz53h/xOubxkrXhjSvZlYZIz2OhN6VbIPG/jbuznz/L
	 I6gzCHZtY6ODg==
Message-ID: <sashiko-outbox-218076@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 net-next 1/4] selftests: landlock: Replace MSG_OOB
 with O_ASYNC+F_SETSIG.
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261116021845.2533130-2-kuniyu@google.com>
References: <20261116021845.2533130-1-kuniyu@google.com>
 <20261116021845.2533130-2-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 02:19:00 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> AF_UNIX will drop MSG_OOB support.
>=20
> scoped_signal_test.c uses MSG_OOB in fown.sigurg_socket and
> trace_fown.deny_scope_fown to trigger SIGURG and exercise
> security_file_send_sigiotask().
>=20
> The same hook can be exercised via send_sigio() with a plain send()
> by setting O_ASYNC and F_SETSIG with SIGURG on recv_socket.
>=20
> Let's replace MSG_OOB with O_ASYNC and F_SETSIG so that the tests
> do not depend on CONFIG_AF_UNIX_OOB.
>=20
> Note that with O_ASYNC set on recv_socket, closing client_socket
> while recv_socket is still open also triggers SIGURG for POLL_HUP
> in unix_release_sock(), which would emit an extra
> landlock_deny_scope_signal trace event in
> trace_fown.deny_scope_fown.  Thus, the child waits for the parent
> to close recv_socket via pipe_parent before closing client_socket.
>=20
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116021845.2533=
130-1-kuniyu@google.com?part=3D1

