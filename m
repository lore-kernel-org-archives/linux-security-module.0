Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B963B8BC5
	for <linux-security-module@vger.kernel.org>; Wed, 27 May 2026 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925358; cv=none; b=ury/U3Ph8I8tt8gIdtTHHAjZDEQ33gSqRepOUwSWJZsC77Sge4HKNxyIYcMrTkLA6tixP+E+Xs3RGquxO3ptYSWLWsc+ZqSfc0/ME0SGNt8GxBdEXtsZK34YsnAmGrxtxyApDnMJaBkauD+VjA4FRhJipm748MfvdGXu3GqIRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925358; c=relaxed/simple;
	bh=+5VIL+Lx+4gWaHoEtMRjLIDQqQ755A0ekMnhYaccrBw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Hp9WAs5jPxhPOqlTvpSoLBsQyw+L+nJNLU8C3ShsaAoQsM1S8cMhROrqEx/a1XOv/eO6QKmfdVbBpmhJ/yhKxwUYuvPD34rRUiXIFw2Go7ESWkIjKDhaoTUTuJ7lgvdMHMm64wHihkjVpG4lWohYjIWUAsJZpeYcJoK7YOpgIQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TjIdmBUU; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TjIdmBUU"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-8b3fe2f19a4so133970056d6.2
        for <linux-security-module@vger.kernel.org>; Wed, 27 May 2026 16:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779925356; x=1780530156; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HU5mpIp08+v7UC4VxJJIUTVB47HlzTm6rBp+W/xs8cI=;
        b=TjIdmBUUR/kAmZij2ZUYDg+zXYadCf+EXj8LEjiiCFnAXXNgk1x0rFvrtVNZqEiQDg
         BoAgYEUB2MsFzam5uOpYwlBEJ4+GhN09t7aJKrvYWnFdasdzrWIV3wmaQ7HbwhX2Wn3h
         CITwBj2foOwxKhItnLqydT3qQIMMMI0PNpK2NQgEdbD7cz25lHB57yDV1uHwK4DYeY1M
         c6uRNb61qjne6opSn4+LhNvm3n9SeUkvHmwknMtuBcbFnDaWANh3xYg7yYknBkQlXWeF
         k2odnW6JC1gXDjY8hMK8FXmNU7XpIT/7gnPM2ZLRMhehCKd41P2hKl7UaGDK+BGjY3Oh
         hVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779925356; x=1780530156;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HU5mpIp08+v7UC4VxJJIUTVB47HlzTm6rBp+W/xs8cI=;
        b=dwPSyaxup9jabGUm5hxjcxZ+yh7J/maqgyWCxN/EcTVwE+wVdZv59T7zw4yVavCCpC
         ucY13lFCbpGUW3UbrytcHDPaB+35nHjBSV4kTI/nh+cG6PpdYDJEnHs33PUXJ4k5DdQ4
         4gq9vLsNIFJECpwkoAHaobjtfnibWnqxYMyfO8QU+KA5Rjb9ObLsuzXCOLuXlzip6sZa
         o4k8PeBZFooq7az1U0LBp5r8M18AVU2dqr1557RZTVNe6sTW+NISbm0sJeUqfMyk9c5e
         3n2ouoiWBeIoHH6AtDoWe+TS6lIeBZAWarFZ5It+MilhFWAAiKBzFk31u+dzltUJ6MqU
         5JeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+zaDz1+nOBKFSNw0AKWFNWgNRGTWseSXGqERSoONelbYJje5BPmjP7IBbkBMOC1LbKkw68SdDYh9euyz0MqIQXwEsEpWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykNbpbALYZn30kFhzstwA4m9g7ZMeoJiFz+ypBXQIzHl4ksgMy
	TdLvitDpDmGfkDYud6sih8EhUW244XMWgSGNcZmlrsu6FuTTUG+y/snOxzzihG3/1g==
X-Gm-Gg: Acq92OGfAtYOuEr7G5r5WdQ/00YJSbUkObi+oJKhlczAYIY8YdqV3UD4vbckFaC36OK
	kpr+JL1Py/04XKgfjo9jhF5DeWuk9uDh+D1IjA50/lJZ0FgpYIz6t7HHgBrBM8HTTECWfMiG6sx
	SJMQW+rHj8IvOqCz/9CmJbJ981rm7EM38m59al5J2T8vSCTyd/uLeHCkZHJoYkruO6hrrpWeauS
	rRJt11PVWk7FfJ049QeWxken+UKRt8IVtcnNpD5075WVSIVZSCmww7dpG/jzUtxAK6pRdvY2VMv
	kKWK3hjXJmUUBDpqNlo7IkqK7JRSOc64eCzPkoeQhMAxGBp/SZBQK+cED1hy5pNpak5g0gGczuj
	sY8gaB656mp+p8CcKJCcs4z/jG5Q7hPVe1c0ZW5HcNU0hgtJm8IdzT+K96MCYxh9nfJbgdx3vjv
	C+OemsyihO1GFHmH/yEKe6DSYZWX1445OwGCRwy+23I1xEEkOhHLkrbcGSxRofhcKaQl7bUbu9y
	N+j3Fk=
X-Received: by 2002:a05:6214:3bc7:b0:8cc:15e4:1208 with SMTP id 6a1803df08f44-8cc7b65aa0dmr409956706d6.32.1779925356424;
        Wed, 27 May 2026 16:42:36 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80ffca70sm181789696d6.22.2026.05.27.16.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 16:42:35 -0700 (PDT)
Date: Wed, 27 May 2026 19:42:35 -0400
Message-ID: <4aac8924f51f66daa69acd50d8b89f3a@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260527_1931/pstg-lib:20260527_1608/pstg-pwork:20260527_1931
From: Paul Moore <paul@paul-moore.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, James Morris <jmorris@namei.org>, John Johansen <john.johansen@canonical.com>, Ondrej Mosnacek <omosnace@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>, apparmor@lists.ubuntu.com, selinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/3] selinux: hooks: use __getname() to allocate path  buffer
References: <20260520-security-v1-2-831bd8e21dd0@kernel.org>
In-Reply-To: <20260520-security-v1-2-831bd8e21dd0@kernel.org>

On May 20, 2026 "Mike Rapoport (Microsoft)" <rppt@kernel.org> wrote:
> 
> selinux_genfs_get_sid() allocates memory for a path with __get_free_page()
> although there is a dedicated helper for allocation of file paths:
> __getname().
> 
> Replace __get_free_page() for allocation of a path buffer with __getname().
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  security/selinux/hooks.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/dev, thanks.

--
paul-moore.com
