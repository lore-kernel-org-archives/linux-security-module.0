Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61583FBEBB
	for <linux-security-module@vger.kernel.org>; Thu, 12 Mar 2026 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334495; cv=none; b=HlcL3ADGfceC7p5OMwibOogzmIzfp7Th3kb/qTeKngm4jUdSxFBee3RvTpi5XzTzIHyM71ipEjybPgyPAYvQz1w5WLGhYJJTWswh58FqRLOa/5OLJx2Jxh06Ds7g+5m0eV2pKM77XUMGslUv7fK70x/ZNIX7T0dggTZriIecflE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334495; c=relaxed/simple;
	bh=ENv0+4bH9YdpFLGeURNwJ3+rEUsnNn74RNCtOl26SEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aw7xzWmzbU4e1BSqAP3f9KPmVNpZlSjt0nAvxcMf7cJmaH/c+8JjXmwGf16KZplDnRV7dRpn/IaJYC8yOrvNboR8xjhnun++VEjot5TpwXfHxhIpGIvBDwihcC3gC+Rrp6KxpjpF40MvZDyuOGcCWff8uydXVR59LTDm9GDhNZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TCUycPJz; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TCUycPJz"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5094e1d17d3so7532871cf.3
        for <linux-security-module@vger.kernel.org>; Thu, 12 Mar 2026 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773334491; x=1773939291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VQXCfPVu6b6dIVECzm0C8AUD7IL7VvpSkD5+M4S95sw=;
        b=TCUycPJzE2fI+UEqk7FktReSuNB+qmtoLxCPQIhObf2GoM3FGGUoUzmOL4EcJ8nqrV
         31wLWw0iuRrm5q/A3vl9oGJab4nkcB5GgE9L87TaBE5zWVhGKUEWMOYZrC4hQkz7+K+y
         MdSN9PZxg9+VlLOffdwRmQphGTW7UoGABbBRu3CtgROAhKqAusDMmmrNFgCXGsGgS+um
         4b3n9KF8H9mgZuxtPx/c84lVtPd3kX8R2XT1vLZ+RjANCZT5FGS44RpBGA5cN1JRJXTn
         oCOtB2FnqO56y3+c6Fos0prISIneHSMHrQ7vAs2p/teTVBOn2DfneDCxuRpkTU9D9cja
         6IGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773334491; x=1773939291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQXCfPVu6b6dIVECzm0C8AUD7IL7VvpSkD5+M4S95sw=;
        b=YhZiVJdoVBddg8oknoiwcaysK3+trgqNz8AixQUCTknE5YWjNdHCiSOUfV7fbqVbEe
         VcL/OuQ6/rDiiAk4A45yRbqJuSqwb5Jbm529Gh5eaS2KzTih/URIbE/LzOO1F8aVmXvT
         HnkOkchYwZnZmY6bi4ukQnxuSg0vvBjCQeEvHZ7mCYJ6DXfD72wtLvgvA8CwDxegENrM
         f3Cx6AORAYO4a+shPmOhcOHXbNQjgII1MkiFp8+R6GZudP6HI9WQDXJXU1db61iQxoma
         YTW/xiWBzagM6LidenpH7Pt/K+KyLCBkrHBH/ej958m1ldxBEtzQSxtkqnePLhZS7UPp
         jobQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo7pkJ9H12ioAw0eOxeWtdSaXA7msDXCe5jsFLU495XahLDmEw/sYR+45q5C/jdfv8C1qn7+xV+VXtEeX7kd+B17wqkc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxitYqEd5M1MotgbTq8VKndOVFuz2N9QDi53NS/WrzhvnREoHL3
	cHpNc9evUK5JBGv7Az7etGS7Y9cUEE0Sqce45S9JPUv5RviuspHuFioybiSAxuSd71c=
X-Gm-Gg: ATEYQzxLAvN96Lfkv1DljZoN8QkIFEdx5Sj6SaihNsVKgmxJP3x1M+j3NT2QWsFIUZr
	/v8cO5NI5B+L+qHa84ZWh6E0F8Eov49B9PN2PEqnTJlYEZ95rO7Ffm3sv+NdG36grNm6eyb35NW
	PyIMcRS3daD4QYw/ylH8rdnGo+aa4dn6YyB9wYwpIMU2j3TCAIed4ehanQ2Kszfz+mapuc0i374
	PLLms/qx3T3gQcw8vKlrk3ExJmcpZ/IZw96wVLzXbGC8f/MRfXh8hVVdNbHS6+xPZANL+BCKlUZ
	Fr/wlTh/Dj/2RMLooJ8upRGMc3Evo+GkaBBKtKe3UoYGK7NhdFQqe/qri+TVZNvQjYFWdSjhS4e
	NyYeBXEISVoumdUqeat0npaMblqqvZdui+MxJX1zep/aR9jkItW5bC6xWsyePZGFbe6eYj5Z6O5
	tj0aWnKHGj05Xf1DhPZGuzlFzUfndPbU1OOoFdDiWWtxR+oKnWbPWZfRvS9Cr0o/w+BxOuXCf+o
	PJOs661Mb4SRIipfFM=
X-Received: by 2002:a05:622a:289:b0:509:44c3:5ffa with SMTP id d75a77b69052e-50957e10673mr1403911cf.52.1773334490530;
        Thu, 12 Mar 2026 09:54:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a119602sm36658181cf.28.2026.03.12.09.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 09:54:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0jJA-00000006i8N-40X9;
	Thu, 12 Mar 2026 13:54:48 -0300
Date: Thu, 12 Mar 2026 13:54:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Philipp Hahn <phahn-oss@avm.de>,
	amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Subject: Re: [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual NULL
 check - refactor
Message-ID: <20260312165448.GN1469476@ziepe.ca>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <abBlpGKO842B3yl9@google.com>
 <20260312125730.GI1469476@ziepe.ca>
 <f5688b895eaebabae6545a0d9baf8f1404e8454e.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5688b895eaebabae6545a0d9baf8f1404e8454e.camel@HansenPartnership.com>

On Thu, Mar 12, 2026 at 11:32:37AM -0400, James Bottomley wrote:
> On Thu, 2026-03-12 at 09:57 -0300, Jason Gunthorpe wrote:
> > On Wed, Mar 11, 2026 at 02:40:36AM +0800, Kuan-Wei Chiu wrote:
> > 
> > > IMHO, the necessity of IS_ERR_OR_NULL() often highlights a
> > > confusing or flawed API design. It usually implies that the caller
> > > is unsure whether a failure results in an error pointer or a NULL
> > > pointer. 
> > 
> > +1
> > 
> > IS_ERR_OR_NULL() should always be looked on with suspicion. Very
> > little should be returning some tri-state 'ERR' 'NULL' 'SUCCESS'
> > pointer. What does the middle condition even mean? IS_ERR_OR_NULL()
> > implies ERR and NULL are semanticly the same, so fix the things to
> > always use ERR.
> 
> Not in any way supporting the original patch.  However, the pattern
> ERR, NULL, PTR is used extensively in the dentry code of filesystems. 
> See the try_lookup..() set of functions in fs/namei.c
> 
> The meaning is
> 
> PTR - I found it
> NULL - It definitely doesn't exist
> ERR - something went wrong during the lookup.
> 
> So I don't think you can blanket say this pattern is wrong.

Lots of places also would return ENOENT, I'd argue that is easier to
use..

But yes, I did use the word "suspicion" not blanket wrong :)

Jason
