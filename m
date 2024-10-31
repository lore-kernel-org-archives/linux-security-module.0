Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC3D1D1F7A
	for <linux-security-module@vger.kernel.org>; Thu, 31 Oct 2024 22:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415231; cv=none; b=m0pvVQoClz+Ab531EsP/DzXxkojishgz7untkcIw8WIlMFsA/jT74DwKY0G2+KDDr01FPSQomneYyHUHJ6MndpJnn9oC4FKdWkn+kHMkWnsv64bbGZs41LjMksPo6xMK3Oq584ldAqA4jmsh544Ju1StyK6Bjolec77PZ4+YWYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415231; c=relaxed/simple;
	bh=pHBg4ejpLx5lEeUtxj625TCmYLloW71G3t7gl4zIiNc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=rfiWhCKDVodefCeeYnF9S9ZgEYzU/5SYTjFWyPdr3fkRnZEQlruwZ4wycIEPT3bDRCQbsIzuBhMi6OhhPi03dMXO+kle3lUT1hvimS1HAddFi2kRe2LXQLdRWSyT3ugjoZloqynNmYkpIiT9jYd/Wq35jlH0wCzpElWI4m3XtWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GU2KDx1d; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GU2KDx1d"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4609e784352so9353971cf.0
        for <linux-security-module@vger.kernel.org>; Thu, 31 Oct 2024 15:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730415221; x=1731020021; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udTVBIR/QeqJ5ZiBMjmwgfafaCOXQDv85YKhtLP6cZI=;
        b=GU2KDx1d5dARQcuOS0sW00oJIoutfiKIOAAIaJwXL1C263gPow7ZkE1eSKpnTNKkO1
         R86yd5vTKtDC+79sdTvo+X8wXcbCpcmDGOLg14r/TgWtElaoJVl4gA+fetLAyI8j+Kb9
         j5f2EnbTnhcHN77GwJQd4cE4D/NjekIDjc+R2BcljHCpT1Rs6mCkeuTeeI3ZpPtoJmIx
         2yZU7cbY6/eVACESD0PGuLD5d6Pnn9/HiFiF30jmBl1CYEhrk/BX7x0pStMuQQoC/1k7
         fezmZZO6rZ00vp+NSDdo1XIhstpWomKyodHeAVwh7nTXEWEDLRZQmJpmuVCqp02HTU0M
         WOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730415221; x=1731020021;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=udTVBIR/QeqJ5ZiBMjmwgfafaCOXQDv85YKhtLP6cZI=;
        b=unG1JkBN61uR+KXv1SmKbuV+ArMM/4X0D5lo/O5o2/PFfF2RZVj2PEKFro8Bw1CJE+
         /ww6hF2de9beIr2j/bnVFF+aHzEemEERJuDBm2SyzMlu7fCFgTCV+tfJKuuMgLtxMrbr
         BeT3IYd1GqU7KhC1DIk6wSbjM65Sn9tYeg0DdqQOygw/k2P1ati9gKQurtugjOQyXRTv
         zHOB9SkRjQNudEFIyVRVm/0kRKS6HwdEJTLylGKa+av4ZIQdSLUUOXnQ06wkKWmnzpjc
         SSLSv8uYeZhclyijetRiKkIKdgsxrJYM7FbO0hpKolhaiJn3c5lk9KSx1SDA7KjishjI
         Jztw==
X-Forwarded-Encrypted: i=1; AJvYcCWLGEZb+hOds6NP08ktap3msJ1otnsWmGNxXnv9MqIxvDktP+qpX0J38SB/SHbHvwwQx3tqQ8ZyeRXN57pcYabA6CpL3VM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywec6O1rJcihz3huIc7jN9NQmlFWzzZOijc6vjoEGTL+lEj9NgZ
	pXo9oWmZV4edHvMKWffeI4LwFKmVP+POv/WmEO25DaQq7T8y5NLuvT6gNwJ+gA==
X-Google-Smtp-Source: AGHT+IG4RK7zrIqYSfQlaLi2Jn/fcR7Wi85MclzKEW7ddmJvzAaqeYWrXlsvLQLcYYERuWLiK1/Vvg==
X-Received: by 2002:a05:622a:188c:b0:460:e7f5:1bf with SMTP id d75a77b69052e-461717c4602mr103322611cf.51.1730415221615;
        Thu, 31 Oct 2024 15:53:41 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad1a12b4sm12324511cf.82.2024.10.31.15.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 15:53:41 -0700 (PDT)
Date: Thu, 31 Oct 2024 18:53:40 -0400
Message-ID: <6c1de7c79141034433d6eab515bcef43@paul-moore.com>
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
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 4/5] LSM: lsm_context in security_dentry_init_security
References: <20241023212158.18718-5-casey@schaufler-ca.com>
In-Reply-To: <20241023212158.18718-5-casey@schaufler-ca.com>

On Oct 23, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the (secctx,seclen) pointer pair with a single lsm_context
> pointer to allow return of the LSM identifier along with the context
> and context length. This allows security_release_secctx() to know how
> to release the context. Callers have been modified to use or save the
> returned data from the new structure.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: ceph-devel@vger.kernel.org
> Cc: linux-nfs@vger.kernel.org
> ---
>  fs/ceph/super.h               |  3 +--
>  fs/ceph/xattr.c               | 16 ++++++----------
>  fs/fuse/dir.c                 | 35 ++++++++++++++++++-----------------
>  fs/nfs/nfs4proc.c             | 20 ++++++++++++--------
>  include/linux/lsm_hook_defs.h |  2 +-
>  include/linux/security.h      | 26 +++-----------------------
>  security/security.c           |  9 ++++-----
>  security/selinux/hooks.c      |  9 +++++----
>  8 files changed, 50 insertions(+), 70 deletions(-)

See my note on patch 1/5, merging into lsm/dev.

--
paul-moore.com
