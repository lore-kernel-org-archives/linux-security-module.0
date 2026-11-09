Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794195332;
	b=zhdOYi9oKHIw6YQIfe2YBbHujkaw56n7moNHtOjO7h+aCzV1T7dWPWSvQeB0twRb94ic
	 18wd61D1CyV5v2EP+mI3f9QgVrqdZK/unyOdcheIbQnKmx0g+g+QxH8EYF+Fmm80+FCDX
	 juQnnm+gfqwwr3n+AGzgHS/eJcDHPah940Yr8TGEAiCfUd3Lecpi7xmrdte0JzzEH7jEi
	 yT/HzSdMMSQQdkEFr4DCOOD9APnBuDlcHKnxypPgYsk1hf+uawyOPJpR4l5F80FMq8Ct7
	 ePAZYXBJx8SNP8dsCPEN+9TwQOQ2PuHwRvXLVF8Q3ixHEgGM/w+GDQeyMpVPA5Z/0Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794195332;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X0kaGWKc358gw/UbgPW0/LKEZyyNTax69+247fXhcvM=;
	b=uQ4HiCh4HsCE/U+jKJaYvBBjCiQv0/XVhG2EXKg0d4uSIkufNuzErqzPcNQCI7y3g58W
	 Yhl+ZaS3ojOLzOVwRaR4h4dW3hVKSxI1k69RiUVl/j0zsgWNXHMwSxNLZGs7CYHm47DZY
	 bMzKA37eueb/RL7K0+8gonklTIkBGuF7zvWGn8/hdWYDc0GEThKyfK7Rr8niriRBorul9
	 byypK1dYkwuB1AE5XGQqGUs8pKMuWVDbVq2r3xTNIdhk/SSR5Cn2xLQ9zGD4euhOBNPoL
	 0uP67ww99v7tj8r08C0RUZSR0w/nnVnnKjZjKLB7ZQRbJh1jvnlNgnKy8kujlQBEibQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9Jqamcb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C0B606A31C
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 03:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9Jqamcb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6911F0089F
	for <linux-security-module@vger.kernel.org>; Mon,  9 Nov 2026 03:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794195331;
	bh=X0kaGWKc358gw/UbgPW0/LKEZyyNTax69+247fXhcvM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=R9JqamcbFAzML3Jzxw293YfV9MMXdrAe1tolKUWCLR8lj2osiESrKB4xPdvIVAcGi
	 1FvuadcpI1RsB1gVJ8/TfUOpaymZNlfsO6ZWwIhwwDyk8gbKWYaI3Khvv7mwBudcUP
	 bF3FdX3Lnl8PDj3xv31ctLfDlX9sYB2KI+Hi0ZCa8CCQUZKat7QaJ2GJH4rH+6B3Li
	 lI61EVDgLr9hDTY+ogzrzYcwmOLIsOWdZ14uBkNq6hMynreBWSB5kn5RsEt3Nh46AK
	 0lL/WH6McMU5sZR5x6DDCA/rteyn5IRfsdZy4pEoD0c1dmkkzvJd0nf6ZRkIEraU34
	 t6wMTrz4UvWAg==
Message-ID: <sashiko-outbox-204373@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] apparmor: fix double d_instantiate() in ns_mkdir_op()
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261109025600.2031008-1-ranhongyun1@huawei.com>
References: <20261109025600.2031008-1-ranhongyun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 03:35:30 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> ns_mkdir_op() drops inode_lock for simple_pin_fs() and re-acquires it
> before instantiating the dentry.  A concurrent mkdir() of the same name
> can pass the VFS negative-dentry checks in that window and also reach
> d_instantiate(), tripping BUG_ON(!hlist_unhashed(&d_alias)).
>=20
> Re-check that the dentry is still negative after re-acquiring inode_lock
> and return -EEXIST if a concurrent mkdir() won the race.
>=20
> Fixes: 4ae47f33354a ("apparmor: add mkdir/rmdir interface to manage polic=
y namespaces")
> Signed-off-by: Ran Hongyun <ranhongyun1@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109025600.2031=
008-1-ranhongyun1@huawei.com?part=3D1

