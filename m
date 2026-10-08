Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270204AF678
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791470039; cv=none; b=B19R4G3YvD9B04Rguqx+RsNm6/9Xusi0hOvzbLX+1d31+aUKqGExKtns/cThZafWuHAaqAjesuS/4OVdqa/FfP5Gj+ZQYIeY94rgaPXnTIvGVNdks2pEHXY24uOA4dxcpPJNRMfdaQyCHtBW1Po1AV1lgY7FTW3iYCAHCj667+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791470039; c=relaxed/simple;
	bh=3feMI/nw/mNRl35p+kbOpFFmobIe8fD7ELeZtsBkFls=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=iTjHeTGuJzrosLFs6+BGayuSUBq1igktbg9OBEwCovj2FQb+x5J3JRGHqavSRZP2geRmHtO9Qrcr5CbOCr2auAU7bElmsBeqj0ouFLVW7jIaSzNcxoHU16QVuv96L0U5DXoer/zvSCvgULCCqJXV0d6B4buKKXt0A4aXTpYqdIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIVLO9jo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIVLO9jo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF741F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791470038;
	bh=3feMI/nw/mNRl35p+kbOpFFmobIe8fD7ELeZtsBkFls=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZIVLO9jod+HiEeTAWpSO0SkhdER8Q09mZZcILM5yJP8q90fRsSojRVxRnAlqF+cxo
	 UwksD3YOhWMx61C43wVkyolE8/qd8F3Xv/foONMt/0XuoW9Iwl8WmDfC2NujuEnzXy
	 odt6U9Uy1xQA7NggSt8KxtDvMrp6H0dGxQEfcY/XIsahscXpfrlgOvGXWIoUMnzk2e
	 a9V7HtBaQRJMvDtmJQMT15OIJsQbbzr9ExnE9ptq6TZB0uOfFOxFTST26lHpJsGX59
	 7fukXL3HPOJbyr7ptXDBN2eDYE/pyqjhbNn4/ew8sM3RR/Tk49LsoyCqn4sI1rR7n+
	 X7eCcA4V46b6Q==
Message-ID: <sashiko-outbox-164299@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 21/27] selftests/landlock: Use _exit() in the
 named_pipe_ioctl child
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-23-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-23-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:33:57 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> In the named_pipe_ioctl test, use _exit(2) like in other places.
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D21

