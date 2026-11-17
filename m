Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794958483;
	b=jvrS/D0JdgDV4CtJfatsSPVsavG9em+IJ1x09Gz5XnBvL2OPtWy9ck5o9C5N3dkRTWq1
	 BCrB/bAd8OsXKnMPGk3f5b+8cLabw242JJciOiG9QgHRkFaXfuvcaNaJgn5TfVEyEnYpy
	 TY+GZW5yCKOxDP7p/sQGuhTZR/uS7woFvcIA2IJKLh8zhirDaYmOgwvOMUKnABgxZW+5G
	 ++0k6h+TQDwTjVqvSNje3vn+8IW89mEDVn4acn+unVI3zTfr1M3CkKcZwbtDJYpIJ9yz9
	 InVpIwyitklEnDM4e8pzkm43wj9HG5L5Lfuon/OzhbIIeKNFi9psdnt4k2f5wyLP5TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:From:To:
	 Cc:Subject:References:In-Reply-To;
	bh=mxCH98lD8Ul9vSPCZMv+h4ue3Gw/ScCzx5yCrbCmDBE=;
	b=3mHpDonEedA0J9RZ4iac8x1sKCTYAPbNXoUyr7OsArF7AmzbRMeYP/OtBi1NsAm7TGQd
	 7Cq6xjsBA/b+wcaji32XIZscSHwtGzlBpkUc4Gw/mKJ+h5DVBrbiLeL/TK7EeZ34zdvF2
	 MYCR8QpX3pvdrl4qL4IaOLpGe/2dpRyZopdGgUK2R2gpczA/2pj3j+yVboyxkfx5i/u4r
	 V8B4Pdp2+kpNYQwWpbHeZg4wjZHlVMTqX1+6ej4rNUXyFyXa+oODo1RLTm7Wck9KLrveX
	 RkujIjOmZKDZdskMIzcXbJ7nArFMIkOun/oNVwk34pWRlITKNXRMSAUItZGxyg2dNLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b="C1/HoDQL";
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE711606A330
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 23:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE711606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=C1/HoDQL
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f2b8cf037so34788285a.1
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 15:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794958482; x=1795563282; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mxCH98lD8Ul9vSPCZMv+h4ue3Gw/ScCzx5yCrbCmDBE=;
        b=C1/HoDQLJzzckFRnS+9k64TFool5JeA6PubBeU/laVzL/w4ah7odPpMpBEDO4oTDek
         tzvkSLyjXBT1ae6muzrpU+3lix8bwV+w5XzoROoTQVFQ75pZIhaZnTEzTzkvFRP9MXet
         cswYz9mJhJ6jqtYt4JjUilPe5tWe18DSDwlcWvq99KCO8DgF8mM2v9dS3T/+DCZLJVWq
         S4BilbEvdhkOpMHkOUTOKfcBRLK371Ffu7Ts5wblHKU+7z+VA6XukkrcJsEnIUrr5zDJ
         9evsjeK1bGn1T3KaRJrNNmPDwV+QAIp1I3m7emtneedTTpgn6usGNwt5x6nS7sEasDi8
         n6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794958482; x=1795563282;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mxCH98lD8Ul9vSPCZMv+h4ue3Gw/ScCzx5yCrbCmDBE=;
        b=w481n25XC7eMbbeR2/qp7Bmv1klZCfeFmTUw+FE0pkvz+A4/HwVlCaYm9cZ0W6XiNQ
         rzM/JEJDVQjUbsAb8FqkTt2oLFxR5U5QkZvWsJs0l4Skp1/kaYG8G8Ym9RFIg39PbSCX
         +4RW90WPSLzgirWZUtU6l9raz5nbg3Lje0qOSww9Wzj9oaZ/qnrfKZJEALSgp7EdgBe2
         q5S/n9mHspODC2TvYVhYP09WbySVwfHad18Cx+tzSf2Iu9/CCHZSwpJq3Pj5VK1R9JqP
         TmyuLviSJVk1mWH6SKN1M/5WLPimbh+tJg2GJsjXtA1z86YeV2lv75lNXQ3sP+x9FB3+
         iwGA==
X-Gm-Message-State: APuU4Z8ryYr/p+L95xhwY6zBpHTzaIJhoY0a/Wp250EN2zkEWcAE4Hgt
	51Zv3yVVAJsmqQPOtt4tLALOk8X2vnQhf8ztdas1tqCkcXTpnyWOAaB83qNFWMtqdw==
