Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794751581;
	b=m/jsEt7Lom8382r7wTKJ5zGLRrKTDHdLLpvmjUllNtcEjxroN7OiODcs5P0wc3dxcBJu
	 9xH/3Bsw2fI4odW9cynsJzo6wCsrfpVsFBysmkm+C2JfIUvbZSvTz8J5nH0BuugSoq3QZ
	 IVEA0J6YNMwoY2PzHv5JpOovofF7Ghk3+pyGldGgG0yDbF01cyhG0cmY6J1BlUewxKOWI
	 ILCv5KTTMkcsxV28VpjrFiLB2iDgd21LWm1iqPDrajjs+STFdntU285t28TaHqZnv7KXe
	 H1mzyIGhcuWX++SjaMd3Ln576/54paC741urE7iSc7hf8Bk0PFMNKKx4BP1oVpbMm2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794751581;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KJJ4WwC3MYxhwLMReonv+6XogyAbjuuw0APxvhwBS2M=;
	b=B7HdF4IlKXNNKNDcR0RnsM43n95QZ0EL62IP+WD6veFbBE4UXGzzoGkOE6r1G0mUplZa
	 x9R5lVOEeHjrz2JmUX/KO3+hXq3qKfx0+QpR57UBxOnNmlgJjt4VKpblII+mCf/gwnR4e
	 W/r4ER7w2LjF11PazBBMK5QrT0Ddgiy+Yu0xfpkjvrKHxnshFHRUNfCboiIY+snv2AmaL
	 RvihuKr1YsWCDPvJiAgW0+4uwQlvtmPUnzFscHckr8GGMy1BigejptJ5okV3Q9nksluls
	 2IGWHRqz7AEeC39HPCrbIRCkpaxiOWXtdK9hLnbjii+3MjpoFvQytIztlo1gIoxGJIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JPnKCGTo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4308606A31E
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JPnKCGTo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8B41F000C5
	for <linux-security-module@vger.kernel.org>; Sun, 15 Nov 2026 14:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794751581;
	bh=KJJ4WwC3MYxhwLMReonv+6XogyAbjuuw0APxvhwBS2M=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=JPnKCGToQPgV76UeYOm2KY5uQKr20MCRuIzMpoGZJ/2ndG3PbKCMNHWaYzwOH1non
	 zMQF2K5B60uyReIvzQY3a5x3dr+jh1yb6gSGIlTmym0+paR0/1PendO8cw+DG9CN/h
	 FzBLo4mVYAXbSMW8SiltSn20nYW2QKAGvtRPX9TLxEDlIsYvxiWQlHoT2qDoKDPp4S
	 QqIQJ7tzM3GQ9hiAY+mW2GQNDu8ACulfWvk4vySQbnUnK8FzgXLe5VWQ0iTvxg9ilF
	 XA7PZ6OWV8vMU2OPwitqYlkO9iJdRM1np3X097Afa1UW50MoxXBY7J3LYOqe633T0A
	 HhlrpMD1zNakw==
Message-ID: <sashiko-outbox-215557@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/13] bpf: handle errors from resolving the real inode
 in uprobe_multi
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261115-work-ovl-d_real-v1-4-ca155efbcb2e@kernel.org>
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org>
 <20261115-work-ovl-d_real-v1-4-ca155efbcb2e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 14:06:21 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> d_real() is about to be able to fail for D_REAL_DATA. So switch
> bpf_uprobe_multi_link_attach() from d_real_inode() to
> d_real_data_inode() and deal with the error.
>=20
> Currently, the real inode is resolved again for every single uprobe of
> the link. There's no point in doing that. Resolve it once right after
> the d_is_reg() check and fail BPF_LINK_CREATE with the error if the data
> of the file can't be resolved. Then all uprobes of the link are
> registered on the same inode.
>=20
> This is a no-op until d_real() can actually fail.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-work-ovl-d=
_real-v1-0-ca155efbcb2e@kernel.org?part=3D4

