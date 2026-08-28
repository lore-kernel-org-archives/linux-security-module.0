Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7350C2620DE
	for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931373; cv=none; b=MmqC8712YZW6h56XSxmX7IQfqtzPwIe9pRrXxk68n98TKjkzZojRLRm5u6yvLpvXK8cVfqrD4rf91fGOqA2xV7gm57XARAe7aT9gOuCi48OVCJ4T6/M83alaThp47dmTV9dpV+KM3Va5mAtPm8omI2KQlpb3OfCqwLmDLJYO6bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931373; c=relaxed/simple;
	bh=gnIzB3ULi7x5ONQLDvVTUDoIOX1PzdODHvT44xCkI2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qp/+iH6kJgfcT3EBhO3d7J79aIVJZHDh8FyvimAJTcJd+aF7JwvTCyq/GUuo7Z2tgfUVFj+3mQfjIHBDnT9vObyYlmpgSo4d8uNIKRgrlyFk23oYpttPkRkoLKLMrnNQdlfEHvGKU24R3GZIRuVO7AmcrJhrF8QhveomR3s8tEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apD7kXZF; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apD7kXZF"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-482e2904915so814562f8f.0
        for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 08:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787931368; x=1788536168; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1orVkvfwH46u61Ql1Gfh2n9UOhRS6qwriTQ/HzVy+pI=;
        b=apD7kXZFoOUaQdhNp5kVLhMC1C5fLe/uXaVXCts+YHrdQoNmfMHD9BOfx/+nC4Wipc
         A+Q4gD2VNfBXMKF7SxZmkq20bexsvf6DTcSTyLf7/+B/JrC77EfFs5CJ85W242Z++yOF
         j5TWc3g3qtDHYO+Hc3ocnqp2w/gPpifvC9zractrntZFW+DRTsEx2wY4dNxyrfEH3KII
         9nDpYFU9bQo5iy6C0ZUjMQlh3lqPFCGKm1McB4+tRtixM3b0iK17wXa2DdFDX4UAHtDh
         GUC8HzLih9SjSAYTlEs8bXsAVIcQlXg8PgZsini4DCP5hvUjAC9nHMcxU+15ezGSnI+d
         TW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787931368; x=1788536168;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1orVkvfwH46u61Ql1Gfh2n9UOhRS6qwriTQ/HzVy+pI=;
        b=Bt4jbYkdbf46lcdmICkAtwhuBRXplFCt50SptxQglqbfd5/2gZlkWkVjnWhyFuIH9y
         FbreLUMFYovxsMmaKXEUh6NsWy2w43v1r6ru62Jlplb8AvlCPkxmU8TV2fALu2wTIOU9
         vNXmpI878LDljUq7RQyNbRrPLd8IVmo3mRIdKLad50eDoDmV7N1g9Ovqor9evkQxS1Wg
         VHoz3gBrO7btExFvF/65qyjjS2e+p2CjcHe22bbreWlIZkbao6zQMOwuPBraz9KJkniO
         w36C4TptOwVVrxvESu3E1kFYOFcvn3HrkXI2cUzJGTfrDbjLT9aMXnEowrYy8h73IRLY
         UnsQ==
X-Forwarded-Encrypted: i=1; AHgh+RrU6y50u2FQBSY8cUJAOiG85dPmDq4jwsTc/u1yX2dLD2rLsFavTw1ZzNa/80jIb9V1wtVBsgwNDs8B8Jq9ZfESm570STo=@vger.kernel.org
X-Gm-Message-State: AFuF++mmKYyHr2Q2Q15MzdvtHFlVOmCuSsfBIzRjwiKR7Z87BZ9/uG1x
	RCBbMpcuZO+AFBd3MGZYooFOe2abpfHtI5onKR/RQmHvTucGjHQyuEhb
X-Gm-Gg: AR+sD12rcQ3hNzvKOZ8Dwh9y1OWfCEJEosZKutmUViy0e0hl0wqenOHZmw+7nplf3G/
	r3mGBbjhOKmZGsLIKo9qkBD1JMASA1r528bHDaEJ1yPoj5mmHCWLvxcH3qohYVotBiRo4hSjway
	o93rQs14OtWvau66Uzmu0Ex/i98kCWgQW6wzQa6UUCT9PlUlj6pAYp/eMXI8NdtKm6lFGlz6lNA
	3yMI6NXrKb16pz4TpqDPbZ4kQg6fxRC4F8YoI4RWCuEpyGhigHtN35yh3t8r2xg6uUUgFTHWprN
	c8tT4reDLm7mfb5n6hielNxgpVXV7x3lp+mSO9hP6mKhaIITpxhHVsZF6tZ1WCm6FkPILiStayG
	pWEXWPe1W1HWjVBRZ5ZCQ3emXHqx+aYcEjPmnm712srLiyDJr2M+5icB6ewZ7j3Xqj9HIGCY/MF
	/SMHGvbwkdOhVA0RLwvKReeVWJRfuRNrruvG20lH6d1U23/YZDXDm+b6El3RPb2WhX0864/uAUN
	zyT2RRrc/Ev+ag=
X-Received: by 2002:a05:6000:2310:b0:47f:8183:e9b8 with SMTP id ffacd0b85a97d-482f79e1e9cmr10847640f8f.22.1787931367551;
        Fri, 28 Aug 2026 08:36:07 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbac8e61sm4800483f8f.13.2026.08.28.08.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:36:07 -0700 (PDT)
Date: Fri, 28 Aug 2026 17:35:44 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com, Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v5 6/6] landlock: Add documentation for UDP support
Message-ID: <20260828.942ec705ed5d@gnoack.org>
References: <20260611162107.49278-1-matthieu@buffet.re>
 <20260611162107.49278-7-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611162107.49278-7-matthieu@buffet.re>

Hello Matthieu!

On Thu, Jun 11, 2026 at 06:21:06PM +0200, Matthieu Buffet wrote:
> Add example of UDP usage, without detailing the two access right.
> Slightly change the example used in code blocks: build a ruleset for a
> DNS client, so that it uses both TCP and UDP.
> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>

Friendly reminder, would you be able to transcribe the newly added
documentation into the Landlock man pages?  I added a tracking issue
at https://github.com/landlock-lsm/linux/issues/66 where I outlined
the rough process, which is mostly mechanical.  I am happy to do a
review.

Thanks,
Günther