X-Gm-Gg: AYBFou2U3XgsuhE077DyyY+qSNNNubB3xdxvxcf4bDYW2BaGcICkl7kJjflUyCVBm70
	Kv9+KGjgTe4WXvyQz1xYYFcCqhgJnh0tcYCv6kk9IaBc7l3/+iABLV6hPxC2HOMFcrRVkKsVbIf
	bzdp1c0SUoVh8neWaXiiDjUHCwDzY2x6WP9T3YPc7w6W0Ol9z9nh192XvYUhR5bwCLnoizFJv9y
	xGcBvQLiAtHgMOvtET0raWO6YjqdsV2D8V5RoW0LrbvTqksYqXpAjzvsKsn1QUmb9WMx7V8WOOL
	rSGUpdD8jpIiQSB71Hwn7cg/EUv8RUC7QAUj1AXgopiPcz86cPY2+ckACn0qjwKvBpi9DCTNSsF
	7gBDdAhim/xsh5d9M2sAB+D1mWYjnD8H8dRkpY+TAe8CAZe01NgnpEdIj1Lg+7RK7nyros42W7A
	sG75cFj3IjreGwbdef/jT+95f6Lk88qgjBk/zAcbywNNWgn9XeTJ/Y06HDipoVoBacxv+R7lkrU
	Uzm6tGWWsPUjG9jhw81l6CjfVLuk0sJCUz/+gn+e2sQPwkT4UN4T0pE368RBI6bJqvTFBI5CJKK
	YKn/hTA+QmRQvkXBr5VwtbF1L8dlbZ+u1gQgsYJBWxkR0S9y8OxdODN7p+b8/RUFS+Sw0fF8Gic
	3H+xjNvTPqFpTABiZQKCXveWvoF5V2owFiWNZ69Zx67WDzDx6UNg=
X-Received: by 2002:a05:620a:2556:b0:93f:19fe:e6ca with SMTP id af79cd13be357-9499972c8e6mr213324085a.43.1794958481841;
        Tue, 17 Nov 2026 15:34:41 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b721861sm42496085a.11.2026.11.17.15.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 15:34:40 -0800 (PST)
Date: Tue, 17 Nov 2026 18:34:38 -0500
Message-ID: <7dc91c090b4f8254f8b6fbe2ec36060f@paul-moore.com>
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
Subject: Re: [PATCH RFC v3 17/44] securityfs: use fc_init_pseudo()
References: <20261116-work-loop-pseudo-v3-17-8cbbea1cf34f@kernel.org>
In-Reply-To: <20261116-work-loop-pseudo-v3-17-8cbbea1cf34f@kernel.org>

On Nov 16, 2026 sashiko-bot@kernel.org wrote:
> 
> Initialize securityfs as a pseudo filesystem. This raises SB_I_PSEUDO
> and SB_I_NOEXEC. securityfs never holds executables.
> 
> But securityfs needs device nodes. AppArmor puts a .null device node
> into securityfs. On exec it replaces file descriptors the new profile
> isn't allowed to use with that node and opens it via dentry_open() which
> doesn't care about SB_I_NODEV. Such a file descriptor can still be
> reopened through /proc/<pid>/fd/<nr> though and that's what opening
> /dev/stderr does. The node itself can also be opened by path as
> /sys/kernel/security/apparmor/.null. Both go through may_open_dev()
> which refuses device nodes with SB_I_NODEV raised. So clear SB_I_NODEV
> again in securityfs_fill_super().
> 
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  security/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/security/inode.c b/security/inode.c
> index 0804023676741..edaebf0f1972d 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -14,6 +14,7 @@
>  #include <linux/kobject.h>
>  #include <linux/fs.h>
>  #include <linux/fs_context.h>
> +#include <linux/pseudo_fs.h>
>  #include <linux/mount.h>
>  #include <linux/pagemap.h>
>  #include <linux/init.h>
> @@ -49,6 +50,8 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  		return error;
>  
>  	sb->s_op = &securityfs_super_operations;
> +	/* Userspace may open AppArmor's .null device node by path. */
> +	sb->s_iflags &= ~SB_I_NODEV;

AppArmor itself does a dentry_open() on its null device to effectively
block inheritence of open files if not permitted by policy.  SELinux
basically does the same thing, in fact AppArmor's aa_inherit_files()
is based on SELinux's flush_unauthorized_files() according to the
comments.

Anyway, I'd suggest changing your comment to something like the
following, but it's not critical.

  /* Allow for LSM specific null device nodes */

Acked-by: Paul Moore <paul@paul-moore.com>

>  	return 0;
>  }
> @@ -64,6 +67,7 @@ static const struct fs_context_operations securityfs_context_ops = {
>  
>  static int securityfs_init_fs_context(struct fs_context *fc)
>  {
> +	fc_init_pseudo(fc);
>  	fc->ops = &securityfs_context_ops;
>  	return 0;
>  }
> 
> -- 
> 2.53.0

--
paul-moore.com
