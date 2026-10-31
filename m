Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793439203;
	b=43DY9gtdKuODBPRCxIfCKGrk6MuCLWrlAnCpyepgaMhpfamyKSv8d/cwC9zANuisiGR+
	 DtgVUx5uWHSlxUtfr5ML6RtPFFKSmtVNPCA04QH+cLbK7zlVx1XWWw46anZCLrekNn2uX
	 +ccCalVI1sd28DD60FAt9W8US6EFsS96J0vwvCmpLTw/qJUslMDpwqLyAzCHl14dcQaDd
	 0VdcAlMVotFehhNJlq2qk3ftWuN8Hnybkmxs2wVlV8iNmRpb07q7xTgmQ2gMgRr78yHkM
	 FcEdAtIKuue8ObXO7v7lISjGYoaiphqZGfKQhNQK8/ElHwIPS9cvCwM78jo2AJ7d+wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439203;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EPbPk2rFgfqnclTHZzqs8a4qj4IMScH45QhE+gx1RdU=;
	b=pHEUu2v/PPT16KoGNsWGCGS2je20Ads1JERUUrydmODpDnO4NsyDanLMNeBIYnGtqBxU
	 6Azh27ixFnFqdLQPZg4woMppdXnPMKs6GV7jqJA6OgujEO+wijLOD/E9ca9/1KYkR0Pgj
	 Wo0fW/T6Ncj5HaqR1SiPP+Olc2X0pVBUU2uoYVbVsmKC52p22qreiNBUiUDM1bB2HMgQW
	 yIh0cSWLAYertPontC4euW9ck/tk91DZD9FBl9x1Aql+sLPc4EcqKp6/ChWW1L38YyJoD
	 8tyVcPGlLyeaEbf22sXVzoqvR1W5jLfch+2f0sZXW23BVK+9+A/JgKoxph+a5ZUEjgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2C0Bpxe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C497606A31A
	for <linux-security-module@vger.kernel.org>; Sat, 31 Oct 2026 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i2C0Bpxe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC101F000C1
	for <linux-security-module@vger.kernel.org>; Sat, 31 Oct 2026 09:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793439203;
	bh=EPbPk2rFgfqnclTHZzqs8a4qj4IMScH45QhE+gx1RdU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=i2C0BpxeqenNUXHCK0krCFJGORH5cA4rs90HYjZduu9VZFKArvD/Yvz1ZHspnIxiw
	 uLD9zX2z769IfG8qz+5OZ7pRiwI+5fZNg22NmUbFxhmpnLFlIhj5g82f5iYNCI6kYm
	 TVvEJnkvt5bX5Q2UMAC/jnla9oJcIyF8oRfA4oXCQY1TLan5/+ahRw9vX5mWfvqI5S
	 VHqGSXQyhHQhfbi7xMw050m7ECfrSQiPAKM4MFrO7nBJm7PQAuCrb9qExE95WCjwB+
	 QXtjyaesMAP7cNpJXK14ZYvyiy4asJSnMqU+oKrrYlYmMGpvyiBBtvrYEqqB+gveY+
	 a+4fNGRa2Y+fQ==
Message-ID: <sashiko-outbox-191873@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] keys: Protect the update method check against type
 removal
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <pm-keys-update-type-removal-20261029-v8-a0dbc48c588bf2b6a278@gmail.com>
References: <pm-keys-update-type-removal-20261029-v8-a0dbc48c588bf2b6a278@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 09:33:22 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> key_update() reads key->type->update, ->def_datalen and ->preparse
> before it takes key->sem. A reference on the key does not pin the
> module that provides its type, so KEYCTL_UPDATE can race with the
> unloading of that module, for example dns_resolver:
>=20
>   KEYCTL_UPDATE task                  Module unload and key GC
>   ------------------                  ------------------------
>   keyctl_update_key()
>     key_update()
>       key_permission()
>       load key->type
>                                       exit_dns_resolver()
>                                         unregister_key_type()
>                                           GC: down_write(&key->sem)
>                                           GC: retype to key_type_dead
> [ ... ]
> the preparsed payload has been freed. Once a key exists, only the GC
> changes key->type, and it does so with key->sem held for writing.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/pm-keys-update-type=
-removal-20261029-v8-a0dbc48c588bf2b6a278@gmail.com?part=3D1

