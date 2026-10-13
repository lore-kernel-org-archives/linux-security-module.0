Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEAA38DC53
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883697; cv=none; b=F0zwq5yO0qXUz41ZfYq7gqaOQJMzdQc9Z0Af2Yq1gbu3ypux2JyX/+uyaNBQVaCBG/JOYk4TWuNkzrTrj2I/IRrmKe4DUSAWr8foW6bdmC8Ss6kO2tasmQ/ESKNZtZijkT6w5FZ3KpUoxmzCzIFyCRY9b1DrJP56AOMn7zmPtCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883697; c=relaxed/simple;
	bh=Q3h2ExnA8H5NFopZKoNQlxreL8fZUIACnVCYBhXgLS8=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CzZhqBYGGgxI8Ah4/SH/7kp0VZZzFSlyuMFIJfLx5MlH1w+SfV8prJYwDUAGfA0iYDoXnmI391OcTPYesdsX/kBqswvPQ8TrTzqaY+in7CluJjEd0myDF2E2oM7aJeVmxyDaqKVff7kO8SrgxmMe4HKDa7GkF/4dqBk0na/5F8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDIx015i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDIx015i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8C61F00893
	for <linux-security-module@vger.kernel.org>; Tue, 13 Oct 2026 09:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791883695;
	bh=xCVXu/bdanZnvQES5YHMyIp5wgF9mkc28qMbQCEbmsU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=EDIx015iH7K1yEgl19Tr0gxrUhePRY6E+58HMu9GCXfkmPY02Zf59x+0l/7FQhdG5
	 z+9mRZZh/4B6NlGVPGEvcR5oSObM7os7/Xi72E5u8q4EYrz9Au2qqRtCV908i2wI/U
	 z8ioy34daRYCZo4r5gcTRFObfq0sBRTQdd+kbsr8g9M8Wi+F6G7sZ42ieuHzuxjUQ2
	 maDiWkDD9oG8zxjCwOjc7oRDOXU2asYnNz9PzTnLfepLloNAwnMkfULEYSBHejNcHR
	 nHjKX/frS3rcjtxuIMsAfHBWBfuPVhNacO/yLTPcK3xgd1fBgutiAqu4c4FVXfoowI
	 wi8hboMYcspSQ==
Message-ID: <sashiko-outbox-169335@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] keys: Protect quota-owner reads in namespace
 filters
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261013090358.1178367-1-nicoyip.dev@gmail.com>
References: <20261013084056.1070923-1-nicoyip.dev@gmail.com>
 <20261013090358.1178367-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 09:28:15 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> keyctl_chown_key() replaces key->user under key->sem and drops the
> reference to the previous owner after releasing the semaphore. Readers
> which do not hold that semaphore can still be using the previous owner
> when key_user_put() frees it.
>=20
> For example, namespace filtering in /proc/keys can race with chown:
>=20
>   /proc/keys reader                 keyctl_chown_key()
>   user =3D key->user
>                                     key->user =3D newowner
>                                     key_user_put(old)
>                                       kfree(old)
>   read user->uid
>=20
> An earlier instrumented run reported:
> [ ... ]
> Fixes: 454804ab0302 ("keys: make procfiles per-user-namespace")
> Fixes: 2ea190d0a006 ("keys: skip keys from another user namespace")
> Cc: stable@vger.kernel.org
> Assisted-by: GPT-6-Astra
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013084056.1070=
923-1-nicoyip.dev@gmail.com?part=3D1

