Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA947ACFD
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791368133; cv=none; b=Wk6z62tm9upkkc2fUqlKmJpNw9nkW2vnOSTbJlMB4QeYfss99iQOyf+0gjLljrmlvw0L5Om3u/q9PehKiDn3rCVbcNz9ovMW2J5nEXnIMpjkdDz+hdJjeFNRa8/p9kz8FWPt4X0B0AfY4yltw5xko41BbJ49wuAtoLJoKaZvbAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791368133; c=relaxed/simple;
	bh=PbuUSHskZaeP0Swc/UhjJMs/1XnOOcjkQKa+NFdPs3w=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=mA92IGlLnTIi5fIG4EjGLjWHf+tpiuSwBpizo8jqTyjCJ6OygliEPs25x7P7RpdxysFVFCFhP08asFAfg8rsNZZFvTwj9cszcWHUPfKNEv962/WMAXCxKwXQERSi70p3GjqJmTbes0CaAvX5747AWUn9npwkvipupNdKt7h7xO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB1S7iMe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB1S7iMe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D2E1F0089B
	for <linux-security-module@vger.kernel.org>; Wed,  7 Oct 2026 10:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791368125;
	bh=AXC0zT/g81R+CBEVIEJ4ecy+tbIT+3MF4eZ+OvDwe/Q=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=NB1S7iMeHiFsaYqkcwK6w7YJvdOlFJvI6Rm1MIQSfFeADlCFzIovC2vaUwAbGchp4
	 uPvSgxFRFYvw1qe2dcdhWr2OBtVSGj1dVjL1wr9f9T7t2f7ngyIOR5NNhFRJJStjbx
	 orvMeGTup9CukjzhQBXHqTnD3K47KSMxYLrxUuR6Z7OQKo3RpoDunKTKDhj/hHY/Mw
	 t6l/g+VFmMlIK+YK2Xc5/BCdkGc1exQlDma+P6mNhbvPsiEcPWbn3CrO1gzF3QTtoL
	 m8sBWH1+IoqMZ//HoYODY266QMqsvftXURDdLfJKBPERc9kghWfJlW3U6pM0VR6dz+
	 gzeJ2RUUk1C6Q==
Message-ID: <sashiko-outbox-162850@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/8] landlock: Enforce namespace use restrictions
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261007100255.1333386-4-mic@digikod.net>
References: <20261007100255.1333386-1-mic@digikod.net>
 <20261007100255.1333386-4-mic@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 10:15:25 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007100255.1333=
386-1-mic@digikod.net?part=3D3

