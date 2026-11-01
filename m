Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499927;
	b=mD7m4q9+n1HUgwmwIffU1MT/74WOPWoQrzfy6EODPfMfOfKaddruI3uEYq6Bd2M4FVDj
	 MOHdqKhhpY9LYH2URWrGZ2NQp/x8d9HsPDONGkRRaP4UAB4kxp2rKSAuQQiG13NDrF7jD
	 5nwJXRin1SiTnb5fi1LmkIh7mXa64dFyfWMeSdTSWq+WVuHpvmTgaPb4baNlGCkvr75WA
	 OZdHa6Q/Rf+0lOi5ArG0vuyKdNcWFz6NfDHc3LNXLYXngxw9drafThw58ZKNMK1W/ZDoY
	 dpHcNV+ZEtHu4uM5UKVsqMfv7o+kuF+gUzcRFSn6OLDGeM7vYKKrukWSH0xN/ZUlWcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499927;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
	 In-Reply-To:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CJMLFsc+Wp5rV2c+umm5ckbj8CU/O6an9rX8Xcr8JyQ=;
	b=HZC/hzfBBrNbhb0cmLi7RMW/DsmqI5ueEcLtjVv54ejAv+SiIs33M+woPijLIg9nnK/g
	 Am5JhAjqBRTFWe07EmTjVw2vK7m8UO6z2qUyQ74vgY9Hb7zpGyshpdvqsrmF0KM/rvPd8
	 vJC/g3ys2lRZDLAvYWj8JaMHM0nJYzz9MrNublSCGXFyCNq68LbQUKGnGSQ93BRj21Sp5
	 HRTdodIwUM1Ljpi4b81pTtMAfQembgBo4johExjyaDhumlEbUwJuBQYeW2xO/Y4gfuCEl
	 I/PfOLr3x2VlKvsl5iuK0ddbd5wFEWwDMztB0rnVIVkHNWdCdZW2m/xRzHsYrzflGEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mainlining.org;
	spf=pass smtp.mailfrom=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=gZSe0UzB;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=Q7hj8aUo;
	arc=none smtp.remote-ip=5.75.144.95
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0589D606A326;
	Sun,  1 Nov 2026 02:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0589D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=gZSe0UzB;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=Q7hj8aUo
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793499922; bh=CJMLFsc+Wp5rV2c+umm5ckb
	j8CU/O6an9rX8Xcr8JyQ=; b=gZSe0UzBKFHOSmxVaKMuF5KkHPoiZkHiO2TjFnpPzweOb2S7TV
	1YqIzfPKV4RO0VKP/h1JGjQCXLhnhoNsIAAgoe3at9GlmgH/9Yl7BCJLKHhQc+9fw9xGoi7h4Kc
	8TtKtpFtG2pHODXxLNXWrNVfUH9IGaJ7XzgGBPNz3oRjiW4IDc/0VZmuzr84Pw/R4cNXKkWul3D
	dV5GUkPgwfRA1fUE7J1a1RY8mTVvK9fKMFECRzFZ50L1FOsgeWA7j8CyzFoWn+zldUWglmVZqRP
	1J5OJPJbAMMv4/gG6zm3LjJuJK+DsUxONgBChJgnt+MoQCZCSeL5JUb7RwomBSnh17Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1793499922; bh=CJMLFsc+Wp5rV2c+umm5ckb
	j8CU/O6an9rX8Xcr8JyQ=; b=Q7hj8aUouRCHU3VRq2jR1Y88iG/nqfjV+L0ZK+TpKVFBajtQoC
	1gWehF1X/hxHJjuBebwnNrM88S3vqPwNR0CA==;
Date: Sun, 01 Nov 2026 02:25:23 +0000
From: Bradley Morgan <brads@mainlining.org>
To: bbnpreetsingh@gmail.com
CC: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 paul@paul-moore.com, sergeh@kernel.org,
 syzbot+557fdc985d6ac3831e14@syzkaller.appspotmail.com,
 syzbot+ee58b040032d8bed63d9@syzkaller.appspotmail.com
Subject: Re: [PATCH] cred: mark the copy in prepare_creds() as a data race
In-Reply-To: <20261030033308.7-1-bbnpreetsingh@gmail.com>
Message-ID: <A25971F6-A534-495D-A115-72B4BAF7EFE4@mainlining.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 30 October 2026 03:33:08 GMT, Babanpreet Singh <bbnpreetsingh@gmail.com>
wrote:

Well! Okay then. Nearly missed this (sigh)

>prepare_creds() copies the old cred while other tasks may be changing
>its refcount. Mark as data race.

It's not the ref count,

Both reports show a 4 byte write 168 bytes into the object:

write to 0xffff888103d7fbe8 of 4 bytes

read to  0xffff888103d7fb40 of 184 bytes

0xfbe8 - 0xfb40 = 0xa8. usage is an atomic_long_t at offset 0, so a hit
there would be 8 bytes at the very start of the struct. What actually
raced is this line of get_cred_many(),

 nonconst_cred->non_rcu = 0;

a plain write to a published cred. The atomic_long_add() under it never
shows up, iirc KCSAN models the atomic fine. So non_rcu in the subject
and the description, thats what the fix is about.



>
>Reported-by: syzbot+ee58b040032d8bed63d9@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=ee58b040032d8bed63d9
>Reported-by: syzbot+557fdc985d6ac3831e14@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=557fdc985d6ac3831e14
>Assisted-by: Claude:claude-opus-5-5
>Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
>---
>Compile tested with gcc and clang; the KCSAN instrumentation of
>kernel/cred.o was checked before and after.

Sooo? What was the after? Could you have said something like "This bug
isn't reproduced any longer, tested by soandso"



> kernel/cred.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/kernel/cred.c b/kernel/cred.c
>index d01df40a9a386..d212db445c138 100644
>--- a/kernel/cred.c
>+++ b/kernel/cred.c
>@@ -189,7 +189,7 @@ struct cred *prepare_creds(void)
> 	kdebug("prepare_creds() alloc %p", new);
> 
> 	old = task->cred;
>-	memcpy(new, old, sizeof(struct cred));
>+	data_race(memcpy(new, old, sizeof(struct cred)));

Hmmm. Comment..?

WARNING: data_race without comment
#12: FILE: kernel/cred.c:192:
+ data_race(memcpy(new, old, sizeof(struct cred)));

The docs says it plain: "Applications of
data_race() should have a comment so as to document the reasoning behind
why it was deemed safe."

I suggest


/*
  * The only fields a published cred can still change are non_rcu and
  * usage, and both get set fresh just below. Keeping a copied non_rcu
  * would be wrong anyway, __put_cred() then skips the grace period.
  */
 data_race(memcpy(new, old, sizeof(struct cred)));

Feel free to bikeshed

prepare_kernel_cred() ALSO does the same copy further down the same file,
*new = *old, off get_task_cred(daemon). Same race, untouched. Did you mean
to leave it out, or has syzbot just not hit it yet?

> 
> 	new->non_rcu = 0;
> 	atomic_long_set(&new->usage, 1);
>
>base-commit: 881f19c2ffbc73f351b257e09c71e6059939b770
>

--- Thanks!
