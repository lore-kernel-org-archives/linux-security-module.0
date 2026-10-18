Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6C73F0A9F
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792345062; cv=none; b=IhB4UHAva1kX75AcLd4baDP51/pFvWhhuPl5hG3IFE+Gl2k9Y2qk1DRQLba3Ka3r8mS5eokblDU43jTUvC4lsOV2ddtfTmpKZUVBhVtg2fNtSP/Ylzf/dnfdyUGolwlLQJZwO1lUgFPWYfX0tTXBTZVpN5m9PxQ+X1NkH/ShmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792345062; c=relaxed/simple;
	bh=jRguDMTjk4HghFcAfUd7HKdGhxuc0PzNMKPrreNO+7E=;
	h=Message-ID:From:Subject:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fhGZrUm8wybjnmyG9MR/GLKUn04IWh37ESVSySNmZnPSswggc7LSWu08kQLkBuz3/x8E3dx1+WFnJXcKqzGOyFzlMmUGCYlJuzmHmEz39PwMVfC5WaUHj7hYsQ+6KCr4aX2b2JqdqjzFhWxXnNNUUFDMawM2z7j2PCUF8051YUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLXTmMN5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLXTmMN5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98D11F000C6
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792345060;
	bh=jRguDMTjk4HghFcAfUd7HKdGhxuc0PzNMKPrreNO+7E=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=FLXTmMN5wTohGAi1DVi5M6AghGBsyz/2IhfFRlWsQAsKN3trPYBGc7vJafUVbMGHY
	 YfLsCe5/+cfCcmYhfylkQP2reM598hoGxCJ3c5twvEstiPKthLqBQtJ0X54owxDQxn
	 p8cW6vma2TjMiN66OeSTvDkePg9PEW1BWo2mu9OISSX5DfYRC/9Cr0ivOknta2QLG9
	 qN4JDz6mexg+nCoEbkbOsgKFVoMApEz2VrTxgyfjHOR38izmv4fqn4Oo/u2Le13V4D
	 O+Ipqnqm8O0uJNGUEaAXPN8Pfwqu2iUqlAw5QVlnGHiOMSXOYMA/sIYzsiOJ849P9P
	 lVwJChDXwIKDw==
Message-ID: <sashiko-outbox-176329@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/13] fcntl: use cred_ids_allow_sigio()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261018-b4-cred-ids-v1-4-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
 <20261018-b4-cred-ids-v1-4-7bdf2db4ea9f@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 17:37:40 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

> sigio_perm() has the four comparisons of kill_ok_by_cred(), and lets euid
> 0 signal anybody. Use the library.
>=20
> The library compares credentials. F_SETOWN only copies the uid and the
> euid of the caller into struct fown_struct, so keep a reference on its
> credentials instead, as struct file does for whoever opened it. That makes
> the sender of a SIGIO a credential like the sender of any other signal.
>=20
> F_GETOWNER_UIDS goes on reporting uid 0 for a file whose owner was never
> set.
>=20
> The credentials now stay around until the owner is set again or the file
> is released. Clearing the owner leaves them alone, as it left the two ids
> alone, so that F_GETOWNER_UIDS goes on reporting them. Who may be
> signalled does not change.
>=20
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018-b4-cred-id=
s-v1-0-7bdf2db4ea9f@toxicpanda.com?part=3D4

