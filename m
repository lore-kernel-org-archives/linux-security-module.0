Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992173;
	b=boEEh0nzxbL4cHHnHbk/bgMwgjVi+VDlvWRCXigtqxgggg0z0L6WmBRLjBlKEREBes4T
	 pY4guQar+Q0R1LgEVMmHnCkSQDDhh6qkqv2bR342cyiHBnsLqNblPAWSdWwm2U+6b4J/V
	 j7zx5kDqtUTL65GMPt6G+M8KF4G25yOLWzeHRFNJcpptmaeeu9fllMyioNiM8BnxAMyy9
	 BnBiKinvZT9/ihKTQkCyhD4biWHJDONGjDNxLqFy79oREZo84Vj2+GQaE9RwKtAwgSjE7
	 W+6umInToNSKNHC3t6k5zmksoanf/O4MkgTe5aRWNnBgDsJu5tNNX0b9jLUpA846B4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992173;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yr4yqma+0dmASfYk4M1OJEYSYgWYaGgOvzMmlVp3GTE=;
	b=O0ckxJfL1wqFEXJWHxscYZOF51FVUzfB9Q4MAagrvQd7AzKyXpPa45Jmpvr7RLK8k9MR
	 VPR49z1zAs34m5Pq6W4TlmJraQCpTscTEl0EaC2PZxRihI/uOdxCE2Qom1qGZJ4lNwmS7
	 Lc2aczo4MVjqKb7xw/dMyLkhw1pMQKJ6QabwHZzA/8jM4Qv45RHrC/95gPVdyTG/M3VQH
	 rsivtNKEwV5sCb7055uvl7N741J+PsPVBHh/DmiTYD7YLBN5Ppw5+QKdwcT5AHRPzm8Z6
	 DAlk/trRmc7o2QYZ/wY2j8IG6HB0Ix0kmh4nU321r/BVfDDmqP6ByUULRJB7iMyCWsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6PgFgjq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CA1606A326
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6PgFgjq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F6C1F0089F
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 19:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793992172;
	bh=yr4yqma+0dmASfYk4M1OJEYSYgWYaGgOvzMmlVp3GTE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=S6PgFgjqZTwRSE5/4mrVGxztipn1xIkYzta1gBcojEhfKdZfIOyf+9/6RlOUB2BOi
	 VnNCHRicjEbje8tGL6o/FuQXieb/TN5S7CbWjXXlkm5KIn5ws2nNkFhoPBsVeYDHEY
	 0yoSigNwmsi6T9s84381g4FeIsq3jKGvN/vZGEvKbEYlJFCfUgQ5iTjNXKtZTn0bkL
	 W6rPEm5+gzP8rq+zc3sZRo1ou4L8YVsDYrdROcmmdAlcdC9XjLkjHfg6GPDh2ol1Gg
	 phkHfan4vO722h3j8tLyRH1efqrQ0vOuzI/isdYhnxvimun/SM4gXLA9XpVvGkoukl
	 RjmVFlZPN5Y5Q==
Message-ID: <sashiko-outbox-202137@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] apparmor: fix out-of-bounds read in unix socket address
 audit
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261106185532.3338123-1-bsdhenrymartin@gmail.com>
References: <20261106185532.3338123-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 19:09:32 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] apparmor: fortify_panic() in audit_unix_addr() on 108-byte unix
  path
--

commit d5771717eed480bc696396976af119ef6974188d
Author: Henry Martin <bsdhenrymartin@gmail.com>

apparmor: fix out-of-bounds read in unix socket address audit

This commit replaces audit_log_untrustedstring() with
audit_log_n_untrustedstring() and strnlen() when logging pathname AF_UNIX
socket addresses in audit_unix_addr().

> diff --git a/security/apparmor/net.c b/security/apparmor/net.c
> index a333e6aff9262..10f888c83b897 100644
> --- a/security/apparmor/net.c
> +++ b/security/apparmor/net.c
> @@ -85,7 +85,8 @@ static void audit_unix_addr(struct audit_buffer *ab, co=
nst char *str,
>  		audit_log_format(ab, " %s=3Dnone", str);
>  	} else if (addr->sun_path[0]) {
>  		audit_log_format(ab, " %s=3D", str);
> -		audit_log_untrustedstring(ab, addr->sun_path);
> +		audit_log_n_untrustedstring(ab, addr->sun_path,
> +					    strnlen(addr->sun_path, len));

[Severity: High]
Can strnlen(addr->sun_path, len) trigger a fortify_panic() when auditing a
socket bound to a 108-byte (UNIX_PATH_MAX) filesystem pathname?

For a 108-byte pathname, unix_mkname_bsd() writes a trailing NUL byte one
byte past sun_path[107] and returns 111 (108 + offsetof(struct sockaddr_un,
sun_path) + 1), which unix_create_addr() stores in u->addr->len.  When
audit_unix_sk_addr() later passes u->addr->name and u->addr->len to
audit_unix_addr(), len is unix_addr_len(111) =3D 109.

With CONFIG_FORTIFY_SOURCE=3Dy, strnlen(addr->sun_path, 109) sees p_size =3D
sizeof(addr->sun_path) =3D 108, maxlen =3D 109, and ret =3D 108, which sati=
sfies
(p_size <=3D ret && maxlen !=3D ret) and calls fortify_panic().  Clamping t=
he
bound to min_t(size_t, len, sizeof(addr->sun_path)) avoids passing a
maxlen larger than the sun_path array.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106185532.3338=
123-1-bsdhenrymartin@gmail.com?part=3D1
