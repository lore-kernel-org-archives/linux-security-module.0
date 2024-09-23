Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ABD8002A
	for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2024 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727092178; cv=none; b=ViLJsytimIWgh5qnevR0D24Sm6hJBV4XgvzqAIsBiu0gzjgt46RhMeBVQFah2kTdK0CujvO2M09R8/FVZAIXnaUIimhHlhL+ToXXYocPGT56bw8oOQWzJ8ltkqypvdOiTY0utDUlvhFToNnf89u4X/r2ue5m5LW4l3aPoyXyF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727092178; c=relaxed/simple;
	bh=FNuIvI5yetUYWxbZVVyMaiZIm82W0BZVAaRwRbmZS4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7w3vP82p4MFguddxNObIP3D536ooXucQdFTqSrI0ODRlh9S3yd8DaUAh172lf9sr5cZG2ct5TpAJRS4ewM5SSnosAoF6uTA2LkZFBDbkZIQFa6c24g6grpy0tmr5yI3xqAerHZfno+JP3G8a5xPVyZueiBn2zAeJGD1sdxcQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N+PO99so; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N+PO99so"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ddcd0b4c59so35794377b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2024 04:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727092175; x=1727696975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAlESk6wiDi0M4YJzyLEruJppHMKW1SuMG7aPcq9FG4=;
        b=N+PO99sokRkG+ATvRgJL7mWB/y5+Ym2+iRY4qwxpJ2h8bcUbiGrx1MrByCFC1OCy9y
         Eb+/uSxf8HoCb+VrqQ2kh5/eUXhzJtgLhUQ0AVrymyJzfDV0bMCM1wZNBuaVSoMtr9BB
         C/UOt0Syk5YEl7STHl0VU61JviA8QD6pzAzgxjm0L4OYjZ3EcYlHEMo0gN66KNg2MABd
         wqZ89nJPrqRx/tyWzlskgA5pQvozv0x921h0HPjbkArv5XaJhtn7zcM6Tn9vxxzsp0CH
         gwRmf+CDrhyjeXVnQ7HQj80dtZBfW2GQoWkFLyGFoCP8AqCfRMizzhQTmHPUu2asnKPF
         9ZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727092175; x=1727696975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAlESk6wiDi0M4YJzyLEruJppHMKW1SuMG7aPcq9FG4=;
        b=U52M7rvk58UjK3Vn4QBCpHxenTg7zbWNtaQP7hpiXvrdLdRrxGZhgBNkrw/uRhgPwr
         mNky1meKWDsB0T+AK99D2MrLlb6Dc9QD1T42ifoPi0PNqwBRN5WpwX9+YZINqTZKjxcv
         FIytsGIbY551ya6NfsThD+bPnUg5yO+oC2l6SC179WQ0bbMBmeIy2wYaZ8lgapc4X8J9
         Dd5DJ59hMAkq6HgJX1VkiK4/6wtdhF01/8DQaZsyBqD62DO58a2gaQchx4runDr8cdTl
         UQXl20i363wIj9AfX748IqQWc/8LtPtYB2ib6lKjjl+X9j//GsX6KM2WzkAc5586HSkk
         legQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+uTyR5Bt8tOx5NkaifPu6bh5plmusgCCVkBTMfP9DmfCa/6K39Fy5cTYhpccwa95Yl3ycIZEMhtBMGXEyl8PsKwiUn30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+joltPF2sDgRZE+JL6NX5MrPck6IJ0W4ww8t/9NSpH96Ji5R+
	kvXoC+rjbCN4ZXa9yazkTvUOoFH+ly8p8awF/MpOXiTaqaoZiigcjtvBqqAE1fU4EWukuvyK9zS
	8o7maMxCbsK57ncB2zVpcQ5d3OyAxsipK0jeR
X-Google-Smtp-Source: AGHT+IEWUMDhWZbDPVnXlsv492mq+DG3vADXokcLji3X/LgPO/+OVuuFhQ5r0QWl83od0sqQXdBQ0yhgEMu/H7USDEc=
X-Received: by 2002:a05:690c:2c0d:b0:6dd:c764:2d5a with SMTP id
 00721157ae682-6dfeeffff81mr64609897b3.41.1727092175387; Mon, 23 Sep 2024
 04:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923115252.3562956-1-ruanjinjie@huawei.com>
