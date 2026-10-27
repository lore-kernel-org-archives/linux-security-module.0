Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111637;
	b=P3YDrWQgJV/Z0V6JpERIMSQ3+2eTFHfMV9okX0aoaC08MRejaHpmQxXrhelcDQ0CmWKS
	 7YJXqILNB9A45PJIbzAvckxTHhG+2ozW6jrED7fnHvOeu69sO0dgknMralLJfwbxpU/0g
	 7YlzWUkbUhxqUI4tNFPlNiHwn8+VDCPKdVF1qH1sMgfB7muofK49N1F9YpFUGB8JDdpB5
	 whkfWkM5dlLSb1s1Xu+/xpYSBIjN780ZOMUMAfklWLxSOIdCh+luiejoT8NB4YKZoRxmD
	 O99MuMVxLwZhZvSRL9AgoZe88b/E7jByI2BUlOwBaya3Muf/THzIF0aGifnsHL/aZww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111637;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vYyTf16O0CGp54PNDPdK5TyK7xaNoTXKiwT2eMTG//c=;
	b=twtMMaOWb1c/V+3hFLL+DlNJaeKQBijkQd5uIOn2p90/9P3Q88eC+obxmo/2ieiTRBMk
	 iTgljTeBr0ONlhsqDLZ6YY0bpQg878Z0M8UKDn2eJCaeDZdrf3SQRbFIvIl0HX6IPqd/q
	 NAjs2VPprBlCEqqYtLHhB0AsmFD+aXT7bORhxur1Uef+TUAer0fkK0oO8RR33KewXlRye
	 B3HOUBoHHTQLdz0ATP3DJqktleopY1kLqVcGlds7wBuJ43hNo015kxdBPM2TEmwkgBJvq
	 8wqZcGVPjaIPS5txCam6aQlEOI4nNNlrCcgU+79o8OBGLy32rBJ77mWS+/I+pdsMuKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iAfIvyJX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52D8606A31A
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iAfIvyJX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3099E1F01825
	for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 14:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111637;
	bh=vYyTf16O0CGp54PNDPdK5TyK7xaNoTXKiwT2eMTG//c=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=iAfIvyJX/WdGJrwuLfiOMzg5LRsopaT+fGTotC0SIwgMtHRoKblioAg2+4e/7Af1/
	 SMv78jyRa/N1UL1+R/aSQRfiammFkAyh9+lTi/TkgFV8s9vyGtJu97Ep+bZFeGILWT
	 EyWiuK1KDEV44dcitVH6hESkP/JMFkJzw1GblsHLX2J3g8bSSQ3L2FgbvzhCuYJq98
	 Avke0HJ5J8sn9XdYUXibIzRcw+jhE3hmmFnV38U2HZk+isloN6DA+fQtjE2lG+4PAO
	 KClisluKsuc0e9M1JBtakJH4MnlIW67M/ehqZIzvrEKyljE4Kip9HGGO7t/qxX/pGb
	 Xg08eowfZtzyA==
Message-ID: <sashiko-outbox-186727@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/6] userns: record how far up CAP_SETFCAP reaches
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261027-b4-setfcap-userns-v8-1-2674adc63f3c@toxicpanda.com>
References: <20261027-b4-setfcap-userns-v8-0-2674adc63f3c@toxicpanda.com>
 <20261027-b4-setfcap-userns-v8-1-2674adc63f3c@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:33:56 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> create_user_ns() records in ns->parent_could_setfcap whether the creator
> had CAP_SETFCAP in its effective set, and verify_root_map() trusts that
> when a task in the new namespace maps the parent's uid 0.  A bool only
> describes the parent, though.  File capabilities belong to the kuid of a
> root user, and a namespace that maps the parent's uid 0 shares that kuid
> with the parent and possibly with ancestors further up, so what matters
> is how far up the creator's CAP_SETFCAP counted.
>=20
> Replace the bool with ns->setfcap_level: CAP_SETFCAP held in the
> namespace counts there and in its ancestors up to the one at that
> ->level.  cap_setfcap_level() computes it from the creator's cred.  A
> creator that holds CAP_SETFCAP passes on the setfcap_level of its own
> namespace, one that doesn't gets the new namespace's own level, and the
> initial namespace has 0.
>=20
> verify_root_map() keeps checking the same condition: the bool was false
> exactly when the level is the namespace's own.
>=20
> No functional change.
>=20
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-b4-setfcap=
-userns-v8-0-2674adc63f3c@toxicpanda.com?part=3D1

