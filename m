Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA3747B41D
	for <linux-security-module@vger.kernel.org>; Tue, 28 Apr 2026 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777404391; cv=pass; b=DrlUTR1KaCXi5MRda+/TO97voapa45bPrMnwCkYxifhkN8vQguZbliGti4szEamc5OKRzQizc5Q2d75/HBx4PcHIggjW06BuWKU/XgRxIOAmMGreRUiYhdTbmOjy5ha+bwMGgE2AUg1aUuk+32i8KvftrAcHv/DNmKWKwgrheT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777404391; c=relaxed/simple;
	bh=U/O8kY35FSPyilg0S9fhApP710nRPp9xFdci0TwAFQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1EashDP9xKxYAmsIxFVrHswUCYWGtWTb9QU/nV5ztV+S3RirfA3xixP97TPo2l9yZSzCl0RQ/Fae72IGqVd3kMbK9YSk/tkH8//ietAMMTe/GSYX80slAeZXtVHvGvM7mfgllK8Shzx5ceexk4AUSlNPTn5DM9/0dgwJTfapKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q7vwjsmM; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q7vwjsmM"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8296dabef74so9827911b3a.1
        for <linux-security-module@vger.kernel.org>; Tue, 28 Apr 2026 12:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777404388; cv=none;
        d=google.com; s=arc-20240605;
        b=CxsBOBfY506b3H5ikJbaSe24Y5bad/rlruaOnzxEcbK3gKlccDRC2an7WciBtja0UG
         H4pGghfNUtIYlNS3QDFIjr/NeETYLMLZ4jwHU8gnhppsUx6hdC5QV17ZONRqeDe2IW76
         cxxkJy76k76IjIm4A1hKIpPt6HnJAkx8cpwO1v0U1TqLL2PoGsD5AitGZyLbxtQ2q6gU
         9kjR3Pa8hnoYQYknAIc1s/NILyvkDs+0xxX8X5jngZP6gH1IxHSN3WZAa8uFI67qa3fZ
         4e8tzELOlPwtufqZTxY7ofK1ZFubjUpsXIS3Nwe67rTe+oGtwTLXrhEKIkUAzC+9XSfH
         mDFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AnfM8zUa1lWAp+XFfhTnKVtdHMyqVSknxxMlh2RVx+s=;
        fh=z29+L8NSfxf0+vTOPWsLFzQK3VghM9aF475ni8QOOzA=;
        b=RcbG5jtIk26nWexjDG37rXuQ6SXLa5ilIm4BcoolcNyJ4h98vVF/Enr+iSd1h0M4I3
         QsUAJTC7QGSqiX1znJe/Zl7b6mHAa3w4KfzWTa0vlg3UNmSr/aqzZTnTTPUUK+PlkLna
         QM8DNwNiFcdR3gedqTwugtRpNOMS4kSTNQIRpihlpdWkac++ngZcRFK/SRCeudCf6mvV
         8i5rgcsTVBRBQZkhXyZ0BDRBYIX7GMVCrRkRkmdZbPOov5+GDKFSb+4ldYG1ociS/5Qg
         06Vxhlo18WCqG6y022DkImoWnUj4ZjtTfMkNCWfUPUkTjWDYlX0O46vujM2Ar8txBpPS
         e10A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777404388; x=1778009188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnfM8zUa1lWAp+XFfhTnKVtdHMyqVSknxxMlh2RVx+s=;
        b=Q7vwjsmMKcT1l9AXMv9x+KpTvpFxUKicUV6cTZMYhfBbNByB0fZF26MMPg+TFYXldO
         wAJnS+xEWXJ9B32JBTBrBIiic2/TeFFLzWJgSXX971s8U5GdjVU5swP5jQNe/htLdkI3
         ZdgeBBL205oAlmG8o0ZHP3gwEnRf6+CuAq1bnKD7K0LesxTfN2B6HATKPShdePiNxe9l
         5IKU/kkmPcPleMi63gfxcs/0a3ucVgI8dCjkUP2X6731EBcWvHp3wHrzOUzZpdkcqCUB
         hKkLZBo5SE7N74E8O4Q5Nvc3gLmrBdIjySsJTh6B0ctBuAz0XLTvOffHG0QD5sJswMLI
         q6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777404388; x=1778009188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AnfM8zUa1lWAp+XFfhTnKVtdHMyqVSknxxMlh2RVx+s=;
        b=gd/w+WxOTxWnMgwbMkiII4sTHS5gCFCqw7amPvN2Vyow3mVl6PEmSgky5uG3k7ta0H
         lTt53hEI8URQfW4blNazG7SUWj6bb9wpMUZrVs5U9gYp6KY7BUa9ReJZT2iq3Psic7ya
         V3n7vV4Om1jhwINyKkMWdHmFqIPIw9PGm5p2cpLxsUtnlj7vqoIcjk89UZbtLXZ+7pEI
         z5nFrV07E3DqofPod5s5ekp7qMRiCfSas4QCtuSHDlSs3K2x9j/PQ/dzBduMtheibKKo
         8PQeZB89ACAJeFcul4MSttZ6djS6XcXT5Zuxpf1kRAZd9cSIBHQE9syGkJ+owuPlM0Kv
         9rTQ==
