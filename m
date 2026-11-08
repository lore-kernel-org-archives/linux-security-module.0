Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169945;
	b=ZER9KQOECRteyjDTRAAa2qFp/xbPYS732paJ4eJGAWPGCzFLkKVgoP11ncJMdcuDt6gX
	 rp5dXmhtRfX+6vgyzSnLCJOmdLaD+FWSWpKij9SoJ6vrcgzrbM1pNN8Vw7HEv2w60pED1
	 JHDqJ2Z0pl8dEc1RpVR1w3nO/iK8bmXbo108zE7USEhbEcsvG0AyG/3KrOORHPnBJIgEt
	 CQYqyPjNhfzGI+XWdP3ibTzIABK/41ejySlhFA7+iJr8m09O2XB77F9EWgOb82twp9DBW
	 NkYaD94ew7xJ8RhJuEwS52R1aI5PKRIdJegjfYpZN/10QW+YlN+yfq0H1oGygtFGNNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169945;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CbQJkdCYoaZj3RcTZu+E8fYSodK5777Xegk2wsgMHUc=;
	b=AVhLJoFeXCz+7LtWsQITw5o5MBokWrrQ1AJFMRf9Bumy1Mbrx0J1WKoaidLdqhVENw41
	 n1aBJ92gV+xmUT4okWqTLgvBxd2HrOiq3HBz57lDLkoHdb/yRbXhPon6lGU1Z8i9m1vm9
	 TiOQw5ndS6FSC3ojOQwge+qv3xUEl2WKn2i/IhwNMpUUBMisEDyoZ8Np88Nud5lxq1yFN
	 onlN5HmpUnvXURN8CWSrkt30htrAHszAnQyjOqDy9qwHEIrbJ0l+S/htmK2MqiVDCQo0d
	 YAuCIR9M2N4R5hZ505boraQCVGm+wTawGmnmcTAp5qBVhDiNutF9I7ry5s/CHDV6lEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EVOq5ccU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76754606D806
	for <linux-security-module@vger.kernel.org>; Sun,  8 Nov 2026 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EVOq5ccU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0359A1F0089F
	for <linux-security-module@vger.kernel.org>; Sun,  8 Nov 2026 20:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169945;
	bh=CbQJkdCYoaZj3RcTZu+E8fYSodK5777Xegk2wsgMHUc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=EVOq5ccUpL3Slps8+Bxf2/vq3E4gqtyXa8zqJ/lTcPz9hiLrLsv7GexvSQOlosV8J
	 /5RYCQ8pXyuLnkf+iSK5X3XTfOdzhTnvZ0k6ELS9eJ9DwM4KE89Qwf+0MI9OTex/uT
	 WvmEqyJOSxxk/ParnuSNUsrURFrvvjyAZESDSn8fXrYIfbds8VvFrpgAfG4iQTFOPE
	 Zin7oYQVWTtzBy+ffZ3vxevcp9pq+FCKPkQaot7ianIVjTdo/oYAm7mQUmQG5ZxFVA
	 BxkpdbOz6aBf7xwvGJljW2ItP93i0m1OeosW8ZcSNspEMv4chVTQv3oRtDLUsfoT3z
	 Lvr8/gWyVBZsA==
Message-ID: <sashiko-outbox-204018@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] landlock: Clarify implicit handling of
 LANDLOCK_ACCESS_FS_REFER
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261108-b4-landlock-refer-nonfs-layer-v2-4-2b405fc1b3aa@gmail.com>
References: <20261108-b4-landlock-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com>
 <20261108-b4-landlock-refer-nonfs-layer-v2-4-2b405fc1b3aa@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 20:32:24 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> The LANDLOCK_ACCESS_FS_REFER right is handled implicitly in a ruleset,
> but only if any other filesystem access right is declared as handled
> in the given ruleset.
>=20
> The old documentation was still a remnant from the times when
> filesystem access rights were the only access rights that existed in
> Landlock, but it became misleading when we introduced additional types
> of access rights.
>=20
> Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and c=
onnect")
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-b4-landloc=
k-refer-nonfs-layer-v2-0-2b405fc1b3aa@gmail.com?part=3D4

