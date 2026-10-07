Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E483F4107
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 10:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791367909; cv=none; b=lL0E2J2Ikckipa7Ycf5BEzPFcxD1fWPcwOQm+hz0+ReUFogS6IxvvqAU43Iuyw30KWyZem7Zssg8acLLeqCOT/slZTE4MPmi7FbQ43/rPb3Ksr6pmt0ZyCMP07NfffWRigFNuHSqhovIFXu6y5toLRZnw53IEVQi+psP/hQ/hn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791367909; c=relaxed/simple;
	bh=mcNSKE6gXd2ZjH35W26Hs8/1YfS54tQ4pNZZrHba2Ms=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ONZIn4wNHVlRqjTglTPouFpaaR8Lm4M26HSBTD+vMhIosxFeu1kI7guiU8sqIiNbhbOivuKPyKh9lIIMbltq54d1gAkHcjfclujyVJv1UkS3GILe4C67Kn2+xa3eaYw7+bAhbUhni1Vj52+pLOXhM5Q63MRpFku9ryUc2na8VOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORmL84dI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORmL84dI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2608F1F0089B
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 10:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791367898;
	bh=PU+IcueplRLqXazqIdjMXLmPHTn9H5ZIp3EmYmoRI7o=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ORmL84dI/kEX64So2eLp+4+vsZjQsY/SECT4fHN7cGvTWO+oXOAX3s75u29jqrczS
	 5Y1SAu6s0m77Ui+eDBpTMWh49odw/PHv1SUlRV8d2cgjqFUrmoHrR5KQLjYgzuN25g
	 XYXnfZDUApN3xYhIqRAkpmcsmAaeIX0oAw6wy+EM9grMkkaZxi+DrP1d9v0Gb3dl4g
	 0CcN49/Zwc80Il6O7cGlIyhaemFYo6xyvIWnLGEC5rizUuKQmGeEdosSiD6DDU+nsY
	 mKOpXiVDtBmCQ4gqEEFL19CNFabacsC4V95XPC2K8wATqFi8Y+frAWYgxpbrKIP6tq
	 H/jL6D6flUxKA==
Message-ID: <sashiko-outbox-162844@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/8] landlock: Enforce capability restrictions
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261007100255.1333386-5-mic@digikod.net>
References: <20261007100255.1333386-1-mic@digikod.net>
 <20261007100255.1333386-5-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 10:11:37 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Add Landlock enforcement for capability use via the LSM capable hook.
> This lets a sandboxed process restrict which Linux capabilities it can
> exercise, using LANDLOCK_PERMISSION_CAPABILITY_USE and per-capability
> rules.
>=20
> The check is a flat per-layer allowed-capabilities test, with no
> domain-ancestry bypass, no cross-namespace discriminant, and no
> dependency on the target user namespace.  These categorical denials
> return -EPERM, like the namespace permission introduced by the previous
> commit, and they mirror its per-capability allowed and quiet masks, so
> LANDLOCK_ADD_RULE_QUIET stays rejected for this rule type.  Successful
> capability rules and denials are traced as the previous commit
> describes.
>=20
> Enforce only at capability exercise time rather than modifying the
> [ ... ]
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007100255.1333=
386-1-mic@digikod.net?part=3D4

