Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD14A146D5A
	for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2026 02:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789959328; cv=none; b=k84bO2+ocTrgeGC9jDRSLrCbdKSuhhCVQ6BEwrpKKE+1wZsju5qTLjgRQOIpIv9UnVR2EyPrkj4lpQ7ok1aU10CbHFlWfFuZk/GNUASRT+AoBpcxyU3M8Sl7pN24dL37Cal4alch5d4TWW3GCbLyXuzDlmi+u6rzEbbAMt3YNHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789959328; c=relaxed/simple;
	bh=a7kFotOfRFQISZ+kh34EntivhSlZSah68v8LKaAsM10=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VSVpuU/4hJQdpmuFWSaOQyuUc6qKmfI2+wmUgkphH8lHKCVtsSAugDMsgYk5qp+e2LgijpxmDlVYFGPY3x/77Rt/Az5YaHCdztkjYqugd+KFf9N93hxpQr8uxwPSXBW4rYsoVCl8k4HblCKZ7J6CkcnIFx2n7h54yAiKwO0e3Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjBb0keT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjBb0keT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B05F1F00893
	for <linux-security-module@vger.kernel.org>; Mon, 21 Sep 2026 02:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789959327;
	bh=tu540Vjo5/nhSklLNDatZj8iilhFnCdellsb+UDya2o=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=kjBb0keT/XwFv20a6w2/njtmphjP53+QFLUWuwlac62584Zmr5tc5xttbXT320VRs
	 2s5k5wunwAKvMAi4g51LgkQFkxQED9DRY6E6tSNwP7qGhRY2MfGStyEvp+jRqTj2HI
	 scyvso6f8oQGJxWS0UMuVRvhRXwJRch/2W3/Ikni1vNk4MyzsicpYxzg71OdQbceV/
	 jQNACAoMOPuCmBsIZdPZsY/QxOwjYh1DxeznWwGTBDWCfB9wrGbwia5BnHXIyWNtXE
	 5qOYdkSueVqB93naOado1cICaYxEWmb+D3iwZj8XCFXnyqdJaAA8RNH6ZIm6KiKj8Y
	 5JcVoVI2gU8gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] security: commoncap: clarify CAP_FS_SET comment in
 cap_task_fix_setuid()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20260921025209.1023530-1-adrianox@gmail.com>
References: <20260921025209.1023530-1-adrianox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 02:55:26 +0000
Message-Id: <20260921025527.5B05F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> CAP_FS_SET is exactly the set of capabilities that an fsuid of 0
> historically granted (see CAP_FS_MASK in include/linux/capability.h),
> so cap_task_fix_setuid() drops that set from the effective set when
> fsuid leaves 0.  Replace the stale FIXME with this explanation.
>=20
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921025209.1023=
530-1-adrianox@gmail.com?part=3D1

