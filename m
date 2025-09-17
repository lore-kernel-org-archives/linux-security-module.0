Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE642FC016
	for <linux-security-module@vger.kernel.org>; Wed, 17 Sep 2025 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132146; cv=none; b=gBXlqQ0DPpnTcfcqi+jmaMZ0rkvOss3/bzwjZOYzSMuin3q1LtN77Fex9EZ6GVHo/qDnn79lTADLdQaXX2BWdmctV38xr6KxtRRrlHMmHsM6cZHNNbDaMjNRS8cdam6mjJuUTs6qDDdSPz1PzRX8iItZbsz2QVuOE89oldg1Dd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132146; c=relaxed/simple;
	bh=UXFAbdLkx06vhXtJ2G9AYBOhckkAb0k5X9bYRyiDHNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlQQrHKcO8zhflGCABMXKRPptXNHpj52oOXzA40wZ+KkWPtj+kp9FHL2qUnb9yQPJOJHmM+3M5LVCkLNB8b+XwlYLfcXSJn3vNIxURq+J+DkvoA0ly7QTTdWQhA0s2j3ZoRtXU3QQj/+qqrn/jHG/ldcasXYbkkCChLiGR3SGW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dR9sCdL0; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dR9sCdL0"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32e34f472d9so19834a91.3
        for <linux-security-module@vger.kernel.org>; Wed, 17 Sep 2025 11:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758132144; x=1758736944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1onfRQv25gQoZTEI++MVbVbx4XYqJDW3+flsFFULcl0=;
        b=dR9sCdL0+Tnoyi4ZHFB2E8vwQwszv3hC6sUvFg/3Eg4C0gow2LWcqF0kB7x7gENsTI
         KlDO+BRy3HygbWeii9bFeSL8JW24RKyJLzHpXR3JEHRH1trHUTZCD3gMBl0+jVOuJlLY
         +/q1/T/wr7+Gsyu4VC4wor+rRUTRZwmW6y+Lgngh8B3Gm490CLeVLWzU4VCi+z6feLPV
         6NeSdKY1ryIOvH8tVOBVZOSW6e4qGxx6DzxWXXP6UOrxVWxe+4VBMWH1Ma0jIbMfl/q2
         0FHW1iEmUcVjvcfvtE+oZTr6uPhv1VYkNSIizXrcCO0txyvS5Gd+5obfrk3wVq6o+DXG
         W9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758132144; x=1758736944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1onfRQv25gQoZTEI++MVbVbx4XYqJDW3+flsFFULcl0=;
        b=kvRTBNVy1Xj320SQjTW1gCQLFys8Rd+KYyzW5f86qQcr8YYDeJRMajwbf56NDUHXqL
         61dLLYNoYfrpLNOcdimQfDZMddS3fEtv2Z5BimGO16mpjf1YurOV+xPx/j8H8rHsybH/
         zzdz2qMMpYf0NaIVS+rXFt0Hnp75x28L4p77g6lEXHvEptD4IbCTH+dDb1UPBt6iKuzh
         jhLX2Bp2Q8XqaxaPGTnfNRXe5j4XkBAMrx6IYd5kvedphHm1tmRO/nxqO2Tl8YHDsxFY
         SfD8FwxJcQla53zUKKqVH9zV7BdE/xFYbHM9zYXpL/3WhzbEV5f13f5gLRNgCOwIzyQt
         EsDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkTxqO0yqTCykg6jjsAd9AGYeRXW4KRMkZmW2oOglRLf9obwtAZwAKfd0nePBBrWEkowoMCYivh94RXXVPGM3R597gKT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGX5x3Fty0AgDn4BXRrp5/qMEQpWgJdhQ7YLDgc6BtgN91pPe1
	14f5RyNwlwde9PpDtIIxDCcUgIeQm8yG5AZ6FCE6gJVQ1OVpRMvipg4LjIl7bhn2Z2J8rCTkR/M
	BhvxmPvG/3qf9FMY3QUFol1etfJHsmRWYS3fdq/vt
X-Gm-Gg: ASbGncssVni8U3seAkOEt7fo+4JP3tPFUXErzVoJPaNl7S2aAnoCWr2XVIJXAJFihFg
	GJfcIiq5DEvwhnR4yNnLl2WYDGAaKwT2zRfHqF8fh/OKd2MS7OK/uqBrYuDbQdiXnA0gBR2BWBs
	0axr3oK5Y0sES7ADsnRH3Fx38mSVMKp8Zx25B/D7Y+cMnufXg3bu7JMbzP88n8rY6ZrW+efCjGi
	F1N48c=
X-Google-Smtp-Source: AGHT+IH3FzNaRMr6v5HHYKxl6FL79CtPc6dSPmg86pYGY7CWig6xwjAHpbOHtWyEHP67xuH9CqUutSk6OOULuCW5dwE=
X-Received: by 2002:a17:90b:5610:b0:32e:2c90:99a with SMTP id
 98e67ed59e1d1-32ee3f7b2acmr3843173a91.35.1758132143486; Wed, 17 Sep 2025
 11:02:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202509172014.2AWygxKf-lkp@intel.com>
