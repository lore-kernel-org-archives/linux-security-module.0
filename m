Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3878956261F
	for <linux-security-module@vger.kernel.org>; Tue,  8 Sep 2026 22:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788905067; cv=pass; b=JvGs5zt4o9J5xnzLuTuReAg4l2uGidtA53XG2uMy1pawbzKZNgtJH5PDNzRjhGrOQKpSFoRx1vaYnj2wXliDmN5Y7iorIoKq1Nm1HQWDqw8HmQSbAT4t17YpyQKio9qCWtHYTosjuEVuvD6EAn7euWCRbm2GxRZwjVK0zZIDwVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788905067; c=relaxed/simple;
	bh=kFs2/Y5KiTV72hw46XVjq1+BiwJ435803ate9yBUPeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7YEATb7EFhoioM4bGpPJfyyNc0chZYUwBBH5KYo6ncAal510UusOSK/ktyyaz3i8RLcnMEIinwZ7OsPhsc22ln3XVIvLyV8vUtEUFTyF8m6C6FsLW1UCV+qRZtyrvaAtSv8tuRWOWboAcMOf6YMlR9SkUR7KMwn8Lw25Zv5TE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=byGtWLH9; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="byGtWLH9"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b2e1d5so422692b3a.1
        for <linux-security-module@vger.kernel.org>; Tue, 08 Sep 2026 15:04:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788905065; cv=none;
        d=google.com; s=arc-20260327;
        b=PqcViV93YCTS4HyKF3t3Avzy2xVPskYNT6yJ/vhVZR+fP5XxZmI8KeUkFNEvI8JVS3
         LN0fgwrMr/x7RH+Blys3A7rWg5cEklxXKSJ0vnuF7nFwJprdDnOMrfLINHsE701xFQfc
         4dutkzokHrmIcKmG8bAz1N4OOWDeSFRiojV5X3FlWMCs5HdKG2OUvtTGRvIof+wvD5P9
         GCaHMI3hK2D3oqS0H8bxhWzQZxV6Bt8gkQofj/3x7vG9iKUuLiSkmf3kZbLvs5BEyI7S
         hYa0bTxaZalft0DN5W04evIx1T8rW4GTYTi7LtJJtll5XDrsjqe+DBo6XuWWge3SFiNE
         TjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YWfrU9KFZA0btF/+MeYl25HDjvWja/4fX79GCEtM140=;
        fh=GRmGFa6+3gHPGUcie8Aybs8CvpZAJcBuOasxUYtm6ZQ=;
        b=TsJmWlAofVR277mLffwhBDLfSZwSSe20W4Xo4+sF9ZrhwGQdrZ0EOBmgvP2A6JlcPz
         JBhV08SKgNH4Ml3g0BoAm5dqaB+6fpYbFIrsSi0jwW3VDUlyg54V0/WS9o0kJyJvZJxZ
         8zcfZMRY0GO/b7RkWb5591csWK2o/glvgIPGr15SV0FDiZls4RzQe2wkGjhz2wbQiscT
         0Li6/9rNlZQZ1U5fX0jUZIhTWmAl3C6gX20TMnlMY+VkZ5tnz4tprfQRyb/yDDABB6iV
         TwQ+6cF8rDFxCHKlvl+82eBBFtVwPvZqG2vyK+AX4JwSt+vB0SpUDvKQJlcxYFeVQ+MG
         dsPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788905065; x=1789509865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YWfrU9KFZA0btF/+MeYl25HDjvWja/4fX79GCEtM140=;
        b=byGtWLH96x6sw3h9XGMxxuPYSC951TzNPI+BCrqb+S36so5xweMUtxaq+IhYdl78cO
         l4K3ie4BoXiLGo5f1w2xx4fm/S+8X+lQMv171L7v6tU59b+KrRF82z5wKjAZ2H+P/+5O
         xtmXKTzL+uob3DpVranPTuGeOOwVh7q0nUpftp8VN1KzTMKong8gRs8yK48VJMZvuc6W
         0otQwxvj8ogNuOWZm+CVwDcQ87CWDrOHMgkOUJR+ItwtrfKxDdpzKtjRysfMFi9YE3ZL
         5PX9XAlHnebv8jwuud1d/EJMoQs/D8OjES/ydwa6btLWWg4BgMUf8uIIAXsTUUdh7Z+S
         Y97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788905065; x=1789509865;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YWfrU9KFZA0btF/+MeYl25HDjvWja/4fX79GCEtM140=;
        b=duReELj5EjixD9MV1WY/X5IaQ1adxfB5t6DpA0vccQaKsfh2Tx5lPxcyy14qmKzouj
         ZkzTcoA7mo+PvHNuVpu6ioirr7FV9VVsvDwv9CzQDShk9TJZCPeTdBiu+jEhhev/XKeC
         eZJDx/2xXxV8VQURuj99NyPtrdAH8dUT7kaHjSZ0XrpJjqzQD0RlUSrrOkp1mJWkaIiA
         Mdvw5twN7YTu8qR7WFaULf3hAaATPysK01Nx5XHez0W5Ku59QS93gwFIOwXfwdNhoSER
         VQVucaIOOAUlZM93C97+zT1nBgk5dfKzLo2KhxXJx4jPIX3F4ulThbIe8LBDnwxy1wtZ
         9Zkg==
