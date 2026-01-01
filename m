Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B93E3A1C9
	for <linux-security-module@vger.kernel.org>; Thu,  1 Jan 2026 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767268626; cv=none; b=L05KkmMhnNGxd+a4iy3BjdvQYV5F5Q3cDowrAhdHut4JfP9uTI3GFJqvdcwtr2eE3zAzSdQ+lSpZvOhb1GlKMfoBardVtDEu6NEdx38hKrzbi1us8D4aPvmv/DWI7yYcGIAtB3kREANoJEArxCeqYHJ6fsa5CkfX/GDx531ieJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767268626; c=relaxed/simple;
	bh=G2rhddGZVpfc7fSGFukzZzPWbmqRXvvAHelXhXgjCiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYXa6L2BIhuxO/MnKQsUYl/Dgp2unXozwBvBDf4MW0MJ0/OmUb2XvYXeHOqUm40CJ/IJYhNFi0GaGno516gK1BEjOdJmbLSqPcqNLF2F6zGTNUvAxFvOWANmymoyDMevrfp9D0QKq3uAbyv1GrLyCvS3x6JgmqquWgC0iLkD5w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJkiDGaq; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJkiDGaq"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64b608ffca7so13992754a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 01 Jan 2026 03:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767268623; x=1767873423; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tOCh1AYIsSHgQf1TBlgltjmRG6ChQgBGDoVHtYBbniM=;
        b=RJkiDGaqZqEQ4aldtxBpxjN7In9yhlUjPnR+s6fQYLg7IJqIjqgcsLqdMastkeZ73k
         Jm9MalZo9qffCf22SHY/ZKijCgJ+GF2ghBqA29TeWClpUEFo4OxrG42k1uiGturQ1Jza
         o5QtakV+AGRTmLPl57j0HQXU6zEhGGAt0uHOpjh8RtULMLGU4MCWW7RqPWW4pdIts7Rm
         8mpqhw4wqTRKUIVRtc4P6oojzPhuLTi8VKq3nlgBgJ59mqTjXRtJgnhxm5Vj6G0wwXvi
         FCRu+DkTi7eyHyzFvbVsT3cyWTmOJg0bhUjfkH0VzahI0u929hkqtZSSusIQ7F30wzG/
         pE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767268623; x=1767873423;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOCh1AYIsSHgQf1TBlgltjmRG6ChQgBGDoVHtYBbniM=;
        b=QYlOmzuJSCkNEHc2+wwtuL4nZhU7ct/YeVBYjvWLbkXpQdZo3IDlH9FywYY1Z5jDvc
         AD8mZ3i+4p3tWyrUD+8oIvmelNtDkiNUkXvdCoT9EEB43/Hq2LW5y3Kzp2mr9YcWJxzk
         DafoKOro7Ia/h4Qh9JBKWHtKI+hBU82cB8Jg1iRVi32fld2OPPOZY7yNRbqmfL2YliFg
         sm9/rDGg8GOI3YtSa9AlKF6HawpVxWXIgchIRa8QjP5uUNP2JXo7fLTplqAJOglIOIdO
         BmbYXIgu7FvVGdxTFA6X/jcDqFOo4Ypt8ZmxHDOCx/7BLdy9YsJZt9mcyj79gtpK/P7p
         cXqA==
X-Forwarded-Encrypted: i=1; AJvYcCUvZ7npPxDInFjFWf0TLOPREyVrYgQTbZoNaUEvGt3P94G5OEaAQiX5pF98kodDZz2xPpoLPzZM0/2RTimK6/cm18NnRIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzut/52uNcZ+IqpD2ViBJjokbEOVmK1rzIxxeBu/4OQL2CXVPFt
	8X4L9PBeXhuIfYb8vzDZp0tVpkvovJTu+rNEKxWco9yCQtWkv9uvvOXY
