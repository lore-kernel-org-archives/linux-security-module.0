Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ACE1C7012
	for <linux-security-module@vger.kernel.org>; Sun,  8 Feb 2026 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770558297; cv=none; b=O+3vA+8HTQ2muYVZat3E1nLfldbXqNzwwdIDCSwYFT91wN5Fbp3WVST03XYeZT5O5/kT+doerUXGZsgyqQ82fuRBlRLQx1NRJiTYa2R/SmVz+MFeUeDR/h+f1Jv+Pahzh65fnUfkG5JMR7LooZC377VfEWc8ovG7Lu5p7AA1sG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770558297; c=relaxed/simple;
	bh=IjYyjbdC5oc2YWqr+UMV0Co2s9P3209QoCVFCZTAgVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKWXReHiKBOyormFMANnSDTfABw1HtN4HWD8P6BP5EjVEIeRo86sZgZf/xsoZ4rydpFwFrnzz3Y/TOqvPWc/albOS5SPfKxXn3jYVnAgDN/Hy6oThRAFdlohdirQ4zE54gzZbYZIHI4ykZDVFHAVsGP6y3Nnpew8qeORsHTJfy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyjkWJVH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyjkWJVH"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47ee0291921so19706745e9.3
        for <linux-security-module@vger.kernel.org>; Sun, 08 Feb 2026 05:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770558295; x=1771163095; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C3rr8jUVDn6I/0BXDONbxse7L42NBhRiUQk55vOcqXU=;
        b=DyjkWJVH5L3af8JHv8bZnqVhU0/poZ/3a2qji2GqkTPrYU6ktpCsV99vQ181LJgUEv
         fJZK0TG2acfrVDcQwMf6UAmKM3LVlAk/Cno+od/m+l6tCiLOddrO00T5pTxafVDnaGeU
         TtyB+N8KBqbYBo6F4EXzeobOTS6eNeNxzVdUulpKm179yWlqZB5djF6OF1lSaVb1yQEk
         k9oelUqRfEBXNWUOepnLPYAQrjH6K5WV1PUyr+MR/GyVWzbsDQqlOS5mrdgVYUBNTRkN
         8PWGsefXLVP5wyDUgMuhNFge6DsCZwlbbcXr6nupfKo1M/B8CuydOnnQSeUwv8i1k/Ck
         qPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770558295; x=1771163095;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3rr8jUVDn6I/0BXDONbxse7L42NBhRiUQk55vOcqXU=;
        b=XbKhrL9wU7AEm/JZ5EaTy8a8XWB+T/qJ/8riqobVe4jPelBJczIuphAUk5SzzWk1wg
         +VJdRMQXhE3jnkbiCYroKp9mK82K6hu8FIvw6vh69D22Pknk8Y6fMt6idFRDaX9SocQa
         Im0VumkPjNhVSE7Cvm5zCurbkwnPNgnf/h67FQt8M2wGm9NZ556I5pUDCrw0fY4AsHlK
         kb5AeLVOWIgzEKuFL78wvS8rvM45xv3FEG5rNj+CbHPbkrXoSbzuFxqcTdjZDM25gZAl
         P4tdM6jxoORFIA2II08SviwnSFO8W4jLqKtTqhaXYKUOZNsUrWu5bjHVdipU1dKS9s6n
         BsZw==
X-Forwarded-Encrypted: i=1; AJvYcCUKt2TmzYeByGCFtGrTtIvmRU3lApdqHi5CBKNPA2wP9ZrUSJUPBg6VvMefBEbuNbr0nEQdmNwPiTkVocipJePrhoJaKt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIg11lUJp+3TSwVhiQtuVN9Jz3MRe8yT5x6h29OcQkFMtHq933
	OinaOvLwA79HLNEhy0EoB2akq0ZWgAebhDZuzLhRvAmeIRtQX+5GJZNq
