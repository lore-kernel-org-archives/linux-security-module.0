Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177949;
	b=CHqTGts3Vn0iYUEkkxTHODaCT+zFy/00ORL5bsWc06jk5sNMC6ei21JSHWy8cpPwqHXM
	 8DCaNiXVJG3zjSKnQ4UQRX80mwD88U8n57ZX/xKFrbXrx4LxwhuorZGxCKqyHTpEjPR9x
	 o/sTHhIX+Jdv7ebjVGRUZSdaoISSYYUQP+R1BfH3Ju4Ih3wdyWWiE+k8m77aKQyKIeViS
	 5uVQyiKSWDDpnAe5YlNKSaWryl4is8zHdRxNVJJ63/Axm2pUXvF5MLENzbCYEDotq3YO6
	 vZW0XKMjvhPWfrkLReQo03N5t8ua7qEHER5XL8rJred5JZsJBwqyHshUc5Zsg8sVm5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177949;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UK5xeADLNC2TeOtxq3qoAwgTUA7V289TGUGGmcouubk=;
	b=SVKJ96+yQRdv+2rSUGsygnd+ir8c7MH7JXXNZo+Rmjxn9yxGHNO/1Wbmvs9o4pqRXfSd
	 2/6GXs0My4vhhoDpCHguKVPisPVb6qOK2HWTjiS8DxhMWnF7KHB9VYh/wsJeWR3hTxJsw
	 Rs2wbdXEMzZuGrMuvcmF0YlNfk7W+Ddpz1F7w4XNcIXnIOLhtcyUIRJHAiv0QE84UE6OR
	 Vkm4hWV6VTRe0k80zGwlpZQFNzX0yDxF5urXVlJIIBk/KQACLReqI3VCfyRxUIMtQPo5G
	 T9HUQsjlu7/wPYw2x5fCeETpv5Lv5lw9+PrtAehPU6RLYEsyinyeK9pPAjH2x5duAqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TI7RQp5/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92AD606A320
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TI7RQp5/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9281F000D2
	for <linux-security-module@vger.kernel.org>; Fri, 20 Nov 2026 12:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795177949;
	bh=UK5xeADLNC2TeOtxq3qoAwgTUA7V289TGUGGmcouubk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=TI7RQp5/ltoaQ3ZnBCikL3cofNsSsClb54HXUV6FcwaZqMoswSroIcvTAJJktL4MK
	 amv+91atc/CwIeY5WaWYfg/QCgL9KHVW1STvI6i5mAzvqkbaVv2m0B4H3LmXYed4Mk
	 h4OkjczN87zkLAYIRgXtf1RlkXacJ/h6jJ4VLskBjxd3setWeywYDP6hYK94q6oI7U
	 z93210acU5hBrxlJzwY99+/c39JYwsf1v7ATBosnnnZmLeRNfqNNDosKgNLTQ/Z+sJ
	 cVI7riDF0Zv2BN80Mae1Jn1X2a0Dp1T9Z/VQpPNSl/CDfKaoNTpN5L9xtZfUQUN7mf
	 medlsbrxPOtYg==
Message-ID: <sashiko-outbox-225145@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] mount: pass flags to alloc_mnt_ns()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261120-work-ns-mount_subtree-v1-1-06337377f94a@kernel.org>
References: <20261120-work-ns-mount_subtree-v1-0-06337377f94a@kernel.org>
 <20261120-work-ns-mount_subtree-v1-1-06337377f94a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 12:32:28 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> Turn the anon argument of alloc_mnt_ns() into a flags argument. The
> next patch needs to pass another property of the new mount namespace
> and two booleans in a row would make the callers unreadable.
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-work-ns-mo=
unt_subtree-v1-0-06337377f94a@kernel.org?part=3D1

