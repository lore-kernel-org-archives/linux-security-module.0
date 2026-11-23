Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435022;
	b=ExQyxyElhLeNvCk/2Bf5mtkPHUdexBJdxDaso4S85y6dvWusGRCPF4hc5/S7iAy/liVw
	 ows0wgBv+vcyWIn9OE99IseqC7ugW6H/p8cGj2QABINbN2IuqSer0FzM+ytcSW6eNEFpJ
	 whlZgbFGc3mYFISSSgevjndA6HpOXPOeACGMpJRq8mOYeouPiaHqynFswg/l3BBJgEW3Y
	 +FQitJaoG+aNHOpUECxwFwRwZKVcLnuT8cysf2Nf6POd2tBZuujiFzq84s+17Qx1wkthE
	 Sp9PUCWZcIyOYf0hjZE+kSYNzbqo4kfzz8kVnq5urlgwKAkxYkHl8XbUABGNd0sKoFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435022;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=oqxTqGc37dwDnLjYZnqU54myhb23sMonqleeRzhUP+A=;
	b=g2RhCkNhITqizqO8sa5u0TjwCysVR5IBN61+B6d6C9/M0KQM8C3+J1mMYXlSJy0sN7ER
	 ukGvavesHeqVqiQ5Snweq3ekesH+eIL3ObpH39XBHcTKLgrHJ10pb/Za8W73hkvXTcSIy
	 IWjaicMiosBya0p4s8NoKfwkUo/I38fA2NS/JeFv6kmwuWeIbARDZeRRuFZ2wlO+Mca52
	 pI44JG4jn/LBeboI1RkiKjAfLkaNGa8IM/KOdItbtnyipZNm+W/X7ZI0YHvVX0I+quXoK
	 dzWvXkh2Ugolcf+KD6E4+7hPLe4RyQYF9TrInjfnn5UldkZ5GAUNWd8iR/ZNr5e7AMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E+gRbUMk;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C49606A327
	for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 11:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40C49606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=E+gRbUMk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795435021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqxTqGc37dwDnLjYZnqU54myhb23sMonqleeRzhUP+A=;
	b=E+gRbUMkXzr0ftgnphVyzjzHx4e5SigwzrZsgeRJCNybCOx25/aMeDa/5uK8JDEq0XaT8T
	/GotI0hz8XNeEaCJySIHX7w0tJVAPDeoB3onXSvfuP5VncwyfmwP7YIzUrYUIH/3A0FxwR
	7vcuuTbyVgva45tbdLQt4k2HsLFCp7w=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-egUYg-lRMNilfHdPqOnLcA-1; Mon, 23 Nov 2026 11:56:59 +0000
X-MC-Unique: egUYg-lRMNilfHdPqOnLcA-1
X-Mimecast-MFC-AGG-ID: egUYg-lRMNilfHdPqOnLcA_1795435019
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b3b74c495dso46694537b3.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Nov 2026 03:56:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435019; x=1796039819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oqxTqGc37dwDnLjYZnqU54myhb23sMonqleeRzhUP+A=;
        b=PpSF5t3urDJZhUkI5fpdSEbaUNlyjhtpDKpL6NhsXkvk64KSMYy6vTkzRQAANYbHf3
         xTuLGP6ayPK+ZSadJTqSuNAONT9hAgVrFISmmFImhmbXr/qtZ6Rs50ng8sDli0FyO4wQ
         CvOz49m9MpgDmd0bGo1aN5gkT+maHjW7dCHVGAhLzYrcAti8XZFhLY+U/iREb302+g0E
         14snj9fIs3SE8D8GNuZ6ofyVA6fx1hbawmDzFjmc3ZpuublSPjWl4fHRwqgmhnjCZHql
         MjfVrscEFMxrSiFxPEorftGyOJdub2h56H05FJcR/2cPTcMkzMuNAk6+RALoFXkn5QMW
         QvuQ==
