Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794461807;
	b=LROZq+jDAVRYjNPVe3NmKuTz9hxAR29nBakvXBn8qpyHpLo6JQxyFYYcY3Etm35Uk5PP
	 tN4xJFnyLVfCQOD8h/wUZspiwZR/XxBTUty/GLAyXmPWTE0tp3UudFANz5RIZxhB6Jp/S
	 TZfMXVURahYD0OAUiPSoKIhMj1I3JNgeuorKJUOnBPXFnobHSfDb1LnuSjxKD4P1o0TMm
	 bwVat2nmTwDFW9mxNE7skDhcsIPufbo2PFmZHVOrclOxI2fyCsY3L/XUY/P0XpZA2iiMe
	 zke+NZB63L8KoI4pV8holugTwY9F08FqK7j4F18o6cUxMapWNk6ASEnaDbrpLol6dBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794461807;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JPOrsiYfVFc6CfxEOLjOLzZuI6+lIW/DS0fuVq5oTLs=;
	b=FiDMKOB2bHBnchP8LEXeVzkSXyvY8n7S8Xm2YPlNLXL+1pVdHEhqEE2KFH1wFvTPI8zU
	 uKwGqiBQ7tn+1uMyT6zV+fwRFfRMrry5ZvXRw5c0AsO8HSQdqG1iPJo9YOO5hTGv13duL
	 u5z5XJvDAs46a/qze0ciV/MUAlOV4bwZYyNJpRJx+DXIiSEVyleBTmqMNJz37MEjDIqrh
	 riNbaSWb7winOpjZiotV/uxC27wEBLDJD8KsUvlBROGV/c2NExTjRkDd1Y+sL6RAZdp1w
	 hwc+VXtvxyKzZ4nDorITU5p/ZvLfrbGXsS5i39VxbikdDW5qT8HAb/LVHn+Mofoizvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xf8+YLpU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C333606A334
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 05:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xf8+YLpU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836971F00A05
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 05:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794461806;
	bh=JPOrsiYfVFc6CfxEOLjOLzZuI6+lIW/DS0fuVq5oTLs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Xf8+YLpUVstQo4i1o4tI2ZRKqw8xyBCqgBNN9swnIFpH5fiRA6lEj8w8s1fAnR6VJ
	 R+EQ2bYKVfzDVeX/0OLU660F0TE+W8/babj/oxqQIKRwuqPvEzkrVAQq4HNHS16p3L
	 6Zl2ilEUA9FmR9az5mJdjXRPYHnfNiRSA5t83qW7RJFc161D1kwOxf14AbGJWPey0C
	 CoOEJLuWPirwV/fLdo/gGCg3LFyqaJST9/ZcDFG3cAIZonV9GT1rQukMTQVWrIauwX
	 Gwr1mI4GsZyDQZxb9NVrIh6fwbWb7nY5hA7Msf/Xmase5dX8FNTS1kE/daDveRbuHL
	 oOQWWpLms0Yqw==
Message-ID: <sashiko-outbox-210461@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/2] landlock: Fix layer composition of
 LANDLOCK_ACCESS_FS_REFER
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261112052713.859515-1-mangosteen922@126.com>
References: <20261112025528.443654-1-mangosteen922@126.com>
 <20261112052713.859515-1-mangosteen922@126.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 05:36:46 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] landlock: Signed-off-by trailer uses handle instead of real
  human name
--

commit 6fdefb3a96cf87892d81d37297b85c7906fe0143
Author: pandaWall <mangosteen922@126.com>

> landlock: Fix layer composition of LANDLOCK_ACCESS_FS_REFER
>
> landlock_get_fs_access_mask() unconditionally ORs
> _LANDLOCK_ACCESS_FS_INITIALLY_DENIED (i.e. LANDLOCK_ACCESS_FS_REFER)
> into every layer's handled filesystem mask.  Layers created from
> rulesets that only handle other rule types (network ports, scopes) or
> only permissions therefore report REFER as handled even though
> landlock_upgrade_handled_layer_config() only adds the bit when
> handled.fs is non-zero, and no filesystem rule can ever clear a bit
> of such a layer.
>
> The consequence is that stacking any non-filesystem ruleset on top of
> a filesystem ruleset makes link(2), rename(2) and
> renameat2(RENAME_EXCHANGE) fail with -EXDEV/-EACCES even when each
> ruleset individually allows the operation: landlock_unmask_layers()
> requires every layer's mask to be cleared, and a non-filesystem
> layer's mask can never be.
>
> Only implicitly handle REFER for layers that already handle
> filesystem access rights.
>
> Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and c=
onnect")
> Signed-off-by: pandaWall <mangosteen922@126.com>

[Severity: High]
The Signed-off-by trailer appears to use a handle ("pandaWall") rather than
a real full name.  Per Documentation/process/submitting-patches.rst, the
Developer's Certificate of Origin requires a real name and does not allow
pseudonyms or handles.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112052713.8595=
15-1-mangosteen922@126.com?part=3D1
