Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2A03A0B1C
	for <linux-security-module@vger.kernel.org>; Tue, 24 Feb 2026 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944298; cv=pass; b=aZ7tkeXoIJ6oeqflsPYaR9fiNgPQArmfcECdFyDB/3SeTw7okfqbXHOxeS1dY5rKT67x6PZ8bLwUctCTJlCaAbiEanNSOgDThK1ee17qM1BDg1MbVMBe1KRDCDEcVsZsWKI88xrMM38v6VUBGEWReqF2qAsMYpPzkzrHL65hfdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944298; c=relaxed/simple;
	bh=NpXDBXAqbPlLtzWPxOL/h0QZP9LJz3X72C7AQTPy0jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZmXiDz66dEoZrvSGdukOF1N79Cbo1vVF+AltpkcSV9nNlKF5pfeLS6KJb2eaBnhyVvGWfLZ7gRVgD1pN5jLzoZ3hMIfJ6woGDMxxrUUekfTvtZCoCxrMru5XdqKCmPscrlXhjC7e9Ctov0wogbOwosLxYONdDKfIXGmlOWogS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBOcavK0; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBOcavK0"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-354bb7d2cb1so2866661a91.0
        for <linux-security-module@vger.kernel.org>; Tue, 24 Feb 2026 06:44:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771944296; cv=none;
        d=google.com; s=arc-20240605;
        b=hS2eKP9mvgdagQ1ZlKLJ65O3snViJNcoVdwBV5m6dklK3nm7lZeazqbUPMndYLrGe/
         rOgYzduLh76RtXCRID7FujCrc/SqAJFggo/Q5UsNleVHIH4MrBEUfFSizKFVQdAiZp2I
         DR+XBMQq96Irqqg0aUFvFw1V5LS4z4jcvWypruC0SK/Xo+P9cpwa44/ejJkU6nDGujxQ
         D8EILlE1L98KjwmeeDuJvLLn8jUHqDqCjFi0s9JY4OWd6vZMU9DK5fKb7tKxLYTdm5I8
         FJ4Sf/l/fn5vgH8xH5jv9G2V4bizCLu9ji9yQxvaQzWOV2uMe0T2EUa+1ZwtcGshjhPl
         hdUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g3vFWFpXe0pZI7fYc1bsMNxvQ7fGJt0aDflHuDb/YTs=;
        fh=tu/lHZy2Utcs8ztxFpLIDVrUWoatV1vj17qOTcrU6oY=;
        b=LhAI4rG/BKk035ez4HztcVjr2Vwne2Vvw8nEgF0bq7x8bFTAkHTsXgZ/8XO0bcD79n
         r0oVXFzom/26TKyKV1xsWX0b710k7b41xlR//y4K/ED7wk2SXW/dEfhok6Hcno6QPS1h
         FfKBsLt1ZxkcqRc9m4LjyK2TUtDgOkRENyqvpNDPuKPGYY0xu61LooqqK/e1Yw+H1f1o
         lA9VMgeScY+Y7jASNvog/DS2sZTfnM7F1y+0ClO2d1HmCEXQwwU4POACHecKjvYis9WC
         rujJI2fPSRCoRwkZOxyqP6Ix/UtOG+g9Iu5Rbptsa5HgjICXhoJjuo7bCIkKNP1djRx9
         ve2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771944296; x=1772549096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3vFWFpXe0pZI7fYc1bsMNxvQ7fGJt0aDflHuDb/YTs=;
        b=LBOcavK0uZWARHpfwTPAPRL5N89Z1QVZ43J6IN1qDaESM80vqGti73ZLcQ2HqG8aLQ
         FP4xrvcPMnUTPHoo+zyhHmBSI6Q0wLvzsoh5iVk3aifVv0xFKbCeuAkeQYp5Vc9FrYni
         5LSl679JJ0OP7GlIqLGhgA57/k+40Mu6UHwz3k4Fx94frpv4tQItF5rFAA7XVGoH2q8n
         OhP8N71bZ4OtpTypA9Z8inSlfz/QYYT04pnSWEX9LMRe3/gP7IsrDOd6Mj19H2NAO2zK
         7xv0bp3GMOxqTSyG+sx0m0Tg+n24tMxDiiGlsi4qzxfLC1/81hu+Pp6I55JIwNNbLALT
         /byg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771944296; x=1772549096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g3vFWFpXe0pZI7fYc1bsMNxvQ7fGJt0aDflHuDb/YTs=;
        b=a2ZV337cDf9TiwCkCMfeSvW81BTCS5UqbcuMXCa+6+Xo0kkhgcOSJrnqdCAvs8D0Nc
         h0f9p/Jv/0DSzN1bMDBWLSidL52xlLevsqwzl0zOxOv0fNOvs0eGIbVlI1tIstUgVLgh
         UjbuQwxyqCkR+wvisqUGKSNTrSSwpYJElRHFhibrZhJ8rPOHqPuAPUDIwLXjmtQNGx60
         k6OtnyVyDdpK65bdoLdmccVqmtBzr44v3g/POuKyzT0E6QCKjVzh6+4PvrtjL9yTDJTX
         tYm3weNpToPYWLONL7aTHYeaHbiLQgIe1B1S/baOrvtK1VWQm1LlhfVBhR3HkytIvONU
         hAPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkpuCdGsGqDmnEC/Snin/l/+8+/plbHo0Q4NRY1NEEDCWgNJLuDFpI1cj3Y1GKxN7eGbNdKM9O25mhUUt5wPdqJoR1/T8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwI656O+H47kR5usUwH2hwaaA2WQZkRaxU/0ccG4W/Z9lLP3ay
	zqg/Gp0bjVpUXOPMaaz8o3JzFK2nkMxRh8ZIDLWMNuub3O6p2kVomw58FKIxqZ1ghFgHPJ8pP5x
	cAA/gaDFc9SYgD933Nt5tBjI8Oy26wwo=
