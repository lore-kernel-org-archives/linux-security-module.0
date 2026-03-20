Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9911728FFFB
	for <linux-security-module@vger.kernel.org>; Fri, 20 Mar 2026 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009696; cv=none; b=myIJr2+8nID0Um9sr54EAOYdcqeScCj2YkcqkBQ5HDT5pAERZkV7eeSriWza8QlU8Y3RJjJOC1+MJRqXg/Zh86j7n87eQeAQ2p++sqftJyJFN09/KEn0LT5FA3eHrvFcsrrxeHYsuQ4ZcWj3y6tmfOwwi/UC4m1GL4yfl+rbJPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009696; c=relaxed/simple;
	bh=WGPhIgP3bxlQmw7G9caGH1dS23/rd2JDwWAXSIFvOnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4kp9vnQBJ7H85JIfnNPVY3zOZ/8Ug3zEWyeEXjYAB+3DjfeC41Rn+bpWqdLn7DZjzVwzZN9Dkk4AAogOPo5BgxSqEnY021Dan9OIiwXDS7WL4tG61kIjzJeDfZrosLvpLnfEqM/IVv4IElVV1ILHWjg22LdJRO/1mAsytpHoxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcmXTS+S; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcmXTS+S"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fd5360d4so15179595e9.1
        for <linux-security-module@vger.kernel.org>; Fri, 20 Mar 2026 05:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774009694; x=1774614494; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zjWX/kPhPRlRLLqOSVNiOv5rgOLZkTVsCLsIHKKSN0Y=;
        b=CcmXTS+SJiuGI4fYHPQZqijR204LyLCirkQvr39snkpB1aVnPuBMoIq6z+JkpanNbW
         Wl1qg5dh2io36KwB9W0Z1h7qH2nVnQjtIHDTHkGEi6+v6MQCumOgdbg0hEbFANHclBlz
         L/XFiDmLjkx+PrySfMkTpU4najt1UD2jM/JZ9CWweRkzjlOeM/h4pN6Y9xY4ANp7XoV9
         K0REKN0SdL5LM5qAki/osHEBAc9eRnYE6Jin2vAVAqgFfejgu2bbK4NzV5LIOeYCa1ut
         iIM0JZz+V1617YGqZeSzAjBY6wteZCKmG0W4+9uiMp5haIebkuKhXFyfdHXjg8b3MLaV
         a2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774009694; x=1774614494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjWX/kPhPRlRLLqOSVNiOv5rgOLZkTVsCLsIHKKSN0Y=;
        b=jT1fQuEOnhfQIUjwFBrett6n8M3l4QmzNnQcuv1bU5wwbZi47j0On/YLz7yzLtgvio
         LnVfJenFy5Upxc7BsRuku7E9OAB4Qk3NiLqz/hu9mah+hg6xmY1ap0OOockI50Et40Tl
         ltTyNBcB4KC7qtsgEcT4G+zb+AGyogckTY5oZnulLtt039d2sbUvnKnuOdasafqbNSlp
         MJqgcUETFKbJX8T9x11rp0XZV6uZiy1ztjJ5nCuVU3CNDk443KZ40SuLnKLmy0kg9xBU
         YRszjEE9b3Nut+daW+Tvd6Zkf95M3CEdIn9KBfmActmSg/AmjFTbx00ynKYY577msRvR
         YeXw==
X-Forwarded-Encrypted: i=1; AJvYcCUYr152t33YZWhCXaJIW3M1Cd+mG39/vgH4DG2mF+WRhm48aemcX8iCg0hlMfX9vAsXFMC9LGfYHgdGNNC7YV/5JH4Y2aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymAXnhvyHX3syLUxMIXsHkIm70Ea/0352QFW+U1nv5yBoo1a4X
	cb1u0aWGYc16E2egDutH1XbDtPdqwiEdsWXUquH1ymyCsupF5hvhl+l3
