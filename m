Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467092;
	b=3jatEg3UC3GPWIBeN46NYkU1SrO8YyAJ8OKxlRvBRSFQxSOXFw3mwY31h/QZE1b2l+4t
	 tf3JnZ+gqt6iqFxS985eqgag/cd/ktP/Joy9aQGH8Uje9M7GfDYhokNRKurB3f6fXA3jP
	 Jc3ZXgfc7mI2v3VBGy0RqXhqFIGIxxQjBmzwPxjaI9btdKVZJdjJARfQTJoaKlBGXSPcv
	 cbcGX0r1OWiOGZFLg+BrxNp2yITzSzb3e972x/+qNdqt6S0SdmaPjHDt0xHT+JrtowMHT
	 tMdB1V1zvJBpaLBGNG3xNTSoG+swSPLu51wdcY2NnltWFsyIff+elY1XhAq4dhBucMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467092;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BpM7YKp7PSCa07TKHIY+Ekd4V3P4TZwGvv+frCnQ0wc=;
	b=jjYz7c8Zp9Cwu8cfawOS5Fd13ivThkkfw/dPEv+6XXefYPISWvLBxoDH7sFyQZzpziUX
	 DuI7FgfFT7/rTfbLjiYa8hBP85IStwuru1C8FbQzKAZs/Lpe9WpqFPuuMICnzvRN1kb/b
	 HEliOQNlRFNziApjivVpTawFnrEMM93EA4MVU5AgHOFVZ7qTrfzivovxlrNnO0FFr8dT1
	 HuZGvWfXMHoELFPRI5nfKskReXTsegQmf7h/JzDkQksybONMwOzKjEJtntC/aJLgm10IW
	 xfoSTVE16f4KarU/7D4lZEYurr1CnQg+FgiCkQGZLCcnPhwnSkH02KmNTpfJC4ZLCgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OGxquTnC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F432606A31C
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 07:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OGxquTnC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2963B1F00A05
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 07:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794467092;
	bh=BpM7YKp7PSCa07TKHIY+Ekd4V3P4TZwGvv+frCnQ0wc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=OGxquTnCWHMMdwcN4pkb3+yCRl5iMy8OZTvR/Fhx0bL7Zf1MArj0cARPLonPa0Zoe
	 3I01VnoHlC17XiA6gUix2Qq6+wokVjp28P/RkyRR7205XdemUaB6pExUB2sdpIHcEM
	 VxJlexWHJ5G14uFeVPsFSNA22TMhOYeW0zgygbgTB+bktzAhtXClrP6kSE3R7ltI2z
	 UiEcJC+Y1BusfL6MWpGi2iz2ViyoQ28JM0yO463dNF2j/IRlq/u8+tso2t1YjkOBtc
	 5cWu47Ez2bhh5Ce8hGNRPwQAbYWe8rlHXM5xFXkfc7KcBvQzRiznlizZQvh/kzr6DC
	 4y5hoPE7wwLqg==
Message-ID: <sashiko-outbox-210566@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] landlock: Fix layer composition of
 LANDLOCK_ACCESS_FS_REFER
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261112065203.1066536-1-mangosteen922@126.com>
References: <20261112025528.443654-1-mangosteen922@126.com>
 <20261112065203.1066536-1-mangosteen922@126.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 07:04:51 +0000
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
  full name
--

commit cb46916a3af3329861df374b264b4d7fb8d1f7a6
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
Documentation/process/submitting-patches.rst requires a real full name in
the Signed-off-by trailer and Author header rather than a single-word
handle or nickname ("pandaWall").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112065203.1066=
536-1-mangosteen922@126.com?part=3D1
