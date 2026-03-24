Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA53390CAA
	for <linux-security-module@vger.kernel.org>; Tue, 24 Mar 2026 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366238; cv=none; b=VvRVGOSL4p+VviFmIExTKi4sZ4mK9dU+KF2XGFiFJiRvFk4By8zPlSq+h1rSfiTICL13rBOiTIQeklxhn2jdTVVj479xVBasJknutxJNKeKsrNaIkXSy4faiho9ZjZSitF2YomTYJkAGOdQ18JNBuB02LV8RruRw24xDQwZ6n3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366238; c=relaxed/simple;
	bh=gAfLzcxzb5imxOXbOMzClv6ppwCmz/QiaDAaLw0iWak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOuxleqMRc7VNj8W0Lu1Jxzeq3/RVsXaP2ekijAKoB1pxiRbS1ePxkFE7MGRLZYm0E36NSu3oKhI2WMYIcaa2uScZRB+0o93sXtrCL1hvNCYwwRypuxlsEu40l3woL8JNH3V5k0kfEJLukM8EMNeEZRO43j5vora0DprmPpWt5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XV2pXuWG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XV2pXuWG"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fe2024a9so32000105e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 24 Mar 2026 08:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774366236; x=1774971036; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EYKECZ+c2+1LaN0ZpFAMYQ/fUaZTTSWm0KVzZuhW4Vk=;
        b=XV2pXuWG7rxFy5ipjK9CA18xJUvder5LDpvT+L/Li6pTg23usRSINUk9udkN8adrQ0
         9ThbsJKLArHhkgGnnMxlphnVrYXZHi0cDcrJ4KoGv1V5M+pb93/QMQlX3Vy8QKzk+6oM
         aTncfP9WM8JjSmr70VMcuSR3YV50pafVWvYAWdKussborjmYdMFkUyhzwDhEbEEVklj1
         ALgjT8iIiaQux7zfwKKFAH8/ianFnZZct3tpKWYokJPbVBU3PxIsduoTRNZSKn4HdfH3
         b+3k+WU6+1Rd21BLU1yRMQOL9L2DTa76Wp++71qddu4YcSUT+mvEZ7uaB3S0GwTYPpAu
         nzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774366236; x=1774971036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EYKECZ+c2+1LaN0ZpFAMYQ/fUaZTTSWm0KVzZuhW4Vk=;
        b=KfKq3B1bS/+R0zdaBa1CLbqViz8dCPSLJ/G9d/wZCiBrXawQjwUvBWVo+KFrJr4UrR
         IbhDoHsE4gQjJ3st4wKoYK1eRjmTgzpcxtuza7lxhK/ximgpBx03/iBywabvjOYHreVv
         nvfCx/TzXCX8S9rVocPEzTuqzjLnnBQXLzBfLmz4kLOsnzyHF5FvSRDrG0U0o/h3WeQu
         cugskCKrkuBhy2LBwaRWq1qfWlphgN3hA3UgjCFU4V3pYlIVvrXtAIz0Z0+eEsnvgOa5
         is+/xSOrK+8lVuoJsm2Z7R2dmF2s1UkR6lExWH3zR6RKEFr24TGJoJQXsQgkk2TjD+Xp
         oRLw==
X-Forwarded-Encrypted: i=1; AJvYcCVxLIjj8Wdsl45u69zVqZsXv3f6nVVMxTEKuif8AAYs8eTTCQ/KKrPiAORGO1fS7Z6n+5shjGEvuyMrHDFLSQmIvUQStxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8eOYDOHjspS2XMGN8YdMVypRFhw8kiX95JLxqTHgOERciAnDU
	oCiyIQm1L11WgfPohej6yw4jmpbhlGn+K1DHbRZo6Ksvtuuf54bvj6WCH1CS9J5OWQ==
X-Gm-Gg: ATEYQzzepwmr7NGpXH4/8Xq25nPGdF4mf+/PyqhPIrAILadMuSwTu3wjff9y7Eqqd52
	gCJq6Wr5rv4QEZeVUmuxCxwDE8HG5nj3MA3iDpAW+dLVeVA6n6f+cnZMWrsO9DQyGl6qAzslDgc
	rbYdJ/DzPuCpzYjSXVTKaqKQhSg0WS+6V38obruD0Iy8eoXVdIO3vD+zpg86sDq1cr2qKoL6Pvf
	58VA129xpo7nGIZCrSFG8PIlVaG0xSnrZUFN8KTKldALiRhxZJIHdD6NRr7vAPb5XeWLiFjDcSu
	bKfN8Huv849Z887z8Y35d88PmPEAf5rQby2D+p2KsSuGDYLViaEGBfkgj3BX/kwnD6BivuM8kZG
	rV2wC0tdVbiRpclI9wC1c+RWvcO7Pw+VwlR5MZJtgm+khhVKnJgPVc1bm1zEJU/sGs/bRJUBzxt
	ErxB4xITx1eE4QvznXu4/Cpt31IEq5kvXfnOxOM/WHQ0bjnS9kqXYpzQ==
X-Received: by 2002:a05:600d:8:b0:483:1403:c47f with SMTP id 5b1f17b1804b1-48715fb7246mr2891295e9.6.1774366235189;
        Tue, 24 Mar 2026 08:30:35 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:820c:ac9a:1d85:a65e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871105c799sm26733795e9.20.2026.03.24.08.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 08:30:33 -0700 (PDT)
Date: Tue, 24 Mar 2026 16:30:27 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: "Panagiotis \"Ivory\" Vasilopoulos" <git@n0toose.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dan Cojocaru <dan@dcdev.ro>
Subject: Re: [PATCH v4] landlock: Expand restrict flags example for ABI
 version 8
Message-ID: <acKuE2X2PWsRkfpR@google.com>
References: <20260304-landlock-docs-add-tsync-example-v4-1-819a276f05c5@n0toose.net>
 <20260323.sheiHaR5uRoo@digikod.net>
 <acJa_56LtPeeH956@google.com>
 <20260324.aqu5Eic7Thee@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260324.aqu5Eic7Thee@digikod.net>

On Tue, Mar 24, 2026 at 04:06:01PM +0100, Mickaël Salaün wrote:
> On Tue, Mar 24, 2026 at 10:48:29AM +0100, Günther Noack wrote:
> > Apologies for the delay, this must have slipped through the cracks.
> > Thanks for bringing it up again.  Yes, this looks good.
> > 
> > Signed-off-by: Günther Noack <gnoack@google.com>
> 
> Shouldn't it be a Reviewed-by?

Absolutely, thanks! I meant to send a Reviewed-by.
Please ignore the previous message.

Reviewed-by: Günther Noack <gnoack@google.com>

—Günther
