Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9E64A43F0
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469905; cv=none; b=e+aa1/4kWFSHWCJlxDzBOdax1510+SthjUkioggfVrb0jqJDYJ0cz+YvK9vzqeb3eE64x+gnHUPbZwGrDr2IBWmgG5RjZk9E9xqCyT4WjdUz3tsFbukTuXbq41ocAnSVvcURFxfD4EVi1iVDN/ntUDqak9zVEC1GVPF8BaxwVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469905; c=relaxed/simple;
	bh=tSGSHKtqOIAgOFBnHSHV1fsYhhSLzDu/ZopFPsFJ9Gg=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NPwU6KV5jUKFsIjZgLXWJZoGjsKtsVahjlesQUKx90m1DssscOC7UdnTqmdo8RNVDxj6wtR0cJSEGs4uiWG2FLq9ua//plfbDvFLT/6IjlNWf3aW8lXj2xd1wYoDTgfpqP20oKE85Itap4HWmh0Ps3VL5yLmGhEeNgfi4z5ILk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrhuPWtV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrhuPWtV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3391F000FF
	for <linux-security-module@vger.kernel.org>; Thu,  8 Oct 2026 14:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791469904;
	bh=lW0A2+yz5mN0H8ND6MsNipd47jNEfLvP++kjRol6LEc=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=PrhuPWtVLucUalBPyoxtHRw+EJSujqK6ODGjmAF355oAfEGA2R8agN7jc+8FvXp4z
	 HutHiujdGl1r7933jYZhwFFaSEvwrq56G9i2lF29GZnTNqlLgFyD15oaLwhLPk7eM5
	 HR8spysxJtC36SH/AxYZCeMF3PnIFxpBNDr2zL7nEUsmkw3alXxRkJMwRZohji7tor
	 6pK+jle/gdMp4d2PA3oYTO/VfkZnqQcQ6TN4LHWZg0ZwhSkcAXPAxt2GShTxNhrxtM
	 fmC5Z07O13jq9LKTstJsLEenoUR+6Fu4EOy1HwT47Jz9ZJAymigWi71+E6PJYf42Sp
	 1KuXDuRae8yHg==
Message-ID: <sashiko-outbox-164286@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/27] selftests/landlock: Handle a missing control
 message in recv_fd()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261008142604.39107-10-gnoack3000@gmail.com>
References: <20261008142604.39107-2-gnoack3000@gmail.com>
 <20261008142604.39107-10-gnoack3000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 14:31:43 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> CMSG_FIRSTHDR() returns NULL when recvmsg(2) did not receive any
> ancillary data, e.g. when the peer closed the socket without sending an
> FD.  recv_fd() dereferences the result unconditionally and crashes
> instead of returning an error.
>=20
> Return -EIO in that case.
>=20
> Assisted-by: LLM
> Signed-off-by: G=C3=BCnther Noack <gnoack3000@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008142604.3910=
7-2-gnoack3000@gmail.com?part=3D8

