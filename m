Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D435013A3
	for <linux-security-module@vger.kernel.org>; Tue,  8 Sep 2026 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909656; cv=none; b=TgsbRkdbuibAdJkgwsjEBlHCwMPFbXD2efYQD3mSbHojHCmPeFvgpa+hAFyqecAx5ep3ESe+/DPe3utbMCq+3rIqHSvoOsAYJmIb3zORYAvelaH3NzN1/FVZQNlrdNU2zLvQSzJmlZjEXsrAU8D+BItXPsq456p8BvNtxbZ8XZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909656; c=relaxed/simple;
	bh=Wecw+9QrgZirVokurAeBUMi9T03tj337LxegaPg13iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EY8KJc3ajWHMtQLJ84YjgvqPShEIRXaLu02ZkS7sPTXRPDTiUb9pSDbW6uGqRctjWGU+T/fmCVFPXZBqmI19GrI6NMWFf03bvF0YCRHxMvkIvRF2PzMhAKsamZCcaQrI4Ffi6x/C1p2pn4+IpdKZEa/9XiysCPnLyrcx5iQl4kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net; spf=pass smtp.mailfrom=bobrowski.net; dkim=pass (2048-bit key) header.d=bobrowski.net header.i=@bobrowski.net header.b=ERKapIL0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bobrowski.net header.i=@bobrowski.net header.b="ERKapIL0"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-85339ed040aso4328396b3a.1
        for <linux-security-module@vger.kernel.org>; Tue, 08 Sep 2026 16:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1788909654; x=1789514454; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ME4T4I0fml2p5iiDAE13UqY89i33BgyIDriKnzcytM8=;
        b=ERKapIL0I28esERqml8fFrJdJFDB/nRClYalESgMt9eMxlQFdIKaythiKGZOo0AxHc
         4awbjlOGQhxUsbTzIdsfAd8wQRyViykaxFwC16/aPY4F66ESH+1dYFW48QMFztLkHNrq
         UFl2m+/TEcTmFPZPMHhtAZ0/gtteiIgK9VWaVlb8Jqh4EloZzomrkde7LyC2eIbylJ1l
         OxoTiLLUyi25YDSZIvj2lBh+T5ckyPWX5AZe95DysSvQDSJduE+MK8FOSkAjwlwohxrs
         0JjvR0hVjWcktRrmHdQI8FxnwoeGTzjwLsEzSXn8whW9664CFCR6/hq+qFxUggkzCMbe
         N7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788909654; x=1789514454;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ME4T4I0fml2p5iiDAE13UqY89i33BgyIDriKnzcytM8=;
        b=G/jzMihaGSDvg4/vudG4c7RTNvKJsYy6BLhLyDcwCL+Pn6KYvwYWegU1cbv9XKGBlo
         7lbI2KqN8OmQnzgum6zJhKEgi44NP27h3jeSyEYbwAG3lUXAYYipjR4vw7uiAl9+/DoU
         hgXx/KoDJT1amEVBdxzmMJWmNimpYSDbUO3hY770way6yivxDJbCpvukD+IVAdMLwBY8
         rEzUFGPYc/nLwM4RHips2iLUApYAwXrfs9CWXCHcgTLyehf09PA7+qNRHf6Jd6P1/oYf
         YGDb1jJhD4IzEjVIpcI0CWjDxPfbrNinRn1Au9MXLRnngJCN6VG9Tx4+qbAozGiJVas2
         JGqg==
X-Forwarded-Encrypted: i=1; AKwUvBxd1E+pGns5f2MQeQQgTpnnyIXC3iEnLkvE4vpdH/Rd80t/re+/m/QEa6G/elCitzaroMwlfWsVrUUX05JS7UGXFTjPgS4=@vger.kernel.org
X-Gm-Message-State: AFuF++nKsNRDDNldSnFDi5f1+YCCjXAB6Vd38yz7QTgnTzlzdllp98TF
	B0C/05CXbbOQxNtb09oDw6jFnyrB04FxBUg8KtKrLIrsQwoyq7Le+3CKAkXQwN6dA0MP
