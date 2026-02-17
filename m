Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ABA36EAAE
	for <linux-security-module@vger.kernel.org>; Tue, 17 Feb 2026 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771346141; cv=none; b=iagXR2QbwaAfJf2zh7IjfJbowyOccBcr1P8ua6nKfpf5Pv7B5SVed17ELqhkNbp6RQK7TjypZRZVmyiDBDS5iJ1b/u71MPg5r+3mWqm4KlQKn+WWxtsD3PdZGq2Pbo8h23f8rIftdhrqKKbxp/3MTVcNLwkTA05w8gt5aNneg24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771346141; c=relaxed/simple;
	bh=v5RdTRwAlMvDnw2mSvvzlyobMMhvsDSGCpnqcjOhXck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEJswU19HsgUVb6l6EYRAxpfKAQNyaxe3XJAngZh6VFSludQJOfc35rPYmApgSJKxxDy+jOucABZ+x/J958eeT2xqv0zH4C5elJV9WaFANHQwtsAxZTdtm6d9GWjI0Jai5qz9xsRCqDwHyiDg3GC0ETLVSZWFT98PxVkvG85ul4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rak7XTDu; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rak7XTDu"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59e6491f1a2so6014e87.0
        for <linux-security-module@vger.kernel.org>; Tue, 17 Feb 2026 08:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771346138; x=1771950938; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yYgWYhiD0n2mEyfYNVfYa0kPXvg9Tft0kDTAVckiQpI=;
        b=rak7XTDuIfOiUWvvSJ0xBo44n0FI5cGT910SJHi+17bvygQxbiFOb79kvIx+pE+bYp
         hYA0QG+6i2nEfs0pYXnOb87dq/ydxEj/APlR7vb2v5Q2COpeGTX4iZXHQ7IZd55L7SzX
         z2qd784G7x2nIxQIJXZ/F42wpmXcfSeJ5L/2LwRo/qLXYV1JZvxH8Mlyv7R7QTPHvqNw
         N4qUaWmZEmkttsGpyqe5slUw4u4G09Uw1xjh8rnlGrq0i/RBWU6oRaf11o51Ij+new/O
         mlUrs/ltzoDUn9+FskPR9fOjUovJilXh959gOyM2pSRShUTQeSkv0rxPZTDwPpW6xOwY
         N1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771346138; x=1771950938;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYgWYhiD0n2mEyfYNVfYa0kPXvg9Tft0kDTAVckiQpI=;
        b=UHH0QLq3d0eiCwgQeY0mm7WjVdOWVw/V9ReKWxJXccPTf11g7RrENa2+V5KoLF/UZp
         Hpzkf0P2Sj/ysJ4auwAHcRh6pWTqRn4Lil+Xi/6pmNTS8LS7Wkyea8bHH4vUWMt4YbEd
         GizpOCip1YB7TOJywyqANSpIbx6rqhTDFnlG/NR1zTAr3u5gOvn3KkUR/1/qEwU0RDJq
         MtrrzdQ+fFdRj/49IMhB+um3NKEzpu0qUJYT9jI1/3RTMjN2G28ZsvkuBuN21vDZbk63
         ieoNq46jaVn+wBdqmUR9do3Pdtkyz2TADfBoKXwnUxmB0DYWHjXOEnvURleYB4af9SVl
         zdLQ==
X-Gm-Message-State: AOJu0Yy2bpG16yKsvFR0209pUNijUdPDmnF8aHbL8bDj+iWaHOy5f5tb
	zw8RoD/VvCmamBzf4YMejJNKp+8cWFbCK4tRzE95bv7eT7BeBnBJ1GkDsyQR8+Tovj+JL7Y4QWH
	w4PzzfQ==
X-Gm-Gg: AZuq6aLTAOZdNnVvQ/YbqBoGAVSOdjf1D1SpP86O1MOcSK1BYN1REAdxnvmcEEUTadm
	VMtOG5aqBhMvoHpOSIwSxbrqPvAPAt/0Gxff8gS2BBYPeMtjLwbef/xl9WKaejJaB0vg7Te5map
	suf9+Xh2xiXOBfnOL6yj1sD6SDH2vcznPZc3zYfkE7f37WNCVQ45mN5v9fSG5LAwEYMs7BuLdyJ
	XCKc4eCVzmLUWZ17IwspLa63qaulq/t9U6+47mmvpWlv/3yfZklcWKAQpWw/fB8yLXZQo+AvQ2O
	1Z/ZVUXa59vUQk2UlIOV7yYMM/VLoYRdYNWQGmH28pcgJsZzl87d+N8F+qCV2BcPQ9Fcs+XlAZn
	xOn9UEG8miJJzWs/faDxm2hyWq6SR2ZUSkPqRjNros8IUT9Xb1KkoaFrj+DfExFlX2z/tqjvClF
	ewYKF3M4W01WG3yTN7dHCEEal9y3M/crf+P70Xa6dKyAmfn/maoRIJ1w==
X-Received: by 2002:ac2:5684:0:b0:59f:7b5f:6b49 with SMTP id 2adb3069b0e04-59f7b5f6c99mr1890888e87.17.1771346137708;
        Tue, 17 Feb 2026 08:35:37 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:8d29:f905:4a47:1dbf])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5636b3sm3853181e87.14.2026.02.17.08.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 08:35:36 -0800 (PST)
Date: Tue, 17 Feb 2026 17:35:31 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 1/2] landlock: Fully release unused TSYNC work entries
Message-ID: <aZSY06XckK9HvYlS@google.com>
References: <20260217122341.2359582-1-mic@digikod.net>
 <aZRh52TIPAmMPJxc@google.com>
 <20260217.cheoghae8Ahh@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260217.cheoghae8Ahh@digikod.net>

On Tue, Feb 17, 2026 at 02:52:46PM +0100, Mickaël Salaün wrote:
> On Tue, Feb 17, 2026 at 01:41:11PM +0100, Günther Noack wrote:
> > On Tue, Feb 17, 2026 at 01:23:39PM +0100, Mickaël Salaün wrote:
> > > +	memset(ctx, 0, sizeof(*ctx));
> > 
> > Minor (and highly optional) remark, this is the same as
> > 
> >   *ctx = (struct tsync_work){};
> 
> What about:
> 
> *ctx = (typeof(*ctx)){};

I find that harder to read, because it is less commonly seen and the typeof() is
an indirection that makes me think as a reader.  But at this point, this is only
a vague opinion and I don't feel strongly about it.  Please submit either one of
these three options :)

—Günther
