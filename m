Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E68486E45
	for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2026 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315904; cv=none; b=iE6g9hUS2FMnjDCyNc454Y0kXZuZ1dmw/phdZxlt0ew9a/2qFXDvfnc/3gNRi2r4kvOO5c+IqHhcjix6RdG8a3DQh9UGtPysulMvd69m84tGQvAKIrMCrHU86MifeCEj0+8i7DjTME7YF5VvYZL7Mi66Oj8Snhr+tRB7eI619UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315904; c=relaxed/simple;
	bh=absJ8vXkzInO+P03amyf9XhQPYsHlNKE+Ful5A+oq7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvCAGKRsZyy9eMEqfsDO+37HChBTtoYioj6/8xrtQQ/AQ+KtdAjVZuA6nC3dGa1JaSoD6RCdaSKMXLgCkdORit0wUVd+3+WzTu6TPxPDEIiypw5zGQneqwq+Y+HL3pzChZ7nUVGGo0VHqPLFhSQMUFlvXLwlg/zkS2rjzqKHw/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiL8wp1D; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiL8wp1D"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c214e625259so133306666b.2
        for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2026 05:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787315898; x=1787920698; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7iWoE1gDDIATF5ySIERyCH/5907Cn2cS9EwNd22zLmg=;
        b=UiL8wp1DsMLl/m1CIey+FDCsGWWjo0WSTfzH7LMVwjkvHb3LOpzDGt6bPlC/i/18aB
         7vTtt5XKOimpl9IMfH7c1A7pCU16n5zwky3qF43kzQ0fO7xjqu+oIt1fe0j2rJlByPPC
         vz/7zPHF7uscx2hkg5WtNmhB8SlcqAmH38uGYlJYFbrTjcWflgMifE/RndsgZewP61T5
         BX+p9NEEQoYi2BE095uOgBtHptF+I5wtRRuIdRqv3E6X7BFzKVZmUe2CclGwwrV5GeyD
         YXcuE/J0exUpKlqaaS7N5LIjFLAKP5kpgWqiGR1+O/OjMQ+hog4bfpu9Jj/37VL3MR85
         gl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787315898; x=1787920698;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7iWoE1gDDIATF5ySIERyCH/5907Cn2cS9EwNd22zLmg=;
        b=PpXr4KST5pGq/Khy4PCUZfITO2hm1jqjBSjzmRcSIk9nKHqYCqq7XB0FyxlcrbCJwR
         hYq40gldLKVvoaOSrx31fPFxdRKDfzSUv3bY2P4wIE0rJ8eMGPeAajPhh676saXzuOoP
         5scopoywfrAnPMaofulC7ZXVsUEbUE1wVJ96vDYdLjnHNxU2eLyge9KLWdSPIonDw6uD
         3tBjYRoaHkfwV6MYtAwSoyIK48W56H9c0zhTwQ/IrazTP1wLGzjhfq2WBN/moNRRd7kj
         0uLOly2EkGsfU2QyvGBZGQKdZe8Qo4oGNoeZ1Yxp8bBEv6FFPLlwsDn84fsJUBoUBa5F
         KHYg==
X-Forwarded-Encrypted: i=1; AHgh+Rry0QBMtgBiaa0y+g9ySDhWkvHK6vg+UFzQmRs9AoJ6kDIYVsuTOHNhg90IVL+ixjNUqn+ouqsvKpjDlg3xHLZnt7R63Rw=@vger.kernel.org
X-Gm-Message-State: AFuF++mld1ha4ViOUJtU9jJzX7kEmLzfXjXTLp75ogb06ApYRX8UjsES
	GkvdN3SOo3i9Aa5ZFemp5KBjEZtAO51qMeSzBlv6pwKqtst6u07W05cM
X-Gm-Gg: AR+sD11sbkwzqrAVeM98G20hKo7n8UgGjf4zQWompUMYvYbz1nMe5uNooXOxv9127fT
	TB6Z59cLA6U0Ju0VriD4uKexIfgTIRCzUYMQYd+F7YaBZtGS0YnX7Z4uI9B6BNETU0nsXAONb56
	d4qlsktMpDeOxOzbSZCRfj8RndmNbuMNpAnFenYIayeQYmFgmLAKmT/19FVhOq0a4wZ9AIbhrkP
	c4WrPIxx0Iqb0EakXvtXUrqQ9ylCNwDphlM+/OC+Qkw4GvoFFmI4hRUFDv8cXhibssxxdlNXR4S
	a/2D/x/wJIfb8/m3OaMg9ixIZO19WV3Go3zqrt/cA3raJnvstMfewp6KMjz7MGXryt9XJQ113zR
	yvak4xFTAyNEKi5jg+k3p38HQtRKlBHfJD29KQZwQEje3GKwrXFNcCupd1QdpBcIR3mlU7nzF5X
	ZOcqpuWK7+57sMe9G4H7RqsqQquOQZl3nSWAzxbbPpME7wOLHmFGw7+3MC7GQ56PPoSmrPY6odf
	89LzW1UZIFQyA==
X-Received: by 2002:a17:907:6d15:b0:c24:4128:c19d with SMTP id a640c23a62f3a-c246a2e9378mr584285566b.4.1787315897766;
        Fri, 21 Aug 2026 05:38:17 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2459197cd4sm480087166b.30.2026.08.21.05.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 05:38:17 -0700 (PDT)
Date: Fri, 21 Aug 2026 14:38:15 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: mic@digikod.net, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 3/6] landlock: Bump ABI for
 LANDLOCK_SCOPE_SYSV_MSG_QUEUE
Message-ID: <20260821.ad614a879e61@gnoack.org>
References: <20260727230833.138165-1-utilityemal77@gmail.com>
 <20260727230833.138165-4-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727230833.138165-4-utilityemal77@gmail.com>

On Mon, Jul 27, 2026 at 07:08:30PM -0400, Justin Suess wrote:
> Bump the ABI version for Landlock SysV message queue scoping.
> 
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>

The ABI bump is normally put into the same commit as the
implementation for easier backporting. Otherwise, looks good.

–Günther