X-Forwarded-Encrypted: i=1; AFNElJ9zIQBNPaxCa5S5Z2ySFAt4m83CA1FFCSkKpo/qtu9jtUjyE0AqMAnG6xrrUZlO9PBABtw63hry1E581OXK6ANkQAbVASQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI8CsKAwi2wCJk0nRpg9CeUCrl6Ejk2FNHZ26DE7S/Qkh49204
	hGLVnlMqGHGXbargEH3RCDMMFd6xrlutYXklrFzxGZozNddKntynVNL8aYsg5sjIexS379htzW5
	gATCjeD7nY7YzPscg3TF6vJZTibqc+vJm5By/K0zk
X-Gm-Gg: AeBDieu17l6cKiLql3PGlbIf+RAzRzBw/ZZ2nwpt6qojWAfay/pljWGUtD1NJg7St+7
	Jdjn/0PXhx3v+1rmfg7PABUivODAFn0vEM7DdvuGzaKDeQ4iPPvnYzY4zYdIl/14YnrO9lxDwfg
	bXwSIUGUqL/2LiTkPfKrUzAKf/dckIKXONNn11imOdrE2MtShu2Z9P/sfeIXxaoMM3MYlvWQsKr
	wACZaf9yHYZSTvV2V82nOwlj3UFx5EkjNAmgE/4bAVNr9wlQWmaefJSUM+g41cnyc3m0v1Vx5Sr
	IgIe2Qjd4r3wNmVLbA==
X-Received: by 2002:a05:6a00:b610:b0:82f:5f2c:dc1e with SMTP id
 d2e1a72fcca58-834ddbefc48mr4513385b3a.30.1777404388228; Tue, 28 Apr 2026
 12:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com> <20260428192119.226244-2-paul@paul-moore.com>
In-Reply-To: <20260428192119.226244-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Apr 2026 15:26:15 -0400
X-Gm-Features: AVHnY4JfXj5rdz057afaM2yOoDKKiXKQXh_FDv64DRP8yW2NVR2QdpNqmASHI1Q
Message-ID: <CAHC9VhSDPg2U9UYZ7Na_A8RA-KN8OsNj5S+QwscW6X20tojhjA@mail.gmail.com>
Subject: Re: [PATCH ported/repost v2] security,fs,nfs,net: update
 security_inode_listsecurity() interface
To: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Cc: stephen.smalley.work@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 3:21=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> From: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> Update the security_inode_listsecurity() interface to allow
> use of the xattr_list_one() helper and update the hook
> implementations.
>
> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.small=
ey.work@gmail.com
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> [PM: forward porting to bring this patch up to v7.1-rc1+]
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  fs/nfs/nfs4proc.c             |  7 ++-----
>  fs/xattr.c                    | 11 +++++++----
>  include/linux/lsm_hook_defs.h |  4 ++--
>  include/linux/security.h      |  5 +++--
>  security/security.c           | 16 ++++++++--------
>  security/selinux/hooks.c      | 10 +++-------
>  security/smack/smack_lsm.c    | 13 ++++---------
>  7 files changed, 29 insertions(+), 37 deletions(-)

With the security_inode_listsecurity() cleanup shipping in Linux v7.0,
I wanted to get this patch ready for the next merge window.  As
expected, some borderline non-trivial porting was needed, so I'm
posting the ported version in case anyone wants to review the patch
again.  If I don't hear anything over the next few days, I'll plan to
merge this into lsm/dev later this week.

The SELinux test suite runs clean for both local and NFS test runs.

--=20
paul-moore.com
