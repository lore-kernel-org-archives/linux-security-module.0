Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6046B640
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470133; cv=none; b=MgXu7Juo9ltSRJzoTDuzhD9Z4TYfThpspKrjrWuqw/VXb28fXXs4PMgLqgNa3BB209WefxLaLrG0irTrCFWPRtAaBRMhAr/Zj6+np1Wp2SxadLgTIHYdBCwVPywvB6oseEkLCp+qPVGViyBbw4VjpJ0PBR1spknNWboyd6LiQTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470133; c=relaxed/simple;
	bh=3yLep9tvTymdoQpyekGhyg+jWDbIZCSU4VEV8VvnLms=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=kPyB+PbyhEVmgYnUzhW8zF8/4fMQo1Zg+SN9VYd9bdPfGJaFqaFpPtOefxKEp63woFAgvp/AqlDuiNXUhhjsifEN2I/Y8KGE/XnODj6OQ9/frmrDWO2cTlja9TV2OaaMaj2tWELorrSk8/AiLBIpTCPcAJUg7hl68CypfxpRfuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+sS4N69; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+sS4N69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F981F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470132;
	bh=umY7hjdkLY6R5x9nnpkmZSXfYy+gbrYXhF1Ba5Iy99E=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=m+sS4N69wf/4eNw6em/NN6CvvHOIemJsDJklWoVapwUU3u2qcledD+FSK6y5GzCEY
	 WaEXlhX1YZG3eI3wnvYnKyUduw00ah8pQ4WxcIL6XoDaR3UOWbJryPTEjdYuUIjX+q
	 Gy7+cDXSHI1s6qBDYJS9VuHABsL1bEWdPC2qbAqFKUcha4ltrgbEY3TkxSq58SCoqE
	 pe3KD4Ja8nmS6QL6XOCmG9UFvPeHhyW5VLeAWuHwmooUw53unRlvXeR+JDf/83KGSG
	 SG3Ers1SiJiiQFAkgqDYQ4mA78Mu5l7ro8jZ6Q0n7IIvWd3kmNPw1CYo8CMADMMlI9
	 DHwQ0DtQMRZSA==
Message-ID: <sashiko-outbox-164303@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/27] selftests/landlock: Assert audit_count_records()
 before using its result
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-14-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-14-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:35:32 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> audit_count_records() fills in the record counts that are checked right
> after it, but its return value is checked with EXPECT.  On failure, the
> counts may be left uninitialized and the following checks are
> meaningless.  Use ASSERT instead.
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D12