X-Gm-Gg: AZuq6aLwXxwlT3oLv1oXctaQ+yfH2Xf+FPP841j0o2S5/6OFLMVTTjAaX5O0QqGlvCx
	NBCoohf9jDZA7qpLYEHJHg3HUwG/JsQpS8dggg65lFYjKVZcV6rTM4rtrFEfpzXb7EaOTJ6XzAc
	LiH6a11p5pDvoYmZbI/gUEIblCyNJr535I1gLMUDCTEq9Vs/07DVFif+eBvxT2gV+9IyIXwUaOZ
	utVFdTNqiish4EvKwOEjVf8mb/IUVjwNEz917IWSgEgq2VTmm6W+0QlofJVK2Jhj9auPGgSShpR
	a+jwDCzWegN4Ygl94Xy9xUGzMyqiOxfBJfYUcAANmSn8by1pi9pxsFX79UvGxMhOckS4iwXOhAx
	Wc5OFB8EtI/0rKnmPfO7sep2drO3VZScfJbKi8UdWGj6eeC0rSwlu3uS5MIyPSITyL6ufORZlXx
	JACzLzH+1vzdg/f9RzvLbKkYCXL9S+fVaEBxjh
X-Received: by 2002:a05:600c:628d:b0:480:6bef:63a0 with SMTP id 5b1f17b1804b1-483202139f7mr131404405e9.21.1770558294748;
        Sun, 08 Feb 2026 05:44:54 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4832096c438sm113249725e9.3.2026.02.08.05.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 05:44:54 -0800 (PST)
Date: Sun, 8 Feb 2026 14:44:38 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Tingmao Wang <m@maowtm.org>, g@galopp
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Justin Suess <utilityemal77@gmail.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-security-module@vger.kernel.org,
	Matthieu Buffet <matthieu@buffet.re>
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
Message-ID: <20260208.79607c8a5661@gnoack.org>
References: <8093547c-ab40-4814-ac9a-8dff6f2a2a90@gmail.com>
 <16129d76-b6d3-4959-b241-dc79a32dd0cd@maowtm.org>
 <aYI2OQhPMgdMAOiz@google.com>
 <e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org>
 <aYMxHRwHCao30HfX@google.com>
 <bfcac905-5901-4cfb-8489-fb228cef0ee0@gmail.com>
 <20260204.vug7Osheiwou@digikod.net>
 <44d216aa-9680-4cf5-bbf0-173869111212@gmail.com>
 <20260205.phohK6hajaih@digikod.net>
 <3f9d456f-8343-4b46-8770-38190f838dbe@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f9d456f-8343-4b46-8770-38190f838dbe@maowtm.org>

On Sun, Feb 08, 2026 at 02:57:16AM +0000, Tingmao Wang wrote:
> On 2/5/26 19:15, Mickaël Salaün wrote:
> > On Thu, Feb 05, 2026 at 10:18:54AM -0500, Justin Suess wrote:
> >> On 2/4/26 13:28, Mickaël Salaün wrote:
> >>>> Tingmao:
> >>>>
> >>>> For connecting a pathname unix socket, the order of the hooks landlock sees is something like:
> >>>>
> >>>> 1.  security_unix_find. (to look up the paths)
> >>>>
> >>>> 2. security_unix_may_send, security_unix_stream_connect (after the path is looked up)
> 
> btw, ideally for pathname sockets we can leave all the checking in the
> security_unix_find() hook (as newly proposed, with the struct sock *other
> param), and not have to e.g. call domain_is_scoped() again in
> security_unix_may_send and security_unix_stream_connect, right?
>
> (Although if this changes error codes, we might have to "delay" the denial
> until the may_send/connect hooks...?  Hopefully not but not checked.)

Yes, absolutely.  I have had a stab at it and will send it soon.

Justin adopted your suggestion from [1] and created an updated LSM
hook patch based on it.  With that, I am doing both checks in the
security_unix_find() hook, based on the resulting struct sock.

[1] https://lore.kernel.org/all/e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org/#t

–Günther
