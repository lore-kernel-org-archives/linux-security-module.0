Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D498B3C3F5B
	for <linux-security-module@vger.kernel.org>; Fri,  2 Oct 2026 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945591; cv=none; b=uExPzeDsGhreXRa1NwyPP/VuUD3kSGDaWVVAeJOrnySDfgnmZedm8Y7MkhwUwss2N752TJpmlEOOtdX2kNvXRWrm2zoaJsBbHqekI7c8vjcPz7puJp59h9Rli+Q2IRHIYnitDWAxp+pedojIL8Wgd1YFvs9oXFs43EXc+P0FTAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945591; c=relaxed/simple;
	bh=F41RlK0ZO1PhyfELXATZR74Q1IGG66+5FT3fQFv1+Y8=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T4FLgKESy3Iri7pzVaX7GhblknCyXSI/d4wzLuc4WUzJOMEQ80I03dvt7czD8AjICbXwRHJ1zn+ZkM2uWy4/IcNLs/aDESBmQQ+gtjVYkQNrR51GZb2zT++V2Fx/LSgjPtoW/lRsESbzWkqY45DaQopacR3MsWl5Hpmto9798Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5Pp3rOd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5Pp3rOd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314161F000FF
	for <linux-security-module@vger.kernel.org>; Fri,  2 Oct 2026 12:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790945590;
	bh=KbQJXhJ55JmgywAv2CSeZj8KlApvxb7RGUURSulEHPk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=M5Pp3rOdEZbjA5fW3uK5nV27Y7ZPQOyC2WpknLozIe7ZApli0MZ4snDkyOO6axqde
	 z6x8nhZATZ6Tz0d8eukyFgY9m1p3AeXqo13cWnkTdAwcGNGMjVYBYk9cJX4i/CJSZt
	 4UDqwK5+9+9KEFh5rxByRB4Qp/pwHiu54ZDtBC3Q69fqtfeSlbq5J0zPIeh7Yb59sR
	 f/fdScUuemtMP2vI0gnyGMugxP3XLFqQ1WZs3Tw6+RfOwMeY+PKAFzFqm0ZbJU5uUF
	 he4Z2B8On4w1wuplVadXLzKzRowjto0Z04i2RUSbC9LwNcQ2IdFWr4JqrvmaxD86Oh
	 htxMayTj14Jug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/8] landlock: Enforce capability restrictions
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261002124409.1277970-5-mic@digikod.net>
References: <20261002124409.1277970-1-mic@digikod.net>
 <20261002124409.1277970-5-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 12:53:09 +0000
Message-Id: <20261002125310.314161F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002124409.1277=
970-1-mic@digikod.net?part=3D4

