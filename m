Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1709C3EA960
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 06:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791525653; cv=none; b=PauUntk9q1cll+OiBzZeCETbeVhy24HifD49rBXvQGsIdU33TpsSHvAiYpWXAM9qENRc0VIWTxkfxRzN3kwaIsHJmo2nTfNa92AkEm61ZEzo6XWCrYj2+SzdnL2nvUNiydE8ffn3bVQL6326bjAxwZ3nvT5R1TqsEeNYKaEEKrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791525653; c=relaxed/simple;
	bh=uQeO1MygvlppPWi/u8DTotuQyodT7fUiVEJ8pDwyuOg=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=p5hejjca2dbNp0xdsRHudv3WHqg5TvQ2zv6kwKRWIHiiYpnLbk51k5JETzPhPA0dhdpJ05hm4ubHcalIMUbUPPmJRrvbMe5vxcYe9PpymbxP8Qf3FKJwohN2/akScUlU1uNyUP2327Q4G7fB+ar2RtuKDWDsIZEfB4XvSRPbTPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgdYKpVC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgdYKpVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66241F000FF
	for <linux-security-module@vger.kernel.org>; Fri,  9 Oct 2026 06:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791525651;
	bh=Y0jAjBgIlPKbYUOLGs28wmm8oWK/xwKtEvubvmso5OI=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JgdYKpVCnWpycfl4MQ16k+mjsuCibXEVf1O5CL5XNRTQRAlMMa0dWLVJsxmeOfdZK
	 WmjFN/JsdAF9HFvocbHH1k9hkOaQ+qXV82DFdH620V9zGNXusAew9k4DeFek+nMklc
	 W1ow2xydeFdcdXTT/Skybz8QW99wX1t2LqO9MITL9YZPgcDlHAuZ6GwAj7EfRgH1s5
	 ISqWvEmqfMMcZh4s6FBMROUsCtmz6X9AQSUdQroKuxe2yMYSPSId+Q5ek0xO0hxt2I
	 G77hmnQW90a8cigCRr4UnmfvB0jaDxfLbD0QFFW3xuj5BeZIiv5g8n3h7zBcytIAsN
	 srTpNA8daMR4Q==
Message-ID: <sashiko-outbox-164911@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] keys: Check the authorization payload in process
 keyring searches
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <pm-key-management-objects-candidate-0004-v3-598361863b76bc25d58d@gmail.com>
References: <pm-key-management-objects-candidate-0004-v3-598361863b76bc25d58d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 06:00:51 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> An authorization payload and its saved credentials must remain valid
> while search_process_keyrings_rcu() searches the requestor's keyrings.
> The function validates the authorization key, then separately loads
> payload.data[0] and unconditionally reads rka->cred. Validation does
> not prevent request_key_auth_revoke() from clearing the payload.
>=20
> A request-key helper can assume authority and fork a descendant that
> inherits the authorization key. If the descendant misses in its own
> keyrings, it falls back to the saved requestor credentials. Successful
> target instantiation invalidates the authorization key without clearing
> the payload. After the helper exits, UMH_WAIT_PROC returns to the
> requester, which calls complete_request_key() and revokes that key.
>=20
> With the descendant paused after validation, the paths can interleave
> as follows:
> [ ... ]
>     RIP: 0010:search_process_keyrings_rcu+0x32b/0x790
>=20
> Fixes: e59428f721ee ("keys: Move the RCU locks outwards from the keyring =
search functions")
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/pm-key-management-o=
bjects-candidate-0004-v3-598361863b76bc25d58d@gmail.com?part=3D1

