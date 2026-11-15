Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794751925;
	b=Mhnr/bFBN87MZ/dxbMl2TfE47HQmyNAkjL8heRnK0zWUxGLiKq1TaS7lnKAdhyxwEGyJ
	 oDVOWlPnDUpl9LeWLM+v3yNMIhkbwKufwVbmOum3OUScv1x6m638MwuhwERq63zOu7ACs
	 CanYcNf0Z3yu21xa1Ty09w/3vmVX+rF+NC20MdYxppplKX/1KxZNraG7DctSQbcA7DX0a
	 yuh5c27gMNwK2xdr/DmoqOrxXQcZRFKW/kTldry/3mEDhkMshSwqivrEKUPPsFlmnxKbm
	 qNTjuNw0Irzsf1Bb/sHzpAHoQmavcQRD6jutIsLKPamJUGO/yq6gnHKoaaTx+JAfPIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794751925;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Tz0uIh4/QIJLKFaoD3++YDHz7sTkKxH5cLZjnh26kVw=;
	b=aD4R2qXD8Y7uyWdqO5oPk62LpfG5uLXmTXf5AdzymietY73+ZGe8drv4QIqYkcnlapm0
	 4pDozDL44TToduWHosaLZIxbioevsMZ72G25TGC1/Us0x91la/1NIf/4vXSAACHfdPGPc
	 yaluOHoGQOaX2qtqq+ymPdIybPM5CnVF4KqzRhvfQ5RNWp6DX7h+gm8MYF/Fw7/L67Ohr
	 P7VCz9q3hjh7zww63s3zYe6G7SqmOyxwsE+MajjRUAjvtgTh5jo4+2hpFbSR33Ms1lI6g
	 yGz0nDmOydIK3lJpsEdKFfBdb6EKkeG+h+0Bt26j8GoDW6GKu6wh4cOcPj2CAke8zjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBB5AJ3a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338E3606A31E
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hBB5AJ3a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6361F000C4
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794751924;
	bh=Tz0uIh4/QIJLKFaoD3++YDHz7sTkKxH5cLZjnh26kVw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=hBB5AJ3aa/DfAAvBekBgMf+6dsPOJejK4tvHgDBqMSbb4qpduQvhQ3w6i2VUN+85o
	 ZK1MqNmRrqG3F4/fh4qhgX5j7bELZSZwLiNtjHP9fpJSiwG1aFgUPPF7PrjePRioVr
	 6I3tX5WIP7J2rUslSiDWvV0Lksw8H6qgwdA0dUGkBqKuLoWik2JejIsgw1A/mOMY8B
	 EhJBQHrwp3v2A0hHy9ms3KQ+RUD/TSarx/1ixBI94+FUOrPuUXW4qhGz54RHyxfAPF
	 RxflKN2MK7j2WnzDELdLVYQjc2SsikY6FTaVoOYMiCi9zhh8LQ9ZsQpyjQ1WQdXUOQ
	 2eCQsC8jwCYiQ==
Message-ID: <sashiko-outbox-215569@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/13] ovl: don't warn when the lazy lowerdata lookup
 fails in ovl_d_real()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261115-work-ovl-d_real-v1-1-ca155efbcb2e@kernel.org>
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
 <20261115-work-ovl-d_real-v1-1-ca155efbcb2e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 14:12:04 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> ovl_d_real() looks up the data of a metacopy file in a data-only layer
> itself if nothing has done that yet. If that lookup fails it WARN()s and
> returns the overlayfs dentry.
>=20
> Commit 42dd69ae1af4 ("ovl: implement lazy lookup of lowerdata in
> data-only layers") assumed that the file would be read before
> trace_uprobe places a uprobe on it so the data would be there already.
>=20
> But nothing actually guarantees that. trace_uprobe takes the path from
> kern_path() and calls d_real_inode() on it when the event is created and
> again when it is enabled. So a uprobe on a metacopy file whose redirect
> points at nothing warns twice:
>=20
>   ovl_d_real(/f, 0): real dentry not found
>   WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210, CPU#2: sh/279
> [ ... ]
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-214581@kernel.org
> Reported-by: Chris Down <chris@chrisdown.name>
> Closes: https://lore.kernel.org/all/20261114120557.4bc1eb6e57218cdc@chris=
down.name
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-work-ovl-d=
_real-v1-0-ca155efbcb2e@kernel.org?part=3D1