In-Reply-To: <202509172014.2AWygxKf-lkp@intel.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 17 Sep 2025 14:02:11 -0400
X-Gm-Features: AS18NWA_y3uwajqyKaoXNoJdoLEqgja1icWNH35vSaHJkBjag0qIhDHgW_Z-m44
Message-ID: <CAHC9VhS+8t_ZhKCmj62+HK8c9pFUF+5MyerykxPR+hvRZz7z-A@mail.gmail.com>
Subject: Re: [pcmoore-lsm:working-lsm_init_rework 9/41] security/lsm_init.c:400:25:
 sparse: sparse: cast removes address space '__rcu' of expression
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Kees Cook <kees@kernel.org>, 
	John Johansen <john.johansen@canonical.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 9:00=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git w=
orking-lsm_init_rework
> head:   8ea7358ca612bb85eef9179ae746edeb5f1dc9ac
> commit: 9cb4dac58e465101fea4aa4f9169f1ea04149da8 [9/41] lsm: split the in=
it code out into lsm_init.c
> config: nios2-randconfig-r133-20250917 (https://download.01.org/0day-ci/a=
rchive/20250917/202509172014.2AWygxKf-lkp@intel.com/config)
> compiler: nios2-linux-gcc (GCC) 9.5.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250917/202509172014.2AWygxKf-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509172014.2AWygxKf-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
> >> security/lsm_init.c:400:25: sparse: sparse: cast removes address space=
 '__rcu' of expression
>
> vim +/__rcu +400 security/lsm_init.c
>
>    348
>    349  static void __init ordered_lsm_init(void)
>    350  {
>    351          struct lsm_info **lsm;
>    352
>    353          if (chosen_lsm_order) {
>    354                  if (chosen_major_lsm) {
>    355                          pr_warn("security=3D%s is ignored because=
 it is superseded by lsm=3D%s\n",
>    356                                  chosen_major_lsm, chosen_lsm_orde=
r);
>    357                          chosen_major_lsm =3D NULL;
>    358                  }
>    359                  ordered_lsm_parse(chosen_lsm_order, "cmdline");
>    360          } else
>    361                  ordered_lsm_parse(builtin_lsm_order, "builtin");
>    362
>    363          for (lsm =3D ordered_lsms; *lsm; lsm++)
>    364                  prepare_lsm(*lsm);
>    365
>    366          report_lsm_order();
>    367
>    368          init_debug("cred blob size       =3D %d\n", blob_sizes.lb=
s_cred);
>    369          init_debug("file blob size       =3D %d\n", blob_sizes.lb=
s_file);
>    370          init_debug("ib blob size         =3D %d\n", blob_sizes.lb=
s_ib);
>    371          init_debug("inode blob size      =3D %d\n", blob_sizes.lb=
s_inode);
>    372          init_debug("ipc blob size        =3D %d\n", blob_sizes.lb=
s_ipc);
>    373  #ifdef CONFIG_KEYS
>    374          init_debug("key blob size        =3D %d\n", blob_sizes.lb=
s_key);
>    375  #endif /* CONFIG_KEYS */
>    376          init_debug("msg_msg blob size    =3D %d\n", blob_sizes.lb=
s_msg_msg);
>    377          init_debug("sock blob size       =3D %d\n", blob_sizes.lb=
s_sock);
>    378          init_debug("superblock blob size =3D %d\n", blob_sizes.lb=
s_superblock);
>    379          init_debug("perf event blob size =3D %d\n", blob_sizes.lb=
s_perf_event);
>    380          init_debug("task blob size       =3D %d\n", blob_sizes.lb=
s_task);
>    381          init_debug("tun device blob size =3D %d\n", blob_sizes.lb=
s_tun_dev);
>    382          init_debug("xattr slots          =3D %d\n", blob_sizes.lb=
s_xattr_count);
>    383          init_debug("bdev blob size       =3D %d\n", blob_sizes.lb=
s_bdev);
>    384          init_debug("bpf map blob size    =3D %d\n", blob_sizes.lb=
s_bpf_map);
>    385          init_debug("bpf prog blob size   =3D %d\n", blob_sizes.lb=
s_bpf_prog);
>    386          init_debug("bpf token blob size  =3D %d\n", blob_sizes.lb=
s_bpf_token);
>    387
>    388          /*
>    389           * Create any kmem_caches needed for blobs
>    390           */
>    391          if (blob_sizes.lbs_file)
>    392                  lsm_file_cache =3D kmem_cache_create("lsm_file_ca=
che",
>    393                                                     blob_sizes.lbs=
_file, 0,
>    394                                                     SLAB_PANIC, NU=
LL);
>    395          if (blob_sizes.lbs_inode)
>    396                  lsm_inode_cache =3D kmem_cache_create("lsm_inode_=
cache",
>    397                                                      blob_sizes.lb=
s_inode, 0,
>    398                                                      SLAB_PANIC, N=
ULL);
>    399
>  > 400          lsm_early_cred((struct cred *) current->cred);
>    401          lsm_early_task(current);
>    402          for (lsm =3D ordered_lsms; *lsm; lsm++)
>    403                  initialize_lsm(*lsm);
>    404  }
>    405
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
