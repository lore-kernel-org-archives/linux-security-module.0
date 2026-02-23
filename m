Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABFE378826
	for <linux-security-module@vger.kernel.org>; Mon, 23 Feb 2026 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885304; cv=pass; b=VnQkVrz5eg1NMcZOu8C66HEpQNUhN2f5Xg1znbI5Xi/D3ybm61gWvubP+gmKkFcyDgsm0owJfAkVmFbpnMSOS+VyEOAfvSKdIMycYmOEIuifO6ouSi0hYSUtJLwW1XVXJa15IoLMFijnaW+wIVTNgo/vFAUuNBSwgzZjxjstWZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885304; c=relaxed/simple;
	bh=laA8fxKUOs+Cw7EhbSLmhA3l6QzLfOUFVFuQ38rQLqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qE8EemtDJ1dnTzNeym1V635/dxJ+R/Ap1ezqzlEkQ7UsUMoeTASXu2byDqb+hsr4LggwAK7HulxcsFNqjzDhNgzuDpmjwc/k1JWRtbMpgdyvCbiIlsFTmmRMgZuHe85caLe/8rerrYwINpJzXhNC6IE9l66t/Q2SZsCGXZItQXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CSZuTDLt; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CSZuTDLt"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3562e98d533so2910514a91.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Feb 2026 14:21:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771885301; cv=none;
        d=google.com; s=arc-20240605;
        b=Z/wEGh3Rj6FUkvwgFEd05d1MxCMVvjz44O2S9tXXzux9vbpiMY46f565VZhai/MpLr
         U3lAerg1dilJHCm0Wt8SOMMcI2EFErhDK5ZHl8nmPC0BRZu9GZTyJl4uSqrPX97Xuxj3
         IvfkcDuYhjcXMhx6tOgk9hku3LtSa8c6t912KUDR5nHiTfJJwEd8qjPLfXCq3rwnDErt
         vXVtfIybfzu3yXGLJkD2Ow0UvduP6wXftEgqDDM6UAv2YvqMOzlL0UBLNvUgscynZq4+
         IJE8j85pL4cg8j1LOkmxG1eSiLFax5hU2YlRglFZMtfPUEpJHuARrCllcZCqx/yAyWne
         EPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k9ZYfImaDpyTe2L1+2pEtc6yTABcUBTwYO7vVYurX8o=;
        fh=cUE9c2eLnnSWMp88Bc9ILhXbkhMsxEDaNLvbe++dygk=;
        b=KuJANTtz9LrAqshXNOhhuTlJphzfSafsJ8O+m2hbd2/FKLRMaxL6Mk/CZB1gOXkEqd
         mXvR/dgpFD53Dzy5oLZVOd9gzisssH9Yw8NOq8R0NHxs2A2jI939YfsexjjnLMy9FedD
         XTOjGYMslQOK+ZVnfN1xj8hZj3Y3Q1kLWgcD6OsbG53AJ0BfYw5ONWh0CSMmMpbgiNuc
         Y0MMqqyA07G6g4m5x4uTKH1w0PVDHKLnhbBFlo4gZEkXz5YUzrW2LOvuUttd4lVZ3Mme
         S9+vnbpbwoyHdaDX0igjey6BTI0Z5EtBdjsecfNJe7l86AM/KRK9EbWHqbr3DddzC89G
         NBHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771885301; x=1772490101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9ZYfImaDpyTe2L1+2pEtc6yTABcUBTwYO7vVYurX8o=;
        b=CSZuTDLt22UDdxVqNRHk0BvF8nUM5UfBRwe4Uxyi4a+mE/iwe803jR5iN3CHGpRJZR
         +N9/vcbV+OT/trIi/0KyeVgobl2NBvdBXSvNbkllMzXUp02ba7IyJmQEyQjfY4P8BmqL
         oK1qN8nlmBECXM02OXCowJ7hX8JrHqAi67bdM13E3SCXTu1VBoej2T49757ojsgWWbTi
         /xksj1wJqb9xAKaq9EfBKOWp37fuhfBxP92oo7hpP0uzdnBnhwrzaEWPEIcHjDo4hhDM
         lvhahe2Mei4ot98C0QgSdJn33e41ILmeDh5uGtsWQtxKZKEqO9aleiuB3aUKTp/d88Th
         4OrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771885301; x=1772490101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k9ZYfImaDpyTe2L1+2pEtc6yTABcUBTwYO7vVYurX8o=;
        b=gjcFq0L0TxRrBYDLoRa4UZ56XTYhaLT7PY/xwAcInJT+wq2/zA3zkQL0WpcgyRnBZe
         pCV3eplK2aqWqyCtne418VOEPnu3JF7wBPl6fiolMW5W6fbJ4SDewUgDVPOeeEfTvDhR
         9xu84oIzX+JPM+sUtYeYnWQjISxR7AaFgWvUoHfZVF71IMKgVQqo35DLNavRCxCBCHF+
         UH8rCP5Vxn0IWwJXodj+q2oFD7GFL+CeOVkdRKUrwsozR0e/6PYB8oBdsw2FaqO4qaAb
         drZTukPxPthsUeP338pQhWfAccY6tAjb7QgZF0J9lMYcI4/VyAVUp5tOkIV1rpPplKKo
         ksGg==
