Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3894ACC8A
	for <linux-security-module@vger.kernel.org>; Wed,  2 Sep 2026 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377710; cv=none; b=WAJHsLC6Hr1gHLlxIeTic6EYAZCX6E5DzRwRCgKm+dC0dXtyZMfUvSx8ZfVbgg51q6M7vMuHS0JFCHzQRtwIIfwHLN4IKuDjADJttbfBd8YBZr3/m0NLgSk0EDB7Gr+iuYyIlG8AjOWKAhHd8aIT5T0DkOSA00p5TIvSHAk3inI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377710; c=relaxed/simple;
	bh=eh+it0zb54ufEP/JnblEMEpySL7Prj/F5s/H28111ro=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=sc5HeKbU8sLeZte9o9bScib4qMJtLF03r9qwhICYKL8n0zpYYQE0fCcD6dvqsLLhJVRYGupGXJrG/zDwSqQn/aswTe9H4lIu7zXJx8sZ1VlUl4Gtak/ZFrkkRQNaEV8w3OywxEeawK2QB4y0gOtJBkASaLDmBSCr2TQc3oqRfuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BApmi94N; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BApmi94N"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-90d7fa95a58so12990936d6.1
        for <linux-security-module@vger.kernel.org>; Wed, 02 Sep 2026 12:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788377687; x=1788982487; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GJ6syoQl7zUGKH+u6+bqTcHjjLcFH2wSt0NVpBp7lDc=;
        b=BApmi94N0haia63+fWtF0lO8gtf7CPbnhyiBUjO2IH+nYwAJb4uJXYRK7Cr6JJKpFk
         YxGptCgPyiA1YZmnPhS3FOGlqVAlbkwTb/eVF5NtLCuLuSICFUx37nq/Nns4yNA2zgH0
         CFYc13B4d2J1cC4nKVeZUp+yNmFJrn0DoYd6ScYOlVDpCIQWM8wV9IJ51HJQi6KW+GVF
         nI2FzCFnKFMfXHpWkki8P6hmZ4q8a2BhC/Xez0+PIPWLa+R4Uc0B91tXHiwfcP+6AsP1
         FRMH/M4HjtVOxsSROaRN5mJYZjmLY8FnTjlOzEo1VRpzChFgoAHEReRUhVrJL43U/Yma
         Kkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377687; x=1788982487;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GJ6syoQl7zUGKH+u6+bqTcHjjLcFH2wSt0NVpBp7lDc=;
        b=BHNexPYy5Cj9Bip8c5eMUunCzQTjXr0U1EAWs8eBxT1/97klg7xbrIH3XSgMAlqhd6
         FGUkZcVsy844yahBhaX3GjcvSXnjXhO9uof2s/50BEzAdzxBYWFmyV6zfW7eW6gAoP1B
         fDVXYEXvYgEr0IWckcI2v59zqCCJefVGQtxCVh1biWmMjQMuPrHgbHea0ts5IYioyssg
         T069UgNxxhYq/zR020GRopXCclBz2ml8ZJoiGCmmr/UD7DVplp6ujQbFMQDlMvDZ9GDp
         Y2fWVDY9S5Yfg8JkJYJGgyuSVJZQf4lFHzPEdwWoTYra3LAQtCU/rEDYuJijMxbwO+/M
         315A==
X-Forwarded-Encrypted: i=1; AKwUvBzmHcxb82m4ZpaJ3zXJPZuDX8n+CKuXf09CC3EmBrNgAxZQw7TbrElCVoAHQnWanCeGaPy8I2xnSUPE/b8XwY7ruXz+12w=@vger.kernel.org
X-Gm-Message-State: AFuF++kdzdAFIqmRBhhrIKrNfBhQcBN7b0Hte6qLtuRlOWgBg1oAc+RR
	sxjpUs12nrJnl4RHNSvfUVcVARkSxJnIdvfNpRXcF79gRxBDSMbPnfv93yqj5e6Jyg==