X-Gm-Gg: AY/fxX4x3bICiVpFu8MS+mVe9lnOaX2Xw/qBU7lrrjp5W49NpwnSWkLLVaY/iduspfj
	syHjm5iJ8/2GTRUWQ8Rd0ZHt2OOCl3gu7ZYv9pyup4qZqf9kuOtbN9wOLtBLoyoxXMyn3212Ix5
	jYe7NpaL5AIXjyNdg7EepI/Xrj8L8x0CGqb+LkCd7zRMBEveQ4n5CzrRnj203y3I0hsJ8KFFS0K
	XQKkxGbA/jm1yiej3J0KZ2Lin/MykPdQUTHu8/XwubZhLQ8vmV18AncXfyVRzvvkmAX69AEE71u
	p8Py0m2J18HPwjaaKAniiccPyZuDOOIXEzLJvNSBkk+OIb7UcvGjTN7T/74DtA8ZiJibfXLFZsi
	fzLdzmes+lr7vKLzkCm3xR87+PVu7k7HvjsDDHh3yWS9KWkVKybCvl982t3QtvIFRRZySdxm015
	tX7ABM3sSBhNH3fxI/FOY/X0VGH4el4o2VvyLF
X-Google-Smtp-Source: AGHT+IHQ+roj6G+fwaY9C50POuuTNn9OM4QtTiSv3F0ezk9cK0kujONP1nzZ4oyO4PBGT3ASgLWw1w==
X-Received: by 2002:a05:6402:1d4b:b0:64b:7dd2:6b9d with SMTP id 4fb4d7f45d1cf-64b8eb738abmr35662187a12.8.1767268622634;
        Thu, 01 Jan 2026 03:57:02 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9105b31esm39838789a12.13.2026.01.01.03.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 03:57:02 -0800 (PST)
Date: Thu, 1 Jan 2026 12:56:50 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>,
	Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
Message-ID: <20260101.c5abb78cd634@gnoack.org>
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251231213314.2979118-1-utilityemal77@gmail.com>

Thank you for sending this, Justin!

Paul: Could you please have a look at this new LSM hook? -- it extends
the LSM interface and it is an approach that I have suggested in [1].

On Wed, Dec 31, 2025 at 04:33:13PM -0500, Justin Suess wrote:
> Hi,
> 
> This patch introduces a new LSM hook unix_path_connect.
> 
> The idea for this patch and the hook came from Günther Noack, who
> is cc'd. Much credit to him for the idea and discussion.
> 
> This patch is based on the lsm next branch.
> 
> Motivation
> ---
> 
> For AF_UNIX sockets bound to a filesystem path (aka named sockets), one
> identifying object from a policy perspective is the path passed to
> connect(2). However, this operation currently restricts LSMs that rely
> on VFS-based mediation, because the pathname resolved during connect()
> is not preserved in a form visible to existing hooks before connection
> establishment. As a result, LSMs such as Landlock cannot currently
> restrict connections to named UNIX domain sockets by their VFS path.
> 
> This gap has been discussed previously (e.g. in the context of Landlock's
> path-based access controls). [1] [2]

+1

The use case here is that Landlock should be able to restrict
connect() to named Unix sockets and control this based on the natural
identifier for named Unix sockets -- the path of the socket file.

This feature is a useful and necessary addition to Landlock.  The
discussion that Tingmao Wang linked to on her patch also shows that
users are caught by surprise when they find that connecting to UNIX
sockets is not restrictable [2].  Her patch set [3] lists some ways in
which this can be a problem.


I understand that adding LSM hooks might be controversial, but I think
that the alternatives to the new LSM hook are both worse:

* The patch set from Tingmao Wang at [3] is not restricting Unix
  sockets based on path, but on Landlock policy scope (domain).  This
  is useful, but only complementary to a path-based restriction.  If
  be build both features at some point, they'd potentially have
  surprising interactions that make the UAPI more confusing.  (I've
  written more about this at [4])

* We can not use the existing security_socket_connect() hook for this,
  because the resolved struct path has already been discarded by the
  time when security_socket_connect() is called, and looking up the
  struct path again would create a TOCTOU race condition.
    
  The hook is called from the function unix_find_bsd() in the AF_UNIX
  implementation, which looks up the struct path and keeps it
  transiently in order to find the associated listening-side struct
  sock.


Please let us know what you think!

Thanks!
–Günther


[1] https://github.com/landlock-lsm/linux/issues/36#issuecomment-3669080619
[2] https://spectrum-os.org/lists/archives/spectrum-devel/00256266-26db-40cf-8f5b-f7c7064084c2@gmail.com/
[3] https://lore.kernel.org/all/cover.1767115163.git.m@maowtm.org/
[4] https://lore.kernel.org/all/20251230.bcae69888454@gnoack.org/

