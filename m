Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795214698;
	b=WOd5JMzgpm+OIL8HaYhetNfaeyRknWP1lr91kwnOlRiJacaPRPFcTYEbvxn/ySnflx3H
	 YvEY4ZUK2hxkNYlopsyW5WUeKJCuwNd7KohivywSVJPzLKzudfm4GM1Dpadq8fjwyhJ3j
	 ++m0dZhejNf+eiB6YpxvSVFZNEOSezdTtAMuJmgXS79NQh5mxNse5Ekw5DcTzgOQXB4vv
	 Vur1ppUDbY1Hdf0JaSPDNbPf5D/O4M90aAPU7i1D4Hij4WjjiS8vIt7JBD8GtDqoWnqZv
	 ffovgt59a7QnyoZIA7IY+xT8dNwu7lmoFQokkb4JRntUt3g/Y1CRAdzFabUgdYHvXmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214698;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Emktz+J0LQVVB3Ex3dnIkWz+sXyCeOkHGsUDcq2qJgw=;
	b=4vgdUyZe00kFxZjKatbV/jpQyOoJ2Xpt4GQDY3gMedLUh8MJJyFcnZGjItnKSBX2YGJK
	 jmBJhG5ambLD0VAoyrxDhMDWtI6WJogGapBVFOpkXCcwQYok4RR5XAPrTkfj8Tit1DkKm
	 RopDKk7go5SyCcaV1WBKUWMdaA/F5jnFCp8llRrQSXzBVzy11+Bju8UfFD5LciV29IUoJ
	 mY0/ohZKnXXQO2MAq2CRKR1Ymty3QhIMcasJAYyYD0sJf8RUrJXl64bU+scDGP41JWtBs
	 uqFV17oYeypsNhzi1S9aJYK2R3xMOZS/N110gYEI9W098tnPzrleX26tNYt1lPj67Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BUUqAQ/O";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D13606A6BC
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BUUqAQ/O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494EE1F000D3
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 22:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795214698;
	bh=Emktz+J0LQVVB3Ex3dnIkWz+sXyCeOkHGsUDcq2qJgw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=BUUqAQ/OAzbJrb0jatMoRahLG7dCm58Ko3Y0VYFCPxt1VIAukwo6ixgUMc5YJqCwN
	 f80DbHPj/T5odRD4ITmnt/NDkl9PgET9lx71oJrJO8WSG5jmS3pHC0d57AWyI4amVg
	 8+0MvAIxvWjHlZ/sRRkpxGL2MCHArxU4Dr08JuLqGtoZbgMKc+YMuLpr/cDMBxebOd
	 1sztH99ehaZ8xe9uwyw722j/zrvcpopGcqKag94x/fF5vBXtDuV1Z9ILe8lgFp2ibY
	 lxPWuuXZLeGw3CTwn0bUt/wNerha/2Y3s9p9+RiBGCjgABymasFv8YTf31uRO5coSE
	 //KCZo8abtxZw==
Message-ID: <sashiko-outbox-226306@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v4 00/14] Namespace for namespace roots
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261119224312.1037966-1-jarkko@kernel.org>
References: <20261119224312.1037966-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 22:44:57 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 14-patch series:

- Patches 1-4, 6, and 10-12: no issues found.
- Patch 5 ("rootns: Add ROOTNS_WAIT ioctl"): 1 potential issue (1
  Medium)
- Patch 7 ("fork: Support CLONE_INTO_ROOTNS in clone3()"): 2 potential
  issues (1 Medium, 1 Low)
- Patch 8 ("fs: Support FSCONFIG_SET_ROOTNS in fsconfig()"): 3 potential
  issues (2 High, 1 Medium)
- Patch 9 ("fs: Support MOVE_MOUNT_T_MNTNS in move_mount()"): 1
  potential issue (1 High)
- Patch 13 ("selftests/rootns: Add root namespace test suite"): 3
  potential issues (1 Medium, 2 Low)
- Patch 14: skipped (not reviewed).

Detailed reviews have been sent as separate replies to patches 5, 7-9,
and 13.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119224312.1037=
966-1-jarkko@kernel.org