X-Gm-Gg: AYBFou0YwmgfO3n9TLD73n3R6JjsLdZ6Tq+DTTS/Xo7V/bOjjqS8A3gceRm+h3/S838
	bxBeA+czAXnqdaprRLzJMLb756rYYi9NMi8Gua3ankCY2JofHRC+ZYfRkAjVPIps/hCNSbNM/vL
	gboa+6823oUaw134FfOghEchk9Mn3egqydBZ/je1EyneFRjMJQkFzkPqn9oK+d2ZJGJoCUhvlfV
	Qbo04AR3iBMyltVENsVDr8lrNRXrlyyOeLSmPCkrNUqU+KbDEv3f4dpcqH2zc6dAN1ovFSgnkF4
	kn7OOBW88Xvbn1KoLnsSBVEuefEXjvr8HcFEJBik6lwiskjiojpkNYf7IUdPAdO74aCM0iusrEU
	DEsWTvUXgi7FRuy9+x//PGB7oWjICRyHindDt0o/zxUEjFTTj8dohwRCHkVhmbr6cWYiHXFGyU/
	95o6sV8cUHChwItM7Ln5sNZ8Rt/g0AdajKPpKyP0M/vx8UUb3bk3Yx5b3vTDAsLTHp8GPGp+PeM
	neX6QwzG2IWyCR4mKJuGgqgg/QlwQlG5g==
X-Received: by 2002:a05:6214:e85:b0:90e:7de2:d81f with SMTP id 6a1803df08f44-90ebabbac8emr90744936d6.20.1788377687526;
        Wed, 02 Sep 2026 12:34:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm25176366d6.2.2026.09.02.12.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:34:46 -0700 (PDT)
Date: Wed, 02 Sep 2026 15:34:46 -0400
Message-ID: <e266759fa7a20e9620b16c1b5a717744@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260902_1319/pstg-lib:20260901_1604/pstg-pwork:20260902_1319
From: Paul Moore <paul@paul-moore.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Seth Forshee <sforshee@kernel.org>, linux-security-module@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: Re: [PATCH 11/27] fs: port acl to const mnt_idmap
References: <20260901-work-idmap-const-v1-11-54ccd48e100b@kernel.org>
In-Reply-To: <20260901-work-idmap-const-v1-11-54ccd48e100b@kernel.org>

On Sep  1, 2026 Christian Brauner <brauner@kernel.org> wrote:
> 
> Convert to const struct mnt_idmap.
> 
> A mount's idmapping is immutable. The only thing that is allowed to be
> modified afterwards is the reference count and that is hidden behind
> mnt_idmap_get() and mnt_idmap_put(). Everything else only ever reads
> from the idmapping. This is the same model that struct cred uses and the
> idmapping is also rather sensitive.
> 
> So make the idmap argument const wherever we can. The conversion is done
> from the bottom up so callers can continue to pass a non-const pointer
> to a const parameter until the conversion is finished.
> 
> No functional changes.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ntfs/ea.c                          |  4 ++--
>  fs/ntfs/ea.h                          |  2 +-
>  fs/ntfs/namei.c                       |  2 +-
>  fs/ntfs3/inode.c                      |  2 +-
>  fs/ntfs3/ntfs_fs.h                    |  4 ++--
>  fs/ntfs3/xattr.c                      |  4 ++--
>  fs/posix_acl.c                        |  6 +++---
>  include/linux/lsm_hook_defs.h         |  8 ++++----
>  include/linux/posix_acl.h             |  4 ++--
>  include/linux/security.h              | 16 ++++++++--------
>  security/integrity/evm/evm_main.c     | 10 +++++-----
>  security/integrity/ima/ima_appraise.c |  4 ++--
>  security/security.c                   |  8 ++++----
>  security/selinux/hooks.c              |  6 +++---
>  security/smack/smack_lsm.c            |  6 +++---
>  15 files changed, 43 insertions(+), 43 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com> (LSM, SELinux)

--
paul-moore.com
