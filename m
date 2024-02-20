Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28B5154425
	for <linux-security-module@vger.kernel.org>; Tue, 20 Feb 2024 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469834; cv=none; b=cwObVjswuP9IauoAQGEBaEs28UzYua9oXjSbzVGNB7LouuMO+3f0a1WhAk4YwOn6HAqItJO+8eLkReuExROWq4ngQH1WML0gkmyaeOYYSAK4xKKKmiqKnb35a7/7JWTUd5zuJ0N1zIHw1Ad7nsO/yGRfpSL05H6VL+CBaE2XRXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469834; c=relaxed/simple;
	bh=0YoTDIJcncc26mTV5po/0I8NONU1TIZscyHen9QSqfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdXHqGLs9OWJjiPLRdQ/8GwGTxcSyJA56gcprLWthEEePFEzLp8zjoOaHHDSkeRYrexS56iwyvkAtIXnRsXSDUlS+HSSuGuIhbJebZnixCSkIyNG6e737DGRpfgp5fwTNv7vRYmPvdVZKNEWApcoiwI/AtqlXMxFyBjCoqJIMjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RpAGfWLP; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RpAGfWLP"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso5733773276.1
        for <linux-security-module@vger.kernel.org>; Tue, 20 Feb 2024 14:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708469831; x=1709074631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJd9Z95KHyUDEhlhjVDF9yk1T1M4Mk1fPdy0+yG5dqM=;
        b=RpAGfWLPPDa5nT1skE2IjquSvPCpH4XDjqXhHemyIuLz/hdLFGrOI1tMaygPMyiCVs
         q1vL4So8FLcrldPFKwFwxHFIOlY3Tn9XtYh0dp0OU9mZt1hPj1KBXbigYV7RhBWQ72m3
         /5oWhtMSkEItzPCnERUndzCdoGbwMpLUX4LwXn+8CwqgLtjgehsJeMbx8stcuhe+DiQq
         9DTWoLBnlupgUmDPko6bERx8iVPqd/o3z4lCax8zyHitOjbWF5QwbAOx1z9SvZjJtvoX
         Va9Q7470lI85S94fjTf32AqcWVxq857I6+nq+RDXXdOmVqQUPU2L2VNe4GAXhWQ8FpVE
         RPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708469831; x=1709074631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJd9Z95KHyUDEhlhjVDF9yk1T1M4Mk1fPdy0+yG5dqM=;
        b=FhHxEpdIZDEJW1QrBSXuylAac+OYyFH8SP5kKE0mxEZ2ictms1xWfKpsVq8kQc0zAO
         ZDgBe8YrgsSu/dve39+GbN84+kiLN44XhV7RUCUzOx/mshzNdKF6wsrwYyLK0SyQQk/O
         gNcfiDe5q8QHJ1XEfpyu4XMJr26I8cJgSCzVerQDEqtnBZLWvmZ03azE51XgcQrbdFNZ
         nPHVviRJ/WEFhin1IaxRVCnrPhxPIaBGWgYvVjE6QoC0PBzwYdN6lFnxYh/t3iPdV1Gw
         wClQOS+pIijtjj0uU5+VgUNXWakpgcWpKPHfbRY4cpg9KchYORYIIfIIfgO0I/C9v0GE
         ZGCA==
X-Forwarded-Encrypted: i=1; AJvYcCWnfabUovi5PJi/GywxKc1iAY/Qxoa4C8FUDgbnFIUheCCZGY/4WFdMPQJkEWHBmWLa0WlIDQCi/epYMBnKF9ZGcq+nx8ykgljoeuN9/11D+wPurAhE
X-Gm-Message-State: AOJu0YwKG9pZZX5LmeEXqJ/sSzdNRVfZDCqq5sWDWxX9ASJVr4nIm/18
	PuNTGDDdFgPMp1PnBixGHrHlvR41B75IcCus45YxO5Mc4rZWymDzn1Z3E1hBp4eTq7uLccwv2Ve
	H96/xqwjKW+GPyutdL57EYGpuyHlUCdTii/e/E73fN+t+ico=
X-Google-Smtp-Source: AGHT+IFHQeTBpph6bd5Wo+fr48nsOpy94ua8Yw9g49gmhGuBFZaV/bAGvI69UADzVdw79h3Ed3LE/pbEkd6/IuyV7L0=
X-Received: by 2002:a25:ef0d:0:b0:dcd:ad52:6927 with SMTP id
 g13-20020a25ef0d000000b00dcdad526927mr16249258ybd.11.1708469831057; Tue, 20
 Feb 2024 14:57:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205182506.3569743-1-stefanb@linux.ibm.com> <20240205182506.3569743-3-stefanb@linux.ibm.com>
In-Reply-To: <20240205182506.3569743-3-stefanb@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Feb 2024 17:57:00 -0500
Message-ID: <CAHC9VhQeJGjm5VCF84W_u2wRZxHtWPMt_Ku-NqJpXUaA53EtVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] security: allow finer granularity in permitting
 copy-up of security xattrs
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, amir73il@gmail.com, brauner@kernel.org, 
	miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 1:25=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.com=
> wrote:
>
> Copying up xattrs is solely based on the security xattr name. For finer
> granularity add a dentry parameter to the security_inode_copy_up_xattr
> hook definition, allowing decisions to be based on the xattr content as
> well.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  fs/overlayfs/copy_up.c            | 2 +-
>  include/linux/evm.h               | 5 +++--
>  include/linux/lsm_hook_defs.h     | 3 ++-
>  include/linux/security.h          | 4 ++--
>  security/integrity/evm/evm_main.c | 2 +-
>  security/security.c               | 7 ++++---
>  security/selinux/hooks.c          | 2 +-
>  security/smack/smack_lsm.c        | 2 +-
>  8 files changed, 15 insertions(+), 12 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com> (LSM,SELinux)

--=20
paul-moore.com
