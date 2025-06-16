Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CCE2063E7
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088226; cv=none; b=lM90Bk+AqKtfMJcKtkDa8odg+uurNBPexyBqfnmW3eVMItLQwwYB8aTUNlLKjlmnVuu0uzuHevS/FPGSelk26XhX5SnzQellC8QqXSNL+G62e2mQNeZ1HT2jdBrxac4bMv0mKQkrGCWTz/Yy1xKWmsPwSbd2ov6dvx95ep+YmDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088226; c=relaxed/simple;
	bh=180+fvQmghlJ4dELQpA9Q9GzoY6ozYQlhMfrL81At4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukw19TaqwYi5AXsY8GvLTfPa7Ir3g6FYIaWknXiK0viYrN7tvOYaGBZAEueVXiFPAtsBUKMWue3tC8XuGsjLKiEnt0t13w7sRvdxGMpSt4WBvFLoD2fkCgh1YRhk7NRiieMj7zBh/EYLNtBAgrjLVQX65EQy/6p1XTwNIsTo5II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=nzoh8IYa; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="nzoh8IYa"
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3BEAA3F479
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1750088216;
	bh=180+fvQmghlJ4dELQpA9Q9GzoY6ozYQlhMfrL81At4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=nzoh8IYaizjaXlwtNf6VSxH0O3bKqwGARsQnt2RhrZLPxHI3k6qwDTDv49X+JCE2b
	 ZMt3/DYoy2QShs0zX+weQ7CKotmyTs6ZwGJzqozvFNd4rO52LGG5uC47l4I106rqEH
	 CiiD2HFdQlE3xMwYvKNgngSgGcKuJ4O0FEfMUPupoio5j9MA+6tQlj+uzFQI2339VQ
	 QOozOIKul9gd0axkbl1sFPBov8xtsTcv89izcc9iKKwFk4xv7Fk+CG8mtzB2OQwsCT
	 ihVOk6MJEKf+AVkqbBc3GCs5Iwb42laFQgUMe8HCmKUqZv4axlmWOz2i4OKTdLl4AU
	 gJiMQL+27SEuQ==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ad8a2dc92ddso312745666b.1
        for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 08:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750088216; x=1750693016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=180+fvQmghlJ4dELQpA9Q9GzoY6ozYQlhMfrL81At4g=;
        b=Qti/93wmpttq3Xu2zeWc/qhVeoEJ8J+NFEJ4KqKLfwwJNVz/cabubH6eMiUhDeKNhQ
         FtKlcEWIPozPH/yXso2fZ7laOe3Q5BIEbX16aTaoZ56vRG1IbAMeDcPtbPKJpiqZZ5XW
         /esFLw4ghgcnkE77WHHaUys3an9l6KdFDGsJbm3APKd9eSolr29D0RzT/jdTGSGiaUGe
         n5GvQy+0oXHAPxmF/XLqs9XcE8m8rufFq6dmgVGRDkzmnnEZr0WZ38EIXfDsNfYj2Ht+
         1pFSaaj8LRKvTZwp8zemJHGdFODI0OfNXnWI/shGl87DziQKwhZb46ytvsZA8eD9FWiy
         I43g==
X-Forwarded-Encrypted: i=1; AJvYcCWJmQ9idN8LayTraFmRLthyvqfsVbjJ2KJ7axjsa9Me66eZBO69vIXAduyqE81+1jegj8u5ZkJUaC1fFBjqlmja48eBH8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze3roW1sDGzHbRwGoKij3Y+d8J7C8slKQdZC2dvST2zvj1I/We
	LaL01+9LrQDsqxThTCGR7+YYDnsHSfQ9vIAz3Dt7gK52FjC9vGH2jAI7WEo9eRUIur0XBd/6dHs
	5tTQokEDvXAMbNf8JSd6RkPfNZas4r5W+I1BjNOL0yUPRyQ7dsBEvf9QMWTcvCR3YondiIUvjYF
	SvawlJzSP/2GUA91tIzdkmx5l+vELxFg70dVc1KFvah9AokgjbL+SmkTu4wu5i+rkX+4P4
X-Gm-Gg: ASbGncuAbHOt1xfXNy7Wy1TRvzDxzpp0kzShaOdInJBgl8uWIPZZePnY3hUbPWuEutK
	y6p3VLGghhe/ujE4EejchKoRAM7DnB3GKEssLUfo1DMwyXgjc77eMdUA4cwQ61dSFZaBZOFx39H
	/oNvA=
X-Received: by 2002:a17:906:f597:b0:ad1:e7f0:d8e5 with SMTP id a640c23a62f3a-adfad31a6b6mr999250166b.16.1750088215716;
        Mon, 16 Jun 2025 08:36:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQJQ/hxkf9NwqjXLunZ2BtPoIP+ffyUhg6RAkOlGAz65yqlO6T/4AupYPgi3j+vAgE7ysMiMcbZuj7k5Zd7QU=
X-Received: by 2002:a17:906:f597:b0:ad1:e7f0:d8e5 with SMTP id
 a640c23a62f3a-adfad31a6b6mr999247466b.16.1750088215333; Mon, 16 Jun 2025
 08:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615003011.GD1880847@ZenIV> <20250615003110.GA3011112@ZenIV> <20250616-holzlatten-biografie-94d47ed640ea@brauner>
In-Reply-To: <20250616-holzlatten-biografie-94d47ed640ea@brauner>
From: Ryan Lee <ryan.lee@canonical.com>
Date: Mon, 16 Jun 2025 08:36:43 -0700
X-Gm-Features: AX0GCFuA0E_AeS4fXVbbXeQ-QJYneMvLTC9afYzBWHzkjGBvUYmdb71wV7nw2uQ
Message-ID: <CAKCV-6sD3tq3GQhq4YuSV_xPi4pA9Vv0zqxxZ=KTOzQutaR4kQ@mail.gmail.com>
Subject: Re: [PATCH] apparmor: file never has NULL f_path.mnt
To: apparmor <apparmor@lists.ubuntu.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Forwarding message thread to the AppArmor mailing list so that it also
has a record of this patch.

---------- Forwarded message ---------
From: Christian Brauner <brauner@kernel.org>
Date: Mon, Jun 16, 2025 at 7:23=E2=80=AFAM
Subject: Re: [PATCH] apparmor: file never has NULL f_path.mnt
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org=
>


On Sun, Jun 15, 2025 at 01:31:10AM +0100, Al Viro wrote:
> [don't really care which tree that goes through; right now it's
> in viro/vfs.git #work.misc, but if somebody prefers to grab it
> through a different tree, just say so]
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
