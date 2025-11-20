Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F83186A
	for <linux-security-module@vger.kernel.org>; Thu, 20 Nov 2025 00:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763597436; cv=none; b=dkrsB7TmlAHebcuRy3pyvZCUwA0SZuOC3jdpddNoSem8NGqNn43sS17cityvLJblzFuKT8r3x0DCdFmT6NrJNDFj/uJLmG/Fx2rv+NYknWkHahr27vCOVw1w+Pxc61vDvtEkwyHLJm6+ULZSDdbxu1URllXl7pzZ7r5HLCK1FXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763597436; c=relaxed/simple;
	bh=jAmQQxE42lgPR8xKS7YR4608nhEwFUcNxWyX+c6LnJk=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=n5bQcfgi2F7u8qs90gtWNarjRNKK7Jsws36tW5T66+sA21oH0GFV8k7weI/ZXIirH8Quj8fKJymfinJfsNBwIH5+K+GyaCwmc8XHEfmSmMIivTwINeClIHVr1mh0BCQFSO2Lg5hK9trlFwoH5Iid6zL15X1Q+oRO/WtV5YiXKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YkKi++Nr; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YkKi++Nr"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-880503ab181so3150096d6.2
        for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 16:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1763597433; x=1764202233; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrSe3R2YH0X0AwQPGyj7bOMAqS8/uA2AQXo6L2I2k4M=;
        b=YkKi++NrcdV6Sn6iCV32XTB+2PPM5EcMYw5jy4BulZ2pZrh46S4XG/4yr5uls6pb0K
         uO/3pANaARsmye4xBwovTIaAxs1mR4CrcjxILKGjlDbO1x+8UYuVqpMKUAa8tKkU7I/w
         JmSgkr4jTDZYu2rv7ouEzP9GW28siJzHuKDa4jsgmU1N9eXnzlrJl4bMVcKA2hisGGso
         v7+kLwM5OCUhub/OQL1kaJc8bqbGDD3Uxd/yrxMiE5gIOUzbrpCucPpwJhSYZ+u+Zj0z
         I9Jnz9M06j3Rux5sQ6770T9wrF6N4TNdj6UfM+0hDku4H6zu6hskbd+79Xlfaxbu82L7
         fvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763597433; x=1764202233;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrSe3R2YH0X0AwQPGyj7bOMAqS8/uA2AQXo6L2I2k4M=;
        b=bbQ+pvnoUc8aSSDSHHRCnjU2zc+Qapk2xYL5BDCEWvLncokcKVXzQl1cj0kxPwsTvk
         B7uHeyVJiMTlEgfdTsh3yn9uzk2acgfShysijxlssffgZDFIWGqBEsvAtS8NOQ0V1x22
         ubKPEWBIVPPSDzHgehfKO9csq1p9Z5KnHrdQ3hLqJBpzK4N51+7Nobxd1TwCnx15s3TZ
         3NCSPfHbjE5CKbg3Hf8XpT6hkmCZFcv2iRu6PAf0IlbEBmykCpMHGHeZOGTdV7JXmqXo
         U8ED0vQNVPojjbZB8xGv2G8i7SWx2GG2vF2JbhLXiQ3F5pqeoo8MnIKxSAqsCc4U0+6B
         xEAA==
X-Forwarded-Encrypted: i=1; AJvYcCUwWlURZYEnSKkYbIL5ZbeTqhBHpM9OwbalyXLwLPBei/RGvQurvuL64WoUj2eNMQ3NPeUXvlUfQMbmjYB00Gm70OgXjGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy35Yy+tSOdy6AN4unvd7iOYIRj/T+tWiTvWJOlcdzr7IXRzhHZ
	gAOFha8QMQTo25CEuih/+Mevu2Gf8+dMh4OzJQY+KnAJ95HbYkfY1WkSFaTn0n3U0g==
X-Gm-Gg: ASbGncu/Rr+qzSY/HItiX5SLrzkalOY6zSxq+HXmILS/629RDP3jLK+4MBixDnvLN8L
	K1KDyU3AfMjDroe++IzUnN8aYttkRH9mvR19bNPHKGq6CUUXMAMKaUlefT4UsLTr/dsB53Bgl0G
	U0HVRkPEVqVtPWodsftapZv5XsJsAOocvVopFkH6sI48yx0tqfynL9nBpsLa8/xvhiFih75scAq
	cyMAXxUb5XSHQXENJe3DjFEDYH/re5vNTXzCYrGNmEDFkmAmqYKYPXzybOfPTt4vZPoVzCiKrj9
	UjSmrcf3RSeLCcRmr4YzHFtARmiZRgb4+O64CTqTCRrMMOQokjTmJapzxdc5bofMMQxRQaVTaOS
	6ymtFmxU2Cf39XYXB/95oJ8f4e4VQvYLUYyNAVni++TZJHx8DrmSfNOb0Jbu/R/PWOhwo87Oo40
	kDggoR4YBfP/TkNVjul+Ks8AUkR/HZHPQ0TQp6Bmm6+rX5B4gkPJ6gm/m48vdEc+cch3c=
X-Google-Smtp-Source: AGHT+IFfdIdtxbRdfiU0y9sic5iWHSCSHBEO5Ssm+TOKBS6seiq2ElAwNyhFeF/v+WvRHWw9bpibSA==
X-Received: by 2002:a05:6214:4a04:b0:80b:11b7:2109 with SMTP id 6a1803df08f44-8846ee349c2mr11790136d6.41.1763597433258;
        Wed, 19 Nov 2025 16:10:33 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e469825sm6110426d6.15.2025.11.19.16.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 16:10:32 -0800 (PST)
Date: Wed, 19 Nov 2025 19:10:31 -0500
Message-ID: <d5efca7df0d2e12ad9d6f3d35afa2828@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20251119_1905/pstg-lib:20251119_1905/pstg-pwork:20251119_1905
From: Paul Moore <paul@paul-moore.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Linux Security Module <linux-security-module@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Jarkko Sakkinen <jarkko@kernel.org>, Christian Brauner <brauner@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>, Jeff Layton <jlayton@kernel.org>, Kees Cook <kees@kernel.org>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Stuart Yoder <stuart.yoder@arm.com>
Subject: Re: [PATCH] security: sctp: Format type and permission checks tables
References: <20251103113922.61232-2-bagasdotme@gmail.com>
In-Reply-To: <20251103113922.61232-2-bagasdotme@gmail.com>

On Nov  3, 2025 Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> 
> Use reST grid tables for both type and permission checks tables.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
> This patch is based on lsm tree.
> 
>  Documentation/security/SCTP.rst | 48 +++++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 17 deletions(-)

I rendered the patched file to HTML, and given that large portions of
the file are still rendered as monospaced preformatted text, the new
table rendering looks a bit out of place.

Let's stick with the existing table format until the entire document
is converted to something that is at least as constitent and
aesthetically pleasing as the current revision.

--
paul-moore.com