X-Forwarded-Encrypted: i=1; AKwUvBx1732yJ/nPFdIfrmDVyL8oi8z+GnF8lBVa5HwjAlSBKMXR/27bNvWWNZwQ2M9FjSb3Z474e/hP9vhENmdSWa2uwWmd0bk=@vger.kernel.org
X-Gm-Message-State: AFuF++lX4WDWha4jBDZsI+yjlq/PtJM6ZS2VTIbzDPSKqZ3g/jEVPY3K
	QwaxHwexD3SwhfFMU64mUR3tBbmEuHD0GJm2HQrsmW19XBkn76S0BNyAEYmu4O9g/7OB/ZBjny9
	7ysuTz47ePn/LP4hWdrY/Bdnt8ktK+SFANlJ3qQwA6ujGHRSmjz4/gA==
X-Gm-Gg: AYBFou0qM7i9wq1bb0YSLSalVzB4EWWYWJVWAznuJcIkYVa120OlPq2mnK6BSU0bifk
	xhODhS1yHufn+3mr1dJhJ8X916NNv1qys0BYMNExL167aDRN89t37pksDgYZ3yiHNSXgBe0ws7P
	ZGNMGE8tbyElPig8TxwKbS5VWOJcl3Bq5vbDehOVOp2ltpg7vJCl6MYwBgCLqv0lYyEMIOD3fFY
	LHuGrrjA2gPZKNSjSg0shVkQ7LkqWy6YoWo8sOv3aFz6ePiR99C+KGTm2w0EqtzRDWq+fYbgusF
	hB1h1W+7AwoAlORJU1OS33QoArYFdEbCskjU4J+DqcEbPPPJ0W6HctfI9VjVVxcpW9li3kBbUzw
	P
X-Received: by 2002:a05:6a00:4103:b0:857:72ba:ff0c with SMTP id
 d2e1a72fcca58-86843380d24mr2506973b3a.20.1788905065338; Tue, 08 Sep 2026
 15:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com>
In-Reply-To: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 8 Sep 2026 18:04:13 -0400
X-Gm-Features: AcwNN1WG-GhgrrNi3fsiuaGk2OK8M8zXACNxnVPqz0qu4sJFuS02JXSPQW7uSlo
Message-ID: <CAHC9VhQwHFdfWkTmZtMC+FgPDd32nW-e_FPbUhE70Y8a6viEBw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] lsm: expose mount idmaps to inode hooks
To: daan@amutable.com
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 10:48=E2=80=AFAM Daan De Meyer via B4 Relay
<devnull+daan.amutable.com@kernel.org> wrote:
>
> OverlayFS performs upper-layer operations through inode-based security
> hooks. Those hooks receive the upper inode and dentry, but not the mount
> idmap used by the VFS operation.
>
> The security layer cannot distinguish an identity-mapped upper from an
> idmapped one or make the same ownership decision as the VFS. The VFS
> layer already passes the idmap down into all relevant inode operations
> so this just brings the security hooks to parity.
>
> So pass the mount idmap through the create, link, symlink, mkdir, mknod,
> and permission hooks. Update the in-tree security implementations and
> non-VFS callers accordingly.

The above three paragraphs should replace the commit description for
patch 1/2.  The current commit description for patch 1/2 only
describes what you did, not why.  In this case, it's pretty easy to
see what you did by looking at the code in patch 1/2, but the motive
behind the change isn't quite as obvious.

As long as you are okay with me updating the patch with the change
above (and explicit on-list email would be good), I can swap in the
paragraphs when I merge the patch so you don't need to do another
respin.  However, if you would prefer to do a respin, that's fine too.

> systemd has been shipping systemd-nsresourced for quite a while now. It
> relies on inode and path hooks to perform ownership checks using a bpf ls=
m.
> To make this actually secure we need to be able to calculate the on-disk
> ownership from the idmap.
>
> ---
> Changes in v3:
> - Restore the two-patch split from v1.
> - Add the missing Signed-off-by trailers to both patches.
> - Link to v2: https://patch.msgid.link/20260901-lsm-mount-idmaps-v2-1-330=
9b9d1eda2@amutable.com
>
> Changes in v2:
> - Squash the implementation and selftest into a single patch.
> - Add the missing Signed-off-by trailer.
> - Link to v1: https://patch.msgid.link/20260824-lsm-mount-idmaps-v1-0-041=
4a9641c85@amutable.com
>
> ---
> Daan De Meyer (2):
>       lsm: expose mount idmaps to inode hooks
>       selftests/bpf: verify mount idmaps reach inode hooks
>
>  fs/cachefiles/security.c                          |   4 +-
>  fs/namei.c                                        |  18 +-
>  include/linux/lsm_hook_defs.h                     |  23 +--
>  include/linux/security.h                          |  58 +++---
>  security/security.c                               |  40 ++--
>  security/selinux/hooks.c                          |  19 +-
>  security/smack/smack_lsm.c                        |   9 +-
>  tools/testing/selftests/bpf/prog_tests/test_lsm.c | 231 ++++++++++++++++=
++++++
>  tools/testing/selftests/bpf/progs/lsm.c           |  79 ++++++++
>  9 files changed, 410 insertions(+), 71 deletions(-)
> ---
> base-commit: 786262be6048deab760f68c8acc2c85607165894
> change-id: 20260824-lsm-mount-idmaps-9d9b994fe1a1
>
> Best regards,
> --
> Daan De Meyer <daan@amutable.com>

--=20
paul-moore.com
