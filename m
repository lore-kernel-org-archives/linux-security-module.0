Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2283B14D6
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344879; cv=none; b=lqqOyl9N8fowfxeo+NlSIWjngZ/nqOpfMEHQjj5UWqlO60FhFcAL6WgWYYt0L97UYRtgCEV5r73ynu6qpNWSe+moCXxYF5jSYU5iY0mjzSwnLmlhVTjSIi88xDVgyVOBqVbNqEDJHxIpWz/E28QeJbVcsxs3zXW6O2L941Utq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344879; c=relaxed/simple;
	bh=Ysb1hm4luSO7ZAEr+CP3/4a+fYhS98VoAV5u8xfegbk=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oKBwgJhV+850FUxWD4SMOrewjihIxHtHQDYvULvdqaLxYbR0XZWzPPvrB349EimbjbpuNf2ycw4u74T1Xgp6mNSTM4viPwRNjrYP+XDqLAC5JFpOMDUI25Mzs1LM2jJsC8+5xMB7Vyrwkyk8I8JUqzUEp0PH8Eq/1lpNqLAd3UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/KJGNME; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/KJGNME"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3976F1F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792344878;
	bh=Ysb1hm4luSO7ZAEr+CP3/4a+fYhS98VoAV5u8xfegbk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=N/KJGNME0FFk8MzE/dlwqYQkBW7lIV61wyq/cE0NOsYWJqD6Tdno/WWs7Q7EmirTH
	 G83Avoyb7miGsWkOj3sf9ic1u8PqZn5GvquUhKDadKALgW8TepSuka+5euB109XL34
	 nORJEPjugGXEBPz+5WMPCGZZ8obuI+ses2OD5S0H3T1RTOqiC7dK226JQj2/q3PtVP
	 3gawVK3CH6hs+5/OIIMGhWQW3vjneAzRIJVyjcZfoxBsWeVthL3x8avy/csa3L6dfd
	 u5VT/A9lwDYTAyfHeqs426EYJeUkvj09x5PqYC7DZgqh+ZmqZtgpzmec4Ha0o2Ekug
	 +UcPmQx9mk02w==
Message-ID: <sashiko-outbox-176326@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/13] block: use cred_ids_allow_ioprio()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018-b4-cred-ids-v1-9-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
 <20261018-b4-cred-ids-v1-9-7bdf2db4ea9f@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:34:37 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Use the library in set_task_ioprio().
>=20
> No functional change.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018-b4-cred-id=
s-v1-0-7bdf2db4ea9f@toxicpanda.com?part=3D9

