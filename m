Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794958486;
	b=vW2VfzfyA0iMaWXfq3sxHjPn+K80K2+oqUOldo7+oYMjqmJ5XtXCDMBX7V+QdC7rudfT
	 s89+5UetHouOX+9av2EnFVr8j1uuo23gtUj1ZMyStAL8fJuwqERdkTtbUOdhgXQ4dnuXi
	 QbDHvDPf4KSAZpSgUjaL7awTH8JzOyN7x1uBBP6T7BuXAFSHqoI6LMdZf3DGausjXECOS
	 6F3366bo/xrmSpla72j/UQSbbjjZaS3QlAU2vTvflhZzFVOpiaZN+uNZy8kHgEa8IvgHa
	 7Na1dmhBV60DSHcf9Zva2s6eISxmbuS4vfuQQNA48hGb7FxDKakNNS/ReQFodoU+5tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:From:To:
	 Cc:Subject:References:In-Reply-To;
	bh=id7sxPUZ1q5vwEsAL+ZQA4c7CaWDRU0GTvUGmQVP1r4=;
	b=ybAtfKjM6hlEpidzCC9263aIRnFYWmYbbqzYYSb7YqZT6W87B8OILWM3fws1R14WGINJ
	 mrghvo9XEUWZCBIH0ULS+eF7bVXlJJ5nhpdDgsz5wxa05j6ZUCK4z1ydCIW7EB5PCKGL4
	 Vza9DTMDRx3W2h25DDR/GiWZ8oo5n+btXCEsdoI9PIlkHJNSW+0La/b7/nMbnr50ga3TG
	 8gNt1/eR20fr9X1HqkwNevs5W9VsvxgRV/w/nAX7igfCgM07VJNjPFVTHnBppbd5MgSQc
	 WEXWNf1S3exo83JAOQgtIgi+tPzyDoT4Fo8rfA+xv1Y2by1PIRoUy9x0FO1HuXw3fyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=PRr5dLBj;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A547606A32F
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 23:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A547606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=PRr5dLBj
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f22a8515eso37987285a.2
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 15:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794958484; x=1795563284; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=id7sxPUZ1q5vwEsAL+ZQA4c7CaWDRU0GTvUGmQVP1r4=;
        b=PRr5dLBjAs05ylRi2AXLL0lTt2IRquA8ljp3pqeJPErlk/8PgAPrbJeb5L3wCfYpa4
         XDYg/SSGs1hy4t8K+/Pp2PiFQx3NJhZscZFEkHYDBy/vZZXIK8wPt1b8bU/aiP11Aror
         r2GnSzAJl8YAMrvOZ9zn1J7tRliIlMrZCaSyvO1BKafTr1o5vnDRkuheZbUs3qaGJKbw
         GZZ0QuyXsQLRhhKtgXaxoG43vf79JCmBRlf2ehljTRfDruOrXulaw85CZqHDE9ak195A
         eJ6eF8rJUuh1V7SM65zr4OBPFIDmlixPlsEtIh2VtMq10Xt4Rwuc5EzZPn5JnzwasjJF
         zOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794958484; x=1795563284;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=id7sxPUZ1q5vwEsAL+ZQA4c7CaWDRU0GTvUGmQVP1r4=;
        b=Vdnz4YhvAKiL4g/8g9flz4SlPWwXTzMUfgJ83LCX7ept8JXwxEIsF5GLgliKOsjYAV
         +Q51xK+/kuNsWgGNrtU21CXYzUdxckZhyUFlWkOqfjyvcSkXgYhA40cnTWC/cCZkLqrW
         t+EsEzF0CjEg5T/qe/WexOLhVzRaVulDQNrk4rp9SSLV4ccccxlyLemxeiBqyUEqqrHz
         wSqx1C/At9PMBmetIjSfLwlXq3j23rIxLUVW7mKYMW2RxVK1bHaoXaGYTqWbtPrLzgCu
         0aB0O0WzuSt3bl8C7ThjSpqrMUidEk2wZ4ja04FIZkb6RQRG8D7jc7M+sIdfBHuDhBh8
         TskQ==
X-Gm-Message-State: APuU4Z8L6BX3pV9vT2D5kDqhk13y25lppvB0zaXaU8qLh/D1Y1bLDy5+
	wy1Vn/rcuR5jhm8N7ZeU3CENmKNFWlmbAkSSGor7Wtpqj2qHc+Wk6fnZK6yikIfKGw==
