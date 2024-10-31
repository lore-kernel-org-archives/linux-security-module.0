Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6631D0F7E
	for <linux-security-module@vger.kernel.org>; Thu, 31 Oct 2024 22:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415232; cv=none; b=AGu2GNxWJDDLU/zMAiAQAeOuSJRpafOmpQsGy7cAjVuBSvlVp8jRI001KlrtPjCh0SxAJCS/oezBZy5a2r/5ZiICBWlPGOS1mRjLmshTa8nusoL5Hi/b+z7PcHIAAAbO6bShVnSjet68plYmwSOfO1KIbaF1BqLGRPlZoMXLgJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415232; c=relaxed/simple;
	bh=BDJdR5tVzmh5dizUpgrVvPq8LICL0s5XylwlqyMeGjM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=DZWbYLwn+K4Yw9JBJFz61q06mb5AaNjkPgFyaHztW+UKAWZEbs37i0c2vnAXC4inbkWnUpLjBHZ1dmGETBtxyUK314Wuq6W6PVxxS5dz9oKrPW946fZ0Nni3YOH8Wph1e4lPUxxAbehJqSZowrtND5z4bv8AlTufdW3qikkg2W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CTnMub5d; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CTnMub5d"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b155cca097so123566885a.1
        for <linux-security-module@vger.kernel.org>; Thu, 31 Oct 2024 15:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730415220; x=1731020020; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMeaJ3dGSvREgbPQf+JCmGH6FTTejL81SGUx/vgLdsc=;
        b=CTnMub5dVwuBSTlgfxp5Q+Nt0Xs2d7LU2Q1PT77d6vOhJ1s0rT00Rnnu0R2SQUoDUp
         NBtQ8JUYtg/EExoymmtCvx7OVz6EUU8XST4xeOlVNMQomDYor63PXjWQLjPgWmSJ5C0v
         jyqSXg5AD2vyHhmYiirzLQIBLy9hcMVsX5wCt3+pzLBk2izXlM6GAp8OaOa6wVWCGfGv
         /PmdJBnnnTKX93sUUQ122cJDomNb5Ieq48sKGfNJEOP7HoLdVcuqSRcwtz1TfvqBFEUt
         0fCT3pqgeOoAZOq3+o9eM2FKhzx58GAdTcRdW9vcOzdlgVjvwNaac6KwKN09nW6+tu/I
         a+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730415220; x=1731020020;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yMeaJ3dGSvREgbPQf+JCmGH6FTTejL81SGUx/vgLdsc=;
        b=BQo9Yg4JsdbfhUvS4blnfZBT+qW2pzOiGBP2YJjJLV73ZkTVUhCKvtt6NRTT+b4nD/
         nGkEgMY6SOVFxCk3RnPgqmjmcMtuOmFQRVUTGmsN034efT+ooWTJPAhuF5B0twlCrWm/
         Xe438YipWauf4TfmVzkk0si802D/Cv6j4SfqaFvLXauZXABNetrodQCrmYNvIzYWui3O
         gqGPSPJinIUmW0wDXAKxVDEA98PQYSXD3kX+wT0iPeoa4feBFq359aXgE3tUzI1XbuBE
         NTJFJXBGNGqAbCY84Meuq97zB7tHoOMdjXd8n3Snny/mEbzwPWAlb2tpHs9UkHYcDBzF
         YmSg==
X-Forwarded-Encrypted: i=1; AJvYcCW/dzyvi/9Nudtxy3vH5sOdwA/1rKI8g9FaXfPrpOYELJcDNOfvldl+dChkp4PXlLBmw7eLgyCNPbxmZYSb9QTjB9ZAEFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTgM9rUZ9fYe91MxgpRI8qbEXqFkGT0cUKP3AQxGIlwOlR0rLn
	qQ2JPX5GNIy7fJR74fPH2RpkOgiYhYy+C5DuDJNZ2w8SYzNq5fZAl3ad1713pJ20r+eU7gSiSnM
	=
X-Google-Smtp-Source: AGHT+IG+igldW75wPFcvIPuMqdxa+k8g3IwKJeTuYvaI0vnsn5mlrSCaSUavQE103p36m8T74a9/hw==
X-Received: by 2002:a05:620a:2956:b0:7ac:9b07:dbd3 with SMTP id af79cd13be357-7b2fa60b808mr303815785a.5.1730415220453;
        Thu, 31 Oct 2024 15:53:40 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a9ae1bsm114481885a.123.2024.10.31.15.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:53:39 -0700 (PDT)
Date: Thu, 31 Oct 2024 18:53:39 -0400
Message-ID: <5e5c5e04ff82a8a8e94f02ecbe63b1fd@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241031_1534/pstg-lib:20241031_1459/pstg-pwork:20241031_1534
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 3/5] LSM: Use lsm_context in security_inode_getsecctx
References: <20241023212158.18718-4-casey@schaufler-ca.com>
In-Reply-To: <20241023212158.18718-4-casey@schaufler-ca.com>

On Oct 23, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Change the security_inode_getsecctx() interface to fill a lsm_context
> structure instead of data and length pointers.  This provides
> the information about which LSM created the context so that
> security_release_secctx() can use the correct hook.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-nfs@vger.kernel.org
> ---
>  fs/nfsd/nfs4xdr.c             | 26 ++++++++++----------------
>  include/linux/lsm_hook_defs.h |  4 ++--
>  include/linux/security.h      |  5 +++--
>  security/security.c           | 12 ++++++------
>  security/selinux/hooks.c      | 10 ++++++----
>  security/smack/smack_lsm.c    |  7 ++++---
>  6 files changed, 31 insertions(+), 33 deletions(-)

See my note on patch 1/5, merging into lsm/dev.

--
paul-moore.com