X-Gm-Gg: AYBFou2nEpxx+v+IBnbjDEx/9aiGjw+xKxsafoHcviTmxqPYcjcGB5dz1vIJUTFy6X5
	Y0JUy8GsUR81tBPE2+rp9YFdOkgCcyCUCzOUe94VeaUC1qAAIyULduWFvdS5jQ8/KovsU/PcmNJ
	0SVKRn8+X3CGmveckpVT40FSK9mtfiHYkDlHi/V4Cv61iLol6E7PQldAo4is6NMvBUEy2Smj0jy
	CcGtlKBYmpfGKPPckIb4l0WVNQwygN4oKyeoa2Acbqx0QLRgEXGfF1mkBW/joDFfzLtHx1CEsly
	vDmrsrkFHfJjHrexNZFlkT3aK/C+E4rHu2brsbOgGaU32Uaqvg5Bt9nDRSKAZIqWXgMqNYRnOb1
	zCSBru9Z8D3MJyxxcds8QeJDeTgH8mkIOKvLYXe1Eb/DNwt5rtor+rYFwsqqj55HDJt7DtlnsmD
	Mo7zzVR/029zglP6/GQ26Tvp2i+bc7BGLQvVZRxhERrDaW2oyJuZ/B02GYy7jBS8JRg67uyA7xm
	TAOo2TYQn5KSyRnmz5Yezm6c+bTDkwQXSr2+FHRuKpDo8TgyOY=
X-Received: by 2002:a17:90b:2c88:b0:398:ba56:b926 with SMTP id 98e67ed59e1d1-39b262e28c2mr51899372a91.25.1788909653985;
        Tue, 08 Sep 2026 16:20:53 -0700 (PDT)
Received: from lima-development (163-53-146-23.ip4.superloop.au. [163.53.146.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3397c13dfb1sm1890239eec.2.2026.09.08.16.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 16:20:53 -0700 (PDT)
Date: Wed, 9 Sep 2026 09:20:46 +1000
From: Matt Bobrowski <matt@bobrowski.net>
To: Paul Moore <paul@paul-moore.com>
Cc: daan@amutable.com, KP Singh <kpsingh@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/2] selftests/bpf: verify mount idmaps reach inode
 hooks
Message-ID: <aqCYTn8RwpqrPrgO@lima-development>
References: <20260904-lsm-mount-idmaps-v3-0-920a1963675d@amutable.com>
 <20260904-lsm-mount-idmaps-v3-2-920a1963675d@amutable.com>
 <CAHC9VhSmpwpvjVPaEKVVA0BnYkn1M+-f4wYDb8uvcL2MQfH9MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSmpwpvjVPaEKVVA0BnYkn1M+-f4wYDb8uvcL2MQfH9MA@mail.gmail.com>

On Tue, Sep 08, 2026 at 06:22:31PM -0400, Paul Moore wrote:
> On Fri, Sep 4, 2026 at 10:48 AM Daan De Meyer via B4 Relay
> <devnull+daan.amutable.com@kernel.org> wrote:
> >
> > From: Daan De Meyer <daan@amutable.com>
> >
> > Extend the BPF LSM selftest to exercise create, link, symlink, mkdir,
> > mknod, and permission through both the VFS identity idmap and a real
> > idmapped tmpfs mount.
> >
> > Record the idmap observed by each hook and verify that every updated hook
> > receives the mapping used by the VFS operation. This provides regression
> > coverage for passing mount idmaps through inode security hooks.
> >
> > Signed-off-by: Daan De Meyer <daan@amutable.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/test_lsm.c | 231 ++++++++++++++++++++++
> >  tools/testing/selftests/bpf/progs/lsm.c           |  79 ++++++++
> >  2 files changed, 310 insertions(+)
> 
> Do any of the BPF LSM folks want to review/ACK this patch from Daan?

Sure, will take a look this evening.