In-Reply-To: <20240923115252.3562956-1-ruanjinjie@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Sep 2024 07:49:24 -0400
Message-ID: <CAHC9VhRN2rsJOHYgVMeG=9X1htCCgNQc_XB_jJY-Ruu-BrtFQA@mail.gmail.com>
Subject: Re: [PATCH] ipe: Fix out-of-bound access of kunit_suite_num_test_cases()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: wufan@linux.microsoft.com, jmorris@namei.org, serge@hallyn.com, 
	deven.desai@linux.microsoft.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 7:42=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> Currently, there is no terminator entry for ipe_parser_test_cases,
> hence facing below KASAN warning,
>
>         BUG: KASAN: global-out-of-bounds in kunit_suite_num_test_cases+0x=
b4/0xcc
>         Read of size 8 at addr ffffffe21035fec0 by task swapper/0/1
>
>         CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                 N=
 6.11.0+ #327
>         Tainted: [N]=3DTEST
>         Hardware name: linux,dummy-virt (DT)
>         Call trace:
>          dump_backtrace+0x94/0xec
>          show_stack+0x18/0x24
>          dump_stack_lvl+0x90/0xd0
>          print_report+0x1f4/0x5b4
>          kasan_report+0xc8/0x110
>          __asan_report_load8_noabort+0x20/0x2c
>          kunit_suite_num_test_cases+0xb4/0xcc
>          attr_module_get+0x54/0xc0
>          kunit_print_attr+0x234/0x358
>          kunit_run_tests+0x138/0xbf4
>          __kunit_test_suites_init+0x110/0x1d0
>          kunit_run_all_tests+0x358/0x394
>          kernel_init_freeable+0x488/0x61c
>          kernel_init+0x24/0x1e4
>          ret_from_fork+0x10/0x20
>
>         The buggy address belongs to the variable:
>          ipe_parser_test_cases+0x60/0x1ba0
>
>         The buggy address belongs to the virtual mapping at
>          [ffffffe20ffe0000, ffffffe2120c1000) created by:
>          paging_init+0x474/0x60c
>
>         The buggy address belongs to the physical page:
>         page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pf=
n:0x4535f
>         flags: 0x3fffe0000002000(reserved|node=3D0|zone=3D0|lastcpupid=3D=
0x1ffff)
>         raw: 03fffe0000002000 fffffffec014d7c8 fffffffec014d7c8 000000000=
0000000
>         raw: 0000000000000000 0000000000000000 00000001ffffffff 000000000=
0000000
>         page dumped because: kasan: bad access detected
>
>         Memory state around the buggy address:
>          ffffffe21035fd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
>          ffffffe21035fe00: 00 00 00 00 00 f9 f9 f9 f9 f9 f9 f9 00 00 00 0=
0
>         >ffffffe21035fe80: 00 00 00 00 00 00 00 00 f9 f9 f9 f9 00 00 00 0=
0
>                                                    ^
>          ffffffe21035ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
>          ffffffe21035ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0=
0
>         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Add a dummy terminator entry at the end to assist
> kunit_suite_num_test_cases() in traversing up to the terminator entry
> without accessing an out-of-boundary index.
>
> Fixes: 10ca05a76065 ("ipe: kunit test for parser")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  security/ipe/policy_tests.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks, I just saw this reported last night with the same patch/fix,
lore link below.  I'm giving it a few hours for Fan to come online and
ACK the patch, but if I don't hear from Fan by this afternoon I'll
merge it and send it up to Linus.

https://lore.kernel.org/linux-security-module/20240922145226.491815-1-linux=
@roeck-us.net/

> diff --git a/security/ipe/policy_tests.c b/security/ipe/policy_tests.c
> index 89521f6b9994..0725fe36f8bb 100644
> --- a/security/ipe/policy_tests.c
> +++ b/security/ipe/policy_tests.c
> @@ -286,6 +286,7 @@ static void ipe_parser_widestring_test(struct kunit *=
test)
>  static struct kunit_case ipe_parser_test_cases[] =3D {
>         KUNIT_CASE_PARAM(ipe_parser_unsigned_test, ipe_policies_gen_param=
s),
>         KUNIT_CASE(ipe_parser_widestring_test),
> +       {}
>  };
>
>  static struct kunit_suite ipe_parser_test_suite =3D {
> --
> 2.34.1

--=20
paul-moore.com
