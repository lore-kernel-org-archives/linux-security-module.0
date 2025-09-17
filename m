Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778302F99BC
	for <linux-security-module@vger.kernel.org>; Wed, 17 Sep 2025 18:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132146; cv=none; b=qhplyQynFsx2P6RyxsWfidwSUhOKoFHMxUHgK995WkyLzS78yuojJQ++vJpDF9cdyjEbmq2JMV090omMSnnAas9qlwSMz5I4lo4/IhhfSMmEPgMnsddYQ9DaC+juxAO3XE8sx0FQaXlmuIw7GNqh6ekricIS+kKef0Nba5oIWos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132146; c=relaxed/simple;
	bh=c45IjX5cJSPCE8t6J9t1ECSHcRcCXtq2ZmI6fywkbX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T96qb7WCnpBVwXagUaiEZ8BsSQKGlR5VfnUSMg49cLZGbT+mZ8TxM0t2yXedDFQgVLN/wsyNAIkumfRkYTBd3OI+5FCtxAOUubmt/gtuyzK2uOmlEcRWZVLfOk69db42Ob73LJ4AnZAJUfIxi7VCnf+gi7Cp26WnfZiJN3boFsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VagvdSJ2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VagvdSJ2"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32e34f472d9so19819a91.3
        for <linux-security-module@vger.kernel.org>; Wed, 17 Sep 2025 11:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758132143; x=1758736943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUM77tLsoDUjAibRwyKv5SQ08Xu0AqfeFVlC0hwSnKI=;
        b=VagvdSJ2r9uFKGGeClrK15lB2EhNSeeQRQMrictJduqkXxj929ofT7snHx4BK6/r/Z
         SFvz4Xqj62YLBkF9AN9Ruv3FZ1Fn0m9OaaJ+MfBa4dLynGUUUFDZK4jFJlPRTPsN1u7M
         OXKScerVZPGmiX38s8bK0IzVXU1C6g1SHJb8Prcxg+lPbvkIrfftJ9Xi+NOH7aN0Rrb/
         E88X2TTs4jvhY8hzCeL3KyYal3dwqzYVhXUbWeRyYl19UmzBMoDUj+h9fGngS6ZdQb/y
         +W0n7z0lMWkG84oqL0+poSnd8RD99XI+/SZ3P7yuFMlPD+uefxa6H0o2xiBW9zSTQypW
         0Jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758132143; x=1758736943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUM77tLsoDUjAibRwyKv5SQ08Xu0AqfeFVlC0hwSnKI=;
        b=ApgMeneaJ9oWxMtCbhx3wSkep7ZCKxFjaeQeM3s85zgGqHQGwq47Y4J7HqcT1FG00z
         0QYYqa594NpWf+FaawToauLu/zm61OJSwp603XBFHCaK89X6GSgLc4cdTXDKMXmduM1S
         XKRH/zWNp9V4M+dQHruGKGs+flsLtj2dPXmPbxACPem2vt2qpLEulz5o/SpwyDDIZeME
         djlfP9y3j2GR1EAAoMPgyqVLUAz9bvQUlbdb2bQvQEPxjcrn+wmmXVyZNelj4Aj+KOPQ
         Ozq7TIcXDjo+CP1eFZ0kIRq6EaxEAF0iy2uW+OeOtO6nm8UW5Sl+S83KwTwZ9H0xl0yO
         Nc0A==
X-Forwarded-Encrypted: i=1; AJvYcCVJRZ+MNevHHcT/zVDpOOthLsHZ9vGwTYtQ6GaJX77qpLJTS7840G+MG3VhCczODm6cNNKIqFebpIY6aAFPXQuUF6NHwb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFuMtm0O2NV+EOZjqUh2ctyoB3GMffLGndko+wuwzJ87R5Arsf
	j5TEztFKMY+j6Mq95wd9ThI7jGts+x4dYe+dC2fmbT8AW9pRaV1v8hbIBIIUqWOVDfp82Ex+1yw
	fCzNVgYi1Nh0tAZvkWRmWX9DxpI2pYfwXTamj+kS2
X-Gm-Gg: ASbGncu0uZSepsiFtl5JysY5W0e8YEANs4VdNdE3UC6oFcS8BRk5wBF3494rPhENoPc
	mjqHZbemq3l1dVIjY/jCkIjrZwPUw8bTRK5WJzwWGgAwuo7c64G/82AwfuQsSqerpNzMMWbWWjv
	auCtFR9Zch63fF4O/6/pnjX4dl3rwpKk5pzuf+XLTojYxPD3pTUEOr5+hTJstn+YmvhgRX3uhTI
	1A7Vzg=
X-Google-Smtp-Source: AGHT+IHS8hOdCDVgiuUdP/vRW/9oLFhnIxkpzATPwO934ELt+GqvfVJnYqe1LADwkFmuGaSy/4pUKM2P+XlmDtuGwHY=
X-Received: by 2002:a17:90b:4a90:b0:32a:e706:b7b6 with SMTP id
 98e67ed59e1d1-32ee3ecfc30mr3766058a91.11.1758132142492; Wed, 17 Sep 2025
 11:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202509171951.rXOi8Oez-lkp@intel.com>
In-Reply-To: <202509171951.rXOi8Oez-lkp@intel.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 17 Sep 2025 14:02:09 -0400
X-Gm-Features: AS18NWAYbfQp7PVjmPX7J13L8lVmlULdlb1F4ZsAfSLFrxqxS41iXrPrFiQ_TeQ
Message-ID: <CAHC9VhSNoAP98XnBXz681-G-f08ycZULhTZRS6t37Lg1P6qUQA@mail.gmail.com>
Subject: Re: [pcmoore-lsm:working-lsm_init_rework 40/41] security/lsm_init.c:516:undefined
 reference to `securityfs_init'
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Casey Schaufler <casey@schaufler-ca.com>, 
	John Johansen <john.johhansen@canonical.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 7:57=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git w=
orking-lsm_init_rework
> head:   8ea7358ca612bb85eef9179ae746edeb5f1dc9ac
> commit: bf19c9b17d8d2f27e2031822337e8d137b2c6224 [40/41] lsm: consolidate=
 all of the LSM framework initcalls
> config: x86_64-randconfig-003-20250917 (https://download.01.org/0day-ci/a=
rchive/20250917/202509171951.rXOi8Oez-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250917/202509171951.rXOi8Oez-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509171951.rXOi8Oez-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    ld: security/lsm_init.o: in function `security_initcall_core':
> >> security/lsm_init.c:516:(.init.text+0x101b): undefined reference to `s=
ecurityfs_init'
>
>
> vim +516 security/lsm_init.c
>
>    508
>    509  /**
>    510   * security_initcall_core - Run the LSM core initcalls
>    511   */
>    512  static int __init security_initcall_core(void)
>    513  {
>    514          int rc_sfs, rc_lsm;
>    515
>  > 516          rc_sfs =3D securityfs_init();
>    517          rc_lsm =3D lsm_initcall(core);
>    518
>    519          return (rc_sfs ? rc_sfs : rc_lsm);
>    520  }
>    521  core_initcall(security_initcall_core);
>    522
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Fixed in the lsm/working-lsm_init_rework branch in case anyone wants
to take a look.  However, as the fix really doesn't have anything to
do with the IMA/EVM patch, I'll wait to repost the patchset until Mimi
has a chance to look at the IMA/EVM patch from Roberto.

--=20
paul-moore.com
