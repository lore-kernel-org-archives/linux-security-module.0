Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F349F3C872A
	for <linux-security-module@vger.kernel.org>; Mon, 20 Apr 2026 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776694843; cv=none; b=FDJt5zp5mc5TphQiIufBBq8YFW5vFuwCaNxMLtNL/aSWBznrQBTsWVXrAxkIvhdRnvHTb+fBVptIxcQyPJXU0VW7jB6u6zW1XwisQXJ7sTPi0pzeD5FYLvrPuLOVSBdQF76M8yfNrCguB8jKbmCTkzWdLzJW39Nud29Y9dnmzpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776694843; c=relaxed/simple;
	bh=2KVxJI9ejeEZMIbIF08+ol9mi4y5S3ApoE9rL6Bsf/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8i06LXy4LaE77zJS+nkukr7CsoD5lVon5Srgk/7dmB5CnfuhXe60abFN8wA2h5f/A79OLyjGzwo+tWLoUgh/fLgp8kACBOCuKdEFZOjaBQxp55dz4dvk3/5Kp2Uo8ePwe3asQPDYnXyfNig6dLuz8gFFI4HGV+BFiDTlgmnjYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JiGwj+Wb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JiGwj+Wb"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso97375e9.0
        for <linux-security-module@vger.kernel.org>; Mon, 20 Apr 2026 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776694840; x=1777299640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ReL9mAV/3BRJ2Kkh/ldlZKgZcqKVBFpRWFlO3tSbuI=;
        b=JiGwj+Wbv9KnT3gRkEmweNEBnkubyyFIMerjCd+FGTG4AzpYCCsaEU/xN7O5bZRRaV
         3vtmu34laWP2K4CGm2ygW0hbACmBMkxB18bYDvS4jtoVayGB3Mql7Ye2RiY9tHW9P8Fl
         OKUp+rwLTXd6e/UnVj6IclbML22doBTSsXiDgtchEGjE7RP2dNUeaQ1QxehBI7Wb83qf
         r7TQ2UhIqR4OxH+qmBGc39RElCvRlSu+3505capXf/v6r1z1p9FUoKX0ozVaaWdiqC1n
         PM3CLfKq0qH5mhm+SXYFDGi3khMsSfsOdkJjFxopAuHpM5TVpAkoiiSMu75bGoLHN7Wr
         gGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776694840; x=1777299640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ReL9mAV/3BRJ2Kkh/ldlZKgZcqKVBFpRWFlO3tSbuI=;
        b=kuhre3j1wOnOIDcOPNILG8yzn6aA58/CNtYV9Pv7eWY14V0xergEx5HA4g+r/TuJqV
         3rcljsqAUANxmJUTcjy/O7Q4KnyVF8GbiZ2Hdf+JNNaC8r+cd5hpructqrcYXVw535UV
         +t8mmrc7NiZtGjiRvrg5p1qG7CcT6vFfS38GujdOarItM5DKr5dAcwzQzjG8jwlZ/yAs
         M1W6ZCmWKYueX44EwJ6E7V2ZVUEa58+w1nMnKeS8KS/9WybtoAD11IHI4t2WbxLUUUyb
         RS6qZ/aK0ulJCt/6jGV/oZaQ7KSeUCCno+VeFilbB6rz1HnLOo7yhif10ku88tbmih2j
         kGrw==
X-Forwarded-Encrypted: i=1; AFNElJ8jKdN9Fu3jkQOktFDEu4Q+L9gqEiYYCaDiv9JzK+psn5P2ZNo0SmUccVZSiV5kkqbRHoW0UIXf+sFWoJ9HAgq6ykzmz9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvahcCRXql4bn3aRrd8KTLbITBeA/x5kyV5YAAql9WoWgDP0WE
	gBLzWf9V7Vq5fFxt3DFhJ2YGJMWAYtvNRBaiKYhhPMAbdDSZ0b07rkG84pLHbN9ovg==
