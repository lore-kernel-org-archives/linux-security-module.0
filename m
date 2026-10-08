Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65488231C91
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470193; cv=none; b=q5dtl+EMX+00v+qBPNEchY/AMF2hTt4zzV/oy14Pt5KQzAPf53/6z3HtqAXj4NAm/OOFumf6YvQV1M5FAKqfl15wdxfskCn+6ZEnQUbLdhG69vl9rfuv6vF62Yrc5YJAStJnx7r6PamZvtvYUkcMAfs+FpJnrbe/uUc+QaWQ5q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470193; c=relaxed/simple;
	bh=t+D0hwGCC+qskjJvMeNTvbZHmG2KvKCiyvENur8Sic8=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=W1F7R8e/8ByVAHxqrl5uL58q90w9JagA6iLeUwLf4Nlipxma2GlsoGGRiw0mtgr6KFjOiTqE9XGuwI9c2v2m/odF7iBk1A+z4WHCNoI4OoO6PcQsRdAG/d/tS2rvk2Qksg/AKeNGxZEnE9g38YPmDYwifEAeCDGM2S7q6goR6/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq6/8i8W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq6/8i8W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D481F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470191;
	bh=t+D0hwGCC+qskjJvMeNTvbZHmG2KvKCiyvENur8Sic8=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Tq6/8i8WBthYsgA/dUfTJ18rOxeVPYE2Pb1KEyP0TVwLgm2qLunFHZ1jmCeJpgKpK
	 Q0OYy+L06O+ZUPB81lca0S6ii3FgYaC/XqucgidvTa5cCzLIvn6Uo5IcjTjDGeJOUr
	 o0y5B5s/gbq25f5PRkGPrrFZuMe8cD5+/2s3i4a8F7pJJ51eBNNPrifkx13xlKBRFP
	 PjARfmSD9KEW+H+jzioa94CR42ut3b0oT/AqeCTBQB3970zKC/Lns0i4jSzKFPst5Y
	 0CbA/zA3XOBoNGxkMpEX8xKfZfT3cGzMnP3rPl8x35M3Sjd25UxLHnzjpxupWVKJs9
	 nt3GcNGA8rkXA==
Message-ID: <sashiko-outbox-164307@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 19/27] selftests/landlock: Fix off-by-one in
 regex_escape()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-21-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-21-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:36:30 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> The final check in regex_escape() was off by one byte
> and should require one byte less to put the NUL byte.
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D19

