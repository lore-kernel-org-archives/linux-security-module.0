Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290415;
	b=kG28bRc2IZEgimAfScGb/B9hgR+vYHQTHtnbAlEJoZK5IhwB4WTGZP7HvKsfUQw4xkZK
	 aE7cB2tCsVEu7t2NYTks7CbEFJVoJtu3CqwfrRQoaGVoUx1sPysjJcQYM9FdLZjBgAZ5L
	 spK8M2lF+V8sJpYwnEI3xX6/kVydFK8lih0qVkqrA7JKXk2y3ysu3u0tYR5AUOUp4QMs6
	 1627rMSKLDdXqb5BSfKy//6NZ8JlccZgdilwG8mEzxhb7uDOMRGt/S7I/AutBEhNqMexh
	 gIbqWkC7h7o3y7gBtn7StJY0KhSrakPhTVF7JtGBq3b+cbmC2CFlRZ/wZgL5ZfDGKbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290415;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vP68phsAvY7aG3S6+yoPsFoCeMDvOnSAllWkqFjMivk=;
	b=JKEZC7QL6H6KbZpWGuPxbhOcxCz98SPO677OuTYMJsIPQ7wlINtZzfigV3IiHjbmE0Vq
	 rBHWC0dr48xCZxaINim0K7eezmZ8M81xthd/34uLemXq+zsL9ubcT6cmDYo7qKkyCb/ZQ
	 +oo7S8QkMoxlrLYpD1/w+EtK9n1ThYIQROY+F1R039sezi2HTmiPubShMg169BCgOqs1D
	 aSgWDuedXhbwOwPLVZHD/SaujTexU+6fuN8hzKklEwzSRgUbXEyJ2z4lrFBci9jCB8bBV
	 xYGTH0952iU9rpTFjLv6xds0PO9gELOVB/RN5doAwY8wOHojMyQiC5DL1P4kyAGh9SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CfHE67on;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97210606A31A
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CfHE67on
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CAB1F01816
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 16:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290415;
	bh=vP68phsAvY7aG3S6+yoPsFoCeMDvOnSAllWkqFjMivk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=CfHE67onXEQuuzbrz1NPyHGxJ4NqeEoVWVydOwz16bmr7aEc0WUo3KvpxHtiFYdFZ
	 DL0Jby0TDHy1T7Z7GD76epKAW+NYcyN4sGHJde9Kx96cLuUIhQ3tiq6hoZmLdHGwcB
	 BApB029fKoFN256xQxiyIPOEXOP9TqMed8ZYlBlKQSthM++wcEDEZsFm/4OCS47pD/
	 UyOO2SL6vUfYsCq09WTcylN4y3K6uEaNAoJbc+xcjADly034ms90l2wNkRtwnhoQjZ
	 fO3iZvLJBzk8WWTqyDt2+KEN79wMMNA8+VNQAoobB0rhL2gkCKvu/sACHjYuA3WecW
	 RcpmY3kI8DiwA==
Message-ID: <sashiko-outbox-189651@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] keys: Protect the update method check against type
 removal
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <pm-keys-update-type-removal-20261029-v7-e79d113bcff91e140d04@gmail.com>
References: <pm-keys-update-type-removal-20261029-v7-e79d113bcff91e140d04@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 16:13:34 +0000
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
-removal-20261029-v7-e79d113bcff91e140d04@gmail.com?part=3D1

