Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802483;
	b=SW88ZbYh34guyd5aiBmJUIiesPoXLCSq1pPlvbL9HCYUiOjQQTo5MCGqcLpcVpOkwS1N
	 5mzjB8906QIli9JgpH6dQlbEO0YmXP4E65CXSmxRqLnMlCntrY80A+h3pPDjlbRjW1bd8
	 2udcd0dHXHivYB7sEVA+++jcSNec1m2FQPEpUcwT96+oSqosm2FQIgEAvvT6v3rc/MZT/
	 ZdH78wQ++qNVpj8KlKPS/b+4gUij49MpBVwCaIjjM+Vqpu1a3lB9T+TxrYjqxz0osp2D2
	 u0qHPsuId4nSgjgCO0b3vJ/yupEK66O0WlTmvG+49mVVwmvgz6RI2IGukjybsBXw9Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802483;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OYSPCaBzMkfb2mAiMZjut7V9po11C4dM4B773ZJgUUs=;
	b=1m6f5ISUOFKVQgGuhdm519MAxALo0LVvg4vVEtfCsrb4ujcMoelDiNYqa2c1R04US1p7
	 eoVxOh+u5ZJjAouXyfMLogeRwJtnO3k4iC4B9y17IuPfUTN9N0dHDRocPsIw3Z5Ibdlmf
	 nWyO4t8X1Y4Nsa0qHCmZ7IJJnv/28Fl521gBGCKi0J/tKn3qpQQ1Kt8KWtEHfXwOQqwvf
	 UfwKo4hhxYOZznZZEXP1k9fCDXHpq8mLmP3fyEgCrVtLZbT3/P7sC8qbRpLnkngUhjlwM
	 5d+0iV3JXg0uOI97rd8GsqsQO0K3b1LBM9URGygZki4soUHG96RGglR6aBIaFhJyoTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=agD8Fb7S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD00606A326
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=agD8Fb7S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279351F000C1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 14:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802482;
	bh=OYSPCaBzMkfb2mAiMZjut7V9po11C4dM4B773ZJgUUs=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=agD8Fb7SL2epKt1oFnxWtLJQcKfocpRqQBcz9K3mSne7DTHfwqRwgDg57RmfUSCpq
	 VF7AliRRIz6zYG5m1ltnIz3/+xgIKaxxStMpjgLJNRmjUC5wxe9/36CMgUsoP02zYz
	 u46oBkXBf/GLTbNUibSRlNqgEb14lSn59YE3IoVt4NflgqluWFBMdqrpK0E0cgjmKZ
	 wulTj/hdWkMquH5xwpLBl5SZiqN5RvRLXqRGXM0G8zNxg5oju+A5ETl5WtuATX3GJW
	 oPeKJ/l+da+HBStT/y1F4nrgtby1MsAAGfg5vMe5YdB68LjQpCbDi8+X9TW9oCvUqY
	 iYqcelfJASeXQ==
Message-ID: <sashiko-outbox-197432@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/13] sys: use cred_ids_allow_sched() for
 setpriority()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261104-b4-cred-ids-v2-7-956213608f16@toxicpanda.com>
References: <20261104-b4-cred-ids-v2-0-956213608f16@toxicpanda.com>
 <20261104-b4-cred-ids-v2-7-956213608f16@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:28:01 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> set_one_prio_perm() makes the two comparisons of check_same_owner(),
> written the other way around. Use the library.
>=20
> No functional change.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-b4-cred-id=
s-v2-0-956213608f16@toxicpanda.com?part=3D7

