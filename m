Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76A615665D
	for <linux-security-module@vger.kernel.org>; Fri, 24 Jan 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737733783; cv=none; b=HeraJqTT8faSS1PyyitLH7Ih8vyyPuHbyMSpGKr/lixnXgP9QvH48t15IagEukqW+iSooZL5C+vgaHEOIFPjERgN5P+uOjdx8qzZX8zm/gSezPs8+9+pOCHN40LJUcdlE9ZkskK+knYnDifbb/7q80k5poKLkGfye6Zo4vd/ELw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737733783; c=relaxed/simple;
	bh=JXIU/HRhJFOslFzs7Y5I8Q5/vTVdUyV4qgXHL6ELb74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=piMLLzGa43O++2+hAhCI3yPrBNZ9KLMwVkgH/p6fSpTYUBOPhuiyjKC9Trj+8qprUP5t7emRkR4GIvWYxiBYOSY1q38y7P/jRSDu1H5YxSOZoD21z53jasQVpxuistmUjTXMhY99orRZWuwNFzmJsMaL6OhSvC2VG1nibCEs62w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=kKNAqML1; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="kKNAqML1"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46df3fc7176so21831831cf.2
        for <linux-security-module@vger.kernel.org>; Fri, 24 Jan 2025 07:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1737733778; x=1738338578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mm6PRQ+58KnnO/05gSNDI1UU/DGC0eaSudSVsHYmldU=;
        b=kKNAqML1WPVCMbnXAVOvbt+UEKV+G6Ei86v/1mSH5TtTwuvkUdKKxsp3/XMAXbIHLZ
         ARLMkhfMRH43b2rnx+oRdT/aeGTEy41d49XI1UAX04+xl6DaOhelDsElhk+u9bXh48jO
         pBrqXyHqgQeVurm/jjjtJuncvkG6JOEFJCYLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737733778; x=1738338578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mm6PRQ+58KnnO/05gSNDI1UU/DGC0eaSudSVsHYmldU=;
        b=pdL+nSLULyzNpw7b35ZcCozlvaLdwUDtxQccRP1tyoxMG18T9W0M9qyU201gYJb8R6
         mwO4TD7qqKRwJdcDGlsBoF8cn/2W75uOk7eqZh4TsYwOblIpNppVYDsx7wnvZFKqh0Ku
         lvwjWITkbpMBqFaW1e67VbS0QYpTtIvF15VC5E3+T2yZZTPg0Gd5UdSs0sACDeD5v4E3
         u8749exp/VmzYN5ORt1MhYdVhn+J52gaphm9dfCLyX4rsHJIqeNqDyvX2mhAQ97VEQuE
         2cJ6ukEaaaBOb8x0CVTNXaaoQhqzCCCaudKltWGN0LTO5/n7hPZ6ZfKOr5OajcSDIGX8
         iX4A==
X-Forwarded-Encrypted: i=1; AJvYcCVRDPg7m9FVAZk7cuwqh0j7JbgLoRP5oxDh1JoB0A6Df/K6zzCLWi6OaeGUqYPIH62laMnTvxHIcuI+QzeKYFO4cMw7PPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp7ZyRuX9k+fLh+91HwyN5zEfmBODdC0eemAs8d8iLW7YgFwS5
	LfXi6k1AFP63/pa6Axv4E/Ri0bDXdRUBTZUxmSB49iIC9ah2Nsip+ixfBp9qy9Uwp5uwdWR1743
	aS519cUp4RZMQgMkjS1TNp3WZWNjURx8lkUBs1UcAUL1X7D63
X-Gm-Gg: ASbGncsMdsHxqxdo3qjkLJABioGc1a/nTGjs/D0ZPtzUOAxoYgIW5QobHcaigNfyIaS
	kjbKkYLlphXIDHPuiXOEHuLcXF72ghBHXnYf5/cqWIzpXuefgoFRFBmHZ3w8g
X-Google-Smtp-Source: AGHT+IFqquliq7HIV96YWV3XAxaZDHz3BuJORL/akaDIVudNtsDg1MClagGxFhuwi/4oxTQvs9U2X4mqMWMQUElMydM=
X-Received: by 2002:ac8:5dc9:0:b0:467:681c:425c with SMTP id
 d75a77b69052e-46e12a0c0f2mr447495461cf.1.1737733778671; Fri, 24 Jan 2025
 07:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123194108.1025273-1-mszeredi@redhat.com> <20250123194108.1025273-5-mszeredi@redhat.com>
 <20250124-abklopfen-orbit-287ed6b59c61@brauner>
In-Reply-To: <20250124-abklopfen-orbit-287ed6b59c61@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 24 Jan 2025 16:49:28 +0100
X-Gm-Features: AWEUYZkqDlmuMcNW-5_UjhqZV7-dejOlo_fdpN5dbcCjLjywZlEGET6if1Se7t4
Message-ID: <CAJfpegvK9Q_uE-O8HkzzjeNh7nZ_sO89=OCyw_SZCudfXbB2JQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] vfs: add notifications for mount attribute change
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-security-module@vger.kernel.org, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Jan 2025 at 16:38, Christian Brauner <brauner@kernel.org> wrote:
>
> On Thu, Jan 23, 2025 at 08:41:07PM +0100, Miklos Szeredi wrote:
> > Notify when mount flags, propagation or idmap changes.
> >
> > Just like attach and detach, no details are given in the notification, only
> > the mount ID.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
>
> I think this is a good next step but I would first go with the minimal
> functionality of notifying about mount topology changes for v6.15.

I can totally relate to that.   I added the fourth patch more as a
"let's see if this can also fit into the current framework".

> Btw, if we notify in do_remount() on the mount that triggered
> superblock reconfiguration then we also need to trigger in
> vfs_cmd_reconfigure() aka fsconfig(FSCONFIG_CMD_RECONFIGURE) but the
> mount that was used to change superblock options is only available in
> fspick() currently. That would need to be handled.

No, if we'd want to watch changes on super blocks, then we'd need to
iterate all the mounts of the superblock and notify each.

I'm not sure if it's something we really want, watching the super
block itself for changes sounds saner.

Thanks,
Miklos