X-Gm-Gg: AYBFou3BqmWPmiT5Q3eG9R3uOLzy4e+ASzoDWk7f93JYLboHkI5zfCufkRGP5J2bVMu
	yEA6udF/PoHrw4HXQ9JndvBbcvK5CGedpukSrKw1fzS080asJeNuCVoB41fpH38FpY7XkMnb4T+
	IFixYRMOGjkgybtuUMQJYaK+gyP4j1gLCP04ftlY9EN79Kg0oMe0mRYfrza34NgDjOKv/UoR67W
	W2/lj5q0FxwK+IYfq8KUZv5ygF9j4kN5j3EceV2cdKWtGO2LOei6uwxfyz1s7UJN9ct385Lqr3t
	eCg3cigWek4QxfPkCfnP9yLykxj1XdoUz/xobrfzLMDNLNR4SBZIdcbkoEvR0n3Ylg7yhYRVm3S
	BZF5dHuw+48+2vqqupgXjx7dzP9cXkfXmj83+Y01Cx3DjlCLhrF38PDiRxlBKL0dbLcApRv8QY5
	SbkNJzOZUz1JrSK1T77yVS5nBlj7cVss52CQebeXhxsDQ1LZUbc0zbdM/c1Z/aa3oXLAS7trJtP
	7GOb+eDN3R7za/116fzFnQZhOzaonalUXBUYJvPuRcRpiFymTXCl2hDShlv/MUsFPbwBfLLkXMr
	29uyp+EKjPgQxdSoGDW0N4SWW4dVi7Z0ksiIR9eLHZzeNbTcZt303kvKgq/3tyibLL7M4EIkF63
	klePtUypx+w3eSR6uCiiG5aU+pol+Ntg=
X-Received: by 2002:a05:620a:2906:b0:944:dbd:8253 with SMTP id af79cd13be357-949995ee428mr247457685a.59.1794958484257;
        Tue, 17 Nov 2026 15:34:44 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b7c9a65sm41585085a.34.2026.11.17.15.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 15:34:42 -0800 (PST)
Date: Tue, 17 Nov 2026 18:34:41 -0500
Message-ID: <7a012ff555beb43b389ba5ab96e25ba3@paul-moore.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261117_1552/pstg-lib:20261117_1552/pstg-pwork:20261117_1552
From: Paul Moore <paul@paul-moore.com>
To: sashiko-bot@kernel.org, "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH RFC v3 18/44] selinux: use fc_init_pseudo() for selinuxfs
References: <20261116-work-loop-pseudo-v3-18-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-18-8cbbea1cf34f@kernel.org>

On Nov 16, 2026 sashiko-bot@kernel.org wrote:
> 
> Initialize selinuxfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> SB_I_NOEXEC. selinuxfs never holds executables. SB_I_NOEXEC also
> refuses PROT_EXEC mappings but the status and policy files are only
> ever mapped for reading.
> 
> But selinuxfs needs device nodes. The kernel replaces file descriptors
> with /sys/fs/selinux/null on exec via dentry_open() which doesn't care
> about SB_I_NODEV. Android init however opens /sys/fs/selinux/null by
> path as /dev/null doesn't exist yet at that point. So clear SB_I_NODEV
> again in sel_fill_super().
> 
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Tested-by: Chris Down <chris@chrisdown.name>
> ---
>  security/selinux/selinuxfs.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 310e19efff1d0..d7ae853b6d685 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -18,6 +18,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/fs.h>
>  #include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
>  #include <linux/hex.h>
>  #include <linux/mount.h>
>  #include <linux/mutex.h>
> @@ -1852,6 +1853,9 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
>  		/* last one */ {"", NULL, 0}
>  	};
>  
> +	/* Android init opens the null device below by path. */
> +	sb->s_iflags &= ~SB_I_NODEV;

See my comment in patch 17/44, this is also used internally in the
flush_unauthorized_files() function.  Once again I would prefer the
comment to be changed to the following:

  /* allow for the /sys/fs/selinux/null device node */

Acked-by: Paul Moore <paul@paul-moore.com>

>  	ret = selinux_fs_info_create(sb);
>  	if (ret)
>  		goto err;
> @@ -1955,6 +1959,7 @@ static const struct fs_context_operations sel_context_ops = {
>  
>  static int sel_init_fs_context(struct fs_context *fc)
>  {
> +	fc_init_pseudo(fc);
>  	fc->ops = &sel_context_ops;
>  	return 0;
>  }
> 
> -- 
> 2.53.0

--
paul-moore.com
