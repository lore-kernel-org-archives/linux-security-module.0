Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453451;
	b=MPZrHo9yHeiYTx44/5ak8l7tHs1pbHdDGUzpZ645M3aL4Nk+dx1m+OyrwqP3W/eSMi4V
	 pGnmhVTVA+xdNq1+rRfoIHnwLr/Vy3lG2YQiy9GtaW4t1EaAWxHwyNQEE+5gcb/m4m7P2
	 erAHs+sEYg9pbvIvQlLCiidO/TYqjvVcTXxxATA3eoAV6+u9LrvWKYgzN+I9KRPMOGeVe
	 xATd8UC+K/GW5y3weGlZHt5Fg3oscuGn6dWRuaNFKlgONWI7kJCd1eCBAtrXhI95BwlD7
	 I6OsW676+6htimszZKVm68BfWVfA+/NptPqML4mz6u2wnXCLBryCLGL0+okj6AuZzNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453451;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sjucaeflT/4NGz1Z8840lb9pYCgHsVALIanJ4ozgQR0=;
	b=N0kIpx+HR0+01oWwgaDc7VleGN+nvJZXIaBH/He4R55fJsbLKm7ZFfSlWTEFc4XoSjKN
	 mcY0PzuUIeaDFVyJOP4v2gLO9tW67YrWKnOJVUvofHg2+epYewl5ftVe4Kz2+M2E4seRM
	 dPaHLLHKjp2JnvoC2m43k++BQN7U5NcDbyvsZgRTs3Pk5JGGPlwjpCsudEGxRArSRYxxl
	 s39+ZOcR5A2IX0FjBIbrwpD3cR6OrZidftJZed3Kz2IQdZr1VJKTQSSJ2Tlocb/jLpeLr
	 wAo/VO6It2DQ/WsX7Hnuzxg5lZTvrZwEeynoehvWh2B47hBjr8lU/qutF01HFAQ3HQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPKP48++;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176C3606A32E
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 03:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPKP48++
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971591F00A07
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 03:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453450;
	bh=sjucaeflT/4NGz1Z8840lb9pYCgHsVALIanJ4ozgQR0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=aPKP48++AKPBZKc9lIYBNQxufXKP4bN78lJ9vCX1dPZumLTVXLeLojuUWwY77hM8o
	 0H+xlNJI8NaVoh+z0GbgVtjCcgplUvh7w2RnqFzOoasQ1WRd4cgq/9g3MHqUvmueYt
	 o0AmVHy0Q6qJO/lcIzPxGhYvBvvfqO7SuMEBdQQa57lCrf/qGP//AUByXzZytKezYy
	 BYrzbs8xV5v4yXEGCQm5B40txMIdbmwtNW1+RSEzZ7k49ukTtc9r6iXXr2U1xZUvid
	 kaVUYOV7HY7QYYFM7C5CT5f1GFsZ8I5EHE0z1YYCWv0TnKYBxIvKGasaOd9KJNCsax
	 vt4qTBH5d8S6w==
Message-ID: <sashiko-outbox-210249@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] landlock: Fix layer composition of
 LANDLOCK_ACCESS_FS_REFER
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261112025528.443654-1-mangosteen922@126.com>
References: <20261112025528.443654-1-mangosteen922@126.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 03:17:30 +0000
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
- [High] landlock: single-word handle in Signed-off-by and text after
  trailers
- [Medium] selftests/landlock: missing MAKE_REG on dir_s1d2 breaks
  refer_with_net_layer
--

commit cf0aefc20d751516a8f184c3d49843e96b5c3818
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
>
> Add a corresponding regression test to the layout1 fs_test suite:
> stacking a network-only ruleset (handled_access_net only) on top of a
> filesystem ruleset allowing REFER and MAKE_REG must not deny
> different-parent rename/exchange.

[Severity: High]
Per Documentation/process/submitting-patches.rst, the Signed-off-by:
trailer and Author header must use a real full name rather than a
single-word handle or nickname ("pandaWall").  In addition, the final
paragraph describing the regression test should be placed before the
Fixes: and Signed-off-by: trailers.

> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/s=
elftests/landlock/fs_test.c
> index f725882fa4a78..5588f0ee58625 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -2570,6 +2570,43 @@ const struct rule layer_dir_s2d1_execute[] =3D {
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
> +			.access =3D LANDLOCK_ACCESS_FS_REFER,
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
> +	/* layer_fs alone: different-parent rename is allowed. */
> +	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_REFER |
> +				      LANDLOCK_ACCESS_FS_MAKE_REG,
> +		   layer_fs);
> +	ASSERT_EQ(0, test_rename(file1_s1d2, file1_s1d3));
> +	ASSERT_EQ(0, test_rename(file1_s1d3, file1_s1d2));
> +	ASSERT_EQ(0, test_exchange(file2_s1d2, file2_s1d3));
> +
> +	/* Stacks a network-only layer: still allowed. */
> +	drop_access_rights(_metadata, &ruleset_net);
> +	ASSERT_EQ(0, test_rename(file1_s1d2, file1_s1d3));
> +	ASSERT_EQ(0, test_rename(file1_s1d3, file1_s1d2));
> +	ASSERT_EQ(0, test_exchange(file2_s1d2, file2_s1d3));
> +}

[Severity: Medium]
Does layer_fs need LANDLOCK_ACCESS_FS_MAKE_REG on dir_s1d2 as well?

In layout1, dir_s1d2 is the parent of dir_s1d3.  Granting MAKE_REG only
on dir_s1d3 allows renaming into dir_s1d3, which inherits REFER from
dir_s1d2 when walking up the hierarchy.  However, dir_s1d2 itself lacks
MAKE_REG, so test_rename(file1_s1d3, file1_s1d2) and
test_exchange(file2_s1d2, file2_s1d3) both fail with EACCES in
current_check_refer_path().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112025528.4436=
54-1-mangosteen922@126.com?part=3D1
