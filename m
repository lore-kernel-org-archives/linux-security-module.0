Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963738;
	b=ZaiZxTosffVgfkcbsl2p4Zlan0TURmvfcVZt94ya2ZQK5WEN9zNkFa2fbishTnZi58R3
	 ag/e7IztugYzHnLl8OoJj3JQmbF5F6fbv08WYZyn1eXdBuAs9W2eIc+aKsbk/qnRwBptK
	 4Zdkc3QZFx2g0gHlW/lTIxiRTqP0Oh2ehLhTljcINmCYYewNNIT21l6knnP8JYT1+48hY
	 JCzR8WEahefzHB28biF8lp3JKj8rDq/jzc8mzaYP3OibtfDKh0Kk8wo8zxN2DGk9nEJl8
	 5cLHzgqavwf6y690Ew8DJ1ey3UOQwNqo1USJy2rSVlKSg95njvb5MUzTsiCzYyOmH/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963738;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L8a6qAVpm7K2E2fPGVRMQYjg1w+lfNvsLcTTwjeXrAA=;
	b=3+zqVEYPKteonKyVqDFWhMBZjE+Zx5h496+y2OBqps8lIIvSsAKvHqU8Y67j79ED/S+v
	 A6MeMCcPZcZ2h16QR3t0W8tAcX7YuC7MPGDnO+QgFme4FEguW+prxWQmbUJKSpVvzp7zB
	 WMS8mbXYJdBcMh4GbWj6BBGWfzmjJ9oZTHOvpxOatWFp7uGGY4iipWjEdN+lbPPnD58aj
	 5uYmZp+TiaJfGNrQn903IydH32UP6mkNvqYi3rZRX1a8eid1XhWuH/q2gWsbYH/bcxEw2
	 cN60zxBiwzM0Hw+4TzWPedDoL6diW0lGv3/ggs4BRruAivodtw4fGQF/OGLKxLV9nDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b+eYIzR9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE53E606EEA1
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b+eYIzR9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619431F0089F
	for <linux-security-module@vger.kernel.org>; Fri,  6 Nov 2026 11:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793963737;
	bh=L8a6qAVpm7K2E2fPGVRMQYjg1w+lfNvsLcTTwjeXrAA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=b+eYIzR9C4dT+wXyqbHBmKLJdUH7aigBlbWNyHFBt0KzzpYeJZHBalkVyJbCY2a2F
	 r21UxFE9yGIAAxHaxZ1qTQMST/L04AmB6dyeyG1ZE2yDDtEBCWqt0tJQyaPjzLeFiR
	 Vik7wXkS4d4yy9pGDKD/ArFIZE+FCasW4cGw6RE/rSLpwg3QuRBd7ymx0tqCLJ2h10
	 KEliHL/SnddLBSHKLEtq17AKWIgjStSAGcOztaH8mIuLSmK15v0BqNUwPd4lJvC7eq
	 jeuO/hpFkqpn3saJLtkTkEDACJeO2bRKmnrWRCeCrj54UcukJTYJtROv/yQ/UviSS5
	 g3gMcRaV+tIMg==
Message-ID: <sashiko-outbox-201275@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] lsm: don't call d_path() when current->fs is NULL
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-security-module@vger.kernel.org
In-Reply-To: <20261106111016.5783-1-drifabdelmalekmohamedsaid@gmail.com>
References: <20261106111016.5783-1-drifabdelmalekmohamedsaid@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:15:36 +0000
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list

> When the last reference to a file is put from exit_task_work(), the task
> has already run exit_fs(), so current->fs is NULL.
>=20
> syzbot reported:
>=20
> Call trace:
>  get_fs_root_rcu fs/d_path.c:244 [inline]
>  d_path+0x224/0x4dc fs/d_path.c:287
>  audit_log_d_path+0xdc/0x19c kernel/audit.c:2221
>  audit_log_lsm_data+0xe0/0x12d0 security/lsm_audit.c:199
>  dump_common_audit_data security/lsm_audit.c:421 [inline]
> ...
>  security_file_open+0xec/0x258 security/security.c:2739
>  do_dentry_open+0x2a8/0xfbc fs/open.c:973
>  vfs_open+0x44/0x2dc fs/open.c:1101
> [ ... ]
>=20
> Fixes: 4a9d4b024a31 ("switch fput to task_work_add")
> Reported-by: syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D975ace299d6ba2eb1cea
> Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gm=
ail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106111016.5783=
-1-drifabdelmalekmohamedsaid@gmail.com?part=3D1

