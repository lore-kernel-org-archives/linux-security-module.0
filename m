Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512323;
	b=HktUoApWKEYRBgVZdt+jeAUTYC7kGnuyE8LSNT+/JiMFI1Bbt5Rsbz7VUUpIHsAdhNGH
	 /RNum46+1zq00zRzPMSxgWYo9mpBEItO/tSoBtVrrTprY7WqFgzpCLsBnhHCtm+D+inhr
	 dsqMotPW0lRGdisiEeGQo468CYNRd+vM9aeSOen1UdzCgI8mrZpL9UTCmJpzOEP6H7UdC
	 mKIeUtq08UHbUtLjWxZVXqIL++c4HFBwehJdemq2qyl0z2k3t2ebxYc3gLFXlXgrMXFRb
	 yC8zTtu397xuMzneuxbiFVvtVjRBGJLA6mEj2Zyc7El4TqUGpA2MEZUIvnxy8FXUwgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512323;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QLrs6XQY4FeoUnb7CKXVg2ktBJHhojIJeM2uWuhql98=;
	b=X3IJIhjfvHdxyjbK7f5SRUABW1GmWK3zYjJeahyi/wKeZoyJOjR4hExtQ8/XmaNE1Avn
	 UgTzbuqXloGG2l3rVkuSW7Ar1lVcrp23wSgyvVqtPSOcTE32ggsYHJD1QUqaFnxg4gSfW
	 ooHX/Irt2/ov43e/hPm51h43DjVtkL5GxLvCegiENxHQMohBC1akqIhji0c1fZ5JNT/Xh
	 Z5LhJXZszC811UprbKVn3W/kxQHaV6Rcpr3874n2SR+i75k/hzJoRN8ZCLI+36EaGwlcV
	 VYyKyFXWcVXWcymZqrfYX6qrwDZMaFmmnZKkUAW1rPZDrG8Ow4y2SUvfgL4/QUxMNBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apnICHAc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F96606A33C
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apnICHAc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565D81F000C4
	for <linux-security-module@vger.kernel.org>; Tue, 24 Nov 2026 09:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795512322;
	bh=QLrs6XQY4FeoUnb7CKXVg2ktBJHhojIJeM2uWuhql98=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=apnICHAcULAqlllj5171NSVFKZFnr4oqYG9eX9Ql2+U+6PvFGWSH4ES57LXX3G9K2
	 kVIAd5lAWaeRaZ9QQSQDinqfpz6ZdPFvlugwgZMEsVjqnbXzcp7Euiva9MNKalAR7k
	 hy9OsmVtHh37/CHBStJ+wOHk0mX+JJgavmRJSvRKjIGo+dudbNwN6vn5tSrVP12IYx
	 7JpTh3x5UvwKUbYxI87fskjqIc2v4efAQCdqUlN6b4eFuCFJ0JyC6xoa63qG6jhqPw
	 kNZjEdAxwt6Fi4oCw8VTq95kcDxpB3OEokLbnRwxrC17cRqXCnNSfnCk+vsMfCl8a/
	 MiL8NODuF/zBg==
Message-ID: <sashiko-outbox-230830@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KEYS: Protect key instantiation and rejection
 against type removal
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261124091243.1019217-1-maguicai@kylinos.cn>
References: <20261124053303.940216-1-maguicai@kylinos.cn>
 <20261124091243.1019217-1-maguicai@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 09:25:21 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> key_instantiate_and_link() reads key->type->def_datalen and ->preparse,
> passes key->type to restrict_link->check(), and invokes ->instantiate()
> and ->free_preparse() without synchronizing against key type removal.
> A reference on the key keeps the key object alive, but does not pin the
> module that provides its type.
>=20
> unregister_key_type() removes the type from key_types_list and waits for
> key_garbage_collector() to run three passes: pass 1 sets KEY_FLAG_DEAD
> and clears key->perm, pass 2 unlinks dead keys from keyrings, and pass 3
> takes key->sem for writing, retypes key->type to &key_type_dead, and
> destroys the payload. A key still under construction stays in
> KEY_IS_UNINSTANTIATED with a valid authorisation key, so an upcall
> helper calling KEYCTL_INSTANTIATE after pass 3 reaches
> __key_instantiate_and_link() and jumps to key_type_dead.instantiate,
> which is NULL:
> [ ... ]
> does not provide ->instantiate().
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guicai Ma <maguicai@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124091243.1019=
217-1-maguicai@kylinos.cn?part=3D1
