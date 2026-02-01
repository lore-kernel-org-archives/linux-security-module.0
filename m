Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40283EBF37
	for <linux-security-module@vger.kernel.org>; Sun,  1 Feb 2026 12:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769948690; cv=none; b=T/3/i5d/vQ27fVLGeyEVjUjEfdBhGTXYRwLG712RsLT44D/3Aa9iprg0NvDsULk4DPWfdxSDKKWTAgmsUwfr7JZC6gxLFEontGJV25zR3DID+iO7PBMRr+iVFUHnZpa1Hvz49EH6Ojmwk8Lyo7IQEYqTtGFvsSTezAsZYCM51+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769948690; c=relaxed/simple;
	bh=Wkbw9ZWwBhEOOLNq2M2ncDkt0f334rlnq51UOYJMP20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Goya3OK+d0H+Azr8cf91xvzRhgEUtBYztMV/n4J0+OBPyi7RL7GVuTdHxSOeseBYPH9WD4p4/sjCzD0fnGt7NLdSntGz2BTUbGYJUhCxqDi5xzdB26aO2OoqV6Co7Yex5gLGGRGZSS93RArIG3v2Lh+rwYnsozdCCimJ2miVjvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5hSNxzh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5hSNxzh"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-480142406b3so25606475e9.1
        for <linux-security-module@vger.kernel.org>; Sun, 01 Feb 2026 04:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769948687; x=1770553487; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c6hqkimSgoOQFqcT8+zLID1+Rf/zRZsTcAtFNVsHMT8=;
        b=h5hSNxzhMqg+wWeQxwNQR90PrBI7dsrmJ0yWgU0hcKXyBWToyqJoB+CMGUt4r4wqNA
         bRtVvs9yihXBY5UKTj354zC1M9jRia2w8ojXT/bEwyEvQpYwmlIbFszOlNJ58vQOOwqJ
         s1QEK/xISu8BmF27dw222tq4bYzryUx4z0aj4azUhTpx+z3pbtjCdM4ksaGMoKkRdLVt
         /3wBf2wQ3bs1AZrQYvhFkfKXaMJ13TvGe8e42JO6ksDeULoM6esWJQT+ivCIo0O7u77L
         +uz+tlZLFKSryu9fW+RSYUHrswc8KRobbwyCGPUHBDdnESf8MTvDDJFc8xYXvw1QbzO8
         +FXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769948687; x=1770553487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6hqkimSgoOQFqcT8+zLID1+Rf/zRZsTcAtFNVsHMT8=;
        b=SGe4wmOBIhKarAMV3cMG6j0QiQPM+obKaS2i4oCjLO+24qBew7l8lnGimhW0clI/gJ
         3GzMY/Uaw37HwPRo5wgvSb2jroiE1EGm3CKeDbVaWILTs6LH564yN4Oau9aXRiyIUfdq
         Eu3YPEtpqIbP0C7BoiS5y/nmtGeMtu0z75oJ0u0oMzooSFTmRhLduIL3XUuU3D9EKRSs
         BcU+03N/DErN+W95CnKxegwLuWzFwS2My+DT9u6Xdqs9W9JFEz1jzVtnKamnQjYhDi+N
         GrsfB/be4L1SpaQ023m4ncqhWFp+ZIAb7wz5LvL/Br8hClCvse2XX21tMhyCAgSbUPKb
         YXlA==
X-Gm-Message-State: AOJu0YzmKD1gIZCvKN+IvhHeqJC+gIkO/GCSHPrX0Q8ewIZJcW0Dk9pu
	DtnjjfMljR6UROoEg/a1ZfWkygpvGJ0wG41cfK6u1vHqT1wgqg1gHdci
X-Gm-Gg: AZuq6aLseq4ulS8lW925KqytiPe9DOZLnPt3fr5sfVfU6JGBvGLuyJ50ZFt0Zje8m28
	KshpFulE00OYFjJGbNgBwaQ7w/QwWACyso4mEcVuorcfzz351Ozzj66k+SEpu2PIjlR+B5fHweG
	uGt0NI/+eDyCqx1sGgNIB9gAcLMSPBJZMGjU4k+zoBh83SYF/xdUlX3GB+rl8yqUmMNIGQLV9dq
	qx0Vm0VSy374vacikYIMQD9q40NpsxmDrba9YphWhKhTX/eF2EhkPIa0e1FHPz07Vcya4s9EqnX
	5PKlcmBtwlpbDc0tRFM4M7W5YaMA9bMTAfAUD3viZwAkB7pCnFZvJuTO4IhF8vi8mWce71LRTxl
	53TQekFHU9CoulmXMX7N3eZwmTxDJzsYd3G9vYilP2zsBDaYhwLue6u7m4p2TFZnmuJjTIav5hw
	9bqejbY09Bgt0Jgz3amxHpGFhoyV+j8lFAf9Ck
X-Received: by 2002:a05:600c:3e1b:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-482db47cd93mr90342055e9.21.1769948687167;
        Sun, 01 Feb 2026 04:24:47 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cddffc0sm373925755e9.5.2026.02.01.04.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 04:24:46 -0800 (PST)
Date: Sun, 1 Feb 2026 13:24:45 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 3/3] landlock: transpose the layer masks data structure
Message-ID: <20260201.5e9323a3a016@gnoack.org>
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260125195853.109967-4-gnoack3000@gmail.com>
 <20260129.oozohZah1Uth@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129.oozohZah1Uth@digikod.net>

On Thu, Jan 29, 2026 at 09:28:08PM +0100, Mickaël Salaün wrote:
> On Sun, Jan 25, 2026 at 08:58:53PM +0100, Günther Noack wrote:
> > At the moment, for the filesystem access rights, the data structure
> > has the same size as before, but once we introduce the 17th filesystem
> > access right, it will double in size (from 32 to 64 bytes), as
> > access_mask_t grows from 16 to 32 bit.  See the link below for
> > measurements.
> > 
> > Link: https://lore.kernel.org/all/20260120.haeCh4li9Vae@digikod.net/
> 
> When adding extra links, please add a [1] reference at the end and use
> this reference in the commit message.

Ack, done.

–Günther
