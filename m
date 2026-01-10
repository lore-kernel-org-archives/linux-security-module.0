Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42E2FE05D
	for <linux-security-module@vger.kernel.org>; Sat, 10 Jan 2026 15:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768057530; cv=none; b=A5wkyn+ZYdcwKzrDpnzFhwdSWV/qvfauLY1vMexoejEqIDAC6vsWhi4H/PpJLPE3N8PzBbh8h5AuyMcE0zT+y78gIN+mmEpE8LHvrkflGRpF8v3blJH8deLJbQqp/SyveBeosFgpYilsjcXshzSSUFzMplUELOaeaZZ8MEkfXoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768057530; c=relaxed/simple;
	bh=Hp2Sw05QujvNObWLAbVuxSX75H4NGV5Lpk+w9Y1zafE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOWaIcZiG+4peXCvRSwrfrFKtrFG67JrwZia6O51c8UR7iXjt6ucHUCWL0yEtmHqcUFB31tG0l88pN6BedBPi7PHRj3KDPwymoXRDgP5J7LiF/7OF1yjvTSeLspXw53u8TMJy/ZOk30e8eT/eu6vWBbG0Fesw0D1QZluVG6mBR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJewIbzM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJewIbzM"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64fabaf9133so9155098a12.3
        for <linux-security-module@vger.kernel.org>; Sat, 10 Jan 2026 07:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768057528; x=1768662328; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TEj+FEB4LerLZrvdgF3k/4SW0VFtrOKqYnchQN+SDTA=;
        b=TJewIbzM/HhWLM5ZPXd9QM9dLhl9fGoZuNXsXauL/KwgvkREggoRZvghQ38SSoep6A
         z/E0+VaQK0r/9ll73lJttN5Xg9T8YhpSlzB0a5OKF+shRITQG0T+vOD2wlfdvCZdQpG/
         V2itiKbWh8JbmhaDAXUze442F1pJxLiIZJl9uZm55UW5KLm1MMnK94aTJIHMmqsB/MRR
         aAYhdWXSQHI8XyQbZgyXwGQANCdYE1MWavbNcZ+b6fq0hxTJUPEGHyfH9tSUsd4MTkK9
         1WYIwC5p7hHrvTaaeYKWFAcHUN31V6geKNMRYg/b/I0Md6BrM5QbD+wR6eVOzYXCT8ib
         agFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768057528; x=1768662328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TEj+FEB4LerLZrvdgF3k/4SW0VFtrOKqYnchQN+SDTA=;
        b=Ub06heyCtIEvH9wPseNMr4QW8FiYqxqrh+W4QQw+nc0n5onHl+GJpE3DpjrkPE51M9
         j43YqoOJyhhYTZgAJswBG+y/2bzkIbDJDiC6HASFGOJPJuECMBof3zbnvo547TZILPrb
         oE7+UY8HJrPRRJkbCMdkj1zr6LMgb7hhPev90cpH9ctUmzj6CsyF0XNVfESzTEePz9Q8
         Kqsi7yqaA/a8TOJeqxJWSFlCaYYxbYKUuHfoz0WadcirW/hD5r4b8EhaCCSd/k3sLooT
         t8QBDKqlfdcLSnC7jR2nbMmemS65ffRn4yTwrPEfwsEy4KIw9/0iIv3HhAyKk+e4BoML
         WJdw==
X-Forwarded-Encrypted: i=1; AJvYcCUhWyYtFHRJwv5fUE0UiOvCNuJiPNlU1JogcTGkGYMx5U7+5oI1/BaIzEYW8BmrdHRnlQXw57fCDMIfrXHaGAaBeq0R5UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0Lj+uvmpUcOscd3ybf92DiVzbefdzzCCNiWuC7un3GDb+oCN
	AzBt4GtAlCWBbi7XSJ7h2dqquRawRZLYByyx0pBwr3OeGlh1gxBpvQop
X-Gm-Gg: AY/fxX7Xckv6Dkb3RCDF/DFqn/CJQgmaRkKU72ciNx8pUBtJafEBw/4eLkSvtFafx92
	DGOlS/7N0qtID8O/NQsYV/+wuDqDBX2KynKRPIrTdB1tiFAi83QPSYHetLTtgm0KsjKLrNMgPbf
	stUjUTH9isB9J4doZOZxlhPpEul4fKE1dD0ei86VVAZxi+iD93/GGxkXCeoLqstLWXxG3w6pjZZ
	LD3EawC1+WaxwDgLqjeoeeslMW5Y7d6ozmleImAVVjw6pTVyGBpzEpWjCFVho7HnLy6mjI6alpG
	u4AOuJfP/m/7X+5JGgt/KwIZW0qf2V89WVYtcFWKBKZRW6/e2Y/pndrxuVSRpU4YAPrSQTDtYaj
	806Jkx38r3sd16TNzR5JddZfJFlZPrXMuy36dCx+8HWfvuKWd/KI2Ul7XjErBOQ9Nbt/QtNNlVQ
	cFxGdEREkGbg9Rc3U78oj+LXjWZAIj/BzoPtvn
X-Google-Smtp-Source: AGHT+IE7khajRLDhQvRfl6gn+7heUftuzRCUyt9QE+geukvYbalacY1Qf33fgdae2besSpr8LQwTXw==
X-Received: by 2002:a17:907:72cd:b0:b83:f09f:4e56 with SMTP id a640c23a62f3a-b844516d7admr1334695766b.63.1768057527518;
        Sat, 10 Jan 2026 07:05:27 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86ebfd007fsm236320366b.31.2026.01.10.07.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 07:05:27 -0800 (PST)
Date: Sat, 10 Jan 2026 16:05:18 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: demiobenour@gmail.com, fahimitahera@gmail.com, hi@alyssa.is,
	ivanov.mikhail1@huawei-partners.com, jannh@google.com,
	konstantin.meskhidze@huawei.com,
	linux-security-module@vger.kernel.org, m@maowtm.org,
	matthieu@buffet.re, mic@digikod.net, paul@paul-moore.com,
	samasth.norway.ananda@oracle.com
Subject: Re: [RFC PATCH 3/5] samples/landlock: Add support for
 LANDLOCK_ACCESS_FS_CONNECT_UNIX
Message-ID: <20260110.853ac55cf90b@gnoack.org>
References: <20260101134102.25938-4-gnoack3000@gmail.com>
 <20260101193009.4005972-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260101193009.4005972-1-utilityemal77@gmail.com>

Hello!

On Thu, Jan 01, 2026 at 02:30:06PM -0500, Justin Suess wrote:
> Allow users to separately specify unix socket rights,
> document the variable, and make the right optional.
> 
> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> Cc: Günther Noack <gnoack3000@gmail.com>

FYI, I ended up not applying this on V2.

I am unconvinced whether further separating the groups of access
rights is a good idea for the sandboxer.  This is just sample code to
be used as reference, so it is good to keep it simple.  I feel that
giving it more granular control over access rights does not help
readers to understand it much further?

It is true though that it would make sense to have this feature in
more production-grade tools. 👍

–Günther