X-Forwarded-Encrypted: i=1; AL+hErEuyc8yFRC2S7COhRfDzcY4cK5TrnRlLCaSRFwmXwPPaQa4FyEmMszznlODvW+IT+E2RQIW2FjfDb7CRrG/9cr3QnXJbfw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6MtU0+vPGScpBNS22YPDlZsM5pHmuYF6IJBtIvn6fw8H4E6wD
	FAGsfZ/8vwqewtMWm1MPZrGeBWX16DTedVgQXSkF8FBmohIhR254EQNn9gYWK8bLUu40m7okBFI
	qGDtxj/fSzdYxMuwffDxt7gNXrV4DZMfNws9FQPZrTQTDcyUH+zkqZSpGAx4qd5DC8prflpfhIJ
	6I60g0s8/tGwaxpmGVd46NNatZZhEdXYcanY5pvv0k8bVSLKhqcj0a
X-Gm-Gg: AZFdTZdMIpegcPa6nGtKS9mhSUAHNKNZXcGXSGBGYg7mydc6HygfS/QqOhjo8RLVYXL
	Oxt/QP5mz4BaqlRBcuUK1vYInacOjZ2YXQ1yFVQZTcmkEo4mF8Ize9ZmXSakHDkKr0op/bB1K0N
	V8Jp558ODKtBgPgLm1R+n8U5SilvMqRyLnpBTAF71b+5URIa0NVSOTj2r6pWSeeFilIgPmn+a+k
	MUrxHw4XjuNK/mtP5eLjOPzzaP/weapnNG9o7rI7J8xfQ==
X-Received: by 2002:a05:690c:6b05:b0:8b3:ba8d:2f55 with SMTP id 00721157ae682-8b52043567emr39667167b3.33.1795435018755;
        Mon, 23 Nov 2026 03:56:58 -0800 (PST)
X-Received: by 2002:a05:690c:6b05:b0:8b3:ba8d:2f55 with SMTP id
 00721157ae682-8b52043567emr39667047b3.33.1795435018370; Mon, 23 Nov 2026
 03:56:58 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120031305.3561045-1-huangsj@hygon.cn> <20261120031305.3561045-2-huangsj@hygon.cn>
 <CAHc6FU7VUBLg=gX-xspFfp4jPffdH7Pc4oVx5nRDo7A3aiVWug@mail.gmail.com> <awP5q_CmS3uIqfCw@hsj-2U-Workstation>
In-Reply-To: <awP5q_CmS3uIqfCw@hsj-2U-Workstation>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 23 Nov 2026 12:56:47 +0100
X-Gm-Features: Aa3M54pdTCvZmmXjws9eztEBY-s6WsNxLh4ieFxp9T0N0Za24a02lla1XE5V3KA
Message-ID: <CAHc6FU7rAr4Mbf3KssQdsxhdk7D+2SzxSydkyw7cgykGGJOi=A@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] vfs: add super_iter_inodes()
To: Huang Shijie <huangsj@hygon.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	hch@infradead.org, mic@digikod.net, axboe@kernel.dk, gnoack@google.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, legion@kernel.org, 
	aleksa@amutable.com, libaokun@linux.alibaba.com, ebiggers@kernel.org, 
	djwong@kernel.org, sandeen@redhat.com, zhongyuan@hygon.cn, 
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, wujianyong@hygon.cn, 
	shijie8@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-security-module@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _RJFKYg47idWS5ZcIx1lvCbCp9bP48FkWqS0GkdR2vo_1795435019
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 9:31=E2=80=AFAM Huang Shijie <huangsj@hygon.cn> wro=
te:
> =E5=9C=A8 Fri, Nov 20, 2026 at 03:56:23PM +0100=EF=BC=8CAndreas Gruenbach=
er =E5=86=99=E9=81=93=EF=BC=9A
> > > +
> > > +int super_iter_inodes(struct super_block *sb, ino_iter_fn iter_fn,
> > > +                     ino_iter_eligible_fn eligible, void *priv, int =
flags);
> > > +
> > >  struct super_operations {
> > >         struct inode *(*alloc_inode)(struct super_block *sb);
> > >         void (*destroy_inode)(struct inode *inode);
> > > --
> > > 2.53.0
> >
> > Sorry to say, but this has gone quite a bit off course. Can you try a
> > construct like iomap_iter() instead?
>
> Christian had suggested to use the following methed:
>   https://lore.kernel.org/all/20261120-mitverantwortlich-drehbaren-kantho=
lz-241300d20168@brauner/

Yes, that's what I meant.

Thanks,
Andreas

