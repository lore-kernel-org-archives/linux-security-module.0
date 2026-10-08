Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A794B0CBF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470016; cv=none; b=RVhqpcwSYgfgsGVMHzpathr6ll1/BHDIK+03iYcPtzNHTv97VOG/fgtk7piUMoUdmsz8gIIq6AWtqdDjoqrc/NuOuf994XxGdPUfk4WXLp4s3cNd47yeYBPPtFB2XvC4GKDzcIJSot1vRrpdc214haNLhvgzQomwco8Ul/kXs4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470016; c=relaxed/simple;
	bh=xvgG3slb72UFZ82Rhg8l+e3NpcOZFVjw+F2RwLD8LY0=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=MLNXjqabwgy9aNSVS+vGxr+wrsGAgbOBsOcF0hziRIGB/d02oXccBzsFRXl4TzWCus6GVt5bXVWV+dfN3O+VI8keIQguNBbshuR5CGstAoHIHNB+WjwGsotpcvYb+aPZ6SHIHmtepctb6CLNA7YmnedYimyCdhcg5b5CZ9jigeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpHTnSd7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpHTnSd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB2D1F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470015;
	bh=+ou3EFX8R67dz26zUczYEkiuLh4t+7bOVTIacQRr7d4=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=QpHTnSd7Jgz7O3KJEyQq1lcU5rECGpJubC6JoIexUwDiBBFcuB9RNWxNHDpXKsREq
	 Uefkr63jAZLXC6SeP1FXNgQtErAzBEK9usLrNjaM8HsaV6CAR9yKgg8ycuFmdkvWp9
	 WnzIt0jbPbeoMQKgnIA+E7rC+GIpgDRBbaFPbNV7aS5wese5LQPd6QYSl4vZaSsdDI
	 csCYyerDRYzO4pa6WdHAyELUeyFEEOSbP/yB0oWTdqGGR6OKdBZN5h/YYiKBBtKPeC
	 8Cp5v8GVw919Y3phOvIaHRKiYem8x0jhfrKBkrDTgReEpmmMBVQyEur30ojeouoq+A
	 jO85lCJqHhDKw==
Message-ID: <sashiko-outbox-164294@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/27] selftests/landlock: Zero-initialize the buffer in
 inconsistent_attr
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-6-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-6-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:33:34 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> This buffer is passed to landlock_create_ruleset() a bit further down,
> expecting an ENOMSG error.  This is only guaranteed when the buffer is
> zero-initialized.
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D4

