Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB9220C004
	for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502299; cv=none; b=L+ztGUta5psJ2RF2iy58jo4iqo8/kesm2GWc2UyCq2k2lWrYKVJ9fE0aa0zMbPs339PdfvNLk7nqsVn8oam4S11F8HcIyDrGO9opijlQ4BpNEZ1raJbLzqToVeWJqxyjMaPb15Jf4uLLLE1OW66w9BIr+dVkYgwQTOGxpi5UQ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502299; c=relaxed/simple;
	bh=ENLLV/0PrVWHZJnSd10hwquS1U8BMVZB3K1bFjotxyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=V9ptYsp4caHUx0xUFXK2aIfB5ZXAx/w+dIx1Hj5M0MP99IXfIgsHLSYIwWtm/Kmb7+SCtYEx1K/bAS3TlJy7RmuzC+KxFf+8ppEdRwVWseEHPU6le/xM4e2wwxzlU7Q4CUTWcRJvK+Xt4PnzgjQGt0qiiAzQmcrxukJbRr8jERk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIFsE3fM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIFsE3fM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736502295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4Kw1qoNYerqhNjh25Dgp7jdmE++mW9Fl3ZiJ8T3co8=;
	b=UIFsE3fM8ZpT28RgTD/VWrQgEAnTkGjPT7UbRMlcM0A3WZUp3DhNJ0v0QFBh450AL2dUF2
	1rk+agWGcGiZ9i74yLeJbYlEoWeR6NzBDaiJjp4lAMBOkt46WyA1BMrDxOCmGN/VpP3McP
	TQbg59XT+08yYB3kLiyn5GjAlHUungM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-GXMcimKJNQKDEfkO0FUSww-1; Fri, 10 Jan 2025 04:44:54 -0500
X-MC-Unique: GXMcimKJNQKDEfkO0FUSww-1
X-Mimecast-MFC-AGG-ID: GXMcimKJNQKDEfkO0FUSww
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385e03f54d0so781393f8f.3
        for <linux-security-module@vger.kernel.org>; Fri, 10 Jan 2025 01:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736502293; x=1737107093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4Kw1qoNYerqhNjh25Dgp7jdmE++mW9Fl3ZiJ8T3co8=;
        b=dvTnEUuI+LAmCF6to0tpmTWdcEzOsY7pdcYqsv58b7wKW0rnWAlNVfnlIwcfnSMNN7
         j+GhV+i1IaUYWYfwKFUa5S/x+i5NBPgKaD0aAqi70IfjB0c6DJuHIoEEE1+YuQn8BYLr
         9677sLBVvLbSIwpOfX7KPEoLR1GP/0bio/vdaI+D3xRUYzg/MMGoSv6Mr6n6dq9UgFtu
         TpMUdmaugD7DwtdpZC0S2UmkPDJ/M64hBWlmy11cfflX/DCDyGSawAQ5onkEipcXXhZI
         m1fc9j+Rvg3FED+IXGBgu9cSiLjKLFFZzUa73Pde5YQ9UeUazWLlRT0KVjtCXdTA10IW
         shcw==
X-Forwarded-Encrypted: i=1; AJvYcCUXssZv4rYCC8V7GirJQVwm21UAXN3MrEQQuRiN1X05wyUz7aWAal8PflbMJWhWXXMmnpihk5BwVuCnRF8TaJrR/9uHorQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye3t5+zGNHUQQF+18H17PS125TCOD3jGXwR22jt0E0+3lhrLXd
	FlE9LD6DYOCdrfoS88nccEzlurT1kZZs6KcU64T5jwQ/tabRHmntXlKO6GhLvKKGvVRhHKmUBAY
	u1Cu0kb4ki2fvj8AgWGUgesTvaPCdPpbISFVStXw5mbDas2cT2x7N37qwflCptkuqAil8YTZR
X-Gm-Gg: ASbGnctrYNtJyP9zdtnS4rnGRN23AvZIh2Kmc6P4x18Vw7vh9T1oaAE891velDb509O
	cq0zQtJvgmeG4dUqirxxK0SN7Bd70llit8xmKNd+CcUvw56GTIYUHZYHNHowqrRkJxJLXuDPbSc
	dko5LFURDQDEeDF/UPtjW6ft0oGKTpmG1L4/FvIgX8kkH8496O2OBHBS/OTDbNzwbpBGbd3d/o3
	XoXcDviaYRcYpdd/3+ZfMVbwQ3yS8ZxBEtnY4KNS8nE+vKtQ2+NeOu/bv9XI1Zcl6haQKEY6XmK
X-Received: by 2002:a05:6000:709:b0:386:3803:bbd5 with SMTP id ffacd0b85a97d-38a8733a1f9mr9910101f8f.45.1736502293463;
        Fri, 10 Jan 2025 01:44:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWMxVaNXeUTe+wjdV2pCbQXCctILb5vVg9f3+psJOjGS23Sr767uuQBsbyCemBlGukLyZjgw==
X-Received: by 2002:a05:6000:709:b0:386:3803:bbd5 with SMTP id ffacd0b85a97d-38a8733a1f9mr9910059f8f.45.1736502293124;
        Fri, 10 Jan 2025 01:44:53 -0800 (PST)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e383965sm4140444f8f.31.2025.01.10.01.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:44:52 -0800 (PST)
Date: Fri, 10 Jan 2025 10:44:51 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Michal Simek <monstr@monstr.eu>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	chris@zankel.net, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] fs: introduce getfsxattrat and setfsxattrat syscalls
Message-ID: <4ad35w4mrxb4likkqijkivrkom5rpfdja6klb5uoufdjdyjioq@ksxubq4xb7ei>
References: <20250109174540.893098-1-aalbersh@kernel.org>
 <e7deabf6-8bba-45d7-a0f4-395bc8e5aabe@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e7deabf6-8bba-45d7-a0f4-395bc8e5aabe@app.fastmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lrykbEr5Glk0ak40NwVR3vm0Fo8Fa_dxwsMZSHg1QUE_1736502293
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2025-01-09 20:59:45, Arnd Bergmann wrote:
> On Thu, Jan 9, 2025, at 18:45, Andrey Albershteyn wrote:
> >
> >  arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
> >  arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
> >  arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
> >  arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
> >  arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
> >  arch/s390/kernel/syscalls/syscall.tbl       |   2 +
> >  arch/sh/kernel/syscalls/syscall.tbl         |   2 +
> >  arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
> >  arch/x86/entry/syscalls/syscall_32.tbl      |   2 +
> >  arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
> >  arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +
> 
> You seem to be missing a couple of files here: 
> 
> arch/arm/tools/syscall.tbl
> arch/arm64/tools/syscall_32.tbl
> arch/mips/kernel/syscalls/syscall_n32.tbl
> arch/mips/kernel/syscalls/syscall_n64.tbl
> arch/mips/kernel/syscalls/syscall_o32.tbl
> 
>        Arnd
> 

Thanks! Added

-- 
- Andrey

