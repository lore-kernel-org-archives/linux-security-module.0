Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00B0612FA
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114132; cv=none; b=YZ4a8awZ2GAne9exGMz8yupn4hwpMWHmRBlJu2Jac0wlJ3wdpCxSAYtrJKs+zMzkuuad9C778cL2tRcV9NO1DSL67xf5+ATD/5l0XEeLc45j+hcOvNI5DOzNFIoqe7Fa2zqnps1dYKsjaWKhUiHlxvc/M1I/AXK/TYwk0bpa0qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114132; c=relaxed/simple;
	bh=bR0sAu/kS7bcb+D5Msz7ceuC42KnLeHSzNW2hRBbkrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRVPibvMmjO2YTmDPE3OP2OjVwRiW7fHtbDPH2mPr6UvV2CYnYAE5sDSyVx5+U4oMtCP2ghyP3ia9Kl+YAWzfEPxYDFN8+FKotJAsVmUjoXtx+vV0CGZCc9aWErFyW7xgUZFI6iDNfFAb72qyb1t9Lzp6K//AOhQq1R+smkX/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L1yZ07PB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L1yZ07PB"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d746ce7d13so29560385ad.0
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 08:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706114130; x=1706718930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc2ne9DEtozuAA7QWnRNqqOnd5KtqxPd0sphMP9Q6c4=;
        b=L1yZ07PBuH4ahcUdNgrGoL7mLH9141b7amG1yoAPASpabpStN2qFoJ9KrcqWlmj3vq
         rhoLfrZjYS20PKpjNaQRDUI4pDRigxtBge32DVThwsBJU8PbdJAaJHuiD7GxiYc+PQLa
         aM4VW2DmXtxMmDJsWLE5eWSdpBd96kbm25CJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706114130; x=1706718930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dc2ne9DEtozuAA7QWnRNqqOnd5KtqxPd0sphMP9Q6c4=;
        b=ce7mmabTsNKB+4kCuk0A+BKRJooQRc4pq6PTA+iE4qRkxR3JsRkNdqNekEDAMS0qty
         97WK7VSipKsDr3cI1wKMkgfZE7UhOO5tSE8EUSV/89QtJfzSZwM2b4uGct46sp87N0Nm
         dRjf3TTjZDofXi3/RK/oCMj5vr3MptsE0yCzxJkJt2YW1cLOqc/BiFsgr20fatdplFhI
         vgfU2ksS7oPRFnoAW6lkB1ZxPsLtDix4ig+OKtBJmXzckEF6t58+bmlgoBHY6GdciQ8S
         mClUhAhOrCr3Nwp9xmAnjUg54T85nP7Xqma3lGblJkFRQOXjdRIQbd4I8X+NzlIliXTl
         OYDQ==
X-Gm-Message-State: AOJu0Yw1th5hQP/c6KpzWEYtxQtnPPMZYW8PDtL53c0kDY5Cft1psHGg
	WAxsVub5ysWbdu7rDLcKnGRLJlXC8oEGoUhh5ygwa9ZoTJ5AgLSpgcPBdfcfig==
X-Google-Smtp-Source: AGHT+IERyxG8hB13JvayvVAKVYQEmEi/M546PMHAK2ELkrVVnnL9t5Wu3jy7ccSeDT6NM+9XiRls/Q==
X-Received: by 2002:a17:902:c20d:b0:1d7:5eef:4ed with SMTP id 13-20020a170902c20d00b001d75eef04edmr1176992pll.38.1706114130308;
        Wed, 24 Jan 2024 08:35:30 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902d04c00b001d73416e65bsm6909726pll.63.2024.01.24.08.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 08:35:29 -0800 (PST)
Date: Wed, 24 Jan 2024 08:35:29 -0800
From: Kees Cook <keescook@chromium.org>
To: Kevin Locke <kevin@kevinlocke.name>,
	John Johansen <john.johansen@canonical.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from
 virt-aa-helper
Message-ID: <202401240832.02940B1A@keescook>
References: <ZbE4qn9_h14OqADK@kevinlocke.name>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbE4qn9_h14OqADK@kevinlocke.name>

On Wed, Jan 24, 2024 at 09:19:54AM -0700, Kevin Locke wrote:
> Hello Linux developers,
> 
> Using AppArmor 3.0.12 and libvirt 10.0.0 (from Debian packages) with
> Linux 6.8-rc1 (unpatched), I'm unable to start KVM domains due to
> AppArmor errors. Everything works fine on Linux 6.7.  After attempting
> to start a domain, syslog contains:
> 
> libvirtd[38705]: internal error: Child process (LIBVIRT_LOG_OUTPUTS=3:stderr /usr/lib/libvirt/virt-aa-helper -c -u libvirt-4fad83ef-4285-4cf5-953c-5c13d943c1fb) unexpected exit status 1: virt-aa-helper: error: apparmor_parser exited with error
> libvirtd[38705]: internal error: cannot load AppArmor profile 'libvirt-4fad83ef-4285-4cf5-953c-5c13d943c1fb'
> 
> dmesg contains the additional message:
> 
> audit: type=1400 audit(1706112657.438:74): apparmor="DENIED" operation="open" class="file" profile="virt-aa-helper" name="/usr/sbin/apparmor_parser" pid=6333 comm="virt-aa-helper" requested_mask="r" denied_mask="r" fsuid=0 ouid=0

Oh, yikes. This means the LSM lost the knowledge that this open is an
_exec_, not a _read_.

I will starting looking at this. John might be able to point me in the
right direction more quickly, though.

Thanks for the report!

-Kees

> 
> The libvirt-$GUID file is not created in /etc/apparmor.d/libvirt and
> apparmor_parser is not executed as far as I can tell.
> 
> I've bisected the regression to 978ffcbf00d82b03b79e64b5c8249589b50e7463.
> Perhaps the change in this commit causes AppArmor to deny opening
> /usr/sbin/apparmor_parser in preparation for exec?  For reference, 
> /etc/apparmor.d/usr.lib.libvirt.virt-aa-helper contains:
> 
>   /{usr/,}sbin/apparmor_parser Ux,
> 
> I'd appreciate any help debugging the issue further.  Let me know if I
> should take it up with the AppArmor or libvirt developers to better
> understand the issue.
> 
> Thanks,
> Kevin

-- 
Kees Cook
