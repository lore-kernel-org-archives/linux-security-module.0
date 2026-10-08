Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785714ACC69
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469931; cv=none; b=VjxX5dCF2BpeNLtVTav6fFTCQZ6REXHswqIAFD16HyyOuAIBYtKNRUwfjKwucgn9ggM6TFDicoY5dEJdg7ckZMNgUxvF6efYr07XkQuhyD5GpLJr2jN5vCYRPEOIDzbz49FmTlL8SebqFaOWhHIfSYGhuodO7LId2/PvS0aiUDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469931; c=relaxed/simple;
	bh=st4OySDSf/iOzZeB4e7Lrxgl/9YQ+d8JiWrR55zNRX4=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fFtMxu8S/hYmWAAInV8J7JZeKaRFcqAPVF2T/8jNt6kbKP/+IT61E9Rb5ZHBCltS8nn7xTxVDbrqfeyXIrW6PuabN3bXMASVRPu3UdLp7DpHdVSMoEZpHVvnfiobqWDyUpNwiMMT0IUIy7QKmu7md0sXwoO1OTRO05mP4az+VHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzzO1FRN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzzO1FRN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4291F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791469930;
	bh=st4OySDSf/iOzZeB4e7Lrxgl/9YQ+d8JiWrR55zNRX4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=KzzO1FRNPxgQQC4fdc8ADzlYwwOp3EbysBhvYWu1IE0/515FEOq8sL9yfwZyk36Gv
	 1m7j/TfZ4fB8yplnltFV/Omp+lFLbdFvc/orpYTToXO+0fDB8qCTrCBm2I1RCMK1I4
	 2UVbuPcpnOqj0k3SO+bVf0DCJ+hfFV/M0qCcy97kPrk4/3UBY+EboVLkC7ui0kUjdb
	 +rlhlAIIYAlvoR4xNMhQwfBjTHpx7tiic5AUBXesKJk6vb+zhFc3IcU9D7X4oIGP6g
	 8nP7KrlXEJAiCET/gh7Pl4rKwvIbvJzezy2lbKLkMNI8DSNI7LmZbD8h7qFLR9DUyn
	 fmMmqhyIgfZIQ==
Message-ID: <sashiko-outbox-164287@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/27] selftests/landlock: Check errno for combined
 VERSION and ERRATA flags
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-18-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-18-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:32:09 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The errata test checks that combining LANDLOCK_CREATE_RULESET_VERSION
> and LANDLOCK_CREATE_RULESET_ERRATA fails, but not the resulting errno,
> unlike the other checks in this test.
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D16

