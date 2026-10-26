Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793020368;
	b=0CyhnnEjzR/UwR2XRdwXOb7nSj90Jtdq+LQOsN+t7f3dDlnwpQO6sQjrTysiCq+VrKMs
	 u2ypYzDkd39jM8vTT35aJubwCX9maim0ctsLoIKttC+utViCcV0jbjqIc3KDwQ28A/UG7
	 TlofmBKapCmtFtFq7Uz/e0FuGTqW4FbmjBJi7YJtnnFjgp+pAheonfoF+M9LVLhmtmc+d
	 bChnVoZBwQPCV38UmM3gj6uN8BxV+Crp4yLVLCPG9i1S0s1GzEkfj6TpOAFgUy3RX0FtB
	 smeqlJw1rWR/nfYefrAAXG10BtTN3rWVe6wyF9ncXoTSj4XWQHnljsJ3sCdyvtUBNWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793020368;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FG1NxqPOjfWBrS7SpXSQmgWNo842qEEKqjVbtJSjeMw=;
	b=bYY3R6/zcfpXL/z5zrBotjbqWgIs2y9T6FlneEf92Dyim/91THe449aGs9TmJgtoEdTy
	 qKznMOyv5CdjNB9zSHRRyAVj+4k4pnpo69D8ORFYUEJ93zDxv2eEkhF2xfk8FA4/nUfl7
	 z3iCct5yarzAd7L1ibCvtdewA5v5iAGI4XdW77dDELkQxamXy1HP9PwgeNMLkgElsolax
	 mLJjP4hwNoqrvramMWlWvwM646YzwF3OorcHrkIqZPGJOpkoqZa9RtgtFcJC1QMIwdy0n
	 B1K6d79lkFKz9ELA+2aLWNbttXKnGYB92LOtuQz6IIB9YQwPBwq2/srPgmNqeYHnOag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hlcMnwvv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8967E606A31A
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hlcMnwvv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146231F01825
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 13:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793020368;
	bh=FG1NxqPOjfWBrS7SpXSQmgWNo842qEEKqjVbtJSjeMw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hlcMnwvvpmFYrlVWk/7ev6aVba1rN1Sh3cbm3IH+E1bN6jokKlDD/pRAnWjF9OmeL
	 MEYHtQXIT4+Yo/715/4wRubFUygqa37cN+HfPFBNKsTOeaeFBIN2REep+A38sckudJ
	 FFiuyQrkZPabLNJsqKNgqw8j118dCgyGLVNyxQKwABKbnl+h5iyF/kCBxCJJyEYQ7R
	 DbAAzfGXEqXFDkBn7RsAMXjAQSxH29W4jfc94wXZnzesOli49DiAk/i2RGzJdeNkAC
	 P2t6vApueoc3kUq2YEu4IGkPLnRhi2BK/hSeAxmmtnoSvygIv8eIg1CIR7JhF08Lh2
	 IhyLgGNkeFJhQ==
Message-ID: <sashiko-outbox-185286@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] security: commoncap: drop stale CAP_FS_MASK FIXME
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261026131010.1822069-1-adrianox@gmail.com>
References: <20261026131010.1822069-1-adrianox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 13:12:47 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> CAP_FS_SET is exactly the set of capabilities that an fsuid of 0
> historically granted (see CAP_FS_MASK in include/linux/capability.h),
> so cap_task_fix_setuid() drops that set from the effective set when
> fsuid leaves 0.  Remove the stale FIXME.
>=20
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026131010.1822=
069-1-adrianox@gmail.com?part=3D1

