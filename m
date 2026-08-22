Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC6030567B
	for <linux-security-module@vger.kernel.org>; Sat, 22 Aug 2026 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787415368; cv=none; b=tB3+w3S6YtPUFwEyRGUPfPNIvRQXKWeB7czg+4EYquxbyOypZhFYqQIQfUoliS9kTch9Sq2kmgGCLjcFKHEBNwhTJolwBjQx3yalb2dtZ+i05Ig6qAj6E7pXAhdI86ecISFMvDFZ2P2S3NQstzxAj+dZUmZmIz5yptp4oIVYr0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787415368; c=relaxed/simple;
	bh=UqGaZm/V7cH41JJd9nv5JmpcXOlvPTkpelgw/cPAGkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBUZP8nzE4S/jG3aZAXDOTQbtDmrWbZrdlMGN66gdghq7GwUCW+wcYRyjlt3PXI/rEtCroumcCrX3i7WwuDGlQtyatR2sbbd34/JKB4IezchbWodWIqpqeT01eNO32bkoLRVUCU+k3dxayD7hLDIkTrkQvXhwD1YxxQSimCw1LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NnSkYEVa; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NnSkYEVa"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so3912974a12.2
        for <linux-security-module@vger.kernel.org>; Sat, 22 Aug 2026 09:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1787415363; x=1788020163; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/89GxTglSvvSWscOr8ylJl/rKYgKzvebpeOORGPECTY=;
        b=NnSkYEVaswrMu8h/dv8qhBrXXQohobWtgOOYy7JcH3+oKmfgtYCcPIogAStYk5jir1
         VzyeZL6de+iXb+0rla9Jj6zIJbnIltxd+ZuKByNoGt93HneVhK7Vnrizo/yRXJFtO3PG
         BfDHRzyOtOa/Wr8bs6iEQw1JrBXgCDIplV5mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787415363; x=1788020163;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/89GxTglSvvSWscOr8ylJl/rKYgKzvebpeOORGPECTY=;
        b=Uc/AhuDOX6cFq8A2TUsRlPtN0FWmKcvjRuBOmAEfelkR8BUgHfrKzg7wF15AhfTTSG
         Ks/6UTOfBtCOq3U1lA/jKFj+CPDwA6OUGMYWJ3TCTkuva7xgW9VF0Xmr+d3vn9FTODBy
         heL2gfY7N/990fQG+VhQmE1wVKG+8N8nLd6o3ZdW1lUXP4/tS7EeSeiS+1S2+G06EB1p
         a0iX1WH8tu4ucWeXPTdBWdH/zeXss4aZakRtzWC3oZ08P8woh30WR6A05egthXQcpi/Q
         v5ccbjIYl4hSOJ5jtuDDdYJ4HFUb+Lfnbm+JxuqV0A50xg723Lx+Ov7hhsC9lhottJDu
         tlfg==
X-Gm-Message-State: AFuF++kwcYtLEMfklmWDwP0sqpByxmPb+wuhFQdmk885J+YJGJocmcIs
	0kyv33fGye5hvfXhx4gry8ifYosq/OJup3GzslHOQkZ1bFZm+jikh38jjq/4v5c1phQynaofbaB
	vPeingMQ=
X-Gm-Gg: AR+sD10Vxa9J+vDBoITn6FOCQah72ew9NRg6lU+PPgDTqT14JJVL2wv0pm0LF5IYbCm
	9oQvfLZpXSqV5IzD14pshltwn/BW91mBn9HBuF0O6xRLbJ4Q+ABhdAiGhxTyr3pn+uzGmRwmckT
	riPsY4iTpD+DohM53GhjjpxCP/3FgwoTBmjD0jzYmG9+1BmdFn1M6wvBZ9EJ21LD5mPmv1AJPgZ
	Ddjb3TFE1fQXMlrJkMkoL74T1xSg3iK4wVaEj+EBuiyYsHpwA0qBK2m0FN5dTR6IiK+yVTlCyjT
	aFXg1XvSE4Xm5X71Y1ukW1QDR//nQpsKs3qxLG4+9PqRfNe0qSpSNzBCCkO5Na0gJ1J3ih5DyyG
	Wjxbq+dmagKzDVbFOSf4aBSkDF9h1TBjL8ThccuDOQrBBTMRffwnQfBP9ZtJ6SG2OvtHKHlnnLg
	I15IJRQBV5bWWjFwLYum2jwvvZ+jXOal7G6UMboW5ntgPjMZcUSfkDVjmdN8/zKBZo3DZSGzYVJ
	Dq+MDL+/UJqCbNcJLGgU6nUQJ1B9m/VrQ0YnReazSEkMsO5mA==
X-Received: by 2002:a05:6402:21db:b0:6a4:cc9:c8f0 with SMTP id 4fb4d7f45d1cf-6a582b052b3mr7601370a12.1.1787415363492;
        Sat, 22 Aug 2026 09:16:03 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9e2esm12737649a12.5.2026.08.22.09.16.02
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 09:16:03 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a173ad7cf4so3899183a12.3
        for <linux-security-module@vger.kernel.org>; Sat, 22 Aug 2026 09:16:02 -0700 (PDT)
X-Received: by 2002:a05:6402:548b:b0:697:f6b2:a94e with SMTP id
 4fb4d7f45d1cf-6a582b9b9d0mr7482513a12.13.1787415362828; Sat, 22 Aug 2026
 09:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aom3Gwl3GkBpw4fr@mail.hallyn.com>
In-Reply-To: <aom3Gwl3GkBpw4fr@mail.hallyn.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 22 Aug 2026 09:15:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4uW6cmMEu4Gp0cFzu=TRTBAEf+5BdKfPkX6kyPSG63w@mail.gmail.com>
X-Gm-Features: AcwNN1VB-xbKD-qGN4AfPZvBNe3EX20_ywUsq9cYA0nWBS0NL1KX5i7IKhR804o
Message-ID: <CAHk-=wi4uW6cmMEu4Gp0cFzu=TRTBAEf+5BdKfPkX6kyPSG63w@mail.gmail.com>
Subject: Re: [GIT PULL] capabilities update for v7.3
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Aug 2026 at 07:50, Serge E. Hallyn <serge@hallyn.com> wrote:
>
> It's available at
>
> git@git.kernel.org/pub/scm/linux/kernel/git/sergeh/linux.git #caps-20260820
>
> on top of commit 1590cf0329716306e948a8fc29f1d3ee87d3989f (tag: v7.2-rc4)

Your tag message is garbage - that's neither valid syntax nor the name
of the tag nor even a valid git.kernel.org pointer.

The *regular* 'git pull-request' part was correct, but you should
probably fix whatever script you use to create that tag message.
Probably just removing that whole bogus "it's available at ..." part.

                 Linus
