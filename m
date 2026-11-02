Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585956;
	b=Kjim5Ss3sL1FvfySq4hxRVoeB2gFSJMyPW/JYcfRrZL1IKbhXAad+wfSaHhG6wIictba
	 kUpC2DQBC4/tpPJ98qBWIM0nbJIb1dF3kAVndZnzBtpPEpz2dxSWgU05SeM37zElEwzyy
	 2vo+FTa34SawUKkTMEIts0G7kcSK7Oeqah4lbSIqBzhIEkE29ut5BeFDIX46vCS1E6l4G
	 p2+1kFhrAgiKUkBDkPgJ4mG54w6JDDn0MRf1HYQAEEIU7KO40LA7lcnhlyIRJWa+rJOx3
	 l6Tsuq2Q0BIUelmuonZuxMuogBhaLWIEkbremksxSvJSVxYIYiw+/a7qC8sVo91VtQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585956;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ksb15ZRLTpUb4X+QYLwUZIYX+VY714XCng08OzcrYO0=;
	b=tDH6C0rioo0OUHuBSkpDdf7pLhpnKOV/flWKQrWOuo/jeOrsVOdweXzZIXZy41Hadmoc
	 0fT1GXaxZEI3+KZJl6GwqNE7M0n24utPDWxNLKmPProVO9lI3wHi2Jf447XCDL78YuDBx
	 JCSRc41FWU2BZ+Xydy128vLVIbuVSi7QA372xnSH/hdFGgqO/CajYYVIE9679i8SMSjgk
	 Zk1eP8YljAIQYJAA+SBYS0IuqxnYplcA6eL+4/EfRByHoDCJkPNTk4GLXWULcBeFVMGTV
	 uFUO7aZNIHLddLKeRvg0JEZ7e0+YGCQzB6SbNksK16uRqjSa6R/X+EuCxpz30qPEtLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQDf28q2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5112A606A324
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 02:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CQDf28q2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1A01F000C1
	for <linux-security-module@vger.kernel.org>; Mon,  2 Nov 2026 02:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793585955;
	bh=Ksb15ZRLTpUb4X+QYLwUZIYX+VY714XCng08OzcrYO0=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=CQDf28q2asGjsmse709l85qnNY+sq3qOOUswFytmvADbwSLxoNwkV605VVqxdy2Mt
	 B58qwCpDTBRBKKjG9XbHaXL68AzVUCK1CPES6kdiaoF60ax0SzvvSd9dbcDuqiXwgO
	 rkhSbQCD1OIsLYKkIxQUUWX2cpPyf0mV5fGxHSxte+KF8vciY0LAmXxG7sLQ2Qaa5r
	 wRGKjNvGVE0pzBLV5W/H4+G6HC2f7KrBuVy0VbYJ8uLpnp+pWbvaCkLxBdLIJm5NzM
	 0zrpLDv392V96F1sA2mBRp/vo9l9/616OQHH+wyAE+iGttXWwzEEBtiS4L2u3ZligE
	 lFb9bW5teKYCg==
Message-ID: <sashiko-outbox-192826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ima: initialize the real inode attributes of the iint
 cache
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261102024703.816178-1-caixinchen1@huawei.com>
References: <20261102024703.816178-1-caixinchen1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 02:19:14 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> ima_iint_cache objects are allocated with kmem_cache_alloc() from a
> dedicated slab whose constructor only runs once, when the slab is first
> created; the constructor does not run again when a freed object is
> reallocated.  ima_iint_init_always() resets all iint fields except
> real_inode.ino and real_inode.dev, which therefore keep the values of
> the previously freed iint.
>=20
> integrity_inode_attrs_changed() reads those fields in
> process_measurement() to detect changes to the backing file on stacked
> filesystems.  The fields are normally written by
> integrity_inode_attrs_store() from ima_collect_measurement(), but the
> IMA_HASH path sets IMA_HASHED without calling it, so on the next file
> open the stale, uninitialized ino and dev are read.  Depending on the
> residual values, IMA may skip re-evaluating a file whose backing data
> or metadata changed, or needlessly re-evaluate it.
>=20
> Initialize real_inode.ino and real_inode.dev with the identification
> of the inode the iint is being associated with at allocation time.
> On stacked filesystems the first comparison against the underlying
> real inode will then fail until ima_collect_measurement() stores the
> real inode's attributes, which is the safe, conservative direction.
>=20
> Fixes: b836c4d29f27 ("ima: detect changes to the backing overlay file")
> Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102024703.8161=
78-1-caixinchen1@huawei.com?part=3D1

