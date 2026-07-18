Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D7031282C
	for <linux-security-module@vger.kernel.org>; Sat, 18 Jul 2026 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784408344; cv=none; b=ZD/fD5hKt8QWZkw0tlRokZpfYUTrgyX81e1KOg+nvLVVIYEROJzPOr4KLRy/kfd1MPDqfs7mlPGAEdYi1ZcZK2reeF7AC0g1AClheTP2SZ9CV6vUElnkt6xs4IYuLLkHYxRpweqJnMRybd+2cU7ngmGhGotq5g9o98gSrTh1MMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784408344; c=relaxed/simple;
	bh=HqzEZ3bgMLTPXgL/wWvLOLcOK5yTeU+drGBScgleG9A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chI7etDNdtgGKYUI7tCJB5vFj9HvqqxTk6mNzepSZ40bGwbgZjGcIfiw9LdH7y0hQ8rU1PM2F0MC2CpqhTSUusOQPcV1mqMHRCnp5/lg64cEO0CiBY8xhMO7g1MRQNwH5SHmno19dhAaINxz0c6hfw9DFZawIz/2GhZHpEWU3s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdhFsyBI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdhFsyBI"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so69194545e9.0
        for <linux-security-module@vger.kernel.org>; Sat, 18 Jul 2026 13:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784408341; x=1785013141; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OfSTmHlc+4PzusgvhlO9OeocHbbw6TEXsXghlFKBcqU=;
        b=bdhFsyBIPJCSoHN+mvWMmpEFX1DLiJ9Ygx/AihNIWeGbKSwSndGhN0GrL6lwxiUOZv
         y3mnSDNIGRqwOusGt/18pkEZDHhcs26VGjGAAVtgZY6KJh7pH2oiRomuMsPCBMIvhdcl
         asb5+4rVqVunaDfhuPo/3Ckdc+LyMVqPvN/iKbIMPvtUcAGBO+WxGVYdAp30LdvFYKVs
         6V603JXIhHxQcC1FGxS9m8t5XT4qzQPjg4OmCJax8c/b0aXqqJMYnXO1eBnXM7uCWEWJ
         iVBdfw/Q1O/BvfJ4YWJKe9Fv5PCI6CLk2GPLApOy8p+oTunVi65pVoxAQspuEQC7la6Z
         5aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784408341; x=1785013141;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OfSTmHlc+4PzusgvhlO9OeocHbbw6TEXsXghlFKBcqU=;
        b=Y1lWpYOuALKwv62sDUemu6tIbrX91qm6yHC4uiVbKI32eoGhZQYhEo154ruPzx4yZj
         umh6imSx7PU7qOxyKCHB3tWEA3NOGfrJZee2VHem52nGZlbJPVF+z7WLL1FlWjDqzsMG
         jbtcBIWcCtEVY8QqZZAzWGwzuS6+R8xsU999pe0rW4+VKav9veYAE6+Ud7vqwlHo2occ
         iWVZg/u5p1oDwff403AvSzkTufgPr6UfZMhvADgvXBBlQ9KWnhj/1T0iRt/Fl9V4Kc2E
         bBH5QMABjcQtu/gMuo48X7OMFL2qa+Cn/b5lbO0YACdkJ0xG0Jgimn0Ehla2ORr4GTV1
         a/hw==
X-Forwarded-Encrypted: i=1; AHgh+Rp+F61Wzfw6Ny/5aogoeD+oOObiZGJ7cLXi697oQmgzjBhvtiHGJHhVcDDe/S561NgLGwBk67TGACHyWKelrh+m4yuAOFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8YTeM/BisR62KoQlthSUPz2MewJ2m9AOXR8hMyW9RA5oh3pi
	kzcpK3IQFMVK9V5EwSaiOSjBZOPRQn+qV8ibu5QV4QWuZFCYAb+NvwpR
X-Gm-Gg: AfdE7clpndr1JUzgVAyxQoDAS+r3qkVPDB1nvDOIFQa1+V+kc3IqyaHrKz2bs0kQlr3
	ac8yrRAFSeh5LT69eP7elMgAKW56qWGLfJYqzzWeP8zRVW3OG4uwA9J0KVluz0sbb3dZCn5Yw55
	c8OyMtcduiOmX9UQ/NKA8HbAeQn/V1EqikJVb6bBACSu19u1xTewLNA4F7DrGkh9MCmxXc2EbvR
	TF+CifTXlnaxzZ74FM3eI/wwSyootyRFak/WYVB5LD1lHyko0DcnWySvSrQo8DT+3wOYlYToQvJ
	zYDRMo5BCmRJxcYWv9CJQjbc1ftHkRP4RfucZtuH0rAGz+3gqLIgviVIk93ivcK9hhB+ZWsn3Bj
	ebP/EUE6VK7zRKrRe5/F6TKSW1XUTqb2CBtFe521+pxwDjo400AJ5X74HklHrW8eKKIphAJ25vv
	h7+pZNvqVxi3gwQsAhOjAyjKiNW8WCLBNFy6uB8jI=