X-Gm-Gg: AeBDieu+U0bIzDCyZ5WGlCkFw9RRV3T8Ob+hdmO67iwO61ED9le7WZe7gZ76Rk55HTB
	VojVHg+BH8lWT792sjplWqIoIBjhIBiWZw2SxGvpfZbgBj03JOv5UzStb4YIy7MNRCCxF2H/st5
	SuNyxgqDUp2DLDvxfKd9UsoxtcvE9U7ecaKVSDRwiX3Xg9fcWcAAO6QVc6lbjFmDcQvbYjI5BXj
	KiHeFPpT23Ozwr8ueIVCWZRayAs1n3ZqWkJQd/1nsVUXy9k1kqCh8skRXsw1O3AGeAeWkieNeKf
	OKqNFCBSM2ajRwWg1h5hTbpwoXzeuzOcJLfY/g21N3KkUDYKOsMZ1YatPCW9WcUrriKdEmgg+ZJ
	fD1x3dZ/5/4ccDN4rw0V86Ibi6vduo4tyTCjW83qmMERaeyHl8geaSUv48/M71rIdINxQfG3OQy
	pKdIRKAWjDpQ46xrvHxsvb8NJOUdIU5co+R/Uux6IZnovIsYsi/EHC54GAe27bW+kM4qX15vigq
	NF+dKmM/iOqp572RXY=
X-Received: by 2002:a05:600d:848c:20b0:485:4133:4021 with SMTP id 5b1f17b1804b1-489013bd634mr1619625e9.7.1776694839891;
        Mon, 20 Apr 2026 07:20:39 -0700 (PDT)
Received: from google.com (117.15.199.104.bc.googleusercontent.com. [104.199.15.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891c318636sm86355285e9.7.2026.04.20.07.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:20:39 -0700 (PDT)
Date: Mon, 20 Apr 2026 14:20:35 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	sudeep.holla@kernel.org, oupton@kernel.org, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC PATCH 4/4] firmware: arm_ffa: check pkvm initailised when
 initailise ffa driver
Message-ID: <aeY2M3v97c00JjFe@google.com>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
 <20260417175759.3191279-5-yeoreum.yun@arm.com>
 <aeYbdmshGZJ4GhXd@google.com>
 <86mryx2408.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86mryx2408.wl-maz@kernel.org>

On Mon, Apr 20, 2026 at 01:46:47PM +0100, Marc Zyngier wrote:
> On Mon, 20 Apr 2026 13:32:32 +0100,
> Sebastian Ene <sebastianene@google.com> wrote:
> > 
> > On Fri, Apr 17, 2026 at 06:57:59PM +0100, Yeoreum Yun wrote:
> > 
> > Hello Yeoreum,
> > 
> > 
> > > When pKVM is enabled, the FF-A driver must be initialized after pKVM.
> > > Otherwise, pKVM cannot negotiate the FF-A version or
> > > obtain RX/TX buffer information, leading to failures in FF-A calls.
> > 
> > At the moment this already happens after you move back ffa_init() to
> > device_initcall().
> 
> But relying on this sort of ordering is just making things more
> fragile.
> 

Thanks for letting me know. Since this is not a solid construct we will have
to change the driver init code to come after pKVM in this case.

> > 
> > > 
> > > During FF-A driver initialization, check whether pKVM has been initialized.
> > > If not, defer probing of the FF-A driver.
> > > 
> > 
> > I don't think you need to add this dependency. pKVM is
> > installed through KVM's module_init() which ends up calling hyp_ffa_init() to
> > do the proxy initialization. The ARM-FFA driver comes after it (since
> > pKVM is arch specific code). We don't have to call finalize_pkvm(..) to
> > be able to handle smc(FF-A) calls in the hyp-proxy.
> 
> You do. Without the finalisation, SMCs are not trapped by EL2.
> 
> And even if it did, relying on such hack is just wrong.
> 

That makes it an even stronger argument to move the driver init at a
later stage. I was relying on this to trap early ff-a when the
ARM FF-A driver was used.

> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

Thanks,
Sebastian
