Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bm9iP9vn"
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E35171D
	for <linux-security-module@vger.kernel.org>; Fri,  8 Dec 2023 14:43:42 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-db549f869a3so2940883276.1
        for <linux-security-module@vger.kernel.org>; Fri, 08 Dec 2023 14:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702075421; x=1702680221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YtvPSFjodu+ZgraE7QhIaNyDdff0Uneik8gDZ6S5Lo=;
        b=bm9iP9vnIfZm1eOEoqYXZl63iLPc2k72WSKL9MJwsjpZ1os51/QbXbMJ9cadWxz6Am
         CckXn5glIT76wVA3ifXSky61kMGMk4Ex31pBnwtCy5BQd+VFi9xAtQGAfBtekIQTuHyz
         4LjyzcIirIf0FT2kbD9P7IIchieiptLuiYrXtenofP8hSvCrYI0jFhi9mDkWC6JHn/lE
         XKP6iVoDAkeRU5MBxityrE3op7pv/Xjz1m8Pm3CnGD2ThGMHZzyKTpDSdwJAF/J9ubco
         SuX+fZFm7hnlCZ98mOXoVC2b0LU8YCCD71qjPzYGlnA8d27KbNSxoHhSvMH+m6QO4QQK
         H4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702075421; x=1702680221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YtvPSFjodu+ZgraE7QhIaNyDdff0Uneik8gDZ6S5Lo=;
        b=SyBOyf3ZCujLxQxIdV+zhbi8SB29Qut+BP//drAY9jOpNkGWFbiv4ME2n7sc+5xPPK
         f5n/VeJKeArMqhMFfn8QU28ctYEKxbMk3g0UGJ/kT2PauK2vouy6/NRcE6d7QBo2omh4
         JgHyjpGrSNzGqXHRTHFaineWErN9UaDTk285t6Sy7a8ODp5qRAVUgYLW6ZG2kf/XT17/
         S2QhbDmnHChUpME8edJXzzcGbZOIXBlfAZIiHZuBTRJArB2R5Xyvlnilp3u8EGnFq/tR
         Is6J3Rk8JvpGGifhLvxb6iY1ltYPGIm1lmEC3m3owvbw5hK12PndJAM6XT2T44wasgi+
         KNfg==
X-Gm-Message-State: AOJu0YyGs9Uru0dAIraG2X064fIVkGHEdzW92Yb6/udfotBBZj9k1O4S
	7/tc16XZrTS2ZSABpkHd6Lcte8S5OIQ60iy7+JHT
X-Google-Smtp-Source: AGHT+IF9tjmLAyUmVUsZYC10muP3I76/RHeidBltFtIH7wYUsGHZIib9uJNx8Z3A7Unf+g5whxu1AgvucF0VPR71ABA=
X-Received: by 2002:a05:6902:150:b0:db7:dacf:ed8b with SMTP id
 p16-20020a056902015000b00db7dacfed8bmr673305ybh.108.1702075421706; Fri, 08
 Dec 2023 14:43:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhSyaFE7-u470TrnHP7o2hT8600zC+Od=M0KkrP46j7-Qw@mail.gmail.com>
 <20231208021433.1662438-1-kamatam@amazon.com>
In-Reply-To: <20231208021433.1662438-1-kamatam@amazon.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 Dec 2023 17:43:30 -0500
Message-ID: <CAHC9VhRRdaUWYP3S91D6MrD8xBMR+zYB3SpGKV+60YkmLwr7Sg@mail.gmail.com>
Subject: Re: Fw: [PATCH] proc: Update inode upon changing task security attribute
To: Munehisa Kamata <kamatam@amazon.com>
Cc: adobriyan@gmail.com, akpm@linux-foundation.org, casey@schaufler-ca.com, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 9:14=E2=80=AFPM Munehisa Kamata <kamatam@amazon.com>=
 wrote:
> On Tue, 2023-12-05 14:21:51 -0800, Paul Moore wrote:

...

> > I think my thoughts are neatly summarized by Andrew's "yuk!" comment
> > at the top.  However, before we go too much further on this, can we
> > get clarification that Casey was able to reproduce this on a stock
> > upstream kernel?  Last I read in the other thread Casey wasn't seeing
> > this problem on Linux v6.5.
> >
> > However, for the moment I'm going to assume this is a real problem, is
> > there some reason why the existing pid_revalidate() code is not being
> > called in the bind mount case?  From what I can see in the original
> > problem report, the path walk seems to work okay when the file is
> > accessed directly from /proc, but fails when done on the bind mount.
> > Is there some problem with revalidating dentrys on bind mounts?
>
> Hi Paul,
>
> https://lkml.kernel.org/linux-fsdevel/20090608201745.GO8633@ZenIV.linux.o=
rg.uk/
>
> After reading this thread, I have doubt about solving this in VFS.
> Honestly, however, I'm not sure if it's entirely relevant today.

Have you tried simply mounting proc a second time instead of using a bind m=
ount?

 % mount -t proc non /new/location/for/proc

I ask because from your description it appears that proc does the
right thing with respect to revalidation, it only becomes an issue
when accessing proc through a bind mount.  Or did I misunderstand the
problem?

--
paul-moore.com