X-Gm-Gg: ATEYQzxWkHahijS46zV1OjNYWAuoOL8iAsLg129gwXLdoShh9L+vimehFScCK6Fczxx
	u0kOQMolDoGJMnNJ6gMBMkqWuNJxWke8hD2GF/OkH10zWuBfKtFTBXQvE2azfPUGsSKEuz2emYu
	gvFBS69EG6+OkpTAKfZ/OnbGKs0KA+hOk0GimO8EvpVqVrxpQcbm7TjV1thWSoDYS/3FRCxZpj+
	mM+WIXiLsKWcPJzppAjDRwvpsR2LjL17SgJcLGdNxWTUDWhlYD16FVQ8Tzw/CAZQF/hPqHOg9KB
	+QkIcHo=
X-Received: by 2002:a17:90a:e7d1:b0:343:3898:e7c7 with SMTP id
 98e67ed59e1d1-35903849c76mr121288a91.12.1771944296292; Tue, 24 Feb 2026
 06:44:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220195405.30612-1-danieldurning.work@gmail.com>
 <9229d70d-aa7a-459f-b005-695e99888783@schaufler-ca.com> <CAHC9VhSp+X8YNocS7sDz+UyhdJh2yY8CRoi6dwV1eOGdCu9f9w@mail.gmail.com>
In-Reply-To: <CAHC9VhSp+X8YNocS7sDz+UyhdJh2yY8CRoi6dwV1eOGdCu9f9w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 24 Feb 2026 09:44:45 -0500
X-Gm-Features: AaiRm50Bs0-On7LLkESDz1iNdkf3h1DBjn6hYvjZSdJVINzCMBHE_JQir6F04Vo
Message-ID: <CAEjxPJ79V7hM=VnbB1dVA96jjr1yeN9qsLjXb4ALv1VmcRfJ-A@mail.gmail.com>
Subject: Re: [PATCH] lsm: move inode IS_PRIVATE checks to individual LSMs
To: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, danieldurning.work@gmail.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-integrity@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	john.johansen@canonical.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, mic@digikod.net, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 5:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> I'm not going to argue with that, and perhaps that is a good next
> step: send a quick RFC patch to the VFS folks, with the LSM list CC'd,
> that drops setting the S_PRIVATE flag to see if they complain too
> loudly.  Based on other threads, Christian is aware that we are
> starting to look at better/proper handling of pidfds/pidfs so he may
> be open to dropping S_PRIVATE since it doesn't really have much impact
> outside of the LSM, but who knows; the VFS folks have been growing a
> bit more anti-LSM as of late.

Adding S_PRIVATE to pidfs inodes was originally motivated by this bug repor=
t:
https://lore.kernel.org/linux-fsdevel/20240222190334.GA412503@dev-arch.thel=
io-3990X/
when pidfs was first introduced as its own distinct filesystem type.
Otherwise, Fedora (and likely any other system enforcing SELinux)
stopped working.
So we can't unconditionally remove S_PRIVATE from pidfs inodes without brea=
king
existing userspace/policy. If we want to introduce controls over pidfs
inodes and do so in a
backward-compatible manner, we have to either move the S_PRIVATE
handling into the
individual LSMs or introduce a new hook in pidfs_init_inode() to
determine whether or not to
set S_PRIVATE. Such a hook might also handle labeling the pidfs inode
although we'd have to
see if we have enough information there to do so fully. Note that such
an approach will still likely
end up leaving pidfs inodes created before initial policy load with
the S_PRIVATE flag and hence
uncontrolled; not sure if that is a problem in practice.

>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 318253344b5c..4cec73b4cbcf 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -921,7 +921,7 @@ static int pidfs_init_inode(struct inode *inode, void=
 *data)
>        const struct pid *pid =3D data;
>
>        inode->i_private =3D data;
> -       inode->i_flags |=3D S_PRIVATE | S_ANON_INODE;
> +       inode->i_flags |=3D S_ANON_INODE;
>        /* We allow to set xattrs. */
>        inode->i_flags &=3D ~S_IMMUTABLE;
>        inode->i_mode |=3D S_IRWXU;
>
> --
> paul-moore.com