X-Gm-Gg: ATEYQzz30qSYYq6vqpOTJkzqhR9yRY3lbWdpZiiBiLLlVz307gmS2YrCWzO5UXYzDvK
	7J89P2xaUfbncj2EKaSmtDkiP2ynmBNudv4c0F/l6A/tx9LvfwWWZ/Ob1HDLpM0wLskWQFS+9cN
	eLVz1aigQIqXhtEh20eLmDwvGJ08TULbAp1w94UEZq7Cv8DEAHPwM4DEQQADdhu5fvmmy3A1bTE
	uaDqun1UlRNAr945pwZhF/B8gRZBMzSLzTa7V8oGzEjPWWolY595+hknMr2wBedLGrWvxdE+S5+
	YqibhENYBxYMz5o8LFcIvw59xmYYc1FOOOlbn6g2SbpdRV3joe1rCI+8w1JnqHjjqa3AqSPYerR
	w4aTA/V8BOpru7GQ00Voq6kIRR/H3yHVPMzDG9p5bsFk/ZNxcIgCzPAMj/QkjeBIAhUDVTmWBzG
	+WlW+EyIg+gwYnNuc6ofPafxxM07l9oYz39vExD5OJCc0BQq3dj+k97jY82RI=
X-Received: by 2002:a05:600c:8b0a:b0:47e:e57d:404 with SMTP id 5b1f17b1804b1-486fee0f917mr44101615e9.16.1774009693646;
        Fri, 20 Mar 2026 05:28:13 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe7e3a94sm67595655e9.7.2026.03.20.05.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 05:28:13 -0700 (PDT)
Date: Fri, 20 Mar 2026 13:28:08 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Justin Suess <utilityemal77@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Johansen <john.johansen@canonical.com>,
	Tingmao Wang <m@maowtm.org>, Kuniyuki Iwashima <kuniyu@google.com>,
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v6 3/9] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <20260320.a44048ae9c83@gnoack.org>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-4-gnoack3000@gmail.com>
 <20260318111507.1nr6rAki@linutronix.de>
 <abqzXO3MmMXKqXOy@suesslenovo>
 <20260318150559.j04YNDtV@linutronix.de>
 <20260318.Jeph6loh9uSa@digikod.net>
 <abrWSwS5urQpvbPb@suesslenovo>
 <20260318.aequoaDaeb7h@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260318.aequoaDaeb7h@digikod.net>

On Wed, Mar 18, 2026 at 06:52:57PM +0100, Mickaël Salaün wrote:
> On Wed, Mar 18, 2026 at 12:43:55PM -0400, Justin Suess wrote:
> > On Wed, Mar 18, 2026 at 05:26:20PM +0100, Mickaël Salaün wrote:
> > > On Wed, Mar 18, 2026 at 04:05:59PM +0100, Sebastian Andrzej Siewior wrote:
> > > > On 2026-03-18 10:14:52 [-0400], Justin Suess wrote:
> > > > > Sebastian,
> > > > Justin,
> > > > 
> > > > > In short: dom_other is a pointer to a landlock-owned refcounted struct.
> > > > …
> > > > > 
> > > > > But we copy the domain pointer, which points to a landlock allocated
> > > > > and controlled object.
> > > > 
> > > > and this is not going away while we are here and preempted after
> > > > dropping the lock? (if the landlock policy is updated/ changed/ …)
> > > 
> > > I agree with Sebastian, this is a bug, see my original proposal:
> > > https://lore.kernel.org/all/20260217.lievaS8eeng8@digikod.net/
> > Mickaël,
> > 
> > Just to make sure we're speaking of the same thing (I spotted a bug
> > shortly after replying to Sebastian).
> > 
> > This is a potential UAF if the dom_other is freed before the access
> > check takes place correct?
> 
> Yes
> 
> > 
> > 	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
> > 	unix_state_unlock(other);
> > 
> > 	unmask_scoped_access(subject->domain, dom_other, &layer_masks,
> > 			     fs_resolve_unix.fs);
> > 
> > If the dom_other->usage reaches zero, then the domain could be
> > freed after the unix_state_unlock while we're checking access??
> > 
> > (I guess I assumed the sock_hold on the @other would prevent the task
> > @other belongs to from being freed.)
> > 
> > Would it be better to move the access check under the unix_state_lock or
> > to acquire another reference to the ruleset (or something else)?
> 
> Because the unmask_scoped_access() only read a bounded array, it's
> simpler to unlock just after.
> 
> The other alternatives would be to use an RCU lock or a new reference
> but I don't think it's worth it.

Thank you, Sebastian, Mickaël and Justin for spotting this!

I agree, holding the existing lock across the unmask_scoped_access()
call seems like the simplest solution.  This function only walks a
previously loaded bounded memory structure, so it does not seem worth
switching to a different lock for that.

I'm changing my WIP for V7 to hold the unix_state_lock across that
function call.

–Günther
