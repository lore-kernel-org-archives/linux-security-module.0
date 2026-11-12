Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794462136;
	b=ImUouFLK3AZmsG0qiK4D0RWKhWeiD16r8Ewrnt5bcZ1NPNaN/o9w2eoRilTFDMLMR5k+
	 FnsAyrAk/9FiPZNdeFBdzkHsaqEQ1gkJl4O+dyRIl2+T88BtvTBWjNDvfSbqAoNMgrkHG
	 2iA+vxVFaH4CNbZ/KzWfm2x/uojJAWX5DnR6agp4ucmbASxjtvUy8OSChnhoY6/xnKy2b
	 jP2TejEWfyqmCQetWhOGOyrh5Rq4Y80zPxUdPuzbZmIyD73Vqa5s6ns/jkrmZNYLj2Cic
	 JP3U8bNMGQTi6NujnDO70tMULUtzUBd+s3LYMB7S1GdOj6WHT+K6+88C45kUbx8lVZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794462136;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tDcHZ3kJ0vKzG31eWVXKvKOE21Wz3lXwXEgrTkyPNrc=;
	b=YpLz7jmh3EQeJsOrr/bEo4oydcgtN7og+fvJUZehM4kNB91eY6qqStKnRHS6JrEDfzVI
	 Qyt4c++g+3MAImm2v+ZPTkXhal1FCg0evA4ppIjFDddGoXQQQ+zcmD4Z948QlW9pQ1ZGF
	 eqCL0xZPuOoVmmLeCWm/sGBNVC8qr+PKE4FxJl42m6GHY9f90qs2wYGK30oBqLspy0Z5z
	 /Nmlzo2WWIhmiM3u/kwgPBz3gdnmn94heLBiB9tokZwR+zmo9PrqbmYUsMa663cbLVmER
	 e/BGUb82+EuaQGXnYrSBjXjPqmQHWOF6tGGEZWWE9x8iK91rUAUZZ8hRXHBmDSlLe9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7TLH8Zu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D7606A324
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 05:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7TLH8Zu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DB61F00A05
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 05:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794462136;
	bh=tDcHZ3kJ0vKzG31eWVXKvKOE21Wz3lXwXEgrTkyPNrc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=k7TLH8ZuzCR6//vUplfs9rDFMyIBUJprG8FVKdzba6H8C/ZY+cb09XpU3r+5wJH39
	 If+GqMecHyHevqxXoFSuWkzRXMAP0VdGYefFtU8lalxo+kvlALQWcUGfssdaMQJNsF
	 SK8rxQfLeIAsagBiWsCSeE9IJevPwCHH3rULJxBggDIUAyUZIXDLrCKhNjlHLnLzXl
	 KZ1ZIl/uBnC+l0l69z6SwAh677MJaRTJjhk+gMKQK+Ft/sjmI7rmcqd+V/t64Tjo38
	 97fHvWS1Wn+cKxjnB8K9atnGcAyzpc0fBWfbmtBnhAHb8EDiJX2RvAO07QNStOypX7
	 p6uabHuTuZ7Lw==
Message-ID: <sashiko-outbox-210473@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/2] landlock: Add a test for REFER layer
 composition with network layer
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261112052713.859515-2-mangosteen922@126.com>
References: <20261112025528.443654-1-mangosteen922@126.com>
 <20261112052713.859515-1-mangosteen922@126.com>
 <20261112052713.859515-2-mangosteen922@126.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 05:42:15 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] landlock: use of handle instead of real full name in
  Signed-off-by
- [Low] selftests/landlock: redundant dir_s1d3 rule in
  refer_with_net_layer()
--

commit a26cce886a00516c15353a37b118df17895f1736
Author: pandaWall <mangosteen922@126.com>

> landlock: Add a test for REFER layer composition with network layer
>
> Check that stacking a network-only ruleset (i.e. a layer handling no
> filesystem access right) on top of a filesystem ruleset still allows
> different-parent renames and exchanges allowed by the filesystem layer.
> Before the fix, such a layer implicitly handled
> LANDLOCK_ACCESS_FS_REFER and denied these operations with EXDEV.
>
> Both parent directories get MAKE_REG because each is the destination
> parent of one rename direction (and of the exchange), as
> current_check_refer_path() requires the moved file type's access right
> on both parents.
>
> Signed-off-by: pandaWall <mangosteen922@126.com>

[Severity: High]
Per Documentation/process/submitting-patches.rst (Developer's Certificate
of Origin), the Author header and Signed-off-by trailer must use a real
full human name rather than a single-word handle ("pandaWall").

> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/s=
elftests/landlock/fs_test.c
> index f725882fa4a78..cf11281639c67 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -2570,6 +2570,49 @@ const struct rule layer_dir_s2d1_execute[] =3D {
>  	{},
>  };
> =20
> +/*
> + * Tests that a layer not handling filesystem access rights does not
> + * implicitly handle LANDLOCK_ACCESS_FS_REFER, which would otherwise deny
> + * different-parent renames and links stacked on top of a filesystem rul=
eset.
> + */
> +TEST_F_FORK(layout1, refer_with_net_layer)
> +{
> +	const struct rule layer_fs[] =3D {
> +		{
> +			.path =3D dir_s1d2,
> +			.access =3D LANDLOCK_ACCESS_FS_REFER |
> +				  LANDLOCK_ACCESS_FS_MAKE_REG,
> +		},
> +		{
> +			.path =3D dir_s1d3,
> +			.access =3D LANDLOCK_ACCESS_FS_MAKE_REG,
> +		},
> +		{},
> +	};
> +	const struct landlock_ruleset_attr ruleset_net =3D {
> +		.handled_access_net =3D LANDLOCK_ACCESS_NET_BIND_TCP,
> +	};
> +
> +	/*
> +	 * layer_fs alone: different-parent renames are allowed.  Both
> +	 * parent directories need MAKE_REG because each is the destination
> +	 * of one rename direction, and the destination parent of an
> +	 * exchange.
> +	 */
> +	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_REFER |
> +				      LANDLOCK_ACCESS_FS_MAKE_REG,
> +		   layer_fs);

[Severity: Low]
Is the second rule in layer_fs[] on dir_s1d3 redundant?

In layout1, dir_s1d3 (TMP_DIR/s1d1/s1d2/s1d3) is a subdirectory of
dir_s1d2, so the first rule on dir_s1d2 already grants both
LANDLOCK_ACCESS_FS_REFER and LANDLOCK_ACCESS_FS_MAKE_REG to dir_s1d3.
Moreover, current_check_refer_path() requires LANDLOCK_ACCESS_FS_REFER on
both parent directories, so if dir_s1d3 did not inherit from dir_s1d2, the
second rule omitting LANDLOCK_ACCESS_FS_REFER would fail with EXDEV.

Because layer_fs[0] grants all handled filesystem rights in the domain on
dir_s1d2, collect_domain_accesses() in current_check_refer_path() also
returns true for both allow_parent1 and allow_parent2 and returns 0 early
before is_access_to_paths_allowed() checks LANDLOCK_ACCESS_FS_MAKE_REG.

Also, placing refer_with_net_layer here separates the
layer_dir_s1d1_refer, layer_dir_s1d1_execute, and layer_dir_s2d1_execute
rule definitions right above from the refer_denied_by_default1..4 tests
below that use them.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112052713.8595=
15-1-mangosteen922@126.com?part=3D2
