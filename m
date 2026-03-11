Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7711630AD10
	for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238391; cv=none; b=G7GT/IJo5ryx9avHGU3EclrQEtUOUjLT2q4mtqJk12WraheQMEe/wOvAzzKyNXoiSRt0JF40omC2hqnHQD7c06j8fKBW4+t4ccebbAh0w0onuGsMNW946cOe7/gIio3Ttjr9sJdkEHCKE42/26b8rUKRa38kwYcTP4nq79Hl3AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238391; c=relaxed/simple;
	bh=POUJjzeRhBIXfPGojdZfC417KH92loTKx1KmDpRcfoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flDhkty8G6QrkzHQJLdy+Rqhl9qTCfRReYR7NRHGRiyO2S3EYztWokNHDlATRXB2Cb9aNBikL0JJzgP/CQjTJ0/jvLuSbK+zUXv2L4UulLiC1cmhf9cuDHyrAQyTcqoD5uxVmXQJtGLjFUrl4qvGN5hqOWl95xF3hBUqGCwd+Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b942b36de08so190644866b.1
        for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 07:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238389; x=1773843189;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
        b=c2IeTHLBb7lKoL+K36fox6bL19t8Ahst4YkqlwRcLSeJ5oz74SArnHVtyKw51G6dic
         /hmUvmDwENkYGR9OJPagw3k3zyRtlXin+tYHAynK7NGiA2bZsif2fCp0qycPxrWgTND2
         vJzFuPu8luAN+cK/jWwXszB6GiyAr1RwPqM1/9QqUc4SpprEUQcTln5WPO9IcIMFPo5R
         rgwtVMIaQkxYITJ5SL4KTtSzbv0Pis0+UrWrxfzqlA8r7hu0GW/jvSKtNudeQdWP0hBn
         HPuiHkiYNfUmNJmyJtCI6P+b6uXqngWw3qxvmQV2ebEBMFIAKgqoEjnxeYLO0gbJudOx
         bTQw==
X-Forwarded-Encrypted: i=1; AJvYcCXJaDsETJgipTreBg+jqELoGqv42l18lwoClMQFGua4fWvRfhk6xI2neYqUxgJA6gNK72UOypqfAaKgN6Azz2Yp4282Xts=@vger.kernel.org
X-Gm-Message-State: AOJu0YylOeDpsN9KT0Dd1a7kNu83eAmk63cnu6Z88ykbG8mgP5UDDOwN
	KID1KsV06UjQk4JEWBPxuii+kf/evrIo6eSoHCZ85UtcoGl79j2eU2GU6GxdpZupiDkHmg==
X-Gm-Gg: ATEYQzwJ3paYX7qjBP/V51VqTcUtKGHMSthpZ8N/Vc7Eo1f2ICnRpisGyOyLkHnn8ri
	5rIE3AjRSGugeombHl8xQsl4db6f8wuVr9t2BibF1QXdcYu9h1mLpFzHbvDE4pD7Zf/mNn0/nij
	GUoQeliQtWIJiV/n95QT8ME59ZecegCK5JZ+/ZwvARSKMDCmugG/TSsJ+nEyZvG3mEzkQcva67p
	5jPBtBw7oP8cAadnr6bz89Lx7Kj1OA0UOUftLRWGeXaCsXOfzPagq3N4h2naJ37Sl2GX/CWdvHp
	zH9jXE417gFWm18M6+/u2apM48nGMrz/Zhks4RJ0d49JzHFUW5+ZkIZg7rCfAsPTJq+QKo8tm7P
	+VTMwlDxPGWJu/5H8c7YpxA2dW+4miWa3ncHxC52pFAlETkOaKsUOFUROL7ZECQghClNY0XsGcF
	gxihQ9Qod9TaamSCCPrUFhnbD7vniVUYsj9J4CjIdfM8PpsMnwaKbJMQkiRml1
X-Received: by 2002:a17:907:96a4:b0:b93:5349:d48b with SMTP id a640c23a62f3a-b97118b0d6dmr460440666b.10.1773238388459;
        Wed, 11 Mar 2026 07:13:08 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972e1c0633sm55069666b.67.2026.03.11.07.13.07
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:13:07 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66174cf4549so2114678a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 07:13:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXoY0I9oOm89dAnj2i77J1bz9uVAKPcjSPwxQJNiQ3kfjaZALOM5GTqzttLqIujKlbZcDsDt+NHkIvFo3LlQYdqQJXE6Ho=@vger.kernel.org
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de> <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org> <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
