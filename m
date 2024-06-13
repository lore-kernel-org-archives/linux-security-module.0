Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4936114B941
	for <linux-security-module@vger.kernel.org>; Thu, 13 Jun 2024 22:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317096; cv=none; b=qNeoHHW6YxscwSBAB+5xWoU7LQ1T/CCdbFkqevOBKq3jAV4ssohWNVJIEfieo2BnXyubl5kFDeZ+ZmjOm8JVKzGSa+E03oqeOUxwuzFMs/7UqIzpBRcxYGEFEKA19JEv88LWOYgXR4dh7rUdNWjF1IIEayuv2V6jie4ejz9eifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317096; c=relaxed/simple;
	bh=GspCeXbe53JYdKAHLrPNjz5Bk3zxp4umRvOyOhKibSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hq6U90eyeEvt8yMECYwNrRFqHep/Bl4yha/t06xYamh5zqEgQKHscXtBqOyj67KSwU7UHYafHFZnezJ5QLSCjSumIAOhQgAbnnaFmtqpQdAv+YEkI5o5vm9owAA3Y6Rky892cWlTv931y0EQ+syX4van9LqJSFkoblQ6m3qCdb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F8hu2pjx; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F8hu2pjx"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec0f3b9cdbso3108241fa.0
        for <linux-security-module@vger.kernel.org>; Thu, 13 Jun 2024 15:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718317092; x=1718921892; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ivv8xxFePEFaIPZc0G+v3++kMFBsUSKEIP1k/xbjdQI=;
        b=F8hu2pjx0zRLoSXjyqV03rAwVJHdiSjYSNKVQL+4WGHUtBPfp8aogbw/DoSrfgTk40
         g4lHlHrkD/jvUMSm/xopfaumtQU2i+fQrQquhfUW0JSh5McZPKFiX5mdl2M+0gM6OQH0
         qrX7dssbpzn8BL2QafqybrQHPa1cusaHOlN7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718317092; x=1718921892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ivv8xxFePEFaIPZc0G+v3++kMFBsUSKEIP1k/xbjdQI=;
        b=Q2tlPkKUpyXj04HiOW6VcIiFO/L6t3/Meq1+JeDXMVYjEb5DH/9OqMucFJeqzu2Ovf
         GDIUvNm365YUjTPbsbqfBxca/ELHpu1JDrD5wiV33RhFJmIdqpVhXjY6tgLlwv9o4GUt
         SASyND8PtiIhZ1RDG/NB+FjdbIVLa1pW/P2V9A/V0UJHql367foakfASojOb2EXTxvwN
         tukP+4jcPxWEONAQyOkiK9shsB6qq8m56r3PI1WPEGX2gtdEW/EM8dCjvgF3qvIeZcpN
         N1rVYKELRkMctn1u+SAzPoO1X0hBO1vc1ySUZYwNhlcM4zxttQcEExy3Le0Q34kjfnvW
         qV7g==
X-Forwarded-Encrypted: i=1; AJvYcCX9S/IDdHV0WxQ+ljLtngxmY25To/SscdbNIZGf4VdOcert/RqdTi55na4L2SRxwVWjyT5y1bbmpBww7UZTpaqMmxAr5J1/ciYHBKt9qFTqrBCd3ZWR
X-Gm-Message-State: AOJu0YzMn7OKU715veFcDSqDiOBb8/GS4eND0QgTKPMXBxCUU2jL9RsG
	c4rFfb/a1mW/hErb6wm/F5AQOs5s7myEGMwMNEnOFnE3EGA8bxBEN6dbbXor2YDEbljWXz6GnVR
	6nldp9Q==
X-Google-Smtp-Source: AGHT+IGFo78UGKGPxggA/dkw/zF7vcupWPkPuzKyFLQM7IaJe8rWpdn0QSHiJrghIyOa+iySzGGtMQ==
X-Received: by 2002:a2e:7212:0:b0:2ea:7e50:6c94 with SMTP id 38308e7fff4ca-2ec0e5c657emr6922421fa.16.1718317091924;
        Thu, 13 Jun 2024 15:18:11 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c9ada6sm3695891fa.140.2024.06.13.15.18.10
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 15:18:11 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec10324791so3239481fa.1
        for <linux-security-module@vger.kernel.org>; Thu, 13 Jun 2024 15:18:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKerptWs+aM3bm4T7Gm8dZpKeoyPVmYPRdska4pLVtlmhRu6ud9uaAKPEboA1aIA3hYaZXmmrEo7xF9D3Ia9xcGGfD7mYippvmNj6igAh48NKGDj0w
X-Received: by 2002:a2e:92d6:0:b0:2eb:242b:652a with SMTP id
 38308e7fff4ca-2ec0e5c6ce9mr6646061fa.15.1718317090589; Thu, 13 Jun 2024
 15:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613023044.45873-1-laoar.shao@gmail.com> <20240613023044.45873-6-laoar.shao@gmail.com>
 <20240613141435.fad09579c934dbb79a3086cc@linux-foundation.org>
In-Reply-To: <20240613141435.fad09579c934dbb79a3086cc@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jun 2024 15:17:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqrwFXK-CO8-V4fwUh5ymnUZ=wJnFyufV1dM9rC1t3Lg@mail.gmail.com>
Message-ID: <CAHk-=wgqrwFXK-CO8-V4fwUh5ymnUZ=wJnFyufV1dM9rC1t3Lg@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] mm/util: Fix possible race condition in kstrdup()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 14:14, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> The concept sounds a little strange.  If some code takes a copy of a
> string while some other code is altering it, yes, the result will be a
> mess.  This is why get_task_comm() exists, and why it uses locking.

The thing is, get_task_comm() is terminally broken.

Nobody sane uses it, and sometimes it's literally _because_ it uses locking.

Let's look at the numbers:

 - 39 uses of get_task_comm()

 - 2 uses of __get_task_comm() because the locking doesn't work

 - 447 uses of raw "current->comm"

 - 112 uses of raw 'ta*sk->comm' (and possibly

IOW, we need to just accept the fact that nobody actually wants to use
"get_task_comm()". It's a broken interface. It's inconvenient, and the
locking makes it worse.

Now, I'm not convinced that kstrdup() is what anybody should use
should, but of the 600 "raw" uses of ->comm, four of them do seem to
be kstrdup.

Not great, I think they could be removed, but they are examples of
people doing this. And I think it *would* be good to have the
guarantee that yes, the kstrdup() result is always a proper string,
even if it's used for unstable sources. Who knows what other unstable
sources exist?

I do suspect that most of the raw uses of 'xyz->comm' is for
printouts. And I think we would be better with a '%pTSK' vsnprintf()
format thing for that.

Sadly, I don't think coccinelle can do the kinds of transforms that
involve printf format strings.

And no, a printk() string still couldn't use the locking version.

               Linus
