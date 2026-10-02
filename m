Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41503C8731
	for <linux-security-module@vger.kernel.org>; Fri,  2 Oct 2026 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945546; cv=none; b=gKpg1rERdOQ4EuNAYSlfbBYm6bvHlteMmbCbg5x7Jah1D8sDgUe45NGjo+lFRyO4eRUbEvFofmFioPMwv8YH8cDuh66C6RHE9XwVaE9coHhfwmQRdfIUieY5MM8Sv2UMxoCfDsLY6lzHghMZHZjYVtXYO7ONyHe1zBEBlvhQbG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945546; c=relaxed/simple;
	bh=dJUi/z5qP09N7qwONhtEIs4G8e/oZkaQu8T7FtRCBrE=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BfE5xy6XnmQXWQ+RxvZFe5nnJYcIR/oHUcHDB+Si1eWlzwg+AADi6YZoM1SXfWFd1EeZERCbiwQjksSxPWx0wnihwy17qf6RB0sgtfksakL7c1/hvGy1Hu8IsvtKJ8xLe4tNeUE8N4aWXul1+JMpz7zrNEOhZIyD5n2uQIuS1yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIwXZowV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIwXZowV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9361F00893
	for <linux-security-module@vger.kernel.org>; Fri,  2 Oct 2026 12:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790945544;
	bh=R0l6/Ke6Zhr8ZpCs7k6jUianj+feFz7Ayq9YhStPrDw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=bIwXZowVIbxIHh5D6CPvpmLdya1ooPVa2CTtnIPc5JYRLdcZZZbsdAbYx7Zovzuho
	 I2LloPoj7ycXW4WU8UDRevqJuiiUJhs54XmS1in0jNbSjNukTAQddEcHStIQiaFzh4
	 nAGbMQiJRRZ/3lSBxp9G/Wi3jgnURKSrL+i3N707uHyKK92SouH+UqDsD0nHLCvJlS
	 bV06NE4GnAUkcbkFuL2XGauO5WcmJSWe60wQkf3axr24E7K8O7y8ZuB+zoZuG2IPd7
	 mXkoWfuSlN0zlFvBHuIFhLo1N+tnRga2a5bwhTBlA+Sx5F4BitSBsa7u0oNgjpFLMj
	 zDt6C222D5sMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/8] landlock: Enforce namespace use restrictions
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261002124409.1277970-4-mic@digikod.net>
References: <20261002124409.1277970-1-mic@digikod.net>
 <20261002124409.1277970-4-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 12:52:24 +0000
Message-Id: <20261002125224.8C9361F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> Add Landlock enforcement for namespace use through the LSM
> namespace_init and namespace_install hooks.  This lets a sandboxed
> process restrict which namespace types it can create, join, or acquire a
> file descriptor for, using LANDLOCK_PERMISSION_NAMESPACE_USE and
> per-type rules.
>=20
> Introduce the handled_permissions field in struct landlock_ruleset_attr:
> each permission gates every use of a kernel-defined category (CLONE_NEW*
> namespace types, CAP_* capabilities) with complete deny-by-default
> coverage, so unknown member values need no validation, being denied
> until a rule allows them.  This UAPI extension advances the Landlock ABI
> from 11 to 12.
>=20
> There is no domain-ancestry bypass and no namespace-creator tracking,
> only a flat per-layer allowed-types bitmask: hook_namespace_init()
> [ ... ]
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: G=C3=BCnther Noack <gnoack@google.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002124409.1277=
970-1-mic@digikod.net?part=3D3

