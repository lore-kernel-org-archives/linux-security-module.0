Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794634683;
	b=r5+0KBacZtBjttyxoKgazClNbjAQd43xl8lbUtyMIc0GBNisiiyeLoUiszC4/WP26zxN
	 hvXOcr06VUuC9aOEDOUvd76n2LSW8iorp4zZ8FJjtNWytUk7C8h4MPZwilB4FMQQ/LHdS
	 3l3OqHr8FWui084lD7n6JaoHHOKb69c56SjpKHrRZjsMA0vQMIj4mbvY+Z1tMBPXLyxaT
	 ACQeEio3z7JB5J97OtgtK0guCF/iSrSGAaUx1bvtDst1oDMs3YUoCBZHu/oTGd3ZCobRs
	 dg2ocW/cIA7VGmmIjhA9DEP+a6SxsXIELAs2LjijWFyaeyzJUw/grezhJiLcElwF/qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794634683;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qlkSkvIKrRa9FiYw6pR+mXT7D77vdBP7yCuqys/Zi0Y=;
	b=D+8PS3vJGMAb2KkjGj+rOUk77nWoCuw4M6y4CdsH4X7x999yd5Bw616xlFHXvsSXo68S
	 RwGMY1rW35FNbvIampbYPe6Ma05A7atDQqpYxKV9zwZ8Cq3xwu1c9pbjE/aGqgRI7TOHK
	 9qQcwcxF8gra6mqWFAh4EQHDkpFHDuVEzKNYPhqybOxGHmLjlIYtzXpE9mF62fUulw5dM
	 c1d7zfLb+/Ia9uaX3l0HuFVHu7B/kUPFP58gh+Sn++rcFvyFigKkgA6BdR67/2kY5v9iY
	 BFk2bHnUaTTtloZekhAihhzbmLw3/20APfxu6ESHHVL+LUc7sXHjFTGbqOvAKnpcMPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b1wWosbI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5029F606A323
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 05:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b1wWosbI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1725E1F000C4
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 05:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794634683;
	bh=qlkSkvIKrRa9FiYw6pR+mXT7D77vdBP7yCuqys/Zi0Y=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=b1wWosbIiKan26/MoYlGq4ripDUoo3Cd4UMg80nOtRtXDcYWNINSuF4k3Bvks1uOr
	 JGaDmHmigDV1WtGNORQlkFyb+t9FI+lWJ/v0Pxf9uB2X59qt/1+l2fbHrRJkANGeZJ
	 1Uz8EBFGtPYwljn83yOwKmEeRbTECkvXQWKk84CniDjby/8ja/RMguvoYEDkERHa63
	 rLCT0XSYheCdRHsU1u0asH7R00rHeULgd1Op185nCpnQWQKpTrG6zCJgAMYkQ0EwfW
	 DGoZJvX+WccerKVyvMgVhGnt1zqcPr9+wVCa4ef50SuTW7ck0xSrmgTXeLvtA5j6+N
	 8L5dXR0MkogMQ==
Message-ID: <sashiko-outbox-214186@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] cred: annotate data race on non_rcu when copying a
 cred
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261114052900.7-1-bbnpreetsingh@gmail.com>
References: <20261114052900.7-1-bbnpreetsingh@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 05:38:02 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> prepare_creds() copies the current cred while another task can be in
> get_cred() on it, clearing non_rcu. KCSAN reports:
>=20
>   BUG: KCSAN: data-race in io_prep_async_work / prepare_creds
>=20
>   write to 0xffff8881046cea68 of 4 bytes by task 3646 on cpu 1:
>    get_cred_many include/linux/cred.h:222 [inline]
>    get_cred include/linux/cred.h:238 [inline]
>    io_prep_async_work+0x9b/0x3c0 io_uring/io_uring.c:367
>=20
>   read to 0xffff8881046ce9c0 of 184 bytes by task 3645 on cpu 0:
>    prepare_creds+0x71/0x550 kernel/cred.c:192
>=20
> The race is harmless. non_rcu and usage are the only fields that change
> on a published cred, and both are reset on the new cred right after the
> copy.
>=20
> Annotate the copy with data_race(). prepare_kernel_cred() makes the
> same copy, so annotate it too and switch it to memcpy() to match.
>=20
> Reported-by: syzbot+ee58b040032d8bed63d9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dee58b040032d8bed63d9
> Reported-by: syzbot+557fdc985d6ac3831e14@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D557fdc985d6ac3831e14
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114052900.7-1-=
bbnpreetsingh@gmail.com?part=3D1

