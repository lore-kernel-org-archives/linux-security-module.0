Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43763BA25B
	for <linux-security-module@vger.kernel.org>; Fri, 20 Mar 2026 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025060; cv=none; b=akvYLZGSYRpJshY22penKAcLfau/p8DH38BDdTdS7RtSgdyJXrffgimDd6+zBgtLplmuvZ2FYJ5BpkScRZ58CjNFzI+8G3+mrSBh5wYPsi5MSHb3f0oFane/MiWx4jdSmlhP8YFm42KGr4B/zIW7Pr9VWNdDgOhTDYxKUZnWJVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025060; c=relaxed/simple;
	bh=pWskkL/fE9d43b477lX0QDWs2YO8fMWnJvwXHumbnLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NbyrbRHwvFNc5hggA0aejWG+esBOQO3+t78HlRpUTNWCLDSyWcLWomtUCaemHhpbIkY9dDuRfZacvc0zuAZ2Xf3saa9AsIJZ+xcXQIVf6BDyjtvdl9NCu9fws7GKLwKjkP2/ufUARQ2TiARdfKBQorZbLW452YGsnIulSV5jCw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evPHBVqG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evPHBVqG"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so17367595e9.0
        for <linux-security-module@vger.kernel.org>; Fri, 20 Mar 2026 09:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774025058; x=1774629858; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dOa511L1/5uD/Vm91vXvETdeU/wtNkJKI6NFapT9TdA=;
        b=evPHBVqGXSJ1gt/Q1owzXEru2pmWj11gqncAfHjeBJQyXPg+Jw4Iyo15GGgrzXu85E
         laRH5E7ohsMWe4CZpdLrIrClRrUZB6FIiNTUqffVyOpuFoJX2viAeb9lVXf3Q/eZeM72
         0AQzFjf8lgd6uHhYhLqZ9jPOczQQaEfwVE2VfjOacbJh/KHuNDrMS+8OUMDJ8PWPZ9zQ
         yeREXEFqQvr7D9GMzCcBMiChvJpmVBWQ6m1slTRRn849Ttw7f3SGFUklw/awomdtc+RW
         jeXjnVwb60u3F7OQY+37Vxom5YvXXonhg3H3eePeGdiyA857wcrYtKk7Elzgsl18jwBw
         UTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025058; x=1774629858;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOa511L1/5uD/Vm91vXvETdeU/wtNkJKI6NFapT9TdA=;
        b=jZMCBDKxqE0qn1Eteo+7PLUHXjhhaJONwnjWbiD2gIKF+ybso6pvbnHZqsL36xWHqU
         zX40FoPwO53645VlWdLxWINk7jtMuWp9TH6Edf8N+RNncT7y6/2rNRbMeovb4yzI2eBk
         3C7AoR+8htlszBVOJ8dQaU/dXTnJ41N/Di8nEdi77VIRW1L12P32g+DpDKV6VF3MVyZC
         n+6AD35dSl54bImBLLekVpjO1/zjmYndmjFp/xGUMW0HctbLf5MdGKczsSf7yvHReKPT
         XX8B31vr0fytVAE5T16+UWYFp3dp7zggNiX3W0N50pprwrWDHbsgHxsgaJDvDGGl9ZnS
         xw6A==
X-Forwarded-Encrypted: i=1; AJvYcCWXxcxZG/Wkuc7p09Zqgxs93/VupLtnX0IAEP+LexHNVYJ0niAxbxRsTNy/SVZkRE7k7XEQEMTpotyaBOGRaq2N5lm5Chc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXQdToLNuu17mjl0oYo+fQtle4JsaNSdlq4OBYzbVd5XqYj6x0
	Abl6zl0y2lukjNpJHc9P6V9rmbCK9dRex4YOC0C8CqQbegbxYBdgSAWwtKTICUZ1
X-Gm-Gg: ATEYQzxNyynHuXTjmT7YnXPFE3C2T8FnhNabTWmWKDCBrAR2Zs9HZ/jLBhUWJEH2lis
	Gij4v/Lq6Mr8/TrDdDMwa25o+IaDFbiGywTgcwa+MS0lAzed6LTi91LK6HZgNy4dPJ1Cyd53Ew3
	yCEC3ZBPS/bd4H4422AmtOr15leUVm5XES+JAJNU5Bp9gmUZyoJqUUpWm/6YuGq3jiSlaXjwzhj
	AsJbMna2JiP3cItqOVeOYFEo8No3ZZf6Ji8uGpDGzREoB7UJ674Utpcsx5W5OqFBSAy9u7Wr4W2
	63V7Df9YTg9q1xZyn/lO/rL8jkvgOPBzpzV/GyZ9j56iRLRsuoE4rjbiKeti3DUujfKVlbf8MiJ
	utccGqY2Fgw94rNOHVljl8Ax4WITMq9se9L6Tp8TwqiZQMUIMaeNNBMib/wSQI7wIpiP6rmnSCm
	lnPcuRZ7Ek9vz97Omyr6zQNc1QukcHPtB/rl5sHSp/Kxrgi4PA
X-Received: by 2002:a05:600c:524e:b0:486:f634:ef3 with SMTP id 5b1f17b1804b1-486ff01efcdmr55259285e9.32.1774025057783;
        Fri, 20 Mar 2026 09:44:17 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470c239sm7318088f8f.27.2026.03.20.09.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 09:44:17 -0700 (PDT)
Date: Fri, 20 Mar 2026 17:44:12 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: John Johansen <john.johansen@canonical.com>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH v6 7/9] landlock/selftests: Check that coredump sockets
 stay unrestricted
Message-ID: <20260320.3670155d65e0@gnoack.org>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-8-gnoack3000@gmail.com>
 <20260318.bahDieJohf1u@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318.bahDieJohf1u@digikod.net>

On Wed, Mar 18, 2026 at 05:53:59PM +0100, Mickaël Salaün wrote:
> On Sun, Mar 15, 2026 at 11:21:48PM +0100, Günther Noack wrote:
> > Even when a process is restricted with the new
> > LANDLOCK_ACCESS_FS_RESOLVE_SOCKET right, the kernel can continue
> 
> LANDLOCK_ACCESS_FS_RESOLVE_UNIX (twice)

Thanks, well spotted! Fixed.

–Günther