X-Forwarded-Encrypted: i=1; AJvYcCU58bGexpepEdiwAOhzRuiVMT5EZbDvWaf+x/r0av2C6SnFVjVkw9VgdIm/JdTguapvOqBhZZcmy51iN/08DGv0jNIste4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFbxBdd1kyzYu5kwZEQRMhXwzcviMwOj88+7bSzgV5n7tyxOSP
	j5XW1vcTlxVxb7Elfaa72QEjSl/37d+qq2CHJpYtdxj7POMQ4RdLzReb9ab4JKco8EPmkUdLXGc
	9XOn41OPfDxKPPGGmDRc9Gb7gnG2zXtEtcvuwOkjd
X-Gm-Gg: ATEYQzyIkZgcZ/ok71abmoEt3S9DeQNGc3TQw+rtsAowx+3mFe4ZkwY0r+AiNXcwqk6
	qTOBZ48fePNgqCIhnHR8lCGaPxnw9TQtbvdmpJnud+OtQcjcu0wLxLLI+4EoXLaFXuXWaNxIFv4
	alrG5UHjIJ6GKIC5vo6uOv0ZEpmi9T4aih0wPNy3+sguWgjk1wK/dneu9/3616YRetNss/304FS
	tN8fB6G/didfExVndLzYJ7zcO/8CX2sX/BoB90zxIGo3TlCLL4BE93d41EdNstv9uT3CiEj8gbH
	FrDCSPpYw/CWlegITA==
X-Received: by 2002:a17:90b:3d46:b0:356:2fee:92cb with SMTP id
 98e67ed59e1d1-358ae80a6b5mr7566836a91.8.1771885301191; Mon, 23 Feb 2026
 14:21:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220195405.30612-1-danieldurning.work@gmail.com> <9229d70d-aa7a-459f-b005-695e99888783@schaufler-ca.com>
In-Reply-To: <9229d70d-aa7a-459f-b005-695e99888783@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Feb 2026 17:21:29 -0500
X-Gm-Features: AaiRm52qgdM1-bPMDqdvit-s0syTJEbYBD7y07LXgBdLcQeQROdMVa1XCyRpsj4
Message-ID: <CAHC9VhSp+X8YNocS7sDz+UyhdJh2yY8CRoi6dwV1eOGdCu9f9w@mail.gmail.com>
Subject: Re: [PATCH] lsm: move inode IS_PRIVATE checks to individual LSMs
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: danieldurning.work@gmail.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
	stephen.smalley.work@gmail.com, jmorris@namei.org, serge@hallyn.com, 
	john.johansen@canonical.com, zohar@linux.ibm.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, mic@digikod.net, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 4:13=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 2/20/2026 11:54 AM, danieldurning.work@gmail.com wrote:
> > From: Daniel Durning <danieldurning.work@gmail.com>
> >
> > Move responsibility of bypassing S_PRIVATE inodes to the
> > individual LSMs. Originally the LSM framework would skip calling
> > the hooks on any inode that was marked S_PRIVATE. This would
> > prevent the LSMs from controlling access to any inodes marked as
> > such (ie. pidfds). We now perform the same IS_PRIVATE checks
> > within the LSMs instead. This is consistent with the general goal
> > of deferring as much as possible to the individual LSMs.
>
> Um ... ick?
>
> Sure, we generally want the LSMs to be responsible for their own
> decisions, but that doesn't look like the point to me. What appears
> to be the issue is that pidfs isn't using S_PRIVATE in a way that
> conveys the necessary information to the LSMs.

First off, consider this the annual reminder for everyone to *please*
trim their replies when discussing things on-list.  Everything is
archived on lore, we're not losing anything, and it makes things *so*
much easier to read if we don't have to skim over the entire email to
make sure we haven't missed any comments.

Now, back to the S_PRIVATE issue ...

I was the one who first suggested (it may have been on the SELinux
list, or in an off-list discussion, not sure?) that moving the
S_PRIVATE check into the individual LSMs was a way to work around the
issue with pidfd/pidfs, so please don't blame Daniel for this, he has
been doing good work trying to solve a rather ugly problem.

> > This reorganization enables the LSMs to eventually implement
> > checks or labeling for some specific S_PRIVATE inodes like pidfds.
>
> We could consider these or similar changes when that eventuality occurs.

To be clear, that time is now, that is just a dependency of that which
needs to be sorted out first.

> I would strongly suggest that this is a pidfs issue, not an LSM
> infrastructure issue.

I'm not going to argue with that, and perhaps that is a good next
step: send a quick RFC patch to the VFS folks, with the LSM list CC'd,
that drops setting the S_PRIVATE flag to see if they complain too
loudly.  Based on other threads, Christian is aware that we are
starting to look at better/proper handling of pidfds/pidfs so he may
be open to dropping S_PRIVATE since it doesn't really have much impact
outside of the LSM, but who knows; the VFS folks have been growing a
bit more anti-LSM as of late.

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 318253344b5c..4cec73b4cbcf 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -921,7 +921,7 @@ static int pidfs_init_inode(struct inode *inode, void *=
data)
       const struct pid *pid =3D data;

       inode->i_private =3D data;
-       inode->i_flags |=3D S_PRIVATE | S_ANON_INODE;
+       inode->i_flags |=3D S_ANON_INODE;
       /* We allow to set xattrs. */
       inode->i_flags &=3D ~S_IMMUTABLE;
       inode->i_mode |=3D S_IRWXU;

--=20
paul-moore.com
