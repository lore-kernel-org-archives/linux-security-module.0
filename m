Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511B4274FE8
	for <linux-security-module@vger.kernel.org>; Tue, 29 Apr 2025 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969710; cv=none; b=l1FTR1Gi/jCjRZU92OZAvXtxvcOrfLBHjDhqRpn/epKF1S7hJEmW+JO23nYhwPXS4XZAwkvC2KAJaoP1L/jHE8NtZVUI5I2QS7Myacy0MgJr7SKNbO3yEKlEa1mM+b34vNQB919KUVSRm3S3NG0wuDzj18QCQb7m+9aVP3L85rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969710; c=relaxed/simple;
	bh=rsEl9UaP3K3oS3AXEGJ4//+d9JcVZzKygP7EoztCreI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZoMVc+Jxp2+7o5RnWOYwmpX3980+ZltEkps+o8xX1gKOV4ZbN4jSWIxC52dAz3zVLhKu2YW9MtvFMza5GIGpy2QAWrtgBQYC5h1hSU3Oz3i3NZG+5hs5QYMfTbb9kxoEUvGsyDwrFwdmx+AQ1nPtYDyV1sC9BextSNMjJhNpKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QDm1WH5a; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QDm1WH5a"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e7387d4a334so822979276.2
        for <linux-security-module@vger.kernel.org>; Tue, 29 Apr 2025 16:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1745969708; x=1746574508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmnUMSIYfYwpn2HyiLKQyNsn7KSrfP3LbpSrKf+5Aoo=;
        b=QDm1WH5aDX3S3onHkINlqKhU3r9HLrw9D1iA4hyEWhENRuaD2NoLbOYORnp9+t083B
         2ZEG+KjLVuRtm8hoXk4HbUQXHgx+8/3YuC1MUHB0OOR8YumhPW3x93lR3uV7dh6TAJ1C
         Cg4Z53TupJMN7ljgn/spNJm2j6L6EQV2CMOHBEoDRkHyXWg8IADMRpxcZ1Q/6YcaWszZ
         xQQ8xpM3l//Dvo1h8453Bv0azTO8mUYPBv3lktXIg75qLusprpBitm76RUHAREgu2bHP
         RAr2MZ4YMrOhy3JzoxkSDgZ38hXSb0YTYXcIWZBqWyfh3MgB3P1ll09FlnC3C4fZqfNm
         rVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969708; x=1746574508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmnUMSIYfYwpn2HyiLKQyNsn7KSrfP3LbpSrKf+5Aoo=;
        b=hA6fBC8aHl56MqI35a8IeEHimJPZwQXkVozAfSbwFYPIgAltQv2JwCRkALyZ/TFYyW
         N5g650b/1z9tgH3nkplq+MfpG8ia7yD4C9OEv/154Kbg5RmWrkTsPLm0jJ9zCV6WZFy8
         tx4WsYdRnMaqBs/5pDs4yp5KXxCE9psmlw9TZWiootOx7xnbYu5ijVScJH/b5+khaT8/
         Pk3UbVxQXIo2bRlsaKsGUi+jjrLewKcKSXHiT+AdSzE3g9WZDmfRf8EGucyP4usUQKjf
         Ydi3QheI1+tZepnrVC1y0EfvwlVZNF9r9mu7+5V34Xlq7cETGPZXTICqrLjMkdF1e9Y7
         zspg==
X-Forwarded-Encrypted: i=1; AJvYcCX1c3lOkarVMRLmA5hIVRh8iE40mu8D2y1nIOe0myHqfKn8X1RM44pqk8pzK8W3Mvx4NBORwNMwM6n8qrUYbfv0c+2F04w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDYbDuO0b8CF23GPH/H9wmoeFjN3BMz5PAEM3LrUmjFmV84ao+
	4reprskNnHf7M58gCGfR8Ypxx8/NMELcECNQ4S7voRfwZBzxVeJ2qHTdUg55cVmmtUbqaNET3eg
	fMOxSKzBq5R59k39ColuGkjw+FrrAVPcEFJ9Q
X-Gm-Gg: ASbGncv+S299gceObEIOBD22zOQ9Lm2/zwUTbxQoZhNMO0KC+J0Oz6G90loiK7aHV76
	YnwZ/ETgCNx80ZtYCcfaaHngU/tA+JC+g5XNqwRU/0w2L9vYtwHLBsiw6Q20bXFWoHFPga/HllB
	Ildbhcgxw2PiR6EjKOaeql+A==
X-Google-Smtp-Source: AGHT+IF/PA17pzv+wdeYWaRIlp9MG3hOQmLeL81RAcqY50BbqvkWNnzjIoFkoR7L0ftuH1lvEReltyIjrUvBDvzq1Oo=
X-Received: by 2002:a05:6902:18d0:b0:e6d:d996:d8e2 with SMTP id
 3f1490d57ef6-e73ea8e46c4mr1522551276.14.1745969708362; Tue, 29 Apr 2025
 16:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
In-Reply-To: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 Apr 2025 19:34:57 -0400
X-Gm-Features: ATxdqUErdvmLNdYZ_wWU2pMeCgVPQbMkXZvEOfiOk_QLBFdZZaZpYQrTWKeaZ3k
Message-ID: <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com>
Subject: Re: [PATCH v2] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 4:15=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Update the security_inode_listsecurity() interface to allow
> use of the xattr_list_one() helper and update the hook
> implementations.
>
> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.small=
ey.work@gmail.com/
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> This patch is relative to the one linked above, which in theory is on
> vfs.fixes but doesn't appear to have been pushed when I looked.
>
>  fs/nfs/nfs4proc.c             | 10 ++++++----
>  fs/xattr.c                    | 19 +++++++------------
>  include/linux/lsm_hook_defs.h |  4 ++--
>  include/linux/security.h      |  5 +++--
>  net/socket.c                  | 17 +++++++----------
>  security/security.c           | 16 ++++++++--------
>  security/selinux/hooks.c      | 10 +++-------
>  security/smack/smack_lsm.c    | 13 ++++---------
>  8 files changed, 40 insertions(+), 54 deletions(-)

Thanks Stephen.  Once we get ACKs from the NFS, netdev, and Smack
folks I can pull this into the LSM tree.

--=20
paul-moore.com
