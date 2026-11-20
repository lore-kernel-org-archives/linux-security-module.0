Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164978;
	b=W3xrCgL/p8vGw1EL6jhG2Fp7AuAl/rNfpOKfPqPnMe3PRDpdsO8pz8CDvONgwpX4xXNo
	 hzMI414inM16qV7EbhxBqP9UAXWaFaPBSZvnXmaej9fzleQQQ5+utYLwPXJjyNo8xNkXZ
	 CMbh8nJmwbeR1bhGxMglgPoAiKuP1fz1ZjPWuoVlqud+fsH+kOsfJoDqeOuxVt5dV8Dyt
	 SFRjgTqaY1gGIy2B7S9j01LloBrRso8axykXK3TEYozphbtReox23ywYUCWIPmBTulOts
	 mmNhqjZwiiuFKNEAs/k02fT1FrpYbWb1ETmsjb1BmwdRs7CZt7zJgsKunQ5JYKvyBOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164978;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K2rq5FS1SULlz/oFqG/0rUGPoW0BXxOjosTA2ogK+Xk=;
	b=TrWplSMAo3MLamtl/pldNNgMRdsFUjC3E98rSY+rp0LPG2NBUKhQ6MdK64gOb4heTAdr
	 S2Z8XMHuuV/Aq1lEy4TREmxrm1hDfuZLUWEE49yupCGoIu5KSzWsWz3YsftZyCjRwDyxj
	 Mx5voZVaCjoI7UVFDPPHlkXCii3NLbG6d6GMYMEK7HTw4CruxhO9utbOg6vX+jav1yNc4
	 u5RCwBGJAsCuHjKp6NTWFqWCqOLZiH0wTfBCzIUARMQOqLFe0v1Qxqulx/QXMdg5peu8I
	 h9xFKY7+b5bCVubxuAlC33HGc0umdpaRQjSlP44sQdz5ZTutjgeV+AItBecELaOJBSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IIIot/vw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168A5606A320
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIIot/vw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9291F000CF
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 08:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795164977;
	bh=K2rq5FS1SULlz/oFqG/0rUGPoW0BXxOjosTA2ogK+Xk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=IIIot/vw88wBX/Y24rQ1W9iQNRf6aXHIkLhLwWW9KStfWXNdB4cwbMiZl6eGTR/yy
	 HwhxqAPhTvrRo0/cNJ0zbVaM3qpGUsEsTVqS5IFstaJOrYK1h1tLf1OBxe6qjOSW4q
	 PiUCYuX9rn7YPIagLxp0gz1zKBXA3RErxAKHaJFHmCi4JyeMvbCvWSI7vB89ESNgEd
	 BJOord2ISdeRM4cqvC49oSURyS2qkegXzUTszmH/ADVkRoFG7xhES5OwDt5KXutVqG
	 fbvEdQsCEuvrehHrIC5VH/jZgExlZD2dz3qmqqIaX1c2KbHJ7d/cwt3pMf+5WJi8wU
	 tY4IbGMSabVjg==
Message-ID: <sashiko-outbox-224801@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] sched/psi: Check CAP_SYS_RESOURCE in the initial
 user namespace
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261120085135.40368-1-dennylin0707@gmail.com>
References: <20261120085135.40368-1-dennylin0707@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 08:56:17 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Commit d82caa273565 ("sched/psi: Allow unprivileged polling of N*2s
> period") moved the CAP_SYS_RESOURCE check for psi triggers from the
> open() of the /proc/pressure files to psi_trigger_create(), so that the
> credentials of the opener decide whether a trigger is privileged. In
> doing so it replaced capable(CAP_SYS_RESOURCE) with a direct test of the
> opener's effective capability set:
>=20
> 	privileged =3D cap_raised(file->f_cred->cap_effective, CAP_SYS_RESOURCE);
>=20
> Unlike capable(), cap_raised() does not check against the initial user
> namespace and does not go through the LSM capable hook. A task that
> creates a user namespace has a full effective set inside it, so an
> unprivileged user gets privileged triggers on /proc/pressure/* and on
> delegated cgroup pressure files: windows that are not a multiple of 2s,
> served by the SCHED_FIFO psimon kthread, which the N*2s rule was meant
> to keep from unprivileged users. LSM policies that deny CAP_SYS_RESOURCE
> are not consulted either.
>=20
> Use file_ns_capable(), which checks the opener's credentials against the
> given user namespace through security_capable(). This brings back the
> user namespace and LSM checks of the capable() call it replaced.
>=20
> Fixes: d82caa273565 ("sched/psi: Allow unprivileged polling of N*2s perio=
d")
> Reported-by: Sieun Yang <didtldms2525@jnu.ac.kr>
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120085135.4036=
8-1-dennylin0707@gmail.com?part=3D1

