Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86E953B5FD
	for <linux-security-module@vger.kernel.org>; Wed,  9 Sep 2026 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965699; cv=none; b=ogCcY4Gx3SVVI4SAD1CdpvYPILWJJ7I3pvRaF2gXGo9YZr/g4WDzFJkoAAJ/O5hdgcYG2tFUfD0YvqsdAJuUEohmX81Q072qA7UytUCviWH2u0DMWf0dKJ7c6P0TqfWiUNLgp2EF2PRz6ligOOPZUT43t4Tvab8+SwYIewz0JjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965699; c=relaxed/simple;
	bh=3mrzF4PFQcJ4DbH3RGaSc+zm2PljjP5W+lnaM84CL3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZS6QTPwUPzzmURA9kwtRIMU2tlKxzHKHAZsarYeCnRZ6QjCtgGWDaSm2AW/+kqXzhRaHYzKWPYKvf1U9WdQ88KpLtFWZYnR7lw+z7pEdML1ACb/8+eQrWtp/hqYs+jLu7H1xYmcSG7D0UGOfZZQG+bsRmqueA6IP/DOMQTtZ00A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IffCLY9U; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IffCLY9U"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so8357915e9.0
        for <linux-security-module@vger.kernel.org>; Wed, 09 Sep 2026 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788965696; x=1789570496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CEnAlwwtVf98S0MQnKDx/a7P5qnwKuSWE+q0EOlFqn8=;
        b=IffCLY9U20m06r8jq41Wip3wbMxiCRO5u98+gwJ4IShm4wkkg7X/pL8ySww6J4XebT
         8G83o+T8HV7UQxDY3AILmU5PPSPuO0534vpsVpgml81WxUkg+jSWdlsrkZC1XojQfCR9
         wPEjfOUTpu0aWTpyHsP2JLI4iJJRVFv2sABsgKZDRr9k7CZCff9jMvjKbbYGvq36IDFe
         m7IyRHupa9IRPB9ER/5GcA3V13z7+3yeRCUbOWz3N6E2aXBB+QFxpxYsIAmSR8V60/bn
         NLxgbMrD38xmDezTXGpi3zHNw6RU9YnQGWCE6LS1nhtK5eZf2geTo1QVmBir/zZ28I2y
         AQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788965696; x=1789570496;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CEnAlwwtVf98S0MQnKDx/a7P5qnwKuSWE+q0EOlFqn8=;
        b=NAoWKbUAaZEVWuuHzU131qd4TNeCWfS3j9GCFm0mGl5jcdkUDyel0p9W5lt4anQ5jU
         A3tovjqjbtORqLBLqNapXetWvC7Ja5dE8h+y4xZQ3u8k3yBQJTYU1x+actTiAccrI8qo
         JR5b9Tkh2KaF7+Wa9tGQPCkKSVkenOqvBH+9tFw0T3+180I5w7xc0LEJYHmBj71P7xeg
         cFUVsrJKLXHPy3MwSRwyYvaWEKcXwzGwjdLiaq4/FZwosDS/4DvFAnZ7Si2SWrbQzGrS
         zATg8kvvALJx/V/+L4QaDxazLJNx/Y8ESGwEE3iJgOEhUypQ6/0oqAwRBhIhKuBKJQVR
         buEQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjqiArVz/OmBeTdNx5vI/utuCdHO1uQ3DAfmAVC1+m397nSn8RZKiCP3fddPgwktqlioP6IEFDGXOcDR4Lns9Bb+IG6r4=@vger.kernel.org
X-Gm-Message-State: AFuF++lCnYA1q1Kj6l5ay2Vowk0LU5s+RI+sDpsC4ZELoplbFn+mHw6M
	+x/3bTKcOaT4S2s4U24fOaZN6Cn+x0+mDryoKOiOvcm78ZYfOfcswf+5
X-Gm-Gg: AYBFou3TLbDOtrHiH49kAHxSbMvqtcTvz6xaTh/cbpnT3wKdlkEe5mURpNy4CzRDCqB
	Mi60HdHoe95GaSgwYSJlypx7M5hqNGeUVDxXq/e1aqouNVeXFvlexgXBulyshTgFtkYGwMZ3Lm9
	MaEHctX+vyST2fOTv+cvUEom73yzEWJgnh0PGFRvS+/LsNEjZONhMtUPKqTI40mHBHSMCHEyt+k
	A1srEtUM0U6uYH8qWEL1Bqa98kc0mIxkkDbhIsCfYEWHQ058+kTB9tj7ER9V4rsEhB0errodfKH
	FbdvUHkthUaa2cynm0hImCUKb3H3v3rfKDSrcGieJvnQvr8OLl5zs/bAE344GMBHu/gU4JpDaf6
	1TOWV/sQLBVn8EydgNIv+aWF0IwzUzJA3+kOu8Vemt+9i1XUKaFd+hdjvivHSqbnWIvN45XdtEE
	pLFUJrMNKJgd0xIDh4xYL8oM6JvGDFsBS4frfzvJKmxkYgjaBejFIIgB9gfWjpXYpTc0Rw+H4HI
	ZhZx6M=
X-Received: by 2002:a05:600c:a01:b0:49d:1916:2133 with SMTP id 5b1f17b1804b1-49d1916215amr117005945e9.8.1788965695566;
        Wed, 09 Sep 2026 07:54:55 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d03543064sm384918195e9.13.2026.09.09.07.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:54:54 -0700 (PDT)
Date: Wed, 9 Sep 2026 17:54:48 +0300
From: Dan Carpenter <error27@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Breno Rodrigues Alves <breno3011alves@gmail.com>,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, arnd@arndb.de,
	linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v5] Kconfig: fix typos in core makefiles and purge
 defective DVB debug (v5)
Message-ID: <aqFzOFa3ADXIBo3G@stanley.mountain>
References: <20260905003005.118245-1-breno3011alves@gmail.com>
 <22707a1f-970b-4309-905d-13ac794c51fa@suse.de>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22707a1f-970b-4309-905d-13ac794c51fa@suse.de>

On Mon, Sep 07, 2026 at 08:59:28AM +0200, Thomas Zimmermann wrote:
> Please stop spamming this list with revisions.
> 

Generally, the rule is wait a day between resends.  Otherwise it
becomes pair programming and no one wants that.

regards,
dan carpenter

