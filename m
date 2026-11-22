Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795312010;
	b=sUDt+s+my1Xh9IKIjmnknLuUfOfzC2ecLkZEuXbo71nTruA8ifo0w9mLbR8jA9VeMtSS
	 Uf2mApNwMI9zjd+LP2HGJY7lso6sHHh1wHUS47gxhzviSd7tOZv5OaD/TTg7HQZ4ys2UJ
	 RlnWzbWAYgsKuQVqHRXzA07EICiTzhd46loNN4AInYel1DqdA8jyQzSDWdEtuaX94LX2X
	 iWI8lbQYiFZk4HsqC2By87+cO6+6gGZ0EEGsEy2cKzJvBRdu6FMXqoUyG+vG8EJuUPdQ2
	 7Ok2F2X+kiXsBcZQ/23IeE0aX7RFrFUZWoZKivR72avUtV45VXyBLTff5OgNeoZ5B4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795312010;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ji/bs1kdDxchGMHhprTF1UOjc0/rjjR8XPs6H6WOhns=;
	b=fJ3hutryol51fBBwK46c1t+BqJXOt5xcWE2ZhVWcmfyULvMygWkUmcjdFbSlBWdsg+I1
	 6UP8o1mn5eMeF4j/ihM82afUho5INv9gLWeFHEAILwyp05m/SQ9bGN3ItjxX7Nw482ZTp
	 lWU06FBj7Dza8oZu8XBpN34iDQpgUHHc7SR8KkKMTizOPn4yJUNJDdsRVBFfLrUFzLW7r
	 XH6bKTrAervh3XV6sJACOv9jgiNJ/RMo7gEucwVLjcSMshwzO0We//PReIOyxrtYHMYRj
	 uWM2AlnBbiKVUCLRPzsTy1B09k17NvwSddNQvf84FkOcsTrxesD1aFyPm3NqRTeivxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZlSMHm6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C68E606A320
	for <linux-security-module@vger.kernel.org>; Sun, 22 Nov 2026 01:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VZlSMHm6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A531F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 22 Nov 2026 01:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795312010;
	bh=ji/bs1kdDxchGMHhprTF1UOjc0/rjjR8XPs6H6WOhns=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=VZlSMHm6WcJmnA9twWM2SGkbfUX5q0CKFBETM+CUm8t1Ek3dvaXRm3Fhy9EhPPA9c
	 bjV/ww+zNXbslvyx3JvaQR8DL+34JQO4vgjDsZAoLC3UxKmPD7J/lQOoydq00WbcXG
	 CVwtMSM/ayzJi3RmSe/t0JAUNjg95B0GH7ZPbqRCXUtciEUWwYxsma29dvO6qmjE/1
	 qujebT2RhCRGvxgFxBkN+rBSHUDa1YXHRxclSozlPUwHhxT2d/wmkuOeen97zb8o8f
	 FMCdYLRMR10aSIHqeAteG6ouSid21QBtCZJypVIvLs12jhM5F7fLy3Ty+4SqyZ2VJz
	 FdUe4wO+jVU2g==
Message-ID: <sashiko-outbox-227633@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v6 00/26] userland: Userland containers
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261122011809.2667684-1-jarkko@kernel.org>
References: <20261122011809.2667684-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 01:46:49 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 26-patch series:

- Patches 1-16 and 19-24: no issues found.
- Patch 17 ("fork: Support CLONE_INTO_USERLAND in clone3()"): 2
  potential issues (1 High, 1 Medium)
- Patch 18 ("fs: Support FSCONFIG_SET_USERLAND in fsconfig()"): 1
  potential issue (1 High)
- Patch 25 ("selftests/userland: Add userland test suite"): 3 potential
  issues (2 Medium, 1 Low)
- Patch 26: skipped (not reviewed).

Detailed reviews have been sent as separate replies to patches 17, 18,
and 25.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122011809.2667=
684-1-jarkko@kernel.org