X-Received: by 2002:a05:600c:b99:b0:495:4cba:e288 with SMTP id 5b1f17b1804b1-4954cbae4cdmr69628505e9.15.1784408340738;
        Sat, 18 Jul 2026 13:59:00 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ed2313sm14322945f8f.23.2026.07.18.13.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 13:58:59 -0700 (PDT)
Date: Sat, 18 Jul 2026 21:58:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "John Ericson" <mail@johnericson.me>
Cc: "Kuniyuki Iwashima" <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Cong Wang"
 <cwang@multikernel.io>, "Simon Horman" <horms@kernel.org>, "Christian
 Brauner" <brauner@kernel.org>, "David Rheinsberg" <david@readahead.eu>,
 "Andy Lutomirski" <luto@kernel.org>, "Sergei Zimmerman"
 <sergei@zimmerman.foo>, "network dev" <netdev@vger.kernel.org>,
 =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, =?UTF-8?B?R8O8?=
 =?UTF-8?B?bnRoZXI=?= Noack <gnoack@google.com>, "Paul Moore"
 <paul@paul-moore.com>, linux-security-module@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: unix_stream_connect and socket address resolution
Message-ID: <20260718215855.07284fb1@pumpkin>
In-Reply-To: <e6f54c5b-2c92-4772-b2f9-5c21e2ec50a9@app.fastmail.com>
References: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
	<20260703073948.2541875-3-John.Ericson@Obsidian.Systems>
	<e6f54c5b-2c92-4772-b2f9-5c21e2ec50a9@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Jul 2026 15:55:12 -0400
"John Ericson" <mail@johnericson.me> wrote:

> In [1] I observed what I considered some odd behavior in unix_stream_connect():
> 
> > I was hoping this was going to be a simple matter of factoring out the
> > back half of `unix_stream_connect`. No such luck was had, because
> > actually instead of `unix_stream_connect` looking up the socket from the
> > VFS once, it does it repeatedly in the same loop that is used to deal
> > with full listening queues.
> > 
> > (This behavior is rather surprising to me, because it would allow a
> > deleted and recreated socket to be picked up on the next loop iteration.
> > But, I don't want to make any UAPI-visible changes in this patch series,
> > so I did not consider changing it.)  
> 
> I had said I didn't want to consider changing this yet in my patch
> series, but based on the feedback I received for a second version of
> that patch series, I now actually think it is a good idea after all to
> discuss this first, and see if it should be changed prior to my patch
> series. (This discussion will inform what the code looks like before I
> do my v2 patch series, and how big or small that patch series is.)
> 
> Here are two scenarios where the current behavior of
> `unix_stream_connect` is surprising:
> 
> File system version:
> 
> 1. server binds socket `/foo/bar`
> 
> 2. clients fill up the accept queue, begin looping
> 
> 3. `mv /foo /foo2; mkdir /foo`
> 
> 4. another server binds `/foo/bar`
> 
> 5. clients connect to the second server instead
> 
> The loop in question is within `unix_stream_connect` itself, not in
> user code. I consider it very surprising that `/foo/bar` is looked up
> multiple times during a single system call.
> 
> Abstract socket version:
> 
> 1. server binds abstract socket `@foo`
> 
> 2. clients fill up the accept queue, begin looping
> 
> 3. server closes its socket (or exits), releasing the abstract name
> 
> 4. another server binds `@foo`
> 
> 5. clients connect to the second server instead
> 
> For abstract sockets we cannot play tricks with `mv`: the first server
> does need to relinquish `@foo` itself. But still, the result is the same
> where a different socket is resolved on the next loop iteration in
> `unix_stream_connect`. I am not sure it is fair to call this a TOCTOU
> issue exactly, but it feels very similar to one.
> 
> The more natural semantics in my view would be to first resolve the
> address to a socket, and then loop holding that resolved socket
> constant. With these semantics:
> 
> - In the `mv` case, the retrying clients continue to try connecting to
>   the original socket, now at `/foo2/bar`.
> 
> - In the close case, the retrying clients fail, and do not connect to
>   any new socket at the same path or abstract name.
> 
> What do you all think? Is this better? If so, is this a security fix
> which can be made unconditionally, or, absent a real concrete attack
> vector, is this a UAPI-breaking change which is automatically out of
> scope, and would thus need an explicit opt-in mechanism?
> 
> Looking forward to feedback,

My $0.02

If you assume that the client isn't responsible for restarting the server,
then there is no strong timing relation between creating a new server
(by any means) and the connect request from the client.
In other words both the above are very similar to the client being
preempted at the start of the connect() system call.

What you need to do is hard link foo to foo1, create the new
socket at foo2/bar then mv foo2 to foo so that it is atomic.
But I suspect hard links to directories aren't allowed any more :-(
(Creating 'random' hard links to directories used to be 'fun',
you could get 'find' in a right mess.)

	David


> 
> John
> 
> [1]: https://lore.kernel.org/all/20260703073948.2541875-3-John.Ericson@Obsidian.Systems/
> 

