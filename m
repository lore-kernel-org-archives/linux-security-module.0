Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826851;
	b=czyxcA2HslPw1EI1qz18DkeBpjLhkbL5qCJMYgCamIETHD/PCY//ENmZMvWzOoV+Sc3b
	 e9AHfGMlYZkAPyOPnW5TUSUs0dhS8AOsNq3CIxfUTP5LgF0jULIcVuNl28k1aPTTDd2Ln
	 YImxd5NEHzgQp77PUmnAkckJEye+kM+s0wyU+wfeMs8ml4tx3/zyYVhfTEZNXw5jK7poP
	 dFUjRnYQH2mdi7EdHsnRT6nqNcV1PyCI9jkVQL2LGhPQMRcg0wzsGi8rlts0tfo3nDZYd
	 9MQtg7eh7bFs0YXzx+RGSu+Mc7oPBMX3zpBeduC3TXFLPkPj7PFyG4EoFG2rwWHVoHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826851;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nsDydOMMp/m+DM3OcWux1ye07mZZpSzUwy2ORsTZ0ao=;
	b=eGPBrXcnEkkp4T9ahHhz3JVOfOaOFkuGaWWJ853U6PFABTqfx+WCmqF6Qt6a8mIG56SP
	 K7kOBV009hwXdXtaiMcx3VARmLijxMWnUzA8vBSbYmQFwMS5y6qQQMUkPrzIvy1xEfUmV
	 TMwLTb1/VUjh7mZ/+Ui8p17hXt/ebTk+s8nGcTv1GiXLveBSfIamDOOyjm1gRZsg4hw8J
	 0rw+C1020Xkp5w0Lfv9oY0wF1fGdx9ysp016BEyybAXz0yuapAcs7GaUhfbHZn3RGytze
	 eGgBlI0mEdTNzpI6jWC7C5ByJdlsztK4sWucrhiVc5F4Xuhz796BZ6M3OW+dW8IyFOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C6jF6tNo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E576070425
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C6jF6tNo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229731F00A02
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 21:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826851;
	bh=nsDydOMMp/m+DM3OcWux1ye07mZZpSzUwy2ORsTZ0ao=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=C6jF6tNoPNQgXwfmzRUPMp+sWVki2+/3i9pYdkx0dCR+N0vs22ucGrN4Nc9NCfs/g
	 3Sx2NH+rz8Zvz1wnfMW6ugv0cPm9HGLSsVKR07U/HwbpwwPdyJk6n8ODLFd7j3M7sh
	 NtCM6U1htxm3AQJdbrggU+hH21BGJk7gG7EH0iYWIP4tT/l91pmgcIM1UzMLnaj9bB
	 vOF51DUwRBIOiBkiw/5zXmWb/jLSwkPFs1UYhDoKpVULkHUCi3iWgP2gSKvA2X+ARD
	 91ctmZblmGQIyPs6VNHZQ8woL+RRNuBm90TeT2pkRV85YDKGE0Hy19IKBinTC6yFA9
	 gZnRAPDP+8Vcg==
Message-ID: <sashiko-outbox-198063@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/27] selftests/landlock: Fix the openat() success
 check in fs_bench
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-selftests-refactor-v2-5-c52f23f7ce33@gmail.com>
References: <20261104-selftests-refactor-v2-0-c52f23f7ce33@gmail.com>
 <20261104-selftests-refactor-v2-5-c52f23f7ce33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 21:14:10 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> fs_bench expects openat() to be denied when Landlock is enabled, but
> only treats a returned FD of 0 as success.  Any other valid FD falls
> through to the errno check, which then reports a stale errno value.
>=20
> Check for any non-negative FD instead.
>=20
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-selftests-=
refactor-v2-0-c52f23f7ce33@gmail.com?part=3D5

